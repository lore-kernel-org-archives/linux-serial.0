From: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 10/10] Bluetooth: add nokia driver
Date: Tue, 7 Mar 2017 10:30:51 -0600
Message-ID: <CAL_Jsq+PvqS_tU6wRzpcsdESYxOOU_JJqsacEc9qLDs2PB2VLw@mail.gmail.com>
References: <20170304115833.3538-1-sre@kernel.org> <20170304115833.3538-11-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170304115833.3538-11-sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Gustavo Padovan <gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org>, Johan Hedberg <johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Sat, Mar 4, 2017 at 5:58 AM, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> This adds a driver for the Nokia H4+ protocol, which is used
> at least on the Nokia N9, N900 & N950.
>
> Signed-off-by: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> ---
>  .../devicetree/bindings/net/nokia-bluetooth.txt    |  51 ++

This should be separate and before the dts files.

>  drivers/bluetooth/Kconfig                          |  12 +
>  drivers/bluetooth/Makefile                         |   2 +
>  drivers/bluetooth/hci_nokia.c                      | 839 +++++++++++++++++++++
>  4 files changed, 904 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/nokia-bluetooth.txt
>  create mode 100644 drivers/bluetooth/hci_nokia.c
>
> diff --git a/Documentation/devicetree/bindings/net/nokia-bluetooth.txt b/Documentation/devicetree/bindings/net/nokia-bluetooth.txt
> new file mode 100644
> index 000000000000..6c80a92f31e2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/nokia-bluetooth.txt
> @@ -0,0 +1,51 @@
> +Nokia Bluetooth Chips
> +---------------------
> +
> +Nokia phones often come with UART connected bluetooth chips from different
> +vendors and modified device API. Those devices speak a protocol named H4+
> +by Nokia, which is similar to the H4 protocol from the Bluetooth standard.
> +In addition to the H4 protocol it specifies two more UART status lines for
> +wakeup of UART transceivers to improve power management and a few new packet
> +types used to negotiate uart speed.
> +
> +Required properties:
> +
> + - compatible: should be one of the following:
> +   * "nokia,brcm,bcm2048"
> +   * "nokia,ti,wl1271-bluetooth"

Drop the chip vendors' prefix here. I don't really want to start a
pattern of 2 vendor prefixes.

> + - reset-gpios: GPIO specifier, used to reset the BT module

Need to state active state.

> + - bluetooth-wakeup-gpios: GPIO specifier, used to wakeup the BT module
> + - host-wakeup-gpios: GPIO specifier, used to wakeup the host processor

I think most BCM devices have these. These apply to the TI device too?
If not, then add brcm prefix.

Also need to specify the active state.

> + - clock-names: should be "sysclk"
> + - clocks: should contain a clock specifier for every name in clock-names
> +
> +Optional properties:
> +
> + - None
> +
> +Example:
> +
> +/ {
> +       /* controlled (enabled/disabled) directly by BT module */
> +       bluetooth_clk: vctcxo {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               clock-frequency = <38400000>;
> +       };
> +};
> +
> +&uart2 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&uart2_pins>;
> +
> +       bluetooth {
> +               compatible = "nokia,ti,wl1271-bluetooth";
> +
> +               reset-gpios = <&gpio1 26 GPIO_ACTIVE_LOW>; /* gpio26 */
> +               host-wakeup-gpios = <&gpio4 5 GPIO_ACTIVE_HIGH>; /* gpio101 */
> +               bluetooth-wakeup-gpios = <&gpio2 5 GPIO_ACTIVE_HIGH>; /* gpio37 */
> +
> +               clocks = <&bluetooth_clk>;
> +               clock-names = "sysclk";
> +       };
> +};
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
