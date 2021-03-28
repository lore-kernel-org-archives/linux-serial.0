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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F130C433C1
	for <linux-serial@archiver.kernel.org>; Sun, 28 Mar 2021 21:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64D346195E
	for <linux-serial@archiver.kernel.org>; Sun, 28 Mar 2021 21:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbhC1VZP (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 28 Mar 2021 17:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbhC1VYk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 28 Mar 2021 17:24:40 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF9FC061756;
        Sun, 28 Mar 2021 14:24:39 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id u21so16356688ejo.13;
        Sun, 28 Mar 2021 14:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VOOl8ErxBPJ+MgHS2Kc6EjQi+pHkac3A/x3zjS/xmr4=;
        b=J3+NAYWxzl9lECtWZwfBVuMBNSU1YAcpsSqHrUrMzB4Wb4nxPYcGQi5hZDUKfA1ZC5
         KPWS2U7Os0GI29mtjO2+0AjGNbgUfe3xqd4bgA20hJZTsIjILLtElOFhQO07sxoWuhle
         WN0PptMh2cDt6R8QbznycVbe18feuY4WtrGUYkrgdHvorNfw3dGHZume5D8Vihu49/W7
         E8AmPbqDv5OdOJ5dXQYstPXT1+g+RVKKiI2lTKfyy2Ctw1aPt7wjcUuS8G2qrg7zR0tm
         iXNcqr3pKMyeYnYRMEr8AKbgQ6vMlw8L3zxotSQZg15lvljlkFZCGd+qH8jxi4g2hfhP
         YxbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VOOl8ErxBPJ+MgHS2Kc6EjQi+pHkac3A/x3zjS/xmr4=;
        b=F6Ef+mVKrDu8zt2hm4ek0rjCGQp74VnlJ5c5Z7Kw7ylaTKMmrJopV5iNAF/J5GLaY/
         z8M1TZBSjJI/QGXtkCKNSxRHHibc1p8xCBzg8FmWIgVA2bxV/DAJqFLOyUzmqrYPa1pM
         1nUAv2rH97abS9QFIzaWlQSJt94QQGsQHpQl52fx34Ab55LJm4+EdO2O1esXbwmCmHH5
         Js+5NngxIsbLtjsFoxg0J1cidxBPdsIs2wwn4BI0l5VzeOSJInMnFtQC1WTYL87Kx5DX
         sKRQyPfQw40I+R+xrAGuSPGhLQJACkyO71UUhXel1KebZA0U2l4n8RybvHfAEnisfWw7
         fD4Q==
X-Gm-Message-State: AOAM531kO60PkBhDu4YClp6bdFYSXzdXLuIye4rmpD3b+7uflwWH6Iqf
        YqLGnhCv6kQLKl34wMMvsuBln7n8A3Ikfo5vwYM=
X-Google-Smtp-Source: ABdhPJxlBNQj9N4H3RLgqryBwaxCFGh6FH+L/AHqGXOl8bxIbiyTs/KSqTOor0E2c1ryHt/opy9mPi/6q2NoT2clB1E=
X-Received: by 2002:a17:907:2716:: with SMTP id w22mr25634218ejk.328.1616966678759;
 Sun, 28 Mar 2021 14:24:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210325152410.1795557-1-narmstrong@baylibre.com> <20210325152410.1795557-4-narmstrong@baylibre.com>
In-Reply-To: <20210325152410.1795557-4-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 28 Mar 2021 23:24:28 +0200
Message-ID: <CAFBinCCGUSaFpsey=hux=EkZnKAG4YXUUEt08tBVwrd1NHPHxw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: meson: set 128bytes FIFO size on uart A
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     gregkh@linuxfoundation.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Mar 25, 2021 at 4:25 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> The first UART controller in "Everything-Else" power domain, usually used
> for Bluetooth HCI has 128bytes FIFO depth.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
