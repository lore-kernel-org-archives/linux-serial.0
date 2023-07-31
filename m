Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13BCC001DF
	for <linux-serial@archiver.kernel.org>; Mon, 31 Jul 2023 05:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjGaFiR (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 31 Jul 2023 01:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjGaFiI (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 31 Jul 2023 01:38:08 -0400
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3648E7B
        for <linux-serial@vger.kernel.org>; Sun, 30 Jul 2023 22:37:58 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-3fe110de46dso20443655e9.1
        for <linux-serial@vger.kernel.org>; Sun, 30 Jul 2023 22:37:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690781876; x=1691386676;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/WXmhfFNlAubMHSoIviyRc3xb+h66CGRBuUOqtmfZ00=;
        b=jefN35f829DeBloBF9454v4VWDgay6CYENoiqugvFHvUW8J6/AgEDrzD/z7/RNaNYJ
         l2+/jGvzWH1MJ5OqgneCq9uTvTT3D0RUVOw1twT1/B4lTzUbmwdjOSS/fG2F0UlVPMTT
         vg71BSmksqYBH1n6gUzoMmBV9ZOQti7cj7zlQzsWNsF1w36fO5gXrICNSO+sNb56KNQF
         /tsiYfNhIjRGlDU+m4sAydEkxfQOfe5Jkv3BMCeLB06bdK0u+wpmNEYnilS7ful89ttw
         eFokuMPYHkj269me7YM81pVpoj+FkFNl6mDH0u/86dfi24fmFgSTdDghucnoDxOtrb3A
         T18Q==
X-Gm-Message-State: ABy/qLYIjCx/BZmoH4ySEbglOwXhpqtFnGV00hNJgvKP4+nqfv/R8hRK
        CexVtFxzeiadO42bfYUVLWYOdGFO2tA=
X-Google-Smtp-Source: APBJJlEnDfroby/FejpWYTUZQfN6NhhCrIUN4YNAqnA5Mv13lpwVVpmMcdEYF7i17CTMgcd89/nOtg==
X-Received: by 2002:a5d:4710:0:b0:30f:bb83:e6f4 with SMTP id y16-20020a5d4710000000b0030fbb83e6f4mr5324061wrq.0.1690781876243;
        Sun, 30 Jul 2023 22:37:56 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id c18-20020a5d4f12000000b0030647449730sm11907304wru.74.2023.07.30.22.37.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jul 2023 22:37:55 -0700 (PDT)
Message-ID: <735250f4-12d1-97cd-be29-49180b9ea174@kernel.org>
Date:   Mon, 31 Jul 2023 07:37:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH -next] 8250_men_mcb: fix error handling in
 read_uarts_available_from_reg()
Content-Language: en-US
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, JoseJavier.Rodriguez@duagon.com,
        jorge.sanjuangarcia@duagon.com
References: <20230728085723.3195044-1-yangyingliang@huawei.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230728085723.3195044-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 28. 07. 23, 10:57, Yang Yingliang wrote:
> If ioremap() fails, it returns NULL pointer, not ERR_PTR(), fix the
> return value check and call release_mem_region() to release resource.
> 
> Fixes: c563831ba879 ("8250_men_mcb: Make UART config auto configurable")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

-- 
js
suse labs

