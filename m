From: Christer Weinigel <christer@weinigel.se>
Subject: Re: tcdrain / TCSBRK / wait_until_sent delay
Date: 09 May 2005 11:22:08 +0200
Message-ID: <m37ji8lpof.fsf@zoo.weinigel.se>
References: <200505051650.38471.andyparkins@gmail.com>
	<m3br7klpz4.fsf@zoo.weinigel.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from 2-1-3-15a.ens.sth.bostream.se ([82.182.31.214]:59561 "EHLO
	zoo.weinigel.se") by vger.kernel.org with ESMTP id S261154AbVEIJWJ
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 9 May 2005 05:22:09 -0400
In-Reply-To: <m3br7klpz4.fsf@zoo.weinigel.se>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Christer Weinigel <christer@weinigel.se>
Cc: Andy Parkins <andyparkins@gmail.com>, linux-serial@vger.kernel.org

Christer Weinigel <christer@weinigel.se> writes:

>     do {
>         ioctl(fd, TIOCSERGETLSR, &lsr);
>     } while (lsr & TIOCSER_TEMT);

Should be !(lsr & TIOCSER_TEMT), since the bit set means that the
transmitter is empty.

Note to self.  _Always_ check posted code one extra time.  :-/

  /Christer
 
-- 
"Just how much can I get away with and still go to heaven?"

Freelance consultant specializing in device driver programming for Linux 
Christer Weinigel <christer@weinigel.se>  http://www.weinigel.se
