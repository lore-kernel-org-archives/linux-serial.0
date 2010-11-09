From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] serial: 8250: fix uninitialized compiler warning
Date: Tue, 9 Nov 2010 18:33:10 +0000
Message-ID: <20101109183310.2ac49f38@lxorguk.ukuu.org.uk>
References: <1289321723.2260.14.camel@cowboy>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:52504 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753583Ab0KISed convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 9 Nov 2010 13:34:33 -0500
In-Reply-To: <1289321723.2260.14.camel@cowboy>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: dave@gnu.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>, linux-serial@vger.kernel.org

On Tue, 09 Nov 2010 13:55:23 -0300
Davidlohr Bueso <dave@gnu.org> wrote:

> From: Davidlohr Bueso <dave@gnu.org>
>=20
> This addresses:
>=20
>   CC [M]  drivers/serial/8250.o
> drivers/serial/8250.c: In function =E2=80=98serial8250_shutdown=E2=80=
=99:
> drivers/serial/8250.c:1696: warning: =E2=80=98i=E2=80=99 may be used =
uninitialized in this function
> drivers/serial/8250.c:1696: note: =E2=80=98i=E2=80=99 was declared he=
re

NAK - pleass see the four or five previous discussions on this one.

The current compilers all seem to get it right anyway.

Alan
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
