From: johnlinn@comcast.net
Subject: kernel lockup due to bad baud rate data
Date: Thu, 16 Jun 2011 00:09:12 +0000 (UTC)
Message-ID: <1786375823.1623268.1308182952117.JavaMail.root@sz0140a.emeryville.ca.mail.comcast.net>
References: <1719676005.1623192.1308182800563.JavaMail.root@sz0140a.emeryville.ca.mail.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from qmta06.emeryville.ca.mail.comcast.net ([76.96.30.56]:47376 "EHLO
	qmta06.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752251Ab1FPAOz (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 15 Jun 2011 20:14:55 -0400
In-Reply-To: <1719676005.1623192.1308182800563.JavaMail.root@sz0140a.emeryville.ca.mail.comcast.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

I'm testing with 2.6.39 and our serial driver that's unique to our ARM platform.  I suspect we have a problem with our serial driver but wanted to see if anyone has seen any similar behavior.

When running with 2 serial ports, any input from a serial terminal running at the wrong baud rate (9600 instead of 115.2K) on a 2nd shell (not the console shell) causes the kernel to lock up. It doesn't crash, I'm still trying to understand what it's doing.  I can no longer ping the board as the network was working prior.

I just wanted to make sure there's not any known tty issues related to this.

Thanks,
John
