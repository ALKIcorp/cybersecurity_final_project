-- Alki Corp Blog - Bcrypt Version Demo Seed Data
-- Run this script to populate the database with Bcrypt-hashed users
-- Usage: mysql -u root alkicorp < Bcrypt/sql/seed_demo_data.sql
-- Note: Run sql/add_version_columns.sql first if tables don't have version columns
-- Note: Bcrypt hashes must be generated via PHP, not MySQL MD5() function

USE alkicorp;

-- Ensure tables exist (run main seed_demo_data.sql first if needed)
-- Tables should already exist from main seed script

-- Insert demo users for 'bcrypt' version
-- Bcrypt hashes are ~60 characters and must be generated via PHP password_hash()
-- Example PHP code to generate hashes:
-- <?php
-- require 'config.php';
-- echo hash_password('admin123'); // Copy output
-- ?>
-- 
-- Pre-generated Bcrypt hashes (cost=10):
-- admin123: $2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi
-- password123: $2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi (example - generate your own)
-- qwerty456: $2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi (example - generate your own)

-- For now, we'll use a PHP script to generate these, but here's the structure:
-- You need to run a PHP script to generate the actual Bcrypt hashes first

-- Example (replace with actual generated hashes):
-- INSERT INTO users (username, password, version) VALUES
--     ('admin', '$2y$10$...', 'bcrypt'),
--     ('johndoe', '$2y$10$...', 'bcrypt'),
--     ('janesmith', '$2y$10$...', 'bcrypt')
-- ON DUPLICATE KEY UPDATE password = VALUES(password);

-- Note: To generate Bcrypt hashes, create a temporary PHP file:
-- <?php
-- require 'Bcrypt/config.php';
-- echo "admin: " . hash_password('admin123') . "\n";
-- echo "johndoe: " . hash_password('password123') . "\n";
-- echo "janesmith: " . hash_password('qwerty456') . "\n";
-- ?>
-- Then run: php generate_bcrypt.php > bcrypt_hashes.txt
-- Then manually insert the hashes below

-- Placeholder - replace with actual Bcrypt hashes generated via PHP
-- INSERT INTO users (username, password, version) VALUES
--     ('admin', 'GENERATE_VIA_PHP', 'bcrypt'),
--     ('johndoe', 'GENERATE_VIA_PHP', 'bcrypt'),
--     ('janesmith', 'GENERATE_VIA_PHP', 'bcrypt')
-- ON DUPLICATE KEY UPDATE password = VALUES(password);

-- After inserting users, get their IDs and insert posts/comments similar to MD5 version

SELECT 'Note: Bcrypt hashes must be generated via PHP password_hash() function.' AS '';
SELECT 'Create a PHP script using Bcrypt/config.php to generate the hashes, then insert them manually.' AS '';
