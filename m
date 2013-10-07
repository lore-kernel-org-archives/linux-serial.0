From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: Commit f7d2c0bb (serial: i.MX: evaluate linux,stdout-path
 property) and resulting build errors
Date: Mon, 7 Oct 2013 08:49:32 +0200
Message-ID: <20131007064932.GU30088@pengutronix.de>
References: <20131003045611.GA17921@roeck-us.net>
 <20131003184445.GH8901@kroah.com>
 <20131006110956.GM30088@pengutronix.de>
 <20131006143743.GA23787@roeck-us.net>
 <20131006191546.GA27140@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41937 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752676Ab3JGGth (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 7 Oct 2013 02:49:37 -0400
Content-Disposition: inline
In-Reply-To: <20131006191546.GA27140@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Fabio Estevam <fabio.estevam@freescale.com>

On Sun, Oct 06, 2013 at 12:15:46PM -0700, Greg Kroah-Hartman wrote:
> On Sun, Oct 06, 2013 at 07:37:43AM -0700, Guenter Roeck wrote:
> > On Sun, Oct 06, 2013 at 01:09:56PM +0200, Sascha Hauer wrote:
> > > On Thu, Oct 03, 2013 at 11:44:45AM -0700, Greg Kroah-Hartman wrote:
> > > > On Wed, Oct 02, 2013 at 09:56:11PM -0700, Guenter Roeck wrote:
> > > > > Hi all,
> > > > > 
> > > > > Commit f7d2c0bbdb (serial: i.MX: evaluate linux,stdout-path property) adds a
> > > > > call to add_preferred_console() into drivers/tty/serial/imx.c. The file can be
> > > > > built as module, yet add_preferred_console() is not exported on any platform.
> > > > > This is one reason why arm:allmodconfig fails to build on the upstream kernel.
> > > > > 
> > > > > What is the best solution ? Should imx.c not be buildable as module anymore ?
> > > > 
> > > > Sascha, I'll have to revert this patch unless you wish to fix it in a
> > > > different way?
> > > 
> > > Do you think exporting add_preferred_console() would be acceptable? If
> > > yes, that would be my preferred solution.
> > > 
> > Difficult to imagine that a console driver can be a loadable module.
> > Unload it while the system is running and then what ?
> 
> Ah man, you spoiled the punch line I was setting Sascha up for!  :)

I can hardly feel that punch as I'm just about to leave town for
vacation ;)

> 
> > Why does this driver have to be buildable as module anyway ? If that is really
> > a MUST, an alternative might be to only call add_preferred_console() if it is not
> > built as module.
> 
> Yes, that's the correct solution, _if_ this has to be a module.

I don't think it has to be buildable as module. I attached a patch
disabling module build.

Fabio, I'm not available until the beginning of next week. Could you
keep an eye on this?

Thanks
  Sascha

8<---------------------------------------------------------

>From 66197e3bd3d1f4000a637e6960c340d7aa0ccf1f Mon Sep 17 00:00:00 2001
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Mon, 7 Oct 2013 08:46:46 +0200
Subject: [PATCH] serial: i.MX: do not allow to build as module

Commit f7d2c0bbdb (serial: i.MX: evaluate linux,stdout-path property) adds a
call to add_preferred_console() into drivers/tty/serial/imx.c. The file can be
built as module, yet add_preferred_console() is not exported.

Fix the build failure by disabling module build for the i.MX driver.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/tty/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index febd45c..b8c5f36 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -551,7 +551,7 @@ config BFIN_UART3_CTSRTS
 	  Enable hardware flow control in the driver.
 
 config SERIAL_IMX
-	tristate "IMX serial port support"
+	boot "IMX serial port support"
 	depends on ARCH_MXC
 	select SERIAL_CORE
 	select RATIONAL
-- 
1.8.4.rc3

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
