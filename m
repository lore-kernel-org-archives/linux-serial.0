From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
Subject: Re: [PPC/MPC5200B] strange data loss on uart reception
Date: Mon, 01 Nov 2010 15:41:53 +0100
Message-ID: <1288622520.1807.0@antares>
References: <20101101031003.GA2903@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=PGP-SHA1; boundary="=-65euN3sA5iQfUgycFaY+"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp6.netcologne.de ([194.8.194.26]:47501 "EHLO
	smtp6.netcologne.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755474Ab0KAOmE (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 1 Nov 2010 10:42:04 -0400
In-Reply-To: <20101101031003.GA2903@kroah.com> (from greg@kroah.com on Mon
	Nov  1 04:10:03 2010)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <greg@kroah.com>, linux-serial@vger.kernel.org

--=-65euN3sA5iQfUgycFaY+
Content-Type: text/plain; charset=us-ascii; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 01.11.10 04:10 schrieb(en) Greg KH:
> On Sun, Oct 31, 2010 at 06:27:00PM +0100, Albrecht Dre? wrote:
>> Am I simply too dumb to use the uart correctly, or is there some issue i=
n the kernel causing this effect?  I noticed that the function mpc52xx_uart=
_int_rx_chars() does not check the return value of tty_insert_flip_char(). =
 If the system runs out of space (actually, the maximum buffer size used sh=
ould be limited, in particular on embedded systems!), might this go undetec=
ted?  This might explain the bigger "chunks", as the '5200's uart has a rat=
her big fifo (512 bytes).
>=20
> That might help, have you tried changing this and seeing if it fixes anyt=
hing?

Hmmm, apparently it's not possible to disable the fifo completely in this c=
hip if I interpret the manual correctly.  I played with the fifo alarm leve=
ls (the number of space left in the fifo to immediately trigger an irq), th=
ough, and it doesn't change anything.

> Also, are you sure your userspace application is checking the return valu=
e of write() to verify that it really wrote everything it thought it did?

The UART is connected to a ftdi usb/rs232 converter, and I write data using=
 USB functions into the ftdi, which in turn sends them into the 5200's uart=
 at 3 MBaud (yes, the wires are *very* short, and the uart doesn't see any =
framing or parity errors... ;-).  And I am pretty sure the uart's rx regist=
er sees the correct number of bytes, as the TIOCGICOUNT ioctl reports exact=
ly the number of bytes I sent.  The rx counter is updated in the isr mpc52x=
x_uart_int_rx_chars() which reads data from the fifo, btw.

However, in this function I added a printk when tty_insert_flip_char() retu=
rns 0, and actually this happens when more than 64kb are sent quickly!  Rea=
ding through the code, the following seems to happen:
- tty_insert_flip_char() detects that the struct tty_buffer is full and cal=
ls tty_insert_flip_string_flags()
- tty_insert_flip_string_flags() calls tty_buffer_request_room()
- tty_buffer_request_room() calls tty_buffer_find()
- tty_buffer_find() calls tty_buffer_alloc() if no free buffer is found
- tty_buffer_alloc() contains at the very beginning

         if (tty->buf.memory_used + size > 65536)
                 return NULL;

I didn't add more debug output here, but for me it looks as if the kernel s=
imply rejects buffering more than 64kByte.  Could this be the correct inter=
pretation of the path outlined above?  If this is the case, then IMHO there=
 is a serious problem, as data can be lost completely undetected, at least =
in any uart driver which ignores the return value of tty_insert_flip_char()=
!

Thanks,
Albrecht.

--=-65euN3sA5iQfUgycFaY+
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iD8DBQBMztG4n/9unNAn/9ERArQFAJ0SDDtaCUBJuw4Z3aeV/TnDEpONQACfUxGp
HQrlufc+jpbeGEEiEhJuQyY=
=7wIV
-----END PGP SIGNATURE-----

--=-65euN3sA5iQfUgycFaY+--
