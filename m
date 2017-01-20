From: msuchanek <msuchanek-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH v2 0/9] Serial slave device bus
Date: Fri, 20 Jan 2017 02:36:12 +0100
Message-ID: <7d6a8a629f8b618cdb09c9112d1e5986@suse.de>
References: <20170116225436.17505-1-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170116225436.17505-1-robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "Dr . H . Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Alan Cox <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Loic Poulain <loic.poulain-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On 2017-01-16 23:54, Rob Herring wrote:
> Here's a new version of the serdev bus support with all the review
> feedback so far incorporated. I've left it named serdev for now pending
> any further votes one way or the other, but I did rename the sysfs 
> visible
> portions to "serial".
> 
> There's still some discussion about what to do with devices that pass 
> thru
> data to userspace unmodified like GPS and could still use tty device 
> for
> the data path. IMO, we should treat this as a separate problem 
> following
> this series. Drivers we want to convert to serdev and already in the
> kernel don't need this functionality.

The whole point of the serial bus is to simplify and clean up support 
for
serial devices.
If tty users cannot use the kernel support for automagic kill
switches/resets/whatever with kernel GPIO or whatever framework and must
continue supporting userspace GPIO and hacks for writing IO space from
userland for their devices there is just no point.

I mean it's fine to add support for your single pet device but if you 
are
to support non-trivial number of devices they don't get all perfect 
kernel
driver overnight. And if you need userspace GPIO for half of your 
devices
you can just continue using it for all to *simplify* your userspace 
code.

It has already happened for SPI devices and the implementation of the
userspace access to SPI is dragging for years.

Thanks

Michal
