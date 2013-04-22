From: "Jongsung Kim" <neidhard.kim@lge.com>
Subject: RE: [RESEND][PATCH] ARM: PL011: add support for extended FIFO-size	of PL011-r1p5
Date: Mon, 22 Apr 2013 11:24:18 +0900
Message-ID: <019701ce3f00$7e0c5390$7a24fab0$@lge.com>
References: <201304151445.25151.neidhard.kim@lge.com> <20130419141748.GU14496@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from LGEMRELSE6Q.lge.com ([156.147.1.121]:49585 "EHLO
	LGEMRELSE6Q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753904Ab3DVCYX (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 21 Apr 2013 22:24:23 -0400
In-Reply-To: <20130419141748.GU14496@n2100.arm.linux.org.uk>
Content-Language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Russell King - ARM Linux' <linux@arm.linux.org.uk>
Cc: gregkh@linuxfoundation.org, jslaby@suse.cz, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

Thank you for your comments, Russell. I'll happily apply your recommendation
just after it come up to the merge window. Or, do you want me to send it by now?

-----Original Message-----
From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk] 
Sent: Friday, April 19, 2013 11:18 PM
To: Jongsung Kim
Cc: gregkh@linuxfoundation.org; jslaby@suse.cz; linux-serial@vger.kernel.org;
linux-kernel@vger.kernel.org
Subject: Re: [RESEND][PATCH] ARM: PL011: add support for extended FIFO-size of
PL011-r1p5

On Mon, Apr 15, 2013 at 02:45:25PM +0900, Jongsung Kim wrote:
> The latest r1p5-revision of the ARM PL011 UART has 32-byte FIFOs,
> while all earlier ones have 16-byte FIFOs. This patch suggests
> a way to set the FIFO-size correctly & flexibly by using a member
> function named get_fifosize, rather than using the fifosize member
> variable. The function takes the UARTPeriphID, and returns the
> correct FIFO size.

Same comments as previous version.

