Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC85C433F5
	for <linux-serial@archiver.kernel.org>; Wed, 18 May 2022 11:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235833AbiERLle (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 18 May 2022 07:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235832AbiERLld (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 18 May 2022 07:41:33 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3C365C5
        for <linux-serial@vger.kernel.org>; Wed, 18 May 2022 04:41:30 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id z5-20020a9d62c5000000b00606041d11f1so1137841otk.2
        for <linux-serial@vger.kernel.org>; Wed, 18 May 2022 04:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=2xn1RzO38VQRiNUGppvJj0NnByQXngHJwYCfzq+4tNE=;
        b=VtlFioB38Iky0Xtib3yb0jn5Koqpc5jiicvSc6wp6IIboRvfyrHyo91F3Y0zUpjx/l
         K0+WTQXLc+EjrLaH4Wco6LIWkiEdAtu2wqENtvqFZMliVaEYTf6M+JT2+p+GI1/ssuc/
         E9D98phVjaLbJIBSMdgoHSXiHDP0SNZ5PC48xnutXdfctMD0AI0Pd1oYgQAqXhdDIs8R
         g0lvRHESu/GjPacsN6bdWYmfegM5uefd+sunTuxKeCrvdo8JTTl0TZzrcPOcI5lN5Y3J
         6a2ZlKowTXqQ9EUrMAuA7yOA3D61nnoI0xGtZzCA3+7yt4p8HyBX3lqs9P8pwYqwRuQu
         8rdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=2xn1RzO38VQRiNUGppvJj0NnByQXngHJwYCfzq+4tNE=;
        b=nWADHv8bbL1ptzrFxChktThXGo5xPaVDijA6i93AhZXnFiky1aEfZ03fwmt/8um2yw
         rLQIuD0OfQT5BjgfhTrW2Tfk9wJH6PcYscRntvWDXQC40LHmZSCLls4gfglN3aPWsWvP
         o47mJqVt5Kqt/STFn8FtxnVveKokFedWaYM0MHic1c3BHHSjccqkfhOiZUffTCccQ0BN
         GkpUsilDcjI9zSJ5X0txk9PegcIP59YMpGQ0gdMUDg8RgaoD+qhQ/t46YkEoFqU9av6i
         vrI4/G5mqyOTk8bTJrgPIb7/JtVq2AhDbiva692O0VJSnvmFsxUem5YC1nYA6JJULfLl
         3Lmg==
X-Gm-Message-State: AOAM530lXqg/Rl1L9UPGk/JHo7pqUVVzE8UVBca3gMUXPdQE+lLHyuSV
        shLmw9v+Uw5GAaqfP55y4vzhPk7L6zOVgftDuzwibc+LT9o=
X-Google-Smtp-Source: ABdhPJzusjXhBrztPnsp4z1RaFBZynItcAx2I/RZLQRkhRJhbX2nuua+ahiOJz2SwQYsjDoZaRWxXvpKb4LxZ1jYHKM=
X-Received: by 2002:a9d:f0a:0:b0:606:1e5e:8bc7 with SMTP id
 10-20020a9d0f0a000000b006061e5e8bc7mr9829627ott.258.1652874090014; Wed, 18
 May 2022 04:41:30 -0700 (PDT)
MIME-Version: 1.0
From:   Belisko Marek <marek.belisko@gmail.com>
Date:   Wed, 18 May 2022 13:41:18 +0200
Message-ID: <CAAfyv36U1A21pOOnrUyZ6tKm087dAbJ5kjpOQj6L8kHYBZGmvg@mail.gmail.com>
Subject: custom serial driver node not created
To:     linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello,

I'm writing serial tty driver (it's SPI/UART converter) and I get
inspired by this driver:
https://github.com/raspberrypi/linux/blob/rpi-5.15.y/drivers/tty/serial/sc16is7xx.c

I have driver probed and also added port to driver which I see in console:
[ 2616.826105] spi0.0: ttyTX0 at I/O 0x1 (irq = 0, base_baud = 9375)
is a test_driver

so I should see it in /dev/ttyTX0 but it seems node is not created.
Udev is running on a platform.
Any ideas what can cause this?

Thanks and regards,

marek

-- 
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
Freelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
twitter: #opennandra
web: http://open-nandra.com
