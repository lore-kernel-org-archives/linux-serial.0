From: romain izard <romain.izard@mobile-devices.fr>
Subject: Re: [PATCH] tty/serial: at91: restore dynamic driver binding
Date: Wed, 24 Feb 2016 16:32:53 +0100
Message-ID: <CAGkQfmPyqu-XCzphbZ8=VMgdC5NA6whyb2BUFZhQbSb2_RKkeg@mail.gmail.com>
References: <1456246781-19606-1-git-send-email-romain.izard.pro@gmail.com> <56CDC403.4090505@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56CDC403.4090505@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, Paul Gortmaker <paul.gortmaker@windriver.com>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

2016-02-24 15:53 GMT+01:00 Nicolas Ferre <nicolas.ferre@atmel.com>:
> Le 23/02/2016 17:59, Romain Izard a =C3=A9crit :
>> In commit c39dfebc7798956fd2140ae6321786ff35da30c3, the modular supp=
ort
>> code for atmel_serial was removed, as the driver cannot be built as =
a
>> module. Because no use case was proposed, the dynamic driver binding
>> support was removed as well.
>>
>> The atmel_serial driver can manage up to 7 serial controllers, which=
 are
>> multiplexed with other functions. For example, in the Atmel SAMA5D2,=
 the
>> Flexcom controllers can work as USART, SPI or I2C controllers, and o=
n
>> all Atmel devices serial lines can be reconfigured as GPIOs.
>
> Well this paragraph somehow puzzled me and made me think that you onl=
y
> have to keep the serial port as "disabled" in the DT to achieve what =
you
> had had in mind.
>
>> My use case uses GPIOs to transfer a firmware update using a custom
>> protocol on the lines used as a serial port during the normal life o=
f
>> the device. If it is not possible to unbind the atmel_serial driver,=
 the
>> GPIO lines remain reserved and prevent this case from working.
>
> Yes, here I understand better. Your use case is somewhat uncommon as
> your SoC pads can be configured for two different uses with two
> different drivers in front of your hardware device...
>
>> This patch reinstates the atmel_serial_remove function, and fixes it=
 as
>> it failed to clear the "clk" field on removal, triggering an oops wh=
en
>> a device was bound again after being unbound.
>
> Well, okay. As the modification is not that big and that the solution=
 is
> pretty elegant, I'll take it.
>
>
>> Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
>> ---
>>  drivers/tty/serial/atmel_serial.c | 30 +++++++++++++++++++++++++++-=
--
>>  1 file changed, 27 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/=
atmel_serial.c
>> index 1c0884d8ef32..59e241723edc 100644
>> --- a/drivers/tty/serial/atmel_serial.c
>> +++ b/drivers/tty/serial/atmel_serial.c
>> @@ -2759,14 +2759,38 @@ err:
>>       return ret;
>>  }
>>
>> +static int atmel_serial_remove(struct platform_device *pdev)
>> +{
>> +     struct uart_port *port =3D platform_get_drvdata(pdev);
>> +     struct atmel_uart_port *atmel_port =3D to_atmel_uart_port(port=
);
>> +     int ret =3D 0;
>> +
>> +     tasklet_kill(&atmel_port->tasklet);
>> +
>> +     device_init_wakeup(&pdev->dev, 0);
>> +
>> +     ret =3D uart_remove_one_port(&atmel_uart, port);
>> +
>> +     kfree(atmel_port->rx_ring.buf);
>> +
>> +     /* "port" is allocated statically, so we shouldn't free it */
>> +
>> +     clear_bit(port->line, atmel_ports_in_use);
>> +
>> +     clk_put(atmel_port->clk);
>> +     atmel_port->clk =3D NULL;
>> +
>> +     return ret;
>> +}
>> +
>>  static struct platform_driver atmel_serial_driver =3D {
>>       .probe          =3D atmel_serial_probe,
>> +     .remove         =3D atmel_serial_remove,
>>       .suspend        =3D atmel_serial_suspend,
>>       .resume         =3D atmel_serial_resume,
>>       .driver         =3D {
>> -             .name                   =3D "atmel_usart",
>> -             .of_match_table         =3D of_match_ptr(atmel_serial_=
dt_ids),
>> -             .suppress_bind_attrs    =3D true,
>> +             .name   =3D "atmel_usart",
>> +             .of_match_table =3D of_match_ptr(atmel_serial_dt_ids),
>
> The 2 modifications above are not related to the patch: keep them lik=
e
> they were event if it's not as pretty as you would like...
>

These modifications were introduced by the patch I reversed, so the
alignment just returned to what it was before Paul's patch. And I need
to remove "suppress_bind_attrs", otherwise it's not possible to unbind
the device and the driver.

Best regards,
--=20
Romain Izard
