From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: sc26xx: Fix compile breakage
Date: Wed, 1 Aug 2012 08:04:40 -0700
Message-ID: <20120801150440.GA20956@kroah.com>
References: <1343808020-26812-1-git-send-email-shc_work@mail.ru>
 <20120801125637.GB3019@kroah.com>
 <1343832930.238398280@f48.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:57334 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755128Ab2HAPEp (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 1 Aug 2012 11:04:45 -0400
Received: by yhmm54 with SMTP id m54so7392931yhm.19
        for <linux-serial@vger.kernel.org>; Wed, 01 Aug 2012 08:04:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1343832930.238398280@f48.mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>

On Wed, Aug 01, 2012 at 06:55:30PM +0400, Alexander Shiyan wrote:
> Hello.
>=20
> Wed, 1 Aug 2012 05:56:37 -0700 =D0=BE=D1=82 Greg Kroah-Hartman <gregk=
h@linuxfoundation.org>:
> > On Wed, Aug 01, 2012 at 12:00:20PM +0400, Alexander Shiyan wrote:
> > > This patch fixes the following compile breakage:
> > >   CC      drivers/tty/serial/sc26xx.o
> > > drivers/tty/serial/sc26xx.c: In function 'read_sc_port':
> > > drivers/tty/serial/sc26xx.c:100: error: implicit declaration of f=
unction 'readb'
> > > drivers/tty/serial/sc26xx.c: In function 'write_sc_port':
> > > drivers/tty/serial/sc26xx.c:105: error: implicit declaration of f=
unction 'writeb'
> > > drivers/tty/serial/sc26xx.c: In function 'sc26xx_probe':
> > > drivers/tty/serial/sc26xx.c:652: error: implicit declaration of f=
unction 'ioremap_nocache'
> > > drivers/tty/serial/sc26xx.c:652: warning: assignment makes pointe=
r from integer without a cast
> > > make[3]: *** [drivers/tty/serial/sc26xx.o] Error 1
> > > make[2]: *** [drivers/tty/serial] Error 2
> > > make[1]: *** [drivers/tty] Error 2
> > > make: *** [drivers] Error 2
> >=20
> > Breakage in what tree?  What caused this to break?
> Breakage due to missing header linux/io.h.

Again, where did this break (3.4, 3.5, 3.6-rc1, 2.6.32, etc.) and what
caused it to break (what patch?)
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
