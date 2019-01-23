From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH 1/6] dt-bindings: soc: qcom: Add interconnect binding for
 GENI QUP
Date: Wed, 23 Jan 2019 09:07:58 -0800
Message-ID: <20190123170758.GB512@tuxbook-pro>
References: <1548138816-1149-1-git-send-email-alokc@codeaurora.org>
 <1548138816-1149-2-git-send-email-alokc@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1548138816-1149-2-git-send-email-alokc@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alok Chauhan <alokc@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org, linux-serial@vger.kernel.org, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, georgi.djakov@linaro.org, dianders@chromium.org, swboyd@chromium.org
List-Id: linux-serial@vger.kernel.org

On Mon 21 Jan 22:33 PST 2019, Alok Chauhan wrote:

> Add documentation for the interconnect and interconnect-names bindings
> for the GENI QUP as detailed by bindings/interconnect/interconnect.txt.
> 
> Signed-off-by: Alok Chauhan <alokc@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
> index dab7ca9..44d7e02 100644
> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
> @@ -17,6 +17,12 @@ Required properties if child node exists:
>  - #address-cells: 	Must be <1> for Serial Engine Address
>  - #size-cells: 		Must be <1> for Serial Engine Address Size
>  - ranges: 		Must be present
> +- interconnects:	phandle to a interconnect provider. Please refer
> +			../interconnect/interconnect.txt for details.
> +			Must be 2 paths corresponding to 2 AXI ports.
> +- interconnect-names:	Port names to differentiate between the

s/Port names/Path names/

> +			2 interconnect paths defined with interconnect
> +			specifier.

These two names are significant in that they must match what the driver
expects, hence you must actually specify them here.

And as the scope of these strings are local to the QUP node you can omit
"qup" from them, so make them "memory" and "config" (or perhaps iface,
to match the clock naming?).

Regards,
Bjorn

>  
>  Properties for children:
>  
> @@ -67,6 +73,10 @@ Example:
>  		#size-cells = <1>;
>  		ranges;
>  
> +		interconnects = <&qnoc 11 &qnoc 512>,
> +				<&qnoc 0 &qnoc 543>;

I presu

> +		interconnect-names = "qup-memory", "qup-config";
> +
>  		i2c0: i2c@a94000 {
>  			compatible = "qcom,geni-i2c";
>  			reg = <0xa94000 0x4000>;
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
