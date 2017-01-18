From: =?UTF-8?Q?Fr=c3=a9d=c3=a9ric_Danis?= <frederic.danis.oss@gmail.com>
Subject: Re: [PATCH v2 7/9] serdev: Introduce new bus for serial attached
 devices
Date: Wed, 18 Jan 2017 12:53:55 +0100
Message-ID: <09cdab76-ee1a-45da-699f-a66bf7148579@gmail.com>
References: <20170116225436.17505-1-robh@kernel.org>
 <20170116225436.17505-8-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170116225436.17505-8-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Loic Poulain <loic.poulain@intel.com>, Pavel Machek <pavel@ucw.cz>, NeilBrown <neil@brown.name>, Linus Walleij <linus.walleij@linaro.org>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hello,

Le 16/01/2017 à 23:54, Rob Herring a écrit :
> ---
> v2:
> - Add modalias sysfs attr and uevent hook
...
> +static int serdev_uevent(struct device *dev, struct kobj_uevent_env *env)
> +{
> +	/* TODO: ACPI and platform modalias */
> +	return of_device_uevent_modalias(dev, env);
> +}
...
> +static ssize_t modalias_show(struct device *dev,
> +			     struct device_attribute *attr, char *buf)
> +{
> +	ssize_t len = of_device_get_modalias(dev, buf, PAGE_SIZE - 2);
> +	buf[len] = '\n';
> +	buf[len+1] = 0;
> +	return len+1;
> +}

This prevents from building serdev as a module with following errors:
   ERROR: "of_device_uevent_modalias" [drivers/tty/serdev/serdev.ko] 
undefined!
   ERROR: "of_device_get_modalias" [drivers/tty/serdev/serdev.ko] undefined!

Currently, those symbols are not exported in drivers/of/device.c

Frédéric Danis
