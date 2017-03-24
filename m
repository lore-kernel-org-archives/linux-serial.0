From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] serdev: Replace serdev_device_write_buf with serdev_device_write
Date: Fri, 24 Mar 2017 13:31:19 -0500
Message-ID: <CAL_JsqJk7B6WEjyyZxdx+UUfaVx6u3dmcUo827DhkfVoDsx08w@mail.gmail.com>
References: <20170320165628.26738-1-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170320165628.26738-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>, Guenter Roeck <linux@roeck-us.net>, Andy Shevchenko <andy.shevchenko@gmail.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Mar 20, 2017 at 11:56 AM, Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:
> Convert serdev_device_write_buf's code to be able to transfer amount of
> data potentially exceeding "write room" at the moment of invocation.
>
> To support that, also add serdev_device_write_wakeup.
>
> Drivers wanting to use full extent of serdev_device_write functionality
> asre expected to provide serdev_device_write_wakeup as a sole handler of
> .write_wakeup event or call it as a part of driver's custom
> .write_wakeup code.
>
> Drivers wanting to retain old serdev_device_write_buf behaviour can
> replace those call to calls to serdev_device_write with timeout of
> 0. Providing .write_wakeup handler in such case is optional.

Looks good, just a couple of things.

>
> Cc: cphealy@gmail.com
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: linux-serial@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  drivers/tty/serdev/core.c | 36 +++++++++++++++++++++++++++++++-----
>  include/linux/serdev.h    | 11 +++++++++--
>  2 files changed, 40 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> index f4c6c90..9962d84 100644
> --- a/drivers/tty/serdev/core.c
> +++ b/drivers/tty/serdev/core.c
> @@ -116,17 +116,41 @@ void serdev_device_close(struct serdev_device *serdev)
>  }
>  EXPORT_SYMBOL_GPL(serdev_device_close);
>
> -int serdev_device_write_buf(struct serdev_device *serdev,
> -                           const unsigned char *buf, size_t count)
> +void serdev_device_write_wakeup(struct serdev_device *serdev)
> +{
> +       complete(&serdev->write_comp);
> +}
> +EXPORT_SYMBOL_GPL(serdev_device_write_wakeup);
> +
> +int serdev_device_write(struct serdev_device *serdev,
> +                       const unsigned char *buf, size_t count,
> +                       unsigned long timeout)
>  {
>         struct serdev_controller *ctrl = serdev->ctrl;
> +       int ret;
>
> -       if (!ctrl || !ctrl->ops->write_buf)
> +       if (!ctrl || !ctrl->ops->write_buf ||
> +           (timeout && !serdev->ops->write_wakeup))
>                 return -EINVAL;
>
> -       return ctrl->ops->write_buf(ctrl, buf, count);
> +       mutex_lock(&serdev->write_lock);
> +       do {
> +               reinit_completion(&serdev->write_comp);
> +
> +               ret = ctrl->ops->write_buf(ctrl, buf, count);
> +               if (ret < 0)
> +                       break;
> +
> +               buf   += ret;
> +               count -= ret;
> +
> +       } while (count &&
> +                wait_for_completion_timeout(&serdev->write_comp,
> +                                            timeout));

This is going to wait for timeout time on each loop. We want the
timeout passed in to be the total time.

> +       mutex_unlock(&serdev->write_lock);
> +       return ret < 0 ? ret : (count ? -ETIMEDOUT : 0);
>  }
> -EXPORT_SYMBOL_GPL(serdev_device_write_buf);
> +EXPORT_SYMBOL_GPL(serdev_device_write);
>
>  void serdev_device_write_flush(struct serdev_device *serdev)
>  {
> @@ -232,6 +256,8 @@ struct serdev_device *serdev_device_alloc(struct serdev_controller *ctrl)
>         serdev->dev.parent = &ctrl->dev;
>         serdev->dev.bus = &serdev_bus_type;
>         serdev->dev.type = &serdev_device_type;
> +       init_completion(&serdev->write_comp);
> +       mutex_init(&serdev->write_lock);
>         return serdev;
>  }
>  EXPORT_SYMBOL_GPL(serdev_device_alloc);
> diff --git a/include/linux/serdev.h b/include/linux/serdev.h
> index 5176cdc..18cbbed 100644
> --- a/include/linux/serdev.h
> +++ b/include/linux/serdev.h
> @@ -39,12 +39,17 @@ struct serdev_device_ops {
>   * @nr:                Device number on serdev bus.
>   * @ctrl:      serdev controller managing this device.
>   * @ops:       Device operations.
> + * @write_comp Completion used by serdev_device_write internally
> + * @write_lock Mutext used to esure exclusive access to the bus when
> + *             writing data with serdev_device_write()
>   */
>  struct serdev_device {
>         struct device dev;
>         int nr;
>         struct serdev_controller *ctrl;
>         const struct serdev_device_ops *ops;
> +       struct completion write_comp;
> +       struct mutex write_lock;
>  };
>
>  static inline struct serdev_device *to_serdev_device(struct device *d)
> @@ -186,10 +191,12 @@ int serdev_device_open(struct serdev_device *);
>  void serdev_device_close(struct serdev_device *);
>  unsigned int serdev_device_set_baudrate(struct serdev_device *, unsigned int);
>  void serdev_device_set_flow_control(struct serdev_device *, bool);
> -int serdev_device_write_buf(struct serdev_device *, const unsigned char *, size_t);
> +void serdev_device_write_wakeup(struct serdev_device *);
> +int serdev_device_write(struct serdev_device *, const unsigned char *, size_t, unsigned long);
>  void serdev_device_write_flush(struct serdev_device *);
>  int serdev_device_write_room(struct serdev_device *);
>
> +
>  /*
>   * serdev device driver functions
>   */
> @@ -223,7 +230,7 @@ static inline unsigned int serdev_device_set_baudrate(struct serdev_device *sdev
>         return 0;
>  }
>  static inline void serdev_device_set_flow_control(struct serdev_device *sdev, bool enable) {}
> -static inline int serdev_device_write_buf(struct serdev_device *sdev, const unsigned char *buf, size_t count)

We probably should keep a wrapper for serdev_device_write_buf to avoid
cross tree dependencies. However, the Nokia BT support is going to
have them anyway.

> +static inline int serdev_device_write(struct serdev_device *sdev, const unsigned char *buf, size_t count)
>  {
>         return -ENODEV;
>  }
> --
> 2.9.3
>
