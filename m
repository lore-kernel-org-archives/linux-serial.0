Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84896C47092
	for <linux-serial@archiver.kernel.org>; Tue,  1 Jun 2021 17:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69D5B613BC
	for <linux-serial@archiver.kernel.org>; Tue,  1 Jun 2021 17:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbhFARDb (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 1 Jun 2021 13:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233657AbhFARDa (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 1 Jun 2021 13:03:30 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B38C061574;
        Tue,  1 Jun 2021 10:01:49 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id g8so14393625ejx.1;
        Tue, 01 Jun 2021 10:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2tdMgHdLMp8IM7jC5IZbDKAnduWAjqHcLkrz4rLbVJw=;
        b=QDdsypDCBWSpFP51Zlk6K05ivWsdZ1K8t0n4IJAGOXbMWDV8hi7GNHTjJlB42ZsAfl
         R2z5gR6Q+L2utD5SGVPceGs+pSEH0PO9Nn4L5QjSiRkcRBfajFfUxr8QSukj7GII/wmI
         TiWLb2HcZaCFYy4ssXTFmXjncL404VnccboE66AKuTs0UA3FT65QsIUqYW+jGKOuFLku
         Rwn8LAsx5YiBH9bgCrU26BKzoJR/bMTEEt3pEXAOD8yQqRf5fh5TugQWMQ5/5AFWurAJ
         oNpvwYi62e5qT8dN8o9mKW/nkRAqDbKF3AtWF+LHktPtsOkjCgOep4p5ODG1TtDi/UbO
         Eqnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2tdMgHdLMp8IM7jC5IZbDKAnduWAjqHcLkrz4rLbVJw=;
        b=RFb+RYPRz9FJqevKAQIvarzaz2Cd+XU282wzQMJ1I7f+6suGCrN5Z8ieox9NBNRlyy
         SZ5EU9gNf+EDpRD3mQlQucIreaSWj4jTJO8f3g/0i+z5+D6ipe53qYEzNqFQTATiAony
         Obpm9aWwalKat67/Ko5FOR4jULTFNpMjeLW+KUPvMVeL6NtIMRud1PNoC+1riAKf+fX8
         3qWg/99YsLO77YYmLBZXK5M/f7wdLGSSWCm1MzlRxVXsOu9komnaeu9LwQiJoL9IKCzd
         uvbq3AmSo15XqntWb40lkmax15bAXvy3M1EL423qOreUzLplGuPVBSL8+/MAW46ZWtiD
         GkMQ==
X-Gm-Message-State: AOAM533M6F0vrmf+BCNBiyEVJqurcWf+zYE0SYkyCK/wsQzeZgoor9VV
        2vDdjUcaTKHE86gqwip/who=
X-Google-Smtp-Source: ABdhPJwoOSKSObg/Q1BlTqp32kvrk7vm1rJBgG4cFo3gK8+/oOwcvuVnHoe7kLfp9YjCuu18EiDL/Q==
X-Received: by 2002:a17:906:68ca:: with SMTP id y10mr30440536ejr.318.1622566907733;
        Tue, 01 Jun 2021 10:01:47 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id n16sm8975571edw.26.2021.06.01.10.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 10:01:46 -0700 (PDT)
Date:   Tue, 1 Jun 2021 19:03:22 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Bixuan Cui <cuibixuan@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] serial: Add missing MODULE_DEVICE_TABLE
Message-ID: <YLZoWn6LCEaUNDuk@orome.fritz.box>
References: <20210410035048.11466-1-cuibixuan@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Lwqq355qEDBFtGXa"
Content-Disposition: inline
In-Reply-To: <20210410035048.11466-1-cuibixuan@huawei.com>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--Lwqq355qEDBFtGXa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 10, 2021 at 11:50:48AM +0800, Bixuan Cui wrote:
> This patch adds missing MODULE_DEVICE_TABLE definition which generates
> correct modalias for automatic loading of this driver when it is built
> as an external module.
>=20
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
> ---
>  drivers/tty/serial/tegra-tcu.c | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--Lwqq355qEDBFtGXa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmC2aFoACgkQ3SOs138+
s6GFAxAAnBm85h6fWfTsi9P5POEipLrTGS16ajaYbFY97eoZOoNN+9kQ5G8Sgjnm
ZHFP3lRdaZ3mS79/4yRZLE7shtxZznMkp/PySejDdlt49Kpt4/iezlGxRbmu/vOQ
lJWU2ixlmORR6WBtRutsWb/tLVqmwWY/cpeZFxaJvOqj6izaDTKnPfoXtth18YHh
rWCyzMz+vLbzOj/3iKQe0W7skN4e4RAbhohFBpkWD/ZFNSREe5WBsAUNJOKs3o4S
X6sfcDWwsJoPqZsSF80ZZUmVkcHfnaUwppAZUTA5L4+gz32b5z9Pqol+277Qq8A5
WnYfdgES15Cihfi4/1LyzcpNWdDRygg2KKF4AkkuwlJJzwLHLny4Ac3QtCzoC+QM
mOGvUgBktBHTHaTOgX5lYVxTas51Bq7g4WHksxmT1LYZODhKWIqn6qSd7JxG9+C5
LFSbcu/ubQbbLUnBOF4Pn5hAwiUOXAxRrhxQE5w72n9tsOrrEHqla72fBPHaiogz
EICGk0jp6yv12Qz8DC8YSwArTDneBy80hl9jojO1HowBBrjbZZF5jIiUJtT8LyT1
/pAgBMeqOsYa5F4Wu6fcNYCOi4Za2ikNgyFbKPb49yX0o+J7lFyg29HxzGu2Z/LI
K/P/cbQgLemXPXmrViRgOQ2asN+HejWeAqJ3eQY4GLfVS/fxRQI=
=PePe
-----END PGP SIGNATURE-----

--Lwqq355qEDBFtGXa--
