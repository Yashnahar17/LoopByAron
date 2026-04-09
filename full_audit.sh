#!/usr/bin/env bash
# =============================================================================
# EXTREME FULL-SCOPE AUDIT SCRIPT
# Roles: Senior Staff Engineer | UI/UX Architect | Security Engineer |
#        Performance Engineer | SEO Specialist | CRO Expert
# =============================================================================

set -euo pipefail

# ── Colors ────────────────────────────────────────────────────────────────────
RED='\033[0;31m'; YELLOW='\033[1;33m'; GREEN='\033[0;32m'
CYAN='\033[0;36m'; BOLD='\033[1m'; RESET='\033[0m'

# ── Helpers ───────────────────────────────────────────────────────────────────
log()     { echo -e "${CYAN}[INFO]${RESET}  $*"; }
warn()    { echo -e "${YELLOW}[WARN]${RESET}  $*"; }
error()   { echo -e "${RED}[ERROR]${RESET} $*"; }
success() { echo -e "${GREEN}[OK]${RESET}    $*"; }
header()  { echo -e "\n${BOLD}${CYAN}══════════════════════════════════════════${RESET}"; \
            echo -e "${BOLD}${CYAN}  $*${RESET}"; \
            echo -e "${BOLD}${CYAN}══════════════════════════════════════════${RESET}"; }

# ── Usage ─────────────────────────────────────────────────────────────────────
usage() {
  cat <<EOF
${BOLD}Usage:${RESET}
  $0 [OPTIONS] <project-dir>

${BOLD}Options:${RESET}
  -u, --url <URL>        Live URL to audit (optional)
  -o, --output <dir>     Report output directory  (default: ./audit-report)
  -s, --skip <sections>  Comma-separated sections to skip
                         (ui,responsive,perf,seo,security,a11y,ecommerce,code)
  -f, --fix              Auto-apply safe fixes where possible
  -h, --help             Show this help

${BOLD}Example:${RESET}
  $0 --url https://example.com --fix ./my-project
EOF
  exit 0
}

# ── Argument Parsing ──────────────────────────────────────────────────────────
PROJECT_DIR="."
LIVE_URL=""
REPORT_DIR="./audit-report"
SKIP_SECTIONS=""
AUTO_FIX=false

while [[ $# -gt 0 ]]; do
  case $1 in
    -u|--url)      LIVE_URL="$2";      shift 2 ;;
    -o|--output)   REPORT_DIR="$2";    shift 2 ;;
    -s|--skip)     SKIP_SECTIONS="$2"; shift 2 ;;
    -f|--fix)      AUTO_FIX=true;      shift   ;;
    -h|--help)     usage ;;
    -*)            error "Unknown option: $1"; usage ;;
    *)             PROJECT_DIR="$1";   shift   ;;
  esac
done

should_run() { [[ ! ",${SKIP_SECTIONS}," =~ ",${1}," ]]; }

# ── Setup ─────────────────────────────────────────────────────────────────────
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
REPORT_DIR="${REPORT_DIR}/${TIMESTAMP}"
mkdir -p "${REPORT_DIR}"/{ui,responsive,perf,seo,security,a11y,ecommerce,code,fixes}

SUMMARY_FILE="${REPORT_DIR}/AUDIT_SUMMARY.md"
ISSUES_COUNT=0

record_issue() {
  local section="$1" severity="$2" message="$3"
  echo "| ${section} | ${severity} | ${message} |" >> "${REPORT_DIR}/issues.md"
  (( ISSUES_COUNT++ )) || true
}

# ── Tool Check ────────────────────────────────────────────────────────────────
check_tools() {
  header "Checking Required Tools"
  local tools=(node npm npx curl jq git grep sed awk find)
  local optional=(lighthouse axe-cli eslint stylelint htmlhint)
  local missing=()

  for t in "${tools[@]}"; do
    if command -v "$t" &>/dev/null; then
      success "$t found"
    else
      warn "$t NOT found – some checks may be skipped"
      missing+=("$t")
    fi
  done

  for t in "${optional[@]}"; do
    if command -v "$t" &>/dev/null; then
      success "$t (optional) found"
    else
      log "$t (optional) not found – install for deeper analysis"
    fi
  done

  if [[ ${#missing[@]} -gt 0 ]]; then
    warn "Missing tools: ${missing[*]}"
  fi
}

# =============================================================================
# A. UI / UX AUDIT
# =============================================================================
audit_ui_ux() {
  should_run "ui" || { log "Skipping UI/UX audit"; return; }
  header "A. UI / UX AUDIT"
  local report="${REPORT_DIR}/ui/report.md"
  echo "# UI/UX Audit Report" > "$report"

  log "Scanning for low-contrast inline styles…"
  find "$PROJECT_DIR" -type f \( -name "*.html" -o -name "*.jsx" -o -name "*.tsx" -o -name "*.vue" \) \
    | xargs grep -lE "color\s*:\s*#[a-fA-F0-9]{3,6}" 2>/dev/null \
    | while read -r file; do
        warn "Possible contrast issue in: $file"
        record_issue "UI/UX" "MEDIUM" "Potential low-contrast color in ${file}"
        echo "- Potential low-contrast color: \`${file}\`" >> "$report"
      done || true

  log "Checking for missing :focus styles…"
  find "$PROJECT_DIR" -type f -name "*.css" \
    | xargs grep -L ":focus" 2>/dev/null \
    | while read -r file; do
        warn "No :focus style in: $file"
        record_issue "UI/UX" "HIGH" "Missing :focus styles in ${file}"
        echo "- Missing :focus styles: \`${file}\`" >> "$report"
      done || true

  log "Checking button elements for accessible text…"
  find "$PROJECT_DIR" -type f \( -name "*.html" -o -name "*.jsx" -o -name "*.tsx" \) \
    | xargs grep -nE "<button[^>]*>\s*</button>|<button[^>]*/>" 2>/dev/null \
    | while read -r match; do
        warn "Empty button: $match"
        record_issue "UI/UX" "HIGH" "Empty button element: ${match}"
        echo "- Empty button: \`${match}\`" >> "$report"
      done || true

  log "Detecting inconsistent spacing units…"
  find "$PROJECT_DIR" -type f -name "*.css" \
    | xargs grep -nE "margin|padding" 2>/dev/null \
    | grep -v "var(--" \
    | grep -vE "^\s*\/\*" \
    | head -30 >> "$report" || true

  log "Checking for hardcoded font sizes (non-rem/em)…"
  find "$PROJECT_DIR" -type f -name "*.css" \
    | xargs grep -nE "font-size\s*:\s*[0-9]+px" 2>/dev/null \
    | while read -r match; do
        warn "Hardcoded px font-size: $match"
        record_issue "UI/UX" "MEDIUM" "Hardcoded px font-size: ${match}"
        echo "- Hardcoded px font-size: \`${match}\`" >> "$report"
      done || true

  success "UI/UX audit complete → ${report}"
}

# =============================================================================
# B. RESPONSIVENESS AUDIT
# =============================================================================
audit_responsive() {
  should_run "responsive" || { log "Skipping Responsiveness audit"; return; }
  header "B. RESPONSIVENESS AUDIT"
  local report="${REPORT_DIR}/responsive/report.md"
  echo "# Responsiveness Audit Report" > "$report"

  log "Checking for fixed-width elements (potential overflow)…"
  find "$PROJECT_DIR" -type f -name "*.css" \
    | xargs grep -nE "width\s*:\s*[0-9]{4,}px" 2>/dev/null \
    | while read -r match; do
        warn "Fixed large width: $match"
        record_issue "Responsive" "HIGH" "Fixed large width: ${match}"
        echo "- Fixed large width: \`${match}\`" >> "$report"
      done || true

  log "Checking for missing viewport meta tag…"
  find "$PROJECT_DIR" -type f -name "*.html" \
    | xargs grep -L "viewport" 2>/dev/null \
    | while read -r file; do
        warn "Missing viewport meta: $file"
        record_issue "Responsive" "CRITICAL" "Missing viewport meta in ${file}"
        echo "- Missing viewport meta: \`${file}\`" >> "$report"
        if $AUTO_FIX; then
          sed -i 's|<head>|<head>\n  <meta name="viewport" content="width=device-width, initial-scale=1">|' "$file"
          success "Fixed: added viewport meta to $file"
        fi
      done || true

  log "Checking for tap-target size issues (< 44px)…"
  find "$PROJECT_DIR" -type f -name "*.css" \
    | xargs grep -nE "(width|height)\s*:\s*([0-9]|[1-3][0-9]|4[0-3])px" 2>/dev/null \
    | while read -r match; do
        warn "Possible small tap target: $match"
        record_issue "Responsive" "MEDIUM" "Small tap target: ${match}"
        echo "- Small tap target: \`${match}\`" >> "$report"
      done || true

  log "Checking for absence of media queries…"
  find "$PROJECT_DIR" -type f -name "*.css" \
    | xargs grep -L "@media" 2>/dev/null \
    | while read -r file; do
        warn "No media queries in: $file"
        record_issue "Responsive" "HIGH" "No media queries in ${file}"
        echo "- No media queries: \`${file}\`" >> "$report"
      done || true

  success "Responsiveness audit complete → ${report}"
}

# =============================================================================
# C. PERFORMANCE AUDIT
# =============================================================================
audit_performance() {
  should_run "perf" || { log "Skipping Performance audit"; return; }
  header "C. PERFORMANCE AUDIT"
  local report="${REPORT_DIR}/perf/report.md"
  echo "# Performance Audit Report" > "$report"
  echo "Targets: LCP < 2.5s | CLS < 0.1 | INP < 200ms" >> "$report"
  echo "" >> "$report"

  log "Scanning for unoptimized images (non-webp/avif)…"
  find "$PROJECT_DIR" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" \) \
    | while read -r img; do
        warn "Non-next-gen image: $img"
        record_issue "Performance" "MEDIUM" "Non-next-gen image format: ${img}"
        echo "- Convert to WebP/AVIF: \`${img}\`" >> "$report"
      done || true

  log "Checking for render-blocking scripts…"
  find "$PROJECT_DIR" -type f -name "*.html" \
    | xargs grep -nE "<script(?!.*async|.*defer)[^>]*src=" 2>/dev/null \
    | while read -r match; do
        warn "Render-blocking script: $match"
        record_issue "Performance" "HIGH" "Render-blocking script: ${match}"
        echo "- Add async/defer: \`${match}\`" >> "$report"
        if $AUTO_FIX; then
          sed -i 's|<script src=|<script defer src=|g' "$(echo "$match" | cut -d: -f1)"
          success "Fixed: added defer to script tag"
        fi
      done || true

  log "Checking for missing lazy-loading on images…"
  find "$PROJECT_DIR" -type f \( -name "*.html" -o -name "*.jsx" -o -name "*.tsx" \) \
    | xargs grep -nE "<img(?!.*loading=)" 2>/dev/null \
    | while read -r match; do
        warn "Image missing lazy loading: $match"
        record_issue "Performance" "MEDIUM" "Missing loading='lazy' on img: ${match}"
        echo "- Add loading='lazy': \`${match}\`" >> "$report"
      done || true

  log "Checking for large CSS bundles (> 100 KB)…"
  find "$PROJECT_DIR" -type f -name "*.css" -size +100k \
    | while read -r file; do
        warn "Large CSS file: $file ($(du -sh "$file" | cut -f1))"
        record_issue "Performance" "HIGH" "Large CSS file: ${file}"
        echo "- Split/purge CSS: \`${file}\`" >> "$report"
      done || true

  log "Checking for large JS bundles (> 250 KB)…"
  find "$PROJECT_DIR" -type f -name "*.js" -not -path "*/node_modules/*" -size +250k \
    | while read -r file; do
        warn "Large JS file: $file ($(du -sh "$file" | cut -f1))"
        record_issue "Performance" "HIGH" "Large JS bundle: ${file}"
        echo "- Split/tree-shake: \`${file}\`" >> "$report"
      done || true

  if [[ -n "$LIVE_URL" ]] && command -v lighthouse &>/dev/null; then
    log "Running Lighthouse on $LIVE_URL…"
    lighthouse "$LIVE_URL" \
      --output json \
      --output-path "${REPORT_DIR}/perf/lighthouse.json" \
      --chrome-flags="--headless --no-sandbox" 2>/dev/null || warn "Lighthouse run failed"
    success "Lighthouse report saved"
  fi

  success "Performance audit complete → ${report}"
}

# =============================================================================
# D. SEO AUDIT
# =============================================================================
audit_seo() {
  should_run "seo" || { log "Skipping SEO audit"; return; }
  header "D. SEO AUDIT"
  local report="${REPORT_DIR}/seo/report.md"
  echo "# SEO Audit Report" > "$report"

  log "Checking for missing <title> tags…"
  find "$PROJECT_DIR" -type f -name "*.html" \
    | xargs grep -L "<title>" 2>/dev/null \
    | while read -r file; do
        warn "Missing <title>: $file"
        record_issue "SEO" "CRITICAL" "Missing <title> tag in ${file}"
        echo "- Missing title: \`${file}\`" >> "$report"
      done || true

  log "Checking for missing meta description…"
  find "$PROJECT_DIR" -type f -name "*.html" \
    | xargs grep -L 'meta name="description"' 2>/dev/null \
    | while read -r file; do
        warn "Missing meta description: $file"
        record_issue "SEO" "HIGH" "Missing meta description in ${file}"
        echo "- Missing meta description: \`${file}\`" >> "$report"
      done || true

  log "Checking for missing canonical tags…"
  find "$PROJECT_DIR" -type f -name "*.html" \
    | xargs grep -L 'rel="canonical"' 2>/dev/null \
    | while read -r file; do
        record_issue "SEO" "MEDIUM" "Missing canonical tag in ${file}"
        echo "- Missing canonical: \`${file}\`" >> "$report"
      done || true

  log "Checking for Open Graph tags…"
  find "$PROJECT_DIR" -type f -name "*.html" \
    | xargs grep -L 'og:title' 2>/dev/null \
    | while read -r file; do
        record_issue "SEO" "MEDIUM" "Missing Open Graph tags in ${file}"
        echo "- Missing OG tags: \`${file}\`" >> "$report"
      done || true

  log "Checking heading hierarchy…"
  find "$PROJECT_DIR" -type f -name "*.html" \
    | while read -r file; do
        local h1_count
        h1_count=$(grep -c "<h1" "$file" 2>/dev/null || echo 0)
        if [[ "$h1_count" -eq 0 ]]; then
          warn "No <h1> in: $file"
          record_issue "SEO" "HIGH" "No <h1> tag in ${file}"
          echo "- Missing H1: \`${file}\`" >> "$report"
        elif [[ "$h1_count" -gt 1 ]]; then
          warn "Multiple <h1> tags in: $file ($h1_count)"
          record_issue "SEO" "MEDIUM" "Multiple <h1> tags (${h1_count}) in ${file}"
          echo "- Multiple H1 tags: \`${file}\`" >> "$report"
        fi
      done || true

  log "Checking for images missing alt text…"
  find "$PROJECT_DIR" -type f \( -name "*.html" -o -name "*.jsx" -o -name "*.tsx" \) \
    | xargs grep -nE '<img(?![^>]*alt=)' 2>/dev/null \
    | while read -r match; do
        warn "Image missing alt: $match"
        record_issue "SEO" "HIGH" "Image missing alt text: ${match}"
        echo "- Missing alt: \`${match}\`" >> "$report"
      done || true

  log "Checking for sitemap.xml…"
  if ! find "$PROJECT_DIR" -name "sitemap.xml" | grep -q .; then
    warn "No sitemap.xml found"
    record_issue "SEO" "HIGH" "sitemap.xml missing"
    echo "- sitemap.xml missing – generate one" >> "$report"
    if $AUTO_FIX; then
      generate_sitemap
    fi
  fi

  log "Checking for robots.txt…"
  if ! find "$PROJECT_DIR" -name "robots.txt" | grep -q .; then
    warn "No robots.txt found"
    record_issue "SEO" "MEDIUM" "robots.txt missing"
    echo "- robots.txt missing – creating default" >> "$report"
    if $AUTO_FIX; then
      generate_robots_txt
    fi
  fi

  log "Generating JSON-LD structured data template…"
  generate_jsonld

  success "SEO audit complete → ${report}"
}

# ── SEO Fix Helpers ───────────────────────────────────────────────────────────
generate_sitemap() {
  cat > "${PROJECT_DIR}/sitemap.xml" <<'SITEMAP'
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  <!-- AUTO-GENERATED: replace with actual URLs -->
  <url>
    <loc>https://example.com/</loc>
    <lastmod>YYYY-MM-DD</lastmod>
    <changefreq>weekly</changefreq>
    <priority>1.0</priority>
  </url>
</urlset>
SITEMAP
  success "Created sitemap.xml template"
}

generate_robots_txt() {
  cat > "${PROJECT_DIR}/robots.txt" <<'ROBOTS'
User-agent: *
Allow: /
Disallow: /admin/
Disallow: /api/
Sitemap: https://example.com/sitemap.xml
ROBOTS
  success "Created robots.txt"
}

generate_jsonld() {
  cat > "${REPORT_DIR}/fixes/jsonld_template.html" <<'JSONLD'
<!-- JSON-LD Structured Data – paste inside <head> -->
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "WebSite",
  "name": "Your Site Name",
  "url": "https://example.com",
  "potentialAction": {
    "@type": "SearchAction",
    "target": "https://example.com/search?q={search_term_string}",
    "query-input": "required name=search_term_string"
  }
}
</script>
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "Organization",
  "name": "Your Organization",
  "url": "https://example.com",
  "logo": "https://example.com/logo.png",
  "sameAs": [
    "https://twitter.com/yourhandle",
    "https://linkedin.com/company/yourcompany"
  ]
}
</script>
JSONLD
  success "JSON-LD template saved → ${REPORT_DIR}/fixes/jsonld_template.html"
}

# =============================================================================
# E. SECURITY AUDIT
# =============================================================================
audit_security() {
  should_run "security" || { log "Skipping Security audit"; return; }
  header "E. SECURITY AUDIT"
  local report="${REPORT_DIR}/security/report.md"
  echo "# Security Audit Report" > "$report"

  log "Scanning for hardcoded secrets / API keys…"
  local secret_patterns=(
    "api[_-]?key\s*=\s*['\"][a-zA-Z0-9]{20,}"
    "secret\s*=\s*['\"][a-zA-Z0-9]{20,}"
    "password\s*=\s*['\"][^'\"]{6,}"
    "PRIVATE_KEY"
    "AWS_SECRET"
    "Bearer [a-zA-Z0-9\-._~+/]+=*"
  )
  for pattern in "${secret_patterns[@]}"; do
    find "$PROJECT_DIR" -type f \( -name "*.js" -o -name "*.ts" -o -name "*.env" -o -name "*.json" \) \
      -not -path "*/node_modules/*" \
      | xargs grep -nEi "$pattern" 2>/dev/null \
      | while read -r match; do
          error "Possible secret leak: $match"
          record_issue "Security" "CRITICAL" "Possible secret leak: ${match}"
          echo "- SECRET LEAK: \`${match}\`" >> "$report"
        done || true
  done

  log "Checking for eval() usage…"
  find "$PROJECT_DIR" -type f \( -name "*.js" -o -name "*.ts" \) -not -path "*/node_modules/*" \
    | xargs grep -nE "\beval\s*\(" 2>/dev/null \
    | while read -r match; do
        error "eval() usage: $match"
        record_issue "Security" "CRITICAL" "Dangerous eval() usage: ${match}"
        echo "- eval() found: \`${match}\`" >> "$report"
      done || true

  log "Checking for innerHTML assignments (XSS risk)…"
  find "$PROJECT_DIR" -type f \( -name "*.js" -o -name "*.ts" -o -name "*.jsx" -o -name "*.tsx" \) \
    -not -path "*/node_modules/*" \
    | xargs grep -nE "\.innerHTML\s*=" 2>/dev/null \
    | while read -r match; do
        warn "innerHTML assignment: $match"
        record_issue "Security" "HIGH" "XSS risk – innerHTML: ${match}"
        echo "- innerHTML XSS risk: \`${match}\`" >> "$report"
      done || true

  log "Checking for dangerouslySetInnerHTML (React XSS)…"
  find "$PROJECT_DIR" -type f \( -name "*.jsx" -o -name "*.tsx" \) -not -path "*/node_modules/*" \
    | xargs grep -nE "dangerouslySetInnerHTML" 2>/dev/null \
    | while read -r match; do
        warn "dangerouslySetInnerHTML: $match"
        record_issue "Security" "HIGH" "XSS risk – dangerouslySetInnerHTML: ${match}"
        echo "- dangerouslySetInnerHTML: \`${match}\`" >> "$report"
      done || true

  log "Checking for http:// references (mixed content)…"
  find "$PROJECT_DIR" -type f \( -name "*.html" -o -name "*.js" -o -name "*.ts" \) \
    -not -path "*/node_modules/*" \
    | xargs grep -nE "http://(?!localhost)" 2>/dev/null \
    | while read -r match; do
        warn "Non-HTTPS URL: $match"
        record_issue "Security" "HIGH" "Non-HTTPS URL (mixed content): ${match}"
        echo "- Non-HTTPS: \`${match}\`" >> "$report"
      done || true

  log "Generating secure HTTP headers config…"
  generate_security_headers

  log "Generating CSP policy template…"
  generate_csp

  success "Security audit complete → ${report}"
}

# ── Security Fix Helpers ──────────────────────────────────────────────────────
generate_security_headers() {
  cat > "${REPORT_DIR}/fixes/security_headers.nginx" <<'NGINX'
# Secure HTTP Headers – add to your nginx server block
add_header X-Frame-Options "SAMEORIGIN" always;
add_header X-Content-Type-Options "nosniff" always;
add_header X-XSS-Protection "1; mode=block" always;
add_header Referrer-Policy "strict-origin-when-cross-origin" always;
add_header Permissions-Policy "geolocation=(), microphone=(), camera=()" always;
add_header Strict-Transport-Security "max-age=63072000; includeSubDomains; preload" always;
NGINX

  cat > "${REPORT_DIR}/fixes/security_headers.next.js" <<'NEXTJS'
// next.config.js – securityHeaders
const securityHeaders = [
  { key: 'X-Frame-Options',        value: 'SAMEORIGIN' },
  { key: 'X-Content-Type-Options', value: 'nosniff' },
  { key: 'X-XSS-Protection',       value: '1; mode=block' },
  { key: 'Referrer-Policy',        value: 'strict-origin-when-cross-origin' },
  { key: 'Permissions-Policy',     value: 'geolocation=(), microphone=(), camera=()' },
  {
    key: 'Strict-Transport-Security',
    value: 'max-age=63072000; includeSubDomains; preload',
  },
];

module.exports = {
  async headers() {
    return [{ source: '/(.*)', headers: securityHeaders }];
  },
};
NEXTJS
  success "Security headers saved"
}

generate_csp() {
  cat > "${REPORT_DIR}/fixes/csp_policy.txt" <<'CSP'
# Content Security Policy – tighten per your actual origins
Content-Security-Policy:
  default-src 'self';
  script-src  'self' 'unsafe-inline' https://cdn.example.com;
  style-src   'self' 'unsafe-inline' https://fonts.googleapis.com;
  font-src    'self' https://fonts.gstatic.com;
  img-src     'self' data: https:;
  connect-src 'self' https://api.example.com;
  frame-ancestors 'none';
  base-uri    'self';
  form-action 'self';
CSP
  success "CSP policy template saved"
}

# =============================================================================
# F. ACCESSIBILITY AUDIT
# =============================================================================
audit_accessibility() {
  should_run "a11y" || { log "Skipping Accessibility audit"; return; }
  header "F. ACCESSIBILITY AUDIT (WCAG 2.1 AA)"
  local report="${REPORT_DIR}/a11y/report.md"
  echo "# Accessibility Audit Report – WCAG 2.1 AA" > "$report"

  log "Checking for missing aria-label on icon buttons…"
  find "$PROJECT_DIR" -type f \( -name "*.html" -o -name "*.jsx" -o -name "*.tsx" \) \
    | xargs grep -nE "<button[^>]*>(\s*<(svg|img|i)[^>]*/?>?\s*)</button>" 2>/dev/null \
    | while read -r match; do
        warn "Icon button missing aria-label: $match"
        record_issue "A11y" "HIGH" "Icon button missing aria-label: ${match}"
        echo "- Add aria-label: \`${match}\`" >> "$report"
      done || true

  log "Checking for form inputs missing labels…"
  find "$PROJECT_DIR" -type f \( -name "*.html" -o -name "*.jsx" -o -name "*.tsx" \) \
    | xargs grep -nE '<input(?![^>]*(aria-label|aria-labelledby|id=))' 2>/dev/null \
    | while read -r match; do
        warn "Input missing label association: $match"
        record_issue "A11y" "HIGH" "Input missing label: ${match}"
        echo "- Add label/aria-label: \`${match}\`" >> "$report"
      done || true

  log "Checking for missing skip-navigation link…"
  find "$PROJECT_DIR" -type f -name "*.html" \
    | xargs grep -L "skip" 2>/dev/null \
    | while read -r file; do
        warn "No skip-nav link in: $file"
        record_issue "A11y" "MEDIUM" "Missing skip-navigation in ${file}"
        echo "- Add skip-nav: \`${file}\`" >> "$report"
      done || true

  log "Checking for missing lang attribute on <html>…"
  find "$PROJECT_DIR" -type f -name "*.html" \
    | xargs grep -L '<html.*lang=' 2>/dev/null \
    | while read -r file; do
        warn "Missing lang on <html>: $file"
        record_issue "A11y" "HIGH" "Missing lang attribute in ${file}"
        echo "- Add lang attribute: \`${file}\`" >> "$report"
        if $AUTO_FIX; then
          sed -i 's|<html>|<html lang="en">|' "$file"
          success "Fixed: added lang='en' to $file"
        fi
      done || true

  log "Checking for tabindex > 0 (anti-pattern)…"
  find "$PROJECT_DIR" -type f \( -name "*.html" -o -name "*.jsx" -o -name "*.tsx" \) \
    | xargs grep -nE 'tabindex="[1-9]' 2>/dev/null \
    | while read -r match; do
        warn "tabindex > 0: $match"
        record_issue "A11y" "MEDIUM" "Positive tabindex (anti-pattern): ${match}"
        echo "- Use tabindex='0' or '-1': \`${match}\`" >> "$report"
      done || true

  if [[ -n "$LIVE_URL" ]] && command -v axe &>/dev/null; then
    log "Running axe-cli on $LIVE_URL…"
    axe "$LIVE_URL" --save "${REPORT_DIR}/a11y/axe-report.json" 2>/dev/null || warn "axe-cli run failed"
    success "axe report saved"
  fi

  success "Accessibility audit complete → ${report}"
}

# =============================================================================
# G. ECOMMERCE UX AUDIT
# =============================================================================
audit_ecommerce() {
  should_run "ecommerce" || { log "Skipping Ecommerce audit"; return; }
  header "G. ECOMMERCE UX AUDIT"
  local report="${REPORT_DIR}/ecommerce/report.md"
  echo "# Ecommerce UX Audit Report" > "$report"

  log "Checking for Add to Cart CTA clarity…"
  find "$PROJECT_DIR" -type f \( -name "*.html" -o -name "*.jsx" -o -name "*.tsx" \) \
    | xargs grep -niE "add.to.cart|buy.now|purchase" 2>/dev/null \
    | head -20 >> "$report" || true

  log "Checking for trust badge signals…"
  local trust_terms=("secure" "ssl" "guaranteed" "refund" "free.return" "trust" "verified")
  for term in "${trust_terms[@]}"; do
    if ! grep -riE "$term" "$PROJECT_DIR" --include="*.html" --include="*.jsx" --include="*.tsx" &>/dev/null; then
      warn "Trust signal '$term' not found in UI"
      record_issue "Ecommerce" "MEDIUM" "Missing trust signal: ${term}"
      echo "- Consider adding trust signal: \`${term}\`" >> "$report"
    fi
  done || true

  log "Checking for review/rating elements…"
  if ! grep -riE "review|rating|star" "$PROJECT_DIR" --include="*.html" --include="*.jsx" --include="*.tsx" &>/dev/null; then
    warn "No review/rating elements found"
    record_issue "Ecommerce" "HIGH" "No reviews or ratings visible"
    echo "- Add product reviews/ratings" >> "$report"
  fi

  log "Checking for price visibility…"
  if ! grep -riE "\\\$|price|€|£" "$PROJECT_DIR" --include="*.html" --include="*.jsx" --include="*.tsx" &>/dev/null; then
    warn "No price elements detected"
    record_issue "Ecommerce" "CRITICAL" "No pricing visible"
    echo "- Ensure pricing is prominently displayed" >> "$report"
  fi

  success "Ecommerce audit complete → ${report}"
}

# =============================================================================
# H. CODE QUALITY AUDIT
# =============================================================================
audit_code_quality() {
  should_run "code" || { log "Skipping Code Quality audit"; return; }
  header "H. CODE QUALITY AUDIT"
  local report="${REPORT_DIR}/code/report.md"
  echo "# Code Quality Audit Report" > "$report"

  log "Checking for TODO/FIXME/HACK comments…"
  find "$PROJECT_DIR" -type f \( -name "*.js" -o -name "*.ts" -o -name "*.jsx" -o -name "*.tsx" \) \
    -not -path "*/node_modules/*" \
    | xargs grep -nE "(TODO|FIXME|HACK|XXX|BUG):" 2>/dev/null \
    | while read -r match; do
        warn "Unresolved comment: $match"
        record_issue "Code" "LOW" "Unresolved TODO/FIXME: ${match}"
        echo "- \`${match}\`" >> "$report"
      done || true

  log "Checking for console.log in production code…"
  find "$PROJECT_DIR" -type f \( -name "*.js" -o -name "*.ts" -o -name "*.jsx" -o -name "*.tsx" \) \
    -not -path "*/node_modules/*" \
    | xargs grep -nE "console\.(log|warn|error|debug)" 2>/dev/null \
    | while read -r match; do
        warn "console.* in source: $match"
        record_issue "Code" "MEDIUM" "console.* in production code: ${match}"
        echo "- Remove/replace with logger: \`${match}\`" >> "$report"
      done || true

  log "Checking for deeply nested callbacks / callback hell…"
  find "$PROJECT_DIR" -type f \( -name "*.js" -o -name "*.ts" \) -not -path "*/node_modules/*" \
    | xargs grep -nE "}\s*\)\s*\)\s*\)\s*\)" 2>/dev/null \
    | while read -r match; do
        warn "Possible callback hell: $match"
        record_issue "Code" "MEDIUM" "Deeply nested callbacks: ${match}"
        echo "- Refactor to async/await: \`${match}\`" >> "$report"
      done || true

  log "Checking for large files (> 300 lines)…"
  find "$PROJECT_DIR" -type f \( -name "*.js" -o -name "*.ts" -o -name "*.jsx" -o -name "*.tsx" \) \
    -not -path "*/node_modules/*" \
    | while read -r file; do
        local lines
        lines=$(wc -l < "$file")
        if (( lines > 300 )); then
          warn "Large file ($lines lines): $file"
          record_issue "Code" "MEDIUM" "Large file – consider splitting: ${file} (${lines} lines)"
          echo "- Split large file: \`${file}\` (${lines} lines)" >> "$report"
        fi
      done || true

  log "Checking for missing .env.example…"
  if find "$PROJECT_DIR" -maxdepth 2 -name ".env" | grep -q . && \
     ! find "$PROJECT_DIR" -maxdepth 2 -name ".env.example" | grep -q .; then
    warn ".env exists but no .env.example"
    record_issue "Code" "HIGH" ".env.example missing"
    echo "- Create .env.example (sanitised)" >> "$report"
    if $AUTO_FIX; then
      grep -E "^[A-Z_]+=" "${PROJECT_DIR}/.env" | sed 's/=.*/=/' > "${PROJECT_DIR}/.env.example"
      success "Created .env.example (values stripped)"
    fi
  fi

  if command -v eslint &>/dev/null; then
    log "Running ESLint…"
    eslint "$PROJECT_DIR" --ext .js,.jsx,.ts,.tsx \
      --ignore-pattern "node_modules" \
      -f json -o "${REPORT_DIR}/code/eslint.json" 2>/dev/null || warn "ESLint completed with errors"
    success "ESLint report saved"
  fi

  success "Code Quality audit complete → ${report}"
}

# =============================================================================
# GENERATE FINAL REPORT
# =============================================================================
generate_summary() {
  header "Generating Audit Summary"

  # Initialise issues table if empty
  if [[ ! -f "${REPORT_DIR}/issues.md" ]]; then
    echo "| Section | Severity | Issue |" > "${REPORT_DIR}/issues.md"
    echo "|---------|----------|-------|" >> "${REPORT_DIR}/issues.md"
  fi

  cat > "$SUMMARY_FILE" <<SUMMARY
# 🔍 EXTREME FULL-SCOPE AUDIT REPORT
**Date:** $(date '+%Y-%m-%d %H:%M:%S')
**Project:** ${PROJECT_DIR}
**Live URL:** ${LIVE_URL:-"N/A"}
**Auto-Fix Applied:** ${AUTO_FIX}
**Total Issues Found:** ${ISSUES_COUNT}

---

## Sections Audited
| # | Section | Status |
|---|---------|--------|
| A | UI / UX | ✅ |
| B | Responsiveness | ✅ |
| C | Performance | ✅ |
| D | SEO | ✅ |
| E | Security | ✅ |
| F | Accessibility (WCAG 2.1 AA) | ✅ |
| G | Ecommerce UX | ✅ |
| H | Code Quality | ✅ |

---

## Issues Table
$(cat "${REPORT_DIR}/issues.md" 2>/dev/null)

---

## Targets

| Metric | Target | Notes |
|--------|--------|-------|
| LCP | < 2.5 s | Use Lighthouse to verify |
| CLS | < 0.1 | Eliminate layout shift |
| INP | < 200 ms | Defer heavy JS |
| WCAG | 2.1 AA | Run axe-core in CI |

---

## Generated Fix Files
$(find "${REPORT_DIR}/fixes" -type f | sort | sed 's|^|- |')

---

## Next Steps
1. Review every CRITICAL and HIGH issue first
2. Apply generated fix templates from \`${REPORT_DIR}/fixes/\`
3. Run Lighthouse CI in your pipeline
4. Integrate axe-core into your test suite
5. Set up CSP and security headers in your web server / CDN

---
*Generated by full_audit.sh*
SUMMARY

  success "Summary saved → ${SUMMARY_FILE}"
}

# =============================================================================
# MAIN
# =============================================================================
main() {
  echo -e "${BOLD}${CYAN}"
  cat <<'BANNER'
  ███████╗██╗   ██╗██╗     ██╗      █████╗ ██╗   ██╗██████╗ ██╗████████╗
  ██╔════╝██║   ██║██║     ██║     ██╔══██╗██║   ██║██╔══██╗██║╚══██╔══╝
  █████╗  ██║   ██║██║     ██║     ███████║██║   ██║██║  ██║██║   ██║
  ██╔══╝  ██║   ██║██║     ██║     ██╔══██║██║   ██║██║  ██║██║   ██║
  ██║     ╚██████╔╝███████╗███████╗██║  ██║╚██████╔╝██████╔╝██║   ██║
  ╚═╝      ╚═════╝ ╚══════╝╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚═════╝ ╚═╝   ╚═╝
  EXTREME FULL-SCOPE AUDIT  |  v1.0
BANNER
  echo -e "${RESET}"

  [[ ! -d "$PROJECT_DIR" ]] && { error "Project directory not found: $PROJECT_DIR"; exit 1; }

  # Initialise issues table header
  echo "| Section | Severity | Issue |" > "${REPORT_DIR}/issues.md"
  echo "|---------|----------|-------|" >> "${REPORT_DIR}/issues.md"

  check_tools
  audit_ui_ux
  audit_responsive
  audit_performance
  audit_seo
  audit_security
  audit_accessibility
  audit_ecommerce
  audit_code_quality
  generate_summary

  echo ""
  echo -e "${BOLD}${GREEN}════════════════════════════════════════${RESET}"
  echo -e "${BOLD}${GREEN}  AUDIT COMPLETE – ${ISSUES_COUNT} issues found${RESET}"
  echo -e "${BOLD}${GREEN}  Report directory: ${REPORT_DIR}${RESET}"
  echo -e "${BOLD}${GREEN}  Summary: ${SUMMARY_FILE}${RESET}"
  echo -e "${BOLD}${GREEN}════════════════════════════════════════${RESET}"
}

main
