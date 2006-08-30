From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] RM9000 serial driver
Date: Wed, 30 Aug 2006 13:15:28 +0100
Message-ID: <20060830121528.GB25699@flint.arm.linux.org.uk>
References: <200608102318.52143.thomas.koeller@baslerweb.com> <200608220057.52213.thomas.koeller@baslerweb.com> <20060822095942.4663a4cd.yoichi_yuasa@tripeaks.co.jp> <200608260038.13662.thomas.koeller@baslerweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:52237 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750741AbWH3MPf (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 30 Aug 2006 08:15:35 -0400
Content-Disposition: inline
In-Reply-To: <200608260038.13662.thomas.koeller@baslerweb.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Thomas Koeller <thomas.koeller@baslerweb.com>
Cc: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>, sshtylyov@ru.mvista.com, linux-serial@vger.kernel.org, ralf@linux-mips.org, linux-mips@linux-mips.org

On Sat, Aug 26, 2006 at 12:38:13AM +0200, Thomas Koeller wrote:
> so far nobody commented on my recent mail, in which I explained why I
> think that the AU1X00 code in 8250.c is not entirely correct, so I assume
> nobody cares.

Or maybe your assumption is wrong.  You were referring to the port type
not being setup at autodetect time, and assuming that is used to define
the register mapping.  It isn't, so your premise for it being broken is
incorrect.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
