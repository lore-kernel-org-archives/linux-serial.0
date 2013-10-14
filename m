From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] In absence of braces, port and NULL are missed
Date: Mon, 14 Oct 2013 13:54:50 +0100
Message-ID: <20131014125449.GB31708@e106331-lin.cambridge.arm.com>
References: <1381703376-31380-1-git-send-email-roel.kluin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:45271 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755306Ab3JNMy7 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 14 Oct 2013 08:54:59 -0400
Content-Disposition: inline
In-Reply-To: <1381703376-31380-1-git-send-email-roel.kluin@gmail.com>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Roel Kluin <roel.kluin@gmail.com>
Cc: "grant.likely@linaro.org" <grant.likely@linaro.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Tony Prisk <linux@prisktech.co.nz>, linux-serial@vger.kernel.org

[Adding Tony Prisk and linux-serial]

Hi Roel,

While this looks like a good fix, the commit message is a bit confusing.
How about something like the message between the scissor lines below:

---->8----
[PATCH] serial: vt8500: add missing braces

Due to missing braces on an if statement, port will always be assigned
-1 regardless of any alias entries in the dt, which was clearly not the
intended behaviour.

This patch adds the missing braces, fixing the issue.
---->8----

Also, while this is device tree related, you should Cc the driver
maintainer when submitting driver changes. 

Cheers,
Mark.

On Sun, Oct 13, 2013 at 11:29:36PM +0100, Roel Kluin wrote:
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> ---
>  drivers/tty/serial/vt8500_serial.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt8500_serial.c
> index 93b697a..4cf71c0 100644
> --- a/drivers/tty/serial/vt8500_serial.c
> +++ b/drivers/tty/serial/vt8500_serial.c
> @@ -561,12 +561,13 @@ static int vt8500_serial_probe(struct platform_device *pdev)
>  	if (!mmres || !irqres)
>  		return -ENODEV;
>  
> -	if (np)
> +	if (np) {
>  		port = of_alias_get_id(np, "serial");
>  		if (port >= VT8500_MAX_PORTS)
>  			port = -1;
> -	else
> +        } else {
>  		port = -1;
> +        }
>  
>  	if (port < 0) {
>  		/* calculate the port id */
> -- 
> 1.8.1.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
