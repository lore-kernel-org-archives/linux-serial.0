Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3863CEB64DC
	for <linux-serial@archiver.kernel.org>; Mon,  3 Jul 2023 15:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbjGCPDv (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 3 Jul 2023 11:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjGCPDv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 3 Jul 2023 11:03:51 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52700CE;
        Mon,  3 Jul 2023 08:03:49 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3094910b150so5280754f8f.0;
        Mon, 03 Jul 2023 08:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688396628; x=1690988628;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+FTBP2WVoYixlodfo18vYpO/m84MGik/n1FAXY6Ivk=;
        b=kmeO+0ky4OgOW3U7Da6jqBbXEdl1mwzNzANeI9xfr7eiLwbsYx6JEJgRDRIu9aXhSM
         BTw9F5+JcHwaTsHqmlcOMC/2MABXIOWBgoMyAtJu9lyWgdsM54Hijn1QM7j6H7e4Jqjz
         I1DBX4qT8ga1/kSrmqkmfbGajdVByXy7ReYNAONnqtb07aUmLdERKL+MFSL+HdSUG5lR
         zmD49TwPL8CEVSphFvTGfkIAiTsjKyYaXMcl6I0pZRIu5NB59w+e3d9sNQEZJR1Z8Zfr
         eeazfeKo0WA37JyuRTB28TnV6AWXrcsP045u5mqLN54It8RayOyipHtwRNfVaOIzgtOm
         uZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688396628; x=1690988628;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e+FTBP2WVoYixlodfo18vYpO/m84MGik/n1FAXY6Ivk=;
        b=Glqxt63uJ2XvGTmBc/uzI7hff1g4LH5/1bKUhkPaXVXqtLfgYtAJMkAOSQu7VzSZ8H
         9w4XZYiWQtElBvopuDuugpNyZE/vBWovVJeu0AZC7OTKYEUeJhQR5YERnfylYqtEpanZ
         SoiYgoY8qr1mOLzGDqFmIQoCKvfAWbl1KCan5gNt+q4tjA48mR9bPOdtgy07QwLo8Mot
         lDolXptY+UmPctiHCl1oBPIkqYZ7JARA0DXg8Wbvg1C8NxRaMuMqm/0gXiSVFHKbh0J/
         GO6Vv/ycj1YmpYLIAOdd5WcvcARstmnVK66Y49EJasMHKiSUFfrhbzMh4u2sAPqsXAXP
         HSzg==
X-Gm-Message-State: ABy/qLYIMoToM7iVCrYbxsObV30zp3CT7lWiS8MntlhXTtnpxK9uIBmM
        hh8Y0B6WXh/pVv2RGw7Vw6w=
X-Google-Smtp-Source: APBJJlFiMn6oCJm08ZPiKtmDI1EbsSGryf1ZyzGR1chtarJZGlFBlQFUfKAEhwDNCOcBW2uzBxkzmA==
X-Received: by 2002:a5d:6086:0:b0:314:3b68:eac6 with SMTP id w6-20020a5d6086000000b003143b68eac6mr1054683wrt.12.1688396627525;
        Mon, 03 Jul 2023 08:03:47 -0700 (PDT)
Received: from orome (p200300e41f305300f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f30:5300:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id da16-20020a056000197000b0031274a184d5sm25969527wrb.109.2023.07.03.08.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 08:03:46 -0700 (PDT)
Date:   Mon, 3 Jul 2023 17:03:45 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] serial: tegra: Don't print error on probe deferral
Message-ID: <ZKLjUdBdC0vVknsk@orome>
References: <20230703113759.75608-1-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OB4qssmobsEbwOZS"
Content-Disposition: inline
In-Reply-To: <20230703113759.75608-1-jonathanh@nvidia.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--OB4qssmobsEbwOZS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 03, 2023 at 12:37:59PM +0100, Jon Hunter wrote:
> If the Tegra serial driver is probe before clocks are available then the
> following error is seen on boot:
>=20
>  serial-tegra 3100000.serial: Couldn't get the clock
>=20
> This has been observed on Jetson AGX Orin. Fix this by calling
> dev_err_probe() instead of dev_err() to avoid printing an error on probe
> deferral.
>=20
> Fixes: e9ea096dd225 ("serial: tegra: add serial driver")
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/tty/serial/serial-tegra.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Patch looks good to me, though I'm not sure the Fixes: tag is useful. It
points to a commit that is 10 years old and the error message is
probably not worth backporting to every single actively maintained
stable release. I'm not sure it's worth backporting at all because it's
purely cosmetic.

That's up to Greg and Jiri, so from the Tegra side:

Acked-by: Thierry Reding <treding@nvidia.com>

--OB4qssmobsEbwOZS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmSi404ACgkQ3SOs138+
s6F6bBAAvTDDFyo2qZuchLH8jWEnQ30NTeNDzy7JUSN1A/sgNVbXvb7w3Sn3tYgX
7p+SaSd1lpRV4Q4yLdHBkUKbMTFr26d6iaz1t/yh1cuNPtlH6+6Rn6mYv9rxzq/W
09mVo4UYfaO3rxzUgNwCzHs0xie/ZBOIowSkK7KrsiDvLCssk4wOnzoKM0d0pkO6
Nr/CauvnZhEofpmksCI67NNNKd9B1SESVUKuR25+HNl6Oj0gg9dsIudJnlwfCsQe
APB5cTD8260QUIJpgisFEK4fvnUug0bRXfdkMO4APib68dHX8BwlYKtrQM5Uj0Ac
TMs//y9W99Wa6uqwA5e+Ymdv1Is55nevUtINsEimi1Myp6EQhb230/wXKxJEVXY+
DTOCptg7dNVAHxqB+j/6LByoDIo2Zte+B4yIh2pk5yDvxg3N58AkxODXdffNgPUP
GNVoi1EfUbXvhvXDeCC+mvleejJ1bGFSl2fFD373JADF5cs4BqKt7WxUagCW8Sst
DtkXUkxqfSbHEpJlcJ+NXbZwDcr7UbMXpv/fwNL2W0TSXY0erfQmwVOtSOTS4oVI
M4tKdzeL+hik1fJKxFufI4A0Z1wzysTrhd0JILH3I8pEUAoR9G+fBh8C1fXPqK8B
eRyMC1Qaqk82Ceawls6bTNHMnPAqUt6WISDT9nDNdjOE5OP4HLY=
=PcIt
-----END PGP SIGNATURE-----

--OB4qssmobsEbwOZS--
