From: Russell Shaw <rjshaw@netspace.net.au>
Subject: Onboard COM of P5E-V-HDMI
Date: Tue, 09 Dec 2008 03:34:02 +1100
Message-ID: <493D4C7A.3050409@netspace.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-out5.netspace.net.au ([203.10.110.92]:64508 "EHLO
	mail.netspace.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753343AbYLHQzF (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 8 Dec 2008 11:55:05 -0500
Received: from [192.168.0.10] (220-253-23-156.VIC.netspace.net.au [220.253.23.156])
	by mail.netspace.net.au (Postfix) with ESMTP id 73E131717F3
	for <linux-serial@vger.kernel.org>; Tue,  9 Dec 2008 03:34:01 +1100 (EST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi,

I'm running 2.6.24 on debian/unstable.

I have an Asus P5E-V-HDMI (Intel G35 chipset) with on-board rs232 serial port.

http://www.asus.com/products.aspx?l1=3&l2=11&l3=584&l4=0&model=1929&modelmenu=1


With an LED breakout box connected, i get these signals asserted
when doing: cat random.txt > /dev/ttyS0:

TD   faint green
RD   flickering red and green
RTS  red
DTR  red

When i'm not sending anything i get:

TD  red
RD  green
RTS green
CTS red
DSR red
DCD red
DTR red


IIRC, RD should not be asserted red or green at all because it
should be an input.

My other serial cards behave ok.

I checked the cable between the motherboard and breakout box.

