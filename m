Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83B2C43381
	for <linux-serial@archiver.kernel.org>; Thu, 18 Mar 2021 17:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 976A364E6B
	for <linux-serial@archiver.kernel.org>; Thu, 18 Mar 2021 17:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbhCRRSe (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 18 Mar 2021 13:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbhCRRSD (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 18 Mar 2021 13:18:03 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252DEC061760
        for <linux-serial@vger.kernel.org>; Thu, 18 Mar 2021 10:18:02 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id kr3-20020a17090b4903b02900c096fc01deso3465720pjb.4
        for <linux-serial@vger.kernel.org>; Thu, 18 Mar 2021 10:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q/dGxKGWMn9sfMz1b8CCSg+fiC/dJhHGZJq+3SdzjOQ=;
        b=WVWbyAI5kfosqOyzscCScjiH7ZCnvPLgynzAoQ7C8JvvuMRmVO+nfLQVdRcBcbhBl3
         3CAeupwS4atfV2Uk80gYt5uTO+qtyNw+uAc7j/oep/H3uv4GOvIOY24izAyzE2DQ8VW7
         kUqFutxVa5UtqjSHyhZiVeHY4i4xf4tXelALM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q/dGxKGWMn9sfMz1b8CCSg+fiC/dJhHGZJq+3SdzjOQ=;
        b=FOV74a3LbCFe225ppGxaq18hO8ktoqBmU0pCUz7s5/x2RNrzNlHjfq5qifwpXcmfze
         aUBLQVTP78UQvrhC6xQu+JTOG3CaQ/JN/g1CasZ+Gf2/GcjnUsTtTT1we66Hri8ZB2JM
         tw+IHHgJiUxqhyDiw2uBlxpwrhIQe3p+qTZJQHMihDZmeBbEdPzz+cbQ7xUp72No8CN5
         HC53r7osDxAEA0Yt8viptrcrf66OHh0cWGYZ/0WQsSXr/B+2A638grxCvsAnX7dxsClu
         TRjOyrSgh4gUs7jbVmNhT+kOS6hrCEhxy7W9oj4hYBrcV8VpGmI5n8waGhVG7Q7zcpRo
         mvbg==
X-Gm-Message-State: AOAM5321R1dh/kYxhFknzNhv2Uocp+B9ShO/OVPHcNo0uZ+SmgxrcKMG
        m6e8twQr9DIkVrU92y5LuFsjtEkDyiH1MQ==
X-Google-Smtp-Source: ABdhPJwjpWZE1h3EfmpA8uaekrYi2l/kcDS5O6e6heHIWgnAfkX7fPzdsgqyeP70KZ8aaKjMwXs8Rg==
X-Received: by 2002:a17:90b:f15:: with SMTP id br21mr5479022pjb.234.1616087881552;
        Thu, 18 Mar 2021 10:18:01 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3cf8:6a09:780b:f65d])
        by smtp.gmail.com with UTF8SMTPSA id r23sm3063398pje.38.2021.03.18.10.18.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Mar 2021 10:18:01 -0700 (PDT)
Date:   Thu, 18 Mar 2021 10:17:59 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Roja Rani Yarubandi <rojay@codeaurora.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-serial@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        akashast@codeaurora.org, msavaliy@qti.qualcomm.com
Subject: Re: [PATCH V2 2/2] arm64: dts: qcom: sc7180: Remove QUP-CORE ICC path
Message-ID: <YFOLR4pem0mRFkoQ@google.com>
References: <20210318111009.30365-1-rojay@codeaurora.org>
 <20210318111009.30365-3-rojay@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210318111009.30365-3-rojay@codeaurora.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Mar 18, 2021 at 04:40:09PM +0530, Roja Rani Yarubandi wrote:
> We had introduced the QUP-CORE ICC path to put proxy votes from
> QUP wrapper on behalf of earlycon, if other users of QUP-CORE turn
> off this clock before the real console is probed, unclocked access
> to HW was seen from earlycon.
> 
> With ICC sync state support proxy votes are no longer need as ICC
> will ensure that the default bootloader votes are not removed until
> all it's consumer are probed.
> 
> We can safely remove ICC path for QUP-CORE clock from QUP wrapper
> device.
> 
> Signed-off-by: Roja Rani Yarubandi <rojay@codeaurora.org>
> Signed-off-by: Akash Asthana <akashast@codeaurora.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
