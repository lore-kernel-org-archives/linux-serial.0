From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH V4] tty/serial: add support for Xilinx PS UART
Date: Fri, 6 May 2011 13:23:44 +0100
Message-ID: <20110506132344.1d166260@lxorguk.ukuu.org.uk>
References: <1013673718.2094564.1304113268455.JavaMail.root@sz0140a.emeryville.ca.mail.comcast.net>
	<4DC3E580.9090500@petalogix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:54593 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754034Ab1EFMWq (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 6 May 2011 08:22:46 -0400
In-Reply-To: <4DC3E580.9090500@petalogix.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: michal.simek@petalogix.com
Cc: johnlinn@comcast.net, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, joe@perches.com, grant likely <grant.likely@secretlab.ca>, John Linn <john.linn@xilinx.com>

> I don't agree with this change. NO_IRQ for microblaze, arm and other is -1. BTW: 
> For ppc is 0. Using NO_IRQ seems to me reasonable.

0 means "no interrupt".

The old mis-use of -1 is an old mostly ARM specific ugly that ahould be
going away not getting repeated further. If Microblaze is using this hack
then it needs to stop.

NO_IRQ was *purposefully* removed from general consumption a long time
ago for a good reason (historically it was an IDE driver internal define
certain people borrowed)

Alan
