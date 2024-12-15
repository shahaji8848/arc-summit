/** @type {import('next').NextConfig} */

const withBundleAnalyzer = require('@next/bundle-analyzer')({
  enabled: process.env.ANALYZE === 'true',
});

const nextConfig = {
  reactStrictMode: false,
  swcMinify: true,
  
  // Example of handling environment variables
  env: {
    // Ensure your backend API or service URL is set correctly here
    API_URL: process.env.API_URL || 'http://127.0.0.1:36529', // Default fallback
    NEXT_PUBLIC_API_URL: process.env.NEXT_PUBLIC_API_URL || 'http://127.0.0.1:36529', // Client-side
  },

  // Additional configuration options can be added here if needed
};

module.exports = withBundleAnalyzer(nextConfig);
