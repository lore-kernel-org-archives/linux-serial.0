From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 02/14] dt-bindings: soc: milbeaut: Add Milbeaut trampoline
 description
Date: Fri, 30 Nov 2018 00:16:37 -0800
Message-ID: <154356579701.88331.5043467509900444879@swboyd.mtv.corp.google.com>
References: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com>
 <1542589274-13878-3-git-send-email-sugaya.taichi@socionext.com>
 <154337047410.88331.9696178601340675631@swboyd.mtv.corp.google.com>
 <c746a3de-a9e3-9f25-ecb9-703ceb7e62d0@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c746a3de-a9e3-9f25-ecb9-703ceb7e62d0@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Sugaya, Taichi" <sugaya.taichi@socionext.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Russell King <linux@armlinux.org.uk>, Jiri Slaby <jslaby@suse.com>, Masami Hiramatsu <masami.hiramatsu@linaro.org>, Jassi Brar <jaswinder.singh@linaro.org>
List-Id: linux-serial@vger.kernel.org

Quoting Sugaya, Taichi (2018-11-29 04:24:51)
> On 2018/11/28 11:01, Stephen Boyd wrote:
> > Quoting Sugaya Taichi (2018-11-18 17:01:07)
> >>   create mode 100644 Documentation/devicetree/bindings/soc/socionext/s=
ocionext,m10v.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/soc/socionext/socionext=
,m10v.txt b/Documentation/devicetree/bindings/soc/socionext/socionext,m10v.=
txt
> >> new file mode 100644
> >> index 0000000..f5d906c
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/soc/socionext/socionext,m10v.t=
xt
> >> @@ -0,0 +1,12 @@
> >> +Socionext M10V SMP trampoline driver binding
> >> +
> >> +This is a driver to wait for sub-cores while boot process.
> >> +
> >> +- compatible: should be "socionext,smp-trampoline"
> >> +- reg: should be <0x4C000100 0x100>
> >> +
> >> +EXAMPLE
> >> +       trampoline: trampoline@0x4C000100 {
> > Drop the 0x part of unit addresses.
> =

> Okay.
> =

> =

> >> +               compatible =3D "socionext,smp-trampoline";
> >> +               reg =3D <0x4C000100 0x100>;
> > Looks like a software construct, which we wouldn't want to put into DT
> > this way. DT doesn't describe drivers.
> We would like to use this node only getting the address of the =

> trampoline area
> in which sub-cores wait.=C2=A0 (They have finished to go to this area in =
previous
> bootloader process.)

Is this area part of memory, or a special SRAM? If it's part of memory,
I would expect this node to be under the reserved-memory node and
pointed to by some other node that uses this region. Could even be the
CPU nodes.

> =

> So should we embed the constant value in source codes instead of getting =

> from
> DT because the address is constant at the moment? Or is there other =

> approach?
> =


If it's constant then that also works. Why does it need to come from DT
at all then?
