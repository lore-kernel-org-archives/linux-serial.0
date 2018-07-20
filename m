From: Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] serial: 8250_ingenic: Add support for the JZ4725B SoC
Date: Fri, 20 Jul 2018 20:58:08 +0200
Message-ID: <1532113088.2309.0@smtp.crapouillou.net>
References: <20180713143840.9721-1-paul@crapouillou.net>
        <20180720153027.GA11978@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180720153027.GA11978@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Rob,

Le ven. 20 juil. 2018 =E0 17:30, Rob Herring <robh@kernel.org> a =E9crit :
> On Fri, Jul 13, 2018 at 04:38:40PM +0200, Paul Cercueil wrote:
>>  The UART in the jz4725b works just like in the other JZ SoCs, so=20
>> this
>>  commit simply adds a new compatible string.
>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>   Documentation/devicetree/bindings/serial/ingenic,uart.txt | 1 +
>>   drivers/tty/serial/8250/8250_ingenic.c                    | 5 +++++
>>   2 files changed, 6 insertions(+)
>>=20
>>  diff --git=20
>> a/Documentation/devicetree/bindings/serial/ingenic,uart.txt=20
>> b/Documentation/devicetree/bindings/serial/ingenic,uart.txt
>>  index c3c6406d5cfe..a0b34fd3b602 100644
>>  --- a/Documentation/devicetree/bindings/serial/ingenic,uart.txt
>>  +++ b/Documentation/devicetree/bindings/serial/ingenic,uart.txt
>>  @@ -3,6 +3,7 @@
>>   Required properties:
>>   - compatible : One of:
>>     - "ingenic,jz4740-uart",
>>  +  - "ingenic,jz4725b-uart",
>>     - "ingenic,jz4760-uart",
>>     - "ingenic,jz4770-uart",
>>     - "ingenic,jz4775-uart",
>>  diff --git a/drivers/tty/serial/8250/8250_ingenic.c=20
>> b/drivers/tty/serial/8250/8250_ingenic.c
>>  index 15a8c8dfa92b..760266559a5a 100644
>>  --- a/drivers/tty/serial/8250/8250_ingenic.c
>>  +++ b/drivers/tty/serial/8250/8250_ingenic.c
>>  @@ -133,6 +133,10 @@ EARLYCON_DECLARE(jz4740_uart,=20
>> ingenic_early_console_setup);
>>   OF_EARLYCON_DECLARE(jz4740_uart, "ingenic,jz4740-uart",
>>   		    ingenic_early_console_setup);
>>=20
>>  +EARLYCON_DECLARE(jz4725b_uart, ingenic_early_console_setup);
>>  +OF_EARLYCON_DECLARE(jz4725b_uart, "ingenic,jz4725b-uart",
>>  +		    ingenic_early_console_setup);
>>  +
>=20
> This shouldn't be necessary. Looks like it should be compatible with
> ingenic,jz4740-uart.
>=20
>>   EARLYCON_DECLARE(jz4770_uart, ingenic_early_console_setup);
>>   OF_EARLYCON_DECLARE(jz4770_uart, "ingenic,jz4770-uart",
>>   		    ingenic_early_console_setup);
>>  @@ -330,6 +334,7 @@ static const struct ingenic_uart_config=20
>> jz4780_uart_config =3D {
>>=20
>>   static const struct of_device_id of_match[] =3D {
>>   	{ .compatible =3D "ingenic,jz4740-uart", .data =3D=20
>> &jz4740_uart_config },
>>  +	{ .compatible =3D "ingenic,jz4725b-uart", .data =3D=20
>> &jz4740_uart_config },
>=20
> And this too.

Well, I'm confused, the driver already uses multiple compatible strings=20
for SoCs that
work the exact same, so that was wrong?

>>   	{ .compatible =3D "ingenic,jz4760-uart", .data =3D=20
>> &jz4760_uart_config },
>>   	{ .compatible =3D "ingenic,jz4770-uart", .data =3D=20
>> &jz4760_uart_config },
>>   	{ .compatible =3D "ingenic,jz4775-uart", .data =3D=20
>> &jz4760_uart_config },
>>  --
>>  2.11.0
>>=20
=
