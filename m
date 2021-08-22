Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5FA0C4338F
	for <linux-serial@archiver.kernel.org>; Sun, 22 Aug 2021 10:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C17406102A
	for <linux-serial@archiver.kernel.org>; Sun, 22 Aug 2021 10:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbhHVKd5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 22 Aug 2021 06:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbhHVKd5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 22 Aug 2021 06:33:57 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93859C061575;
        Sun, 22 Aug 2021 03:33:16 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id r2so13820382pgl.10;
        Sun, 22 Aug 2021 03:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ADLfZopKXvKa0Ld8s4Xxltpx94A/+7/XhSuJdVPpzww=;
        b=LbaSt3p8b0mPgTKBtdufkbN3nKW7dTL1ddnIoT1b/rKH5VvmJxpImtkrX1oUheQCdS
         7xmyC5oMR8WqOXSHEkf/F32ks5Ldtshy9fTvRyYLAqGrtVd7MHJMAyh9HtTcnMb9Ir1Y
         +9Q8kyPUVlu/JM0f2n93EMd6krMEmj8xbBg8O431r9bIdzZxTSYJiV47mPPYX/P1+Voh
         Gvz3haydwJDiwIWwb7FlW3IgJKbiY0zgn4KFRsU9HipvAZ1sFRK0cwUPLCRfE7Kpr0mb
         brz7KuMuiTblFdnI9g/VWBeRIWER2iqHnz5WIoCgtv2SeerkQsvq0DUomtfq1YENEIbQ
         W8Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ADLfZopKXvKa0Ld8s4Xxltpx94A/+7/XhSuJdVPpzww=;
        b=UQfjmtDal0ipEvHZ1jerMOHZQ55V+WdU+lXJY4eZ3/xZZu5tM+m2FuvCQZXV1uCIZE
         caZR+xErVbwHFaLqGVMPCXFthV9XcQk1TSSeuY4V8nmJdJZN+k9gEh/0ZxaBpE/Ynd2A
         NfeA0wb/l3hQQ2570iDmEKrR3+BpYPm6/8juVnSAzuAIWZ3qkiEw9J9PTWWgkCp992NJ
         zNTQdDf0AG2MGPGFF0AjFu/Qs5uKf6L5wWjhNxVsidEx07f8TK3YlAZ9kZxeREIkgOox
         sHVvWwIfvAT91yux18sAaUN3I4E1MVGXRnC2JPH2gyjnp/Y/Kd5Aapu6h0AN7yJ/+aQA
         boug==
X-Gm-Message-State: AOAM530i/jwnG/fHkZtXnwBr0vjhiLjD+cyFpXyth5HsM0i6xeshVCHj
        D/6BtJP8tQtZ6cYQfesjQvM=
X-Google-Smtp-Source: ABdhPJxzse1wQ8Sv1uTM+tcU77pDwrjBONPCjo8NXCZ8HNQ7lT3JjLYu1WFroggY7W8PO6M6csj1Gg==
X-Received: by 2002:aa7:8ec1:0:b029:3cd:cd3c:b85c with SMTP id b1-20020aa78ec10000b02903cdcd3cb85cmr27967881pfr.15.1629628396102;
        Sun, 22 Aug 2021 03:33:16 -0700 (PDT)
Received: from [192.168.1.22] (amarseille-551-1-7-65.w92-145.abo.wanadoo.fr. [92.145.152.65])
        by smtp.gmail.com with ESMTPSA id z19sm12639513pfn.94.2021.08.22.03.33.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Aug 2021 03:33:15 -0700 (PDT)
Subject: Re: [PATCH] dt-bindings: serial: brcm,bcm6345-uart: convert to the
 json-schema
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20210819134859.19537-1-zajec5@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <205daa26-660d-3a65-3c9b-b2c540abd31e@gmail.com>
Date:   Sun, 22 Aug 2021 12:33:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210819134859.19537-1-zajec5@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 8/19/2021 3:48 PM, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> This helps validating DTS files.
> 
> In example periph_clk@0 was replaced with periph_clk to fix validation.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
