From: Alexander Shiyan <shc_work@mail.ru>
Subject: Re: [PATCH] serial: sc26xx: Fix compile breakage
Date: Wed, 1 Aug 2012 21:44:16 +0400
Message-ID: <20120801214416.36e82420.shc_work@mail.ru>
References: <1343808020-26812-1-git-send-email-shc_work@mail.ru>
	<20120801125637.GB3019@kroah.com>
	<1343832930.238398280@f48.mail.ru>
	<20120801150440.GA20956@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp24.mail.ru ([94.100.176.177]:43360 "EHLO smtp24.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754281Ab2HARoY (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 1 Aug 2012 13:44:24 -0400
In-Reply-To: <20120801150440.GA20956@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>

On Wed, 1 Aug 2012 08:04:40 -0700
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Wed, Aug 01, 2012 at 06:55:30PM +0400, Alexander Shiyan wrote:
> > Wed, 1 Aug 2012 05:56:37 -0700 =CF=D4 Greg Kroah-Hartman <gregkh@li=
nuxfoundation.org>:
> > > On Wed, Aug 01, 2012 at 12:00:20PM +0400, Alexander Shiyan wrote:
> > > > This patch fixes the following compile breakage:
> > > >   CC      drivers/tty/serial/sc26xx.o
> > > > drivers/tty/serial/sc26xx.c: In function 'read_sc_port':
> > > > drivers/tty/serial/sc26xx.c:100: error: implicit declaration of=
 function 'readb'
> > > > drivers/tty/serial/sc26xx.c: In function 'write_sc_port':
> > > > drivers/tty/serial/sc26xx.c:105: error: implicit declaration of=
 function 'writeb'
> > > > drivers/tty/serial/sc26xx.c: In function 'sc26xx_probe':
> > > > drivers/tty/serial/sc26xx.c:652: error: implicit declaration of=
 function 'ioremap_nocache'
> > > > drivers/tty/serial/sc26xx.c:652: warning: assignment makes poin=
ter from integer without a cast
> > > > make[3]: *** [drivers/tty/serial/sc26xx.o] Error 1
> > > > make[2]: *** [drivers/tty/serial] Error 2
> > > > make[1]: *** [drivers/tty] Error 2
> > > > make: *** [drivers] Error 2
> > >=20
> > > Breakage in what tree?  What caused this to break?
> > Breakage due to missing header linux/io.h.
>=20
> Again, where did this break (3.4, 3.5, 3.6-rc1, 2.6.32, etc.) and wha=
t
> caused it to break (what patch?)

I'm using kernel 3.4.5. Perhaps, the problem not in header that missing=
, but is that I build
a driver for ARM platform, i.e. with a patched Makefile. In any case, y=
ou can just drop this
patch. I use these ICs with ARM architecture, and so I write an improve=
d version of the driver
that will support all ICs from this series and do not depend on the arc=
hitecture.

--=20
Alexander Shiyan <shc_work@mail.ru>
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
