From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Subject: Re: [PATCH 3/4] ARM64: dts: meson-gx-p23x-q20x: enable the Bluetooth
 module
Date: Mon, 16 Jan 2017 01:47:19 +0100
Message-ID: <042e2824-0772-cf27-ffa5-4c3b2af7c92b@suse.de>
References: <20170115223255.10350-1-martin.blumenstingl@googlemail.com>
 <20170115223255.10350-4-martin.blumenstingl@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170115223255.10350-4-martin.blumenstingl@googlemail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>, linux-serial@vger.kernel.org, linux-amlogic@lists.infradead.org, jslaby@suse.com, gregkh@linuxfoundation.org, khilman@baylibre.com, carlo@caione.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Am 15.01.2017 um 23:32 schrieb Martin Blumenstingl:
> This takes the Bluetooth module out of reset (the reset line is
> connected to GPIOX_17) and enables uart_A which is used to configure the
> module.
> This is identical for all boards which inherit meson-gx-p23x-q20x:
> - GXL S905D P230
> - GXL S905D P231
> - GXM S912 Q200
> - GXM S912 Q201
> =

> To get the HCI interface up one has to install bluez-utils and run:
> hciattach -s115200 /dev/ttyAML1 bcm43xx 2000000 flow -
> =

> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> =

> diff --git a/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi b/arch/a=
rm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
> index 7a078bef04cd..7db779048091 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
> @@ -48,6 +48,7 @@
>  / {
>  	aliases {
>  		serial0 =3D &uart_AO;
> +		serial1 =3D &uart_A;
>  	};
>  =

>  	chosen {
> @@ -94,12 +95,21 @@
>  =

>  	sdio_pwrseq: sdio-pwrseq {
>  		compatible =3D "mmc-pwrseq-simple";
> -		reset-gpios =3D <&gpio GPIOX_6 GPIO_ACTIVE_LOW>;
> +		reset-gpios =3D <&gpio GPIOX_6 GPIO_ACTIVE_LOW>,
> +			      <&gpio GPIOX_17 GPIO_ACTIVE_LOW>;
>  		clocks =3D <&wifi32k>;
>  		clock-names =3D "ext_clock";
>  	};
>  };
>  =

> +/* This is connected to the Bluetooth module of the wifi/BT combo chip: =
*/
> +&uart_A {
> +	status =3D "okay";
> +	pinctrl-0 =3D <&uart_a_pins &uart_a_cts_rts_pins>;

Nit: <&uart_a_pins>, <&uart_a_cts_rts_pins> please, like you've done for
reset-gpios above.

Regards,
Andreas

> +	pinctrl-names =3D "default";
> +	uart-has-rtscts;
> +};
> +
>  /* This UART is brought out to the DB9 connector */
>  &uart_AO {
>  	status =3D "okay";
> =



-- =

SUSE Linux GmbH, Maxfeldstr. 5, 90409 N=FCrnberg, Germany
GF: Felix Imend=F6rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N=FCrnberg)
