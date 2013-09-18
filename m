From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [PATCH] serial: samsung: add support for manual RTS setting
Date: Wed, 18 Sep 2013 11:40:51 +0200
Message-ID: <2325055.YfxTctqBtd@amdc1227>
References: <1378894107-7904-1-git-send-email-jose.goncalves@inov.pt>
 <2486439.1yKjlWu5X1@amdc1227> <5238A8B1.9080105@inov.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:42678 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751343Ab3IRJlB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 18 Sep 2013 05:41:01 -0400
In-reply-to: <5238A8B1.9080105@inov.pt>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: =?ISO-8859-1?Q?Jos=E9_Miguel_Gon=E7alves?= <jose.goncalves@inov.pt>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>, Sylwester Nawrocki <s.nawrocki@samsung.com>

On Tuesday 17 of September 2013 20:08:33 Jos=E9 Miguel Gon=E7alves wrot=
e:
> On 17-09-2013 16:21, Tomasz Figa wrote:
> > I had the following scenario in mind:
> > 1) enable CRTSCTS,
> > 2) set RTS status using the IOCTL,
> > 3) disable CRTSCTS,
> > 4) do something,
> > 5) enable CRTSCTS again.
> >=20
> > I would expect that the value set in point 2 would be still valid a=
fter
> > point 5, while it will be reset.
>=20
> Maybe I'm missing something but, as I see it, as soon as you enable A=
=46C
> in the UART controller the RTS pin is no more manually controllable, =
so
> after point 5 the pin is set automattically by the controller accordi=
ng
> with the Rx FIFO contents. Don't you want to say instead that the val=
ue
> set in 2) will be valid in 4)?

Ahh, right, I inverted CRTSCTS bit polarity in points 1, 3 and 5. It sh=
ould=20
be:
1) disable CRTSCTS,
2) set RTS status using the IOCTL,
3) enable CRTSCTS,
4) do something,
5) disable CRTSCTS again.

> >> Regarding port capability, if it's decided to validate it in
> >> s3c24xx_serial_get_mctrl() and s3c24xx_serial_set_mctrl() it shoul=
d
> >> also
> >> be validated here. The question is how to validate for the full
> >> spectrum
> >> of SoCs that this driver supports?
> >=20
> > Hmm, since the driver is already broken in this aspect, ignoring th=
is
> > in
> > your patch might be fine for now. A follow up patch fixing this wou=
ld
> > be
> > welcome, though. However I don't have any good idea how to implemen=
t
> > this at the moment.
> >=20
> > First thing that comes to my mind is using the variant data structu=
res
> > to store information about per port capability (different port FIFO
> > sizes are already handled like this), but this would imply splittin=
g
> > some of the groups, as S5PC100 supports modem control for different
> > subset of ports than S3C64xx, while they both use the same variant
> > data.
> >=20
> > Using device tree, this could be passed as an extra property, but s=
ome
> > of the platforms using samsung serial driver can be booted without
> > device tree, so it wouldn't cover all the cases.
>=20
> So, as I understand, for now is enough to resubmit the patch with the
> UMCON register setting in s3c24xx_serial_set_termios() preserving the
> previous manual setting of the RTS pin, correct? I was thinking in
> something like this:
>=20
>      umcon =3D rd_regb(port, S3C2410_UMCON);
>      if (termios->c_cflag & CRTSCTS) {
>          umcon |=3D S3C2410_UMCOM_AFC;
>          umcon &=3D ~S3C2412_UMCON_AFC_8; // Disable RTS when RX FIFO
> contains 63 bytes } else {
>          umcon &=3D ~S3C2410_UMCOM_AFC;
>      }
>      wr_regl(port, S3C2410_UMCON, umcon);

Yes, this looks fine.

Best regards,
Tomasz

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
