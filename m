From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v7 3/6] dt-bindings: pinctrl: mt8183: add binding document
Date: Mon, 18 Feb 2019 09:48:23 -0600
Message-ID: <20190218154823.GA2714@bogus>
References: <1550210558-30516-1-git-send-email-erin.lo@mediatek.com>
 <1550210558-30516-4-git-send-email-erin.lo@mediatek.com>
 <2b221339-3933-2a25-ab60-d4d772d2873a@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2b221339-3933-2a25-ab60-d4d772d2873a@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Erin Lo <erin.lo@mediatek.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Boyd <sboyd@codeaurora.org>, devicetree@vger.kernel.org, srv_heupstream <srv_heupstream@mediatek.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, yingjoe.chen@mediatek.com, mars.cheng@mediatek.com, eddie.huang@mediatek.com, linux-clk@vger.kernel.org, Zhiyong Tao <zhiyong.tao@mediatek.com>
List-Id: linux-serial@vger.kernel.org

On Fri, Feb 15, 2019 at 10:35:39AM +0100, Matthias Brugger wrote:
> 
> 
> On 15/02/2019 07:02, Erin Lo wrote:
> > From: Zhiyong Tao <zhiyong.tao@mediatek.com>
> > 
> > The commit adds mt8183 compatible node in binding document.
> > 
> > Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> > Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> > ---
> >  .../devicetree/bindings/pinctrl/pinctrl-mt8183.txt | 115 +++++++++++++++++++++
> >  1 file changed, 115 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-mt8183.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8183.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8183.txt
> > new file mode 100644
> > index 0000000..364e673
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8183.txt
> > @@ -0,0 +1,115 @@
> > +* Mediatek MT8183 Pin Controller
> > +
> > +The Mediatek's Pin controller is used to control SoC pins.
> > +
> > +Required properties:
> > +- compatible: value should be one of the following.
> > +	"mediatek,mt8183-pinctrl", compatible with mt8183 pinctrl.
> > +- gpio-controller : Marks the device node as a gpio controller.
> > +- #gpio-cells: number of cells in GPIO specifier. Since the generic GPIO
> > +  binding is used, the amount of cells must be specified as 2. See the below
> > +  mentioned gpio binding representation for description of particular cells.
> > +- gpio-ranges : gpio valid number range.
> > +- reg: physicall address base for gpio base registers. There are nine
> 
> s/physicall/physical
> 
> > +  physicall address base in mt8183. They are 0x10005000, 0x11F20000,
> > +  0x11E80000, 0x11E70000, 0x11E90000, 0x11D30000, 0x11D20000, 0x11C50000,
> > +  0x11F30000.
> > +
> > +	Eg: <&pio 6 0>
> > +	<[phandle of the gpio controller node]
> > +	[line number within the gpio controller]
> > +	[flags]>
> > +
> > +	Values for gpio specifier:
> > +	- Line number: is a value between 0 to 202.
> > +	- Flags:  bit field of flags, as defined in <dt-bindings/gpio/gpio.h>.
> > +            Only the following flags are supported:
> > +            0 - GPIO_ACTIVE_HIGH
> > +            1 - GPIO_ACTIVE_LOW
> > +
> > +Optional properties:
> > +- reg-names: gpio base register names. There are nine gpio base register
> > +  names in mt8183. They are "iocfg0", "iocfg1", "iocfg2", "iocfg3", "iocfg4",
> > +  "iocfg5", "iocfg6", "iocfg7", "iocfg8".
> > +- interrupt-controller: Marks the device node as an interrupt controller
> > +- #interrupt-cells: Should be two.
> > +- interrupts : The interrupt outputs from the controller.
> 
> we are missing interrupt-parent here.

No, because interrupt-parent is implied and may be in a parent node.

What's missing is how many interrupts and what are they? 

Rob
