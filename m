From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v2 6/7] dt-bindings: serial: Add bindings for GENI based
 UART Controller
Date: Tue, 16 Jan 2018 22:35:06 -0800
Message-ID: <20180117063506.GD6620@minitux>
References: <1515805547-22816-1-git-send-email-kramasub@codeaurora.org>
 <1515805547-22816-7-git-send-email-kramasub@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1515805547-22816-7-git-send-email-kramasub@codeaurora.org>
Sender: linux-doc-owner@vger.kernel.org
To: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
Cc: corbet@lwn.net, andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, wsa@the-dreams.de, gregkh@linuxfoundation.org, linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linux-serial@vger.kernel.org, jslaby@suse.com, Girish Mahadevan <girishm@codeaurora.org>
List-Id: linux-serial@vger.kernel.org

On Fri 12 Jan 17:05 PST 2018, Karthikeyan Ramasubramanian wrote:

> Add device tree binding support for GENI based UART Controller in the
> QUP Wrapper.
> 
> Signed-off-by: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
> Signed-off-by: Girish Mahadevan <girishm@codeaurora.org>
> ---
>  .../devicetree/bindings/serial/qcom,geni-uart.txt  | 29 ++++++++++++++++++++++
>  .../devicetree/bindings/soc/qcom/qcom,geni-se.txt  | 13 ++++++++++
>  2 files changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/qcom,geni-uart.txt
> 
> diff --git a/Documentation/devicetree/bindings/serial/qcom,geni-uart.txt b/Documentation/devicetree/bindings/serial/qcom,geni-uart.txt
> new file mode 100644
> index 0000000..e7b9e24
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/qcom,geni-uart.txt
> @@ -0,0 +1,29 @@
> +Qualcomm Technologies Inc. GENI Serial Engine based UART Controller
> +
> +The Generic Interface (GENI) Serial Engine based UART controller supports
> +console use-cases and is supported only by GENI based Qualcomm Universal
> +Peripheral (QUP) cores.
> +
> +Required properties:
> +- compatible: should contain "qcom,geni-debug-uart".

Why is this uart a _debug_ uart? Is there a separate binding for the
geni-uart?

I like that your naming here matches my suggestion with qcom,geni-i2c.

> +- reg: Should contain UART register location and length.
> +- reg-names: Should contain "se-phys".

No need to specify reg-names for a single reg.

> +- interrupts: Should contain UART core interrupts.
> +- clock-names: Should contain "se-clk".

Omit the "clk"

> +- clocks: clocks needed for UART, includes the core clock.

Be more specific.

> +- pinctrl-names/pinctrl-0/1: The GPIOs assigned to this core. The names
> +  Should be "active" and "sleep" for the pin confuguration when core is active
> +  or when entering sleep state.

Omit pinctrl information.

> +
> +Example:
> +uart0: qcom,serial@a88000 {

Don't use qcom, in node name. This should be named "serial".

> +	compatible = "qcom,geni-debug-uart";
> +	reg = <0xa88000 0x7000>;
> +	reg-names = "se-phys";
> +	interrupts = <0 355 0>;

<GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>

> +	clock-names = "se-clk";
> +	clocks = <&clock_gcc GCC_QUPV3_WRAP0_S0_CLK>;
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&qup_1_uart_3_active>;
> +	pinctrl-1 = <&qup_1_uart_3_sleep>;
> +};

Regards,
Bjorn
