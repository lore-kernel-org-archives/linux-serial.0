From: "Tosoni" <jp.tosoni@acksys.fr>
Subject: RE: tcdrain / TCSBRK / wait_until_sent delay
Date: Mon, 9 May 2005 10:16:03 +0200
Message-ID: <000a01c5546f$57d83f60$2e01a8c0@acksys.fr>
References: <200505071035.55508.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp7.clb.oleane.net ([213.56.31.27]:51341 "EHLO
	smtp7.clb.oleane.net") by vger.kernel.org with ESMTP
	id S261305AbVEIIQ2 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 9 May 2005 04:16:28 -0400
In-Reply-To: <200505071035.55508.andyparkins@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Andy Parkins' <andyparkins@gmail.com>
Cc: linux-serial@vger.kernel.org, rmk+lkml@arm.linux.org.uk

> I appreciate that, I was disappointed because I know
> that some other people are doing this on Windows and
> I assumed Linux would be able to kick a**.
> Considering the magic that Linux can do elsewhere, it
> didn't seem unreasonable to expect 9600 half duplex.  :-(

Hi,

I have the same problem and here is where I am:

- Windows can handle this because it has a RTS mode ioctl called
"RTS_TOGGLE" which sounds perfectly OK for your use (and mine).

- Historically UNIX did not implement such ioctl, and so did (not) LINUX.

- I suggested last year to create such ioctl in LINUX.

- Mr Russell King answered me that the good way to do this is to handle it
in the user space application, which is obviously flawed and results in the
delays you see because of user-space time-sharing granularity.

- Then Mr Russel King suggested to redesign a complete "line discipline"
just to handle the missing RTS feature. I must note that such "line
discipline" would duplicate completely the existing default line discipline
except for the RTS_TOGGLE ioctl.

- So I implemented the RTS_TOGGLE for myself in the serial driver, but my
(small, non-intrusive) patch would not be accepted in the standard serial
driver.

Well, if you use the Oxford 16C95x chip, I can provide you with a patched
driver for kernel 2.6.10. Or I can sell you my own RS485 card with drivers
(we are manufacturers - www.acksys.fr)

I wish linux people would accept to add such ioctl in the standard serial
API. Even if it is not immediately implemented in the serial drivers, it
would give a standard path for anyone wishing to implement it. I am sure
many people miss it in a time where LINUX is used more and more in
industrial appliance.

Jean-Pierre Tosoni
ACKSYS


