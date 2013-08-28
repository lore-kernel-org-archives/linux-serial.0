From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: merging device tree binding dirs for serial bindings
Date: Wed, 28 Aug 2013 20:12:37 +0100
Message-ID: <20130828191237.123F83E04C7@localhost>
References: <F93329E6-1426-4197-871D-211F34455DDE@codeaurora.org> <20130828183534.GC14627@kroah.com> <0F60E12D-C0BF-4185-85FF-0BC879B3C1F0@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0F60E12D-C0BF-4185-85FF-0BC879B3C1F0@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kumar Gala <galak@codeaurora.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org list" <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>, "shawn.guo@linaro.org Guo" <shawn.guo@linaro.org>, "s.hauer@pengutronix.de Hauer" <s.hauer@pengutronix.de>
List-Id: linux-serial@vger.kernel.org

On Wed, 28 Aug 2013 13:49:13 -0500, Kumar Gala <galak@codeaurora.org> wrote:
> 
> On Aug 28, 2013, at 1:35 PM, Greg Kroah-Hartman wrote:
> 
> > On Wed, Aug 28, 2013 at 01:02:14PM -0500, Kumar Gala wrote:
> >> We appear to have:
> >> 
> >> Documentation/devicetree/bindings/serial/
> >> 
> >> and
> >> 
> >> Documentation/devicetree/bindings/tty/serial/
> >> 
> >> Which one do we want to keep, I'd pick the first, but I don't care too much.
> > 
> > I don't care, I never created either one, and don't do any devicetree
> > stuff, so it's up to the devicetree maintainers to pick one.
> > 
> > thanks,
> > 
> > greg k-h
> 
> Since you don't care we'll go with bindings/serial.
> 
> I'll send a patch to merge and clean this up.

Sounds good to me.

g.
