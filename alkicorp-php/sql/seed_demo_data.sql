-- Alki Corp Blog - Demo Seed Data (Plain Version)
-- Run this script to populate the database with test data for the SQLi demo
-- Usage: mysql -u root alkicorp < sql/seed_demo_data.sql
-- Note: Run sql/add_version_columns.sql first if tables don't have version columns

-- Create database if not exists
CREATE DATABASE IF NOT EXISTS alkicorp;
USE alkicorp;

-- Create users table (with version column)
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(255) NOT NULL,
    version VARCHAR(20) NOT NULL DEFAULT 'plain',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY username_version (username, version)
);

-- Create posts table (with version column)
CREATE TABLE IF NOT EXISTS posts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    author_id INT NOT NULL,
    version VARCHAR(20) NOT NULL DEFAULT 'plain',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (author_id) REFERENCES users(id)
);

-- Create comments table (with version column)
CREATE TABLE IF NOT EXISTS comments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    post_id INT NOT NULL,
    comment_content TEXT NOT NULL,
    version VARCHAR(20) NOT NULL DEFAULT 'plain',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES posts(id)
);

-- Insert demo users for 'plain' version (plaintext passwords for vulnerable demo)
INSERT INTO users (username, password, version) VALUES
    ('admin', 'admin123', 'plain'),
    ('johndoe', 'password123', 'plain'),
    ('janesmith', 'qwerty456', 'plain')
ON DUPLICATE KEY UPDATE password = VALUES(password);

-- Insert demo posts for 'plain' version
-- Note: author_id references users - adjust if needed based on actual user IDs
INSERT INTO posts (title, content, author_id, version) VALUES
    ('Welcome to Alki Corp Blog', 'This is our first blog post. We are excited to share updates about our company and projects.', 1, 'plain'),
    ('Security Best Practices', 'Always use strong passwords and keep your software updated. Security is everyone''s responsibility.', 1, 'plain'),
    ('Team Update', 'We have added new members to our development team. Welcome aboard!', 2, 'plain')
ON DUPLICATE KEY UPDATE title = VALUES(title);

-- Insert demo comments for 'plain' version
INSERT INTO comments (post_id, comment_content, version) VALUES
    (1, 'Great first post! Looking forward to more updates.', 'plain'),
    (1, 'Excited to follow along with the company news.', 'plain'),
    (2, 'Very helpful security tips, thanks for sharing!', 'plain'),
    (3, 'Welcome to the new team members!', 'plain')
ON DUPLICATE KEY UPDATE comment_content = VALUES(comment_content);

-- Verify data
SELECT 'Users (plain version):' AS '';
SELECT id, username, password, version FROM users WHERE version = 'plain';

SELECT 'Posts (plain version):' AS '';
SELECT id, title, author_id, version FROM posts WHERE version = 'plain';

SELECT 'Comments (plain version):' AS '';
SELECT id, post_id, LEFT(comment_content, 50) AS comment_preview, version FROM comments WHERE version = 'plain';
