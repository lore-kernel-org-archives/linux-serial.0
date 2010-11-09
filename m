From: Davidlohr Bueso <dave@gnu.org>
Subject: Re: [PATCH] serial: 8250: fix uninitialized compiler warning
Date: Tue, 09 Nov 2010 15:54:36 -0300
Message-ID: <1289328876.2260.37.camel@cowboy>
References: <1289321723.2260.14.camel@cowboy>
	 <20101109183310.2ac49f38@lxorguk.ukuu.org.uk>
Reply-To: dave@gnu.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailbigip.dreamhost.com ([208.97.132.5]:43880 "EHLO
	homiemail-a4.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752344Ab0KISyp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 9 Nov 2010 13:54:45 -0500
In-Reply-To: <20101109183310.2ac49f38@lxorguk.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>, linux-serial@vger.kernel.org

On Tue, 2010-11-09 at 18:33 +0000, Alan Cox wrote:
> On Tue, 09 Nov 2010 13:55:23 -0300
> Davidlohr Bueso <dave@gnu.org> wrote:
>=20
> > From: Davidlohr Bueso <dave@gnu.org>
> >=20
> > This addresses:
> >=20
> >   CC [M]  drivers/serial/8250.o
> > drivers/serial/8250.c: In function =E2=80=98serial8250_shutdown=E2=80=
=99:
> > drivers/serial/8250.c:1696: warning: =E2=80=98i=E2=80=99 may be use=
d uninitialized in this function
> > drivers/serial/8250.c:1696: note: =E2=80=98i=E2=80=99 was declared =
here
>=20
> NAK - pleass see the four or five previous discussions on this one.
>=20
Yes I should have googled this one before sending.

> The current compilers all seem to get it right anyway.

This is with gcc 4.4.5 (ubuntu 10.10 - latest), released on October 1st=
,
2010 (quite current).

Thanks,
Davidlohr


--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
