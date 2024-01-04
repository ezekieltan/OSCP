import paramiko

def ssh_login(host, username, private_key_path):
    # Create an SSH client instance
    ssh_client = paramiko.SSHClient()

    # Automatically add the server's host key
    ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy())

    try:
        # Load the private key
        private_key = paramiko.RSAKey.from_private_key_file(private_key_path)

        # Connect to the SSH server
        ssh_client.connect(hostname=host, username=username, pkey=private_key)

        print(f"Logged in successfully as '{username}'")
        # Perform operations here if needed after login

        # Close the SSH connection
        ssh_client.close()
    except paramiko.AuthenticationException as e:
        print(f"Failed to log in as '{username}': {e}")
    except paramiko.SSHException as e:
        print(f"SSH error: {e}")
    except Exception as e:
        print(f"An error occurred: {e}")
        ssh_client.close()

if __name__ == "__main__":
    # Define the SSH server details
    host = "192.168.234.149"
    private_key_path = "/path/to/your/private/key"  # Update with the path to your private key

    # List of usernames to attempt login
    usernames = ["user1", "user2", "john"]  # Replace with your list of usernames

    for username in usernames:
        ssh_login(host, username, private_key_path)
