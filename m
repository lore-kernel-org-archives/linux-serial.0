From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: Re: [PATCH 19/19] serdev: Instantiate a ttydev serdev if acpi and of fails
Date: Wed, 6 Jun 2018 09:28:43 +0200
Message-ID: <CAPybu_2rpXkJEDkJ+jBtja-U+KK2LfDubpXz22xL1UAtKNdACA@mail.gmail.com>
References: <20180529131014.18641-1-ricardo.ribalda@gmail.com>
 <20180529131014.18641-20-ricardo.ribalda@gmail.com> <CAHp75VeNhtJSa-2NJ5hCJP5yxtcaiNi-P8QA3BYCbGSNRfyvrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VeNhtJSa-2NJ5hCJP5yxtcaiNi-P8QA3BYCbGSNRfyvrg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

Hi Andy,

On Tue, Jun 5, 2018 at 3:44 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, May 29, 2018 at 4:10 PM, Ricardo Ribalda Delgado
> <ricardo.ribalda@gmail.com> wrote:
> > If a serdev ttyport controller does not have an acpi nor an of child,
> > create a ttydev as a child of that controller.
> >
> > Doing this allows the removal, addition and replacement of ttydev devices
> > at runtime.
>
> > @@ -619,6 +619,27 @@ static inline int acpi_serdev_register_devices(struct serdev_controller *ctrl)
> >  }
> >  #endif /* CONFIG_ACPI */
> >
> > +
>
> Redundant blank line.

ACK
>
> > +#if IS_ENABLED(CONFIG_SERIAL_DEV_CTRL_TTYDEV)
>
> > -       if (ret_of && ret_acpi) {
> > -               dev_dbg(&ctrl->dev, "no devices registered: of:%d acpi:%d\n",
> > -                       ret_of, ret_acpi);
> > +
> > +#if IS_ENABLED(CONFIG_SERIAL_DEV_CTRL_TTYDEV)
> > +       if (ret_of && ret_acpi && ctrl->is_ttyport)
> > +               ret_tty = serdev_controller_add_ttydev(ctrl);
> > +#endif
> > +
> > +       if (ret_of && ret_acpi && ret_tty) {
> > +               dev_dbg(&ctrl->dev,
> > +                       "no devices registered: of:%d acpi:%d tty:%d\n",
> > +                       ret_of, ret_acpi, ret_tty);
> >                 ret = -ENODEV;
> >                 goto out_dev_del;
> >         }
>
> Wouldn't be better to leave above if-condition and introduce your
> stuff inside it?

I have redesign the logic in the function on the next version

Thanks


-- 
Ricardo Ribalda
