From: Gerald Emig <gme@emig-software.de>
Subject: Re: Non-standard baud rate setting 14400 ..Possible?
Date: Fri, 10 Oct 2003 19:58:49 +0200
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20031010195849.0f33ab62.gme@emig-software.de>
References: <007101c38f3e$e6419d70$cf14a8c0@sampath>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:13305 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S263052AbTJJR7a convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 10 Oct 2003 13:59:30 -0400
In-Reply-To: <007101c38f3e$e6419d70$cf14a8c0@sampath>
List-Id: linux-serial@vger.kernel.org
To: Sampath Kumar <sampath@spartanlabs.com>
Cc: linux-serial@vger.kernel.org


There is no such way;
main reason is that the serial hardware does not support these data
speeds (even under Win***).

But as I see from the rates that you mention, it seems that you talk vi=
a
a modem. Note that modem speed and speed of the serial port are two
different things. Modem speeds are normally handled by the modem
(automatically or by AT-commands), not by the linux serial driver.

I hope this helps, but feel free to ask more questions.



On Fri, 10 Oct 2003 20:27:59 +0530
"Sampath Kumar" <sampath@spartanlabs.com> wrote:

> Hello ,
>=20
> Is there a way to set the serial port on the i386 Linux 2.4.17 at non
> standard baud rates like 14400,28800,etc.?
>=20
> Regards
> Sampath
>=20
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-serial" in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--=20

Gerald Emig

--
EMIG Software           Tel. 06858-6197, Mobil: 0163-4751706
Engelstr. 17            Fax. 0721-151-348672
66564 Ottweiler-F=FCrth   http://www.emig-software.de
Germany                 e-mail: gme@emig-software.de

-
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
