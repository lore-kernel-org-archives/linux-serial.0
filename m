From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v2 06/15] arm: dts: Add devicetree for OrangePi 2G IoT board
Date: Mon, 3 Dec 2018 09:53:00 -0800
Message-ID: <CAOesGMi=qFB0jTTAzTYxBduYf_7RVwOZkKNjckpqg6tbd3sPow@mail.gmail.com>
References: <20181121033652.12247-1-manivannan.sadhasivam@linaro.org>
 <20181121033652.12247-7-manivannan.sadhasivam@linaro.org> <CAL_JsqJ=88ORdgbRDn+VWk9=ydShidqwOxdAMfDbH4W2drnXzA@mail.gmail.com>
 <CAOesGMgSxwcmBLDvxsvcCJ9-NvJ3-wK8fZBZV2ZNuzAa1idi3w@mail.gmail.com> <CAL_JsqLZY_5rZ35YSGeH7wmEZoLP1TjG+0n4BWGiUBwOFSq-Vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqLZY_5rZ35YSGeH7wmEZoLP1TjG+0n4BWGiUBwOFSq-Vw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, linux-serial@vger.kernel.org, Amit Kucheria <amit.kucheria@linaro.org>, LinusW <linus.walleij@linaro.org>, zhao_steven@263.net, overseas.sales@unisoc.com
List-Id: linux-serial@vger.kernel.org

On Mon, Dec 3, 2018 at 9:21 AM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Mon, Dec 3, 2018 at 11:11 AM Olof Johansson <olof@lixom.net> wrote:
> >
> > On Mon, Dec 3, 2018 at 7:54 AM Rob Herring <robh+dt@kernel.org> wrote:
> > >
> > > On Tue, Nov 20, 2018 at 9:38 PM Manivannan Sadhasivam
> > > <manivannan.sadhasivam@linaro.org> wrote:
> > > >
> > > > Add initial devicetree support for OrangePi 2G IoT board from Xunlo=
ng.
> > > >
> > > > Signed-off-by: Andreas F=C3=A4rber <afaerber@suse.de>
> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.=
org>
> > > > ---
> > > >  arch/arm/boot/dts/Makefile                    |  2 +
> > > >  .../boot/dts/rda8810pl-orangepi-2g-iot.dts    | 40 +++++++++++++++=
++++
> > > >  2 files changed, 42 insertions(+)
> > > >  create mode 100644 arch/arm/boot/dts/rda8810pl-orangepi-2g-iot.dts
> > > >
> > > > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefil=
e
> > > > index b0e966d625b9..a0fdad8f10dd 100644
> > > > --- a/arch/arm/boot/dts/Makefile
> > > > +++ b/arch/arm/boot/dts/Makefile
> > > > @@ -806,6 +806,8 @@ dtb-$(CONFIG_ARCH_QCOM) +=3D \
> > > >         qcom-msm8974-sony-xperia-castor.dtb \
> > > >         qcom-msm8974-sony-xperia-honami.dtb \
> > > >         qcom-mdm9615-wp8548-mangoh-green.dtb
> > > > +dtb-$(CONFIG_ARCH_RDA) +=3D \
> > > > +       rda8810pl-orangepi-2g-iot.dtb
> > > >  dtb-$(CONFIG_ARCH_REALVIEW) +=3D \
> > >
> > > Question for Arnd/Olof: can we *please* start putting new SoC familie=
s
> > > in sub-dirs?
> >
> > I think we're at a point where it's becoming quite awkward to keep it
> > in a flat directory, yes.
> >
> > Best way to handle this is usually right before the closing of a merge
> > window, so let's do it then. It'll be a conflict-ridden mess if we try
> > to stage something in -next, so I'd rather just do it directly in our
> > tree as a one-shot thing.
>
> While I'd like to see the whole thing converted, I was only asking
> about this one platform. That should be doable now, right?

I'd rather apply this to current scheme and then move everything once,
instead of having maintainers go "Oh, I guess I need to move mine" and
we end up with an onslaught of conflicting pull requests to move
things apart.


-Olof
