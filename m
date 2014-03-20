From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: hci_ldsic nested locking problem
Date: Thu, 20 Mar 2014 12:16:22 -0500
Message-ID: <20140320171621.GA2827@saruman.home>
References: <20140320163435.GH32692@saruman.home>
 <1395333736.22077.32.camel@acox1-desk.ger.corp.intel.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1395333736.22077.32.camel-wU3TRTJX3O1FGiH78xh5akvbDziVy8sZEvhb3Hwu1Ks@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Muralidharan Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2014 at 04:42:16PM +0000, Alan Cox wrote:
> On Thu, 2014-03-20 at 11:34 -0500, Felipe Balbi wrote:
> > Hi,
> >=20
> > when 8250 driver calls uart_write_wakeup(), the tty port lock is already
> > taken. hci_ldisc.c's implementation of ->write_wakeup() calls
> > tty->ops->write() to actually send the characters, but that call will
> > try to acquire the same port lock again.
> >=20
> > Looking at other line disciplines that looks like a bug in hci_ldisc.c.
> > Am I correct to assume that ->write_wakeup() is supposed to *just*
> > wakeup the bottom half so we handle ->write() in another context ?
> >=20
> > Is it legal to call tty->ops->write() from within ->write_wakeup() ?
>=20
> It isn't because you might send all the bytes and go
>=20
> 	write
> 		write_wakeup
> 			write
> 				write wakeup
> 					...
>=20
> and recurse

cool, so there really is a bug in hci_ldisc. Marcel, any tips on how do
you want this to be sorted out ?

--=20
balbi

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTKyJlAAoJEIaOsuA1yqRE2FwP/AmUoBnEl6k60x4X1R19LYYP
Hcfqh96Or4Z0qA8+AxTWwK6gyOgTvU5l9VhR549x3lB3G5KIf/k2VffkjARtn94v
gBahV14mpjA2AQRtidQwqAtqivf0UN9dcLC6vfVjkqfHOqma6nfjfP82P5KFI7aY
G0bsnb62ojKTIDYtNmJor3mAKGzzL9LfZX3jShjFldoU01UTr8e0ONL2fRhyJ0l0
1+5euw0GaGGnxAbZvVgulFZh7CECpmkDGspzUN9cjY45spwDOergGVH2lXPS7Hae
a+rEwUI3F4fkARGST+cuKc4/VgG91E0IgyLW10paNwtdW8kgzcIjYqRzFepb/PMm
cRbYj2XIRF2mekpvo2I8zm+6ZtWdS74PiBwLR14OvQJ1/YcFIN6cwlVjafZyyHuK
7P+YCSzQLGKV9Ra+lW0UCe9BYUh1xMQztGFu7mRRSMIR6KTmF36fAzxsn6/eZlmG
YGJaz90RbSutEZ9dhf1kclMvURrXkSZUFeWIEfLV6dpgTTZ35OrIyslFpvoRWEs4
IkjKwQowwf1WJ7ow1k4KbAYz+wF9froG/F128y+408ks9kWrD33uOIaBewTM7Da8
k5+vr2CWysQausGHZKAC+L9lmIo2DfmOdy8C+DzkCLgOH5WpxqXb5Vx5bw5sRO6N
2PjQiY5IBPKzhcVpIobJ
=+Ocl
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
