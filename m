Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D192C433DB
	for <linux-serial@archiver.kernel.org>; Sun, 28 Mar 2021 21:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38DB76195E
	for <linux-serial@archiver.kernel.org>; Sun, 28 Mar 2021 21:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbhC1VYk (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 28 Mar 2021 17:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbhC1VYR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 28 Mar 2021 17:24:17 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777FEC061756;
        Sun, 28 Mar 2021 14:24:17 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id ap14so3280895ejc.0;
        Sun, 28 Mar 2021 14:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h8X3xkCb2iKB1gBnb2OIJ1fkuZbHQANnRKaUSTzssmg=;
        b=ESp1OIAIKANj6P4M6l2SRGboimfHCB6ez6cMjR5+bnW41ngioW7pLqCe4Nr5o8WPr+
         nw1AX2EFcyldrHMQslSs7QQP+/XPZQPvNURDiR22UA8jPEfLwta7Icid6eSeWVPss9dH
         IFBv21gGNGwQZ+Cr129IDO75lofg6HGgLPDy4y0NBhdVe0iW6AkOnjyS6OUFMRmBPA+C
         Vkt7E20tE4bgZv4MOc5XA52IvweWuGCAkCyKHrgRtYQrs8tXfIaOfR2frcrFZVAUfQuB
         eq1HBc8KwmgMak16il8V0p82DAjML0EajwgZrYN8+Z5pWzYAdICjxcp4gDNwH47k8T0U
         3BBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h8X3xkCb2iKB1gBnb2OIJ1fkuZbHQANnRKaUSTzssmg=;
        b=PHNxsyVaT/W6suAxunbZXhaOLqXsMHF7WNBKR6c36XmGYJnS7qW4kj8HH0XpmoxD/O
         VICH1eVauiiRoMXpW4krAqHCuNUzDFpkr+O97TVxy8UfedNal07J0/xgX4sQt1JaOQ+t
         k5ZljEzcnadqFYUPAVycFBpEayfhQq3ctCr+xjVVLof9JPLpuQyD+W8EpWeYR5E5FYCF
         feTBxWKJcnZ+IRszMUTVIH2+Qw1Kbk3RY4MDVLyeLn/9MuDIy09uzi6ZG4pNbsD3bPmU
         74XzPoToktXvgzLtOMBdVHNnj75iPfbLuChcgUjDkJ7KQFHMbMhXQNE8jEiFWRBGLKDW
         vTtw==
X-Gm-Message-State: AOAM532GIr+BxggRrwlRV9oky41K9SMzVyUJE+t4SecjTK4jiMaNLiAV
        ODe1aick7CnWzp1aOioJL8x6L9eXQgFfomhAX+zKhQ53+XM=
X-Google-Smtp-Source: ABdhPJwO88tlg8QBHREqzsFMcEe9Jhi5Z9xZo47eaL0S4suKjsU2w2XhA5xvl8Lf4/MlD1zHmY0pKal0XDGBU0uXrLc=
X-Received: by 2002:a17:906:52d0:: with SMTP id w16mr25472016ejn.172.1616966655864;
 Sun, 28 Mar 2021 14:24:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210325152410.1795557-1-narmstrong@baylibre.com> <20210325152410.1795557-3-narmstrong@baylibre.com>
In-Reply-To: <20210325152410.1795557-3-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 28 Mar 2021 23:24:05 +0200
Message-ID: <CAFBinCB0_xonzPnZck3Ji6x9x12uLshDYo29nnEjqh8unn_YyA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] tty: serial: meson: retrieve port FIFO size from DT
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     gregkh@linuxfoundation.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Mar 25, 2021 at 4:25 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Now the DT bindings has a property to get the FIFO size for a particular port,
> retrieve it and use to setup the FIFO interrupts threshold.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
