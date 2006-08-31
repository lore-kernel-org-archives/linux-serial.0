From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] RM9000 serial driver
Date: Thu, 31 Aug 2006 11:24:55 +0400
Message-ID: <44F68EC7.5080205@ru.mvista.com>
References: <200608102318.52143.thomas.koeller@baslerweb.com> <200608300100.32836.thomas.koeller@baslerweb.com> <20060830121216.GA25699@flint.arm.linux.org.uk> <200608302328.47944.thomas.koeller@baslerweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:50155 "EHLO
	imap.sh.mvista.com") by vger.kernel.org with ESMTP id S1751044AbWHaHXz
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 31 Aug 2006 03:23:55 -0400
In-Reply-To: <200608302328.47944.thomas.koeller@baslerweb.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Thomas Koeller <thomas.koeller@baslerweb.com>
Cc: Russell King <rmk@arm.linux.org.uk>, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>, linux-serial@vger.kernel.org, ralf@linux-mips.org, linux-mips@linux-mips.org, =?ISO-8859-1?Q?Thomas_K=F6ller?= <thomas@koeller.dyndns.org>

Hello.

Thomas Koeller wrote:

>>iotype is all about the access method used to access the registers of
>>the device, be it by byte or word, and it also takes account of any
>>variance in the addressing of the registers.

>>It does not refer to features or bugs in any particular implementation.

> That's what I assumed, too - it seemed obvious. And it seemed equally
> obvious that it is the port type that encodes the the implementation's
> peculiarities. Among these are the register offset mapping requirements,
> so I assumed these should depend on the port type as well.

    Different mapping requirements actually put the device beyond 8250 
compatibility, so it seems quite natural they're addressed by the different 
entity.
    RM9000 UART is, strictly speaking, *not* 8250 compatible and needs some 
trickery for the 8250 driver to support it (historically, Alchemy UARTs were 
driven by the distinct driver, au1x00_uart.c -- however, its code was for the 
most part copied over from 8250.c).

> Now Sergei strongly insist that it's the iotype that should be checked
> whenever to get to the hardware type. I still do not quite understand how
> that is supposed to work. If I have a PCI device, for example, then the
> iotype will always be either UPIO_MEM or UPIO_PORT, so how could I learn
> something about the hardware implementation by looking at these values?

    I think it's determined by the value of the programming interface register 
of the PCI device. The values 0 to 6 imply full backward compatibility to 8250 
WRT the addressing scheme, IIUC.

> Or is the assumption that devices on a standard bus will always be of
> a standard type?

    For the PCI bus, it is.

> Thomas

WBR, Sergei

