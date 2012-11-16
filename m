From: Lokesh <v.lokesh@live.com>
Subject: Need to remove ch35x wch driver which already running
Date: Fri, 16 Nov 2012 07:59:22 +0000 (UTC)
Message-ID: <loom.20121116T085450-158@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:49777 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750817Ab2KPIt6 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 16 Nov 2012 03:49:58 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1TZHci-0001WD-9J
	for linux-serial@vger.kernel.org; Fri, 16 Nov 2012 09:50:04 +0100
Received: from 117.192.141.203 ([117.192.141.203])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Fri, 16 Nov 2012 09:50:04 +0100
Received: from v.lokesh by 117.192.141.203 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Fri, 16 Nov 2012 09:50:04 +0100
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

HI

I have a pci base serial card i.e wch35x card. for 3.0.5, the driver does not
exisits. Iam redeveloping for the same from scratch. But due mis detection, the
pci card claims a driver named "serial".

The lspci -k dispaly driver in use as serial. but in lsmod it does not lists.

I want to remove the serial module which is claiming this device. so that is i
can re write the driver just for learning purpose.

02:00.0 Serial controller: Device 4348:5046 (rev 10) (prog-if 02 [16550])
	Subsystem: Device 4348:5046
	Flags: medium devsel, IRQ 21
	I/O ports at d030 [size=8]
	I/O ports at d020 [size=8]
	I/O ports at d010 [size=8]
	I/O ports at d000 [size=16]
	Kernel driver in use: serial
00: 48 43 46 50 01 00 00 02 10 02 00 07 00 00 00 00
10: 31 d0 00 00 21 d0 00 00 11 d0 00 00 01 d0 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 48 43 46 50
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 00 00



