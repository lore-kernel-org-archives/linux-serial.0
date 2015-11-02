From: Sven Brauch <mail-ITmcY+a7/CDoK6nBLMlh1Q@public.gmane.org>
Subject: Re: implement put_char() in cdc-acm
Date: Mon, 2 Nov 2015 21:27:29 +0100
Message-ID: <5637C731.20409@svenbrauch.de>
References: <1445958479.2043.6.camel@suse.com>
 <562F9C08.6050105@svenbrauch.de> <1446030280.15140.10.camel@suse.com>
 <5630BE5E.6040204@hurleysoftware.com> <1446035622.15140.17.camel@suse.com>
 <563667D9.9080401@svenbrauch.de> <1446463972.25345.24.camel@suse.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="vTIkERICRWQXEEW3JO52keIRuul5br1u7"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1446463972.25345.24.camel-IBi9RG/b67k@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oneukum-IBi9RG/b67k@public.gmane.org>
Cc: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vTIkERICRWQXEEW3JO52keIRuul5br1u7
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/11/15 12:32, Oliver Neukum wrote:
> given this test I will submit the patch.
Mind you, I don't know if the improvement is due to your patch or other
things. I didn't test the new kernel without your patch; should I?

> Sven, can you ramp up the buffers in the manner Peter suggested
> and retest? It looks like the throttling code isn't perfect yet,
> but a larger buffer may make its performance good enough.
I'll try as soon as possible, but I'm sceptical. That still doesn't
guarantee that no data is lost, which feels bad to me.

Thanks and best regards,
Sven


--vTIkERICRWQXEEW3JO52keIRuul5br1u7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWN8c0AAoJEGjKjjjEuz9L+F4P/jKYqnbhptzzPcGaUgP+vU2z
39p4F4XRghErySzGUnrKFwydO6ZhHHZz0BCZX7cfFo++2mgE7XNIAkz+VNvHwAKK
AR6s/5IhZHvOwjOyrywhErx4Zlq5PVbJ9n8ogFfMFtJKSJRz4DWXt18FCtHUFXaw
SsA4eIpXEHWN8jX+6XjPdnPtQ6H4PAhOYuJz5wWk1N2wID7N3ke8APxl/HpNAtgj
YzoGponLil8xzWyFm6rQF4GTMTduBwKDifYg0y350odXWaNXKGTINGf1yCScvlbn
V0jaky5HmqFDiCQ5n/vfsCEOni7cSEAJh8EzqDByoq4QDJCtHHer59Pn8oWTVl1r
kRGzCA6ZPa7yG2Cwy3UxLCwC/fwKliSxtmBT3GpNHRPUDXDA/BM5eQRRBW56xy6j
B3VQqjGLXsvSUqJpqHfV1Usz3J8NjsAgrwyUCroHIVRZ1jJuZvM/z4ozuIk7lO9o
WANQHaCtjRVy2Ry3odYcfwZr3v2wRCS+mw0QtvSRNHikp847FdE5xmPv9+mHDuFF
yuVweCtWWTvCkh9MAl1DwBj+1FtlW8tVuEJ2M9iT+4zeTRoikYm+bLWm0OMVZ9hU
oys4fcMuirt3ekk+smwEH9+M7tbTwrwwCitmdhSJhTeOJ84Dad08eXPFt0FRgGPs
4i94xgKuijrfsT5RUInm
=VbmK
-----END PGP SIGNATURE-----

--vTIkERICRWQXEEW3JO52keIRuul5br1u7--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
