From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH 1/6] dt-bindings: soc: qcom: Add interconnect binding for
 GENI QUP
Date: Wed, 23 Jan 2019 20:35:30 +0200
Message-ID: <c4260d66-5ca4-b194-0cbc-2a682a99db4b@linaro.org>
References: <1548138816-1149-1-git-send-email-alokc@codeaurora.org>
 <1548138816-1149-2-git-send-email-alokc@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1548138816-1149-2-git-send-email-alokc@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alok Chauhan <alokc@codeaurora.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org, linux-serial@vger.kernel.org, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: dianders@chromium.org, swboyd@chromium.org, bjorn.andersson@linaro.org
List-Id: linux-serial@vger.kernel.org

Hi Alok,

Thanks for the patches!

On 1/22/19 08:33, Alok Chauhan wrote:
> Add documentation for the interconnect and interconnect-names bindings

s/interconnect /interconnects /

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

s/a interconnect/an interconnect/

> +			../interconnect/interconnect.txt for details.
> +			Must be 2 paths corresponding to 2 AXI ports.
> +- interconnect-names:	Port names to differentiate between the
> +			2 interconnect paths defined with interconnect
> +			specifier.
>  
>  Properties for children:
>  
> @@ -67,6 +73,10 @@ Example:
>  		#size-cells = <1>;
>  		ranges;
>  
> +		interconnects = <&qnoc 11 &qnoc 512>,
> +				<&qnoc 0 &qnoc 543>;

Please take a snippet from your patch 6/6 and put it here instead of the
hard-coded integers above.

> +		interconnect-names = "qup-memory", "qup-config";
> +
>  		i2c0: i2c@a94000 {
>  			compatible = "qcom,geni-i2c";
>  			reg = <0xa94000 0x4000>;
> 

When you post a new version, please change the subject of the patch
series to PATCH v2, PATCH v3 etc, in order to be able to distinguish
between different versions.

Thanks,
Georgi
