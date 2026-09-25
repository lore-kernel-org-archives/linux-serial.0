Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F644C754A
	for <linux-serial@vger.kernel.org>; Fri, 25 Sep 2026 18:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790362799; cv=none; b=Cz2G0adz6tNR6ytMY/bCDp0cUM6Tl4eMZOlyF4J4bi8xibR0xMuBXDyllp5+nxC8//koIdAKgcmZEEDEQfFFWNX0nxxDUyjaCghy0feJ7tQ3L0IxgBovfDT6CUx8UfF17eaWyUBKlmXHxwTSVj5672bRZmiPHU5YP0d+OXeS4FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790362799; c=relaxed/simple;
	bh=KRq4RMdDu6Uo8DHyLNd0M3yKz1Cxvy4TJdNE8dpCHe0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eHSbcruAs9S2Xaj2iFU/eYvCNbYvxbFGJ1nur8XQU0VchAryZCQUlkza3A5HmbaTlRFo4GA8tRaxshaNU9T75dXzUYUC4qDBAaE2fMja68D/XohPP4tHHtckg6wu32X2aYGpFXulUpil3ChM7wTp5Lyf9j8rltftmsu+H5pLmdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VXcD/hYU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXcD/hYU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDD6E1F000FF;
	Fri, 25 Sep 2026 18:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790362797;
	bh=xjjOPDSJCa3jXlgOwyRtDTiOL4tuvhbLhru9HBBappM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VXcD/hYUDflJSx50AIIu0qc7P0OmjpyHoJwCfkK8Ol2Qci5bNZxSc/IsPedd+GN+m
	 Fx07qC7hP7NMED5tSYBEgAk/vGTgsZ/DkU7G/9QyDqCu+oV6qJgvhSuPtsJp0J+gZ/
	 da8UvqtwIWEHEh3b9nJ8TfifGi8PP/pgp8ceNmtp8c9iU3PgZ8Rh6n+UcZ7Q3loCUC
	 EIkR0FuqagBtKOZ+xvDDqEbuUNKbiKHxRAR9rtb+eLfT24NG8aQEw+QNUdsO+iEf4n
	 ehZcZ8hOtkLc4wchbTHDpF3yLMMg3RzFrMl2Jefrrz+0DI4uKolMVcXhlsqoSEOYXZ
	 Kcz6Aeg9ljm7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: hvc: use modern IRQ acquisition API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260925185011.61259-1-rosenp@gmail.com>
References: <20260925185011.61259-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 18:59:57 +0000
Message-Id: <20260925185957.CDD6E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] tty: hvc: permanent probe failure on -EPROBE_DEFER due to state co=
rruption
--

commit 3ec0d2af78ba8c496b4a45223b1fb5f9769284c2
Author: Rosen Penev <rosenp@gmail.com>

serial: hvc: use modern IRQ acquisition API

This patch updates the hvc_opal driver to use platform_get_irq_optional()
for acquiring its interrupt. It adds handling for -EPROBE_DEFER and other
negative error codes returned by the new API.

> diff --git a/drivers/tty/hvc/hvc_opal.c b/drivers/tty/hvc/hvc_opal.c
> index 402da9e7c5346..ce726b8b5ab00 100644
> --- a/drivers/tty/hvc/hvc_opal.c
> +++ b/drivers/tty/hvc/hvc_opal.c
[ ... ]
> @@ -209,8 +209,10 @@ static int hvc_opal_probe(struct platform_device *de=
v)
>  		dev->dev.of_node,
>  		boot ? " (boot console)" : "");
> =20
> -	irq =3D irq_of_parse_and_map(dev->dev.of_node, 0);
> -	if (!irq) {
> +	irq =3D platform_get_irq_optional(dev, 0);
> +	if (irq =3D=3D -EPROBE_DEFER)
> +		return irq;

[Severity: High]
Can this early return cause a memory leak and permanent probe failure on re=
try?

Earlier in hvc_opal_probe(), the driver allocates a struct hvc_opal_priv and
saves it in a global array:

drivers/tty/hvc/hvc_opal.c:hvc_opal_probe() {
    ...
    } else if (hvc_opal_privs[termno] =3D=3D NULL) {
        pv =3D kzalloc_obj(struct hvc_opal_priv);
        if (!pv)
            return -ENOMEM;
        pv->proto =3D proto;
        hvc_opal_privs[termno] =3D pv;
    ...
}

If platform_get_irq_optional() returns -EPROBE_DEFER here, the function
returns immediately without freeing pv or clearing hvc_opal_privs[termno].

When the driver is later re-probed, it will see that hvc_opal_privs[termno]
is no longer NULL and fail with -ENXIO:

drivers/tty/hvc/hvc_opal.c:hvc_opal_probe() {
    ...
    } else {
        pr_err("hvc_opal: Device %pOF has duplicate terminal number #%d\n",
               dev->dev.of_node, termno);
        return -ENXIO;
    }
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925185011.6125=
9-1-rosenp@gmail.com?part=3D1
