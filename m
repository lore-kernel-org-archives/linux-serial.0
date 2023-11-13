Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8807BC4332F
	for <linux-serial@archiver.kernel.org>; Mon, 13 Nov 2023 10:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjKMKRU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 13 Nov 2023 05:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKMKRU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 13 Nov 2023 05:17:20 -0500
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6630135
        for <linux-serial@vger.kernel.org>; Mon, 13 Nov 2023 02:17:17 -0800 (PST)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5a7eef0b931so48904897b3.0
        for <linux-serial@vger.kernel.org>; Mon, 13 Nov 2023 02:17:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699870637; x=1700475437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p9k2DHjxp1qiXwaazh58YgAuDhQ8ib4KcEzl6Yg5CNw=;
        b=wqV7SOoJ/jACeAr5Q3CanewKeBh6YOIyeKZGqmwBSpXMl+85wXz6RaySMLYqV67bim
         Z30WWl4P4Ayx6Ef4Y+lR34g6xJVFipGhgS3teGstFNrOkYWKfxwQBpJJSJK89ky5OisC
         s12isHJuI0C7bZh8mkcSvLvw7uxtQIcRU5sSpAr+s8kO1TuL4b7f1EzTE/QhpTm1aFjD
         2+/gCLBfbdY7WVxfaO3t6X8cDGnQlXDsFAaSZloAvkuofE/nwwQN99bq4bWI0lbJDzaE
         NR82xB+Jt5kyYytFAgK9a3BquT9I/7jEqr5/zCKoDN4mEWOnZl6XyjUNVbBDG5xOxOu9
         B+Iw==
X-Gm-Message-State: AOJu0YziYMZHL22MkJO3RTTI8kTp1sgYPhS3k1egbajBdanRZyqXjY88
        +EZqhMfK9O+gTtyud8Jsb5JFLTgCO+E9/A==
X-Google-Smtp-Source: AGHT+IEBt+eFigkOvdbDHWy3k5wIAec2P28aYB5uNa3ORZeKWxnKL54EBIftH+wP8mHYk5SG2MDu+w==
X-Received: by 2002:a81:9207:0:b0:59b:fda7:9d7f with SMTP id j7-20020a819207000000b0059bfda79d7fmr7125680ywg.49.1699870636716;
        Mon, 13 Nov 2023 02:17:16 -0800 (PST)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id a64-20020a818a43000000b00586108dd8f5sm1708474ywg.18.2023.11.13.02.17.15
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 02:17:15 -0800 (PST)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-59b5484fbe6so48695987b3.1
        for <linux-serial@vger.kernel.org>; Mon, 13 Nov 2023 02:17:15 -0800 (PST)
X-Received: by 2002:a81:8306:0:b0:5b3:22f1:e42f with SMTP id
 t6-20020a818306000000b005b322f1e42fmr6718857ywf.26.1699870635086; Mon, 13 Nov
 2023 02:17:15 -0800 (PST)
MIME-Version: 1.0
References: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de> <20231110152927.70601-39-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20231110152927.70601-39-u.kleine-koenig@pengutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 13 Nov 2023 11:17:03 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWf6=hHAcvkN7x4V0-sjuX59OOKHxKMbHKunb3Dbnpx3Q@mail.gmail.com>
Message-ID: <CAMuHMdWf6=hHAcvkN7x4V0-sjuX59OOKHxKMbHKunb3Dbnpx3Q@mail.gmail.com>
Subject: Re: [PATCH 38/52] serial: sh-sci: Convert to platform remove callback
 returning void
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        John Ogness <john.ogness@linutronix.de>,
        Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        kernel@pengutronix.de, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Nov 10, 2023 at 4:30 PM Uwe Kleine-König
<u.kleine-koenig@pengutronix.de> wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
>
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
>
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
