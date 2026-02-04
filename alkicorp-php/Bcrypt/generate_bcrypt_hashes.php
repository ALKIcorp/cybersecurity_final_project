<?php
/**
 * Generate Bcrypt hashes for seed data
 * Run: php Bcrypt/generate_bcrypt_hashes.php
 * Copy the output and use it in Bcrypt/sql/seed_demo_data.sql
 */

require_once __DIR__ . '/config.php';

$users = [
    ['username' => 'admin', 'password' => 'admin123'],
    ['username' => 'johndoe', 'password' => 'password123'],
    ['username' => 'janesmith', 'password' => 'qwerty456']
];

echo "-- Bcrypt hashes for seed data\n";
echo "-- Copy these into Bcrypt/sql/seed_demo_data.sql\n\n";

foreach ($users as $user) {
    $hash = hash_password($user['password']);
    echo "-- {$user['username']} / {$user['password']}\n";
    echo "INSERT INTO users (username, password, version) VALUES ('{$user['username']}', '$hash', 'bcrypt')\n";
    echo "ON DUPLICATE KEY UPDATE password = '$hash';\n\n";
}

echo "\n-- Now insert posts and comments after users are created\n";
echo "-- Use the same pattern as MD5 version seed script\n";
