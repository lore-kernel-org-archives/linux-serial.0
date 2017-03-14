From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 1/2] serdev: Add serdev_device_write subroutine
Date: Wed, 15 Mar 2017 01:17:27 +0200
Message-ID: <CAHp75VfWCCS6L1fFi0Gq0r-CTQbaLk8pos+NWz5R_b0uBt6K1w@mail.gmail.com>
References: <20170314134819.19476-1-andrew.smirnov@gmail.com> <20170314134819.19476-2-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170314134819.19476-2-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Chris Healy <cphealy@gmail.com>, Guenter Roeck <linux@roeck-us.net>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Mar 14, 2017 at 3:48 PM, Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:
> Add serdev_device_write() which is a blocking call allowing to transfer
> arbitraty amount of data (potentially exceeding amount that
> serdev_device_write_buf can process in a single call)

> +int serdev_device_write(struct serdev_device *serdev,
> +                       const unsigned char *buf, size_t count)
> +{

> +       int ret = count;

If count by some reason bigger than INT_MAX...

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
> +
> +               chunk = serdev_device_write_buf(serdev, buf, count);


> +               if (chunk < 0) {

This will never happen. What kind of test did you try?

> +                       ret = chunk;
> +                       goto done;
> +               }


> +
> +               buf   += chunk;
> +               count -= chunk;
> +

> +               if (!count)

What is supposed to be returned? Initial count? Does it make any sense?

> +                       break;

Perhaps you need to refactor this function.

> +
> +               wait_for_completion(&serdev->write_wakeup);
> +       }

> +done:

It would be nice to have a suffix, like

done_unlock:


But I'm pretty sure if you refactor the code in a smart way you will
not need it.

> +       mutex_unlock(&serdev->write_lock);
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(serdev_device_write);

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

Does it make sense to shift? I would think of shorter field names instead.

> + * @write_wakeup Completion used by serdev_device_write internally

Colon is missed.

Another filed is missed.

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

By the way does this changes the possible context of application
(atomic / non-atomic)?

-- 
With Best Regards,
Andy Shevchenko
