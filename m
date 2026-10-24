Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.67.36.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792843425;
	b=gVQoDga6T9cjGJTdP0jlJ0Xa+UM3rD2ZqBuOj4/NMB6Nz/NqE9cFRsN5FxC8snE1mwAe
	 tKw0AEE+E6QtiY8+3ubUcPQBgCDDzkOunWVQjEvf5cSw+y+9Suwm0Ew5/iQJeJKTStv7b
	 h285UAeNOfSuI7RtTQ95oYkUm6k7itoKF0QMK6hn71UH1VquGxUYIv3x/sgqEtuWPUjpC
	 hT8Q66vK1EJgLRtriKdJTZp7OkaclVSzNpuEq6124p2WKzmkTO3iu/Z2xIYL90PJXp26Y
	 KkfnXpRI2+NosiVddarwoSJgCrOIvVaB1p6ddPvgoWt5gbuUs0rsYytOJkYgtQsh4PA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792843425;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP;
	bh=bOf7vVjEc1JfpKs9y78I7tDudz6gZ0SvhG3C1Iiyl/g=;
	b=HZvfN+2At6szcWeQdZFWmyOuF/SrKeJdNrsS2XtxaYgRNLSwOzzRvB1KiqCzRUsc08/u
	 hNm04o5XYigKPSiR5oxpushfJ20R1lj4rQ57YtSDj6B+KAtQKdJGGyELfbCZZfop78fFw
	 HWURH4cTThWzYcYgeBeFA6uTnEEvtB2EAC1G5/nukxy03pRpozR26GUbvZngTUz48HdWG
	 nEa7n1f/rGjhwJY+B0zr7w2AmzvcdtLNkbNDbwc4uO6s+vvSiL542JZu3V31x47ujo9jQ
	 yxm8f9CfbpBY1NhJGfrlcaEpaFSlJg2eHJU7rkLcsDhuPEL6lVnQiz/QV9u15IWo+HQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=posteo.de;
	spf=pass smtp.mailfrom=posteo.de;
	dkim=pass header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=K9vPfK7B;
	arc=none smtp.remote-ip=185.67.36.66
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385AF606A31A
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 12:03:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 385AF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=K9vPfK7B
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 275E8240104
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 14:03:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1792843422;
	bh=bOf7vVjEc1JfpKs9y78I7tDudz6gZ0SvhG3C1Iiyl/g=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=K9vPfK7BdsGdqqXPssNbOUNIjwGAZ0gj7vWgjlW5U3advvy7jFTIQjE9kUC1TYmUh
	 JNdqUoirDX81F2b1ATfP5rAIjn+AJarpTspkVVz6ys+cpORjh30wHYGO73uz0JD1Dx
	 THJiSrqC7ytc64EK2Ea+mJgLh1n4hfpDr1vipo2mb93KUjBq6A45UOqfruKrLRvIAh
	 7rHDmVQ4sQIOsihW559PtOZzAjWvhplRXZ2Q1hLTvs/1Ee0hLdYtjD0t2LoKUlzHu0
	 tbk4iNdSWu2eoLie1Wl/CF/MMT8dOasImEoxt9nGhW12dLh0go928B4tvBuC7JjT3t
	 TJ+oaR+dlREHA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4jBdp41ZYtz6txm;
	Sat, 24 Oct 2026 14:03:40 +0200 (CEST)
Message-ID: <0197324d19f5c68e46dab41e22dbfc4c1bc34813.camel@posteo.de>
Subject: Re: [PATCH v4] platform/x86: dell-uart-backlight: Bind through
 normal serdev matching
From: Markus Probst <markus.probst@posteo.de>
To: kernel test robot <lkp@intel.com>, ChunAn Wu <an.wu@canonical.com>, 
	linux-serial@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, hansg@kernel.org, 
	ilpo.jarvinen@linux.intel.com, mpearson-lenovo@squebb.ca, 
	derekjohn.clark@gmail.com
Date: Sat, 24 Oct 2026 12:03:41 +0000
In-Reply-To: <202610241920.GJiRENj2-lkp@intel.com>
References: <20261024022930.2704030-3-an.wu@canonical.com>
	 <202610241920.GJiRENj2-lkp@intel.com>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-nR/T0NyQdFn9lrwqgCyN"
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-nR/T0NyQdFn9lrwqgCyN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2026-10-24 at 19:59 +0800, kernel test robot wrote:
> Hi ChunAn,
>=20
> kernel test robot noticed the following build errors:
>=20
> [auto build test ERROR on driver-core/driver-core-testing]
> [also build test ERROR on driver-core/driver-core-next driver-core/driver=
-core-linus linus/master v7.3 next-20261022]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>=20
> url:    https://github.com/intel-lab-lkp/linux/commits/ChunAn-Wu/platform=
-x86-dell-uart-backlight-Bind-through-normal-serdev-matching/20261024-10292=
9
> base:   driver-core/driver-core-testing
> patch link:    https://lore.kernel.org/r/20261024022930.2704030-3-an.wu%4=
0canonical.com
> patch subject: [PATCH v4] platform/x86: dell-uart-backlight: Bind through=
 normal serdev matching
> config: i386-randconfig-1007-20261024 (https://download.01.org/0day-ci/ar=
chive/20261024/202610241920.GJiRENj2-lkp@intel.com/config)
> compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20261024/202610241920.GJiRENj2-lkp@intel.com/reproduce)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202610241920.GJiRENj2-lkp=
@intel.com/
>=20
> All error/warnings (new ones prefixed by >>):
>=20
> > > drivers/platform/x86/dell/dell-uart-backlight.c:328:38: error: array =
type has incomplete element type 'struct serdev_device_id'
>      328 | static const struct serdev_device_id dell_uart_bl_serdev_id[] =
=3D {
>          |                                      ^~~~~~~~~~~~~~~~~~~~~~
> > > drivers/platform/x86/dell/dell-uart-backlight.c:338:10: error: 'struc=
t serdev_device_driver' has no member named 'id_table'
>      338 |         .id_table =3D dell_uart_bl_serdev_id,
>          |          ^~~~~~~~
>    drivers/platform/x86/dell/dell-uart-backlight.c: In function 'dell_uar=
t_bl_pdev_probe':
> > > drivers/platform/x86/dell/dell-uart-backlight.c:363:15: error: too ma=
ny arguments to function 'serdev_device_add'
>      363 |         ret =3D serdev_device_add(serdev, KBUILD_MODNAME);
>          |               ^~~~~~~~~~~~~~~~~
>    In file included from drivers/platform/x86/dell/dell-uart-backlight.c:=
19:
>    include/linux/serdev.h:161:5: note: declared here
>      161 | int serdev_device_add(struct serdev_device *);
>          |     ^~~~~~~~~~~~~~~~~
>    drivers/platform/x86/dell/dell-uart-backlight.c: At top level:
> > > drivers/platform/x86/dell/dell-uart-backlight.c:328:38: warning: 'del=
l_uart_bl_serdev_id' defined but not used [-Wunused-variable]
>      328 | static const struct serdev_device_id dell_uart_bl_serdev_id[] =
=3D {
>          |                                      ^~~~~~~~~~~~~~~~~~~~~~
>=20
>=20
> vim +328 drivers/platform/x86/dell/dell-uart-backlight.c
>=20
>    327=09
>  > 328	static const struct serdev_device_id dell_uart_bl_serdev_id[] =3D =
{
>    329		{ KBUILD_MODNAME },
>    330		{ }
>    331	};
>    332=09
>    333	static struct serdev_device_driver dell_uart_bl_serdev_driver =3D =
{
>    334		.probe =3D dell_uart_bl_serdev_probe,
>    335		.driver =3D {
>    336			.name =3D KBUILD_MODNAME,
>    337		},
>  > 338		.id_table =3D dell_uart_bl_serdev_id,
>    339	};
>    340=09
>    341	static int dell_uart_bl_pdev_probe(struct platform_device *pdev)
>    342	{
>    343		enum acpi_backlight_type bl_type;
>    344		struct serdev_device *serdev;
>    345		struct device *ctrl_dev;
>    346		int ret;
>    347=09
>    348		bl_type =3D acpi_video_get_backlight_type();
>    349		if (bl_type !=3D acpi_backlight_dell_uart) {
>    350			dev_dbg(&pdev->dev, "Not loading (ACPI backlight type =3D %d)\n"=
, bl_type);
>    351			return -ENODEV;
>    352		}
>    353=09
>    354		ctrl_dev =3D get_serdev_controller("DELL0501", NULL, 0, "serial0"=
);
>    355		if (IS_ERR(ctrl_dev))
>    356			return PTR_ERR(ctrl_dev);
>    357=09
>    358		serdev =3D serdev_device_alloc(to_serdev_controller(ctrl_dev));
>    359		put_device(ctrl_dev);
>    360		if (!serdev)
>    361			return -ENOMEM;
>    362=09
>  > 363		ret =3D serdev_device_add(serdev, KBUILD_MODNAME);
>    364		if (ret) {
>    365			dev_err(&pdev->dev, "error %d adding serdev\n", ret);
>    366			serdev_device_put(serdev);
>    367			return ret;
>    368		}
>    369=09
>    370		ret =3D serdev_device_driver_register(&dell_uart_bl_serdev_driver=
);
>    371		if (ret)
>    372			goto err_remove_serdev;
>    373=09
>    374		/* So that dell_uart_bl_pdev_remove() can remove the serdev */
>    375		platform_set_drvdata(pdev, serdev);
>    376		return 0;
>    377=09
>    378	err_remove_serdev:
>    379		serdev_device_remove(serdev);
>    380		return ret;
>    381	}
>    382=09
>=20
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

Because of the missing "2/3" in the subject line it likely has applied
it as first patch. I assume that was by mistake, given you also resent
the same patch again with the correct subject line.

Anyway, this report should be meaningless.

Thanks
- Markus Probst


--=-nR/T0NyQdFn9lrwqgCyN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmrcnpsbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSmQMP/2ZCtnao+OHuSIPBDL3I
pH/cCKHL1ZWfzxnHA7bNV3/je0LUFxW0e9L+tucwVBvhqMItfee1D9wI+sbbVQZ0
7Tjatelzljgh6JcrXDp2/ZnlAymH1LkWgO3OI95ljU8HcYdgHTZTdRMqOhNz47J8
m9G1+rKrvnTUF9WWhPoYqejzGb2aW0u/k3a9h9iWSeF3TWDwkzKrkKJuqajuIzAg
rpV0I6TEk0zlPMLfzsvACOALNwM4x4EGnSHTt2N0UIwdzqZMmVAN1awVDrqGLYM1
nfEN64G7MIV3sOc+8o9vtQExl9FPK8udFwEURnN2qQH5mzeHIRNCOdb58KeKoTfd
9kqin7C8iVAtWhlq7wBPh9MzYcCSHtssnu0iXho4LwCsGmH4rjZVebDaJc+Oo1nn
B1233CyHdA9eDkLvk/RkixG7akyy2spTooBCILftZIN/sszLCPz3P0tMzPEWNo2d
72RhncM1dD1wMRovUSrzz0tR1t4uE0Auo4pTkdlA7mxVSP48Afiq+Q/NwSkTIf+w
5UUvxd48YcJ+UaYp+bic/iQIkHUXfJqtzY9OMF3OdZQ4iF2wDK1C3k2Y9i4RxSEl
N5mhSO0BKF28ilGS8xH4hhZyxKtmOOoGN77EfNJVT33mZjj1v74r5XJitny1nEfv
oAebnCpn3hbSVVgSQ6rQBBwq
=mGFw
-----END PGP SIGNATURE-----

--=-nR/T0NyQdFn9lrwqgCyN--
