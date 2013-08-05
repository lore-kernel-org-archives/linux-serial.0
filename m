From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 1/2] OF: Add helper for matching against
 linux,stdout-path
Date: Mon, 5 Aug 2013 15:16:15 +0200
Message-ID: <20130805131615.GV26614@pengutronix.de>
References: <1375706445-15375-1-git-send-email-s.hauer@pengutronix.de>
 <1375706445-15375-2-git-send-email-s.hauer@pengutronix.de>
 <51FFA195.6080903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <51FFA195.6080903@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, devicetree@vger.kernel.org, grant.likely@linaro.org
List-Id: linux-serial@vger.kernel.org

On Mon, Aug 05, 2013 at 07:59:01AM -0500, Rob Herring wrote:
> On 08/05/2013 07:40 AM, Sascha Hauer wrote:
> > devicetrees may have a linux,stdout-path property in the chosen
> > node describing the console device. This adds a helper function
> > to match a device against this property so a driver can call
> > add_preferred_console for a matching device.
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> 
> Acked-by: Rob Herring <rob.herring@calxeda.com>
> 
> There are no existing users that could take advantage of this?

The existing users do not register the console in the drivers probe
function but instead have initcalls which parse the linux,stdout-path
property manually and register whatever they find there. The better
implementations at least check whether the node they find actually is
compatible to the driver.

Sorry, no users to change here without having access to the hardware.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
