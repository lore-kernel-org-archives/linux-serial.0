From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v7 3/6] dt-bindings: pinctrl: mt8183: add binding document
Date: Tue, 19 Feb 2019 09:21:57 -0600
Message-ID: <CAL_JsqKgp615eJZnSu6aogzLwubnBKdxdU8+19hj=hS1aOWefA@mail.gmail.com>
References: <1550210558-30516-1-git-send-email-erin.lo@mediatek.com>
 <1550210558-30516-4-git-send-email-erin.lo@mediatek.com> <20190218163211.GB2714@bogus>
 <1550544357.4739.32.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550544357.4739.32.camel@mhfsdcap03>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhiyong Tao <zhiyong.tao@mediatek.com>
Cc: Erin Lo <erin.lo@mediatek.com>, Linus Walleij <linus.walleij@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Boyd <sboyd@codeaurora.org>, devicetree@vger.kernel.org, srv_heupstream <srv_heupstream@mediatek.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, Yingjoe Chen <yingjoe.chen@media>
List-Id: linux-serial@vger.kernel.org

On Mon, Feb 18, 2019 at 8:46 PM Zhiyong Tao <zhiyong.tao@mediatek.com> wrote:
>
> On Mon, 2019-02-18 at 10:32 -0600, Rob Herring wrote:
> > On Fri, Feb 15, 2019 at 02:02:35PM +0800, Erin Lo wrote:
> > > From: Zhiyong Tao <zhiyong.tao@mediatek.com>
> > >
> > > The commit adds mt8183 compatible node in binding document.
> > >
> > > Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> > > Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> > > ---
> > >  .../devicetree/bindings/pinctrl/pinctrl-mt8183.txt | 115 +++++++++++++++++++++
> > >  1 file changed, 115 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-mt8183.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8183.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8183.txt
> > > new file mode 100644
> > > index 0000000..364e673
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8183.txt
> > > @@ -0,0 +1,115 @@
> > > +* Mediatek MT8183 Pin Controller
> > > +
> > > +The Mediatek's Pin controller is used to control SoC pins.
> > > +
> > > +Required properties:
> > > +- compatible: value should be one of the following.
> > > +   "mediatek,mt8183-pinctrl", compatible with mt8183 pinctrl.
> > > +- gpio-controller : Marks the device node as a gpio controller.
> > > +- #gpio-cells: number of cells in GPIO specifier. Since the generic GPIO
> > > +  binding is used, the amount of cells must be specified as 2. See the below
> > > +  mentioned gpio binding representation for description of particular cells.
> > > +- gpio-ranges : gpio valid number range.
> > > +- reg: physicall address base for gpio base registers. There are nine
> > > +  physicall address base in mt8183. They are 0x10005000, 0x11F20000,
> > > +  0x11E80000, 0x11E70000, 0x11E90000, 0x11D30000, 0x11D20000, 0x11C50000,
> > > +  0x11F30000.
> >
> > You don't need to list out each address, just what each address is. (Or
> > just '9 GPIO base addresses'.)
>
> ==>ok, we will change it.
> >
> > > +
> > > +   Eg: <&pio 6 0>
> >
> > How is this an example of reg? Seems something is missing.
> >
> > > +   <[phandle of the gpio controller node]
> > > +   [line number within the gpio controller]
> > > +   [flags]>
> > > +
> > > +   Values for gpio specifier:
> > > +   - Line number: is a value between 0 to 202.
> > > +   - Flags:  bit field of flags, as defined in <dt-bindings/gpio/gpio.h>.
> > > +            Only the following flags are supported:
> > > +            0 - GPIO_ACTIVE_HIGH
> > > +            1 - GPIO_ACTIVE_LOW
> > > +
> > > +Optional properties:
> > > +- reg-names: gpio base register names. There are nine gpio base register
> > > +  names in mt8183. They are "iocfg0", "iocfg1", "iocfg2", "iocfg3", "iocfg4",
> > > +  "iocfg5", "iocfg6", "iocfg7", "iocfg8".
> > > +- interrupt-controller: Marks the device node as an interrupt controller
> > > +- #interrupt-cells: Should be two.
> > > +- interrupts : The interrupt outputs from the controller.
> >
> > outputs? More than 1? If so, need to say what they are and the order.
> >
> ==> there is only use one interrupt in mt8183. we will change
> "interrupts" to "interrupt" in v8.

No, 'interrupts' is always plural. The problem is 'outputs'.

Rob
