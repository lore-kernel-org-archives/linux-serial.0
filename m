From: "Francisco M. Marzoa Alonso" <fmmarzoa@softronica.org>
Subject: Strange sniffer behaviour
Date: Mon, 23 Aug 2004 13:31:29 +0200
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <200408231331.29869.fmmarzoa@softronica.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from 55.Red-213-4-20.pooles.rima-tde.net ([213.4.20.55]:3277 "EHLO
	softronica.org") by vger.kernel.org with ESMTP id S261405AbUHWLXO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 23 Aug 2004 07:23:14 -0400
Received: from 10.10.0.21 (unknown [10.10.0.21])
	by softronica.org (Postfix) with ESMTP id 1A9A37E6B
	for <linux-serial@vger.kernel.org>; Mon, 23 Aug 2004 13:15:41 +0200 (CEST)
Content-Disposition: inline
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

I've a program under Windows that comunicates with a device connected t=
o the=20
serial port in order to update its firmware, and I'm trying to migrate =
it to=20
windows but I've found several trobules. I've solved some of them with =
the=20
help of Gerald Eming (thx. a lot), but I'm still having problems.

To figure out the root of those problems, I've downloaded "slsnif", a s=
niffer=20
to monitor data through serial port, but I'm having problems even with =
this:

When I run "slsniff" my program behaviour is quite different that if th=
e=20
"slsniff" is not running. If the sniffer is running my program gives "I=
llegal=20
seek" errors since second try to read the port, while this does NOT occ=
ur if=20
the "slsniff" is not running. =BFAny ideas?

=46ollowing I paste my latest CommReadChar and CommWriteChar functions,=
 because=20
I think the trouble could be in them, I've not very clear if I'm using =
the=20
select function in the proper way:

int CommReadChar (HANDLE HND, int Wait, unsigned char* Data) {
	struct timeval TOut;
	fd_set readfs;

	FD_ZERO(&readfs);
	FD_SET (HND, &readfs);

	TOut.tv_sec =3D Wait / 1000;
	TOut.tv_usec =3D Wait % 1000;

	if ( select ( FD_SETSIZE, &readfs, NULL, NULL, &TOut ) ) {
		return ( read (HND, &Data, 1) );
	} else {
		perror ("CommReadChar TIMEOUT while waiting for reading");
		return 0;
	}
}

int CommWriteChar (HANDLE HND, const unsigned char Data) {
        int bcount;
	char aux;

	//----
	struct timeval TOut;
	fd_set writefs;

	FD_ZERO(&writefs);
	FD_SET (HND, &writefs);

	TOut.tv_sec =3D 1000;
	TOut.tv_usec =3D 0;
	//----

	aux =3D Data;

	bcount =3D write ( HND, &aux, 1 );
	if ( bcount !=3D 1 ) {
		perror ("Cannot write char to serial port");
		return 0;
	}

	//---
	//tcflush ( HND, TCOFLUSH );
	if ( ! select ( FD_SETSIZE, NULL, &writefs, NULL, &TOut ) ) {
		perror ( "Timeout waiting on CommWriteChar");
		return 0;
	}
	//---


	return ( bcount );
}


I've also tested changing FD_SETSIZE by (HND+1) with identical results.=
=20
Please, note that my goal now is to have the sniffer working properly w=
ithout=20
interfere with my application, because I think if I solve this problem =
I'll=20
be easily able to solve the main trouble. I think it probably has somet=
hing=20
to see with the file descriptor for /dev/ttyS0, that both slsniff and m=
y=20
program uses at same time, but cannot figure out what's exactly the roo=
t of=20
the problem.

Thx. and BTW excuse my poor english.


--=20
=46rancisco M. Marzoa Alonso
Responsable de Software - Softr=F3nica S.A.
http://www.softronica.org/
C/Herrer=EDas, 14 - 28760 Tres Cantos (Madrid)
tfno. +34 918 038 600  fax. +34 918 032 297


-
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
