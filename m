From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: Tree for Jan 23 (pch_uart.c)
Date: Thu, 24 Jan 2013 15:15:37 +1100
Message-ID: <20130124151537.12c139821173713bf858fa40@canb.auug.org.au>
References: <20130123174336.47c0113740a14da7f6a92187@canb.auug.org.au>
	<51007226.1040604@infradead.org>
	<20130124130616.ee95e032326b1afee6716419@canb.auug.org.au>
	<20130124023054.GA21851@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Thu__24_Jan_2013_15_15_37_+1100_bSRIaIXoUN5RA3YZ"
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20130124023054.GA21851@localhost>
Sender: linux-next-owner@vger.kernel.org
To: Liang Li <liang.li@windriver.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Greg KH <greg@kroah.com>
List-Id: linux-serial@vger.kernel.org

--Signature=_Thu__24_Jan_2013_15_15_37_+1100_bSRIaIXoUN5RA3YZ
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 24 Jan 2013 10:30:54 +0800 Liang Li <liang.li@windriver.com> wrote:
>
> Should I add a fix for the compile error .. or do squash then send out
> refreshed patch ?

You need to send a fix patch to Greg based on his tty tree
(git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git).

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Thu__24_Jan_2013_15_15_37_+1100_bSRIaIXoUN5RA3YZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJRALVpAAoJEECxmPOUX5FEWv4P+wVISo3NRpYkCycQ/CPf15N/
kop2HPPBXEtWLXtXKgJU44QhTLdYMNtW2ZIU5DLW9ep/k2zPW2N93TfNAk7rjnTx
oi1tEzGzNskHaTJnfomKuqnklJ6yljmeIKvqAMOP8Osh6FIsIEXl1tbGr0wh1Tqt
l3+Xu9CnymabhxND6AnNmoiYHoh5S7x6reAK3YWOhZ8qaa5wFknPsxrv2+YrnFYQ
dreJsjVMUt+y6E5QPu8PuvI7fNZ/HoVRJYl8043qXk5CmJM9vBUR+jvH1+cPg8FE
PMMjhtLpL2M8kgb3mgcToavJRTHUHclKg5O4L30iu97SZntjTCkKy5ZL9g+HWACs
6hdUhM0aKBDs6Jf9oc1UpFn0BvIXzRPH3vZw763B3if5sUBWFi3qxfFi11S6HjvC
Z7gWLXVUONRI9CylUCQnHnQ42TYBP8JmciFc2orljaYcw06UxRL3qOIO4CeG/vVF
9gIDct6E5ckRlp6c1tDGZvS5QQUwSVoGfXQ10RRoTa4UnNGiKq3aGE87qn0+TBpz
VuQ4dJhvbK5NBcSRqSv8TiO1PjDS/cQA0ZqburU2NQymCi0oOInnyCSrTlKkb7bw
enDBI+izCFWdDsndZs6RYpj+s8PIEyfts111YqFrq6gkL1jBFgYGzkPpc8nGoI7y
FtsVejpxNwAC0vyM/KUC
=kAaW
-----END PGP SIGNATURE-----

--Signature=_Thu__24_Jan_2013_15_15_37_+1100_bSRIaIXoUN5RA3YZ--
