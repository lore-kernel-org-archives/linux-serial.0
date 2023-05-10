Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53428C7EE22
	for <linux-serial@archiver.kernel.org>; Wed, 10 May 2023 06:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235195AbjEJGLR (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 10 May 2023 02:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236161AbjEJGK4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 10 May 2023 02:10:56 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FFA40F4
        for <linux-serial@vger.kernel.org>; Tue,  9 May 2023 23:10:40 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f4c6c4b51eso911875e9.2
        for <linux-serial@vger.kernel.org>; Tue, 09 May 2023 23:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1683699039; x=1686291039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dF6pa9jOL+FS7sdVMkryy+XB+jWacnITy30HAcpROQk=;
        b=sYyonTPDuVD12f/fRHqYxhmS4ZV0pC4hkHkJ6WwnCLZjoQW+mEnk2DitOpbXpw5Nub
         AakkPdsTHP2M/niggFjawLcQ9I/B/QGUX6B7Ons+ZhViohhr10jRRYNQfgQ91Pwb39C+
         NvGrOyOuw8m8Ha0DsqXLBsrk5BSt5FcU9U/uGmgOi6hPKyr4GvtEy8oV8ZypI7HKeCno
         U0xmbByQ7D/1KG9F0pOzIdjVZUKWYEPgx4IQckQERhwBLiZaEwHbK9+vo8rRSvy8yTno
         gdhbvJwFnohLfb5OPC8Wrx7FJcFESybuMkjsfCHkOV0wQ9TGS0XckhTD8jDRPQPSjf3i
         p69Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683699039; x=1686291039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dF6pa9jOL+FS7sdVMkryy+XB+jWacnITy30HAcpROQk=;
        b=PdP8dlyj4EjM7H23111GcHLUQf8/N8ZWYqrXvdYCF4Hvygu92IaPP99BWzSmCvFcFN
         9YkfjpWaF2u5Q9MAJ9F8jbky/jLrc5Wt4BQz544TmZ1b9lkZ4ZZcoYPKSL5dLTXmhtDl
         X8P6c37HAUhHo+f8AfirLl6hoB3Oe18d7AL00HR2IYllmpOPHI55qb7lZ9YIOq1ji4PK
         /rkNlfKZBzQ8fspeVYvFIw9uSANk28ViM7WejeuEdoiZBxOj7tkF4Wz9ZuPu6Msx475p
         YoHQh2pt1/wiP4nEbhxehcNzOYUmZkSPA6qLsaCfqcx28dL20wxlfM5Uva49cWsZghaR
         AuhQ==
X-Gm-Message-State: AC+VfDwIuf4r8RXX0QITUIy1AqV2KS1urx42/abCOWfpC7XXqyyMjd0P
        r0agFTlh2Jht+pcSD9RAZRY+51Kl3vJ10ce7qiuwcS4IMw1pJak0
X-Google-Smtp-Source: ACHHUZ5h/hKJcCSMOATO3TWn2+Pew1ggT0AjsCAr+Xf1zU8r/ZTlkjNEafbkGI660Tjoga1A1wtCDO8cAPrOei90ovQ=
X-Received: by 2002:a7b:c398:0:b0:3f4:2907:20d8 with SMTP id
 s24-20020a7bc398000000b003f4290720d8mr4534823wmj.36.1683699039337; Tue, 09
 May 2023 23:10:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230405111559.110220-1-lma@semihalf.com>
In-Reply-To: <20230405111559.110220-1-lma@semihalf.com>
From:   Lukasz Majczak <lma@semihalf.com>
Date:   Wed, 10 May 2023 08:10:28 +0200
Message-ID: <CAFJ_xbqNu3=_jq0HADad9zj+F=TPa4zCoi_8y6Fp3FjymQLkrA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] serial: core: fix broken console after suspend
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        upstream@semihalf.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

Is there anything more I should do regarding these changes ?

Best regards,
Lukasz
=C5=9Br., 5 kwi 2023 o 13:19 Lukasz Majczak <lma@semihalf.com> napisa=C5=82=
(a):
>
> This is v2 of a patch[1].
> v1->v2:
> * Fixed typos in commit message
> * Tested[2] patch "serial: core: preserve cflags, ispeed and ospeed" on a=
ll
>   current LTS kernels (4.14, 4.19, 5.4, 5.10, 5.15, 6.1) and on top of
>   6.3-rc5 with positive results - console was working after resume
> * During tests another issue was observed  on 6.1+ - FIFO not enabled aft=
er
>   resume - and an additional change was needed ("serial: core: enable
>   FIFO after resume")
> * Test procedure:
>   1) ensure the console output is ok
>   2) suspend device with "echo freeze > /sys/power/state"
>      (/sys/module/printk/parameters/console_suspend =3D=3D N)
>   3) resume device and check the console output
>   4) suspend device with "echo freeze > /sys/power/state"
>      (/sys/module/printk/parameters/console_suspend =3D=3D Y)
>   5) resume device and check the console output
>
> [1] https://lore.kernel.org/lkml/20230301075751.43839-1-lma@semihalf.com/
> [2] Test platforms: PC with i5-8400 + GB H370M D3H
>                     HP Elite c1030 Chromebook Enterprise i5-10310U
>
> Lukasz Majczak (2):
>   serial: core: preserve cflags, ispeed and ospeed
>   serial: core: enable FIFO after resume
>
>  drivers/tty/serial/serial_core.c | 57 +++++++++++++++-----------------
>  1 file changed, 27 insertions(+), 30 deletions(-)
>
> --
> 2.40.0.577.gac1e443424-goog
>
