From: Roman Kurakin <rik@cronyx.ru>
Subject: Re: ST16C554 Serial device driver
Date: Tue, 21 Sep 2004 15:08:38 +0400
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <41500BB6.8050702@cronyx.ru>
References: <41500508.9010004@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from hanoi.cronyx.ru ([144.206.181.53]:22021 "EHLO hanoi.cronyx.ru")
	by vger.kernel.org with ESMTP id S267571AbUIULLP (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 21 Sep 2004 07:11:15 -0400
Received: (from root@localhost) by hanoi.cronyx.ru
  id i8LB84ri038775 for linux-serial@vger.kernel.org.checked; (8.12.8/vak/2.1)
  Tue, 21 Sep 2004 15:08:04 +0400 (MSD) (envelope-from rik@cronyx.ru)
In-Reply-To: <41500508.9010004@free.fr>
List-Id: linux-serial@vger.kernel.org
To: eric.valette@free.fr
Cc: rmk+serial@arm.linux.org.uk, linux-serial@vger.kernel.org

Hi,

    Try our driver, it is only wrapper for serial.c.
So you may see some hints in it.

http://www.cronyx.ru/~rik/omlinux_current.tgz

But I should warn you that current serial.c is buggy.
Our internal tests works fine with linux prior 2.6 and
FreeBSD both with our cards and com ports, but fails
with serial.c from 2.6.x. This fact enforce me to think
that driver is buggy, not test.

rik

Eric Valette wrote:

> Hi,
>
> Sorry to annoy you with one small question : I'm currently working as a
> contractor to port an application from LynxOS to linux 2.6 and I'm
> annoyed with the serial driver code. I need to find a driver for a 
> ST16C554 quad serial ISA board. I've tried to use setserial with the 
> relevant IO ports and irq but cannot manage to output annything on the 
> PC 104 board.
>
> The setting multiplex the same IRQ (10) for the four ports. Do you have
> any hint, advice.
>
> Thanks for your help,
>
>



