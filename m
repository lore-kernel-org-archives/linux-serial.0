From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: Re: [PATCH 18/19] serdev: ttydev: Serdev driver that creates an
 standard TTY port
Date: Wed, 6 Jun 2018 09:47:27 +0200
Message-ID: <CAPybu_2dqG1HX39e+oG8rYvzMG_vGDBQjiLewNjwUvkh+AiF=w@mail.gmail.com>
References: <20180529131014.18641-1-ricardo.ribalda@gmail.com>
 <20180529131014.18641-19-ricardo.ribalda@gmail.com> <CAHp75VfFTtysSBvYfmCMoKZz8BpHb73qh=Zy-gpn6RKO2DE-5Q@mail.gmail.com>
 <CAPybu_0zByhDeVf6_Tv_PwU0WL_y6bkVPn0ha+VBvPcxWV4rLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPybu_0zByhDeVf6_Tv_PwU0WL_y6bkVPn0ha+VBvPcxWV4rLA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

Hi Andy,
On Wed, Jun 6, 2018 at 8:58 AM Ricardo Ribalda Delgado
<ricardo.ribalda@gmail.com> wrote:
>
> Hi Andy
> On Tue, Jun 5, 2018 at 3:42 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Tue, May 29, 2018 at 4:10 PM, Ricardo Ribalda Delgado
> > <ricardo.ribalda@gmail.com> wrote:
> > > Standard TTY port that can be loaded/unloaded via serdev sysfs. This
> > > serdev driver can only be used by serdev controllers that are compatible
> > > with ttyport.
> >
> > > +config SERIAL_DEV_CTRL_TTYDEV
> > > +       tristate "TTY port dynamically loaded by the Serial Device Bus"
> > > +       help
> > > +         Say Y here if you want to create a bridge driver between the Serial
> > > +         device bus and the TTY chardevice. This driver can be dynamically
> > > +         loaded/unloaded by the Serial Device Bus.
> > > +
> > > +         If unsure, say Y.
> > > +       depends on SERIAL_DEV_CTRL_TTYPORT
> >
> > > +       default m
> >
> > Hmm... Can't we survive w/o this by default?
>
> If this module is not available and serdev is enabled the user would
> miss his /dev/ttyS* nodes, so I rather leave this on.

Sorry, brain fart. This is exactly what #if
IS_ENABLED(CONFIG_SERIAL_DEV_CTRL_TTYDEV) prevents.

I have defaulted the module to n as you suggested. You can take a look
to the patches that I plan to submit tomorrow at:

https://github.com/ribalda/linux/tree/serdev2

>
> >
> > > +static int __init ttydev_serdev_init(void)
> > > +{
> > > +       return serdev_device_driver_register(&ttydev_serdev_driver);
> > > +}
> > > +module_init(ttydev_serdev_init);
> > > +
> > > +static void __exit ttydev_serdev_exit(void)
> > > +{
> > > +       return serdev_device_driver_unregister(&ttydev_serdev_driver);
> > > +}
> > > +module_exit(ttydev_serdev_exit);
> >
> > Isn't above is just a macro in serdev.h?
> > I.e. module_serdev_device_driver().
>
> ACK, thanks!
> >
> > --
> > With Best Regards,
> > Andy Shevchenko
>
> Best regards
>
> --
> Ricardo Ribalda



-- 
Ricardo Ribalda
