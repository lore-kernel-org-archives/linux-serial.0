Return-Path: <SRS0=SZDA=AZ=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F58C433E4
	for <linux-serial@archiver.kernel.org>; Tue, 14 Jul 2020 15:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A47C72222E
	for <linux-serial@archiver.kernel.org>; Tue, 14 Jul 2020 15:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jwl7xjaj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbgGNPws (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 14 Jul 2020 11:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgGNPwr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 14 Jul 2020 11:52:47 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDCAC061755;
        Tue, 14 Jul 2020 08:52:47 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id d18so17729002edv.6;
        Tue, 14 Jul 2020 08:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HC01Z6OLDElwaYfUqlXgjB5pKfu/tIF7xhD0stkkoE4=;
        b=Jwl7xjajpAamyRBfornhb/ooABbGMtjk3/sQx5mWMrJMj2Awgv+gDjRmAjSHkQ0Gv7
         nlliQDgxqH4s7/dXsCh7i6CfYdJ3yAvUiXFVAFemTZ3LwvTfbvLTMjFnm6JSo0y45vCC
         NKlz1D1AGvcc0NwxUSL4SXdyesqyufey3rJnG8PXlqgH2xFRTcL3hL0O+NPOzUTBreO0
         ydjdztT3GK9UszUKAKMk2hP3Vx6rSvxs4vc7Z+6MLZh/MvTd7XDTyTBBdapBDC+2V0WM
         3yWwcb2R0/egYXg3aqzRnLahJd2ZyGW+2Uf/fVZRJ47iJ/DGM7p7TU8ICfTz3IZOLgLZ
         fKig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HC01Z6OLDElwaYfUqlXgjB5pKfu/tIF7xhD0stkkoE4=;
        b=hnnNxSNxP8jS0zf+cr+Osm2zU7ENoKcmMZfH9h5gXQau5xGM/lHmg2nAToeqV0AEVo
         iz8552SuRwiXrEW5Zu9gn4uK518ZNWNSVqELRPgCl9X2U+lRj+M2yJHqyH3ReO48hGpP
         8wjwSHNLF7dNsDCAO5A4SFwXqBlCYZhMn4LanaaMqyH3gymgwQ6UWMfgjm8d5qz4ZWXV
         tPIGNdZ0fw3Buhqd5+dhEIRUTaaGipI+1zMpbYyZObyaUcPKmhjBSUHG6JX/koSnqgug
         pwqJGZn4prpWaf0MR+eWxtsdIL3peutbjrMRpcRB2PgoHT/YI9CbAbgRYQ4PAI3j85M8
         WyYQ==
X-Gm-Message-State: AOAM530rG31DP6NeCByLmAT5RJ237zi4Ncgurre2nJMI0cSxzVJxqQcz
        EcUogcBvEk5qRud9Ea1Um3w=
X-Google-Smtp-Source: ABdhPJwM+0LjznQqykK788nYYpN22ezdQK2v668RvcWSXO5fMQpdt3NfrSE/i4oQAr0H+Naf8jTS9w==
X-Received: by 2002:a05:6402:2cb:: with SMTP id b11mr5506993edx.66.1594741966218;
        Tue, 14 Jul 2020 08:52:46 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id h10sm14583606edz.31.2020.07.14.08.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 08:52:45 -0700 (PDT)
Date:   Tue, 14 Jul 2020 17:52:44 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] serial: tegra: drop bogus NULL tty-port checks
Message-ID: <20200714155244.GC251696@ulmo>
References: <20200710135947.2737-1-johan@kernel.org>
 <20200710135947.2737-3-johan@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0lnxQi9hkpPO77W3"
Content-Disposition: inline
In-Reply-To: <20200710135947.2737-3-johan@kernel.org>
User-Agent: Mutt/1.14.4 (2020-06-18)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--0lnxQi9hkpPO77W3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2020 at 03:59:47PM +0200, Johan Hovold wrote:
> The struct tty_port is part of the uart state and will never be NULL in
> the receive helpers. Drop the bogus NULL checks and rename the
> pointer-variables "port" to differentiate them from struct tty_struct
> pointers (which can be NULL).
>=20
> Fixes: 962963e4ee23 ("serial: tegra: Switch to using struct tty_port")
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/tty/serial/serial-tegra.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--0lnxQi9hkpPO77W3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl8N1MwACgkQ3SOs138+
s6HN4Q/9GbF9ywuYWv23IziNN5Nomf0Lg5LzLc4u2KZiDaVFS94F7kqYc2ZVI189
xKiFdeXeWfKadEcU3b9v8aSZeG+jQyjRq8SjlVa0jwN3pI1MQPEGUHeIKS53rWuy
nmm3csdutYZEP9N4I7WPpgUJkhL8ReY5ycJmgAQT8Pw6lc/ikgg2RqZo8GK/L4vF
DfcXXOGWf0C9rM8FS0Gsm3j0ZEiMNpo2mWqIb58nBZIW0DrYfg+E5CNB3KeVc6ry
BXANwBwth2Np20gcTu29RYClJ+jPIaHLIyoyu/z1JFu4fKuQ8fE+5srm0UqrvKnB
XXsr7Uck2Pp+cIICAwURnkeAdP/81ak27BvPJe+0039CRs0HxrQ8aLbEgfMU+0i+
MoGuqpjYC+HmMEoMDUICoB0WHtHAoaeocUxN7wO45HMei4Vme4yDHrpsVQMeZ3Iw
3SPuGaSPcjRqYnxvkDcMwLpbdj6llcpPO3vf5FGHD8LdgxGTcugz2/n43By1rDLS
+1QitK/7JPf4hvaoBeYvd59GqRSc+oO0chrnHoWODjhC3kqS+VAjdU8bhcJLDEet
GiWN2CqDsKujxrLj8gRqg72YE5CVXriVCiQdkULQz6g4qI9XA1/hP+wWKcJybB6l
FQylj2A4/s1ZU5+APCsrmUlAOWkVYKradW0d0iG8Pozn120jpik=
=O4HE
-----END PGP SIGNATURE-----

--0lnxQi9hkpPO77W3--
