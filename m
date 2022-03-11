Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2945C4332F
	for <linux-serial@archiver.kernel.org>; Fri, 11 Mar 2022 10:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbiCKKn5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 11 Mar 2022 05:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiCKKn4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 11 Mar 2022 05:43:56 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BD474DF1
        for <linux-serial@vger.kernel.org>; Fri, 11 Mar 2022 02:42:52 -0800 (PST)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 276783F62E
        for <linux-serial@vger.kernel.org>; Fri, 11 Mar 2022 10:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646995371;
        bh=x4TvzHF8QuKQ3/zOGOuqHkYTzalnGKY2B97/GSUfpsM=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=wKY4ijq178WgQSNw1eeE0nkeDM3zj7C5WU4Z4yRwb0qCIaD1FVcGcjC18vwATPhw+
         VN+tNKKNjslf6OZ1LqfEXQ25w85F4M2T9RprutHcmXZ+44gzJpgxcRPTREHgpNTkL3
         EHOpAGr0mNAQwQEqClu5Y73hztZZLq/sl2UdrDAKjHfyydiA6/sf+ZznUkbWCaOADh
         3Bdamcmx5yujKhoUaY3YpghflcahiFeFDofFlMHNC4sNtktKwKbkyIrphn/Yrra5LB
         yhUo/hbvwd4ZGUn/YUG8o4bkEeiiG6Z3YzqaMQ4OR5c1e4dRfUub+016lLi/6dH+/A
         O88Z6tkjMSpbg==
Received: by mail-ed1-f72.google.com with SMTP id da28-20020a056402177c00b00415ce4b20baso4641107edb.17
        for <linux-serial@vger.kernel.org>; Fri, 11 Mar 2022 02:42:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=x4TvzHF8QuKQ3/zOGOuqHkYTzalnGKY2B97/GSUfpsM=;
        b=wM5cHZnGFia0ADdahOQwS+RbAuUGr6uL9BnNzu+he8tPA8i23rxfd9tnif7yNh1zko
         jOBBXAGvnkiW8T2cgcjhqSEFsDYI4jcFp6zNoYv3DlMUJ5awJUkK1w61TE88Zg+VgcSg
         9hvdAveujhPUKpW0k69xvR8RsOQ7x/GBHH8ZqND8bJaBpAi0/9z5u98IfL71XTr3sY5/
         kTM5ig96t3gtbf5EdFReg34h1+XcJ/qmSRURDcKnHNxV0pGoeFLd/ZHZ4ip5bfHU/Fki
         OOW0u1aBhOSQ1Wq9Wm4K20eSvK1BD9D9RFE/5smalRSWbvGrWDe8pnF+hC5USCc5un0I
         ef4g==
X-Gm-Message-State: AOAM533zceR0Y0yoMLjhkfRLTKyEoJVCvDGfP1LkRUBsqSjtK9m/7jrS
        QQj7742tu4xZyc8BNhRUR/4blkENlJBPkVVrM94jvrfo8lb0RthSyWsA0nIxU6GnXPCHUQy2vYo
        HwhWzzwhALjmyHsARTPfy9u7RWWqKKOQ+O4FMPLF4Qw==
X-Received: by 2002:a05:6402:4301:b0:415:b73f:1b48 with SMTP id m1-20020a056402430100b00415b73f1b48mr8164300edc.39.1646995370723;
        Fri, 11 Mar 2022 02:42:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz5gHHbbJP79tXVqgVSmziJdzb2BPwQmpwOBIR/Tn9dJGGxL7wDFb7JWGH8AKhMGqStoPQB7g==
X-Received: by 2002:a05:6402:4301:b0:415:b73f:1b48 with SMTP id m1-20020a056402430100b00415b73f1b48mr8164284edc.39.1646995370567;
        Fri, 11 Mar 2022 02:42:50 -0800 (PST)
Received: from [192.168.0.148] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id b10-20020a056402278a00b00415b20902a6sm3272872ede.27.2022.03.11.02.42.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Mar 2022 02:42:49 -0800 (PST)
Message-ID: <ad94136d-f651-7e6e-b3ec-94553c4c6d3b@canonical.com>
Date:   Fri, 11 Mar 2022 11:42:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 2/2] tty: serial: samsung: Add ARTPEC-8 support
Content-Language: en-US
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     kernel@axis.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        alim.akhtar@samsung.com
References: <20220311094515.3223023-1-vincent.whitchurch@axis.com>
 <20220311094515.3223023-3-vincent.whitchurch@axis.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220311094515.3223023-3-vincent.whitchurch@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 11/03/2022 10:45, Vincent Whitchurch wrote:
> Add support for the UART block on the ARTPEC-8 SoC.  This is closely
> related to the variants used on the Exynos chips.  The register layout
> is identical to Exynos850 et al but the fifo size is different (64 bytes
> in each direction for all instances).
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
> 
> Notes:
>     v2:
>     - Added Krzysztof's Reviewed-by.
>     - Expanded commit message
>     - Fixed fifo size
>     - Rebased on top of Krzysztof's "minor fixes/cleanups" series.  This needed a
>       couple of fixes for build errors.
>     
>     (I'm always unsure if Reviewed-by should be carried over or not if the fixes
>     are minor.  I apologize in advance if carring it over was the wrong thing to do
>     in this case.)

For minor fixes, usually we carry Rb tag over. It's fine.

LGTM

Best regards,
Krzysztof
