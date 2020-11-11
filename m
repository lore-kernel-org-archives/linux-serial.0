Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C86AC388F9
	for <linux-serial@archiver.kernel.org>; Wed, 11 Nov 2020 12:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CF1420709
	for <linux-serial@archiver.kernel.org>; Wed, 11 Nov 2020 12:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a802Ccfg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgKKMhB (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 11 Nov 2020 07:37:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbgKKMg7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 11 Nov 2020 07:36:59 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0E6C0613D1
        for <linux-serial@vger.kernel.org>; Wed, 11 Nov 2020 04:36:58 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id s30so2958107lfc.4
        for <linux-serial@vger.kernel.org>; Wed, 11 Nov 2020 04:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Z/RLrQiMTHPq56fnlrRSCpv7SZDjk7H+db3bzm7aFN0=;
        b=a802CcfgkzvTLYQcN5Oy3W60s6AXQPMEYPsKTPgYv1UzxaolTTp6fKMBlZU4pzenmO
         u4sftRc3ZcRStVJvCxrmY+HtqPGAHdlHMvCIGlQRztswk/93uVZ3lvgSBfOXgD0fe40I
         dFmXsu9vABBrMJluiPwXGKOsYIWpittnHSksZ9REqPE2GggfpOJJ2lX4d7leY6Z0047F
         MT47a06dvA+b4vXNh73leh4fXJnOd4Cd5ER9AJQrCL/FgU0t2UrYiepW7RJyrtfTNjri
         zy+t+eM37SJPhdWdudEfoC1/KCkMyJbooDFsEWXtm2YFEAcsWvn9xcMxWtkLjOXGY50/
         3/JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z/RLrQiMTHPq56fnlrRSCpv7SZDjk7H+db3bzm7aFN0=;
        b=lp1zzR4iiU+jxE8/0otRzU5JYbpoRc2at1TOAo1z/xs7K6tJ9P4cLbOmLYmdQdJTj+
         9rd7TbEkeegF0IQ8Dy7U5wwcea21ZVEwKs0ShUkeWmy8JV7/+GM5KRk/rZm+sev4R3Xl
         67jELT675UnVzg2D/Gxj9VzJ81/xNCsvPzIAvInWy7dvNE5GZVkcnd6rAyRQdkEjXbDc
         wEDgUs6JxabtXyu1wQ+rrquBLZ5DwGm2YOjCmtHW8h2jJxODamFKkEzq648lG51if0iD
         Xi2HrVPLuv5fwmJxYp5pwMm/ufprrSzv6+1e7Zs73t7HOwDJKP9XYFG4hbru32dIm4TM
         aBYA==
X-Gm-Message-State: AOAM531ewtpdE0RXr4cRegoryp+ceF+IJ08yfSJO+mL/kymsc0eqVLkJ
        sV5eNJpj23kxaaq5rpWL97L2w5cEaFoQ7d5YJggLuy4VWj8=
X-Google-Smtp-Source: ABdhPJzUys+r2xwiUiIqMf4HztCdGVrrxP9z8YQP37ir7r8EtrbyRyIhdfDNxaKaoyauNOnBIXKhtZlGRzOcgyz+wlo=
X-Received: by 2002:a19:8353:: with SMTP id f80mr8608246lfd.348.1605098216726;
 Wed, 11 Nov 2020 04:36:56 -0800 (PST)
MIME-Version: 1.0
References: <20201110214840.16768-1-festevam@gmail.com> <20201111095701.rnsuajzfgkstiwa5@pengutronix.de>
In-Reply-To: <20201111095701.rnsuajzfgkstiwa5@pengutronix.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 11 Nov 2020 09:36:44 -0300
Message-ID: <CAOMZO5BNdtj15dmJ3xciSrhODs-XYcPOaO2EEUQCxWxBc3bJyA@mail.gmail.com>
Subject: Re: [PATCH] serial: imx: Remove unused platform data support
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-serial@vger.kernel.org, Fugang Duan <fugang.duan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Uwe,

On Wed, Nov 11, 2020 at 6:57 AM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:

> Is it a problem if you build with SERIAL_IMX=3Dy, COMPILE_TEST=3Dy and
> ARCH_MXC + CONFIG_OF unset?

I tried your suggested combination and it built fine.

Regards,

Fabio Estevam
