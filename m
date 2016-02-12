From: "Matwey V. Kornilov" <matwey@sai.msu.ru>
Subject: Re: [PATCH v8 3/3] tty: 8250_omap: Use software emulated RS485
 direction control
Date: Fri, 12 Feb 2016 10:57:16 +0300
Message-ID: <CAJs94Ea-3Lvfmh=72EOnDhXKawBfBbM3Ue2tuW-OLemXSFTZfA@mail.gmail.com>
References: <CAEo2pzv-kSy+34JzC1hOxMLX_j2EB1KkiHsao5Tpm2cKVz9Qrg@mail.gmail.com>
 <CAJs94EZNi=g5D08c9-m0aGQFTDUSksaJNsrcT6RYsyd_az75Qg@mail.gmail.com> <CAEo2pzs7mTUFpUGvsyrzt5cYPXsWLiBLaoQ==SypBm5fKjkFjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAEo2pzs7mTUFpUGvsyrzt5cYPXsWLiBLaoQ==SypBm5fKjkFjA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?0JjQu9GM0Y/RgSDQk9Cw0YHQsNC90L7Qsg==?= <torso.nafi@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-kernel <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

2016-02-11 23:19 GMT+03:00 =D0=98=D0=BB=D1=8C=D1=8F=D1=81 =D0=93=D0=B0=D1=
=81=D0=B0=D0=BD=D0=BE=D0=B2 <torso.nafi@gmail.com>:
> 2016-02-11 22:08 GMT+03:00 Matwey V. Kornilov <matwey@sai.msu.ru>:
>> Thanks for pointing out. serial8250_unregister_port should set
>> serial8250_ports[line].em485 to NULL in order to prevent unneeded
>> activation when this struct is reused.
>
> Then the allocated/initialized resources should be freed/released as =
well.

Sure, I've already sketched the patch, but to test it, I need some
time to build 8250_omap as a module and setup networking console and
kgdb over network.

>
>> You would be able to use serial8250_em485_register in omap8250_probe
>> on &up before serial8250_register_8250_port(&up) if
>> serial8250_register_8250_port could replicate em485 member state.
>> But there are alternatives in implementation.
>
> I'm considering adding the relevant code to the omap8250_startup and
> omap8250_shutdown callback functions. However the serial driver
> documentation claims that these don't have port->lock taken when
> invoked, only port_sem.
>
>> serial8250_register_8250_port may either copy pointer up->em485 to
>> uart->em485 or perform deep copy.
>
> Actually, "up" here in omap8250_probe is not a pointer but a struct
> variable on stack, so copying the pointer to it is out of question.
>

up->em485 is always pointer, however you are right, that
serial8250_em485_init stores pointer to up when the timers are inited.
More complex issue here that serial8250_em485_init need to set RTS to
proper state and probably can't do that before
serial8250_register_8250_port. So omap8250_probe should directly or
indirectly use serial8250_get_port(priv->line) after
serial8250_register_8250_port. As for me, possible solution could be
to add a wrapper:

int serial8250_em485_init_by_line(int line) {
    struct uart_8250_port *uart =3D &serial8250_ports[line];
    int ret;
    unsigned long flags;

    spin_lock_irqsave(&uart->port.lock, flags);
    ret =3D serial8250_em485_init(uart).
    spin_unlock_irqrestore(&uart->port.lock, flags);

    return ret;
}

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
