From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH -next] serial: etraxfs-uart: Update gpiod API
Date: Thu, 23 Jul 2015 15:23:49 -0700
Message-ID: <20150723222349.GB9973@kroah.com>
References: <1437510892-30376-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1437510892-30376-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-cris-kernel@axis.com, Jesper Nilsson <jesper.nilsson@axis.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
List-Id: linux-serial@vger.kernel.org

On Tue, Jul 21, 2015 at 01:34:52PM -0700, Guenter Roeck wrote:
> Commit b17d1bf16cc7 ("gpio: make flags mandatory for gpiod_get functi=
ons")
> makes the flags argument to devm_gpiod_get_optional mandatory but doe=
s not
> update all users. This results in the following build error.
>=20
> drivers/tty/serial/etraxfs-uart.c:933:16: error:
> 	too few arguments to function =E2=80=98devm_gpiod_get_optional=E2=80=
=99
>=20
> Fixes: b17d1bf16cc7 ("gpio: make flags mandatory for gpiod_get functi=
ons")

This patch isn't in Linus's tree, so whatever tree this commit is in,
needs to also take this fix.

thanks,

greg k-h
