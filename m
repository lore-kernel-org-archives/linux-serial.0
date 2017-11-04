From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v10 1/5] serdev: Make .remove in struct
 serdev_device_driver optional
Date: Sat, 4 Nov 2017 12:24:31 +0100
Message-ID: <20171104112431.GA24583@kroah.com>
References: <20171031163656.24552-1-andrew.smirnov@gmail.com>
 <20171031163656.24552-2-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171031163656.24552-2-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Rob Herring <robh@kernel.org>, cphealy@gmail.com, Guenter Roeck <linux@roeck-us.net>, Lucas Stach <l.stach@pengutronix.de>, Nikita Yushchenko <nikita.yoush@cogentembedded.com>, Lee Jones <lee.jones@linaro.org>, Pavel Machek <pavel@ucw.cz>, Andy Shevchenko <andy.shevchenko@gmail.com>, Johan Hovold <johan@kernel.org>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-serial@vger.kernel.org

On Tue, Oct 31, 2017 at 09:36:52AM -0700, Andrey Smirnov wrote:
> Using devres infrastructure it is possible to write a serdev driver
> that doesn't have any code that needs to be called as a part of
> .remove. Add code to make .remove optional.

What about manual unbind from userspace through sysfs?  You need to have
a remove function.  All drivers need that, to not have it is pretty lazy :)

thanks,

greg k-h
