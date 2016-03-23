From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4] tty: serial: meson: Implement earlycon support
Date: Wed, 23 Mar 2016 09:39:19 -0400
Message-ID: <20160323133919.GA4235@kroah.com>
References: <1457263284-8819-1-git-send-email-afaerber@suse.de>
 <56F27268.4060902@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56F27268.4060902@suse.de>
Sender: linux-doc-owner@vger.kernel.org
To: Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-serial <linux-serial@vger.kernel.org>, linux-meson@googlegroups.com, Nicolas Saenz Julienne <nicolassaenzj@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Jiri Slaby <jslaby@suse.com>, Carlo Caione <carlo@caione.org>, linux-doc <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, LAKML <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Mar 23, 2016 at 11:39:36AM +0100, Andreas F=E4rber wrote:
> Am 06.03.2016 um 12:21 schrieb Andreas F=E4rber:
> > Split off the bulk of the existing meson_serial_console_write()
> > implementation into meson_serial_port_write() for implementing
> > meson_serial_early_console_write().
> >=20
> > Use "meson" as the earlycon driver name, courtesy of Nicolas.
> >=20
> > Signed-off-by: Nicolas Saenz Julienne <nicolassaenzj@gmail.com>
> > Acked-by: Carlo Caione <carlo@endlessm.com>
> > Signed-off-by: Andreas F=E4rber <afaerber@suse.de>
> > ---
> >  v3 -> v4:
> >  * Select SERIAL_EARLYCON (Arnd)
>=20
> Ping?

It's the middle of the merge window, there's nothing I can do at the
moment, please wait for after 4.6-rc1 is out before I can start catchin=
g
up...

greg k-h
