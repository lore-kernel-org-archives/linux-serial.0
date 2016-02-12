From: Martin Sperl <kernel@martin.sperl.org>
Subject: Re: serial: clk: bcm2835: Strange effects when using aux-uart in console
Date: Fri, 12 Feb 2016 20:44:25 +0100
Message-ID: <6CD3FC59-BA17-43D9-897C-A2D122D26EF8@martin.sperl.org>
References: <A5F427B7-9B78-4892-9722-69418C4D0C10@martin.sperl.org> <56BC895E.2010108@sperl.org> <1617009200.323700.219000a8-c162-4594-aacc-a7e9894518b2.open-xchange@email.1und1.de> <662D2FB2-B088-4CFC-8416-A4F35BBAD7DD@sperl.org> <F7A2533A-D64C-4187-ABD4-416C446D1637@martin.sperl.org>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <F7A2533A-D64C-4187-ABD4-416C446D1637@martin.sperl.org>
Sender: linux-clk-owner@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Eric Anholt <eric@anholt.net>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-clk <linux-clk@vger.kernel.org>, linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org


> On 12.02.2016, at 18:34, Martin Sperl <kernel@martin.sperl.org> wrote=
:
>=20
> The screen is still blinking and UART does not work.
> Maybe the driver is not able to handle the =E2=80=9Cremapping=E2=80=9D
> of registers to a different range and is touching ram
> used by the FW?
>=20
> The only solution that I found is using fixed clocks
> in the device-tree (which is not what we intended:
> / {
>                clk_uart0: clock@3 {
>                        compatible =3D "fixed-clock";
>                        reg =3D <3>;
>                        #clock-cells =3D <0>;
>                        clock-output-names =3D "uart0_pclk";
>                        clock-frequency =3D <3000000>;
>                };
>=20
>                clk_apb_p: clock@4 {
>                        compatible =3D "fixed-clock";
>                        reg =3D <4>;
>                        #clock-cells =3D <0>;
>                        clock-output-names =3D "apb_pclk";
>                        clock-frequency =3D <126000000>;
>                };
> };
> &uart0 {
>        clocks =3D <&clk_uart0 &clk_apb_p>;
> };
>=20
> (so I have ruled out that the amba-pl011 writes to
> the wrong addresses).
>=20
> So as far as I can tell it is only clock related
> and when the new clock-framework is used it fails...

So the issue is triggered as soon as the plld_per
pll divider gets disabled/reenabled.

This happens because the clk_hw.core.prepare_count
drops down to 0 and then unprepare is called.

So we need to increase the ref-count for the pll
and pll_dividers to at least 1 so that these never
get disabled - at least for now until we can come
up with a better contract with the firmware.

Obviously this may impact other drivers as well
where a pll is used for the first time - if nothing
else uses it and the clock gets released, then
the clock would trigger a unprepare of the whole
branch of the clock tree.

The question is: how can we solve it in an acceptable
manner?

Do we need a driver that just holds a reference to
those clocks? Or should we just prepare the clock
after registering it in clk-bcm2835.c?

As for why does this not show up when compiled in?
It seems that in that case the amba_pl011 driver
never gets removed and then probed again.

This is possibly related to the optional use of DMA,
with the amba-pl011 driver that retries the install,
which is not supported on the bcm2835 - at least that
is what the datasheet says. And DMA is (probably) not
enabled during the early boot stages, so it does not
fail once when it tries to register DMA.

Thanks,
	Martin


