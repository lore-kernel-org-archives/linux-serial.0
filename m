From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v10 2/5] serdev: Introduce devm_serdev_device_open()
Date: Wed, 1 Nov 2017 18:48:36 -0500
Message-ID: <CAL_JsqLOWbdvgDx1-ujSm==AKL_n+NpkkA7q6_9mBKXF-_rsbw@mail.gmail.com>
References: <20171031163656.24552-1-andrew.smirnov@gmail.com> <20171031163656.24552-3-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171031163656.24552-3-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Chris Healy <cphealy@gmail.com>, Guenter Roeck <linux@roeck-us.net>, Lucas Stach <l.stach@pengutronix.de>, Nikita Yushchenko <nikita.yoush@cogentembedded.com>, Lee Jones <lee.jones@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>, Andy Shevchenko <andy.shevchenko@gmail.com>, Johan Hovold <johan@kernel.org>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-serial@vger.kernel.org

On Tue, Oct 31, 2017 at 11:36 AM, Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:
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

Acked-by: Rob Herring <robh@kernel.org>
