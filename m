From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC PATCH 1/6] serio: add DT driver binding
Date: Mon, 29 Aug 2016 11:57:13 +0200
Message-ID: <20160829095713.GA14178@amd>
References: <20160824232437.9446-1-robh@kernel.org>
 <20160824232437.9446-2-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160824232437.9446-2-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>, vojtech@ucw.cz
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Loic Poulain <loic.poulain@intel.com>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, Linus Walleij <linus.walleij@linaro.org>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed 2016-08-24 18:24:31, Rob Herring wrote:
> This adds DT driver binding support to the serio bus. The parent of the
> serio port device must have a device_node associated with it. Typically,
> this would be the UART device node. The slave device must be a child node
> of the UART device node.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Pavel Machek <pavel@ucw.cz>

Added vojtech to cc list, as he's original author.

> diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
> index 1ca7f55..9e8eb7a 100644
> --- a/drivers/input/serio/serio.c
> +++ b/drivers/input/serio/serio.c
> @@ -36,6 +36,7 @@
>  #include <linux/slab.h>
>  #include <linux/workqueue.h>
>  #include <linux/mutex.h>
> +#include <linux/of_device.h>
>  
>  MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
>  MODULE_DESCRIPTION("Serio abstraction core");
> @@ -902,6 +907,10 @@ static int serio_bus_match(struct device *dev, struct device_driver *drv)
>  	struct serio *serio = to_serio_port(dev);
>  	struct serio_driver *serio_drv = to_serio_driver(drv);
>  
> +	if (of_driver_match_device(dev, drv)) {
> +		printk("matched %s\n", dev->of_node->name);

printk probalby should be removed when moving out of RFC phase.

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
