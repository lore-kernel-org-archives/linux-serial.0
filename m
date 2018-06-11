From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 20/24] serdev: Make match_id accessible by drivers
Date: Mon, 11 Jun 2018 15:47:27 +0300
Message-ID: <CAHp75VcKxZdp=Rmkt=K+yHq2aFAfSsD+SrKvPsSCCVLmLgc1pA@mail.gmail.com>
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com> <20180611115240.32606-21-ricardo.ribalda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180611115240.32606-21-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

On Mon, Jun 11, 2018 at 2:52 PM, Ricardo Ribalda Delgado
<ricardo.ribalda@gmail.com> wrote:
> Drivers that make use of the driver_data field require to transverse the
> id_table. There is no reason to have one implementation per driver.

> +const struct serdev_device_id *serdev_match_id(
> +                       const struct serdev_device_id *id,
> +                       const struct serdev_device *sdev)

I think slightly better would be

const strunct serdev_device *
serdev_match_id(const struct serdev_device_id *id,
                       const struct serdev_device *sdev)

>  {
>         while (id->name[0]) {
>                 if (!strcmp(sdev->modalias, id->name))
> -                       return 1;
> +                       return id;
>                 id++;
>         }
>
> -       return 0;
> +       return NULL;
>  }
> +EXPORT_SYMBOL_GPL(serdev_match_id);

Can we avoid ping-pong changes in the series? I mean to introduce this
helper in this form in the first place?


> -               return serdev_match_id(sdrv->id_table, sdev);
> +               return serdev_match_id(sdrv->id_table, sdev) != NULL;

return !!serdev_match_id(...);
?


> +const struct serdev_device_id *serdev_match_id(
> +               const struct serdev_device_id *id,
> +               const struct serdev_device *sdev);

Same as above.

-- 
With Best Regards,
Andy Shevchenko
