Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A195C433EF
	for <linux-serial@archiver.kernel.org>; Thu, 21 Apr 2022 09:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387713AbiDUJkO (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 21 Apr 2022 05:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384833AbiDUJkM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 21 Apr 2022 05:40:12 -0400
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81EB11A1A;
        Thu, 21 Apr 2022 02:37:22 -0700 (PDT)
Received: by mail-qt1-f174.google.com with SMTP id hf18so2858025qtb.0;
        Thu, 21 Apr 2022 02:37:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9L340xJdiQzYg/eB8Jbz28dOkpWgxBK5SkWFK1V58bU=;
        b=wAiQUes9/Ym8I9MmbrZ5toHOIUtl2Fawjq3EXrVrMK4KK6bhq/TmRXqXOQZTMWyvP4
         nFV0JT9kZ+gjAl2LBYq7SoTdlLc44BD4mTRa/Xsrf2nAtwW1tKfhORjfPGVDl3JRtFEl
         yhhpqpgdG6+WqYsTwJgjy3RiRmoP2KXSoUoFCaNiRz6YQJhVhuFv1UOcPm9kkIvj4azu
         V+Dsi43uZg4b/AgctKPmagxB/e8BI0YrYEpcoaaSmJbiSmRdGA+RjwF0UqksOpk+NXFo
         oqwNBn6MtlwpE+ToRQyYf3XGW3dGSuHx6D25lACq1lPmCPVwmUobnZLnSrLrlAB2/LOW
         y8ag==
X-Gm-Message-State: AOAM532E5coCoc/AkImBZxsuBrgJwy72Hv8sX3Jc6EXDeXbYA6SErHvQ
        lg+qen5w/roohm/V/plwywhJ/wdTNuhL61oG
X-Google-Smtp-Source: ABdhPJy4G6MXJejY8GPLYT7DPpLOz6oixHc37922JQ7sFVmZfb4A7TXN2KEfI36+xv4YcPlWd84HAQ==
X-Received: by 2002:ac8:5f11:0:b0:2f3:5333:40fb with SMTP id x17-20020ac85f11000000b002f3533340fbmr165210qta.96.1650533841771;
        Thu, 21 Apr 2022 02:37:21 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id i18-20020a05620a27d200b0069ecf023d1asm2647243qkp.129.2022.04.21.02.37.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 02:37:21 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id w20so1528323ybi.8;
        Thu, 21 Apr 2022 02:37:20 -0700 (PDT)
X-Received: by 2002:a5b:984:0:b0:63f:8c38:676c with SMTP id
 c4-20020a5b0984000000b0063f8c38676cmr24405019ybq.393.1650533840601; Thu, 21
 Apr 2022 02:37:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220420084255.375700-1-yoshihiro.shimoda.uh@renesas.com> <20220420084255.375700-2-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <20220420084255.375700-2-yoshihiro.shimoda.uh@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 21 Apr 2022 11:37:09 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXvkNa3LXPD4t45HLaVxpqOhAzYpft=o0CrB89NzvG-5Q@mail.gmail.com>
Message-ID: <CAMuHMdXvkNa3LXPD4t45HLaVxpqOhAzYpft=o0CrB89NzvG-5Q@mail.gmail.com>
Subject: Re: [PATCH 01/15] dt-bindings: arm: renesas: Document R-Car V4H SoC
 DT bindings
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Apr 20, 2022 at 10:43 AM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> Add device tree bindings documentation for Renesas R-Car V4H
> (r8a779f0).
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v5.19.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
