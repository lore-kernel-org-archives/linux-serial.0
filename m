From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: Add new ASYNC_SPD_WARP13?
Date: Wed, 6 Apr 2011 17:14:16 +0000 (UTC)
Message-ID: <ini718$hfj$1@dough.gmane.org>
References: <ini5hh$7s3$1@dough.gmane.org>
 <20110406175350.64bd2f23@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:44690 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754587Ab1DFROb (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 6 Apr 2011 13:14:31 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1Q7WJK-0006MA-0y
	for linux-serial@vger.kernel.org; Wed, 06 Apr 2011 19:14:30 +0200
Received: from dsl.comtrol.com ([64.122.56.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Wed, 06 Apr 2011 19:14:30 +0200
Received: from grant.b.edwards by dsl.comtrol.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Wed, 06 Apr 2011 19:14:30 +0200
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On 2011-04-06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> The ASYNC_SPD_xxxx mechanism is obsolete. Just set the baud rate to
> 921600, the kernel has supported arbitary baud rates for some time.

This raises a question I've been wondering about for some time.  While
the kernel and the serial driver API support arbitrary baud rates,
termios doesn't AFAICT.

How does one use the standard POSIX serial port API to obtain an
abritrary baud rate?

The only way I can find to get arbitrary baud rates from a user
perspective is to use the ASYNC_SPD_xxxx mechanism.

-- 
Grant Edwards               grant.b.edwards        Yow! Catsup and Mustard all
                                  at               over the place!  It's the
                              gmail.com            Human Hamburger!

