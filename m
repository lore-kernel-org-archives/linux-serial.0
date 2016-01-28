From: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH V2 1/2] dt/bindings: serial: bcm2835: add binding documentation for bcm2835-aux-uart
Date: Wed, 27 Jan 2016 22:39:54 -0800
Message-ID: <87y4bacimd.fsf@eliezer.anholt.net>
References: <1452344854-2576-1-git-send-email-kernel@martin.sperl.org> <4288762.bCLxQBDvy4@wuerfel> <6035A0DD-AD61-48F7-B641-272BB23F3CD8@martin.sperl.org> <4799423.86Gz9JKjiK@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4799423.86Gz9JKjiK@wuerfel>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> writes:

> On Monday 11 January 2016 14:57:46 Martin Sperl wrote:
>> > On 11.01.2016, at 13:21, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:
>> >=20
>> > Please just add another patch to rename the existing uarts appropriate=
ly
>> > first, then add this one on top with the correct name.
>>=20
>> I can do that with the next incarnation of the patch.
>>=20
>> But would that not break dt-source files, that refer to uart0?
>> Is this not considered an API change as well or does this only apply
>> to the binary files?
>
> To clarify: I meant you should change the node name, not the label.
>
> The label is not part of the dtb data that gets passed to the kernel
> and can have any value, including "uart0".
>
> The node name is part of the dtb and should follow common naming
> conventions (per ePAPR), but the kernel doesn't actually care, so
> it won't break anything.
>
> There are cases where a bootloader relies on a particular node name
> in order to find a device node and patch its properties, but I don't
> think this is the case here.

Confirmed, the booloader source I have doesn't do anything with uart
nodes.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWqbe6AAoJELXWKTbR/J7o0jEP/3Z3edblFHKMYdQhW7IzjwFz
rxLumUCmB7/DAH7BY8p+z24+z621TAujvlm4hNE4IyDQawUIBHRng5c3aO0cgV0z
Zqbyww8IGzk6FzlJEWsmgmH2d+q9Q8JPGs/me3hlgGtgOfdu83VcXewsQ0hCyZl+
kxEbAr8qOQ1bquVAhE/X+Nh9KM/elwb5w6r9GQ8lfRIhXN0hUWagwV0F81rb336k
M05vnypnOm2mmtcU9Tg/rP7OiRnpSs/kGhyXiFcSn9DuRPr0mntBinSgbpldEpcc
LAIsyEdxdEWPZurdWbRGbjHG+udfWCdqQfuaVCldwsOnzMQQqG8WY8IZoyoP2Jr3
lCHssEt6sLg/5sFEKAG2A02V15QCrHkApJ3RnH79TzmUfbmanmwoFrRbOt/5HcO+
gftldn3ByAW4qrTEPVdW7gk0WwZMkU/VT/1p+5bE5j7ulh3GAfu5OWlzBV5ZJl6V
0yi+fec8D4aLxnQ0uWYyjsVALUYDsKU9maj49lJwwDE0tdrL5Gn4EJYRrM2N3HSo
iDmltkGjiSCSm7iHm32mLPdiPTxbS9T/kG7g5YdOAlC0v8zxzqCK+MhBJ9uxHRlL
tSPH0J7+0QhZac4lq/8iNVElifv2wTbTksUqBtExARJ1If+tgihtLkoHSrlfTogi
dS/yv4OTalgnUWCnWdR2
=FcJx
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
