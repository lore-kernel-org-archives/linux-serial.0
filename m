From: Christian Melki <christian.melki@ericsson.com>
Subject: 8250.c: Generic support for RTS disabling once shiftreg and fifo is
 empty. (low latency RS485 etc).
Date: Fri, 27 Apr 2012 08:23:23 +0200
Message-ID: <1346E68D3A5B2043907CF4BF466383411A07E01021@ESESSCMS0353.eemea.ericsson.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailgw7.ericsson.se ([193.180.251.48]:45640 "EHLO
	mailgw7.ericsson.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752571Ab2D0GX1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 27 Apr 2012 02:23:27 -0400
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

Hi.

I have written a patch for 8250.c that introduces a new ioctl to tell the uart driver to shift disable RTS when uart has been completely emptied.
This idea is to set the ioctl once the master is finished and wants to shift the bus.
We needed this to be in the kernel since we have very little time to shift RTS according to the implemented protocol on top of RS485.

Is there any interest in the community for such a behavior?

The patch is a little ugly right now. It busywaits a maximum amount of time for the shift register to become empty. I don't know how to do it without introducing a latency that is more than our max RTS time shift requirement (50us). I think it could be useful with a generic 8250.c support for this.

Regards,
Christian Melki