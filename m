From: Guenter Gebhardt <g.gebhardt@meilhaus.de>
Subject: NetMos Nm9835 Chip
Date: Wed, 14 Jul 2004 08:18:21 +0200
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <200407140818.21256.g.gebhardt@meilhaus.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.meilhaus.com ([195.30.252.147]:29366 "EHLO
	mail.meilhaus.com") by vger.kernel.org with ESMTP id S264298AbUGNGSt
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 14 Jul 2004 02:18:49 -0400
Content-Disposition: inline
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hello,

I previously posted this question with my patch for support of Meilhaus serial 
PCI boards. But not all people on this mailing list will read this mail. So i 
send it seperately.

Meilhaus has a serial board named ME-9200 with the NetMos Nm9835 chip which 
provides two serial ports and one parallel port.

I found out that support for this chip was added in the parport_serial.c code 
in the 2.4 kernels. Then it was removed with the hint that "Remove NetMos 
support, since it causes problems for some people", which People and why?

Then a patch was sent to the kernel mailing list for 2.5 Kernels 
(ftp://people.redhat.com/twaugh/patches/linux25/linux-netmos.patch) but never 
got applied.

Does someone know what's going on with this Chip?

Thanks in advance,

Gebhardt

