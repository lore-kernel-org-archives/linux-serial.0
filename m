Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B4FC001E9
	for <linux-serial@archiver.kernel.org>; Thu,  1 Apr 2021 17:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F70A6137B
	for <linux-serial@archiver.kernel.org>; Thu,  1 Apr 2021 17:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234711AbhDARpr (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 1 Apr 2021 13:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234582AbhDARiK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 1 Apr 2021 13:38:10 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2D0C0D942E;
        Thu,  1 Apr 2021 07:56:28 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id g8-20020a9d6c480000b02901b65ca2432cso2379034otq.3;
        Thu, 01 Apr 2021 07:56:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=b51MdFXC3VyV3rk2wSYcP9E+sT/K1k0PZUFp+W5EgPY=;
        b=axfyOe4pKnjLXgnZcjftqxCP79YXpFahjtPQIgnehX8FfHBQN8qsNCmuvgAU6uvaE0
         +W976oQ3ljsrqi5Y6sCfNviRdnwM7tOA6W5fHoQkSO4XKaKAys+xdxz9QjFddUy49Y9d
         S5YhEH9V+R2cO2DV4OqzQ2dbIR+LWDJDXnMf8d0oXG43Ylw+g30ZPifAn0sdcFtG3aOn
         jhQV2POuwA8/0yU6nfyU/DNLjpkWWSkjI3032hRwkbGiUzKWraU/Ej7wZ8ZSzoRBWx11
         HNHEI473qs2tDf3WPP5IOsCigrWJxxljTd3dXqq4oMWjnO9Adz8ZE93aCAgiNbqm7K2s
         1nWQ==
X-Gm-Message-State: AOAM530hR8UF1DohjH9GeNAIdugckXW3NyEdrAcibp91QYzjeOo8r0P+
        Y7J1/inN2ZeO7AiYjYrUCBYc/y8X4A==
X-Google-Smtp-Source: ABdhPJzvGwq10FN++hBJ+VBjgxixDeXeYVqnUGGXPtJLMldLSliVun6grNAzy9JrRlq2ysk537TmhA==
X-Received: by 2002:a05:6830:4d:: with SMTP id d13mr7257198otp.295.1617288983889;
        Thu, 01 Apr 2021 07:56:23 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t22sm1229535otl.49.2021.04.01.07.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 07:56:23 -0700 (PDT)
Received: (nullmailer pid 409159 invoked by uid 1000);
        Thu, 01 Apr 2021 14:56:21 -0000
From:   Rob Herring <robh@kernel.org>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Rob Herring <robh+dt@kernel.org>, - <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        Andrew Jeffery <andrew@aj.id.au>, openbmc@lists.ozlabs.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Joel Stanley <joel@jms.id.au>, Lubomir Rintel <lkundrak@v3.sk>
In-Reply-To: <20210401005702.28271-4-zev@bewilderbeest.net>
References: <YGOuhjD19SmjmQou@hatter.bewilderbeest.net> <20210401005702.28271-1-zev@bewilderbeest.net> <20210401005702.28271-4-zev@bewilderbeest.net>
Subject: Re: [PATCH v2 3/3] dt-bindings: serial: 8250: add aspeed, sirq-active-high
Date:   Thu, 01 Apr 2021 09:56:21 -0500
Message-Id: <1617288981.559685.409158.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, 31 Mar 2021 19:57:02 -0500, Zev Weiss wrote:
> This provides a simpler, more direct alternative to the deprecated
> aspeed,sirq-polarity-sense property for indicating the polarity of
> the Aspeed VUART's SIRQ line.
> 
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> ---
>  Documentation/devicetree/bindings/serial/8250.yaml | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/serial/8250.yaml:16:30: [warning] too few spaces after comma (commas)
./Documentation/devicetree/bindings/serial/8250.yaml:17:30: [warning] too few spaces after comma (commas)

dtschema/dtc warnings/errors:

See https://patchwork.ozlabs.org/patch/1460791

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

