Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 793C4C4707C
	for <linux-serial@archiver.kernel.org>; Fri, 21 May 2021 18:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 455C9613E8
	for <linux-serial@archiver.kernel.org>; Fri, 21 May 2021 18:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbhEUS5n (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 21 May 2021 14:57:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:50752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230176AbhEUS5m (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 21 May 2021 14:57:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5DF0261183;
        Fri, 21 May 2021 18:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621623379;
        bh=Jv/o1enaggkq/lL3EEu4cGIArTSMfrnN5S4ybbfdrn8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DgQiGdDYcsBSsD51HT8upWICryzvHVCSXuU+D+SJSwRp7s7mL9LBNX/7Ic3YlTc43
         QTSQhIBjdoJR92gnYcoKUO2q6Kd2+R1QNcvnNCwG0UHKEEgYmA1+2FTp7Rn2RsQPw6
         5O9FCf9HaBjLKnxvOmCYXbElsvQiWV/1zxuqrWWFgCNbOTuZgd9AdxoPXBItXXt9c1
         xmRYsR7mC9RTk8fxfj5gJJM5pVV0lENDMblJvvlTMjdxCFVphEJmCqpmPm+0x2xElR
         UEgBHnFmxxr8Yd1BaQohabLNhI/tTAh5XhcgUSFQpkEVfC2FIbvK9kFUjVknf/Ql6g
         sMJwVS75z9M1Q==
Received: by mail-ej1-f51.google.com with SMTP id k14so28470742eji.2;
        Fri, 21 May 2021 11:56:19 -0700 (PDT)
X-Gm-Message-State: AOAM5315JY5xl7uMqILLNumVMj7aRPoSM6GE2v1cfqSQjUgARzUeD4yh
        gESyYIv24nMBOKzDV1UCukAMg/hni7s56hgCLg==
X-Google-Smtp-Source: ABdhPJyOA/13jGroTnau7yXh+uu6HX8nolIudOgr5s9saAVT7HW0mr52LclHUCwHLz5GYwLoKDdzonxkyf9vvfpL9b8=
X-Received: by 2002:a17:907:78cd:: with SMTP id kv13mr11622619ejc.360.1621623378049;
 Fri, 21 May 2021 11:56:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210520115440.8259-1-thunder.leizhen@huawei.com> <20210520115440.8259-2-thunder.leizhen@huawei.com>
In-Reply-To: <20210520115440.8259-2-thunder.leizhen@huawei.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 21 May 2021 13:56:06 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLi-DD66WUJ=+x8-qq0NZybeuba1OvtRxGLc8-yWmR-Kg@mail.gmail.com>
Message-ID: <CAL_JsqLi-DD66WUJ=+x8-qq0NZybeuba1OvtRxGLc8-yWmR-Kg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: serial: pl011: Delete an incorrect
 compatible string
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
> The compatible strings "zte,zx296702-uart" and "arm,primecell" are a
> combination, but commit 89d4f98ae90d ("ARM: remove zte zx platform")
> removes only the former. It is incorrect to match driver pl011 based only
> on the remaining "arm,primecell". Delete it.
>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  Documentation/devicetree/bindings/serial/pl011.yaml | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
