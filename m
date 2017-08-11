From: Sean Wang <sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 1/2] dt-bindings: serial: Add MediaTek BTIF controller
 bindings
Date: Fri, 11 Aug 2017 10:53:08 +0800
Message-ID: <1502419988.19230.16.camel@mtkswgap22>
References: <cover.1501692369.git.sean.wang@mediatek.com>
         <6b2ad0dc976259563562e7ab23abdacf68c94aa5.1501692369.git.sean.wang@mediatek.com>
         <20170810162752.2xncymekrhu544g7@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170810162752.2xncymekrhu544g7@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, jslaby-IBi9RG/b67k@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, jan.kiszka-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org, heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, hpeter-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, vigneshr-l0cyMroinI0@public.gmane.org, matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Thu, 2017-08-10 at 11:27 -0500, Rob Herring wrote:
> On Thu, Aug 03, 2017 at 01:05:22AM +0800, sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org wrote:
> > From: Sean Wang <sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > 
> > Document the devicetree bindings for MediaTek BTIF controller
> > which could be found on MT7622 and MT7623 SoC.
> > 
> > Signed-off-by: Sean Wang <sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > ---
> >  .../devicetree/bindings/serial/mtk-btif.txt        | 26 ++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/serial/mtk-btif.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/serial/mtk-btif.txt b/Documentation/devicetree/bindings/serial/mtk-btif.txt
> > new file mode 100644
> > index 0000000..80c1f5a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/serial/mtk-btif.txt
> > @@ -0,0 +1,26 @@
> > +Device-Tree bindings for MediaTek BTIF controller found on those
> > +MediaTek SoCs with Bluetooth feature
> > +
> > +Required properties:
> > +- compatible: Should be one of:
> > +	- "mediatek,mt7622-btif" : for MT7622 SoC
> > +	- "mediatek,mt7623-btif" : for MT7623 SoC
> > +- reg: The base address of the BTIF register bank;
> > +- interrupts: A single interrupt specifier;
> > +- clocks: list of clock specifiers, corresponding to
> > +	  entries in clock-names property;
> > +- clock-names: should contain "main" entries.
> > +
> > +Optional properties:
> > +- mediatek,loopback: Boolean; if defined, indicates that BTIF controller
> > +	running on the loopback mode.
> 
> I don't think this belongs in DT, but should be a module param or sysfs 
> control.
> 
the loopback actually is one of hardware setups so i add it as one
property in the dt or could you kindly guide me how to make judgment
accurately for listing those changes as either dt or a module param? 


> > +
> > +Example:
> > +
> > +	btif: btif@1100c000 {
> 
> bluetooth@...
> 
btif not bluetooth, which is just the interface hardware allowing the
the main processor communicating with the bluetooth hardware built in
the SoC, and is really like to the uart used by legacy bluetooth.
So i will add bluetooth as the another node.


> > +		compatible = "mediatek,mt7623-btif";
> > +		reg = <0 0x1100c000 0 0x1000>;
> > +		interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_LOW>;
> > +		clocks = <&pericfg CLK_PERI_BTIF>;
> > +		clock-names = "main";
> > +	};
> > -- 
> > 2.7.4
> > 


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
