From: Tilman Schmidt <tilman@imap.cc>
Subject: Re: [PATCH 68/68] TTY: isdn/gigaset, use tty_port
Date: Mon, 05 Mar 2012 18:08:00 +0100
Message-ID: <4F54F2F0.8090909@imap.cc>
References: <1330955575-26641-1-git-send-email-jslaby@suse.cz> <1330955575-26641-69-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1330955575-26641-69-git-send-email-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: gregkh@linuxfoundation.org, alan@linux.intel.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, jirislaby@gmail.com, Hansjoerg Lipp <hjlipp@web.de>, gigaset307x-common@lists.sourceforge.net
List-Id: linux-serial@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am 05.03.2012 14:52, schrieb Jiri Slaby:
> Let us port the code to use tty_port. We now use open_count and tty
> from there. This allows us also to use tty_port_tty_set with tty
> refcounting instead of hand-written locking and logic.
>=20
> Note that tty and open_count are no longer protected by cs->lock. It =
is
> protected by tty_port->lock. But since all the places where they were
> used are now switched to the helpers, we are fine.
>=20
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Hansjoerg Lipp <hjlipp@web.de>
> Cc: Tilman Schmidt <tilman@imap.cc>
> Cc: gigaset307x-common@lists.sourceforge.net

Very nice. Thanks!

Acked-by: Tilman Schmidt <tilman@imap.cc>

- --=20
Tilman Schmidt                    E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Unge=F6ffnet mindestens haltbar bis: (siehe R=FCckseite)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAk9U8vAACgkQQ3+did9BuFv8RACeLMRSUGhjotg0il1LtWqtfrzR
sakAn0LJr66dYyUXteH44p5+KFQuS5v9
=3DIs+Q
-----END PGP SIGNATURE-----
