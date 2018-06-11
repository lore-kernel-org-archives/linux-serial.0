From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: Re: [PATCH v2 14/24] mfd: rave-sp: MODULE_DEVICE_TABLE(serdev)
Date: Mon, 11 Jun 2018 17:18:16 +0200
Message-ID: <CAPybu_3m8M5guQQQ+_wx9i7eU8qsUhZ1bRvmbdEnSsUPUtAe6A@mail.gmail.com>
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
 <20180611115240.32606-15-ricardo.ribalda@gmail.com> <EBCCCD1F-0F23-4599-8A78-32BBF2DAF746@holtmann.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <EBCCCD1F-0F23-4599-8A78-32BBF2DAF746@holtmann.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Marcel
On Mon, Jun 11, 2018 at 3:14 PM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Ricardo,
>
> > Export serdev table to the module header, allowing module autoload via
> > udev/modprobe.
> >
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: Johan Hovold <johan@kernel.org>
> > Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> > ---
> > drivers/mfd/rave-sp.c | 7 +++++++
> > 1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/mfd/rave-sp.c b/drivers/mfd/rave-sp.c
> > index 5c858e784a89..c0ecfbc16dca 100644
> > --- a/drivers/mfd/rave-sp.c
> > +++ b/drivers/mfd/rave-sp.c
> > @@ -694,12 +694,19 @@ static int rave_sp_probe(struct serdev_device *se=
rdev)
> >
> > MODULE_DEVICE_TABLE(of, rave_sp_dt_ids);
> >
> > +static struct serdev_device_id rave_sp_serdev_id[] =3D {
> > +     { "rave-sp", },
> > +     {}
> > +};
> > +MODULE_DEVICE_TABLE(serdev, rave_sp_serdev_id);
> > +
> > static struct serdev_device_driver rave_sp_drv =3D {
> >       .probe                  =3D rave_sp_probe,
> >       .driver =3D {
> >               .name           =3D "rave-sp",
> >               .of_match_table =3D rave_sp_dt_ids,
> >       },
> > +     .id_table =3D rave_sp_serdev_id,
> > };
> > module_serdev_device_driver(rave_sp_drv);
>
> so I would actually prefer that we not duplicate the .driver.name in the =
.id_table. This one for example is non-functional since all supported hardw=
are needs a specific .data entry. It will fail here:
>
>         sp->variant =3D of_device_get_match_data(dev);
>         if (!sp->variant)
>                 return -ENODEV;
>
> Maybe we focus first on getting the base support for new_device etc. merg=
ed and use the Edison Bluetooth platform driver support in hci_bcm.c so we =
can do a real cleanup there. And then later add broad new_device support. S=
ome of these instances should be just fine with never getting it since they=
 require to many per device quirks to make things functional. A blind searc=
h+replace is not going to work.

I think that functionality is added on another patch from the series.
Let me merge both together so the driver is functional (and builds)
from any point of the tree. Let me merge it in
https://github.com/ribalda/linux/tree/serdev3 and resend after I fixed
all the other suggestions


Thanks

>
> And things like device_get_match_data() should work as well even if the h=
ardware is listed via serdev_device_id. Drivers that are solely DT centric =
will need a lot more work before dynamic adding of serdev devices can happe=
n.
>
> Regards
>
> Marcel
>


--=20
Ricardo Ribalda
