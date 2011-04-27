From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH V3] tty/serial: add support for Xilinx PS UART
Date: Wed, 27 Apr 2011 15:15:20 +0100
Message-ID: <20110427151520.32b0d2fb@lxorguk.ukuu.org.uk>
References: <20110427103340.2554df83@lxorguk.ukuu.org.uk>
	<126598808.1934339.1303910496698.JavaMail.root@sz0140a.emeryville.ca.mail.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:43245 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756427Ab1D0OO6 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 27 Apr 2011 10:14:58 -0400
In-Reply-To: <126598808.1934339.1303910496698.JavaMail.root@sz0140a.emeryville.ca.mail.comcast.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: johnlinn@comcast.net
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, michal simek <michal.simek@petalogix.com>, joe@perches.com, grant likely <grant.likely@secretlab.ca>, greg@kroah.com

> I meant we were not detecting if the error was too much and finding the 
> nearest baud rate that had an acceptable amount of error. 

If you hand back the baud rate you ended up with the tty layer then it
will do the rest for you.

