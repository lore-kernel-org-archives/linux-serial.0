From: Chris Budd <budorola@gmail.com>
Subject: Re: 2.4.21: Sharing interrupts with serial console
Date: Thu, 4 Aug 2005 07:29:06 -0700
Message-ID: <92fc8b8105080407297d8ced80@mail.gmail.com>
References: <92fc8b8105080318367f77fed1@mail.gmail.com>
	 <20050804085440.A22910@flint.arm.linux.org.uk>
Reply-To: Chris Budd <budorola@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.201]:25445 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262128AbVHDO3I convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 4 Aug 2005 10:29:08 -0400
Received: by zproxy.gmail.com with SMTP id r28so237693nza
        for <linux-serial@vger.kernel.org>; Thu, 04 Aug 2005 07:29:06 -0700 (PDT)
In-Reply-To: <20050804085440.A22910@flint.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Chris Budd <budorola@gmail.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On 8/4/05, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> On Wed, Aug 03, 2005 at 06:36:51PM -0700, Chris Budd wrote:
> > 1.  The rs_init function in ./linux-2.4.21/drivers/char/serial.c
> > explicitly states "The interrupt of the serial console port can't be
> > shared."  Does this include *ALL* interrupts?  The code checks for
> > sharing only with other serial devices, not *ALL* types of devices
> > like I2C, RTC, etc.
<snip>
> > 2.  While the presence of the comment about not sharing was nice, it
> > does not explain "why?"
> 
> Connecting a level-active interrupt output to an edge-triggered
> interrupt controller input is Bad News(tm) for missing interrupts.
> 

Of course.  I thought it was something more serious in the bowels of
the kernel.  All the comment needed was just that one adjective "The
*edge-triggered* interrupt of the serial console port can't be
shared."  I know many programmers do not like to write comments, but
good comments make the code more robust and stable:  the code clearly
shows *what* you did, but comments are necessary to indicate *why*.

<snip>
> If your Intel hardware doesn't have level triggered input capabilities,
> please apply customer pressure to Intel to ensure that they consider it
> for their future ARM-based designs.

You will be happy to know that the Intel IOP80321 has level-sensitive
interrupts.

Thank you for the detailed explanation.
Chris.
