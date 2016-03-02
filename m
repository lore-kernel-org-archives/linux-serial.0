From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3] tty: serial: meson: Implement earlycon support
Date: Wed, 02 Mar 2016 10:19:54 +0100
Message-ID: <2758553.xUr6zr8gHg@wuerfel>
References: <1456886949-26503-1-git-send-email-afaerber@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1456886949-26503-1-git-send-email-afaerber@suse.de>
Sender: linux-doc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Andreas =?ISO-8859-1?Q?F=E4rber?= <afaerber@suse.de>, linux-meson@googlegroups.com, Peter Hurley <peter@hurleysoftware.com>, Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nicolas Saenz Julienne <nicolassaenzj@gmail.com>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Jiri Slaby <jslaby@suse.com>, Carlo Caione <carlo@caione.org>
List-Id: linux-serial@vger.kernel.org

On Wednesday 02 March 2016 03:49:09 Andreas F=E4rber wrote:
> Split off the bulk of the existing meson_serial_console_write()
> implementation into meson_serial_port_write() for implementing
> meson_serial_early_console_write().
>=20
> Use "meson" as the earlycon driver name, courtesy of Nicolas.
>=20
> Signed-off-by: Nicolas Saenz Julienne <nicolassaenzj@gmail.com>
> Signed-off-by: Andreas F=E4rber <afaerber@suse.de>
> ---

I think you also have to add

	select SERIAL_EARLYCON

in the Kconfig file now, to avoid build errors when no other
driver selects that.

	Arnd
