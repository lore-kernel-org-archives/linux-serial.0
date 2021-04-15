Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FCEC433B4
	for <linux-serial@archiver.kernel.org>; Thu, 15 Apr 2021 10:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9566A611F1
	for <linux-serial@archiver.kernel.org>; Thu, 15 Apr 2021 10:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbhDOKpP (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 15 Apr 2021 06:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbhDOKpP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 15 Apr 2021 06:45:15 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A04C061574;
        Thu, 15 Apr 2021 03:44:52 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id u14-20020a17090a1f0eb029014e38011b09so7634175pja.5;
        Thu, 15 Apr 2021 03:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y1DUj+LpqFJx365XATeNPbb83Gb4aaYZHLTa7lCAIIY=;
        b=rlZwX0nXNQejE35yBuX2SSKtFS/peJGaVHQ38eFLkt/FAa4K3wbA+9fgog0KaBwbDE
         ZtwXV13LrMf/7PU4LoHzaz0YSEgZ6R7WuuXhTYw5oDckdTqga+sbIkvXKBkWu0DblxL7
         tKJWP7BR8D7dx1z+2ZBTvnuGG34I+gf1dPwbbZ6Nu8iZyofFngFoCZ7VGxYr00CmcCPZ
         IxBHPOnnz0/1Ur1E1K7UbPLIZEkraplfnZfheqDHJSC3tuKwPL2zn6SdsTElBuwn4OFb
         LwTMfMYef8Kutj/1qPwTHmhhrwiGgvU5EQEQJcHx6eSeiS7JpUK0PZOT8gom7vZtIqNp
         x0Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y1DUj+LpqFJx365XATeNPbb83Gb4aaYZHLTa7lCAIIY=;
        b=ince/2tcLPgCqnlmZ3jYsvjQ90kHqGe74menbeSPaNtRKlUR/Kk/juFrztEorgKxJI
         xb2i8+hHY/PandGyIIOdvg++MKcm4uK2s+HFz7gyhkPSRh6qx+UyRYy1BQVuhnd/j/Zt
         WxsvAWTWvJe9oJMFASXUWdXJtbPa+T81zbK/qpwgtGQuG7yE9eeblZE33OabSXOQXsVl
         03g4+hhOMfPxFoen6rliHDsfDkIDXQFrkvnRynz6MRwVW4nuN7+ytNxl6BpvCTvm0hwt
         XBxETiEkcFIqPIp3WATRD0DBnoGqQi1hJGGwyiosNm3N1ULFF+5NVkAamGSoekQYea67
         DTsA==
X-Gm-Message-State: AOAM533iCCPKnicUJSoCCpFXzm1B/O3TPZv0OCme6RwkTzJmwpeqsN38
        1PPNG1J8+z99DdZqrIO+4ugIPZTn8ZS/PC48tkY6fGNY0iY=
X-Google-Smtp-Source: ABdhPJz+aRI3MO9vvoP2aoQlylH4jlAwUNLprod4UA53/zT5TX1gIwNI6iB7j8vxlcFXvVC+/8IVKykDDWIXYyXc4Is=
X-Received: by 2002:a17:902:e803:b029:e9:1f79:2427 with SMTP id
 u3-20020a170902e803b02900e91f792427mr3093248plg.21.1618483491886; Thu, 15 Apr
 2021 03:44:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210414134539.42332-1-alcooperx@gmail.com>
In-Reply-To: <20210414134539.42332-1-alcooperx@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 15 Apr 2021 13:44:34 +0300
Message-ID: <CAHp75VfQetCJJZ_U70xEduVBQHEx_GkHeKBs2uzNtvcq9H0BqQ@mail.gmail.com>
Subject: Re: [-next] serial: 8250: Match legacy NS16550A UARTs
To:     Al Cooper <alcooperx@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Apr 14, 2021 at 7:13 PM Al Cooper <alcooperx@gmail.com> wrote:
>
> From: Florian Fainelli <f.fainelli@gmail.com>
>
> Older 32-bit only Broadcom STB chips used a NS16550A compatible UART,
> the 8250_bcm7271.c driver can drive those UARTs just fine provided that
> we let it match the appropriate compatible string.

This sounds not correct to me, ns16550a is a national semiconductor product.

Why is it here and not in generic 8250_of?

> +       {
> +               .compatible = "ns16550a",
> +               .data = brcmstb_rate_table_16550a,
> +       },


-- 
With Best Regards,
Andy Shevchenko
