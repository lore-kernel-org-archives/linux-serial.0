From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH RFC 4/7] i2c: Add device tree bindings for GENI I2C
 Controller
Date: Tue, 2 Jan 2018 09:51:49 -0600
Message-ID: <20180102155149.f2wzjvdhoi6cne4x@rob-hp-laptop>
References: <1514392046-30602-1-git-send-email-kramasub@codeaurora.org>
 <1514392046-30602-5-git-send-email-kramasub@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1514392046-30602-5-git-send-email-kramasub@codeaurora.org>
Sender: linux-i2c-owner@vger.kernel.org
To: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org, linux-serial@vger.kernel.org, linux-doc@vger.kernel.org, devicetree@vger.kernel.org, andy.gross@linaro.org, david.brown@linaro.org, mark.rutland@arm.com, corbet@lwn.net, wsa@the-dreams.de, gregkh@linuxfoundation.org, jslaby@suse.com, Sagar Dharia <sdharia@codeaurora.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Dec 27, 2017 at 09:27:23AM -0700, Karthikeyan Ramasubramanian wrote:
> Add device tree binding support for I2C Controller in GENI based
> QUP Wrapper.
> 
> Signed-off-by: Sagar Dharia <sdharia@codeaurora.org>
> Signed-off-by: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
> ---
>  .../devicetree/bindings/i2c/i2c-qcom-geni.txt      | 39 ++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-qcom-geni.txt
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-qcom-geni.txt b/Documentation/devicetree/bindings/i2c/i2c-qcom-geni.txt
> new file mode 100644
> index 0000000..d2fa9ce
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/i2c-qcom-geni.txt
> @@ -0,0 +1,39 @@
> +Qualcomm Technologies Inc. GENI based I2C Controller driver
> +
> +Required properties:
> + - compatible: Should be:
> +   * "qcom,i2c-geni.

Only 1 version?

> + - reg: Should contain QUP register address and length.
> + - interrupts: Should contain I2C interrupt.
> + - clocks: Serial engine core clock, and AHB clocks needed by the device.

Are there really clocks for a firmware based device or these are just 
clocks in the parent serial engine?

> + - pinctrl-names/pinctrl-0/1: The GPIOs assigned to this core. The names
> +   should be "active" and "sleep" for the pin confuguration when core is active
> +   or when entering sleep state.
> + - #address-cells: Should be <1> Address cells for i2c device address
> + - #size-cells: Should be <0> as i2c addresses have no size component
> + - qcom,wrapper-core: Wrapper QUP core containing this I2C controller.

Probably these devices should be child nodes of the QUP core node.

> +
> +Optional property:
> + - qcom,clk-freq-out : Desired I2C bus clock frequency in Hz.
> +   When missing default to 400000Hz.

There's a standard property for this.

> +
> +Child nodes should conform to i2c bus binding.
> +
> +Example:
> +
> +i2c@a94000 {
> +	compatible = "qcom,i2c-geni";
> +	reg = <0xa94000 0x4000>;
> +	interrupts = <GIC_SPI 358 0>;
> +	clock-names = "se-clk", "m-ahb", "s-ahb";
> +	clocks = <&clock_gcc GCC_QUPV3_WRAP0_S5_CLK>,
> +		<&clock_gcc GCC_QUPV3_WRAP_0_M_AHB_CLK>,
> +		<&clock_gcc GCC_QUPV3_WRAP_0_S_AHB_CLK>;
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&qup_1_i2c_5_active>;
> +	pinctrl-1 = <&qup_1_i2c_5_sleep>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	qcom,wrapper-core = <&qup_0>;
> +	qcom,clk-freq-out = <400000>;
> +};
> -- 
> Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
