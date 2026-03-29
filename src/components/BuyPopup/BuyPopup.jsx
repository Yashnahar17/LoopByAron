import React, { useState } from 'react';
import './BuyPopup.css';

const platforms = [
  {
    name: 'Amazon',
    audiobook: 'Buy',
    ebook: 'Buy',
    hardcopy: 'Buy',
    links: {
      audiobook: '#amazon-audiobook',
      ebook: '#amazon-ebook',
      hardcopy: '#amazon-hardcopy'
    }
  },
  {
    name: 'Amazon Prime & Global',
    audiobook: null,
    ebook: 'Add-On',
    hardcopy: 'Add-On',
    links: {}
  },
  {
    name: 'Flipkart',
    audiobook: 'Buy',
    ebook: 'Buy',
    hardcopy: 'Buy',
    links: {
      audiobook: '#flipkart-audiobook',
      ebook: '#flipkart-ebook',
      hardcopy: '#flipkart-hardcopy'
    }
  },
  {
    name: 'Meesho',
    audiobook: 'Buy',
    ebook: 'Buy',
    hardcopy: 'Buy',
    links: {
      audiobook: '#meesho-audiobook',
      ebook: '#meesho-ebook',
      hardcopy: '#meesho-hardcopy'
    }
  },
  {
    name: 'Blue Cloud Store',
    audiobook: 'Buy',
    ebook: 'Buy',
    hardcopy: 'Buy',
    links: {
      audiobook: '#bluecloud-audiobook',
      ebook: '#bluecloud-ebook',
      hardcopy: '#bluecloud-hardcopy'
    }
  },
  {
    name: 'Amazon Kindle',
    audiobook: 'Buy',
    ebook: 'Buy',
    hardcopy: 'Buy',
    links: {
      audiobook: '#kindle-audiobook',
      ebook: '#kindle-ebook',
      hardcopy: '#kindle-hardcopy'
    }
  },
  {
    name: 'Google Play Books',
    audiobook: null,
    ebook: 'Global E-Book Listing (150+ Countries)',
    hardcopy: null,
    links: {
      ebook: '#google-play'
    }
  },
  {
    name: 'Blue Cloud Publishers E-Store',
    audiobook: 'Buy',
    ebook: 'Buy',
    hardcopy: 'Buy',
    links: {
      audiobook: '#estore-audiobook',
      ebook: '#estore-ebook',
      hardcopy: '#estore-hardcopy'
    }
  },
  {
    name: 'Spotify',
    audiobook: 'Add-On',
    ebook: 'Buy',
    hardcopy: null,
    links: {
      ebook: '#spotify-ebook'
    }
  },
  {
    name: 'Amazon Music',
    audiobook: 'Add-On',
    ebook: 'Buy',
    hardcopy: null,
    links: {
      ebook: '#amazon-music-ebook'
    }
  },
  {
    name: 'Apple Music',
    audiobook: 'Add-On',
    ebook: 'Buy',
    hardcopy: null,
    links: {
      ebook: '#apple-music-ebook'
    }
  }
];

const BuyPopup = ({ bookTitle = 'The Loop Trilogy' }) => {
  const [isOpen, setIsOpen] = useState(false);

  const openPopup = () => setIsOpen(true);
  const closePopup = () => setIsOpen(false);

  const handleBuyClick = (link) => {
    if (link && link !== '#') {
      window.open(link, '_blank');
    }
  };

  const renderCell = (value, link) => {
    if (!value) {
      return <span className="dash">—</span>;
    }

    if (value === 'Buy') {
      return (
        <button
          className="buy-btn"
          onClick={() => handleBuyClick(link)}
        >
          Buy
        </button>
      );
    }

    if (value === 'Add-On') {
      return <span className="badge addon">Add-On</span>;
    }

    // For special cases like "Global E-Book Listing"
    return (
      <button
        className="buy-btn global-listing"
        onClick={() => handleBuyClick(link)}
      >
        {value}
      </button>
    );
  };

  return (
    <>
      {/* Main Buy Button */}
      <button className="main-buy-btn" onClick={openPopup}>
        Buy Now
      </button>

      {/* Popup Overlay */}
      {isOpen && (
        <div className="popup-overlay" onClick={closePopup}>
          <div className="popup-container" onClick={(e) => e.stopPropagation()}>
            {/* Header */}
            <div className="popup-header">
              <h2>Buy "{bookTitle}"</h2>
              <button className="close-btn" onClick={closePopup}>
                ×
              </button>
            </div>

            {/* Table */}
            <div className="table-wrapper">
              <table className="buy-table">
                <thead>
                  <tr>
                    <th>Platform</th>
                    <th>Audiobook</th>
                    <th>E-Book</th>
                    <th>Hardcopy / Paperback</th>
                  </tr>
                </thead>
                <tbody>
                  {platforms.map((platform, index) => (
                    <tr key={index}>
                      <td className="platform-name">{platform.name}</td>
                      <td>{renderCell(platform.audiobook, platform.links?.audiobook)}</td>
                      <td>{renderCell(platform.ebook, platform.links?.ebook)}</td>
                      <td>{renderCell(platform.hardcopy, platform.links?.hardcopy)}</td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>

            {/* Footer */}
            <div className="popup-footer">
              <p className="legend">
                <span className="legend-item">
                  <span className="badge addon">Add-On</span> = Requires subscription
                </span>
              </p>
            </div>
          </div>
        </div>
      )}
    </>
  );
};

export default BuyPopup;