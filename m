From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v2 2/7] dt-bindings: soc: qcom: Add device tree binding
 for GENI SE
Date: Tue, 16 Jan 2018 22:25:58 -0800
Message-ID: <20180117062558.GB6620@minitux>
References: <1515805547-22816-1-git-send-email-kramasub@codeaurora.org>
 <1515805547-22816-3-git-send-email-kramasub@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1515805547-22816-3-git-send-email-kramasub@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
Cc: corbet@lwn.net, andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, wsa@the-dreams.de, gregkh@linuxfoundation.org, linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linux-serial@vger.kernel.org, jslaby@suse.com
List-Id: linux-serial@vger.kernel.org

On Fri 12 Jan 17:05 PST 2018, Karthikeyan Ramasubramanian wrote:

> Add device tree binding support for the QCOM GENI SE driver.
> 
> Signed-off-by: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>

Better describe the entire GENI, with it's functions in the same
binding.

> ---
>  .../devicetree/bindings/soc/qcom/qcom,geni-se.txt  | 34 ++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
> new file mode 100644
> index 0000000..66f8a16
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
> @@ -0,0 +1,34 @@
> +Qualcomm Technologies, Inc. GENI Serial Engine QUP Wrapper Controller
> +
> +Generic Interface (GENI) based Qualcomm Universal Peripheral (QUP) wrapper
> +is a programmable module for supporting a wide range of serial interfaces
> +like UART, SPI, I2C, I3C, etc. A single QUP module can provide upto 8 Serial
> +Interfaces, using its internal Serial Engines. The GENI Serial Engine QUP
> +Wrapper controller is modeled as a node with zero or more child nodes each
> +representing a serial engine.
> +
> +Required properties:
> +- compatible:		Must be "qcom,geni-se-qup".
> +- reg:			Must contain QUP register address and length.
> +- clock-names:		Must contain "m-ahb" and "s-ahb".
> +- clocks:		AHB clocks needed by the device.
> +
> +Required properties if child node exists:
> +- #address-cells: Must be 1
> +- #size-cells: Must be 1

But on a 64-bit system, shouldn't these be 2?

> +- ranges: Must be present
> +
> +Properties for children:
> +
> +A GENI based QUP wrapper controller node can contain 0 or more child nodes
> +representing serial devices.  These serial devices can be a QCOM UART, I2C
> +controller, spi controller, or some combination of aforementioned devices.
> +
> +Example:
> +	qup0: qcom,geniqup0@8c0000 {

I don't see a reason for this to be referenced, so skip the label. And
don't use qcom, in the node name; "geni" would be perfectly fine?

> +		compatible = "qcom,geni-se-qup";
> +		reg = <0x8c0000 0x6000>;
> +		clock-names = "m-ahb", "s-ahb";
> +		clocks = <&clock_gcc GCC_QUPV3_WRAP_0_M_AHB_CLK>,
> +			<&clock_gcc GCC_QUPV3_WRAP_0_S_AHB_CLK>;
> +	}

Regards,
Bjorn
