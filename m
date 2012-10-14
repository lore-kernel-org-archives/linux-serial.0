From: Noam Camus <noamc@ezchip.com>
Subject: RE: 8250_early for big-endian
Date: Sun, 14 Oct 2012 18:18:40 +0200
Message-ID: <264C179F799EF24AB26D5319053335E80CC30010D0@ezexch.ezchip.com>
References: <264C179F799EF24AB26D5319053335E80CC30499A2@ezexch.ezchip.com>
	<20121012175150.4b081343@pyramind.ukuu.org.uk>
	<264C179F799EF24AB26D5319053335E80CC30499A4@ezexch.ezchip.com>
	<20121012195102.5781c7d4@pyramind.ukuu.org.uk>
	<264C179F799EF24AB26D5319053335E80CC30499A5@ezexch.ezchip.com>
	<20121012220604.3f99d003@pyramind.ukuu.org.uk>
	<264C179F799EF24AB26D5319053335E80CC30499A9@ezexch.ezchip.com>
	<20121013145212.27f6fcbd@pyramind.ukuu.org.uk>
	<264C179F799EF24AB26D5319053335E80CC3001073@ezexch.ezchip.com>
 <20121014133216.686277e1@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ezexch.ezchip.com ([212.179.42.101]:10877 "EHLO
	ezexch.ezchip.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751603Ab2JNQTX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 14 Oct 2012 12:19:23 -0400
In-Reply-To: <20121014133216.686277e1@pyramind.ukuu.org.uk>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk] 
Sent: Sunday, October 14, 2012 2:32 PM

> For 8250_early it may well be the right thing is to support similar serial_in/serial_out methods.

Is it acceptable solution to add attribute __weak (and remove static) from serial_in/serial_out methods?

Noam
