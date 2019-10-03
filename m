From: Mateusz Holenko <mholenko@antmicro.com>
Subject: Re: [PATCH 2/3] dt-bindings: serial: document LiteUART bindings
Date: Thu, 3 Oct 2019 11:23:29 +0200
Message-ID: <CAPk366QHtjL9qJV3RRwa=3tW-GB5PfLC1qzc0WgYbRzdMcZrYQ@mail.gmail.com>
References: <20190930130430.GA9080@localhost.localdomain> <CAL_JsqLXJNvWOOajS4JVVek=h+v_Fxrx58ogQ0Cz+5n5Sh0+=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqLXJNvWOOajS4JVVek=h+v_Fxrx58ogQ0Cz+5n5Sh0+=g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, devicetree@vger.kernel.org, Karol Gugala <kgugala@antmicro.com>, Jiri Slaby <jslaby@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Maxime Ripard <mripard@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Sam Ravnborg <sam@ravnborg.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Icenowy Zheng <icenowy@aosc.io>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, "Paul E. McKenney" <paulmck@linux.ibm.com>
List-Id: linux-serial@vger.kernel.org

pon., 30 wrz 2019 o 23:32 Rob Herring <robh+dt@kernel.org> napisa=C5=82(a):
>
> On Mon, Sep 30, 2019 at 8:04 AM Mateusz Holenko <mholenko@antmicro.com> w=
rote:
> >
> > From: Filip Kokosinski <fkokosinski@internships.antmicro.com>
> >
> > Add documentation for LiteUART devicetree bindings.
> >
> > Signed-off-by: Filip Kokosinski <fkokosinski@internships.antmicro.com>
> > Signed-off-by: Mateusz Holenko <mholenko@antmicro.com>
> > ---
> >  .../devicetree/bindings/serial/litex,liteuart.txt    | 12 ++++++++++++
> >  MAINTAINERS                                          |  6 ++++++
> >  2 files changed, 18 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/serial/litex,lite=
uart.txt
>
> Please make this a schema. See
> Documentation/devicetree/writing-schema.rst (or .md before 5.4).

Ok. We will rewrite it.

> >
> > diff --git a/Documentation/devicetree/bindings/serial/litex,liteuart.tx=
t b/Documentation/devicetree/bindings/serial/litex,liteuart.txt
> > new file mode 100644
> > index 000000000..13c71a0c9
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/serial/litex,liteuart.txt
> > @@ -0,0 +1,12 @@
> > +LiteUART serial controller
> > +
> > +Required properties:
> > +- compatible: should be "litex,liteuart"
>
> Only 1 version?

For the time being there is only one flavor.

> > +- reg: base address and length of the register set for this device
>
> Is there really no interrupt line? That should be added if there's h/w
> support even if the driver doesn't yet support it.
>
> > +
> > +Example:
> > +
> > +uart0: serial@f0001000 {
>
> Wrong unit address. Should be "@e0001800".

Right, address should be consistent with the one in 'reg'.

>
> > +       compatible =3D "litex,liteuart";
> > +       reg =3D <0xe0001800 0x100>;
> > +};
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index b2326dece..65a6cf296 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -9462,6 +9462,12 @@ F:       Documentation/misc-devices/lis3lv02d.rs=
t
> >  F:     drivers/misc/lis3lv02d/
> >  F:     drivers/platform/x86/hp_accel.c
> >
> > +LITEX PLATFORM
> > +M:     Karol Gugala <kgugala@antmicro.com>
> > +M:     Mateusz Holenko <mholenko@antmicro.com>
> > +S:     Maintained
> > +F:     Documentation/devicetree/bindings/serial/litex,liteuart.txt
> > +
> >  LIVE PATCHING
> >  M:     Josh Poimboeuf <jpoimboe@redhat.com>
> >  M:     Jiri Kosina <jikos@kernel.org>
> > --
> > 2.23.0
> >

Thanks for your comments.
I'll address the remarks in V2 of the patchset after receiving a
response on the rest of the patches.

--
Mateusz Holenko
mobile: +48 606 791 789
Antmicro Ltd | www.antmicro.com
Zwierzyniecka 3, 60-813 Poznan, Poland
