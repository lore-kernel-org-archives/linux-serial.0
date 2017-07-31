From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [RFC v2 2/6] serdev: add method to set parity
Date: Mon, 31 Jul 2017 13:55:12 +0300
Message-ID: <3171716.rxI4aCGIDo@avalon>
References: <1500305076-15570-1-git-send-email-ulrich.hecht+renesas@gmail.com> <1500305076-15570-3-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1500305076-15570-3-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, magnus.damm@gmail.com, wsa@the-dreams.de, robh@kernel.org, peda@axentia.se, geert@linux-m68k.org, linux-i2c@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Ulrich,

Thank you for the patch.

On Monday 17 Jul 2017 17:24:32 Ulrich Hecht wrote:
> Adds serdev_device_set_parity() and an implementation for ttyport.
> 
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
>  drivers/tty/serdev/core.c           | 12 ++++++++++++
>  drivers/tty/serdev/serdev-ttyport.c | 17 +++++++++++++++++
>  include/linux/serdev.h              |  4 ++++
>  3 files changed, 33 insertions(+)
> 
> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> index f71b473..1fbaa4c 100644
> --- a/drivers/tty/serdev/core.c
> +++ b/drivers/tty/serdev/core.c
> @@ -242,6 +242,18 @@ int serdev_device_set_tiocm(struct serdev_device
> *serdev, int set, int clear) }
>  EXPORT_SYMBOL_GPL(serdev_device_set_tiocm);
> 
> +int serdev_device_set_parity(struct serdev_device *serdev,
> +			     bool enable, bool odd)

Code calling this function will be difficult to read:

	serdev_device_set_partity(dev, true, false);

Without looking up the function definition, the last two arguments are not 
very explicit. How about replacing them with a disabled, odd, even enum ?

> +{
> +	struct serdev_controller *ctrl = serdev->ctrl;
> +
> +	if (!ctrl || !ctrl->ops->set_parity)
> +		return -ENOTSUPP;
> +
> +	return ctrl->ops->set_parity(ctrl, enable, odd);
> +}
> +EXPORT_SYMBOL_GPL(serdev_device_set_parity);
> +
>  static int serdev_drv_probe(struct device *dev)
>  {
>  	const struct serdev_device_driver *sdrv =
> to_serdev_device_driver(dev->driver); diff --git
> a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
> index 302018d..9114956 100644
> --- a/drivers/tty/serdev/serdev-ttyport.c
> +++ b/drivers/tty/serdev/serdev-ttyport.c
> @@ -195,6 +195,22 @@ static int ttyport_set_tiocm(struct serdev_controller
> *ctrl, unsigned int set, u return tty->driver->ops->tiocmset(tty, set,
> clear);
>  }
> 
> +static int ttyport_set_parity(struct serdev_controller *ctrl,
> +			      bool enable, bool odd)
> +{
> +	struct serport *serport = serdev_controller_get_drvdata(ctrl);
> +	struct tty_struct *tty = serport->tty;
> +	struct ktermios ktermios = tty->termios;
> +
> +	ktermios.c_cflag &= ~(PARENB | PARODD);
> +	if (enable)
> +		ktermios.c_cflag |= PARENB;
> +	if (odd)
> +		ktermios.c_cflag |= PARODD;
> +
> +	return tty_set_termios(tty, &ktermios);
> +}
> +
>  static const struct serdev_controller_ops ctrl_ops = {
>  	.write_buf = ttyport_write_buf,
>  	.write_flush = ttyport_write_flush,
> @@ -206,6 +222,7 @@ static const struct serdev_controller_ops ctrl_ops = {
>  	.wait_until_sent = ttyport_wait_until_sent,
>  	.get_tiocm = ttyport_get_tiocm,
>  	.set_tiocm = ttyport_set_tiocm,
> +	.set_parity = ttyport_set_parity,
>  };
> 
>  struct device *serdev_tty_port_register(struct tty_port *port,
> diff --git a/include/linux/serdev.h b/include/linux/serdev.h
> index e69402d..8b67fcd 100644
> --- a/include/linux/serdev.h
> +++ b/include/linux/serdev.h
> @@ -90,6 +90,7 @@ struct serdev_controller_ops {
>  	void (*wait_until_sent)(struct serdev_controller *, long);
>  	int (*get_tiocm)(struct serdev_controller *);
>  	int (*set_tiocm)(struct serdev_controller *, unsigned int, unsigned 
int);
> +	int (*set_parity)(struct serdev_controller *, bool, bool);
>  };
> 
>  /**
> @@ -298,6 +299,9 @@ static inline int serdev_device_set_rts(struct
> serdev_device *serdev, bool enabl return serdev_device_set_tiocm(serdev, 0,
> TIOCM_RTS);
>  }
> 
> +int serdev_device_set_parity(struct serdev_device *serdev,
> +			     bool enable, bool odd);
> +
>  /*
>   * serdev hooks into TTY core
>   */

-- 
Regards,

Laurent Pinchart
