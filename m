From: Sven Brauch <mail-ITmcY+a7/CDoK6nBLMlh1Q@public.gmane.org>
Subject: Re: implement put_char() in cdc-acm
Date: Tue, 3 Nov 2015 11:13:15 +0100
Message-ID: <563888BB.2080601@svenbrauch.de>
References: <1445958479.2043.6.camel@suse.com>
 <562F9C08.6050105@svenbrauch.de> <1446030280.15140.10.camel@suse.com>
 <5630BE5E.6040204@hurleysoftware.com> <1446035622.15140.17.camel@suse.com>
 <563667D9.9080401@svenbrauch.de> <1446463972.25345.24.camel@suse.com>
 <5637C731.20409@svenbrauch.de> <1446541094.27681.2.camel@suse.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ulIrq8wQWKiHQ15SaHCBcBfasS6sgj37V"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1446541094.27681.2.camel-IBi9RG/b67k@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oneukum-IBi9RG/b67k@public.gmane.org>
Cc: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ulIrq8wQWKiHQ15SaHCBcBfasS6sgj37V
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/11/15 09:58, Oliver Neukum wrote:
> Basically
> your device is special by doing implied flow control
> when the host stops requesting data.
Hmm, ok, interesting. But isn't that what always happens for USB bulk
transfers, which is always the transport layer for the driver in question=
?

Regards,
Sven


--ulIrq8wQWKiHQ15SaHCBcBfasS6sgj37V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWOIi7AAoJEGjKjjjEuz9LGNAP/AmLgLYO9uUG2zEHn11I9Abw
+H2BWmuHKt7XQf6YmvYOdnXK5miPULlCCBSWOeXgRfvl08wf4jbdJx2wZh5yxTPt
lfElg4ajJlI6uY7S1rJ3OLoqP3vuCVYyuHmC2pD7GszgYN2h67YKwf3z10YJiNSD
N2HL9M8jtHkjpmhgzWFA3ObK+oQZegIgGizNxLH2YenojQAD3SxlgnCGSV28MCfK
atXgPQN4PZ7QNfPmOKVllNjD15WoUd+zZP2viHPmkhpRekeVnZBCALPcUGF+Xwso
DBIGGQvgCLPzckLRHYxiJjpVnB8GET5iC60qGJW8RUxj5GF4uTysRB+/QSl0WREW
Sj10avtPBZU1HA8CTNZIeJNXB2h0aOXToKgeiLlCpHtS/cv8K4JIbhWL3oJcQEeg
0zmaVLNRJf2mAqJ9+Ba3jAqiLmayGjsUJbM+g+Y6lj83w3d0Ssso6jzdATjfJ9Ui
yccAKQwuOq+Yl7MvGv3qvNejPSC9ZjzN9NJrUaogoci2nXmjFG7DxSeStCEAVHaV
azS/hC7jsACeCe5ygTeYTUw7yHo4dItLsIU895tVtUws49Q47/b+5lIUiU1eorcg
9wg4+3B3Oqw/AeFIGGroJnRj+NGN8OnwMAJHQoQWE13xmfP6fGhadtOHJkQrUFoq
G6iqF0qPaKbzg59TVnkh
=w5zP
-----END PGP SIGNATURE-----

--ulIrq8wQWKiHQ15SaHCBcBfasS6sgj37V--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
