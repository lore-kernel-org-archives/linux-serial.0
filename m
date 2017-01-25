From: Peter Griffin <peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [STLinux Kernel] [PATCH 8/8] ARM: dts: STiH407-family: Enable HW
 flow-control
Date: Wed, 25 Jan 2017 10:59:12 +0000
Message-ID: <20170125105912.GA5680@griffinp-ThinkPad-X1-Carbon-2nd>
References: <20170124134310.27512-1-lee.jones@linaro.org>
 <20170124134310.27512-9-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170124134310.27512-9-lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, jslaby-IBi9RG/b67k@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Hi Lee,

On Tue, 24 Jan 2017, Lee Jones wrote:

> Hardware flow-control capability must be specified at a platform
> level in order to inform the ASC driver that the platform is capable
> (i.e. are the lines wired up, etc).  STiH4{07,10} devices are indeed
> capable, so let's provide the property.
> 
> Signed-off-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  arch/arm/boot/dts/stih407-family.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
> index 9789978..7ada8ea 100644
> --- a/arch/arm/boot/dts/stih407-family.dtsi
> +++ b/arch/arm/boot/dts/stih407-family.dtsi
> @@ -226,7 +226,7 @@
>  			pinctrl-0 = <&pinctrl_serial0_flowctrl>;
>  			pinctrl-1 = <&pinctrl_serial0>;
>  			clocks = <&clk_s_c0_flexgen CLK_EXT2F_A9>;
> -
> +			st,hw-flow-control;

There is a generic serial binding for this already. As this ST property
hasn't been used upstream, it seems like it would be worth dropping it
and switching to the generic uart-has-rtscts one.

See Documentation/devicetree/bindings/serial/serial.txt

  - uart-has-rtscts: The presence of this property indicates that the
    UART has dedicated lines for RTS/CTS hardware flow control, and that
    they are available for use (wired and enabled by pinmux configuration).
    This depends on both the UART hardware and the board wiring.
    Note that this property is mutually-exclusive with "cts-gpios" and
    "rts-gpios" above.

Also you should put this in the board dtsi, as it is board dependent property.
By putting it here you are enabling hw-flow-control for all stih407-family
based boards.

regards,

Peter.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
