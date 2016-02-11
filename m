From: =?UTF-8?B?0JjQu9GM0Y/RgSDQk9Cw0YHQsNC90L7Qsg==?=
	<torso.nafi@gmail.com>
Subject: Re: [PATCH v8 3/3] tty: 8250_omap: Use software emulated RS485
 direction control
Date: Thu, 11 Feb 2016 23:19:52 +0300
Message-ID: <CAEo2pzs7mTUFpUGvsyrzt5cYPXsWLiBLaoQ==SypBm5fKjkFjA@mail.gmail.com>
References: <CAEo2pzv-kSy+34JzC1hOxMLX_j2EB1KkiHsao5Tpm2cKVz9Qrg@mail.gmail.com>
	<CAJs94EZNi=g5D08c9-m0aGQFTDUSksaJNsrcT6RYsyd_az75Qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJs94EZNi=g5D08c9-m0aGQFTDUSksaJNsrcT6RYsyd_az75Qg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Matwey V. Kornilov" <matwey@sai.msu.ru>
Cc: Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-kernel <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

2016-02-11 22:08 GMT+03:00 Matwey V. Kornilov <matwey@sai.msu.ru>:
> Thanks for pointing out. serial8250_unregister_port should set
> serial8250_ports[line].em485 to NULL in order to prevent unneeded
> activation when this struct is reused.

Then the allocated/initialized resources should be freed/released as well.

> You would be able to use serial8250_em485_register in omap8250_probe
> on &up before serial8250_register_8250_port(&up) if
> serial8250_register_8250_port could replicate em485 member state.
> But there are alternatives in implementation.

I'm considering adding the relevant code to the omap8250_startup and
omap8250_shutdown callback functions. However the serial driver
documentation claims that these don't have port->lock taken when
invoked, only port_sem.

> serial8250_register_8250_port may either copy pointer up->em485 to
> uart->em485 or perform deep copy.

Actually, "up" here in omap8250_probe is not a pointer but a struct
variable on stack, so copying the pointer to it is out of question.


Regards,
Ilyas G.
