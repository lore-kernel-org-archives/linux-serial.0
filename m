From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] pl011: added clock management feature
Date: Tue, 9 Nov 2010 15:44:39 +0000
Message-ID: <20101109154439.GA7973@n2100.arm.linux.org.uk>
References: <1289316637-7828-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:45538 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750815Ab0KIPo7 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 9 Nov 2010 10:44:59 -0500
Content-Disposition: inline
In-Reply-To: <1289316637-7828-1-git-send-email-linus.walleij@stericsson.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org, Par-Gunnar Hjalmdahl <par-gunnar.p.hjalmdahl@stericsson.com>, Lukasz Rymanowski <Lukasz.Rymanowski@tieto.com>, Grzegorz Sygieda <grzegorz.sygieda@tieto.com>

On Tue, Nov 09, 2010 at 04:30:37PM +0100, Linus Walleij wrote:
> From: Grzegorz Sygieda <grzegorz.sygieda@tieto.com>
> 
> This patch allows to control the pl011 clock using set_termios
> callback. Any positive baudrate passed enables clock, otherwise
> disables. This saves a lot of power on submicron designs since
> we can clock off and disable unused UARTs.

Why not just close the port to save power - the clock in that case will
automatically be turned off.

It's not like the port can be used without the baud rate correctly set -
or indeed characters transmitted or received without the clock running.
So all the time that the clock is disabled, the port is inoperable.

If you want to maintain the modem control line settings while the port
is closed, why not clear the HUPCL termios flag?
