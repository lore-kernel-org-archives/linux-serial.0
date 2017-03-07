From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 10/10] Bluetooth: add nokia driver
Date: Wed, 8 Mar 2017 00:06:09 +0100
Message-ID: <20170307230609.kpw3y2pkfka6kgo5@earth>
References: <20170304115833.3538-1-sre@kernel.org>
 <20170304115833.3538-11-sre@kernel.org>
 <CAL_Jsq+PvqS_tU6wRzpcsdESYxOOU_JJqsacEc9qLDs2PB2VLw@mail.gmail.com>
 <20170307210837.w5fdwc2sy3xmzci7@earth>
 <65D9766C-9BED-42D5-931C-65044530E215@holtmann.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yjbcw4gvvbbzjx7v"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <65D9766C-9BED-42D5-931C-65044530E215-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Gustavo F. Padovan" <gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org>, Johan Hedberg <johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org


--yjbcw4gvvbbzjx7v
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On Tue, Mar 07, 2017 at 10:20:27PM +0100, Marcel Holtmann wrote:
>> [...]
>>
>> - compatible: should contain "nokia,h4p-bluetooth" as well as one of the=
 following:
>> * "brcm,bcm2048-nokia"
>> * "ti,wl1271-blueooth-nokia=E2=80=9D
>=20
> I never liked the term =E2=80=9Ch4p=E2=80=9D. It is fundamentally just
> =E2=80=9Cbluetooth=E2=80=9D.

It's not me, that came up with the term, Nokia called their protocol
H4+ (for DT people not familiar with bluetooth - the standard
bluetooth UART protocol is named H4). I agree, that H4+ is
ambiguous, but with the "nokia," prefix it should be clear what
protocol is meant. I don't really mind, though. We can also just
list the individual chips and add all compatible strings to the
driver.

FWIW I remove the term from the driver leaving only a single
instance in the header ("AKA H4+").

> What are our plans for Broadcom, Intel etc. Bluetooth UARTs?

I think drivers, that need extra resources (like GPIOs) can switch to
serdev exclusively. The kernel needs ACPI/DT/boardcode data for those
devices anyways.

Iirc Rob is working on serdev patches for Broadcom and TI BT, so he may
provide more information.

-- Sebastian

--yjbcw4gvvbbzjx7v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAli/PN4ACgkQ2O7X88g7
+pplCA//RECW46Q3/61zbH1prx80b7exC1YSCIfcaEvTnzmmwrFM4tTjVB/KdSXL
IhV06OCdcOwr9c1viXO6L4KRevFEA8V46rH0XMpQFUPmgSB/HGYVb+12tlTjcXNO
pU0qKLqGAjqGM9kY/xhzoELnnIhwcRvkonpyx8dRNJSobgodOJvatJLgYQkqs74u
wO26/W8DhuRTYpYU4XZEmURlcNil1NYHIRSm7hEaDooAg1jsLj9yqXRImzhnXrGo
A0dkpvlmybHrhKJHzJXTlj2MsbjqGlapaJa2Kbi8qc7O6jgm0F65qsD0Tzbggcaj
5XB8FAIjWOYdD6qXh2vopZ0lJU5cHpWZvajdS3LbLIsW6BE/6rJPj+ej34XzGN0y
enA27o2y/uPuI2q6YzhtI1sGbdk2NxsytZXSZsPfOnsB9p1cBefmcISEWoPfwuUj
tKVofnkhfHpaq/j+VhkkvtsuVIM2knLzSNAKojBQ4VrRvKtlgInflq1EiU4Wc8GY
qtSgCk3m6vXDa2ctiqvVGO6qMliniNkLx5I2K8pUghTBAYRxa4dTWoVG0Re6RWqp
evj9gzigQvWV2pKPsIWWrZ/9LEB2OF3xPp6T4rBl6rbEJQMCH5dY+hg1zgo2FxKe
m0C4PUyNMVFB28J6MZbF11Bu4IsTgnHhLuQsKoVwcAycr8boFWc=
=Io95
-----END PGP SIGNATURE-----

--yjbcw4gvvbbzjx7v--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
