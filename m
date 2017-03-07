From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 07/10] serdev: add serdev_device_wait_until_sent
Date: Tue, 7 Mar 2017 09:34:49 -0600
Message-ID: <CAL_Jsq+BCE1u6Ysz0FOdh--wHm-PZxqcmqTgQMyDcvQNkYp3gw@mail.gmail.com>
References: <20170304115833.3538-1-sre@kernel.org> <20170304115833.3538-8-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170304115833.3538-8-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Mark Rutland <mark.rutland@arm.com>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Sat, Mar 4, 2017 at 5:58 AM, Sebastian Reichel <sre@kernel.org> wrote:
> Add method, which waits until the transmission buffer has been sent.
>
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---
>  drivers/tty/serdev/core.c           | 11 +++++++++++
>  drivers/tty/serdev/serdev-ttyport.c | 15 ++++++++++++++-
>  include/linux/serdev.h              |  3 +++
>  3 files changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> index f4c6c90add78..a63b74031e22 100644
> --- a/drivers/tty/serdev/core.c
> +++ b/drivers/tty/serdev/core.c
> @@ -173,6 +173,17 @@ void serdev_device_set_flow_control(struct serdev_device *serdev, bool enable)
>  }
>  EXPORT_SYMBOL_GPL(serdev_device_set_flow_control);
>
> +void serdev_device_wait_until_sent(struct serdev_device *serdev, long timeout)
> +{
> +       struct serdev_controller *ctrl = serdev->ctrl;
> +
> +       if (!ctrl || !ctrl->ops->wait_until_sent)
> +               return;
> +
> +       ctrl->ops->wait_until_sent(ctrl, timeout);
> +}
> +EXPORT_SYMBOL_GPL(serdev_device_wait_until_sent);
> +
>  static int serdev_drv_probe(struct device *dev)
>  {
>         const struct serdev_device_driver *sdrv = to_serdev_device_driver(dev->driver);
> diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
> index d05393594f15..db2bc601e554 100644
> --- a/drivers/tty/serdev/serdev-ttyport.c
> +++ b/drivers/tty/serdev/serdev-ttyport.c
> @@ -14,6 +14,7 @@
>  #include <linux/serdev.h>
>  #include <linux/tty.h>
>  #include <linux/tty_driver.h>
> +#include <linux/poll.h>
>
>  #define SERPORT_ACTIVE         1
>
> @@ -47,10 +48,13 @@ static void ttyport_write_wakeup(struct tty_port *port)
>         struct serport *serport = serdev_controller_get_drvdata(ctrl);
>
>         if (!test_and_clear_bit(TTY_DO_WRITE_WAKEUP, &port->tty->flags))
> -               return;
> +               goto out;
>
>         if (test_bit(SERPORT_ACTIVE, &serport->flags))
>                 serdev_controller_write_wakeup(ctrl);
> +
> +out:
> +       wake_up_interruptible_poll(&port->tty->write_wait, POLLOUT);

Shouldn't this be separate patch?

Rob
