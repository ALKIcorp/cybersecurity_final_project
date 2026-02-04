-- Alki Corp Blog - MD5 Version Demo Seed Data
-- Run this script to populate the database with MD5-hashed users
-- Usage: mysql -u root alkicorp < MD5/sql/seed_demo_data.sql
-- Note: Run sql/add_version_columns.sql first if tables don't have version columns

USE alkicorp;

-- Ensure tables exist (run main seed_demo_data.sql first if needed)
-- Tables should already exist from main seed script

-- Insert demo users for 'md5' version (MD5-hashed passwords)
INSERT INTO users (username, password, version) VALUES
    ('admin', MD5('admin123'), 'md5'),
    ('johndoe', MD5('password123'), 'md5'),
    ('janesmith', MD5('qwerty456'), 'md5')
ON DUPLICATE KEY UPDATE password = VALUES(password);

-- Get user IDs for MD5 version (they may be different from plain version)
SET @admin_id = (SELECT id FROM users WHERE username = 'admin' AND version = 'md5' LIMIT 1);
SET @johndoe_id = (SELECT id FROM users WHERE username = 'johndoe' AND version = 'md5' LIMIT 1);

-- Insert demo posts for 'md5' version
INSERT INTO posts (title, content, author_id, version) VALUES
    ('Welcome to Alki Corp Blog', 'This is our first blog post. We are excited to share updates about our company and projects.', @admin_id, 'md5'),
    ('Security Best Practices', 'Always use strong passwords and keep your software updated. Security is everyone''s responsibility.', @admin_id, 'md5'),
    ('Team Update', 'We have added new members to our development team. Welcome aboard!', @johndoe_id, 'md5')
ON DUPLICATE KEY UPDATE title = VALUES(title);

-- Get post IDs for MD5 version
SET @post1_id = (SELECT id FROM posts WHERE title = 'Welcome to Alki Corp Blog' AND version = 'md5' LIMIT 1);
SET @post2_id = (SELECT id FROM posts WHERE title = 'Security Best Practices' AND version = 'md5' LIMIT 1);
SET @post3_id = (SELECT id FROM posts WHERE title = 'Team Update' AND version = 'md5' LIMIT 1);

-- Insert demo comments for 'md5' version
INSERT INTO comments (post_id, comment_content, version) VALUES
    (@post1_id, 'Great first post! Looking forward to more updates.', 'md5'),
    (@post1_id, 'Excited to follow along with the company news.', 'md5'),
    (@post2_id, 'Very helpful security tips, thanks for sharing!', 'md5'),
    (@post3_id, 'Welcome to the new team members!', 'md5')
ON DUPLICATE KEY UPDATE comment_content = VALUES(comment_content);

-- Verify data
SELECT 'Users (md5 version):' AS '';
SELECT id, username, password, version FROM users WHERE version = 'md5';

SELECT 'Posts (md5 version):' AS '';
SELECT id, title, author_id, version FROM posts WHERE version = 'md5';

SELECT 'Comments (md5 version):' AS '';
SELECT id, post_id, LEFT(comment_content, 50) AS comment_preview, version FROM comments WHERE version = 'md5';
