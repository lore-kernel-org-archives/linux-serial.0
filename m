From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: tcdrain / TCSBRK / wait_until_sent delay
Date: Mon, 9 May 2005 09:59:03 +0100
Message-ID: <20050509095903.A5674@flint.arm.linux.org.uk>
References: <200505071035.55508.andyparkins@gmail.com> <000a01c5546f$57d83f60$2e01a8c0@acksys.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:39951 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261160AbVEII7M (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 9 May 2005 04:59:12 -0400
Content-Disposition: inline
In-Reply-To: <000a01c5546f$57d83f60$2e01a8c0@acksys.fr>; from jp.tosoni@acksys.fr on Mon, May 09, 2005 at 10:16:03AM +0200
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tosoni <jp.tosoni@acksys.fr>
Cc: 'Andy Parkins' <andyparkins@gmail.com>, linux-serial@vger.kernel.org

On Mon, May 09, 2005 at 10:16:03AM +0200, Tosoni wrote:
> - Then Mr Russel King suggested to redesign a complete "line discipline"

Please do me the reasonable curtesy of spelling my name correctly.

> just to handle the missing RTS feature. I must note that such "line
> discipline" would duplicate completely the existing default line discipline
> except for the RTS_TOGGLE ioctl.

Interestingly, I've reviewed our discussions back in December, and
they aren't exactly how you recollect them to be.  I gave you the
historical position, and suggested both a possible way forward and
someone else for you to talk to about this.

It also appears that you continued to press for _your_ original
implementation, justifying it against the historical position (both
of which I'd already suggested weren't suitable.)

Maybe I didn't explain clearly enough why your implementation wasn't
suitable.  Adding an IOCTL for RS485 RTS style vs conventional RTS
style causes problems.  Consider what happens when:

1. we get a third (and there are more than two) flow control styles.
2. the port is closed and something else opens it which wants standard
   flow control. (or even an overlapping open/close.)

I have also suggested to a third party about adding a feature by which
the flow control method could be changed between several different
settings, preferably via the existing control implmentation - termios.
This should resolve both of the above.

Unfortunately, that also went by un-noticed and as such hasn't progressed.

Therefore, there has been no progress on different flow control styles.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
