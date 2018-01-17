From: Bjorn Andersson <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 4/7] dt-bindings: i2c: Add device tree bindings for
 GENI I2C Controller
Date: Tue, 16 Jan 2018 22:31:06 -0800
Message-ID: <20180117063106.GC6620@minitux>
References: <1515805547-22816-1-git-send-email-kramasub@codeaurora.org>
 <1515805547-22816-5-git-send-email-kramasub@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1515805547-22816-5-git-send-email-kramasub-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Karthikeyan Ramasubramanian <kramasub-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: corbet-T1hC0tSOHrs@public.gmane.org, andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jslaby-IBi9RG/b67k@public.gmane.org, Sagar Dharia <sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Fri 12 Jan 17:05 PST 2018, Karthikeyan Ramasubramanian wrote:

> Add device tree binding support for I2C Controller in GENI based
> QUP Wrapper.
> 
> Signed-off-by: Sagar Dharia <sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> Signed-off-by: Karthikeyan Ramasubramanian <kramasub-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> ---
>  .../devicetree/bindings/i2c/i2c-qcom-geni.txt      | 35 ++++++++++++++++++++++
>  .../devicetree/bindings/soc/qcom/qcom,geni-se.txt  | 19 ++++++++++++
>  2 files changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-qcom-geni.txt
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-qcom-geni.txt b/Documentation/devicetree/bindings/i2c/i2c-qcom-geni.txt
> new file mode 100644
> index 0000000..ea84be7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/i2c-qcom-geni.txt
> @@ -0,0 +1,35 @@
> +Qualcomm Technologies Inc. GENI Serial Engine based I2C Controller
> +
> +Required properties:
> + - compatible: Should be:
> +   * "qcom,i2c-geni.

As this is a subset of geni it would look better with qcom,geni-i2c
imho.

> + - reg: Should contain QUP register address and length.
> + - interrupts: Should contain I2C interrupt.
> + - clock-names: Should contain "se-clk".

Omit "clk" from the clock names.

> + - clocks: Serial engine core clock needed by the device.
> + - pinctrl-names/pinctrl-0/1: The GPIOs assigned to this core. The names
> +   should be "active" and "sleep" for the pin confuguration when core is active
> +   or when entering sleep state.

No need to describe pinctrl properties - and your description here
doesn't match the code.

> + - #address-cells: Should be <1> Address cells for i2c device address
> + - #size-cells: Should be <0> as i2c addresses have no size component
> +
> +Optional property:
> + - clock-frequency : Desired I2C bus clock frequency in Hz.
> +   When missing default to 400000Hz.
> +
> +Child nodes should conform to i2c bus binding.

..."as described in i2c.txt"

Regards,
Bjorn
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
