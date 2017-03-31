From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3] serdev: Add serdev_device_write subroutine
Date: Fri, 31 Mar 2017 14:43:23 +0300
Message-ID: <CAHp75Vdv0zMiwVd==kD8yhS3sFhpYv07LnjmtWKqu2Hb-Oxriw@mail.gmail.com>
References: <20170330220035.26649-1-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170330220035.26649-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Chris Healy <cphealy@gmail.com>, Guenter Roeck <linux@roeck-us.net>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Mar 31, 2017 at 1:00 AM, Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:
> Add serdev_device_write() a blocking call allowing to transfer
> arbitraty amount of data (potentially exceeding amount that
> serdev_device_write_buf can process in a single call)
>
> To support that, also add serdev_device_write_wakeup().
>
> Drivers wanting to use full extent of serdev_device_write
> functionality are expected to provide serdev_device_write_wakeup() as
> a sole handler of .write_wakeup event or call it as a part of driver's
> custom .write_wakeup code.
>
> Because serdev_device_write() subroutine is a superset of
> serdev_device_write_buf() the patch re-impelements latter is terms of
> the former. For drivers watning to just use serdev_device_write_buf()
> .write_wakeup handler is optional.
>

There are still style inconveniences I notice, but let me avoid
bikeshedding here, so
FWIW:
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Cc: cphealy@gmail.com
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: linux-serial@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>
> Changes since v2 (see [v2]):
>
>         - Changed subject and commit message wording to better reflect
>           nature of the patch
>
>         - Various spelling, formatting, documentation and wording
>           fixes as caught/suggested by Andy
>
> Changes since v1 (see [v1]):
>
>         - Make timeout to be a total(as opposed to per-iteration)
>           timeout
>
>         - Keep serdev_device_write_buf() as a wrapper arount
>           serdev_device_write() for compatibility
>
> [v2] https://lkml.org/lkml/2017/3/28/942
> [v1] https://lkml.org/lkml/2017/3/20/650
>
>  drivers/tty/serdev/core.c | 36 +++++++++++++++++++++++++++++++-----
>  include/linux/serdev.h    | 17 +++++++++++++++--
>  2 files changed, 46 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> index f4c6c90..6701d10 100644
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
> +               buf += ret;
> +               count -= ret;
> +
> +       } while (count &&
> +                (timeout = wait_for_completion_timeout(&serdev->write_comp,
> +                                                       timeout)));
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
> index 5176cdc..0beaff8 100644
> --- a/include/linux/serdev.h
> +++ b/include/linux/serdev.h
> @@ -39,12 +39,16 @@ struct serdev_device_ops {
>   * @nr:                Device number on serdev bus.
>   * @ctrl:      serdev controller managing this device.
>   * @ops:       Device operations.
> + * @write_comp Completion used by serdev_device_write() internally
> + * @write_lock Lock to serialize access when writing data
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
> @@ -186,7 +190,8 @@ int serdev_device_open(struct serdev_device *);
>  void serdev_device_close(struct serdev_device *);
>  unsigned int serdev_device_set_baudrate(struct serdev_device *, unsigned int);
>  void serdev_device_set_flow_control(struct serdev_device *, bool);
> -int serdev_device_write_buf(struct serdev_device *, const unsigned char *, size_t);
> +void serdev_device_write_wakeup(struct serdev_device *);
> +int serdev_device_write(struct serdev_device *, const unsigned char *, size_t, unsigned long);
>  void serdev_device_write_flush(struct serdev_device *);
>  int serdev_device_write_room(struct serdev_device *);
>
> @@ -223,7 +228,8 @@ static inline unsigned int serdev_device_set_baudrate(struct serdev_device *sdev
>         return 0;
>  }
>  static inline void serdev_device_set_flow_control(struct serdev_device *sdev, bool enable) {}
> -static inline int serdev_device_write_buf(struct serdev_device *sdev, const unsigned char *buf, size_t count)
> +static inline int serdev_device_write(struct serdev_device *sdev, const unsigned char *buf,
> +                                     size_t count, unsigned long timeout)
>  {
>         return -ENODEV;
>  }
> @@ -259,4 +265,11 @@ static inline struct device *serdev_tty_port_register(struct tty_port *port,
>  static inline void serdev_tty_port_unregister(struct tty_port *port) {}
>  #endif /* CONFIG_SERIAL_DEV_CTRL_TTYPORT */
>
> +static inline int serdev_device_write_buf(struct serdev_device *serdev,
> +                                         const unsigned char *data,
> +                                         size_t count)
> +{
> +       return serdev_device_write(serdev, data, count, 0);
> +}
> +
>  #endif /*_LINUX_SERDEV_H */
> --
> 2.9.3
>



-- 
With Best Regards,
Andy Shevchenko
