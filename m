From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 21/24] rave-sp: Support for variants on modalias drivers
Date: Mon, 11 Jun 2018 15:54:36 +0300
Message-ID: <CAHp75VeeF4eNjyhhBxocRXboN3fRY=RjrT6QQ72=QJ-s8gvSfA@mail.gmail.com>
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com> <20180611115240.32606-22-ricardo.ribalda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180611115240.32606-22-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Jun 11, 2018 at 2:52 PM, Ricardo Ribalda Delgado
<ricardo.ribalda@gmail.com> wrote:
> Rave-sp behaves differently based on the device variant.


>         sp->variant = of_device_get_match_data(dev);
> +       if (!sp->variant) {
> +               id = serdev_match_id(rave_sp_serdev_id, serdev);

I think you may leave the ID table where it is in the code and use link.

> +               if (id)
> +                       sp->variant = (const struct rave_sp_variant *)
> +                                                       id->driver_data;
> +       }

Perhaps a helper like it's done for ACPI / OF cases?

[device_get_match_data() -> ]
  of_fwnode_device_get_match_data()
  acpi_fwnode_device_get_match_data()

-- 
With Best Regards,
Andy Shevchenko
