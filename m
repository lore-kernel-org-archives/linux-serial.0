From: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: [PATCH 3/4] ARM64: dts: meson-gx-p23x-q20x: enable the Bluetooth module
Date: Mon, 16 Jan 2017 10:44:36 +0100
Message-ID: <CAFBinCC2SzLtq9-tUFUu5CH_Q8tJSdJHc_93UmcgoTOOxnD5=Q@mail.gmail.com>
References: <20170115223255.10350-1-martin.blumenstingl@googlemail.com>
 <20170115223255.10350-4-martin.blumenstingl@googlemail.com> <042e2824-0772-cf27-ffa5-4c3b2af7c92b@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <042e2824-0772-cf27-ffa5-4c3b2af7c92b-l3A5Bk7waGM@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber-l3A5Bk7waGM@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, jslaby-IBi9RG/b67k@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Mon, Jan 16, 2017 at 1:47 AM, Andreas F=C3=A4rber <afaerber-l3A5Bk7waGM@public.gmane.org> wro=
te:
> Am 15.01.2017 um 23:32 schrieb Martin Blumenstingl:
>> This takes the Bluetooth module out of reset (the reset line is
>> connected to GPIOX_17) and enables uart_A which is used to configure the
>> module.
>> This is identical for all boards which inherit meson-gx-p23x-q20x:
>> - GXL S905D P230
>> - GXL S905D P231
>> - GXM S912 Q200
>> - GXM S912 Q201
>>
>> To get the HCI interface up one has to install bluez-utils and run:
>> hciattach -s115200 /dev/ttyAML1 bcm43xx 2000000 flow -
>>
>> Signed-off-by: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
>> ---
>>  arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi | 12 +++++++++++-
>>  1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi b/arch/=
arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
>> index 7a078bef04cd..7db779048091 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
>> @@ -48,6 +48,7 @@
>>  / {
>>       aliases {
>>               serial0 =3D &uart_AO;
>> +             serial1 =3D &uart_A;
>>       };
>>
>>       chosen {
>> @@ -94,12 +95,21 @@
>>
>>       sdio_pwrseq: sdio-pwrseq {
>>               compatible =3D "mmc-pwrseq-simple";
>> -             reset-gpios =3D <&gpio GPIOX_6 GPIO_ACTIVE_LOW>;
>> +             reset-gpios =3D <&gpio GPIOX_6 GPIO_ACTIVE_LOW>,
>> +                           <&gpio GPIOX_17 GPIO_ACTIVE_LOW>;
>>               clocks =3D <&wifi32k>;
>>               clock-names =3D "ext_clock";
>>       };
>>  };
>>
>> +/* This is connected to the Bluetooth module of the wifi/BT combo chip:=
 */
>> +&uart_A {
>> +     status =3D "okay";
>> +     pinctrl-0 =3D <&uart_a_pins &uart_a_cts_rts_pins>;
>
> Nit: <&uart_a_pins>, <&uart_a_cts_rts_pins> please, like you've done for
> reset-gpios above.
indeed, not sure why I mixed it up. should I also send an update for
the pinctrl-documentation (as it seems to use the same pattern): [0]?

> Regards,
> Andreas
>
>> +     pinctrl-names =3D "default";
>> +     uart-has-rtscts;
>> +};
>> +
>>  /* This UART is brought out to the DB9 connector */
>>  &uart_AO {
>>       status =3D "okay";
>>
>
>
> --
> SUSE Linux GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
> GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Norton
> HRB 21284 (AG N=C3=BCrnberg)


[0] http://lxr.free-electrons.com/source/Documentation/devicetree/bindings/=
pinctrl/pinctrl-bindings.txt?v=3D4.9#L74
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
