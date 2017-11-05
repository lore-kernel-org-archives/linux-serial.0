From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v10 2/5] serdev: Introduce devm_serdev_device_open()
Date: Sun, 5 Nov 2017 16:38:57 +0100
Message-ID: <20171105153857.GC13118@localhost>
References: <20171031163656.24552-1-andrew.smirnov@gmail.com>
 <20171031163656.24552-3-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171031163656.24552-3-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Rob Herring <robh@kernel.org>, cphealy@gmail.com, Guenter Roeck <linux@roeck-us.net>, Lucas Stach <l.stach@pengutronix.de>, Nikita Yushchenko <nikita.yoush@cogentembedded.com>, Lee Jones <lee.jones@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>, Andy Shevchenko <andy.shevchenko@gmail.com>, Johan Hovold <johan@kernel.org>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-serial@vger.kernel.org

On Tue, Oct 31, 2017 at 09:36:53AM -0700, Andrey Smirnov wrote:
> Add code implementing managed version of serdev_device_open() for
> serdev device drivers that "open" the device during driver's lifecycle
> only once (e.g. opened in .probe() and closed in .remove()).
> 
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-serial@vger.kernel.org
> Cc: Rob Herring <robh@kernel.org>
> Cc: cphealy@gmail.com
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Johan Hovold <johan@kernel.org>
> Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  Documentation/driver-model/devres.txt |  3 +++
>  drivers/tty/serdev/core.c             | 27 +++++++++++++++++++++++++++
>  include/linux/serdev.h                |  1 +
>  3 files changed, 31 insertions(+)

> +int devm_serdev_device_open(struct device *dev, struct serdev_device *serdev)
> +{
> +	struct serdev_device **dr;
> +	int ret;
> +
> +	dr = devres_alloc(devm_serdev_device_release, sizeof(*dr), GFP_KERNEL);
> +	if (!dr)
> +		return -ENOMEM;
> +
> +	ret = serdev_device_open(serdev);
> +	if (ret) {
> +		devres_free(dr);
> +		return ret;
> +	}
> +
> +	*dr = serdev;
> +	devres_add(dev, dr);
> +
> +	return ret;

This would be more readable as return 0.

> +}
> +EXPORT_SYMBOL_GPL(devm_serdev_device_open);

Johan
