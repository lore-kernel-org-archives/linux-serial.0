From: "kees schoenmakers" <kees3328@gmail.com>
Subject: TIOCSERGETLSR
Date: Wed, 11 Apr 2007 15:33:10 +0200
Message-ID: <a754e89f0704110633m495d8fa3y433d925c6a0279c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.242]:37351 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752674AbXDKNdM (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 11 Apr 2007 09:33:12 -0400
Received: by an-out-0708.google.com with SMTP id b33so194166ana
        for <linux-serial@vger.kernel.org>; Wed, 11 Apr 2007 06:33:11 -0700 (PDT)
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi,

I have noticed difference in return "value" of ioctl(port,
TIOCSERGETLSR, &value) between different chips(hardware).
Kernel is Linux version 2.6.20.4 (root@pc_develop02.fluidwell.local)
(gcc version 4.1.2 20061115 (prerelease) (Debian 4.1.1-21)) #1 SMP
PREEMPT Fri Apr 6 13:41:02 CEST 2007 (build from source)
My mobo is from recent date and has an on-board serial port (ttyS0).
An extra PCI board with 2 serial ports is added:
07:00.0 Serial controller: NetMos Technology PCI 9835 Multi-I/O Controller (rev
01) (prog-if 02 [16550])
        Subsystem: LSI Logic / Symbios Logic 2S (16C550 UART)
        Flags: medium devsel, IRQ 21
        I/O ports at 1030 [size=8]
        I/O ports at 1028 [size=8]
        I/O ports at 1020 [size=8]
        I/O ports at 1018 [size=8]
        I/O ports at 1010 [size=8]
        I/O ports at 1000 [size=16]

My application uses a simplex modem connection over the low-speed
serial port, therefore I need to know for sure that all chararcters
have been written out before changing over from xmit to receive. I use
the TIOCSERGETLSR to check if this is the case. My problem is that for
the on board serial port the ioctl returns that situation OK but it is
wrong for the 9835 ports. There the TIOCSERGETLSR returns empty almost
after the first/second character is written which is not correct
(verified with scope). It may be a bug in the 9835 controller.  Do
others have similar findings?

please CC me as I am not on the list

Kees
