From: Sven Brauch <mail-ITmcY+a7/CDoK6nBLMlh1Q@public.gmane.org>
Subject: Re: implement put_char() in cdc-acm
Date: Sun, 1 Nov 2015 20:28:25 +0100
Message-ID: <563667D9.9080401@svenbrauch.de>
References: <1445958479.2043.6.camel@suse.com>
 <562F9C08.6050105@svenbrauch.de> <1446030280.15140.10.camel@suse.com>
 <5630BE5E.6040204@hurleysoftware.com> <1446035622.15140.17.camel@suse.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="SLLhTquBg75Qe1VfwM7Mt1KdmkBvqcQWA"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1446035622.15140.17.camel-IBi9RG/b67k@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oneukum-IBi9RG/b67k@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SLLhTquBg75Qe1VfwM7Mt1KdmkBvqcQWA
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hey,

On 28/10/15 13:33, Oliver Neukum wrote:
>> Sven, please test Oliver's patch on that tree.
> It can be found at=20
> https://kernel.googlesource.com/pub/scm/linux/kernel/git/gregkh/tty/
I finally got around to test this; sorry for the delay.

I cloned that tree (git describe said v4.3-rc5), and applied Oliver's
patch. With that kernel booted, the error occured much less frequently,
but was still reproducable under load. With 4.2.5, I get a failure after
a few hundred MB; with 4.3-rc5 plus patch, it transferred serveral gigaby=
tes
without errors, but failed when I started compiling something in the
background as a test.

So, I guess, this improves things but there's still no guarantee that
the data sent by the device will actually be delivered.

Querying for the stty options while the program is running gives this:
# sudo stty -a -F /dev/ttyACM0
speed 9600 baud; rows 0; columns 0; line =3D 0;
intr =3D ^C; quit =3D ^\; erase =3D ^?; kill =3D ^U; eof =3D ^D; eol =3D =
<undef>; eol2 =3D <undef>; swtch =3D <undef>; start =3D ^Q; stop =3D ^S; =
susp =3D ^Z; rprnt =3D ^R; werase =3D ^W; lnext =3D ^V; discard =3D ^O;
min =3D 0; time =3D 0;
-parenb -parodd -cmspar cs8 hupcl -cstopb cread clocal -crtscts
-ignbrk -brkint -ignpar -parmrk -inpck -istrip -inlcr -igncr -icrnl -ixon=
 -ixoff -iuclc -ixany -imaxbel -iutf8
-opost -olcuc -ocrnl onlcr -onocr -onlret -ofill -ofdel nl0 cr0 tab0 bs0 =
vt0 ff0
-isig -icanon -iexten -echo -echoe -echok -echonl -noflsh -xcase -tostop =
-echoprt -echoctl -echoke -extproc

If there's anything else which would be helpful for you to have tested,
please let me know.

Best regards,
Sven


--SLLhTquBg75Qe1VfwM7Mt1KdmkBvqcQWA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWNmfcAAoJEGjKjjjEuz9LsJUP/2AcQi7VMmyGSPxcPVhFUMZ9
pPW+dv7vIl2hI2yfmozQEoQ++myT6FWsOkEbyuoEozRVFkRTZzeQepIp6IqnWkY3
rTDHIj8C5MwRtS0N9YRosxAMS/7DvRTZr/dVZwvlooy5BzWug2QUqDEsgFBPevo/
9IbDmX8CwNq70Fo3nHzL5NrttecNGMfcjZnfrq5kwpg1BJ14fApGqtT6BQ29ap4R
6+DJCvhMlPc+HncigUhANXZ0Z5nO7a5FB8ER0+VaMiYzW7hUc6cVsXa41m5POhOA
2SjRi/fc+fRUWkklUiucIxwJSWP6OGe0kjdHoPQg1Dvb6odTNuI1x+qm7vxSlrCv
PBK7NauaOhneZwEUpilmmGPWPe/v696kunCZBTzUGfkttLkkHy+NcJvuVmG7PGPx
1OlP31dsIw0MMlRNDTb5d9PVaolLVcWhcuB70ZGr8lyLzcYQPQfO4n7Gb/sIhMPE
xgCAOBDUh+DkelY1bZt8UKRcAdMKW/268+lK3vwP34dxgIJSnUTxrDEZHfA+Wq1R
7ph2HtOfWPhewxUwjfAL3TMUGOyQiI4Br2zlDkdfVX1J8BD9r4lI7DzJKpsw25N0
s5rw9d0zbuhBKhluH7MHuyETcCEmaRnLAm95TSjxWSP6GDSezBSGW11W9LWe39NE
0XhYHE2X6u4o0QUCY5oE
=HSgu
-----END PGP SIGNATURE-----

--SLLhTquBg75Qe1VfwM7Mt1KdmkBvqcQWA--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
