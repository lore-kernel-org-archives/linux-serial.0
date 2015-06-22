From: Manfred Schlaegl <manfred.schlaegl@gmx.at>
Subject: Re: [PATCH] serial: imx: reduce irq-latency after rx overflow
Date: Mon, 22 Jun 2015 10:20:10 +0200
Message-ID: <5587C53A.9080308@gmx.at>
References: <5585A220.5000405@gmx.at> <4275820.CIOTxUBfmF@ws-stein>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="QtdmuMDllheEF7UCFhMI9tjvDH9gv07Ik"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4275820.CIOTxUBfmF@ws-stein>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Manfred Schlaegl <manfred.schlaegl@ginzinger.com>
List-Id: linux-serial@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QtdmuMDllheEF7UCFhMI9tjvDH9gv07Ik
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 2015-06-22 08:48, Alexander Stein wrote:
> Am Samstag, 20. Juni 2015, 19:25:52 schrieb Manfred Schlaegl:
>> To prevent problems with interrupt latency, and due to the fact, that
>> the error will be counted anyway (icount.overrun), the dev_err is simp=
ly
>> removed.
>>
>> Background:
>> If an rx-fifo overflow occurs a dev_err message was called in interrup=
t
>> context. Since dev_err messages are written to console in a synchronou=
s way
>> (unbuffered), and console may be a serial terminal, this leads to a
>> highly increased interrupt-latency (several milliseconds).
>> As a result of the high latency more rx-fifo overflows will happen, an=
d
>> therefore a feedback loop of errors is created.
>=20
> I understand your rationale but removing this error message from kernel=
 log removes the possibility to detect serial overruns by simply check th=
e kernel log or output on kernel console. AFAICS you have to use TIOCGICO=
UNT to get the error counters.
> How about introducing a rate limit for this kernel message?
>=20

Hello!

I understand your argument, but:
 1. In my personal opinion kernel error messages should only be used on i=
nternal errors (missing resources, asserts, ...) and in cases where no ot=
her way is (yet) available to report errors (by counters, return values, =
=2E..). Lost RX bytes on uarts seem more like a communication error and s=
hould be silently handled by higher layers using error counters, or proto=
col internal mechanisms.
 2. I have found no other serial driver (except serial-tegra and imx) tha=
t reports this kind of errors using kernel messages.
 3. Error counters for serial interfaces can also be retrieved from users=
pace by using procfs -> implemented in serial_core; e.g. /proc/tty/driver=
/IMX-uart.

best regards,
manfred


--QtdmuMDllheEF7UCFhMI9tjvDH9gv07Ik
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJVh8U6AAoJEGS1eKPM78WhtDgP/RfsQ4B4AV69P2zl8JzRR9sA
e+J5ByC0dkCes4X5AmVvNeij9v5a5HP81XePmpRTStv8wn8/ebbZZZ3IUTsKqKDE
qZlaBq6mFz6D/lDfqGb5pZSgDWlWnSxY4IKWD6JE9fe+exLkkOMWQsqSP0T3TFmL
n4cJ719Be65kYzIwKT7GTyhf7G24/HC/ol/FNkCDiEUb1Hy3CS+FuTWYZZqfZPP9
rznStCVffU2vSaNuxEyt5Tubv2Q14OQLvDjzMo1HmZ5HDst/7S6Dsva0BZgy/7mu
foY7WAaEtVzSIGpGt2AJXRGHLgeiXoerip24mO+YAEb/GitonwR0YkMpMa9UPeBG
PML6q3zB07pK3bfNNM51jiYkXV4TYIWa7Vnvvq+Gu29922lP/jqpYE0F7a2kg4wN
gMHs1m3Y4WiOTqXX7BMo6/yjI1PE8LaQLU6zlSsEQhYk5YXq6uANtrl3ucSd6r9G
kHtwIMW8WrhqF2HtjN7AnOMJJjTbWHRCt/3r3V3amHAK2MF6UjxatTU3OeMi1li4
mPxgSFLdbrLUclzo4wRXYV3E4Dy+CBhhkJHBBsoSIfR1JxjFCuGt9As0TeayyBUR
qVHyTmH7PBCogsVB8N6IPhqm15DDbuDg5xQMSQTNQaOF42Nmtx/M1C0R3UhEaM1M
cxJNiyr4xTn3LSuEfKsI
=MFoU
-----END PGP SIGNATURE-----

--QtdmuMDllheEF7UCFhMI9tjvDH9gv07Ik--
