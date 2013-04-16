From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] tty: serial: ralink: fix SERIAL_8250_RT288X
 dependency
Date: Mon, 15 Apr 2013 21:08:30 -0700
Message-ID: <20130416040830.GB4907@kroah.com>
References: <1365845973-16164-1-git-send-email-blogic@openwrt.org>
 <20130415181527.GA25341@kroah.com>
 <516CCC26.5000504@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49]:54243 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000Ab3DPEIc (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 16 Apr 2013 00:08:32 -0400
Received: by mail-pb0-f49.google.com with SMTP id um15so57498pbc.8
        for <linux-serial@vger.kernel.org>; Mon, 15 Apr 2013 21:08:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <516CCC26.5000504@openwrt.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: John Crispin <blogic@openwrt.org>
Cc: linux-mips@linux-mips.org, linux-serial@vger.kernel.org

On Tue, Apr 16, 2013 at 05:57:26AM +0200, John Crispin wrote:
> On 15/04/13 20:15, Greg Kroah-Hartman wrote:
> >On Sat, Apr 13, 2013 at 11:39:32AM +0200, John Crispin wrote:
> >>With every Ralink SoC that we add, we would need to extend the dependency. In
> >>order to make life easier we make the symbol depend on MIPS&  RALINK and then
> >>select it from within arch/mips/ralink/.
> >>
> >>Signed-off-by: John Crispin<blogic@openwrt.org>
> >>---
> >>
> >>These 2 patches in this series should be merged via the mips tree. Patch 1/2
> >>requires an Ack from the tty maintainer.
> >>
> >>  drivers/tty/serial/8250/Kconfig |    4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >>diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
> >>index 80fe91e..24ea3c8 100644
> >>--- a/drivers/tty/serial/8250/Kconfig
> >>+++ b/drivers/tty/serial/8250/Kconfig
> >>@@ -295,8 +295,8 @@ config SERIAL_8250_EM
> >>  	  If unsure, say N.
> >>
> >>  config SERIAL_8250_RT288X
> >>-	bool "Ralink RT288x/RT305x/RT3662/RT3883 serial port support"
> >>-	depends on SERIAL_8250&&  (SOC_RT288X || SOC_RT305X || SOC_RT3883)
> >>+	bool
> >>+	depends on SERIAL_8250&&  MIPS&&  RALINK
> >
> >This patch doesn't create a select anywhere, so how can a user know what
> >to do here?
> >
> >greg k-h
> 
> Hi Greg,
> 
> The select happens in patch 2/2. i split it up as it touches a
> different subsystem. I can put both changes into the same patch.
> would that be acceptable ?

That would make more sense, don't you think?

greg k-h
