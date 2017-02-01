From: Peter Griffin <peter.griffin@linaro.org>
Subject: Re: [STLinux Kernel] [PATCH v2 10/10] ARM: dts: STiH410-b2260:
 Enable HW flow-control
Date: Wed, 1 Feb 2017 14:53:46 +0000
Message-ID: <20170201145346.GA28760@griffinp-ThinkPad-X1-Carbon-2nd>
References: <20170201143145.31962-1-lee.jones@linaro.org>
 <20170201143145.31962-11-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170201143145.31962-11-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, dt@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@stlinux.com
List-Id: linux-serial@vger.kernel.org

On Wed, 01 Feb 2017, Lee Jones wrote:

> Hardware flow-control capability must be specified at a platform
> level in order to inform the ASC driver that the platform is capable
> (i.e. are the lines wired up, etc).  STiH4{07,10} devices are indeed
> capable, so let's provide the property.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Peter Griffin <peter.griffin@linaro.org>

> ---
>  arch/arm/boot/dts/stih410-b2260.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/stih410-b2260.dts b/arch/arm/boot/dts/stih410-b2260.dts
> index cbcbcb4..93c14d1 100644
> --- a/arch/arm/boot/dts/stih410-b2260.dts
> +++ b/arch/arm/boot/dts/stih410-b2260.dts
> @@ -66,6 +66,7 @@
>  			pinctrl-0 = <&pinctrl_serial0_hw_flowctrl>;
>  			pinctrl-1 = <&pinctrl_serial0>;
>  			rts-gpios = <&pio17 3 GPIO_ACTIVE_LOW>;
> +			uart-has-rtscts;
>  			status = "okay";
>  		};
>  
