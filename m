From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH v6] uartclk value from serial_core exposed to sysfs
Date: Thu, 06 Sep 2012 21:47:27 +0200
Message-ID: <5048FDCF.8020602@suse.cz>
References: <1344929718-22736-1-git-send-email-tmshlvck@gmail.com> <1346894238-12870-1-git-send-email-tmshlvck@gmail.com> <5048E35F.5020304@suse.cz> <CAEB7QLAWLuXFLWMYX70enP5X0z5EXTNo93hfOm7sH_kQteMAkA@mail.gmail.com> <5048F161.3000805@suse.cz> <CAEB7QLAk6pe9ih+P_621fZE3JpRcFpPA+Wzk57x3FmVaGmoOKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:62937 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758690Ab2IFTrb (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 6 Sep 2012 15:47:31 -0400
In-Reply-To: <CAEB7QLAk6pe9ih+P_621fZE3JpRcFpPA+Wzk57x3FmVaGmoOKg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tomas Hlavacek <tmshlvck@gmail.com>
Cc: gregkh@linuxfoundation.org, alan@linux.intel.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, marek.vasut@gmail.com

On 09/06/2012 09:41 PM, Tomas Hlavacek wrote:
>> * why are you passing tty_port to the struct device's private data a=
nd
>> not uart_port proper? Is this for some future use?
>=20
> I actually used the uart_port structure in older RFC versions of the
> patch. Alan Cox advised to use struct tty_port because of consistency=
=2E
> More precisely he said (in an e-mail from Aug 12):
>=20
> I'd rather however it pointed
> to the tty_port that each tty device has (or very soon will be requir=
ed
> to have).

Yes, this is already a requirement in tty-next. And every driver has to
provide us with the tty_port as you might persuaded yourself of that
already ;).

> You can still find the uart_foo structs from that but it means
> we can do the dev_set_drvdata() in a consistent manner for all tty
> devices in the kernel. That in turn means we can make some of the sys=
fs
> valid the same way.

Ah, OK, makes sense.

>> * cannot be all those attribute structs const?
>=20
> It seems that making
>=20
> static const struct attribute *tty_dev_attrs[] =3D ...
>=20
> produces warning:
>=20
> drivers/tty/serial/serial_core.c:2334:2: warning: initialization from
> incompatible pointer type [enabled by default]
> drivers/tty/serial/serial_core.c:2334:2: warning: (near initializatio=
n
> for =E2=80=98tty_dev_attr_group.attrs=E2=80=99) [enabled by default]
>=20
> But others can. I am going to make them const in following patch.

Ok, it was only a suggestion. I did not know either.

regards,
--=20
js
suse labs
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
