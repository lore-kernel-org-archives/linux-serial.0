From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] pl011: added clock management feature
Date: Tue, 9 Nov 2010 14:40:12 -0800
Message-ID: <20101109224012.GA21992@kroah.com>
References: <1289316637-7828-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:45799 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753676Ab0KIWuM (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 9 Nov 2010 17:50:12 -0500
Content-Disposition: inline
In-Reply-To: <1289316637-7828-1-git-send-email-linus.walleij@stericsson.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org, Grzegorz Sygieda <grzegorz.sygieda@tieto.com>, Lukasz Rymanowski <Lukasz.Rymanowski@tieto.com>, Par-Gunnar Hjalmdahl <par-gunnar.p.hjalmdahl@stericsson.com>

On Tue, Nov 09, 2010 at 04:30:37PM +0100, Linus Walleij wrote:
> From: Grzegorz Sygieda <grzegorz.sygieda@tieto.com>
> 
> This patch allows to control the pl011 clock using set_termios
> callback. Any positive baudrate passed enables clock, otherwise
> disables. This saves a lot of power on submicron designs since
> we can clock off and disable unused UARTs.

That's nice, but it seems like an overload of what people traditionally
think of when it comes to baud rates.  Why not just power down ports
that are not open instead?

thanks,

greg k-h
