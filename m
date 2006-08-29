From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] RM9000 serial driver
Date: Tue, 29 Aug 2006 19:14:37 +0400
Message-ID: <44F459DD.8060902@ru.mvista.com>
References: <200608102318.52143.thomas.koeller@baslerweb.com> <200608220057.52213.thomas.koeller@baslerweb.com> <20060822095942.4663a4cd.yoichi_yuasa@tripeaks.co.jp> <200608222227.20181.thomas.koeller@baslerweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:2219 "EHLO
	imap.sh.mvista.com") by vger.kernel.org with ESMTP id S965018AbWH2PNc
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 29 Aug 2006 11:13:32 -0400
In-Reply-To: <200608222227.20181.thomas.koeller@baslerweb.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Thomas Koeller <thomas.koeller@baslerweb.com>
Cc: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>, rmk+serial@arm.linux.org.uk, linux-serial@vger.kernel.org, ralf@linux-mips.org, linux-mips@linux-mips.org, =?ISO-8859-1?Q?Thomas_?= =?ISO-8859-1?Q?K=F6ller?= <thomas@koeller.dyndns.org>

Hello.

Thomas Koeller wrote:

>>If you have an another standard 8250 port. this driver cannot support it
>>You should do as well as AU1X00.

> The AU1X00 code obviously assumes that every port that is not an AU1X00 is
> a standard port requiring no register mapping. However, this is of course
> not necessarily true in the most general case. There could be platforms
> with multiple ports, all non-standard, but in different ways. Handling this

    The key word here is *could*. So far, this case is purely speculative. The 
"half-compatible" UARTs seem to only reside in some SOCs for which case the 
current scheme is still adequate.
    I think I understand why such "half- compatible" hardware has appeared at 
all -- the weird 8250 addressing scheme with several registers mapped to the 
single address may be hard to implement...

> would require per-port mapping functions, which could be achieved by adding
> function pointers to struct uart_8250_port. However, this would add the
> overhead of a real, non-inlined function call to every register access.

> Also, it seems to me that the whole register-mapping stuff conflicts with
> autodetection, because autoconfig() uses serial_inp() and serial_outp()
> before the port types, and hence the mapping requirements, are known.

    Port types have nothing to do with this. Or at least they hadn't until 
your recent patch. :-)
    iotype was used to identify the addressing scheme, and it's alsready known 
beforehand.

> This is not a problem for me, however, since the correct port type is
> set up by the platform using early_serial_setup().

    There actually may be some other (and more valid than your case :-) issues 
preventing autoconfure from use with SOC UARTs. I guess autoconfigure code 
wan't intended for the case of SOC chips -- their UARTs' charactarestics are 
usually known beforehand, and the correct PORT_* might be pre-set by the 
platform setup code.

WBR, Sergei

