From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH 1/1] tty: atmel_serial_probe(): index of atmel_ports[]
 fix
Date: Wed, 20 Feb 2013 16:00:48 +0100
Message-ID: <5124E520.709@suse.cz>
References: <1360711049-5557-1-git-send-email-wpawel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ee0-f51.google.com ([74.125.83.51]:43866 "EHLO
	mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757742Ab3BTPAy (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 20 Feb 2013 10:00:54 -0500
In-Reply-To: <1360711049-5557-1-git-send-email-wpawel@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Pawel Wieczorkiewicz <wpawel@gmail.com>, nicolas.ferre@atmel.com, gregkh@linuxfoundation.org, grant.likely@secretlab.ca
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On 02/13/2013 12:17 AM, Pawel Wieczorkiewicz wrote:
> From: Pawel Wieczorkiewicz <wpawel@gmail.com>
> 
> Index of atmel_ports[ATMEL_MAX_UART] should be smaller
> than ATMEL_MAX_UART.
> 
> Signed-off-by: Pawel Wieczorkiewicz <wpawel@gmail.com>
> ---
>  drivers/tty/serial/atmel_serial.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index d4a7c24..3f7586a 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -1772,7 +1772,7 @@ static int atmel_serial_probe(struct platform_device *pdev)
>  		ret = find_first_zero_bit(&atmel_ports_in_use,
>  				sizeof(atmel_ports_in_use));
>  
> -	if (ret > ATMEL_MAX_UART) {
> +	if (!(ret < ATMEL_MAX_UART)) {

Good catch, but the result looks weird. Could you just make it ">="?

And find_first_zero_bit + sizeof above is bogus too. The sizeof returns
4 on 32-bit (the driver is run on 32bit machines exlusively AFAICS). So
the highest possible ret in there is 5. Instead atmel_ports_in_use
should be declared using DECLARE_BITMAP(atmel_ports_in_use,
ATMEL_MAX_UART) and the second parameter here then ATMEL_MAX_UART.

Could you fix that too?

-- 
js
suse labs
