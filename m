From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 1/2] usb: gadget dbgp: Fix endpoint config after USB
 disconnect
Date: Fri, 7 Nov 2014 12:04:53 -0600
Message-ID: <20141107180453.GM15036@saruman>
References: <1414346490-19307-1-git-send-email-kyosti.malkki@gmail.com>
 <1415027885-2181-1-git-send-email-kyosti.malkki@gmail.com>
 <1415027885-2181-2-git-send-email-kyosti.malkki@gmail.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+cfQkLQGU7KOA/8T"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1415027885-2181-2-git-send-email-kyosti.malkki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?iso-8859-1?Q?Ky=F6sti_M=E4lkki?= <kyosti.malkki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
List-Id: linux-serial@vger.kernel.org

--+cfQkLQGU7KOA/8T
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 03, 2014 at 05:18:04PM +0200, Ky=F6sti M=E4lkki wrote:
> SET_FEATURE request with DEBUG_MODE only worked the first time after modu=
le
> initialisation. Per the USB 2.0 debug device specification, said request
> is to be treated as if it were a SET_CONFIGURATION request, i.e. endpoint
> must be re-configured.
>=20
> As configure_endpoints() may now get called multiple times, move it outsi=
de
> __init and move serial_alloc_tty() call into __init.
>=20
> Code has assumption that endpoint mapping remains unchanged with consecut=
ive
> calls of configure_endpoints().
>=20
> Signed-off-by: Ky=F6sti M=E4lkki <kyosti.malkki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---

if there are no comments here, I'll add this one to my testing/next.

--=20
balbi

--+cfQkLQGU7KOA/8T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUXQnFAAoJEIaOsuA1yqRES6UP/1v/mkURgEZBDe39Z1vMfU8t
74b/0XJdO/+Juzp8QHAkPCQnQLpQvqbeRnXHOcs0AnYdDmUL7RCPLKjQsvOVayMa
2bnaVhuWWQmlL05BjpJQP/7Ve0/wz+fCqI8aOqMLczRwNoP/l8S9m9ctWfhRxeuW
4qEwYsHhHc0bXcFUTXX210zgRa9beg4brMAY8u7CHotzUH3Me2catJBhq7E1fuPs
pXt/L4/yUjbsTPts5F/1LojSwjhnw1kIsNlmGLBeH+Kc98y1WCRA48AsBfjBKtrg
gTpPQilHt8CoD45RZMb8/EJB9TakQ8W2U4vGO2CYLpoUkzcDhncBxFNfa8kzXObW
Hvv5VCF1+3b6Wo5CfATY+LtwpGccfkjByzBN+b0cHmusigsORw+2470VcbpMLFnH
7QJQN42jb0R1/5KkcU8Lx6gua3edJmxhvp0v0WTsGMSTMnQn+POy7Y5hvBS7bZkg
4l1Mogqp15pudvNahrAGwbPu3KD9LvtldApCAvjYqYkXKuoDp0EXDZp+Yg+KmGIM
849c3Ft1aM9xM5p+xgedasSW2OugXRuSDYVFVdMsUvtshabCsGVGDtuncBXArMLT
b3C3bmAOaJr0MwRN7tg+ZejIrHxDU3CQGrN6RdW6WFPcgTQOALvnQ2NDrrSNlczW
EpmPBcFJPBNMX+M2po7I
=Tgzu
-----END PGP SIGNATURE-----

--+cfQkLQGU7KOA/8T--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
