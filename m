From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: Bug?: 2.6.9-bk3
Date: Wed, 20 Oct 2004 08:59:18 +0100
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20041020085918.B1047@flint.arm.linux.org.uk>
References: <4175C484.5070009@tuxq.com> <1098240366.5963.21.camel@at2.pipehead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:41222 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S270197AbUJTH73 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 20 Oct 2004 03:59:29 -0400
Content-Disposition: inline
In-Reply-To: <1098240366.5963.21.camel@at2.pipehead.org>; from paulkf@microgate.com on Tue, Oct 19, 2004 at 09:46:06PM -0500
List-Id: linux-serial@vger.kernel.org
To: Paul Fulghum <paulkf@microgate.com>
Cc: "Steven E. Woolard" <tuxq@tuxq.com>, linux-serial@vger.kernel.org, Linux Kernel list <linux-kernel@vger.kernel.org>

On Tue, Oct 19, 2004 at 09:46:06PM -0500, Paul Fulghum wrote:
> On Tue, 2004-10-19 at 20:51, Steven E. Woolard wrote:
> > I ran into this problem when trying to compile 2.6.9-bk3 (since it came 
> > out less than 24 hours after 2.6.9 ... bad omen eh?)
> > I've attached my .config used just incase it helps. (New to bug 
> > reporting...)
> > ...
> >    CC      drivers/serial/8250.o
> > drivers/serial/8250.c:185: error: `UART_FCR_R_TRIG_10' undeclared here 
> > (not in a function)
> 
> Russell's patch introduces the use of
> the UART_FCR_x_TRIG_xx macros, but not
> the definition.

And the fix has been posted on this very mailing list shortly after the
problem code was merged:

  Subject: [PATCH] Fix serial breakage in -bk3
  Date:   Tue, 19 Oct 2004 23:47:16 +0100
  Message-ID: <20041019234716.D20243@flint.arm.linux.org.uk>


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
