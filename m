From: Stuart Longland <stuartl-3e+Fe6x+DsgJbe36r25VNhCuuivNXqWP@public.gmane.org>
Subject: Re: [PATCH] USB: serial: ti_usb_3410_5052: Port uart_mode from io_ti.
Date: Fri, 18 Aug 2017 13:16:25 +1000
Message-ID: <498e9270-f174-1f72-f0ee-c68b0e6894bc@longlandclan.id.au>
References: <4a469222-d48d-f498-f2db-ca582295adc3@longlandclan.id.au>
 <20170818025659.4402-1-stuartl@vrt.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="n0DpqDH38jWI0dUIJiUEVGCAejxKVcOVm"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170818025659.4402-1-stuartl-EoQOJlg3kTYQrrorzV6ljw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stuart Longland <stuartl-EoQOJlg3kTYQrrorzV6ljw@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alborchers-2TsfIrYsZRL7O9PZeWXHPg@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--n0DpqDH38jWI0dUIJiUEVGCAejxKVcOVm
Content-Type: multipart/mixed; boundary="t4a4uTqCOx5Kr0i73JBpw81Hb19Hp6lWC";
 protected-headers="v1"
From: Stuart Longland <stuartl-3e+Fe6x+DsgJbe36r25VNhCuuivNXqWP@public.gmane.org>
To: Stuart Longland <stuartl-EoQOJlg3kTYQrrorzV6ljw@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
 alborchers-2TsfIrYsZRL7O9PZeWXHPg@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <498e9270-f174-1f72-f0ee-c68b0e6894bc-3e+Fe6x+DsgJbe36r25VNhCuuivNXqWP@public.gmane.org>
Subject: Re: [PATCH] USB: serial: ti_usb_3410_5052: Port uart_mode from io_ti.
References: <4a469222-d48d-f498-f2db-ca582295adc3-3e+Fe6x+DsgJbe36r25VNhCuuivNXqWP@public.gmane.org>
 <20170818025659.4402-1-stuartl-EoQOJlg3kTYQrrorzV6ljw@public.gmane.org>
In-Reply-To: <20170818025659.4402-1-stuartl-EoQOJlg3kTYQrrorzV6ljw@public.gmane.org>

--t4a4uTqCOx5Kr0i73JBpw81Hb19Hp6lWC
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: quoted-printable

Hi all,

On 18/08/17 12:56, Stuart Longland wrote:
> This introduces the `uart_mode` sysfs attribute as seen in the `io_ti`
> USB serial driver, allowing this USB serial interface to be switched
> between RS-232, 2-wire RS-485 and 4-wire RS-485.
>=20
> /sys/class/tty/ttyUSB${num}/device/uart takes a single integer:
=E2=80=A6 and of course, I meant 'uart_mode' here, not 'uart'.

>=20
> 	0:	RS-232 mode (default for RS-232-compatible dongles)
> 	1:	RS-485 2w mode (default for RS-485-only dongles)
> 	2:	RS-485 4w mode / RS-422 mode

This is of course, not a very elegant solution, but it gets me out of a
bind for now and at least gets the RS-485 functionality of this USB
serial dongle working.

Long term, I think the earlier ideas of expanding the RS-485 related
ioctls should be pursued.  I'm open to ideas here.

Regards,
--=20
Stuart Longland (aka Redhatter, VK4MSL)

I haven't lost my mind...
  ...it's backed up on a tape somewhere.


--t4a4uTqCOx5Kr0i73JBpw81Hb19Hp6lWC--

--n0DpqDH38jWI0dUIJiUEVGCAejxKVcOVm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvKEYefT5O+PbDe5y+VS7u3lI1UYFAlmWXAoACgkQ+VS7u3lI
1UbtRQ//fEVv36DZxcBLskny5xZBpmscmGx6wIxriRnVWUz/0etBj/piDXXY5bsN
90z1OEbotdz4YGl4eKc6R4t5JffyGHOCDAG6q1XN8p0TRJIYLR15w3ZstEQGs5lL
uIEx5nJ6eUm0wRcsJhUqr3ry2TjJk4U0hIJYOTAnJbFdq0oh3ob2H0neGlyHy6XE
OwFl4fqYI1utKfAAKKkYlRPWhPDNOnBNOq4Sd4mTxq/FS0FL373XW8uFAoJfIfub
uBuV0RB2qglxNPz8SIIYyy5fxsDYa6pp5UibELR26u9B4ZweyddDTmIl/ug/AGd+
6fRqE9Rb8OIukdW/nwfl6mmPrsm9bpGcGKaz7ZtHQ1XAQ1huEtzeifGBpUoipuxb
5ekA+xxaA8iKGEL7lbefCtkOPwRyfO0+XqeNAMYdVtqDDtD63TA+rlPl5sG6Zv9O
4EVTAb3jRollo/sNptbuafEFmMWCqCGmigx8uzGpcPrptUAwjIeLhiTjhCylGxO5
I5hnEBm01hT3JUx6WtTV9ppO7fsjPXlgvjlo/xc4hLG7lKgCbiIJCAWN1QcUJOZ6
FmrO9Cl8gjBxSKhKXkXP7eZ1XP2RGY6Jzd08VwEIUpklTqUjsxTj/oFe1sIvEJBk
Q0+WdfqPuFvoT5ZrHWe/KNKBCMIxidNWB/hqYAG1u3C8Qg5zNe4=
=CSwm
-----END PGP SIGNATURE-----

--n0DpqDH38jWI0dUIJiUEVGCAejxKVcOVm--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
