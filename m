From: Sven Brauch <mail-ITmcY+a7/CDoK6nBLMlh1Q@public.gmane.org>
Subject: Re: implement put_char() in cdc-acm
Date: Wed, 28 Oct 2015 16:53:46 +0100
Message-ID: <5630EF8A.8060904@svenbrauch.de>
References: <1445958479.2043.6.camel@suse.com>
 <562F9C08.6050105@svenbrauch.de> <1446030280.15140.10.camel@suse.com>
 <5630BE5E.6040204@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Rnw2fofwh76JCOiPUVxSgE6t92bXJ7TRc"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5630BE5E.6040204-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Oliver Neukum <oneukum-IBi9RG/b67k@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Rnw2fofwh76JCOiPUVxSgE6t92bXJ7TRc
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hey,

On 28/10/15 13:23, Peter Hurley wrote:
> Sven, please test Oliver's patch on that tree.
I will do as soon as I get around to it, I hope on the weekend.

> Lastly, please confirm your test method/termios settings (iow, are
> you using a reproducer or just 'cat big_file > /dev/ttyACM1')
Sorry, what exactly do you mean by "reproducer"? I have a
microcontroller which acquires and transmits the data on the device end
of the USB connection. The data flows from device to host.

> I would much rather rework URB flow + unthrottle, as I previously
> outlined in the original thread instead of introducing another
> buffering layer.
=46rom my non-kernel-dev point of view, this seems the way to go if the
strategy in my patch (technical flaws aside) is not acceptable.
Everything else, i.e. larger buffers or less delay, will certainly be a
welcome improvement but still does not guarantee data delivery.

A very similar patch, by the way, was already submitted a few years ago
[1] but not accepted for similar reasons as brought up here (I only
found that thread later on). That patch has a more elegant
implementation than mine, so you might prefer reviving that, if it
becomes relevant.

I will be happy to test any fixes which come up, although I can't
promise I can get around to do it immediately.

Thanks and best regards,
Sven

_______________
[1] https://marc.info/?l=3Dlinux-kernel&m=3D130754754705303&w=3D2


--Rnw2fofwh76JCOiPUVxSgE6t92bXJ7TRc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWMO+KAAoJEGjKjjjEuz9LZIYP/RntkRmca7B1dbd7csEGs9Nv
gbPOyZBf+XgnyxeUqIcuIU0PaXFeVnYU1ZXmHRyP5SUt45wcOJoR3HEMO40/PrnR
ptNmNuJEJDvzeoOnOpvZk3FVyhtanyXMRRAOnQnRwMhgokjdGtdDfVb6gHxZdz1V
RSoq1z30OmpT/Gw2yXyjo/lHHib6LsVcWAqMbI5ezFmD0WZuNpRoGuebC22Dujen
klJJ4EBAuZuYePcRUsWaCEB9gX13p2LZB6QkiGew4LGc/943dmpTRtgc1JPyYDZJ
HFMWaOzFzhJVrw1eZq3bL3QByS9BLuV2kxYhdBwTqnpfpcdXU4Fz4/ESZwV5m/AF
1Yq66z9mHwwd/CFRmiwmPRtCmdldLAWCF7EsU/s6TQZzcHgXON/43LumpzRXnM2Y
TO6DTxKLG+nfGu4Fgptd/R7j1wc1UqzQ4WbKWtvxPlH7++W7hLr2ezzcXCu1+3dt
uhbHDvyB7LAidJ2nnR80YrTV1/8VTDIFJd3mNFlCLVuZB2xAeGFEHN/a1gBOF+hU
5DD4bxefN5y1NEioHAN/2InUr382bcoh9XhoHMR/MYmjigsjvpdA1nsOKDJ5KcSZ
xZJSqSwNOII97sDJH8IptVfsfPJ4XaB18LyBn2EsRnNR8AoBbvyLGJDNVU191DEB
8vG1gEaFXtvrB99mL585
=SJ8k
-----END PGP SIGNATURE-----

--Rnw2fofwh76JCOiPUVxSgE6t92bXJ7TRc--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
