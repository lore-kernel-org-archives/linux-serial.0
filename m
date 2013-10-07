From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: Commit f7d2c0bb (serial: i.MX: evaluate linux,stdout-path property)
 and resulting build errors
Date: Mon, 07 Oct 2013 03:56:19 -0700
Message-ID: <52529353.5000600@roeck-us.net>
References: <20131003045611.GA17921@roeck-us.net> <20131003184445.GH8901@kroah.com> <20131006110956.GM30088@pengutronix.de> <20131006143743.GA23787@roeck-us.net> <20131006191546.GA27140@kroah.com> <20131007064932.GU30088@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:64893 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368Ab3JGK42 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 7 Oct 2013 06:56:28 -0400
In-Reply-To: <20131007064932.GU30088@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Fabio Estevam <fabio.estevam@freescale.com>

On 10/06/2013 11:49 PM, Sascha Hauer wrote:

[ ... ]

>
>>From 66197e3bd3d1f4000a637e6960c340d7aa0ccf1f Mon Sep 17 00:00:00 2001
> From: Sascha Hauer <s.hauer@pengutronix.de>
> Date: Mon, 7 Oct 2013 08:46:46 +0200
> Subject: [PATCH] serial: i.MX: do not allow to build as module
>
> Commit f7d2c0bbdb (serial: i.MX: evaluate linux,stdout-path property) adds a
> call to add_preferred_console() into drivers/tty/serial/imx.c. The file can be
> built as module, yet add_preferred_console() is not exported.
>
> Fix the build failure by disabling module build for the i.MX driver.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>   drivers/tty/serial/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index febd45c..b8c5f36 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -551,7 +551,7 @@ config BFIN_UART3_CTSRTS
>   	  Enable hardware flow control in the driver.
>
>   config SERIAL_IMX
> -	tristate "IMX serial port support"
> +	boot "IMX serial port support"

I don't think 'boot' will get you very far unless that is a new config option
I am not aware of :-).

Guenter

