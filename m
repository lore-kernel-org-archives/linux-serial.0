From: Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH] tty: serial: msm_serial: Use DT aliases
Date: Thu, 06 Nov 2014 22:42:47 -0800
Message-ID: <545C69E7.6010909@gmail.com>
References: <1414024381-12204-1-git-send-email-sboyd@codeaurora.org> <545C694D.1030204@gmail.com>
Reply-To: frowand.list@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <545C694D.1030204@gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: frowand.list@gmail.com
Cc: Stephen Boyd <sboyd@codeaurora.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 11/6/2014 10:40 PM, Frank Rowand wrote:
> From: Frank Rowand <frank.rowand@sonymobile.com>
> 
> Update msm8974 dtsi for msm_serial to reflect msm_serial_probe()
> getting line id from the serial alias.
> 
> Signed-off-by: Frank Rowand <frank.rowand@sonymobile.com>
> ---
>  arch/arm/boot/dts/qcom-msm8974.dtsi |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> Index: b/arch/arm/boot/dts/qcom-msm8974.dtsi
> ===================================================================
> --- a/arch/arm/boot/dts/qcom-msm8974.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
> @@ -9,6 +9,10 @@
>  	compatible = "qcom,msm8974";
>  	interrupt-parent = <&intc>;
>  
> +	aliases {
> +		serial0 = &serial0;
> +	};
> +
>  	cpus {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> @@ -189,7 +193,7 @@
>  			reg = <0xfd8c0000 0x6000>;
>  		};
>  
> -		serial@f991e000 {
> +		serial0: serial@f991e000 {
>  			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
>  			reg = <0xf991e000 0x1000>;
>  			interrupts = <0 108 0x0>;
> 

This same change is also needed in:

  qcom-ipq8064.dtsi
  qcom-msm8960.dtsi
  qcom-apq8084.dtsi
  qcom-apq8064.dtsi
  qcom-msm8660.dtsi

but I did not want to just blindly apply those changes without testing.

-Frank
