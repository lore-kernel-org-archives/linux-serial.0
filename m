From: Thomas Schwinge <thomas@codesourcery.com>
Subject: Re: [PATCH 3/7] serial: sh-sci: restore big-endian operation.
Date: Fri, 09 Mar 2012 21:23:46 +0100
Message-ID: <87lin9mskt.fsf@schwinge.name>
References: <1331311133-26937-1-git-send-email-thomas@codesourcery.com> <1331311133-26937-3-git-send-email-thomas@codesourcery.com> <20120309171007.GA25965@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:33187 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030512Ab2CIUYD (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 9 Mar 2012 15:24:03 -0500
In-Reply-To: <20120309171007.GA25965@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, linux-serial@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Greg!

First -- as you probably have guessed already -- I'm not (not yet?) :-)
too familiar with the Linux kernel patch submission process.  I have
spent quite some time reading the included documentation, but apparently
missed some details...  :-)


On Fri, 9 Mar 2012 09:10:07 -0800, Greg KH <gregkh@linuxfoundation.org> wro=
te:
> On Fri, Mar 09, 2012 at 05:38:49PM +0100, Thomas Schwinge wrote:
> > As of 37b7a97884ba64bf7d403351ac2a9476ab4f1bba we have to use the
> > endianess-agnostic I/O accessor functions.
>=20
> Please always put a human readable description of what the git id is, so
> that we have a chance to understand what is going on.

Sorry.  ``sh: machvec IO death.'' -- well, the essential part what I'm
fixing here is that before this commit readw (and friends, such as
ioread16) didn't do any endianess modification of the data, but directly
invoked __raw_readw, whereas after 37b7a978 they do such modification by
means of filtering through le16_to_cpu (in the readw/ioread16 case).
This is where things break for big endian (but not little endian, where
this is a no-op).


> Are these patches supposed to be going through the sh tree, or the
> serial tree to Linus?

I'm assuming that Paul Mundt will handle the whole lot in an SH tree.

Paul, by the way, if that's more convenient I can also publish my Git
tree.


> And watch your To: line, it seemed to be munged :(

Yes.  By means of scripts/get_maintainer.pl (and some manual adjustments)
I created the Cc: lists that are part of my commits' log messages.  Then,
I just had git send-email send that out, without explicitly specifying a
primary recipient (To: line).  I assume I should have put Paul there?

On this patch, the linux-serial was Cced (as suggested by
scripts/get_maintainer.pl), as it touches a TTY/serial driver, and I
wanted to make sure to give you an opportunity to review that the patch
doesn't introduce any breakage on non-SH architectures, for example.
(Despite its indicative name, sh-sci also seems to be used on some ARM
boards.)


> confused,

Sorry; will hopefully improve.  :-)


Gr=C3=BC=C3=9Fe,
 Thomas

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJPWmbSAAoJENuKOtuXzphJR5EIAKslGo7+zlQGhPiZ3sOGl+3g
8nrO/kbTl8SrZYV2fjFjVWkRRbWrGT/WA/d1LRQ4wZVNDFgbqH8QfH0yovzZwHVf
Os3hsr0LLZYQYZs6lqmGy6HjNy8YNXKok3/zAoOWE90HyCJMHeVo5LIwYtpzwYGb
Mnu87HDb82TCf7kpF66+uQ/lbcvl6/41HbudTnLQOAhgT/52XKBC0irdxxopkdmB
8h+fzfVxaJ+yaTy2YZai/Pf9jCJkazvcXQhXOMhsYjr5ETBHnSkUVLOBPPVtc3zn
Vy17x5qBPIMPUImd6H6CzWnznoeQbE3GWDlcMFpQGg4AkHe99q8rplguc9UrZsc=
=gifc
-----END PGP SIGNATURE-----
--=-=-=--
