Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E660C6FA82
	for <linux-serial@archiver.kernel.org>; Wed, 14 Sep 2022 12:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiINMnt (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 14 Sep 2022 08:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbiINMnp (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 14 Sep 2022 08:43:45 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4874E6F549
        for <linux-serial@vger.kernel.org>; Wed, 14 Sep 2022 05:43:44 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 29so22054470edv.2
        for <linux-serial@vger.kernel.org>; Wed, 14 Sep 2022 05:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=jH4ZkF5EGYcmclxCWfALnPu3pTX8M84cMeEEmdJqF7Q=;
        b=s+RgiYNn1A9TLZ03WWu/3F7/+j2PfnMrcM4JwjKH5zxbtCW86E50h8lKjQiwZ9Y/M9
         qXTDAwB8It6y3m6ldyLMfOtVxCp1wZYiMRuJzHeel2C5C8ryAqsiGlBAJZ1AAw6LtIIb
         OsvWvASU912DGyPvPi+SUVLKvdFPfCgQyJaJWuQUOvhot+PufRABkVaUtCuuQRa9oCUC
         Y7s8kHIhwg8v8brUDEGGq4c3V87NOaxyk3/WNwFpjSZQRXwLceKuDfDGOAcM4DQZcjL5
         0dSrxOQuwLd5ZUJwRfwPgki47k9FkbRrZ9DbcEwExdV0UTJqlMZ4cLXiu8C2JTaluMCW
         sijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=jH4ZkF5EGYcmclxCWfALnPu3pTX8M84cMeEEmdJqF7Q=;
        b=w6ipF+FT8r7Mj4etWYRQo7LZjMcAo4EaZj+vncOedVwYsld3CsCzEkj2XFLfjJ1YsL
         FTKeNXzN5TpsjqPoNZCKu8m0lKVqqw/3cUrWhflJrEq8/deeImnBSJIYqXp0m36iVLL9
         0RiwwEwG0KOXvLzQFwBVsNWlviwAES2qyEkHGNkcHg/R2yEaEQnLk5gsuIZiBBvn3MaV
         zcNPJ6MgSSBm77jl66i3jxi0IyFTYSIc5Y75vyasfI8TCoqb10ig5zUvuBgtKPUGCFOH
         lNRPvvj+cb6DD8ihagMdNIoZFotGoxHtpx1KKlgL4MjEx1ID/yoXSmemYuH7/FmG9mBR
         8PQw==
X-Gm-Message-State: ACgBeo0W4ad1hGs4sQeeLAkdvOEg28GEmnGC8TgiIbg69Nem/ZAV3E8l
        oYcLV2wa4J/VQCAKDp6oe9goZEPaRKmQ3RuM6rvsQFGekxw=
X-Google-Smtp-Source: AA6agR7wPtBAwe0E7jAMANiedrq7hYoetxPIBoeZ3zEubqBlLcCZqJ9J4obL2RCDbp8OOCnsdmqCt6hWR5n/qy2yeT0=
X-Received: by 2002:aa7:c84f:0:b0:446:2bfb:5a63 with SMTP id
 g15-20020aa7c84f000000b004462bfb5a63mr30455779edt.172.1663159422910; Wed, 14
 Sep 2022 05:43:42 -0700 (PDT)
MIME-Version: 1.0
References: <f191dcca0d8ea03598c463fc0d3fba8941ff2275.1662888075.git.lukas@wunner.de>
In-Reply-To: <f191dcca0d8ea03598c463fc0d3fba8941ff2275.1662888075.git.lukas@wunner.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 14 Sep 2022 14:43:31 +0200
Message-ID: <CACRpkdZBs1bR_bWuoTHG1s-Rq-qZ1JVTKUdCRCxj1k9fYROhYw@mail.gmail.com>
Subject: Re: [PATCH] serial: omap: Disallow RS-485 if rts-gpio is not specified
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, Sep 11, 2022 at 11:25 AM Lukas Wunner <lukas@wunner.de> wrote:

> The serial-omap driver requires an rts-gpio for RS-485 to work.
> Historically it has allowed enabling RS-485 even if no rts-gpio was
> specified in the device tree.
>
> That doesn't make any sense, so disable RS-485 on probe if rts-gpio is
> missing and disallow user space from enabling it.
>
> Three NULL pointer checks for up->rts_gpiod can be dropped as a result,
> simplifying the driver slightly.
>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: Linus Walleij <linus.walleij@linaro.org>

LooksGoodToMe
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
