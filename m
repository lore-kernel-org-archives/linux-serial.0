From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: serial: clk: bcm2835: Strange effects when using aux-uart in
 console
Date: Tue, 16 Feb 2016 20:29:16 +0100 (CET)
Message-ID: <43491797.472221.74f5f000-03c2-453a-a849-faa85305b11d.open-xchange@email.1und1.de>
References: <A5F427B7-9B78-4892-9722-69418C4D0C10@martin.sperl.org>
 <56BC895E.2010108@sperl.org>
 <1617009200.323700.219000a8-c162-4594-aacc-a7e9894518b2.open-xchange@email.1und1.de>
 <662D2FB2-B088-4CFC-8416-A4F35BBAD7DD@sperl.org>
 <F7A2533A-D64C-4187-ABD4-416C446D1637@martin.sperl.org>
 <6CD3FC59-BA17-43D9-897C-A2D122D26EF8@martin.sperl.org>
 <470852136.382408.76a8faee-9235-4ee0-9fd1-e25a1e9f0bb3.open-xchange@email.1und1.de>
 <EE05C090-EB8A-41E8-B9C3-8CCC79F15FE9@martin.sperl.org>
 <359843746.379810.6eb6c2f5-8282-417a-83d1-1fa79425ff73.open-xchange@email.1und1.de>
 <D4D8C3EE-7BDC-44F4-A54F-A6861FE0A174@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <D4D8C3EE-7BDC-44F4-A54F-A6861FE0A174@martin.sperl.org>
Sender: linux-clk-owner@vger.kernel.org
To: Martin Sperl <kernel@martin.sperl.org>
Cc: linux-serial@vger.kernel.org, linux-clk <linux-clk@vger.kernel.org>, Eric Anholt <eric@anholt.net>, linux-arm-kernel@lists.infradead.org, linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

Hi Martin,

> Martin Sperl <kernel@martin.sperl.org> hat am 16. Februar 2016 um 17:=
31
> geschrieben:
>
>
>
> > On 13.02.2016, at 21:45, Stefan Wahren <stefan.wahren@i2se.com> wro=
te:
> >
> >
> > According to the datasheet busy bit shouldn't be set while changing=
 the
> > clock.
> > So this isn't good. I hope this could be fixed, too.
> >
>
> I had hoped that the patch by Eric:
> "clk: bcm2835: Fix setting of PLL divider clock rates"
> would fix the issue, but that was unfortunately not the case.
>
> Some more investigation using the debugfs patch I had posted,
> which exposes the registers showed that:
> plld_per_a2w had a value of 4 before starting getty
> and a value of 0 after starting getty.
>
> That made me investigate why this value was changed and I found
> the culprit in the form of:
> @@ -1167,7 +1171,9 @@ static void bcm2835_pll_divider_off(struct clk_=
hw *hw)
> cprman_write(cprman, data->cm_reg,
> (cprman_read(cprman, data->cm_reg) &
> ~data->load_mask) | data->hold_mask);
> - cprman_write(cprman, data->a2w_reg, A2W_PLL_CHANNEL_DISABLE);
> + cprman_write(cprman, data->a2w_reg,
> + cprman_read(cprman, data->a2w_reg) |
> + A2W_PLL_CHANNEL_DISABLE);
> }

good job. This change make sense because the divider value shouldn't be=
 zero.

But maybe we should protect the RMW by a lock like in bcm2835_clock_off=
?

>
> after that (with plld itself marked as =E2=80=9Cprepared=E2=80=9D dur=
ing probe) everything is
> working fine.
>
> bcm2835_pll_off shows a similar pattern, but patching that
> the same way:
> @@ -955,8 +955,12 @@ static void bcm2835_pll_off(struct clk_hw *hw)
> struct bcm2835_cprman *cprman =3D pll->cprman;
> const struct bcm2835_pll_data *data =3D pll->data;
>
> - cprman_write(cprman, data->cm_ctrl_reg, CM_PLL_ANARST);
> - cprman_write(cprman, data->a2w_ctrl_reg, A2W_PLL_CTRL_PWRDN);
> + cprman_write(cprman, data->cm_ctrl_reg,
> + cprman_read(cprman, data->cm_ctrl_reg) |
> + CM_PLL_ANARST);
> + cprman_write(cprman, data->a2w_ctrl_reg,
> + cprman_read(cprman, data->a2w_ctrl_reg) |
> + A2W_PLL_CTRL_PWRDN);
> }
>
> does not resolve the issue - the system crashes - but without he pll
> lock message=E2=80=A6

Without the knowledge about the registers it's hard to say what exactly=
 causes
the crash.

Regards
Stefan
