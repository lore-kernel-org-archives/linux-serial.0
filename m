Return-Path: <SRS0=fcdp=X4=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BE9C4CED1
	for <linux-serial@archiver.kernel.org>; Thu,  3 Oct 2019 17:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEC7B21D71
	for <linux-serial@archiver.kernel.org>; Thu,  3 Oct 2019 17:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EvjKgRek"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730215AbfJCQKT (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:10:19 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46756 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732585AbfJCQKS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 3 Oct 2019 12:10:18 -0400
Received: by mail-pl1-f196.google.com with SMTP id q24so1718841plr.13
        for <linux-serial@vger.kernel.org>; Thu, 03 Oct 2019 09:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:from:to:cc:subject:user-agent:date;
        bh=v9Xix4ukYpxBHBe1n3DXedqcwTHB0Vaz/YT0zLakIIo=;
        b=EvjKgRekrDRXydliKainNvs1EDKpTaQC9hbAsmM3L4SgVhnCamPwwGeWgzLCmD/6ZN
         YJihKrj4Aua03JcGiXSnnv9gCPNFzimjX/dj6do1v8Tarr4QDToU5Y7qaBlDo7r0dOjB
         7MqZGdDBTEaz9H1tW70rmHCyl63UhJarLzgIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:from:to:cc:subject
         :user-agent:date;
        bh=v9Xix4ukYpxBHBe1n3DXedqcwTHB0Vaz/YT0zLakIIo=;
        b=UxAF6jLyXpMyCioczwmyyKtGrGHKwgnwYDyUk34jOfANdGoibdt4p+KIeuXEC0W/mi
         WH4IC/M5yQqyMTo3V0Mw6vok1nsO2OQdi+sohhJo2mrKxPaSlsAQk/3s1uIQEkx+qpuF
         WuC4Aby53vw7vCNKffl/jmLYFqvSX6izYf+M/oE0vZlVq3ZkrGcLV90xycuS7oeEEY31
         eDqw2sF+PDBzPUbDx0NsWa2DMQeZHPiNiV0Ng1cvmT6a42keTP2l5zunabuAeVD69VwO
         kfymHdbWlkZMgiEeWEjnFzNVQ93wwF0UWCGBf5kZzcy+LcYdtuPhsoTxW5xk9BowKAJo
         sXsA==
X-Gm-Message-State: APjAAAXTPO5XGADlEiLRH8CsaKQPcjCqstxWE25YDqxhHCGyBsY6iiqO
        NxTmWksg77t5fUZGYc24PMAVMw==
X-Google-Smtp-Source: APXvYqwv9TynoMmQOqZjRuUUV4/ZHjd2t53y5sK2b6fAukPfOM6uRj4H5n6IfZmi7UusPIcmhIpQeQ==
X-Received: by 2002:a17:902:ba82:: with SMTP id k2mr9926433pls.293.1570119017817;
        Thu, 03 Oct 2019 09:10:17 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id b69sm3516011pfb.132.2019.10.03.09.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 09:10:17 -0700 (PDT)
Message-ID: <5d961d69.1c69fb81.43b1b.addf@mx.google.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191001180743.1041-1-geert+renesas@glider.be>
References: <20191001180743.1041-1-geert+renesas@glider.be>
From:   Stephen Boyd <swboyd@chromium.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-renesas-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] serial: sh-sci: Use platform_get_irq_optional() for optional interrupts
User-Agent: alot/0.8.1
Date:   Thu, 03 Oct 2019 09:10:16 -0700
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org
Message-ID: <20191003161016.0F5ygzvGGm2P3CQhRUBm5ZBQ8XnA2TQW2Ur8jGMjZMg@z>

Quoting Geert Uytterhoeven (2019-10-01 11:07:43)
> As platform_get_irq() now prints an error when the interrupt does not
> exist, scary warnings may be printed for optional interrupts:
>=20
>     sh-sci e6550000.serial: IRQ index 1 not found
>     sh-sci e6550000.serial: IRQ index 2 not found
>     sh-sci e6550000.serial: IRQ index 3 not found
>     sh-sci e6550000.serial: IRQ index 4 not found
>     sh-sci e6550000.serial: IRQ index 5 not found
>=20
> Fix this by calling platform_get_irq_optional() instead for all but the
> first interrupts, which are optional.
>=20
> Fixes: 7723f4c5ecdb8d83 ("driver core: platform: Add an error message to =
platform_get_irq*()")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

