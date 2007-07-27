From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: When line-discipline doesn't fit - serial from the kernel again
Date: Fri, 27 Jul 2007 23:04:39 +0200 (CEST)
Message-ID: <Pine.LNX.4.60.0707272247420.11083@poirot.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:48748 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761372AbXG0VEl (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 27 Jul 2007 17:04:41 -0400
Received: from lyakh (helo=localhost)
	by poirot.grange with local-esmtp (Exim 3.36 #1 (Debian))
	id 1IEWzH-0004jU-00
	for <linux-serial@vger.kernel.org>; Fri, 27 Jul 2007 23:04:39 +0200
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi

I've been trying to find a suitable solution for this problem for many 
months now. Meanwhile I've implemented an ugly hack, that's in the 
mainline since about 2.6.20, but now there's another platform with the 
same "feature" and I'd really love to avoid repeating that hack again...

There are NAS devices from Buffalo from the Linkstation family, that have 
an AVR microcontroller doing system power management (power on / off / 
reset / LEDs / buttons / timer / watchdog / ...) and connected to the main 
CPU over a UART. It would be all fine and everything can be implemented in 
the user-space, except power-off / reset. It is really like that - you 
send a byte to the AVR over the UART and you are dead or reset. Obviously, 
this should be done from arch low-level kernel code and cannot be done 
from userspace. Even worse, there are PPC, ARM, and MIPS Linkstations.

There have been a few "kernel serial API" patches floating around, none of 
them got far enough, mostly they were rejected with "use line-discipline" 
sort of argument. What should Linkstation do?

Thanks
Guennadi
---
Guennadi Liakhovetski
