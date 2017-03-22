From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCHv2 07/11] serdev: add helpers for cts and rts handling
Date: Wed, 22 Mar 2017 16:03:14 -0500
Message-ID: <CAL_JsqLD6dYFXvA8nNaMiKuVbs97VD0s0MMeVGvnmQbLbD6_zA@mail.gmail.com>
References: <20170321223216.11733-1-sre@kernel.org> <20170321223216.11733-8-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170321223216.11733-8-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Mark Rutland <mark.rutland@arm.com>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Mar 21, 2017 at 5:32 PM, Sebastian Reichel <sre@kernel.org> wrote:
> Add serdev helper functions for handling of cts and rts
> lines using the serdev's tiocm functions.
>
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---
>  include/linux/serdev.h | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/include/linux/serdev.h b/include/linux/serdev.h
> index 3ad1d695f947..8cdce2ea0d51 100644
> --- a/include/linux/serdev.h
> +++ b/include/linux/serdev.h
> @@ -16,6 +16,7 @@
>  #include <linux/types.h>
>  #include <linux/device.h>
>  #include <asm-generic/termios.h>
> +#include <linux/delay.h>
>
>  struct serdev_controller;
>  struct serdev_device;
> @@ -254,6 +255,36 @@ static inline int serdev_device_write_room(struct serdev_device *sdev)
>
>  #endif /* CONFIG_SERIAL_DEV_BUS */
>
> +static inline bool serdev_device_get_cts(struct serdev_device *serdev)
> +{
> +       int status = serdev_device_get_tiocm(serdev);
> +       return !!(status & TIOCM_CTS);
> +}
> +
> +static inline int serdev_device_wait_for_cts(struct serdev_device *serdev, bool state, int timeout_ms)
> +{
> +       unsigned long timeout;
> +       bool signal;
> +
> +       timeout = jiffies + msecs_to_jiffies(timeout_ms);
> +       while (!time_after(jiffies, timeout)) {

You can use time_is_after_jiffies(timeout) instead of !time_after.

> +               signal = serdev_device_get_cts(serdev);
> +               if (signal == state)
> +                       return 0;
> +               usleep_range(1000, 2000);
> +       }
> +
> +       return -ETIMEDOUT;
> +}
> +
> +static inline int serdev_device_set_rts(struct serdev_device *serdev, bool enable)
> +{
> +       if (enable)
> +               return serdev_device_set_tiocm(serdev, TIOCM_OUT2 | TIOCM_RTS, 0);

Perhaps a comment why we're messing with OUT2.

With those,

Acked-by: Rob Herring <robh@kernel.org>

> +       else
> +               return serdev_device_set_tiocm(serdev, 0, TIOCM_OUT2 | TIOCM_RTS);
> +}
> +
>  /*
>   * serdev hooks into TTY core
>   */
> --
> 2.11.0
>
