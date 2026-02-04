-- Database Migration: Add version columns to support multi-version app
-- Run this script to add version support to existing alkicorp database
-- Usage: mysql -u root alkicorp < sql/add_version_columns.sql

USE alkicorp;

-- Add version column to users table
ALTER TABLE users ADD COLUMN version VARCHAR(20) NOT NULL DEFAULT 'plain';

-- Add version column to posts table
ALTER TABLE posts ADD COLUMN version VARCHAR(20) NOT NULL DEFAULT 'plain';

-- Add version column to comments table
ALTER TABLE comments ADD COLUMN version VARCHAR(20) NOT NULL DEFAULT 'plain';

-- Ensure unique usernames per version (drop old unique constraint if exists)
-- Note: This may fail if username is already unique - that's okay, we'll add composite unique
ALTER TABLE users DROP INDEX IF EXISTS username;
ALTER TABLE users ADD UNIQUE KEY username_version (username, version);

-- Backfill existing data as 'plain' version (if not already set)
UPDATE users SET version = 'plain' WHERE version IS NULL OR version = '';
UPDATE posts SET version = 'plain' WHERE version IS NULL OR version = '';
UPDATE comments SET version = 'plain' WHERE version IS NULL OR version = '';

-- Verify changes
SELECT 'Migration complete. Sample data:' AS '';
SELECT id, username, LEFT(password, 20) AS password_preview, version FROM users LIMIT 5;
SELECT id, title, version FROM posts LIMIT 5;
SELECT id, post_id, version FROM comments LIMIT 5;
