From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH 4/5] dt-bindings: serial: sprd: Add dma properties to
 support DMA mode
Date: Fri, 1 Mar 2019 17:42:32 +0800
Message-ID: <CAMz4kuLQucODjYzei6TY1jRkP8VCY6i_8z963VuW7PWEDJLF2A@mail.gmail.com>
References: <cover.1550560916.git.baolin.wang@linaro.org> <8f0a032f9bcce28bb0d147f9646950f64fc22a74.1550560916.git.baolin.wang@linaro.org>
 <20190228195319.GA13133@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190228195319.GA13133@bogus>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.com, Mark Rutland <mark.rutland@arm.com>, Orson Zhai <orsonzhai@gmail.com>, Chunyan Zhang <zhang.lyra@gmail.com>, Mark Brown <broonie@kernel.org>, lanqing.liu@unisoc.com, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Fri, 1 Mar 2019 at 03:53, Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Feb 19, 2019 at 03:31:14PM +0800, Baolin Wang wrote:
> > From: Lanqing Liu <lanqing.liu@unisoc.com>
> >
> > This patch adds dmas and dma-names properties for the UART DMA mode.
> >
> > Signed-off-by: Lanqing Liu <lanqing.liu@unisoc.com>
> > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > ---
> >  .../devicetree/bindings/serial/sprd-uart.txt       |    6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/serial/sprd-uart.txt b/Documentation/devicetree/bindings/serial/sprd-uart.txt
> > index 6eb5863..9ac28f6 100644
> > --- a/Documentation/devicetree/bindings/serial/sprd-uart.txt
> > +++ b/Documentation/devicetree/bindings/serial/sprd-uart.txt
> > @@ -15,12 +15,18 @@ Required properties:
> >    UART clock and source clock are optional properties, but enable clock
> >    is required.
> >
> > +Optional properties:
> > +- dma-names: Should contain "tx" for transmit and "rx" for receive channels.
>
> The order here doesn't match the example.

Ah, yes, will update new version to fix this. Thanks.

>
> > +- dmas: A list of dma specifiers, one for each entry in dma-names.
> > +
> >  Example:
> >       uart0: serial@0 {
> >               compatible = "sprd,sc9860-uart",
> >                            "sprd,sc9836-uart";
> >               reg = <0x0 0x100>;
> >               interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
> > +             dma-names = "rx", "tx";
> > +             dmas = <&ap_dma 19 19>, <&ap_dma 20 20>;
> >               clock-names = "enable", "uart", "source";
> >               clocks = <&clk_ap_apb_gates 9>, <&clk_uart0>, <&ext_26m>;
> >       };
> > --
> > 1.7.9.5
> >



-- 
Baolin Wang
Best Regards
