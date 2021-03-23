Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E6BC433E6
	for <linux-serial@archiver.kernel.org>; Tue, 23 Mar 2021 22:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BCE6619D7
	for <linux-serial@archiver.kernel.org>; Tue, 23 Mar 2021 22:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233914AbhCWWdt (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 Mar 2021 18:33:49 -0400
Received: from mail-io1-f42.google.com ([209.85.166.42]:35514 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbhCWWau (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Mar 2021 18:30:50 -0400
Received: by mail-io1-f42.google.com with SMTP id x17so8184832iog.2;
        Tue, 23 Mar 2021 15:30:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z0xQqmzALS2FhLdkzcWSihGa+FeQuFbmAwvE7tjw9YI=;
        b=hg6pON8MGD4ng0CsW4feWL7PSpiFAc/AXBUmtQzdV4Jyy3mXfqa7Vm3cZCmj1WC92b
         u/z4juipN77P5SfFtRqsBYFCRi2pPeq61VKFCESU53yP8Xt2z7GXC7rpmHHKqRBg3EcI
         A1d4ctGwR3Ig4Z0UKnENGgz1Y+0KvYfvlFsJ1oeSSdwvL0+ZnlUcpvEFoxv8l08/+XyH
         IbqOjPMyYimiSM+vJ+/QyqHxOGnyqZ4nfmSxoF/hl837LDoG6gEQMcjOUdmlYnqi8/gm
         PwXphgbKHTl8v9rNmXwwThPkb9P8i8kXluFwQ2QiTxNLhXrkeZKC0QVDDYR6APHmRTrJ
         w2Mw==
X-Gm-Message-State: AOAM532hcjggdnAqbSlH8zXjF+ID731Wu9Jn97w/N2IK50+kTc/1aq5c
        ftj8pMw3kye57Tz5nJJRAQ==
X-Google-Smtp-Source: ABdhPJyp2GyxLMCUzepm+Z+ITtn/OVbU1LfwLQWNFPA34sQJ/S7koa026FSCFUPs4pbKlfdAi0qdVA==
X-Received: by 2002:a5d:9959:: with SMTP id v25mr238442ios.189.1616538647518;
        Tue, 23 Mar 2021 15:30:47 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id x6sm107877ioh.19.2021.03.23.15.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 15:30:46 -0700 (PDT)
Received: (nullmailer pid 1463268 invoked by uid 1000);
        Tue, 23 Mar 2021 22:30:44 -0000
Date:   Tue, 23 Mar 2021 16:30:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Martin Devera <devik@eaxlabs.cz>
Cc:     Le Ray <erwan.leray@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        fabrice.gasnier@foss.st.com, linux-kernel@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Subject: Re: [PATCH v7 1/2] dt-bindings: serial: Add rx-tx-swap to stm32-usart
Message-ID: <20210323223044.GA1463209@robh.at.kernel.org>
References: <1615559009.788146.2976052.nullmailer@robh.at.kernel.org>
 <20210312153702.12349-1-devik@eaxlabs.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312153702.12349-1-devik@eaxlabs.cz>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, 12 Mar 2021 16:37:01 +0100, Martin Devera wrote:
> Add new rx-tx-swap property to allow for RX & TX pin swapping.
> 
> Signed-off-by: Martin Devera <devik@eaxlabs.cz>
> Acked-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> ---
> v7:
>   - fix yaml linter warning
> v6:
>   - add version changelog
> v5:
>   - yaml fixes based on Rob Herring comments
>     - add serial.yaml reference
>     - move compatible from 'then' to 'if'
> v3:
>   - don't allow rx-tx-swap for st,stm32-uart (suggested
>     by Fabrice Gasnier)
> v2:
>   - change st,swap to rx-tx-swap (suggested by Rob Herring)
> ---
>  .../devicetree/bindings/serial/st,stm32-uart.yaml  | 29 ++++++++++++++--------
>  1 file changed, 19 insertions(+), 10 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
