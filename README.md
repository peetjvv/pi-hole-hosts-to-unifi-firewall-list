# pi-hole-hosts-to-unifi-firewall-list

Script to convert a [pi-hole hosts](https://github.com/StevenBlack/hosts) file to a list of enter separated hosts that you can use in the firewall rules on your Unifi Controller.

## Running the script

1. Get the url for the hosts file on the [StevenBlack/hosts](https://github.com/StevenBlack/hosts?tab=readme-ov-file#list-of-all-hosts-file-variants) repo.

2. Run the script. First argument is the url to the hosts file, second argument is an optional path to an output file.

   ```sh
   ./pi-hole-hosts-to-unifi-firewall-list.sh [hosts file url] [output path]
   ```
