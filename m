Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB939C4338F
	for <linux-serial@archiver.kernel.org>; Thu, 19 Aug 2021 01:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B43CA610A1
	for <linux-serial@archiver.kernel.org>; Thu, 19 Aug 2021 01:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235348AbhHSBza (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 18 Aug 2021 21:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235258AbhHSBz3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 18 Aug 2021 21:55:29 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098AAC061764;
        Wed, 18 Aug 2021 18:54:54 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id f2so8678686ljn.1;
        Wed, 18 Aug 2021 18:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SIKwoT7gMcNLGB5LAQafINcu0OphUU1dAr/e57eNEWo=;
        b=sw+FOUi+UBE067inIUuz/+rZnRV94u+R1Sec123aN9b4/newbT3wmNAw7S7HpNO/wz
         iO+dY1GVkQAISUgGIIUKVRoRjHbeWcXdGdWk8REGH8f9SCRr1Hk7PuYX1xwIDZ5qxOW9
         RUq71RG3MrYxbIhgri8rQLo8oixXzSOwarwXPANC3yPsownwuzus8+7YiuUoBC1JREJ1
         0s9lsC9A2CkokDjtmy3v64v/WD7x5hxwRg9bsRr7b3UQ3LablKY7Cm9MyiPjvzcWtxTL
         ceLGMlmDQVzTC607+/6fU1tlYH86QlC2eLd7jD6PrKevnwloqvl86637nwZ4RgsbII+8
         6P8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SIKwoT7gMcNLGB5LAQafINcu0OphUU1dAr/e57eNEWo=;
        b=tnoAiLObIlzX1BNQzGSpDqa9PEMNSF9E4yOeWxei3BMbSnMhrGNPBLzU0Em+JuLJgR
         01XZuuFYiwcsjWDCAJlVEnfY27onw0uH26jp9Uvlyj0NGGvy1mduEigUXwve8ItfJELf
         0EkhqMsNRAwgdvmfnBRLPNaHAfOzkB679cwy//ex/+yhwTTud+RiYepICEaHayWUN/NV
         1qBDtWt/HXFkIjUE61vCD1rNizyhQyI8vRZNHDs0yRT8dhBGePyshYFraLaI055/GwTt
         rK+MLt70tsdsWW+JLq0fMwyRYnuHCL3cWao8SikZE6KefdLjEKZuvMo3GfkVZwQBG2/g
         sE6Q==
X-Gm-Message-State: AOAM531mFsQrK11q9kQ4iKGhVjXrpRrPcHpDig+c5Z/c5E/LICn0MMb5
        HrKVl988wQCSjwnFDoWFt3ICun3rfHFOLZBCr08=
X-Google-Smtp-Source: ABdhPJwZFhtL2gp3dxGVCxHolp5qH/A1rEKnum7OgsI7jCZpoPymnSDn+ku5BoaxVHmv4On3hYFcRueqwCHHG4oO87o=
X-Received: by 2002:a2e:a78b:: with SMTP id c11mr10243732ljf.347.1629338092343;
 Wed, 18 Aug 2021 18:54:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210817063058.4718-1-sherry.sun@nxp.com>
In-Reply-To: <20210817063058.4718-1-sherry.sun@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 18 Aug 2021 22:54:41 -0300
Message-ID: <CAOMZO5Dq153EYBFYdNZ-fWNkWkqJ3o+oP4y9K9cpcBu+dFChkA@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: fsl_lpuart: fix the wrong mapbase value
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Sherry,

On Tue, Aug 17, 2021 at 3:32 AM Sherry Sun <sherry.sun@nxp.com> wrote:
>
> From: Andy Duan <fugang.duan@nxp.com>
>
> Register offset needs to be applied on mapbase also.
> dma_tx/rx_request use the physical address of UARTDATA.
> Register offset is currently only applied to membase (the
> corresponding virtual addr) but not on mapbase.
>
> Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>
> Acked-by: Fugang Duan <fugang.duan@nxp.com>
> Signed-off-by: Adriana Reus <adriana.reus@nxp.com>
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>

You probably should add a Fixes tag.
