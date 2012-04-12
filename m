From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] serial: 8250: Add cpufreq support
Date: Thu, 12 Apr 2012 10:47:58 +0100
Message-ID: <20120412104758.3fc8085d@pyramind.ukuu.org.uk>
References: <1333433022-5455-1-git-send-email-akshay.s@ti.com>
	<20120403105530.7fa3bce7@pyramind.ukuu.org.uk>
	<6F6B80BD2E18844D97BB4B51FE3705C831790EA0@DBDE01.ent.ti.com>
	<20120405115322.15e6088c@pyramind.ukuu.org.uk>
	<6F6B80BD2E18844D97BB4B51FE3705C83179146B@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:35074 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762371Ab2DLJpi (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 12 Apr 2012 05:45:38 -0400
In-Reply-To: <6F6B80BD2E18844D97BB4B51FE3705C83179146B@DBDE01.ent.ti.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "Shankarmurthy, Akshay" <akshay.s@ti.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "alan@linux.intel.com" <alan@linux.intel.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "paul.gortmaker@windriver.com" <paul.gortmaker@windriver.com>, "jamie@jamieiles.com" <jamie@jamieiles.com>, "swarren@nvidia.com" <swarren@nvidia.com>, "dianders@chromium.org" <dianders@chromium.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

> > > I will have a look at this and add the lock if necessary.
> > 
> > At the very least you need reference counts held on the tty struct and to allow for the tty having vanished under you.
> > 
> 
> I am planning to add "tty->termios_mutex" lock. Any comments ?

Explain how this will help. You need a reference count to the tty itself.

> I understand this and planning to avoid unnecessary registration like these. 
> As a solution, UART port's cpu freq status will be sent from the board file.
> Adding a member to the structure "plat_serial8250_port" which says whether
> a port requires cpu freq registration or not. cpu freq register function is
> called in the driver depending upon the status of this structure member.
> I can update the patch accordingly and send out a version 2 to the list.

That sounds sensible.

Alan
