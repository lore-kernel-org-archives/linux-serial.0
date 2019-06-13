From: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] dt-bindings: serial: add documentation for Rx in-band
 wakeup support
Date: Thu, 13 Jun 2019 08:40:16 -0600
Message-ID: <CAL_JsqKJMAhOLH_Y2rgbdWZ9f5CEVdMMEF8+bHfjxxtu-cBKdQ@mail.gmail.com>
References: <20190611121510.260188-1-tientzu@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20190611121510.260188-1-tientzu-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Claire Chang <tientzu-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nicolas Boichat <drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, changqi.hu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "open list:SERIAL DRIVERS" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Jun 11, 2019 at 6:15 AM Claire Chang <tientzu-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
>
> To support Rx in-band wakeup, one must create an interrupt specifier with
> edge sensitivity on Rx pin and an addtional pinctrl to reconfigure Rx pin
> to normal GPIO in sleep state. Driver will switch to sleep mode pinctrl and
> enable irq wake before suspend and restore to default settings when
> resuming.
>
> Signed-off-by: Claire Chang <tientzu-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> ---
> Resending this patch since I forgot to cc device tree maintainers/mailing list.
> The 2/2 patch in this series[1] is already in tty-next[2].
>
> [1] https://patchwork.kernel.org/patch/10962299/
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/log/?h=tty-testing
>
>  .../devicetree/bindings/serial/mtk-uart.txt         | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/serial/mtk-uart.txt b/Documentation/devicetree/bindings/serial/mtk-uart.txt
> index bcfb13194f16..3488b6e24e0c 100644
> --- a/Documentation/devicetree/bindings/serial/mtk-uart.txt
> +++ b/Documentation/devicetree/bindings/serial/mtk-uart.txt
> @@ -21,7 +21,12 @@ Required properties:
>
>  - reg: The base address of the UART register bank.
>
> -- interrupts: A single interrupt specifier.
> +- interrupts or interrupts-extended:

interrupts-extended support is implied as both are supported and the
connection to the interrupt parent is outside the scope of the
binding. So we just document 'interrupts'.

> +  index 0: an interrupt specifier for the UART controller itself
> +  index 1: optional, an interrupt specifier with edge sensitivity on Rx pin to
> +           support Rx in-band wake up. If one would like to use this feature,
> +           one must create an addtional pinctrl to reconfigure Rx pin to normal
> +           GPIO before suspend.
>
>  - clocks : Must contain an entry for each entry in clock-names.
>    See ../clocks/clock-bindings.txt for details.
> @@ -37,7 +42,11 @@ Example:
>         uart0: serial@11006000 {
>                 compatible = "mediatek,mt6589-uart", "mediatek,mt6577-uart";
>                 reg = <0x11006000 0x400>;
> -               interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_LOW>;
> +               interrupts-extended = <&sysirq GIC_SPI 51 IRQ_TYPE_LEVEL_LOW>,
> +                                     <&gpio 121 IRQ_TYPE_EDGE_FALLING>;
>                 clocks = <&uart_clk>, <&bus_clk>;
>                 clock-names = "baud", "bus";
> +               pinctrl-names = "default", "sleep";
> +               pinctrl-0 = <&uart_pin>;
> +               pinctrl-1 = <&uart_pin_sleep>;
>         };
> --
> 2.22.0.rc2.383.gf4fbbf30c2-goog
>
