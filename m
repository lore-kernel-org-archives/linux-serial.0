From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Linux 2.5.30: [SERIAL] build fails at 8250.c
Date: Sat, 3 Aug 2002 09:05:23 +0100
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20020803090523.A22424@flint.arm.linux.org.uk>
References: <200208030020.RAA05695@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200208030020.RAA05695@baldur.yggdrasil.com>; from adam@yggdrasil.com on Fri, Aug 02, 2002 at 05:20:28PM -0700
List-Id: linux-serial@vger.kernel.org
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: axel@hh59.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, tytso@mit.edu

On Fri, Aug 02, 2002 at 05:20:28PM -0700, Adam J. Richter wrote:
> On Sat, 3 Aug 2002 01:12:10 +0100, Russell King wrote:
> >Ok, here's a fix for the 8250.c build problem (please don't send it
> >to Linus; I've other changes that'll be going via BK and patch to
> >lkml pending):
> >
> >--- orig/drivers/serial/8250.c  Fri Aug  2 21:13:31 2002
> >+++ linux/drivers/serial/8250.c Sat Aug  3 00:28:47 2002
> >@@ -31,7 +31,8 @@
> > #include <linux/console.h>
> > #include <linux/sysrq.h>
> > #include <linux/serial_reg.h>
> >-#include <linux/serialP.h>
> >+#include <linux/circ_buf.h>
> >+#include <linux/serial.h>
> > #include <linux/delay.h>
> > 
> > #include <asm/io.h>
> 
> 	Your patch still results in a compilation error for me.
> It looks like 8250.c needs <linux/serialP.h> for ALPHA_KLUDGE_MCR:

Your quote above didn't include the patch for 8250.h which was in my
mail directly after 8250.c.  Did you specifically miss it for a reason?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

