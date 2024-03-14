# Vercel-DDNS
Vercel Dynamic DNS (DDNS)


A bash Script for exposing local server with Vercel DNS. It runs every 15 minutes, checking current IP address and updates DNS records for your domain.

Usage:
1.Pointing your domain name NS server to Vercel.(May be CNAME works too)

2.Down the DDNS.sh

3.Edit:

DOMAIN='abc.com'

SUB_DOMAIN='xyz'

VERCEL_TOKEN='M2qG463fdfdk0Q3BkEjnvdTzI'

#get the VERCEL_TOKEN from https://vercel.com/account/tokens

4.Upload DDNS.sh

5.Move DDNS.sh into /root/

6.#Open cron settings crontab -e

#Add this line :

*/15 * * * * /root/DDNS.sh

then you can visit  http://xyz.abc.com:port 

7.Go to bed.


Thank @alyx404  :https://github.com/alyx404/Vercel-DDNS-v6
