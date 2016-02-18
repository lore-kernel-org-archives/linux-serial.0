From: =?UTF-8?B?0JjQu9GM0Y/RgSDQk9Cw0YHQsNC90L7Qsg==?=
	<torso.nafi@gmail.com>
Subject: Re: [PATCH v8 3/3] tty: 8250_omap: Use software emulated RS485
 direction control
Date: Thu, 18 Feb 2016 21:15:33 +0300
Message-ID: <CAEo2pzuHwLgE3iBxeJ406tZuVN6EF_Z3wFdVfk64_jvmNqV4fQ@mail.gmail.com>
References: <CAEo2pzv-kSy+34JzC1hOxMLX_j2EB1KkiHsao5Tpm2cKVz9Qrg@mail.gmail.com>
	<CAJs94EZNi=g5D08c9-m0aGQFTDUSksaJNsrcT6RYsyd_az75Qg@mail.gmail.com>
	<CAEo2pzs7mTUFpUGvsyrzt5cYPXsWLiBLaoQ==SypBm5fKjkFjA@mail.gmail.com>
	<CAJs94Ea-3Lvfmh=72EOnDhXKawBfBbM3Ue2tuW-OLemXSFTZfA@mail.gmail.com>
	<CAEo2pzsRdhqiFiHOc8BxFsiJwJ9WTru3dGaWgfssJLWQ5FCTyg@mail.gmail.com>
	<CAEo2pzsqo5Zp99n9GKD3e1_f_+YErJiRHc=rQy7HPvmQ92iM3A@mail.gmail.com>
	<CAEo2pzu60tmME7N07X+OyGHpDnxT9VnzNDO2SZ9qRGu5zKpWuA@mail.gmail.com>
	<CAEo2pzsRf++Yaexn2K=RTu=NJs6GwC=6DXC50a=Xv92FO8N7Vg@mail.gmail.com>
	<56C5F63B.1060306@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56C5F63B.1060306@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: "Matwey V. Kornilov" <matwey@sai.msu.ru>, Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-kernel <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hello,

2016-02-18 19:50 GMT+03:00 Peter Hurley <peter@hurleysoftware.com>:
> No, that's not the way.
>
> First, there's plenty of driver hooks to properly manage the RTS level
> for rs485.

For now I'm considering to add the check to uart_dtr_rts in
serial_core.c. However, given the access to struct
tty_port_operations, I think it's also possible to use a
driver-specific hook if it makes more sense. The question is - where
exactly does it belong?

> Second, how are you running GPIO rts with the omap8250 driver?

Through hooking set_mctrl and get_mctrl and using the suggested
helpers from serial_mctrl_gpio.c. Though I had to introduce
uart_port.get_mctrl to serial_core.h (with set_mctrl already being
there) and serial8250_do_get_mctrl to serial_8250.h (same here,
serial8250_do_set_mctrl is already there).


Regards,
Ilyas G.
