From: Julio Guerra <julio-wf23HAOg02MWenYVfaLwtA@public.gmane.org>
Subject: Re: cdc_acm bug? read buffer bytes shifted
Date: Fri, 16 Sep 2016 18:24:35 +0200
Message-ID: <f97a97ee-4d22-145c-5f73-472ee4f03968@farjump.io>
References: <2c59e268-9fd6-172b-1803-074aa4e11f27@farjump.io>
 <1471692758.29854.0.camel@suse.com>
 <4bffb2dd-de01-8819-cf44-c4fb1357ecd4@farjump.io>
 <1471874667.17783.19.camel@suse.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="SdoBQdRSaHDWoRs7TXF9HAj8jGResctqB"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1471874667.17783.19.camel-IBi9RG/b67k@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oneukum-IBi9RG/b67k@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SdoBQdRSaHDWoRs7TXF9HAj8jGResctqB
Content-Type: multipart/mixed; boundary="axBp3wdrQCcHjkFrgPUXcSsEADwehpbPf";
 protected-headers="v1"
From: Julio Guerra <julio-wf23HAOg02MWenYVfaLwtA@public.gmane.org>
To: Oliver Neukum <oneukum-IBi9RG/b67k@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <f97a97ee-4d22-145c-5f73-472ee4f03968-wf23HAOg02MWenYVfaLwtA@public.gmane.org>
Subject: Re: cdc_acm bug? read buffer bytes shifted
References: <2c59e268-9fd6-172b-1803-074aa4e11f27-wf23HAOg02MWenYVfaLwtA@public.gmane.org>
 <1471692758.29854.0.camel-IBi9RG/b67k@public.gmane.org>
 <4bffb2dd-de01-8819-cf44-c4fb1357ecd4-wf23HAOg02MWenYVfaLwtA@public.gmane.org>
 <1471874667.17783.19.camel-IBi9RG/b67k@public.gmane.org>
In-Reply-To: <1471874667.17783.19.camel-IBi9RG/b67k@public.gmane.org>

--axBp3wdrQCcHjkFrgPUXcSsEADwehpbPf
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> On Sat, 2016-08-20 at 14:14 +0200, Julio Guerra wrote:
>>>> Another example:
>>>>> 00 00 00 00 00 00 00 01
>>>> ...
>>>>> 01 00 00 00 00 00 00 00
>>>> ...
>>>>> 00 01 00 00 00 00 00 00
>>>> ...
>>>>> 00 00 01 00 00 00 00 00
>>>> after a random number of times, while usbmon shows the usb payload
>>>> "00 00 00 00 00 00 00 01".
>>>
>>> Hi, how many bytes does read() return?
>>>
>>
>> Exactly 8 bytes, always. I set the tty in raw non-canonical mode with
>> vmin =3D 8 and vtime =3D 0. I also tried with vmin =3D 1 and did the c=
opy of
>> exactly 8 bytes by looping in userspace, without any improvement.
>>
>> I wrote a small workaround for now that detects this problem (because =
I
>> exactly know what the buffer is supposed to look like) to close() and
>> re-open() the device. The next read buffer is then correct.
>>
>=20
> Please activate dynamic debugging for the tty and cdc_acm driver.
> We need to know where the corruption happens.
>=20

I didn't find anything helpful in /sys/kernel/debug/dynamic_debug
regarging the tty module (I enabled tty_io debugs and it doesn't appear
in the logs), but I enabled cdc_acm debugs. Nothing is observable in the
logs when the bug appears. I logged everything as a comment of the gist:
https://gist.github.com/Julio-Guerra/b6529994f814771c825649bdb8d927c2#gis=
tcomment-1875985

Note that re-running the script restarts the underlying kernel buffer
correctly, it does not restart from its previous bugged state.

Let me know if you want other debug traces enabled.

--=20
Julio Guerra


--axBp3wdrQCcHjkFrgPUXcSsEADwehpbPf--

--SdoBQdRSaHDWoRs7TXF9HAj8jGResctqB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQIcBAEBCgAGBQJX3BzfAAoJEBh1WakJKS6kgPgP/RxB6ulzdA7tO2WyBDgKhFmk
H0t0xRKA5t3uPbbKRNNvjSLrPdBAJFRriz3ZyTCx1FJoUrA51Yn0YJBO0Gp35G6I
yZsak6PsAvlIpLNAvHC6sFOdezYfm51JBJmnwMvCz0S5EFqD0bxlQviwKnB+tSA1
KVqR/wQpHKNbs+nl/cHh+/Ty2YJINyuwQymQ/YJ8PrzbvLrBkQ8zZvhMmNOTInp+
X80yQHK/2Lf9/3n4Vxp0uVQMZUcsKHo4lEV0RQmkFpJXeurtUyRZxUqj/r6nBJB7
T/1F3LQ0M+nL0T7C2KfHCpomts8I/EJEK9Ykfe9lGZk60fNmnbMXf0XeLqcXFpMi
AYOqvDEsWgq6pnalcf9WRBuoASb60vn/iQRTU2zXs0BoHFbk+CzTT8wGihJoyygi
dAuZ/xW9ycmuzw5oeMuMPUzetUO/XgmBlfHhdM96fTt5TvyEHVn3WlWm3MbXFny0
5Oa7cm79KQ2/YrsX+iOzWFVXnUelr77BiikqLTRiTYD3cOMFtujV0/lm7XyHXV+d
9Zf5ipl+uujvO2ebGzn6EjzWR84X44+BoULoFXt1VKFw2e40JZENW2Cl8fZFmFmP
hH6ArfC+YY5QAX9QyMRmWYsEHGTTEV66UoI6piJbrfHyibpixgziiz15zBa1fOGS
qjeQtAVoEfzkt+8tjwre
=LuH+
-----END PGP SIGNATURE-----

--SdoBQdRSaHDWoRs7TXF9HAj8jGResctqB--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
