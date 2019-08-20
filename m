From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: lantiq: Update for new SoC
Date: Tue, 20 Aug 2019 11:00:50 -0500
Message-ID: <CAL_JsqJK=TFsAt4kegGs2ymnWpY4tuDXNJF0RFpvZJmuPHJMYA@mail.gmail.com>
References: <cover.1566288689.git.rahul.tanwar@linux.intel.com> <fa6b20015dc6bfe247e1b2a07bdc5c727595a04b.1566288689.git.rahul.tanwar@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <fa6b20015dc6bfe247e1b2a07bdc5c727595a04b.1566288689.git.rahul.tanwar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rahul Tanwar <rahul.tanwar@linux.intel.com>
Cc: devicetree@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@intel.com>, qi-ming.wu@intel.com, cheol.yong.kim@intel.com, rahul.tanwar@intel.com
List-Id: linux-serial@vger.kernel.org

On Tue, Aug 20, 2019 at 3:29 AM Rahul Tanwar
<rahul.tanwar@linux.intel.com> wrote:
>
> Intel Lightning Mountain(LGM) SoC reuses Lantiq ASC serial controller IP.
> Update the dt bindings to support LGM as well.
>
> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
> ---
>  .../devicetree/bindings/serial/lantiq_asc.yaml          | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/serial/lantiq_asc.yaml b/Documentation/devicetree/bindings/serial/lantiq_asc.yaml
> index 54b90490f4fb..92807b59b024 100644
> --- a/Documentation/devicetree/bindings/serial/lantiq_asc.yaml
> +++ b/Documentation/devicetree/bindings/serial/lantiq_asc.yaml
> @@ -17,6 +17,7 @@ properties:
>      oneOf:
>        items:
>          - const: lantiq,asc
> +        - const: intel,lgm-asc

Better expressed as:

compatible:
  enum:
    - intel,lgm-asc
    - lantiq,asc

>
>    reg:
>      maxItems: 1
> @@ -28,6 +29,12 @@ properties:
>        - description: tx or combined interrupt
>        - description: rx interrupt
>        - description: err interrupt
> +    description:
> +      For lantiq,asc compatible, it supports 3 separate
> +      interrupts for tx rx & err. Whereas, for intel,lgm-asc
> +      compatible, it supports combined single interrupt for
> +      all of tx, rx & err interrupts.

This can be expressed with an if/then schema. There's some examples in
the tree how to do that.

> +
>
>    clocks:
>      description:
> @@ -67,4 +74,14 @@ examples:
>              interrupts = <112 113 114>;
>      };
>
> +  - |
> +    asc0: serial@e0a00000 {
> +            compatible = "intel,lgm-asc";
> +            reg = <0xe0a00000 0x1000>;
> +            interrupt-parent = <&ioapic1>;
> +            interrupts = <128 1>;
> +            clocks = <&cgu0 LGM_CLK_NOC4>, <&cgu0 LGM_GCLK_ASC0>;
> +            clock-names = "freq", "asc";
> +    };
> +
>  ...
> --
> 2.11.0
>
