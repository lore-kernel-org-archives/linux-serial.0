From: ael <law_ence.dev@ntlworld.com>
Subject: Regression: 8250 with 2.6.24
Date: Fri, 08 Feb 2008 18:29:08 +0000
Message-ID: <foi71k$pem$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:56546 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757121AbYBHWaG (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 8 Feb 2008 17:30:06 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1JNbjO-0002Vb-HG
	for linux-serial@vger.kernel.org; Fri, 08 Feb 2008 22:30:02 +0000
Received: from cpc2-oxfd6-0-0-cust55.oxfd.cable.ntl.com ([86.3.132.56])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Fri, 08 Feb 2008 22:30:02 +0000
Received: from law_ence.dev by cpc2-oxfd6-0-0-cust55.oxfd.cable.ntl.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Fri, 08 Feb 2008 22:30:02 +0000
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Legacy i386 system with Intel 440BX chip set:
------------------------------------------------------------------------
# lspci
00:00.0 Host bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX Host
bridge (rev 02)
00:01.0 PCI bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX AGP
bridge (rev 02)
00:07.0 ISA bridge: Intel Corporation 82371AB/EB/MB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corporation 82371AB/EB/MB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corporation 82371AB/EB/MB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ACPI (rev 02)
00:08.0 SCSI storage controller: Adaptec AHA-2940U/UW/D / AIC-7881U (rev 01)
00:0a.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 20)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200 AGP
(rev 01)
----------------------------------------------------------------------

Moving from 2.6.23.14 to 2.6.24, the /dev/ttyS* are incorrectly created:-

In /var/log/messages:-
----------------------------------------------------------------------
Feb  4 17:01:54 conquest3 kernel: serial8250: ttyS0 at I/O 0x3f8 (irq =
4) is a 16550A
Feb  4 17:01:54 conquest3 kernel: serial8250: ttyS1 at I/O 0x2f8 (irq =
3) is a 16550A
Feb  4 17:01:54 conquest3 kernel: 00:0c: ttyS0 at I/O 0x3f8 (irq = 4) is
a 16550A
Feb  4 17:01:54 conquest3 kernel: 00:0f: ttyS1 at I/O 0x2f8 (irq = 3) is
a 16550A
------------------------------------------------------------------------
[which is correct.]

However:-
#  ls -l /sys/devices/platform/serial8250/tty/
total 0
drwxr-xr-x 3 root root 0 Feb  8 18:22 ttyS2
drwxr-xr-x 3 root root 0 Feb  8 18:22 ttyS3
[which is incorrect.]

udev then creates the wrong devices:-
# ls -l /dev/ttyS*
crw-rw---- 1 root dialout 4, 66 Feb  8 18:03 /dev/ttyS2
crw-rw---- 1 root dialout 4, 67 Feb  8 18:03 /dev/ttyS3

Accessing those nodes gives errors:

# statserial /dev/ttyS3
statserial: TIOCMGET failed: Input/output error

Complications:
--------------

1) This is non deterministic: very rarely all four devices appear:
ttyS0,ttyS1, ttyS2 and ttyS3. Accessing ttyS0 and ttys1 then works
correctly.

2) 2.6.23.14 (and probably earlier kernels) also generated 4 devices,
and rarely had a similar problem - but I can't recall exact details.
Thus the bug might have been around for a longish period with some sort
of race triggered almost always in 2.6.24.
-------------------------------------------------------------------------

Anyone throw any light on this?

ael




