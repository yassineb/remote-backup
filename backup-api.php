<?php
define('API_KEY', '5bfe0c405c67de32b1de9ea40d093666');
define('UPLOAD_DIR', dirname(__FILE__) . '/uploaded-backups/');

$key = filter_input(INPUT_POST, 'key');

if ($key != API_KEY)
	exit("Invalid key!");

if (isset($_FILES['file']))
{
	if (!is_writable(UPLOAD_DIR) || !move_uploaded_file($_FILES['file']['tmp_name'], UPLOAD_DIR . $_FILES['file']['name']))
		echo "Failed!";
}
