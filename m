From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] serial: pl011: protect attribute read from NULL platform
 data struct
Date: Wed, 15 May 2013 10:23:22 +0100
Message-ID: <20130515092322.GC3494@gmail.com>
References: <1368103855-28363-1-git-send-email-lee.jones@linaro.org>
 <CACRpkdZR3AsGyCUH=cbskcZPs0PVBjH6QXUGkD+KG8SzGMMOKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdZR3AsGyCUH=cbskcZPs0PVBjH6QXUGkD+KG8SzGMMOKg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Linus WALLEIJ <linus.walleij@stericsson.com>, Srinidhi KASAGAR <srinidhi.kasagar@stericsson.com>, Russell King <linux@arm.linux.org.uk>, Jiri Slaby <jslaby@suse.cz>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Mon, 13 May 2013, Linus Walleij wrote:

> On Thu, May 9, 2013 at 2:50 PM, Lee Jones <lee.jones@linaro.org> wrot=
e:
>=20
> > It's completely feasible that platform data will be empty i.e. when
> > booting with Device Tree with no device AUXDATA. So we must protect
> > it's use in these use-cases, or risk a kernel Oops.
> >
> > Cc: Russell King <linux@arm.linux.org.uk>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Jiri Slaby <jslaby@suse.cz>
> > Cc: linux-serial@vger.kernel.org
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> > *******                                                        ****=
***
> > If this issue has not already been fixed, this patch should be appl=
ied
> > during the v3.10 -rc:s, as it fixes a serious bug which was introdu=
ced
> > in the merge-window.
> > *******                                                        ****=
***
>=20
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>=20
> You should probably put Greg on To: so that he picks this up for
> the -rc:s ASAP.

I spoke with Greg yesterday. He's catching up on mail.

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
