From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH RESEND] serdev: add controller runtime PM support
Date: Wed, 30 May 2018 08:20:27 -0500
Message-ID: <CAL_JsqLk+wFmF+c9XOnna0VerP-CejmqjyiGaa8y3crOz4aiXQ@mail.gmail.com>
References: <20180530105059.21409-1-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180530105059.21409-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, "H. Nikolaus Schaller" <hns@goldelico.com>, Andreas Kemnade <andreas@kemnade.info>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Pavel Machek <pavel@ucw.cz>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, May 30, 2018 at 5:50 AM, Johan Hovold <johan@kernel.org> wrote:
> Add support for controller runtime power management to serdev core. This
> is needed to allow slave drivers to manage the runtime PM state of the
> underlying serial controller when its driver, in turn, implements more
> aggressive runtime power management (e.g. using autosuspend).
>
> For some applications, for example, where loss off initial data after a
> remote-wakeup event is acceptable or where rx is not used at all,
> aggressive serial controller runtime PM may be used without further
> involvement of the slave driver. But when this is not the case, the
> slave driver must be able to indicate when incoming data is expected in
> order to avoid data loss.
>
> To facilitate the common case, where the serial controller power state
> is active whenever the port is open (which is the case with just about
> every serial driver), and where data loss is not acceptable and cannot
> even be prevented by explicit controller runtime power management, an
> RPM reference is taken in serdev open and put again at close. This
> reference can later be balanced by any serdev driver which wants and/or
> can handle aggressive controller runtime PM.
>
> Note that the .ignore_children flag is set for the serdev controller to
> allow the underlying hardware to idle when no I/O is expected, regardless
> of the slave device RPM state.
>
> Acked-by: Tony Lindgren <tony@atomide.com>
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>
> Hi Rob and Greg,
>
> This is a resend of the serdev controller runtime PM patch, which you
> haven't commented on yet (possibly due to the following extensive
> discussions on how to generalise the aggressive OMAP serial runtime PM
> implementation).
>
> This patch works with what we have today, regardless of how we end up
> configuring the serial controller (active) runtime PM behaviour
> (currently done through sysfs for OMAP), which is a separate issue.
>
> No changes in this resend, besides me adding Tony's and Sebastian's ack
> and reviewed-by tags and dropping the second patch which only served as
> an example of how to use this in a serdev driver.

Acked-by: Rob Herring <robh@kernel.org>

Rob
