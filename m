Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C75C4361B
	for <linux-serial@archiver.kernel.org>; Wed, 16 Dec 2020 08:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 706F0230FF
	for <linux-serial@archiver.kernel.org>; Wed, 16 Dec 2020 08:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgLPI6v (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 16 Dec 2020 03:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgLPI6u (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 16 Dec 2020 03:58:50 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572E5C0613D6
        for <linux-serial@vger.kernel.org>; Wed, 16 Dec 2020 00:58:10 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id n16so1490392wmc.0
        for <linux-serial@vger.kernel.org>; Wed, 16 Dec 2020 00:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=CnyyKZ0Zx1BxINWxPqOgHgBA1hAyUh9nq8RAHfNkCus=;
        b=fZHU34jQlz1e2bWiS5yLio80iUB2pJw8FaGi9nwz3hsQAEpTTVFuu9ePjFreyn4sO7
         PU2DQMlqac65tisGoObkSRhMZ4Cv4e9ByEitpNNAKP/hiQWG7RDD0dj2+UFfc/CAQnxv
         SSQJOp35A9eG6Wlqwk8K+Kr0V7t/Y0MgdwLiSOG16X5h+WgldPpM43if+YUzeQST2qgf
         E7pW6z1bseE5Rrii/nSvWF/MAtRDgpnZbEzCSkjg2ZNyPJt0kzaOQoYV2gfSXTT09QZK
         GSAwtVf5/4BSe9+g1NS6PCDRqUxjeHG1JyCwIpryX0ejWqaq2+4gkfPXu+JE5erN0il6
         Yvmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=CnyyKZ0Zx1BxINWxPqOgHgBA1hAyUh9nq8RAHfNkCus=;
        b=AYl4YR8+gOW/rXrpaZ67hBP9AB+z3Kt2/ZMRkoQ3oKgf8R/7hUEThRMtDRbmoRAhOi
         HjBNqS4Rf8EnB1jU5WzMUyZtp317+o994oCseyWw9ZXVquw5Y9uetgxhNDFdszT6DKGb
         xsvSEuAPYrK8yfNnSDhUv2sG7J8/CH7GrpsSAd9FDoNx7nHyZTwRJQnD9j5ImqnPJAcl
         pg4TlyPhmAMKdjrygo9ClXnb8W7rqWdqiw9Lp2spdMm/Rdk+A7fzOGLyYHzVkvomN/gN
         X6zj8XUFeH4UWC+3Lcb9UcVVKfBGkrGmUbMZqN3848JmUTLvMurIV+f0BPfPNJb9bBo4
         MbMw==
X-Gm-Message-State: AOAM532vYqs93pEK6uI3JtblJV5MhsJhoLQvbEF0YbCExOJBf3LCB8dm
        dOvMDqU3LirvMMqAcR5Xls1BmQ==
X-Google-Smtp-Source: ABdhPJxyD6igsMnOelb9CqTbNakrbhwN83NwuKQeIw5SBvQ4jSlkvgYwYSwyhS6HWPk299U6SE0Fsg==
X-Received: by 2002:a05:600c:2903:: with SMTP id i3mr2200622wmd.41.1608109089069;
        Wed, 16 Dec 2020 00:58:09 -0800 (PST)
Received: from dell ([91.110.221.200])
        by smtp.gmail.com with ESMTPSA id w13sm2126803wrt.52.2020.12.16.00.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 00:58:08 -0800 (PST)
Date:   Wed, 16 Dec 2020 08:58:06 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pawel Czarnecki <pczarnecki@internships.antmicro.com>,
        Stafford Horne <shorne@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-media <linux-media@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] dt-bindings: mfd: correct the node name of the panel
 led
Message-ID: <20201216085806.GJ4776@dell>
References: <20201204093813.1275-1-thunder.leizhen@huawei.com>
 <20201204093813.1275-6-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201204093813.1275-6-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, 04 Dec 2020, Zhen Lei wrote:

> According to the definition in leds-pwm.yaml, the node name of each led
> must match the regular expression "^led(-[0-9a-f]+)?$". "led" or "led-"
> followed by a decimal or hexadecimal ID number.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  Documentation/devicetree/bindings/mfd/iqs62x.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
