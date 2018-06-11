From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: Re: [PATCH v2 21/24] rave-sp: Support for variants on modalias drivers
Date: Mon, 11 Jun 2018 17:21:42 +0200
Message-ID: <CAPybu_0wG_vrkAF4M4C9D2EmtEzT=DbGjFXS-KC=VWYfrr3ACQ@mail.gmail.com>
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
 <20180611115240.32606-22-ricardo.ribalda@gmail.com> <CAHp75VeeF4eNjyhhBxocRXboN3fRY=RjrT6QQ72=QJ-s8gvSfA@mail.gmail.com>
 <8912BE88-4AA3-44ED-9828-57666CB31522@holtmann.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8912BE88-4AA3-44ED-9828-57666CB31522@holtmann.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, LKML <linux-kernel@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>
List-Id: linux-serial@vger.kernel.org

Hello


On Mon, Jun 11, 2018 at 3:38 PM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Andy,
>
> >> Rave-sp behaves differently based on the device variant.
> >
> >
> >>        sp->variant =3D of_device_get_match_data(dev);
> >> +       if (!sp->variant) {
> >> +               id =3D serdev_match_id(rave_sp_serdev_id, serdev);
> >
> > I think you may leave the ID table where it is in the code and use link=
.
> >
> >> +               if (id)
> >> +                       sp->variant =3D (const struct rave_sp_variant =
*)
> >> +                                                       id->driver_dat=
a;
> >> +       }
> >
> > Perhaps a helper like it's done for ACPI / OF cases?
> >
> > [device_get_match_data() -> ]
> >  of_fwnode_device_get_match_data()
> >  acpi_fwnode_device_get_match_data()
>
> something like that and frankly this is trying to hard. This driver is cu=
rrently really DT specific and can be fixed up later. It is causing a lot o=
f noise in this patch series. I would really urge to focus on the core chan=
ges get prominent drivers support. I think hci_bcm.c is a good example sinc=
e a) we need to fix up Edison and b) new ACPI based tablets might be able t=
o allow for easy testing.

I can try to implement something like andy proposes, but if it turns
out too complicated we can remove this driver from the series.

Thanks!

>
> Regards
>
> Marcel
>


--=20
Ricardo Ribalda
