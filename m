From: Roger Davis <rogerdavis@verizon.net>
Subject: Linux Serial Code Problems
Date: Wed, 04 Sep 2013 18:38:56 -0500 (CDT)
Message-ID: <30148664.203459.1378337936840.JavaMail.root@vznit170080>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from vms173021pub.verizon.net ([206.46.173.21]:43733 "EHLO
	vms173021pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762344Ab3IEAjA (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 4 Sep 2013 20:39:00 -0400
Received: from vznit170080pub.verizon.net ([unknown] [192.168.1.50])
 by vms173021.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTP id <0MSM00AG4KCWAK00@vms173021.mailsrvcs.net> for
 linux-serial@vger.kernel.org; Wed, 04 Sep 2013 18:38:56 -0500 (CDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

 On Mon, Sep 02, 2013 at 06:14:30PM -0500, Roger Davis wrote:
I have been pursuing a serial port problem for over a year, using Ubuntu 12.04.
I reported it on 2012-12-07, and the bug was confirmed soon after that. I'm not
sure if the root cause is in the basic Linux kernel, or if it is only in Ubuntu.
Others are having problems with similar modems.
 
The exact same computer and modem (USR 5610C, PCI, 16550 chip, Linux
compatible, http://www.usr.com/products/modem/modem-comparison.asp , with
integral controller and serial port, NOT a Wimmodem ) works just fine in
Windoze. I switch OS's by hardwire switches in removable drive trays, so it is
really the exact very same computer, not just another one of the same spec.
 
The serial port ttyS4 seems to be detected, but yet not detected, and not 
usable by the modem. IRQ 17 also seems to behave oddly. I suspect that internal
modems with both controller and integral serial ports have been kinda
"overlooked" during coding, so the code gets confused and stumbles?
 
There has been no fix action since I reported it, and the bug is still
unassigned.
 
Please see confirmed bug " https://bugs.launchpad.net/ubuntu/+bug/1087519 " for
much more details.
