From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH] - add PNP IDs for FPI based touchscreens
Date: Sun, 1 Oct 2006 21:30:04 +0100
Message-ID: <20061001203004.GA2224@flint.arm.linux.org.uk>
References: <20061001182738.GA17124@srcf.ucam.org> <1159735659.13029.182.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:21769 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932329AbWJAUaP (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 1 Oct 2006 16:30:15 -0400
Content-Disposition: inline
In-Reply-To: <1159735659.13029.182.camel@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Oct 01, 2006 at 09:47:39PM +0100, Alan Cox wrote:
> Ar Sul, 2006-10-01 am 19:27 +0100, ysgrifennodd Matthew Garrett:
> > The Compaq TC1000 and Fujitsu Stylistic range of tablet machines use 
> > touchscreens from FPI. These are implemented as serial interfaces, 
> > generally exposed in the ACPIPNP information on the system. This patch 
> > adds them to the 8250_pnp driver tables, avoiding the need to mess 
> > around with setserial to set them up.
> > 
> > I haven't been able to confirm what FUJ02B5, FUJ02BA and FUJ02BB are. 
> > FUJ02B1 refers to the controller for the system hotkeys. FUJ02BC appears 
> > to be the last in the range - after this, they moved to Wacom-based 
> > systems.
> > 
> > Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>
> 
> 
> Acked-by: Alan Cox <alan@redhat.com>
> 
> This makes a lot of sense and will mean that people don't have to read
> the fpit driver docs to get X working.

ack, just applied it anyway before reading your reply.

http://ftp.arm.linux.org.uk/pub/armlinux/kernel/git-cur/serial:devel.*

has the current state of play in both mbox and diff formats.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
