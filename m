From: Andy Parkins <andyparkins@gmail.com>
Subject: tcdrain / TCSBRK / wait_until_sent delay
Date: Thu, 5 May 2005 16:50:38 +0100
Message-ID: <200505051650.38471.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2399377.NaaO8VjXy4";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from host3.360visontechnology.com ([195.102.65.187]:13263 "EHLO
	369run02s.360vision.com") by vger.kernel.org with ESMTP
	id S262139AbVEEPuo (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 5 May 2005 11:50:44 -0400
Received: from dvr ([127.0.0.1])
	by dvr with esmtp (Exim 3.36 #1 (Debian))
	id 1DTicY-0008Ca-00
	for <linux-serial@vger.kernel.org>; Thu, 05 May 2005 16:50:38 +0100
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

--nextPart2399377.NaaO8VjXy4
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,

I wonder if anyone can help me with this as a problem?  I'm trying to send=
=20
commands to a device along a two wire RS485 connection.  I'm using an RS232=
=20
to RS485 converter that changes the buffer direction based on RTS.  With th=
at=20
in mind I therefore do things like (error detection left out for brevity)

bit =3D TIOCM_RTS;
ioctl( fd, TIOCMBIS, &bit );
write( fd, "\xaa", 1 );
tcdrain();
ioctl( fd, TIOCMBIC, &bit );

This triggers the other end to send a response that I read back with=20
select/read.  However, what I am reading has the front few bytes corrupted.=
 =20
Sticking a scope on the TXD and RTS lines of the serial port shows that

      ______________________________________
RTS __|                                    |_____
       _____ ___ ___ ___
TXD ___|   |_| |_| |_| |_________________________
        S 1 0 1 0 1 0 1 0 s
                           <-----delay---->

There is a small delay between RTS going high and the data starting - no=20
problem there, however, when the transmission finishes there is a 2 byte=20
delay before RTS goes low.  The device I'm talking to has (apparently) a=20
response time of 200us; I'm seeing a delay before restoration of RTS of 2ms=
=2E=20
write() returns immediately - the delay is coming from tcdrain() - but I=20
cannot see from where.

With a bit of digging I've found that tcdrain() simply calls ioctl(TCSBRK,1=
)=20
which I guess ends up in

linux/driver/char/tty_io.c:         tty_ioctl() which calls
linux/driver/char/tty_ioctl.c:      tty_wait_until_sent() which calls
linux/driver/serial/serial_core.c:  uart_wait_until_sent()

uart_wait_until_sent() then sits and waits for /at most/ two characters wor=
th=20
of timeout for

linux/driver/serial/8250.c: serial8250_tx_empty()

to tell it that it can return.  It appears (in my very newbie eyes) that=20
uart_wait_until_sent() checks for tx_empty() every 1/5th of a byte, I would=
=20
think that would be more than enough.  It takes negligible time for=20
serial8250_tx_empty() to call serial_in() to read the UART status register.=
 =20
I imagine that the msleep_interruptible() call is well tested in Linux.

My question then is where is the time going?  It seems suspicious that=20
uart_wait_until_sent() has an overall timeout of two character times -=20
exactly the excess I'm seeing.  Am I right to be suspicious?  Have I=20
understood any of this?  Is it unreasonable to expect Linux to do a 200us=20
turnaround?



Andy
=2D-=20
Dr Andrew Parkins, M Eng (hons), AMIEE


--nextPart2399377.NaaO8VjXy4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCekDOwQJ9gE9xL20RAspvAKCPBQYSQyO4wU8aYlm6R4fq10JwWwCfbo+R
EBMhiW3Fr067KE1yh7UymTc=
=tpEm
-----END PGP SIGNATURE-----

--nextPart2399377.NaaO8VjXy4--
