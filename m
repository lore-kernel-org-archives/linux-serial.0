From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: Serial port read working but not write.
Date: Fri, 23 Jul 2004 11:40:54 +0200
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20040723094054.GT18676@lug-owl.de>
References: <20040722164803.5219.qmail@web8206.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pbi2MkfjSbXbI4MN"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from dvmwest.gt.owl.de ([62.52.24.140]:29850 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S266878AbUGWJk4 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 23 Jul 2004 05:40:56 -0400
Content-Disposition: inline
In-Reply-To: <20040722164803.5219.qmail@web8206.mail.in.yahoo.com>
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org


--Pbi2MkfjSbXbI4MN
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-07-22 17:48:03 +0100, suresh shenoy <msureshshenoy@yahoo.co.in>
wrote in message <20040722164803.5219.qmail@web8206.mail.in.yahoo.com>:
>    I am currently using redhat linux 9.0. I am working
> with a hardware which senses some data and sends back
> to the PC through serial port. It also can move a dc
> motor using the same hardware. I am using POSIX serial

There are several possibilities that come to mind:

	- You're sending with wrong parity and ignore parity on read,
	  but your device doesn't.
	- Your cable is broken.
	- You're sending the wrong command :-)
	- Input and output speed differ
	- Wrong handshake settings in place, with a cable that make your
	  computer think the device won't accept data right now.

It would help a lot if you had a serial sniffer. From personal
experience, the last point (handshake+cable) has good chances. For a
test, you may want to poll how many bytes are in your output-buffer:

{
	int ret;
	int bytes;

	ret =3D ioctl (fd, TIOCOUTQ, &bytes);
	if (ret !=3D 0)
		fprintf (stderr, "Problem querying outqueue\n");
	else
		printf ("Outqueue: %d bytes\n", bytes);
}

If the number rises (and never goes back to zero), then it's likely a
handshake and/or cabling problem. If it goes down to zero at some time
(up to seconds, depends on your serial speed:)  then it's more likely a
parity error or you're sending wrong commands.  However, it *could* also
be a handshake problem (you get signaled that you're allowed to send,
but the device cannot handle more data and throws it away).

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Irak! =
  O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--Pbi2MkfjSbXbI4MN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBAN0mHb1edYOZ4bsRAkAbAJ0X6PLes8vkfqYxZRCcpC68M3HdawCgiJKQ
KQBrho5eooIRs/k95dV2GdA=
=V5do
-----END PGP SIGNATURE-----

--Pbi2MkfjSbXbI4MN--
