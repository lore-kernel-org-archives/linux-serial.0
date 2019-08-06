From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [RFCv2 8/9] dt-bindings: serial: meson-uart: convert to yaml
Date: Tue, 6 Aug 2019 21:18:02 +0200
Message-ID: <CAFBinCBSC-wrSxKajwfQNJuzf3ZGFNS4bYPE8qnJF92gTMK_8w@mail.gmail.com>
References: <20190805120320.32282-1-narmstrong@baylibre.com>
 <20190805120320.32282-9-narmstrong@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190805120320.32282-9-narmstrong@baylibre.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: linux-amlogic@lists.infradead.org, robh+dt@kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Neil,

On Mon, Aug 5, 2019 at 2:06 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Now that we have the DT validation in place, let's convert the device tree
> bindings for the Amlogic UART Serial controller over to a YAML schemas.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
two nit-picks below, but overall this looks good:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

> ---
>  .../bindings/serial/amlogic,meson-uart.txt    | 38 ----------
>  .../bindings/serial/amlogic,meson-uart.yaml   | 73 +++++++++++++++++++
>  2 files changed, 73 insertions(+), 38 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/serial/amlogic,meson-uart.txt
>  create mode 100644 Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
>
> diff --git a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.txt b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.txt
> deleted file mode 100644
> index c06c045126fc..000000000000
> --- a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.txt
> +++ /dev/null
> @@ -1,38 +0,0 @@
> -Amlogic Meson SoC UART Serial Interface
> -=======================================
> -
> -The Amlogic Meson SoC UART Serial Interface is present on a large range
> -of SoCs, and can be present either in the "Always-On" power domain or the
> -"Everything-Else" power domain.
> -
> -The particularity of the "Always-On" Serial Interface is that the hardware
> -is active since power-on and does not need any clock gating and is usable
> -as very early serial console.
> -
> -Required properties:
> -- compatible : compatible: value should be different for each SoC family as :
> -       - Meson6 : "amlogic,meson6-uart"
> -       - Meson8 : "amlogic,meson8-uart"
> -       - Meson8b : "amlogic,meson8b-uart"
> -       - GX (GXBB, GXL, GXM) : "amlogic,meson-gx-uart"
> -       eventually followed by : "amlogic,meson-ao-uart" if this UART interface
> -       is in the "Always-On" power domain.
> -- reg : offset and length of the register set for the device.
> -- interrupts : identifier to the device interrupt
> -- clocks : a list of phandle + clock-specifier pairs, one for each
> -          entry in clock names.
> -- clock-names :
> -   * "xtal" for external xtal clock identifier
> -   * "pclk" for the bus core clock, either the clk81 clock or the gate clock
> -   * "baud" for the source of the baudrate generator, can be either the xtal
> -       or the pclk.
> -
> -e.g.
> -uart_A: serial@84c0 {
> -       compatible = "amlogic,meson-gx-uart";
> -       reg = <0x0 0x84c0 0x0 0x14>;
> -       interrupts = <GIC_SPI 26 IRQ_TYPE_EDGE_RISING>;
> -       /* Use xtal as baud rate clock source */
> -       clocks = <&xtal>, <&clkc CLKID_UART0>, <&xtal>;
> -       clock-names = "xtal", "pclk", "baud";
> -};
> diff --git a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> new file mode 100644
> index 000000000000..5d48a8c04aa9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> @@ -0,0 +1,73 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2019 BayLibre, SAS
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/serial/amlogic,meson-uart.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Amlogic Meson SoC UART Serial Interface
> +
> +maintainers:
> +  - Neil Armstrong <narmstrong@baylibre.com>
> +
> +description: |
> +  The Amlogic Meson SoC UART Serial Interface is present on a large range
> +  of SoCs, and can be present either in the "Always-On" power domain or the
> +  "Everything-Else" power domain.
> +
> +  The particularity of the "Always-On" Serial Interface is that the hardware
> +  is active since power-on and does not need any clock gating and is usable
> +  as very early serial console.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - description: Allways-on power domain UART controller
Always instead of Allways

[...]
> +examples:
> +  - |
> +    serial@84c0 {
> +          compatible = "amlogic,meson-gx-uart";
> +          reg = <0x84c0 0x14>;
> +          interrupts = <26>;
> +          clocks = <&xtal>, <&pclk>, <&xtal>;
> +          clock-names = "xtal", "pclk", "baud";
> +    };
more a hint than a nit-pick: you can add #includes to the example,
just like in the real .dtb
then you can keep the GIC_SPI and IRQ_TYPE_... macros
