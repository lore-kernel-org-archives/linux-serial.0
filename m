From: Aras Vaichas <aras.vaichas@gmail.com>
Subject: can't detect 16550A at port 0x010 on Vortex86dx board
Date: Fri, 6 Jul 2012 22:00:23 +0100
Message-ID: <CAJkQPOm_TpNp6Y=rx0x9EtH1zvvwOb5JAo7Z+45BKRQPru-4ZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:43557 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755224Ab2GFVBE (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 6 Jul 2012 17:01:04 -0400
Received: by qaas11 with SMTP id s11so672837qaa.19
        for <linux-serial@vger.kernel.org>; Fri, 06 Jul 2012 14:01:04 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

I've got a board based on the Vortex86DX CPU which is an x86 based
microcontroller. It has five 16550A UARTS, four (COM1-COM4) of which
are at the usual i/o port addresses (0x3f8, 0x2f8, 0x3e8, 0x2e8) but
the fifth (COM9) is at 0x010, irq 9.

http://www.dmp.com.tw/tech/vortex86dx/

The problem is that I can't get the fifth one (COM9) to work in Linux.
COM9 works correctly in a stand-alone DOS application when accessed at
i/o port 0x010, but I can't even detect it from Linux.

What I've done so far:

* added COM9 to /drivers/tty/serial/8250/  (hacked existing driver to
probe at 0x010)

* enabled DEBUG_AUTOCONF in /drivers/tty/serial/8250/8250.c so I can
see when and which addresses are being probed.

* editted /arch/x86/kernel/setup.c because i/o port 0x010 overlapped
an existing region reserved for dma1 which caused request_region() to
fail. Datasheet for CPU confirmed different reserved i/o port regions.

Result: the kernel failed to probe the UART at address 0x010 with the
error "IER test failed".

I used an i/o port probing utility to manually read/write port 0x010
but I could not detect any 16550A registers in the 0x010 to 0x017
region. It appears there is nothing there. I tried to write and read
back data from the scratch register (offset +7), but it did nothing.
My same tests pass on the other four UART addresses.

The datasheet for the CPU doesn't say much about COM9.
ftp://ftp.dmp.com.tw/DMP_Vortex86_Series_Software_Programming_Reference_091216.pdf

On page 156 it mentions an "On-Chip Device Control Register" on the
Southbridge which has a bit for doing "something" with COM9, but it
doesn't say what it does. AFAIK the DOS application does not configure
the Southbridge.

I wrote a utility to read and write the Southbridge registers but I
still failed to detect the UART.

Am I on the right path?

What else should I try?

Would Linux block my ability to manually probe these i/o ports?

thanks,

Aras Vaichas
