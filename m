Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A31C54E94
	for <linux-serial@archiver.kernel.org>; Wed, 25 Jan 2023 00:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234644AbjAYAZf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 24 Jan 2023 19:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234641AbjAYAZd (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 24 Jan 2023 19:25:33 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937B851C7E
        for <linux-serial@vger.kernel.org>; Tue, 24 Jan 2023 16:24:53 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id b6so12392362pgi.7
        for <linux-serial@vger.kernel.org>; Tue, 24 Jan 2023 16:24:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:to:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gsxQDYJ637mVBncELdhv1LGROnJJn7ORrONb7PiHKCc=;
        b=V8Rh6ixAbXeAODu8AB6JbTXML21LyR51xoPSmNj5QN5jB0SX4krquhGTt2iwT4W0WT
         gjZc4BdHYbyn/ESs/+PNMob23ftZ3qfUcxiUd2D16MFpPU9qd31C4nM6X7oFlDorUuPf
         3Y8LuGbLRsuGByfFEIsd0YMZgqFIHcDFz03m14TsGhtWr1RoOb8uW3Ryk6HJdUHfdzjE
         ao2HyEaLstfhdO6ZLJceuTzocIzAOpTxYwX0z48OMxGbwJAKnlLv0FtURES84+BJDry3
         Sxce4VfCmxdBr8g1v+IqoOGouG5AT1j2+nNiR8mvHixTyApxVbVu7HDvs8DLUZTAB7oV
         dSVw==
X-Gm-Message-State: AFqh2kqOKdUvS+vY+KFFFAkVR0oUXfp9b7+k2tNUrD/x8+hP6OGfAKRi
        Y/4k8OwOuKIUzZdZ+9Sg2tZRtg==
X-Google-Smtp-Source: AMrXdXvMasxXa5cS8AxFhZik43b2HxYo623z8Gih3oj35j/s73J/68oDQhdvnDxZluU+a6gJZxOL2A==
X-Received: by 2002:aa7:8204:0:b0:58b:9473:7ae0 with SMTP id k4-20020aa78204000000b0058b94737ae0mr30892444pfi.32.1674606232659;
        Tue, 24 Jan 2023 16:23:52 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a28-20020aa78e9c000000b0058193135f6bsm2202152pfr.84.2023.01.24.16.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 16:23:51 -0800 (PST)
From:   Kevin Hilman <khilman@kernel.org>
To:     Bernhard =?utf-8?Q?Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tglx@linutronix.de,
        maz@kernel.org, lee@kernel.org, linus.walleij@linaro.org,
        matthias.bgg@gmail.com, gregkh@linuxfoundation.org,
        daniel.lezcano@linaro.org, chunfeng.yun@mediatek.com,
        angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, nfraprado@collabora.com,
        andrew@lunn.ch, gtk3@inbox.ru, sean.wang@mediatek.com,
        zhiyong.tao@mediatek.com
Subject: Re: [PATCH v8 0/9] Add minimal MT8365 and MT8365-EVK support
In-Reply-To: <20230123163833.1007181-1-bero@baylibre.com>
References: <20230123163833.1007181-1-bero@baylibre.com>
Date:   Tue, 24 Jan 2023 16:23:47 -0800
Message-ID: <7hr0vjh370.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Bernhard Rosenkränzer <bero@baylibre.com> writes:

> v8:
>   - Add binding descriptions for mediatek,mt8365-systimer and
>     mediatek,mt8365-uart
>   - Specify ranges with parameters for u3phy

Built this series on top of v6.2-rc1 and boot tested on mt8365-evk board
locally.

Tested-by: Kevin Hilman <khilman@baylibre.com>

Kevin
