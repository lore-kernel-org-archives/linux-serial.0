From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] serial imx.c: fix CTS trigger level lower to avoid
	lost chars
Date: Thu, 21 Jan 2010 22:11:33 +0000
Message-ID: <20100121221133.GA30419@n2100.arm.linux.org.uk>
References: <1264109163-28739-1-git-send-email-valentin.longchamp@epfl.ch> <20100121220653.GA21010@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:52626 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754813Ab0AUWLw (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 21 Jan 2010 17:11:52 -0500
Content-Disposition: inline
In-Reply-To: <20100121220653.GA21010@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Valentin Longchamp <valentin.longchamp@epfl.ch>, s.hauer@pengutronix.de, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Jan 21, 2010 at 11:06:53PM +0100, Wolfram Sang wrote:
> CCing linux-serial
> 
> On Thu, Jan 21, 2010 at 10:26:03PM +0100, Valentin Longchamp wrote:
> > The imx CTS trigger level is left at its reset value that is 32
> > chars. Since the RX FIFO has 32 entries, when CTS is raised, the
> > FIFO already is full. However, some serial port devices first empty
> > their TX FIFO before stopping when CTS is raised, resulting in lost
> > chars.
> 
> ? Isn't that a flaw of the other side? Have you spotted other serial drivers
> doing the same as your patch?

Arguably, but it's common behaviour of 16550A's and similar.
