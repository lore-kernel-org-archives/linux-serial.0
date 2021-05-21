Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB86C4707A
	for <linux-serial@archiver.kernel.org>; Fri, 21 May 2021 18:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F3E7613E1
	for <linux-serial@archiver.kernel.org>; Fri, 21 May 2021 18:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbhEUSzw (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 21 May 2021 14:55:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:50302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232714AbhEUSzv (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 21 May 2021 14:55:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 97F9561244;
        Fri, 21 May 2021 18:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621623267;
        bh=AjWpbnsQht+zUw23co+Hw3rsedGTIqvjpGYhFVnROAY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=o093Y34PuqM83CGt3lDpKw1+IOLHWuKuMjOVk0/F5F38I/yVlTBMCtMGXGlp1MIBr
         60/a8K9Ku33linFVgbniBCJKKs76JOl+EMPchiVkFqPqp+BjecX0CxRPayN9lcL+lH
         ULO1hkgbYBBOoff3g6dLg3lfVNx1MRan2MR6S8lw2VWO87KPCEUZSw5ehySxzT3cK5
         peGcLhRfBfz4Lw3c7mSYOGlkSjM8Ok6x7aq9pirMfUlRsIHBmIKIZ529hKG3hkpa5E
         Mk0AScmhdDRcTqMfWJ0r5+3h7p3w2tAr1WI7WOFCyNWcov5o4eDnG7ohV8Lh/EHID5
         Dyd4i8JXjXSew==
Received: by mail-ej1-f49.google.com with SMTP id z12so30482818ejw.0;
        Fri, 21 May 2021 11:54:27 -0700 (PDT)
X-Gm-Message-State: AOAM530kEFeCsW1CQCS46HJYX/FCxOurQ4kKoXLVeBO+BY1Upb56TKkB
        D4c0qH3RH8uA7lPzqRLkp3601tVC3sDoTjfy+w==
X-Google-Smtp-Source: ABdhPJwJ4UP2zEEviEw/DgRXgB2NQ3pjrdu3ZvKrj3G2lj2MBLe2e0DyJCcTXjZNs7xSzdgXRRuatJWlFU4bfBZEUJ4=
X-Received: by 2002:a17:906:6c96:: with SMTP id s22mr11882915ejr.468.1621623266192;
 Fri, 21 May 2021 11:54:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210520115440.8259-1-thunder.leizhen@huawei.com> <20210520115440.8259-3-thunder.leizhen@huawei.com>
In-Reply-To: <20210520115440.8259-3-thunder.leizhen@huawei.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 21 May 2021 13:54:14 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+XYATKC=y+=wFHtfVB634Mb_Y5xC969UMyDc4Z9W8x4A@mail.gmail.com>
Message-ID: <CAL_Jsq+XYATKC=y+=wFHtfVB634Mb_Y5xC969UMyDc4Z9W8x4A@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: serial: pl011: Avoid matching device
 tree nodes of variant pl011 drivers
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-serial <linux-serial@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, May 20, 2021 at 6:54 AM Zhen Lei <thunder.leizhen@huawei.com> wrote:
>
> There is a variant driver of pl011, which may have a compatible string
> written as: "arm,sbsa-uart", "arm,pl011". Because it contains "arm,pl011",
> so the corresponding device tree nodes are also checked by this YAML file.
> As a result, many flase warnings similar to the following are reported:
>
> arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dt.yaml:
>  serial@21c0000: compatible:0: 'arm,pl011' was expected
>  serial@21c0000: compatible:1: 'arm,primecell' was expected

The DT is wrong. The h/w is either a PL011 or it isn't. If it is, then
the compatible should be '"arm,pl011", "arm,primecell"'. There is no
point in making it 'arm,sbsa-uart' as the PL011 (and OS support for
it) predate SBSA (by a lot). If it is not a PL011 and only the SBSA
subset, then it should be "arm,sbsa-uart".

Rob
