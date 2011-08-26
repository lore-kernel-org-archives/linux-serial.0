From: Jamie Iles <jamie@jamieiles.com>
Subject: Re: [PATCH] tty: add a DesignWare 8250 driver
Date: Fri, 26 Aug 2011 17:20:21 +0100
Message-ID: <20110826162021.GC2802@pulham.picochip.com>
References: <1314368925-13097-1-git-send-email-jamie@jamieiles.com>
 <201108261804.02784.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:38984 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754862Ab1HZQUw (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 26 Aug 2011 12:20:52 -0400
Received: by wwf5 with SMTP id 5so3675218wwf.1
        for <linux-serial@vger.kernel.org>; Fri, 26 Aug 2011 09:20:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201108261804.02784.arnd@arndb.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jamie Iles <jamie@jamieiles.com>, linux-serial@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@suse.de>

On Fri, Aug 26, 2011 at 06:04:02PM +0200, Arnd Bergmann wrote:
> On Friday 26 August 2011, Jamie Iles wrote:
> > The Synopsys DesignWare 8250 is an 8250 that has an extra interrupt that
> > gets raised when writing to the LCR when busy.  To handle this we need
> > special serial_out, serial_in and handle_irq methods.  Add a new
> > platform driver that uses these accessors.
> > 
> > Cc: Alan Cox <alan@linux.intel.com>
> > Cc: Greg Kroah-Hartman <gregkh@suse.de>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Jamie Iles <jamie@jamieiles.com>
> 
> The driver looks good to me,
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> Is the patch to export serial8250_handle_irq already in Greg's tree or is that
> still missing?

No, and I really don't know how I missed it.  I was sure an allmodconfig 
build worked, but perhaps 8250_dw wasn't selected.  Anyhow, here's the 
patch that does that.

Apologies again for making such a mess out of this series!

Thanks,

Jamie

8<---

From: Jamie Iles <jamie@jamieiles.com>
Subject: [PATCH] tty: 8250: export serial8250_handle_irq

Allow modules to use the normal 8250 irq handler inside their own.

Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 drivers/tty/serial/8250.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/8250.c b/drivers/tty/serial/8250.c
index 6f594d2..435ce14 100644
--- a/drivers/tty/serial/8250.c
+++ b/drivers/tty/serial/8250.c
@@ -1588,6 +1588,7 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(serial8250_handle_irq);
 
 static int serial8250_default_handle_irq(struct uart_port *port)
 {
-- 
1.7.4.1

