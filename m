From: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH V3 1/4] ARM: bcm2835: follow dt uart node-naming convention
Date: Tue, 02 Feb 2016 17:34:19 -0800
Message-ID: <871t8ur2zo.fsf@eliezer.anholt.net>
References: <1453032932-2512-1-git-send-email-kernel@martin.sperl.org> <1453032932-2512-2-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1453032932-2512-2-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

--=-=-=
Content-Type: text/plain

kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org writes:

> From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
>
> This patch fixes the naming of the device tree node: uart@7e201000
> to conform to the standard of: serial@7e201000
>
> Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

Did the rebase and merged this one to bcm2835-dt-next.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWsVkbAAoJELXWKTbR/J7oH4EP/RlVKOgHv6rbi2HKITHtatuP
kHNuBZVY9NcnS9/TufeKaK6zg04Jplynl0mers5VSPQd5toDto8zGFweJpmtZTRD
wtB7dLWPrnUSS72Vzq34hgegu96BY+6uDzMz4JzgxGAB4NyZ3/i8ovJZGBMgHyCc
Jw+OVJXeZisbnRewpgwGHlHzflq93fYFQt46o7LK92k26TmjKOet7GGMwWptdCgg
5TlpB5VCiwPya0DFQaF6y9kjqKlYViVU8Dktha1oriinvIiJlLPHK+F6iWQmom+g
db2u76zgI/lNSxCyUir+YRcoaSP4+/fd1d4xlnzMFyCw68RcbPj1z/SUTj4dfMWI
4ppan4sbLeeIK1t91gW4bhqMAzLB5aY0QH5CF/wkIjdSZPbrrKiwpeEOCBIbFjtU
IlJAcAZYweEJCy6VYFTV1HcJNg57IQOb7qgAokvs6aq/7Sliy3aqFyXmMhIfuPNF
CIAv5qxvE57NiRy91Iku9tVLvuzDYpvABjugfg/P460Vyq/51ODQXVlb7LmpcM8O
RH5RNxA1N1HpaptIxxRMyY/1fbjYArtlcuEqTthwGxaI7ebJtTb6b7QE7BrKk6Rl
p+HA0YroyI20KFq61vnGdD9Q8dkiKddsBfyjVubgZDpgkd5j43q7VTzKa6KJBiJa
a+lvkQzAB0VfDjSo+TUl
=cWt5
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
