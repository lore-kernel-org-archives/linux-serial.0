From: Paul Burton <paul.burton-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 00/15] MIPS Malta DT Conversion
Date: Mon, 25 May 2015 14:29:30 +0100
Message-ID: <20150525132930.GR13811@NP-P-BURTON>
References: <1432309875-9712-1-git-send-email-paul.burton@imgtec.com>
 <CAOS_Y6TRN2b5PGxWdO6SD5W2Wmo33Z88DeHw7Jrxw4TzzVYLcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GUPx2O/K0ibUojHx"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOS_Y6TRN2b5PGxWdO6SD5W2Wmo33Z88DeHw7Jrxw4TzzVYLcA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, Paolo Bonzini <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Leonid Yegoshin <Leonid.Yegoshin-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, "Steven J. Hill" <Steven.Hill-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Qais Yousef <qais.yousef-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Markos Chandras <markos.chandras-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, Michal
List-Id: linux-serial@vger.kernel.org

--GUPx2O/K0ibUojHx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2015 at 02:59:31AM -0500, Rob Landley wrote:
> On Fri, May 22, 2015 at 10:50 AM, Paul Burton <paul.burton-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org> wr=
ote:
> > This series begins converting the MIPS Malta board to use device tree,
> > which is done with a few goals in mind:
> >
> >   - To modernise the Malta board support, providing a cleaner example to
> >     people referencing it when bringing up new boards and reducing the
> >     amount of code they need to write.
> >
> >   - To make the code at the board level more generic with the eventual
> >     aim of sharing it between multiple boards & allowing for
> >     multi-platform kernel binaries. Although this series doesn't result
> >     in the kernel reaching those goals, it is a step in that direction.
> >
> >   - To result in a more maintainable kernel through a combination of the
> >     above.
>=20
> How would I go about testing this under qemu?
>=20
> (Especially the "more than 256 megs ram" part. :)

Hi Rob,

With the series applied you can start from malta_defconfig, enable
CONFIG_HIGHMEM, build your kernel then run QEMU like so:

  $ qemu-system-mipsel -kernel vmlinux -m 1G -append memsize=3D1G -serial s=
tdio

If you apply this patch to QEMU:

  https://www.mail-archive.com/qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org/msg297902.html

(or if you use a real board) then you can omit the memsize argument from
the kernel command line (ie. the -append) and just do:

  $ qemu-system-mipsel -kernel vmlinux -m 1G -serial stdio

The kernel will then retrieve the correct memory size from the
bootloader-provided environment and make use of all the available RAM.

Thanks,
    Paul

--GUPx2O/K0ibUojHx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIbBAEBCAAGBQJVYyO1AAoJENzvn0paErs5IoEP9A+/GJonjPcXdU4ISCC2jhSe
VLMFy+gR9WFGd+nd68J5imIaajXdSeOAeWRP4N7ryFnMBtgkx2BKm4XDAmvx0RFi
TobVMvEOhwQ83twetcc2e5yk7sMEt469ySVnRLy652lgeM0F6OBIFkwGNfAgaCVN
5BUyKuvt8KE5DaBUIZJ+FVgf0+X2/wvdwxYnEd/roZkBFvnSKLCmfkqBMlkNxNC/
0XRay7XBbArqlpw37G6dCqKbNcADOC7E5eJQwLVbtvF1DZ/Cxgr84yUG3DNEehbA
2yDw9ZV6meWqtXIao8yGsP/In8x/VFak/iN6xkbpz1WkXsy/35pYnY9Rz1ZvZbxB
aB9h1zlGO9gawkPqQNmL/SW2eRo2H+OrDiZV0eRLArx7nVGEvuBbv96juwn6N6KP
dR3fglBjWsk5P6FacnMcAyx0cRTyYt72Iw7Fl5g2jKnGmK9v8X/RSyQK8z5dyzT9
r0hcuH+L8KJ8u5u04z7kpcGTLOCMKEUebqzqZVzGdb/npBnrf2m1/DaDXbCST3p2
mS/3nmml7kPERZmFKRqb9LN51LmwZjSDynSS+oYRuRB22doAEPEZPSZlMCzEF1Wr
oBkq6RVymhmgr3LY7/EALw+X/EHR5HXBs3tPAH37y54ZD5MOME0PhQydKGDwsqxS
fPq0m+RALx9Y5ghGuXI=
=JaeJ
-----END PGP SIGNATURE-----

--GUPx2O/K0ibUojHx--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
