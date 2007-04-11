From: "Stuart MacDonald" <stuartm@connecttech.com>
Subject: RE: TIOCSERGETLSR
Date: Wed, 11 Apr 2007 10:11:52 -0400
Message-ID: <063201c77c43$5aeb1f80$294b82ce@stuartm>
References: <a754e89f0704110633m495d8fa3y433d925c6a0279c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from inetc.connecttech.com ([64.7.140.42]:4868 "EHLO
	inetc.connecttech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752852AbXDKOaX (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 11 Apr 2007 10:30:23 -0400
In-Reply-To: <a754e89f0704110633m495d8fa3y433d925c6a0279c0@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'kees schoenmakers' <kees3328@gmail.com>, linux-serial@vger.kernel.org

From: On Behalf Of kees schoenmakers
> I have noticed difference in return "value" of ioctl(port,
> TIOCSERGETLSR, &value) between different chips(hardware).
> Kernel is Linux version 2.6.20.4 (root@pc_develop02.fluidwell.local)
> (gcc version 4.1.2 20061115 (prerelease) (Debian 4.1.1-21)) #1 SMP
> PREEMPT Fri Apr 6 13:41:02 CEST 2007 (build from source)
> My mobo is from recent date and has an on-board serial port (ttyS0).
> An extra PCI board with 2 serial ports is added:
> 07:00.0 Serial controller: NetMos Technology PCI 9835 
> Multi-I/O Controller (rev 01) (prog-if 02 [16550])

If this
http://www.moschip.com/html/MCS9835.html
is your board, the data sheet is
http://www.moschip.com/data/products/NM9835/Data%20Sheet_9835.pdf

I looked it over quickly. The UART is contained within a chip they
make. The LSR looks good from the documentation. **

> My application uses a simplex modem connection over the low-speed
> serial port, therefore I need to know for sure that all chararcters
> have been written out before changing over from xmit to receive. I use
> the TIOCSERGETLSR to check if this is the case. My problem is that for
> the on board serial port the ioctl returns that situation OK but it is
> wrong for the 9835 ports. There the TIOCSERGETLSR returns empty almost
> after the first/second character is written which is not correct
> (verified with scope). It may be a bug in the 9835 controller.  Do
> others have similar findings?

** I don't have one of these boards, but I'm suspecting a hardware
error as well, based on your description. (I'm assuming that you do
see the proper bits go high briefly, and then go off too quickly.)

I'd try contacting the OEM or Moschip.

..Stu

-- 
We make multiport serial products.
http://www.connecttech.com/
(800) 426-8979

