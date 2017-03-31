From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3] serdev: Add serdev_device_write subroutine
Date: Fri, 31 Mar 2017 08:22:28 -0500
Message-ID: <CAL_Jsq+W3UcmmRNuTALczAHCO_wHTDcDz4jXBJgJeB0X-3oGBA@mail.gmail.com>
References: <20170330220035.26649-1-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170330220035.26649-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>, Guenter Roeck <linux@roeck-us.net>, Andy Shevchenko <andy.shevchenko@gmail.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Mar 30, 2017 at 5:00 PM, Andrey Smirnov
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

typo

> .write_wakeup handler is optional.
>
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

Need to test for timeout < 0 here and return timeout when < 0.

Rob
