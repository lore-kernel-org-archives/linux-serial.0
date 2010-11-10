From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] pl011: added clock management feature
Date: Wed, 10 Nov 2010 00:01:52 +0000
Message-ID: <20101110000152.GA8993@n2100.arm.linux.org.uk>
References: <1289316637-7828-1-git-send-email-linus.walleij@stericsson.com> <20101109224012.GA21992@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:49169 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751526Ab0KJACP (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 9 Nov 2010 19:02:15 -0500
Content-Disposition: inline
In-Reply-To: <20101109224012.GA21992@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Linus Walleij <linus.walleij@stericsson.com>, Par-Gunnar Hjalmdahl <par-gunnar.p.hjalmdahl@stericsson.com>, Greg Kroah-Hartman <gregkh@suse.de>, Lukasz Rymanowski <Lukasz.Rymanowski@tieto.com>, Grzegorz Sygieda <grzegorz.sygieda@tieto.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Nov 09, 2010 at 02:40:12PM -0800, Greg KH wrote:
> On Tue, Nov 09, 2010 at 04:30:37PM +0100, Linus Walleij wrote:
> > From: Grzegorz Sygieda <grzegorz.sygieda@tieto.com>
> > 
> > This patch allows to control the pl011 clock using set_termios
> > callback. Any positive baudrate passed enables clock, otherwise
> > disables. This saves a lot of power on submicron designs since
> > we can clock off and disable unused UARTs.
> 
> That's nice, but it seems like an overload of what people traditionally
> think of when it comes to baud rates.  Why not just power down ports
> that are not open instead?

We already do.  My question to Linus (in a previous message) is why this
isn't sufficient.
