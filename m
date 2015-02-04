From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH_V2 07/34] dt: interrupt-controller: Add ingenic,jz4740-intc
 binding doc
Date: Wed, 04 Feb 2015 20:07:38 +0300
Message-ID: <54D251DA.1020807@cogentembedded.com>
References: <1423063323-19419-1-git-send-email-Zubair.Kakakhel@imgtec.com> <1423063323-19419-8-git-send-email-Zubair.Kakakhel@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423063323-19419-8-git-send-email-Zubair.Kakakhel@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>, linux-mips@linux-mips.org
Cc: devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, mturquette@linaro.org, sboyd@codeaurora.org, ralf@linux-mips.org, jslaby@suse.cz, tglx@linutronix.de, jason@lakedaemon.net, lars@metafoo.de, paul.burton@imgtec.com
List-Id: linux-serial@vger.kernel.org

Hello.

On 02/04/2015 06:21 PM, Zubair Lutfullah Kakakhel wrote:

> From: Paul Burton <paul.burton@imgtec.com>

> Add binding documentation for the Ingenic jz4740 interrupt controller.

> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: devicetree@vger.kernel.org
> ---
>   .../interrupt-controller/ingenic,jz4740-intc.txt   | 26 ++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ingenic,jz4740-intc.txt

> diff --git a/Documentation/devicetree/bindings/interrupt-controller/ingenic,jz4740-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/ingenic,jz4740-intc.txt
> new file mode 100644
> index 0000000..5e7f4bb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/ingenic,jz4740-intc.txt
> @@ -0,0 +1,26 @@
> +Ingenic jz4740 SoC Interrupt Controller

    JZ4740?

> +
> +Required properties:
> +
> +- compatible : should be "ingenic,jz4740-intc" or "ingenic,jz4780-intc"
> +- reg : Specifies base physical address and size of the registers.
> +- interrupt-controller : Identifies the node as an interrupt controller
> +- #interrupt-cells : Specifies the number of cells needed to encode an
> +  interrupt source. The value shall be 1.
> +- interrupts - Specifies the CPU interrupt the controller is connected to.
> +
> +Optional properties:
> +- interrupt-parent: phandle of the CPU interrupt controller.
> +
> +Example:
> +
> +intc: intc@10001000 {

    Name it "interrupt-controller@10001000", please.

> +	compatible = "ingenic,jz4740-intc";
> +	reg = <0x10001000 0x14>;
> +
> +	interrupt-controller;
> +	#interrupt-cells = <1>;
> +
> +	interrupt-parent = <&cpuintc>;
> +	interrupts = <2>;
> +};

WBR, Sergei
