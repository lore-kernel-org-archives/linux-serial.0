From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] serdev: add method to set parity
Date: Thu, 18 Jan 2018 13:23:55 +1100
Message-ID: <20180118022355.GA3286@localhost>
References: <1516203739-4705-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1516203739-4705-1-git-send-email-ulrich.hecht+renesas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulrich Hecht <ulrich.hecht+renesas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Wed, Jan 17, 2018 at 04:42:19PM +0100, Ulrich Hecht wrote:
> Adds serdev_device_set_parity() and an implementation for ttyport.

Perhaps you can mention that the interface uses an enum and the three
settings that you add here.

> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
> Broken out of the "[PATCH 0/6] serdev multiplexing support" series
> because this kind of functionality is apparently also required
> for "[RFC v2 0/9] Realtek Bluetooth serdev support (H5 protocol)",
> which contains an earlier revision of this patch.

Thanks for submitting this separately.

>  drivers/tty/serdev/core.c           | 12 ++++++++++++
>  drivers/tty/serdev/serdev-ttyport.c | 18 ++++++++++++++++++
>  include/linux/serdev.h              | 10 ++++++++++
>  3 files changed, 40 insertions(+)
> 
> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> index 5dc88f6..1f25896 100644
> --- a/drivers/tty/serdev/core.c
> +++ b/drivers/tty/serdev/core.c
> @@ -290,6 +290,18 @@ int serdev_device_set_tiocm(struct serdev_device *serdev, int set, int clear)
>  }
>  EXPORT_SYMBOL_GPL(serdev_device_set_tiocm);
>  
> +int serdev_device_set_parity(struct serdev_device *serdev,
> +			     enum serdev_parity parity)
> +{
> +	struct serdev_controller *ctrl = serdev->ctrl;
> +
> +	if (!ctrl || !ctrl->ops->set_parity)
> +		return -ENOTSUPP;
> +
> +	return ctrl->ops->set_parity(ctrl, parity);
> +}
> +EXPORT_SYMBOL_GPL(serdev_device_set_parity);

Please place the parity functions (and fields) after the set_flow
equivalents so that we keep the line-setting functionality grouped
together.

> +static int ttyport_set_parity(struct serdev_controller *ctrl,
> +			      enum serdev_parity parity)
> +{
> +	struct serport *serport = serdev_controller_get_drvdata(ctrl);
> +	struct tty_struct *tty = serport->tty;
> +	struct ktermios ktermios = tty->termios;
> +
> +	ktermios.c_cflag &= ~(PARENB | PARODD);

You should also clear CMSPAR.

> +	if (parity != SERDEV_PARITY_NONE) {
> +		ktermios.c_cflag |= PARENB;
> +		if (parity == SERDEV_PARITY_ODD)
> +			ktermios.c_cflag |= PARODD;
> +	}
> +
> +	return tty_set_termios(tty, &ktermios);

Note that tty_set_termios() always return 0. You need to verify that you
got what you requested by looking at the termios after the function
returns (and possibly return -EINVAL). Not all drivers support (all)
parity modes.

Note that we currently do not implement proper error handling for flow
control, but that should be fixed.

Looks good otherwise.

Thanks,
Johan
