From: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [PATCH] Fix the warning of uninitialized value in driver/serial/8250.c
Date: Mon, 2 Feb 2009 11:03:16 +0100
Message-ID: <200902021103.21887.laurentp@cse-semaphore.com>
References: <4986B86E.3030604@oracle.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2771663.RnMNcygN0y";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756296AbZBBKDj@vger.kernel.org>
In-Reply-To: <4986B86E.3030604@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wenji.huang@oracle.com
Cc: linux-serial@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

--nextPart2771663.RnMNcygN0y
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 02 February 2009 10:10:06 Wenji Huang wrote:
> This patch is to remove the the warning of uninitialized i in
> driver/serial/8250.c
>
> Signed-off-by: Wenji Huang <wenji.huang@oracle.com>
>
> diff -Nurh drivers/serial/8250.c.Orig drivers/serial/8250.c
> --- drivers/serial/8250.c.Orig  2009-02-02 14:02:47.000000000 -0500
> +++ drivers/serial/8250.c       2009-02-02 14:03:30.000000000 -0500
> @@ -1678,7 +1678,7 @@
>
>   static void serial_unlink_irq_chain(struct uart_8250_port *up)
>   {
> -       struct irq_info *i;
> +       struct irq_info *i =3D NULL;
>          struct hlist_node *n;
>          struct hlist_head *h;

gcc is wrong, i can't be used uninitialized in that function. You should us=
e=20
the following construct instead to suppress the warning without generating =
any=20
code.

	struct irq_info *uninitialized_var(i);

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart2771663.RnMNcygN0y
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkmGxOQACgkQlyYWY4YEWhX+NwCfWyt/YHsocft+QRGDVwbgnmZZ
YsoAnjLywxfbHMmt8wUEbsbQQHVxvK0C
=Oiqq
-----END PGP SIGNATURE-----

--nextPart2771663.RnMNcygN0y--
