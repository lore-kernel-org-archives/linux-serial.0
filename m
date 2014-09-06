From: Carlo Caione <carlo@caione.org>
Subject: Re: [PATCH 2/7] ARM: meson: serial: add MesonX SoC on-chip uart
 driver
Date: Sat, 6 Sep 2014 20:51:12 +0200
Message-ID: <20140906185112.GB14240@nuc>
References: <1408272594-10814-1-git-send-email-carlo@caione.org>
 <1408272594-10814-3-git-send-email-carlo@caione.org>
 <20140906182804.GA14240@nuc>
 <20140906183834.GA28645@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:52609 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751354AbaIFSvT (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 6 Sep 2014 14:51:19 -0400
Content-Disposition: inline
In-Reply-To: <20140906183834.GA28645@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux@arm.linux.org.uk, robh+dt@kernel.org, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, daniel.lezcano@linaro.org, tglx@linutronix.de, jslaby@suse.cz, grant.likely@linaro.org, b.galvani@gmail.com

On sab, set 06, 2014 at 11:38:34 -0700, Greg KH wrote:
> On Sat, Sep 06, 2014 at 08:28:04PM +0200, Carlo Caione wrote:
> > On dom, ago 17, 2014 at 12:49:49 +0200, Carlo Caione wrote:
> > > The SoC has four fully functional UARTs which use the same programming
> > > model. They are named UART_A, UART_B, UART_C and UART_AO (Always-On)
> > > which cannot be powered off.
> > > 
> > > Signed-off-by: Carlo Caione <carlo@caione.org>
> > > ---
> > 
> > Ping
> 
> It's still in my queue, sorry, been busy with conferences and the like,
> should get to everything next week...

No prob. I'll wait, thanks.

-- 
Carlo Caione
