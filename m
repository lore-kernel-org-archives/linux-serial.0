From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: serial programming
Date: Mon, 19 Jan 2004 10:51:59 +0100
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20040119095159.GD14285@lug-owl.de>
References: <20040119080806.72608.qmail@web86103.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C/7vEaNFiWgFcEpn"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from dvmwest.gt.owl.de ([62.52.24.140]:3974 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S264485AbUASJwB (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 19 Jan 2004 04:52:01 -0500
Content-Disposition: inline
In-Reply-To: <20040119080806.72608.qmail@web86103.mail.ukl.yahoo.com>
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org


--C/7vEaNFiWgFcEpn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-01-19 09:08:06 +0100, Felix Theodor <felix_theodor@yahoo.de>
wrote in message <20040119080806.72608.qmail@web86103.mail.ukl.yahoo.com>:
> I try to write a programm to read Datas from the
> serial port.
> But some how it doesnt read all the datas in one time.
> So I'm very confusing.=20

If the data doesn't come in one shot, then simply read as often as you
need to get it all:)

Just another hint: select() may help to make your program a bit better.

But find more comments below:)

> #include <signal.h>
> #include <sys/time.h>
>=20
> #include <stdlib.h>=20
> #include <unistd.h>=20
> #include <fcntl.h>=20
> #include <termios.h>=20
> #include <stdio.h>
> #include <time.h>
> #include <errno.h>
> #include <string.h>
>=20
> #include <assert.h>
>=20
> #include <sys/stat.h>
> #include <sys/types.h>
>=20
> #include <sys/socket.h>
> #include <netinet/in.h>
> #include <arpa/inet.h>
> #include <netdb.h>
>=20
> #include <sys/wait.h>
> #include <syslog.h>
>=20
>=20
> unsigned char buffer[256];	// Receive buffer
>=20
> int fdResult=3D0;			// COM file descriptor
>=20
> int sResultE=3D0;			// Receive result
>=20
>=20
> //
> -------------------------------------------------------------------------
> // COM Port oeffnen  =20
> //
> -------------------------------------------------------------------------
> //
> //
> int open_port ()=20
> {=20
>=20
>  struct termios options, oldtio;=20
You are not using "oldtio" anywhere...
>  =20
>  int fd;=20
>   =20
>  fd =3D open ("/dev/ttyS0",O_RDWR | O_NOCTTY |
> O_NONBLOCK );=20
>   =20
>=20
>  if (fd < 0) =20
>  {=20
>   fprintf(stderr, "Open_port: unable to open
> /dev/ttyS0\n");=20
>   exit (1); =20
>  }=20
>  else
>    fcntl (fd, F_SETFL, 0);  =20
> =20
>  tcgetattr (fd, &options); =09

May fail.

>  cfsetispeed (&options, B19200); =09
>  cfsetospeed (&options, B19200); =09

May fail - you need to check.

>  options.c_cflag |=3D CSTOPB; 	=09
> =20
>  options.c_cflag &=3D ~CSIZE;
>  options.c_cflag |=3D CS8;  =20
>=20
>  options.c_cflag &=3D ~PARENB;
> =20
>  options.c_iflag =3D IGNPAR;
>  options.c_oflag =3D 0;
>  options.c_lflag =3D 0;
> =20
>  options.c_cc[VMIN]=3D3;
>  options.c_cc[VTIME]=3D0;
> =20
>  tcflush(fd, TCIFLUSH);
>  tcsetattr (fd, TCSAFLUSH, &options);

With tcsetatts, you explain the options you *want* to see. That doesn't
neccessarily set the values (esp. if the hardware isn't capable of what
you ask for). So it actually is a good thing to do another tcgetatte()
and check if your values got accepted.

>  return fd;=20
> }
>=20
> //
> -------------------------------------------------------------------------
> //   =20
> //
> -------------------------------------------------------------------------
> //
> //
> unsigned char receive_datas (unsigned char * buffer)=20
> {=20
>   int iInput=3D0;
>  =20
>   memset(buffer,0,256);
>  =20
>   iInput=3Dread(fdResult, buffer,256);  =20

You've set VMIN=3D3 ("At least, send me 3 chars") and VTIME=3D0 ("Send me
what you have *right now*").

So you get what you ask for:) By the way, you should *always* expect
read to actually read less data then you've asked it for.

>   return iInput;=20
> }

If you need to exactly read 256 bytes, do it like this:

/*
 * < 0			on error,
 * number of bytes read	on success
 */
ssize_t
read_n_bytes (int fd, unsigned char *buf, size_t num)
{
	ssize_t	n;
	ssize_t	bytes_read =3D 0;

	while (bytes_read < num) {
		n =3D read (fd, buf + bytes_read, num - bytes_read);
		if (n < 0)
			return n;

		bytes_read +=3D n;
	}

	return bytes_read;
}

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--C/7vEaNFiWgFcEpn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAC6i/Hb1edYOZ4bsRAu+GAJ4+Migol/MDoyah23SkPoL3aN6ssQCfRDdR
OXU9fbkKdrzW5LTTkwVBdDw=
=MU8/
-----END PGP SIGNATURE-----

--C/7vEaNFiWgFcEpn--
