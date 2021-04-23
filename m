Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7EDC433ED
	for <linux-serial@archiver.kernel.org>; Fri, 23 Apr 2021 19:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A03B613D7
	for <linux-serial@archiver.kernel.org>; Fri, 23 Apr 2021 19:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243935AbhDWTtL (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 23 Apr 2021 15:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243874AbhDWTtJ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 23 Apr 2021 15:49:09 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0CBC061574;
        Fri, 23 Apr 2021 12:48:32 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id lr7so7501821pjb.2;
        Fri, 23 Apr 2021 12:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RblyejMO0ehdI3884/nZF+v9qcRYrKv3C89X2315cxc=;
        b=qMCaatxx/bSEsCo0Gf7FUukHolKiLQl3+D3e8B95J36vEEhdGD3cwJh1rj3BZjPCOE
         CfSuEeJuJ+jIHpQwcEbNVvVzo+PpJVyyCwzPZAzK4mlQQj/922MHGeUXxdLYpTyLJxxD
         ZzXPbnKNIlWfZHg3ZIJhhBHN6D+0p37t1b2YTmrsT06ilkuedJzUVpqv7GL7cUDouCgA
         ZO+w+4pfOz7o52H6FGrcAaY2+4bxjqhyno5tBE4ETe7kMd/bezDsbIfyR06U9k0d3Wtr
         qcuZ3kc+tvcAuaU0L3UewiVtKEH5NFGV+iq2atwyv686bAxlFpW7xC3gasn7OP1Rg/O2
         qouA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RblyejMO0ehdI3884/nZF+v9qcRYrKv3C89X2315cxc=;
        b=beJqlNVFLtezCUmlshZtl/EFqtG6l1cefHBQ0PA5TcBhYl5tvopgBpTl8z/R8YnTWW
         qNXPC+JoIn0MC7e3ptfL19Ci9IfApV9PNXff19kDeQwkEjtjdUXvTfM7oxEPgRBb3aqw
         thQzcl5QiOG2Kzstb5c2TD1pxXgeyB69WfRgGWXz0IA7nXW+lNa1Rpj5h3/3ZG3bdqRZ
         q4IdzY/C4MQ0UaYkqHlfY9rrytM1k6KkzXndXp5Kqg+9Z4vGvpZftZv2xYGf+Wq/OqgT
         HQbTLuGXpUiiuThYN+5qZXRGGTN5F/IWX7RmgBm5KhIwVYnBuKC6r4w0aaefNvme8hbl
         iybg==
X-Gm-Message-State: AOAM531wQ3eBx5V4x2GwHn2Ah6Ft0MRw12LzWlFvEN9KCxFEhqRANhKh
        FXBOeW0gBU7HqLRJ+4G68T+9xHizR4w=
X-Google-Smtp-Source: ABdhPJy+8xqXrxU5UjY1FTpnTR1T+0SZzmmE95sBP5vfvc1R4Cvna4Hyx/wnSME5qMVv6wz/1KjmZg==
X-Received: by 2002:a17:90a:8592:: with SMTP id m18mr7212464pjn.165.1619207311621;
        Fri, 23 Apr 2021 12:48:31 -0700 (PDT)
Received: from [10.230.29.202] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id b20sm8163779pju.17.2021.04.23.12.48.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Apr 2021 12:48:31 -0700 (PDT)
Subject: Re: [PATCH] serial: 8250: of: Check for CONFIG_SERIAL_8250_BCM7271
To:     Alan Cooper <alcooperx@gmail.com>,
        ": Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
References: <20210423191920.42940-1-alcooperx@gmail.com>
 <CAOGqxeVokFqOQMpTrpyg1GPRk6YCw=GF0-ShBtiKz_3_0RU2XQ@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <d48a47cf-2dff-cc94-6b6b-f498ab94fe57@gmail.com>
Date:   Fri, 23 Apr 2021 12:48:29 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CAOGqxeVokFqOQMpTrpyg1GPRk6YCw=GF0-ShBtiKz_3_0RU2XQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 4/23/2021 12:25 PM, Alan Cooper wrote:
> Please ignore this patch, it was already submitted by Florian about an hour ago.

Sorry for the lack of coordination, was about to ask you if you wanted
to send it.
-- 
Florian
