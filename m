From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: serial: add documentation for the
 SiFive UART driver
Date: Fri, 19 Oct 2018 15:45:57 -0500
Message-ID: <CAL_JsqJBSqaxnETdJg1Mdp+H2ay+WKT0JaxLe6D4Fwo_99qUkw@mail.gmail.com>
References: <20181019184827.12351-1-paul.walmsley@sifive.com> <20181019184827.12351-2-paul.walmsley@sifive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181019184827.12351-2-paul.walmsley@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul.walmsley@sifive.com>
Cc: "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@sifive.com>, Paul Walmsley <paul@pwsan.com>
List-Id: linux-serial@vger.kernel.org

On Fri, Oct 19, 2018 at 1:48 PM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
> Add DT binding documentation for the Linux driver for the SiFive
> asynchronous serial IP block.  Nothing too exotic.
>
> Cc: linux-serial@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
>  .../bindings/serial/sifive-serial.txt         | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/sifive-serial.txt
>
> diff --git a/Documentation/devicetree/bindings/serial/sifive-serial.txt b/Documentation/devicetree/bindings/serial/sifive-serial.txt
> new file mode 100644
> index 000000000000..8982338512f5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/sifive-serial.txt
> @@ -0,0 +1,21 @@
> +SiFive asynchronous serial interface (UART)
> +
> +Required properties:
> +
> +- compatible: should be "sifive,fu540-c000-uart0" or "sifive,uart0"

I assume once again, the last '0' is a version? As I mentioned for the
intc and now the pwm block bindings, if you are going to do version
numbers please document the versioning scheme. Palmer mentioned the
compatible string is part of the IP block repository? Where does the
number come from? What's the next version? Major vs. minor versions?
ECO fixes? Is the version s/w readable? How do you ensure it gets
updated? All that should be addressed.

Otherwise, don't do version numbers because we have no visibility to
what they mean.

> +- reg: address and length of the register space
> +- interrupt-parent: should contain a phandle pointing to the SoC interrupt
> +    controller device node that the UART interrupts are connected to

Don't need to document interrupt-parent here.

> +- interrupts: Should contain the UART interrupt identifier
> +- clocks: Should contain a clock identifier for the UART's parent clock
> +
> +
> +Example:
> +
> +uart0: serial@10010000 {
> +       compatible = "sifive,uart0";
> +       interrupt-parent = <&plic0>;
> +       interrupts = <80>;
> +       reg = <0x0 0x10010000 0x0 0x1000>;
> +       clocks = <&prci PRCI_CLK_TLCLK>;
> +};
> --
> 2.19.1
>
