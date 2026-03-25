import { motion } from 'framer-motion'
import { FileText, ShieldCheck, ScrollText, Sparkles } from 'lucide-react'
import FadeIn from '../components/FadeIn'
import Footer from '../components/Footer'

const legalContent = {
  privacy: {
    eyebrow: 'Privacy Policy',
    title: 'Privacy matters here.',
    intro:
      'This Privacy Policy explains how The Loop Trilogy website collects, uses, and protects your information. By using this website, you agree to the practices described below.',
    highlight: 'We aim to keep privacy expectations clear, practical, and respectful.',
    updatedAt: 'Last updated: March 25, 2026',
    sections: [
      {
        title: '1. Information We Collect',
        body: [
          'We may collect the following categories of information through this website and its related forms or website tools.',
        ],
        groups: [
          {
            title: 'Personal Information',
            items: [
              'Name',
              'Email address',
              'Phone number, if submitted through contact forms',
              'Country and other form details you choose to provide',
            ],
          },
          {
            title: 'Technical Information',
            items: [
              'IP address',
              'Browser type',
              'Device type',
              'Operating system',
              'Pages visited',
              'Referring URLs',
            ],
          },
          {
            title: 'Account or Transaction Information',
            items: [
              'If account, checkout, wishlist, or order-history features are introduced on this website, related account or transaction details may also be collected and stored as needed to provide those services.',
            ],
          },
        ],
      },
      {
        title: '2. How We Use Information',
        intro: 'We may use information collected through this website to:',
        items: [
          'Respond to enquiries and provide customer support',
          'Review and manage submitted reviews or messages',
          'Process orders or deliver books if purchasing features are made available',
          'Improve website performance and functionality',
          'Personalize the user experience',
          'Send transactional or service-related emails',
          'Prevent fraud or misuse',
          'Comply with legal obligations',
        ],
        note: 'We do not sell personal data.',
      },
      {
        title: '3. Cookies and Tracking',
        body: [
          'This website may use cookies or similar technologies to improve functionality and understand usage patterns.',
        ],
        items: [
          'Maintain sessions or website preferences',
          'Store cart or checkout-related information if those features are enabled',
          'Analyze traffic and visitor behavior',
          'Improve website functionality and performance',
        ],
        note: 'Users can disable cookies through browser settings, but doing so may affect some website functionality.',
      },
      {
        title: '4. Payment Security',
        body: [
          'If payments are offered through this website, they will be processed through secure third-party providers.',
          'We do not store full credit card details or CVV numbers on this website.',
          'Applicable payment providers are expected to use appropriate industry-standard protections, including PCI-DSS compliant processing where relevant.',
        ],
      },
      {
        title: '5. Data Sharing',
        intro: 'We may share information only as needed with:',
        items: [
          'Payment processors',
          'Shipping or fulfillment partners, if applicable',
          'Email service providers',
          'Analytics providers',
          'Legal authorities when required by law',
        ],
        note: 'We do not sell user data.',
      },
      {
        title: '6. Data Retention',
        body: [
          'We retain personal data only for as long as reasonably necessary for website operations, communication, order fulfillment where applicable, legal compliance, and legitimate business needs.',
          'Users may request deletion of their data, subject to any legal or operational requirements that require retention.',
        ],
      },
      {
        title: '7. User Rights',
        intro: 'Users may have the right to:',
        items: [
          'Request access to personal data',
          'Request correction of inaccurate data',
          'Request deletion of data',
          'Withdraw consent for marketing communications where applicable',
        ],
        note: 'Requests can be submitted through the website contact page or by email.',
      },
      {
        title: '8. Security Measures',
        body: [
          'We implement reasonable security measures designed to protect information handled through this website.',
        ],
        items: [
          'SSL encryption',
          'Secure hosting practices',
          'Access controls',
          'Regular updates and maintenance',
        ],
        note: 'However, no online system can be guaranteed to be completely secure.',
      },
      {
        title: "9. Children's Privacy",
        body: [
          'This website is not intended for children under 13, and we do not knowingly collect personal data from children under 13.',
        ],
      },
      {
        title: '10. Third-Party Links',
        body: [
          'This website may contain links to third-party websites or services. We are not responsible for the privacy practices, content, or policies of those third-party websites.',
        ],
      },
      {
        title: '11. Changes to This Privacy Policy',
        body: [
          'We may update this Privacy Policy from time to time. Any changes will be posted on this page with an updated effective date.',
        ],
      },
      {
        title: '12. Contact Information',
        body: [
          'For privacy-related questions or requests, please contact us at privacy@looptrilogy.com or through the website contact page.',
          'Business mailing address details can be added here if and when a public business address is made available for this website.',
        ],
      },
    ],
  },
  terms: {
    eyebrow: 'Terms of Service',
    title: 'Terms for using this website.',
    intro:
      'Welcome to The Loop Trilogy website. These Terms of Service govern your use of this website and its services, including browsing content, submitting forms, and any future book purchasing features made available through the site.',
    highlight: 'By accessing or using the website, you agree to comply with these Terms.',
    updatedAt: 'Last updated: March 25, 2026',
    sections: [
      {
        title: '1. Eligibility',
        intro: 'By using this website, you confirm that:',
        items: [
          'You are at least 18 years old or have permission from a legal guardian',
          'You have the legal capacity to enter into a binding agreement',
          'You will use this website in compliance with applicable laws',
        ],
      },
      {
        title: '2. Use of the Website',
        body: [
          'You agree to use the website only for lawful purposes.',
        ],
        intro: 'You must not:',
        items: [
          'Use the website for fraudulent purposes',
          'Attempt to gain unauthorized access to our systems',
          'Copy, distribute, or reproduce content without permission',
          'Upload malicious code or attempt to disrupt services',
          'Use automated tools such as bots or scrapers without permission',
        ],
        note: 'We reserve the right to restrict or terminate access for violations.',
      },
      {
        title: '3. Account Registration',
        body: [
          'Some features may require account creation if those features are introduced on this website.',
        ],
        intro: 'If account functionality is enabled, you agree to:',
        items: [
          'Provide accurate and complete information',
          'Keep login credentials secure',
          'Notify us of unauthorized access',
          'Accept responsibility for activity under your account',
        ],
        note: 'We reserve the right to suspend accounts that violate our policies.',
      },
      {
        title: '4. Products and Services',
        intro: 'This website may offer or later offer:',
        items: [
          'Physical books',
          'Digital books such as PDF or EPUB files',
          'Book-related resources',
          'Subscription or update services where applicable',
        ],
        note: 'We reserve the right to modify pricing, update descriptions, discontinue products, limit quantities, or change availability at any time.',
      },
      {
        title: '5. Orders and Payments',
        body: [
          'If orders are placed through this website, you agree that payment information submitted is accurate and authorized.',
          'Prices, taxes, shipping charges, and other checkout terms may apply as shown at the time of purchase.',
          'Orders are considered confirmed only after successful payment processing and acceptance by us.',
        ],
        intro: 'We reserve the right to cancel orders due to:',
        items: [
          'Pricing or listing errors',
          'Fraud concerns',
          'Stock or availability issues',
        ],
      },
      {
        title: '6. Shipping and Delivery',
        body: [
          'Delivery times for physical books may vary depending on destination and shipping provider.',
          'Customers are responsible for providing accurate shipping and delivery information.',
        ],
        intro: 'We are not responsible for delays caused by:',
        items: [
          'Courier services',
          'Customs clearance',
          'Incorrect shipping information',
          'Natural events, strikes, or similar disruptions',
        ],
      },
      {
        title: '7. Digital Products',
        intro: 'Digital books and downloads are licensed, not sold, and:',
        items: [
          'May not be redistributed',
          'May not be resold',
          'Are for personal use only',
        ],
        note: 'Unauthorized distribution may result in suspension of access and potential legal action.',
      },
      {
        title: '8. Refund and Return Policy',
        body: [
          'Return and refund terms may vary depending on the product offered and the specific policy displayed at checkout or at the time of sale.',
        ],
        groups: [
          {
            title: 'Physical Books',
            items: [
              'May be eligible for return within the period stated at purchase',
              'Must generally be unused and in original condition unless otherwise stated',
            ],
          },
          {
            title: 'Digital Books',
            items: [
              'Are generally non-refundable once downloaded or delivered unless required by law',
            ],
          },
        ],
        note: 'Refunds or returns may be denied in cases of abuse, misuse, or policy violation.',
      },
      {
        title: '9. Intellectual Property',
        body: [
          'All website content associated with The Loop Trilogy is owned by or used with permission by the site owner unless otherwise stated.',
        ],
        intro: 'This includes items such as:',
        items: [
          'Book descriptions',
          'Graphics',
          'Logos',
          'Website design',
          'Code',
          'Digital content',
        ],
        note: 'You may not reproduce, copy, distribute, or reuse this content without permission.',
      },
      {
        title: '10. User Content',
        intro: 'Users may submit content such as:',
        items: [
          'Reviews',
          'Comments',
          'Ratings',
        ],
        body: [
          'By submitting content through this website, you grant us a non-exclusive right to use, display, and distribute that content in connection with the website and related promotional activity.',
          'We may remove content that violates site guidelines, is unlawful, misleading, abusive, infringing, or otherwise inappropriate.',
        ],
      },
      {
        title: '11. Privacy',
        body: [
          'Your privacy is important to us. Please review the Privacy Policy on this website to understand how we collect, use, and protect data.',
        ],
      },
      {
        title: '12. Third-Party Services',
        intro: 'We may use third-party services including:',
        items: [
          'Payment gateways',
          'Analytics tools',
          'Shipping providers',
          'Email providers',
        ],
        note: 'We are not responsible for third-party terms, privacy practices, availability, or performance.',
      },
      {
        title: '13. Disclaimer',
        body: [
          'This website is provided on an "as is" and "as available" basis to the extent permitted by applicable law.',
        ],
        intro: 'We do not guarantee:',
        items: [
          'Error-free service',
          'Continuous availability',
          'Complete accuracy of product details or book descriptions',
        ],
        note: 'Use of the website is at your own risk.',
      },
      {
        title: '14. Limitation of Liability',
        intro: 'To the extent permitted by law, we are not liable for:',
        items: [
          'Indirect damages',
          'Loss of profits',
          'Loss of data',
          'Business interruption',
        ],
        note: 'Where a purchase has been made, maximum liability will generally be limited to the amount paid for the relevant product or service, unless otherwise required by law.',
      },
      {
        title: '15. Changes to Terms',
        body: [
          'We may update these Terms at any time. Changes will be posted on this page with an updated effective date.',
          'Continued use of the website after changes are posted indicates acceptance of the revised Terms.',
        ],
      },
      {
        title: '16. Governing Law',
        body: [
          'These Terms are governed by the laws of India.',
          'Any disputes arising in connection with these Terms or the website will be subject to the applicable jurisdiction and laws of India.',
        ],
      },
      {
        title: '17. Contact Information',
        body: [
          'For questions about these Terms, please contact support@looptrilogy.com or use the website contact page.',
          'Business mailing address details can be added here if and when a public business address is made available for this website.',
        ],
      },
    ],
  },
}

function LegalSection({ section, index }) {
  return (
    <motion.div
      initial={{ opacity: 0, y: 24 }}
      whileInView={{ opacity: 1, y: 0 }}
      viewport={{ once: true, margin: '-40px' }}
      transition={{ duration: 0.5, delay: index * 0.08 }}
      className="rounded-[1.75rem] border border-gray-100 bg-white p-7 shadow-[0_20px_55px_rgba(15,23,42,0.06)] md:p-8"
    >
      <h2 className="text-2xl font-bold tracking-tight text-gray-900">{section.title}</h2>
      <div className="mt-4 space-y-4 text-gray-600 leading-7">
        {section.intro && <p>{section.intro}</p>}
        {section.body?.map((paragraph) => (
          <p key={paragraph}>{paragraph}</p>
        ))}
        {section.groups?.map((group) => (
          <div key={group.title} className="rounded-2xl border border-gray-100 bg-gray-50/80 p-5">
            <h3 className="text-base font-semibold text-gray-900">{group.title}</h3>
            <ul className="mt-3 space-y-2">
              {group.items.map((item) => (
                <li key={item} className="flex gap-3">
                  <span className="mt-2 h-1.5 w-1.5 flex-shrink-0 rounded-full bg-teal-500" />
                  <span>{item}</span>
                </li>
              ))}
            </ul>
          </div>
        ))}
        {section.items && (
          <ul className="space-y-2">
            {section.items.map((item) => (
              <li key={item} className="flex gap-3">
                <span className="mt-2 h-1.5 w-1.5 flex-shrink-0 rounded-full bg-teal-500" />
                <span>{item}</span>
              </li>
            ))}
          </ul>
        )}
        {section.note && (
          <p className="rounded-2xl border border-teal-100 bg-teal-50 px-4 py-3 text-sm font-medium text-teal-800">
            {section.note}
          </p>
        )}
      </div>
    </motion.div>
  )
}

export default function LegalPage({ pageKey, onNavigate }) {
  const page = legalContent[pageKey] ?? legalContent.privacy
  const isPrivacy = pageKey === 'privacy'
  const Icon = isPrivacy ? ShieldCheck : ScrollText

  return (
    <>
      <section className="relative overflow-hidden bg-white pt-28 pb-14 md:pb-18">
        <div className="absolute inset-0 bg-[radial-gradient(circle_at_top_left,rgba(45,212,191,0.16),transparent_32%),radial-gradient(circle_at_bottom_right,rgba(15,23,42,0.05),transparent_30%)]" />
        <div className="section-shell-wide relative">
          <FadeIn>
            <div className="grid gap-8 lg:grid-cols-[1.05fr_0.95fr] lg:items-center">
              <div>
                <div className="mb-5 inline-flex items-center gap-2 rounded-full border border-teal-200 bg-teal-50 px-4 py-2 text-sm font-semibold text-teal-700">
                  <FileText size={16} />
                  {page.eyebrow}
                </div>
                <h1 className="max-w-3xl text-5xl font-bold tracking-tight text-gray-900 md:text-6xl">
                  {page.title}
                </h1>
                <p className="mt-6 max-w-2xl text-lg leading-8 text-gray-600">
                  {page.intro}
                </p>
                <p className="mt-6 inline-flex rounded-2xl border border-gray-200 bg-white px-5 py-3 text-sm font-medium text-gray-700 shadow-sm">
                  {page.updatedAt}
                </p>
              </div>

              <div className="rounded-[2rem] border border-white/60 bg-[linear-gradient(135deg,#0f172a_0%,#164e63_56%,#14b8a6_100%)] p-8 text-white shadow-[0_30px_80px_rgba(15,23,42,0.18)] md:p-10">
                <div className="flex h-16 w-16 items-center justify-center rounded-2xl border border-white/10 bg-white/10 text-cyan-100 backdrop-blur-sm">
                  <Icon size={30} strokeWidth={1.8} />
                </div>
                <p className="mt-8 text-sm font-semibold uppercase tracking-[0.28em] text-cyan-100/75">
                  Legal Overview
                </p>
                <p className="mt-5 text-2xl font-semibold leading-9">
                  {page.highlight}
                </p>
                <div className="mt-8 grid gap-3 sm:grid-cols-2">
                  <div className="rounded-2xl border border-white/10 bg-white/10 px-4 py-4 backdrop-blur-sm">
                    <p className="text-xs uppercase tracking-[0.24em] text-cyan-100/70">Coverage</p>
                    <p className="mt-2 text-base font-medium text-white">Site pages, forms, and submissions</p>
                  </div>
                  <div className="rounded-2xl border border-white/10 bg-white/10 px-4 py-4 backdrop-blur-sm">
                    <p className="text-xs uppercase tracking-[0.24em] text-cyan-100/70">Approach</p>
                    <p className="mt-2 text-base font-medium text-white">Clear language with practical expectations</p>
                  </div>
                </div>
              </div>
            </div>
          </FadeIn>
        </div>
      </section>

      <section className="bg-gray-50 pb-20 pt-6 md:pb-24">
        <div className="section-shell-wide">
          <FadeIn className="mb-10">
            <div className="flex items-center gap-3">
              <div className="flex h-12 w-12 items-center justify-center rounded-2xl bg-teal-100 text-teal-600">
                <Sparkles size={20} />
              </div>
              <div>
                <p className="text-sm font-semibold uppercase tracking-[0.22em] text-teal-600">Key Sections</p>
                <p className="text-gray-500">A straightforward overview of the policies that apply to this website.</p>
              </div>
            </div>
          </FadeIn>

          <div className="grid gap-6">
            {page.sections.map((section, index) => (
              <LegalSection key={section.title} section={section} index={index} />
            ))}
          </div>
        </div>
      </section>

      <Footer onNavigate={onNavigate} />
    </>
  )
}
