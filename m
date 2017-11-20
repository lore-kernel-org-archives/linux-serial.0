From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC v1 8/8] dt-bindings: net: bluetooth: add
 support for Realtek Bluetooth chips
Date: Mon, 20 Nov 2017 15:09:52 -0600
Message-ID: <20171120210952.7ky2r2oj7otn3umi@rob-hp-laptop>
References: <20171117223543.32429-1-martin.blumenstingl@googlemail.com>
 <20171117223543.32429-9-martin.blumenstingl@googlemail.com>
Reply-To: robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBDJIP47K7MERBJUJZXIAKGQEUFIDP2Y-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20171117223543.32429-9-martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org, gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org, johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, jslaby-IBi9RG/b67k@public.gmane.org, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Larry.Finger-tQ5ms3gMjBLk1uMJSBkQmQ@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Fri, Nov 17, 2017 at 11:35:43PM +0100, Martin Blumenstingl wrote:
> This adds the documentation for Bluetooth functionality of the Realtek
> RTL8723BS and RTL8723DS.
> Both are SDIO wifi chips with an additional Bluetooth module which is
> connected via UART to the host.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
> ---
>  .../devicetree/bindings/net/realtek-bluetooth.txt  | 31 ++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/realtek-bluetooth.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/realtek-bluetooth.txt b/Documentation/devicetree/bindings/net/realtek-bluetooth.txt
> new file mode 100644
> index 000000000000..c919e06469f8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/realtek-bluetooth.txt
> @@ -0,0 +1,31 @@
> +Realtek Bluetooth Chips
> +-----------------------
> +
> +This documents the binding structure and common properties for serial
> +attached Realtek devices.
> +
> +Serial attached Realtek devices shall be a child node of the host UART
> +device the slave device is attached to. See ../serial/slave-device.txt
> +for more information
> +
> +Required properties:
> +- compatible: should contain one of the following:
> +    * "realtek,rtl8723bs-bluetooth"
> +    * "realtek,rtl8723ds-bluetooth"
> +
> +Optional properties:
> +- disable-gpios: GPIO specifier, used to enable/disable the BT module

We generally use 'enable-gpios' or 'powerdown-gpios' even if the h/w 
name is somewhat different.

> +- reset-gpios: GPIO specifier, used to reset the BT module
> +
> +
> +Example:
> +
> +&uart {
> +	...
> +
> +	bluetooth {
> +		compatible = "realtek,rtl8723bs-bluetooth";
> +		disable-gpios = <&gpio 20 GPIO_ACTIVE_LOW>;
> +		reset-gpios = <&gpio 11 GPIO_ACTIVE_HIGH>;
> +	};
> +};
> -- 
> 2.15.0
> 
