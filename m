From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] serial: i.MX: evaluate linux,stdout-path property
Date: Thu, 4 Oct 2012 15:12:42 +0200
Message-ID: <20121004131242.GI1322@pengutronix.de>
References: <1349347191-7406-1-git-send-email-s.hauer@pengutronix.de>
 <506D84BD.5010000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <506D84BD.5010000@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

On Thu, Oct 04, 2012 at 07:44:45AM -0500, Rob Herring wrote:
> On 10/04/2012 05:39 AM, Sascha Hauer wrote:
> > devicetrees may have the linux,stdout-path property to specify the
> > console. This patch adds support to the i.MX serial driver for this.
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> > 
> > I was originally looking for a more generic way to handle this, but
> > since a struct console has no device associated to it, it's not
> > possible to match a console with a device in a generic way. So we
> 
> Could we add a device ptr to struct console?

I think not. Looking at some drivers they register a console very early
when there is no device available (even if there will be a device later
when the uart driver probes)

> >  #ifdef CONFIG_OF
> >  /*
> > + * Check if this device matches the linux,stdout-path property
> > + * in the chosen node. return true if yes, false otherwise
> > + */
> > +static int serial_imx_is_stdoutpath(struct platform_device *pdev)
> 
> Couldn't this function be generic? Just move
> IS_ENABLED(CONFIG_SERIAL_IMX_CONSOLE) outside this function. Arguably,
> the presence of the property or not could replace the config option all
> together.
> 
> And use a struct device so this can work with devices other than
> platform devices (i.e. amba).

Ok, makes sense.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
