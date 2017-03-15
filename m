From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] serdev: Add serdev_device_write subroutine
Date: Wed, 15 Mar 2017 09:18:36 -0500
Message-ID: <CAL_JsqKxFBFz-SHRQaDS0P4P_emBVBpkQFb0jN3oH6WM99t59g@mail.gmail.com>
References: <20170314134819.19476-1-andrew.smirnov@gmail.com> <20170314134819.19476-2-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170314134819.19476-2-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>, Guenter Roeck <linux@roeck-us.net>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Mar 14, 2017 at 8:48 AM, Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:
> Add serdev_device_write() which is a blocking call allowing to transfer
> arbitraty amount of data (potentially exceeding amount that
> serdev_device_write_buf can process in a single call)
>
> Cc: cphealy@gmail.com
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-serial@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  drivers/tty/serdev/core.c | 37 +++++++++++++++++++++++++++++++++++++
>  include/linux/serdev.h    | 23 +++++++++++++++++------
>  2 files changed, 54 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> index f4c6c90..759e834 100644
> --- a/drivers/tty/serdev/core.c
> +++ b/drivers/tty/serdev/core.c
> @@ -128,6 +128,41 @@ int serdev_device_write_buf(struct serdev_device *serdev,
>  }
>  EXPORT_SYMBOL_GPL(serdev_device_write_buf);
>
> +int serdev_device_write(struct serdev_device *serdev,
> +                       const unsigned char *buf, size_t count)

_write vs. _write_buf are not all that clear what the difference is.
but I don't have a better name.

Perhaps a timeout param is needed? This could never complete if CTS
remains deasserted.

> +{
> +       int ret = count;
> +
> +       if (serdev->ops->write_wakeup)
> +               return -EINVAL;
> +
> +       mutex_lock(&serdev->write_lock);
> +
> +       for (;;) {
> +               size_t chunk;
> +
> +               reinit_completion(&serdev->write_wakeup);

Perhaps write_comp instead as write_wakeup is already a function name.

> +
> +               chunk = serdev_device_write_buf(serdev, buf, count);
> +               if (chunk < 0) {
> +                       ret = chunk;
> +                       goto done;
> +               }
> +
> +               buf   += chunk;
> +               count -= chunk;
> +
> +               if (!count)
> +                       break;
> +
> +               wait_for_completion(&serdev->write_wakeup);
> +       }
> +done:
> +       mutex_unlock(&serdev->write_lock);
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(serdev_device_write);
> +
>  void serdev_device_write_flush(struct serdev_device *serdev)
>  {
>         struct serdev_controller *ctrl = serdev->ctrl;
> @@ -232,6 +267,8 @@ struct serdev_device *serdev_device_alloc(struct serdev_controller *ctrl)
>         serdev->dev.parent = &ctrl->dev;
>         serdev->dev.bus = &serdev_bus_type;
>         serdev->dev.type = &serdev_device_type;
> +       init_completion(&serdev->write_wakeup);
> +       mutex_init(&serdev->write_lock);
>         return serdev;
>  }
>  EXPORT_SYMBOL_GPL(serdev_device_alloc);
> diff --git a/include/linux/serdev.h b/include/linux/serdev.h
> index 5176cdc..8f7aa35 100644
> --- a/include/linux/serdev.h
> +++ b/include/linux/serdev.h
> @@ -35,16 +35,19 @@ struct serdev_device_ops {
>
>  /**
>   * struct serdev_device - Basic representation of an serdev device
> - * @dev:       Driver model representation of the device.
> - * @nr:                Device number on serdev bus.
> - * @ctrl:      serdev controller managing this device.
> - * @ops:       Device operations.
> + * @dev:        Driver model representation of the device.
> + * @nr:                 Device number on serdev bus.
> + * @ctrl:       serdev controller managing this device.
> + * @ops:        Device operations.
> + * @write_wakeup Completion used by serdev_device_write internally
>   */
>  struct serdev_device {
>         struct device dev;
>         int nr;
>         struct serdev_controller *ctrl;
>         const struct serdev_device_ops *ops;
> +       struct completion write_wakeup;
> +       struct mutex write_lock;
>  };
>
>  static inline struct serdev_device *to_serdev_device(struct device *d)
> @@ -162,10 +165,13 @@ static inline void serdev_controller_write_wakeup(struct serdev_controller *ctrl
>  {
>         struct serdev_device *serdev = ctrl->serdev;
>
> -       if (!serdev || !serdev->ops->write_wakeup)
> +       if (!serdev)
>                 return;
>
> -       serdev->ops->write_wakeup(serdev);
> +       if (serdev->ops->write_wakeup)
> +               serdev->ops->write_wakeup(serdev);
> +       else
> +               complete(&serdev->write_wakeup);
>  }
>
>  static inline int serdev_controller_receive_buf(struct serdev_controller *ctrl,
> @@ -187,6 +193,7 @@ void serdev_device_close(struct serdev_device *);
>  unsigned int serdev_device_set_baudrate(struct serdev_device *, unsigned int);
>  void serdev_device_set_flow_control(struct serdev_device *, bool);
>  int serdev_device_write_buf(struct serdev_device *, const unsigned char *, size_t);
> +int serdev_device_write(struct serdev_device *serdev, const unsigned char *buf, size_t count);

Drop the param names to be consistent with the rest of the declarations.

>  void serdev_device_write_flush(struct serdev_device *);
>  int serdev_device_write_room(struct serdev_device *);
>
> @@ -227,6 +234,10 @@ static inline int serdev_device_write_buf(struct serdev_device *sdev, const unsi
>  {
>         return -ENODEV;
>  }
> +static inline int serdev_device_write(struct serdev_device *sdev, const unsigned char *buf, size_t count)
> +{
> +       return -ENODEV;
> +}
>  static inline void serdev_device_write_flush(struct serdev_device *sdev) {}
>  static inline int serdev_device_write_room(struct serdev_device *sdev)
>  {
> --
> 2.9.3
>
