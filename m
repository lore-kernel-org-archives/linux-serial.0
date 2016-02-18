From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v8 3/3] tty: 8250_omap: Use software emulated RS485
 direction control
Date: Thu, 18 Feb 2016 08:50:03 -0800
Message-ID: <56C5F63B.1060306@hurleysoftware.com>
References: <CAEo2pzv-kSy+34JzC1hOxMLX_j2EB1KkiHsao5Tpm2cKVz9Qrg@mail.gmail.com>
 <CAJs94EZNi=g5D08c9-m0aGQFTDUSksaJNsrcT6RYsyd_az75Qg@mail.gmail.com>
 <CAEo2pzs7mTUFpUGvsyrzt5cYPXsWLiBLaoQ==SypBm5fKjkFjA@mail.gmail.com>
 <CAJs94Ea-3Lvfmh=72EOnDhXKawBfBbM3Ue2tuW-OLemXSFTZfA@mail.gmail.com>
 <CAEo2pzsRdhqiFiHOc8BxFsiJwJ9WTru3dGaWgfssJLWQ5FCTyg@mail.gmail.com>
 <CAEo2pzsqo5Zp99n9GKD3e1_f_+YErJiRHc=rQy7HPvmQ92iM3A@mail.gmail.com>
 <CAEo2pzu60tmME7N07X+OyGHpDnxT9VnzNDO2SZ9qRGu5zKpWuA@mail.gmail.com>
 <CAEo2pzsRf++Yaexn2K=RTu=NJs6GwC=6DXC50a=Xv92FO8N7Vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAEo2pzsRf++Yaexn2K=RTu=NJs6GwC=6DXC50a=Xv92FO8N7Vg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?0JjQu9GM0Y/RgSDQk9Cw0YHQsNC90L7Qsg==?= <torso.nafi@gmail.com>, "Matwey V. Kornilov" <matwey@sai.msu.ru>
Cc: Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-kernel <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 02/18/2016 01:46 AM, =D0=98=D0=BB=D1=8C=D1=8F=D1=81 =D0=93=D0=B0=D1=81=
=D0=B0=D0=BD=D0=BE=D0=B2 wrote:
> 2016-02-18 10:18 GMT+03:00 =D0=98=D0=BB=D1=8C=D1=8F=D1=81 =D0=93=D0=B0=
=D1=81=D0=B0=D0=BD=D0=BE=D0=B2 <torso.nafi@gmail.com>:
>> Also, forgot to mention that if serial8250_em485_init is called not
>> upon uart startup but elsewhere (upon port register for example), an=
d
>> em485 is set, serial8250_do_startup should call
>> serial8250_em485_rts_after_send, or else RTS might be in wrong state
>> whenever the port device is opened, making it impossible to receive
>> data through RTS-controlled RS232<->RS485 hardware converters.
>=20
> Just found out that it doesn't help. Actually, it is the behavior of
> tty_open function to call tty_port_block_til_ready after startup, and
> of the latter - to set RTS via ioctl if baud is not zero - both of
> which cannot be overriden within the scope of the 8250 framework. The
> reason this works in legacy omap_serial is that my GPIO which is used
> to emulate RTS is not tied to mctrl there, so the call of
> tty_port_block_til_ready does not affect its state.
>=20
> Therefore, a check for SER_RS485_ENABLED needs to be introduced to
> tty_port_block_til_ready.

No, that's not the way.

=46irst, there's plenty of driver hooks to properly manage the RTS leve=
l
for rs485.
Second, how are you running GPIO rts with the omap8250 driver?
