From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
Subject: [PPC/MPC5200B] strange data loss on uart reception
Date: Sun, 31 Oct 2010 18:27:00 +0100
Message-ID: <1288546021.1866.1@antares>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=PGP-SHA1; boundary="=-c07L/9a8WkQRRJlYqMrW"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp5.netcologne.de ([194.8.194.25]:56904 "EHLO
	smtp5.netcologne.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756245Ab0JaRcb (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 31 Oct 2010 13:32:31 -0400
Received: from antares (xdsl-78-34-214-38.netcologne.de [78.34.214.38])
	by smtp5.netcologne.de (Postfix) with ESMTP id 5BB3731C2F6
	for <linux-serial@vger.kernel.org>; Sun, 31 Oct 2010 18:27:02 +0100 (CET)
Received: from antares (antares [127.0.0.1])
	by antares (Postfix) with ESMTPS id 1B87EBA03C
	for <linux-serial@vger.kernel.org>; Sun, 31 Oct 2010 18:27:02 +0100 (CET)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

--=-c07L/9a8WkQRRJlYqMrW
Content-Type: text/plain; charset=us-ascii; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[re-posted from the linuxppc-dev list...]

Hi all,

I'm not sure if this is the right list, so please excuse me if I'm totally =
wrong here, or if my question is really dumb...

My platform is a MPC5200B (roughly Icecube) based board with kernel 2.6.32.=
  From a PC I try to send data through the MPC5200B's serial port, using th=
e standard mpc52xx_uart driver.  The reading process is rather slow in proc=
essing the incoming data.  Thus, the uart is configured to use rts/cts  han=
dshaking.  The port is opened in (O_EXCL | O_RDWR) mode.

Sending large data blocks to the 5200, I noticed that complete chunks of da=
ta are missing in the output read in user space.  This is apparently *not* =
a problem on the uart layer; the result of the TIOCGICOUNT ioctl does not r=
eport any errors from the uart, and the serial_icounter_struct.rx field con=
tains *exactly* the correct number of data bytes I transmitted.  The data l=
oss seems to occur only if the block is larger than 64 kByte, but I didn't =
find a scheme of the actually missing number of bytes.  However, it's alway=
s a larger chunk of several hundred bytes to kBytes.

Am I simply too dumb to use the uart correctly, or is there some issue in t=
he kernel causing this effect?  I noticed that the function mpc52xx_uart_in=
t_rx_chars() does not check the return value of tty_insert_flip_char().  If=
 the system runs out of space (actually, the maximum buffer size used shoul=
d be limited, in particular on embedded systems!), might this go undetected=
?  This might explain the bigger "chunks", as the '5200's uart has a rather=
 big fifo (512 bytes).

Any insight would be really appreciated!

Thanks in advance,
Albrecht.

--=-c07L/9a8WkQRRJlYqMrW
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iD8DBQBMzabln/9unNAn/9ERArIMAJ423RdZdSaTGkIc0iUVHTg1yZEpswCgkx8w
cB3FUq4U/wo6SM8xCu7MoH0=
=rBuL
-----END PGP SIGNATURE-----

--=-c07L/9a8WkQRRJlYqMrW--
