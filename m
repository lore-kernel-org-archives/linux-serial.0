From: Thomas Koeller <thomas.koeller@baslerweb.com>
Subject: Re: [PATCH] RM9000 serial driver
Date: Wed, 30 Aug 2006 23:16:42 +0200
Message-ID: <200608302316.43111.thomas.koeller@baslerweb.com>
References: <200608102318.52143.thomas.koeller@baslerweb.com> <44F441F3.8050301@ru.mvista.com> <20060829190426.GA20606@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail02.hansenet.de ([213.191.73.62]:18092 "EHLO
	webmail.hansenet.de") by vger.kernel.org with ESMTP id S932069AbWH3VRO
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 30 Aug 2006 17:17:14 -0400
In-Reply-To: <20060829190426.GA20606@flint.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>, linux-serial@vger.kernel.org, ralf@linux-mips.org, linux-mips@linux-mips.org, Thomas =?iso-8859-1?q?K=F6ller?= <thomas@koeller.dyndns.org>

On Tuesday 29 August 2006 21:04, Russell King wrote:
> It's worse than that - this code is there to read the ID from the divisor
> registers implemented in some UARTs.  If it isn't one of those UARTs, it's
> expected to return zero.
>
> So we don't actually want to be prodding some other random registers on
> differing UARTs.

For the  RM9000, DLL and DLM are located at distinct addresses, so these 
registers could be accessed without prior setting of DLAB. However, the
h/w docs say that DLAB has to be used nonetheless. I doubt that, but
wanted to play safe. So, in order to make this work, I had two options:

1. to monitor all register writes for setting/clearing of DLAB, and 
   switch the register mapping tables accordingly, or

2. implement serial_dl_read()/serial_dl_write() to directly access
   the registers, thus bypassing the mapping.

I decided to implement option #2, because it seemed less of a kludge.
Would you still say that this is an abuse?

Thomas
-- 
Thomas Koeller, Software Development

Basler Vision Technologies
An der Strusbek 60-62
22926 Ahrensburg
Germany

Tel +49 (4102) 463-390
Fax +49 (4102) 463-46390

mailto:thomas.koeller@baslerweb.com
http://www.baslerweb.com
