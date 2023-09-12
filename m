Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4426CA0ED3
	for <linux-serial@archiver.kernel.org>; Tue, 12 Sep 2023 08:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbjILIz2 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 12 Sep 2023 04:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbjILIzZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 12 Sep 2023 04:55:25 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4DB10CA
        for <linux-serial@vger.kernel.org>; Tue, 12 Sep 2023 01:55:21 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d7e387c33f3so4653587276.1
        for <linux-serial@vger.kernel.org>; Tue, 12 Sep 2023 01:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694508921; x=1695113721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5cpNRcFT9dpKDqYIUxrODvQWj8t0YOkYRZZPM52uQ0k=;
        b=e4vPvNjo8Yg1JafwyMjaSddkk4B9L0SSXbjWOy3mLdqW0fjGQPyVn+WXJS9YquNBZ7
         FUaWRD/99pHA3Z2OUxVelTITZTe3dWDuiKf+YMTBVMwO2CmrFV7Uzunl05H3K02qScTn
         JHBKZq1qWh63SeQZ2anyiIEFO82hyB+PIIvY7SEPq0gCHCocGqRvJFAB1son/hP3Xb2v
         PCsNByLiGYeAOOPQNcR1bm2txL+cCXG+13lf9PfXGrn+jcn1TmYoBOzDguvQ4t/js/Qu
         OCVYrr7Mr47HSEOPT7PAQLgGov/wUC+xBU2kwkh6KMhtPV/g2DXYh6dDVno6kxrRh/oQ
         fdpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694508921; x=1695113721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5cpNRcFT9dpKDqYIUxrODvQWj8t0YOkYRZZPM52uQ0k=;
        b=JfbA2FleA0OzaxpcJBjSIZ/9sck5bIXAGajLx8o4S9Nxjxks965B8tKZSPiLjRpyya
         hEJU6l+hnmJl+bbTQfw3KPZ9m0OzhPhkNjHn0Ygy1S58AvlkBw4TVPREHYv1wZkEwQan
         OuztfVMKJ7r+8k0wLoGi6ieFdIxZKAhnS+3L+DSxVjRLvkLknS2hLmpq8HfvNAedNa5B
         6L9MaaJe/A/ElFoXDashyjFEmTtXXFimBZD3zAh5zpHxkz3sSaG2m3pMC+hT8aj3YIhO
         stvIdb3oceIECBJc233DGp3I0wdwbjz5QNs2dhgk/sk8VeFJh8H5ZzzWpQmmUkmDFSPZ
         9diw==
X-Gm-Message-State: AOJu0YzVKr0g+yojMZrXJgMUtrIZabSEbJFz6d75bx3+P7d03jOC4kP1
        0+GMSw6kbnxKigC+J1VpqdSjPNjDts/bklSlUDQI2A==
X-Google-Smtp-Source: AGHT+IEGS3TFambdJO6EdNSaKvuN7uKr3gK0rinQYZQudCv8F8e445q/O/vPsuhqGcFuGeBnFL3BaIyBwDUyNvoDYZc=
X-Received: by 2002:a5b:8:0:b0:d78:341d:e475 with SMTP id a8-20020a5b0008000000b00d78341de475mr10595508ybp.44.1694508920728;
 Tue, 12 Sep 2023 01:55:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 12 Sep 2023 10:55:08 +0200
Message-ID: <CACRpkdYL46wY_4dm2w45kdPqOJ8zU9X=SSAXv_K=9wfBZFqyDQ@mail.gmail.com>
Subject: Re: [PATCH 00/37] Add new Renesas RZ/G3S SoC and RZ/G3S SMARC EVK
To:     Claudiu <claudiu.beznea@tuxon.dev>
Cc:     geert+renesas@glider.be, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, ulf.hansson@linaro.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        magnus.damm@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com, quic_bjorande@quicinc.com,
        arnd@arndb.de, konrad.dybcio@linaro.org, neil.armstrong@linaro.org,
        nfraprado@collabora.com, rafal@milecki.pl,
        wsa+renesas@sang-engineering.com,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Sep 12, 2023 at 6:52=E2=80=AFAM Claudiu <claudiu.beznea@tuxon.dev> =
wrote:

> This patch series adds initial support for The Renesas RZ/G3S (R9A08G045{=
S33})
> SoC. The RZ/G3S device is a general-purpose microprocessor with a
> single-core Arm=C2=AE Cortex=C2=AE-A55 (1.1GHz) and a dual-core Arm=C2=AE=
 Cortex=C2=AE-M33 (250MHz),
> perfect for an IOT gateway controller.

I saw some of the patches are fixes. I expect that you and Geert
figure these out so I can get a separate pull request for those
ASAP. (Unless they are nonurgent.)

For new code try to use <linux/cleanup.h>.
Or if you prefer take a sweep and introduce scoped guards
everywhere (for spinlocks, mutexes..).

Yours,
Linus Walleij
