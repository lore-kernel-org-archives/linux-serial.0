From: Pavel Machek <pavel@ucw.cz>
Subject: Re: serial ioctl emulation done right
Date: Tue, 6 May 2003 21:40:27 +0200
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20030506194027.GA5727@atrey.karlin.mff.cuni.cz>
References: <20030506184731.GA5419@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:8461 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261199AbTEFT1z (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 6 May 2003 15:27:55 -0400
Content-Disposition: inline
In-Reply-To: <20030506184731.GA5419@elf.ucw.cz>
List-Id: linux-serial@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, rmk@arm.linux.org.uk

Hi!

> What about this one? This makes it possible to kill copy from
> x86-64/ia32/ia32_ioctl.c, and adds support for setserial on all
> architectures...

It actually introduces very ugly warnings, I'm working ont that.
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
