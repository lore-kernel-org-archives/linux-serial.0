From: "Matwey V. Kornilov" <matwey@sai.msu.ru>
Subject: Re: [PATCH v8 3/3] tty: 8250_omap: Use software emulated RS485
 direction control
Date: Thu, 11 Feb 2016 22:08:11 +0300
Message-ID: <CAJs94EZNi=g5D08c9-m0aGQFTDUSksaJNsrcT6RYsyd_az75Qg@mail.gmail.com>
References: <CAEo2pzv-kSy+34JzC1hOxMLX_j2EB1KkiHsao5Tpm2cKVz9Qrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAEo2pzv-kSy+34JzC1hOxMLX_j2EB1KkiHsao5Tpm2cKVz9Qrg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?0JjQu9GM0Y/RgSDQk9Cw0YHQsNC90L7Qsg==?= <torso.nafi@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-kernel <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

2016-02-11 19:40 GMT+03:00 =D0=98=D0=BB=D1=8C=D1=8F=D1=81 =D0=93=D0=B0=D1=
=81=D0=B0=D0=BD=D0=BE=D0=B2 <torso.nafi@gmail.com>:
> Hello,
>
> 2016-02-01 21:09 GMT+03:00 "Matwey V. Kornilov" <matwey@sai.msu.ru>:
>> +static int omap_8250_rs485_config(struct uart_port *port,
>> +                                 struct serial_rs485 *rs485)
>> +{
>> +       struct uart_8250_port *up =3D up_to_u8250p(port);
>> +
>> +       /* Clamp the delays to [0, 100ms] */
>> +       rs485->delay_rts_before_send =3D min(rs485->delay_rts_before=
_send, 100U);
>> +       rs485->delay_rts_after_send  =3D min(rs485->delay_rts_after_=
send, 100U);
>> +
>> +       port->rs485 =3D *rs485;
>> +
>> +       /*
>> +        * Both serial8250_em485_init and serial8250_em485_destroy
>> +        * are idempotent
>> +        */
>> +       if (rs485->flags & SER_RS485_ENABLED) {
>> +               int ret =3D serial8250_em485_init(up);
>> +
>> +               if (ret) {
>> +                       rs485->flags &=3D ~SER_RS485_ENABLED;
>> +                       port->rs485.flags &=3D ~SER_RS485_ENABLED;
>> +               }
>> +               return ret;
>> +       }
>> +
>> +       serial8250_em485_destroy(up);
>> +
>> +       return 0;
>> +}
>
> I think that an invocation of serial8250_em485_destroy() should be
> performed inside omap8250_remove() as well. However there is a catch =
-
> serial8250_get_port() is only reserved for suspend-resume power
> management operations, and I am aware of no other means how to supply
> an uart_8250_port to serial8250_em485_destroy() at that point.

Thanks for pointing out. serial8250_unregister_port should set
serial8250_ports[line].em485 to NULL in order to prevent unneeded
activation when this struct is reused.

>
> Similarly, I got no idea on how to implement handling
> "linux,rs485-enabled-at-boot-time" property without using
> serial8250_get_port() directly (well, honestly I could try invoking
> the corresponding ioctl somehow, but that's gonna be plain ugly at
> least).

You would be able to use serial8250_em485_register in omap8250_probe
on &up before serial8250_register_8250_port(&up) if
serial8250_register_8250_port could replicate em485 member state.
But there are alternatives in implementation.
serial8250_register_8250_port may either copy pointer up->em485 to
uart->em485 or perform deep copy.

>
> Regards,
> Ilyas G.
>



--=20
With best regards,
Matwey V. Kornilov.
Sternberg Astronomical Institute, Lomonosov Moscow State University, Ru=
ssia
119991, Moscow, Universitetsky pr-k 13, +7 (495) 9392382
