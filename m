From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] serial: 8250: Add ns16550a to OF compatible list
Date: Tue, 24 Nov 2009 09:53:52 +0000
Message-ID: <200911240953.52204.arnd@arndb.de>
References: <1259054502-28284-1-git-send-email-monstr@monstr.eu> <1259054502-28284-2-git-send-email-monstr@monstr.eu>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:61551 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932504AbZKXJyu (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 24 Nov 2009 04:54:50 -0500
In-Reply-To: <1259054502-28284-2-git-send-email-monstr@monstr.eu>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: monstr@monstr.eu
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, grant.likely@secretlab.ca, john.williams@petalogix.com, stable@kernel.org, chrisw@sous-sol.org, greg@kroah.com, alonz@discretix.com

On Tuesday 24 November 2009 09:21:42 monstr@monstr.eu wrote:
> From: Michal Simek <monstr@monstr.eu>
> 
> Signed-off-by: Michal Simek <monstr@monstr.eu>

I was holding off on that patch to make sure the discussion had ended,
but this part certainly looks good.

Some points on form though:

* The patch is missing a changelog, which is always required, but especially
important if you're changing code that you want in -stable!

* You did not cc me. Ok, I just noticed I'm missing an entry in the MAINTAINERS
file, but scripts/get_maintainer.pl would have given you a good indication of
who feels responsible. You also didn't cc Alon, who submitted a similar patch
[1] just days ago, which I assume prompted you to send this. If you didn't see
his patch, nevermind.

* Patches go into mainline first, then into stable [2]. Asking for inclusion into
-stable for a patch that is still being discussed for inclusion in -next is
the wrong order, no matter how obvious and trivial the patch is.

Anyway, thanks for the patch. I'll follow up with a new version with a better
changelog for the tty tree. Any suggestions about what to do on 2.6.32?
Should it go in there now, or would this go into a -stable release since
it's not a regression?

Acked-by: Arnd Bergmann <arnd@arndb.de>

[1] http://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg39015.html
[2] http://lkml.indiana.edu/hypermail/linux/kernel/0504.3/1369.html

> ---
>  drivers/serial/of_serial.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/serial/of_serial.c b/drivers/serial/of_serial.c
> index 02406ba..b047c38 100644
> --- a/drivers/serial/of_serial.c
> +++ b/drivers/serial/of_serial.c
> @@ -161,6 +161,7 @@ static int of_platform_serial_remove(struct of_device *ofdev)
>  static struct of_device_id __devinitdata of_platform_serial_table[] = {
>  	{ .type = "serial", .compatible = "ns8250",   .data = (void *)PORT_8250, },
>  	{ .type = "serial", .compatible = "ns16450",  .data = (void *)PORT_16450, },
> +	{ .type = "serial", .compatible = "ns16550a",  .data = (void *)PORT_16550A, },
>  	{ .type = "serial", .compatible = "ns16550",  .data = (void *)PORT_16550, },
>  	{ .type = "serial", .compatible = "ns16750",  .data = (void *)PORT_16750, },
>  	{ .type = "serial", .compatible = "ns16850",  .data = (void *)PORT_16850, },
> 
