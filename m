From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: merging device tree binding dirs for serial bindings
Date: Wed, 28 Aug 2013 11:35:34 -0700
Message-ID: <20130828183534.GC14627@kroah.com>
References: <F93329E6-1426-4197-871D-211F34455DDE@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <F93329E6-1426-4197-871D-211F34455DDE@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kumar Gala <galak@codeaurora.org>
Cc: devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org list" <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>, "shawn.guo@linaro.org Guo" <shawn.guo@linaro.org>, "s.hauer@pengutronix.de Hauer" <s.hauer@pengutronix.de>
List-Id: linux-serial@vger.kernel.org

On Wed, Aug 28, 2013 at 01:02:14PM -0500, Kumar Gala wrote:
> We appear to have:
> 
> Documentation/devicetree/bindings/serial/
> 
> and
> 
> Documentation/devicetree/bindings/tty/serial/
> 
> Which one do we want to keep, I'd pick the first, but I don't care too much.

I don't care, I never created either one, and don't do any devicetree
stuff, so it's up to the devicetree maintainers to pick one.

thanks,

greg k-h
