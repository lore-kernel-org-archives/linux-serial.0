From: Joshua Colvin <jcolvin@marisys.net>
Subject: What does the 0x0F char from serial port signify??
Date: Thu, 31 Jul 2003 13:43:12 -0400
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <750102E9-C37E-11D7-BB0C-000A959AFBBA@marisys.net>
Mime-Version: 1.0 (Apple Message framework v552)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from [66.203.135.146] ([66.203.135.146]:55812 "EHLO
	grampus.marisys.net") by vger.kernel.org with ESMTP id S272535AbTGaRnN
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 31 Jul 2003 13:43:13 -0400
Received: from marisys.net ([192.168.0.22])
	by grampus.marisys.net (8.11.6/8.11.6) with ESMTP id h6VHUXx05818
	for <linux-serial@vger.kernel.org>; Thu, 31 Jul 2003 13:30:33 -0400
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org


Hello all,
I'm trying to setup a socket connection to a serial port under Linux. 
When talking to the device
on the other end of the serial port I get an SI (shift in) character 
(hex value 0x0f, octal value 017)
embedded in the response. So rather than get "RESPONSE" I get 
"RESP\017ONSE". It happens
like clockwork, same place, every time. While it COULD be the device on 
the other end (it's 3rd
party closed source proprietary), I seriously doubt it. I've been 
playing with the termios settings
when configuring the serial port to no avail.

The closest I could find to the meaning of this character is an 
additional character set code and is
controlled by IEXTEN or VDISCARD. However setting or clearing either of 
these has no effect. Does
anyone have any insight as to what this??

I'm using cfmakeraw to make the serial port raw. It does not talk to a 
modem, but rather to a data
acquisition computer via RS-422. Any ideas?? Does RS-422 have anything 
to do with this? I'm
slowly going crazy.

Thanks.
Josh

