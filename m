From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2] serdev: Replace serdev_device_write_buf with serdev_device_write
Date: Tue, 28 Mar 2017 20:07:05 +0300
Message-ID: <CAHp75VdHWE6jK12Q=2wGV-J5eCYWiAWnLFwz2r8AcJJQvAaztA@mail.gmail.com>
References: <20170328160139.7739-1-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170328160139.7739-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Chris Healy <cphealy@gmail.com>, Guenter Roeck <linux@roeck-us.net>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Mar 28, 2017 at 7:01 PM, Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:
> Convert serdev_device_write_buf's code to be able to transfer amount of
> data potentially exceeding "write room" at the moment of invocation.
>
> To support that, also add serdev_device_write_wakeup.
>
> Drivers wanting to use full extent of serdev_device_write
> functionality are expected to provide serdev_device_write_wakeup as a
> sole handler of .write_wakeup event or call it as a part of driver's
> custom .write_wakeup code.
>
> Drivers wanting to retain old serdev_device_write_buf behaviour can

> replace those call to calls to serdev_device_write with timeout of
> 0. Providing .write_wakeup handler in such case is optional.

Some indentation would be better if, for example, 0 will be kept on
previous line.

So, what I would see if no one objects is patch series of two:
1) introduction of new API
2) removing old one.

It will benefit for easier review and any potential code anthropologist.

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

Extra white spaces.

> +               count -= ret;
> +

> +       } while (count &&
> +                (timeout = wait_for_completion_timeout(&serdev->write_comp,
> +                                                       timeout)));

So, would it be better to support interrupts here and return a
corresponding error code to the user?

Besides that question, readability might be better if you use
temporary variable and pack above on one line:

unsigned long to = timeout;

} while (count && (to = ...(to)));



> +       mutex_unlock(&serdev->write_lock);
> +       return ret < 0 ? ret : (count ? -ETIMEDOUT : 0);
>  }
> -EXPORT_SYMBOL_GPL(serdev_device_write_buf);
> +EXPORT_SYMBOL_GPL(serdev_device_write);

> + * @write_comp Completion used by serdev_device_write internally

Links to the functions are func()-like. Please check kernel doc howto:s.

> + * @write_lock Mutext used to esure exclusive access to the bus when
> + *             writing data with serdev_device_write()

checkpatch.pl has integrated spellchecker AFAIU.
Moreover, can you try harder to make that description shorter?

>  void serdev_device_write_flush(struct serdev_device *);
>  int serdev_device_write_room(struct serdev_device *);
>
> +
>  /*
>   * serdev device driver functions
>   */

This doesn't belong to the change.

-- 
With Best Regards,
Andy Shevchenko
