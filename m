From: Domenico Andreoli <cavokz@gmail.com>
Subject: Re: [GIT PATCH] TTY/serial driver patches for 3.2
Date: Wed, 26 Oct 2011 16:16:35 +0200
Message-ID: <20111026141635.GA2293@glitch>
References: <20111026114236.GA22180@kroah.com>
 <CA+55aFycM+nHxJNnFSjEXQvZkeBfHu161ePC0=7sWKZR1toQNA@mail.gmail.com>
 <20111026133438.GA26336@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:48072 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754992Ab1JZOQk (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Oct 2011 10:16:40 -0400
Content-Disposition: inline
In-Reply-To: <20111026133438.GA26336@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Wed, Oct 26, 2011 at 03:34:38PM +0200, Greg KH wrote:
> On Wed, Oct 26, 2011 at 03:18:21PM +0200, Linus Torvalds wrote:
> > On Wed, Oct 26, 2011 at 1:42 PM, Greg KH <gregkh@suse.de> wrote:
> > >
> > > The one in 8250_pci.c is trivial to fix, the atmel_serial one isn=
't as
> > > easy, but I'm sure you can figure it out :) =A0If you want me to =
do the
> > > merge for it, I'll be glad to do so, just let me know.
> >=20
> > So I figured it out, but please double-check, especially since it
> > seems to be some arm-only driver that I can't even compile-test my
> > resolution.
>=20
> I think it looks correct, but yeah, as I can't build it either, it's
> tough to tell.
>=20
> Nicolas, can you verify that Linus's merge was done correctly?  If no=
t,
> can you send a patch?  It is commit
> efb8d21b2c6db3497655cc6a033ae8a9883e4063 in Linus's tree right now.

tryed to build efb8d21 with at91cap9adk_defconfig + DT + 8250 but it fa=
ils:

drivers/tty/serial/atmel_serial.c: In function 'atmel_serial_probe':
drivers/tty/serial/atmel_serial.c:1788:3: error: implicit declaration o=
f function 'of_alias_get_id' [-Werror=3Dimplicit-function-declaration]
drivers/tty/serial/atmel_serial.c: At top level:
drivers/tty/serial/atmel_serial.c:1893:3: error: implicit declaration o=
f function 'of_match_ptr' [-Werror=3Dimplicit-function-declaration]
drivers/tty/serial/atmel_serial.c:1893:3: error: initializer element is=
 not constant
drivers/tty/serial/atmel_serial.c:1893:3: error: (near initialization f=
or 'atmel_serial_driver.driver.of_match_table')
cc1: some warnings being treated as errors

there is not mention of such (new) of_match_ptr macro anywhere in Linus=
' tree.

Regards,
Domenico
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
