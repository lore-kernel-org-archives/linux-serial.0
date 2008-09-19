From: Michael Trimarchi <trimarchimichael@yahoo.it>
Subject: Re: [PATCH] atmel_serial: update the powersave handler to match serial core
Date: Fri, 19 Sep 2008 16:33:09 +0000 (GMT)
Message-ID: <866907.89401.qm@web26206.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from web26206.mail.ukl.yahoo.com ([217.12.10.243]:26578 "HELO
	web26206.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751299AbYISQdM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 19 Sep 2008 12:33:12 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Victor <linux@maxim.org.za>, Anti Sullin <anti.sullin@artecdesign.ee>

Hi,



----- Messaggio originale -----
> Da: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
> A: Michael Trimarchi <trimarchimichael@yahoo.it>
> Cc: linux-serial@vger.kernel.org; linux-kernel@vger.kernel.org; Andre=
w Victor <linux@maxim.org.za>; Anti Sullin <anti.sullin@artecdesign.ee>
> Inviato: Venerd=EC 19 settembre 2008, 18:15:51
> Oggetto: Re: [PATCH] atmel_serial: update the powersave handler to ma=
tch serial core
>=20

> I agree it would be useful. It would require changing the port mux
> configuration from the driver though, and there's no standardized
> interface for doing that. Maybe this is a good motivation to come up
> with one?
>=20

I think that a driver can do the request to a the gpio layer (may can b=
e implemented
by the gpio-lib ) and give it only the gpio. The "gpio-lib" can save an=
d restore
the status of the gpio, and request the handler, passing the gpio-id as=
=20
a data. So when the handler fire, we can now which peripheral is
interested on the wake-up event.

> Btw, I assume the first character you receive will be lost when you d=
o
> this, right?
>

Yes, I haven't done a lot of test to see how many chars are lost (sure =
one I think).=20
Depends on the time spent after

 /* Wait for interrupt to wake us up */=20
  mcr p15, 0, r0, c7, c0, 4=20
=20
> Haavard

Regards Michael


__________________________________________________
Do You Yahoo!?
Poco spazio e tanto spam? Yahoo! Mail ti protegge dallo spam e ti da ta=
nto spazio gratuito per i tuoi file e i messaggi=20
http://mail.yahoo.it=20
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
