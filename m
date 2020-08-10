Return-Path: <SRS0=IIB/=BU=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39ACC433E1
	for <linux-serial@archiver.kernel.org>; Mon, 10 Aug 2020 14:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9211B2070B
	for <linux-serial@archiver.kernel.org>; Mon, 10 Aug 2020 14:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597068936;
	bh=vy8eBB2//IvDtBt60/3I4yq6JaPvKDrnYi5TwhfDlK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EDyzAz6eAsbbi5sKYuteCkgwFPN3SA5m8EcCSy4FajYpen+vZhAACXgi2CaNB0okG
	 aX+6Vs2nbb3rwUuvG8ZvGQiUB4pv0WioW9XhGfiN7mSL0rmKRXevZ64dzZNkGvFenE
	 6wEV+bYtOU4voFb7SaHIHTEz3zfgPLJo22A2eFcI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgHJOPb (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 10 Aug 2020 10:15:31 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45980 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgHJOPb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 10 Aug 2020 10:15:31 -0400
Received: by mail-ed1-f67.google.com with SMTP id di22so6484044edb.12;
        Mon, 10 Aug 2020 07:15:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/9w3jeHQu0tGGSbBjCL27CGFJj/E1cqCv8uax1z96uE=;
        b=sCwCZoU5iE+LkzhKQKQVtAzw0dpsVHJyBgau7259ONYpybq/COBujwDPfLpFp8VzzZ
         2CwapVL1bPGvqNplTpFTx5Bt5RZgj5l0lIr8CiEiJZDFXv+wi1bMYqIszCUd1ya93wRt
         3Vloy5aP8SW5L1q16yzlypAUEM8l4vnMucM2wzsGPi3SduIMMyiBU9QDIEHMJJv9Wv8k
         1O6dRYg4llCWv2GqzyNWqYD2AI/SwPUH0XC0NgJ3QTsSumeeFgRRKMwUXgx+zJjBT2tf
         6wPIvSLKOYAgKq4ToQY/QsOYllhxnuChYBEA2ShV7qfv4quCDoCZKSGDBFsOlI1oSeTT
         wSlA==
X-Gm-Message-State: AOAM530V2yZT8A1rIUrvwdom7E0FcjNOaMLipeu02mD3/7WS2kwzB1Ax
        bMReJFEPtB8vdtWRWnkQbZc=
X-Google-Smtp-Source: ABdhPJwln4xOfhbOSKOZ+8uP/TEgLEw/XTopL0JiulzbP60CYhCX+ZiXbmfrXBY/H9XrTHJk0GskSg==
X-Received: by 2002:a05:6402:1504:: with SMTP id f4mr21756997edw.163.1597068929268;
        Mon, 10 Aug 2020 07:15:29 -0700 (PDT)
Received: from pi3 ([194.230.155.117])
        by smtp.googlemail.com with ESMTPSA id t18sm13397113ejf.38.2020.08.10.07.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 07:15:28 -0700 (PDT)
Date:   Mon, 10 Aug 2020 16:15:26 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Tamseel Shams <m.shams@samsung.com>
Cc:     kgene@kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, alim.akhtar@samsung.com
Subject: Re: [RFT PATCH v5] serial: samsung: Removes the IRQ not found warning
Message-ID: <20200810141526.GA12448@pi3>
References: <CGME20200810032514epcas5p1140fe0e44f3727953480ff0531c76b0c@epcas5p1.samsung.com>
 <20200810030021.45348-1-m.shams@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200810030021.45348-1-m.shams@samsung.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Aug 10, 2020 at 08:30:21AM +0530, Tamseel Shams wrote:
> In few older Samsung SoCs like s3c2410, s3c2412
> and s3c2440, UART IP is having 2 interrupt lines.
> However, in other SoCs like s3c6400, s5pv210,
> exynos5433, and exynos4210 UART is having only 1
> interrupt line. Due to this, "platform_get_irq(platdev, 1)"
> call in the driver gives the following false-positive error:
> "IRQ index 1 not found" on newer SoC's.
> 
> This patch adds the condition to check for Tx interrupt
> only for the those SoC's which have 2 interrupt lines.
> 
> Signed-off-by: Tamseel Shams <m.shams@samsung.com>
> ---
> Commit message is changed.
> 
> Added RFT, for older platform.
>  
> Addressed Krzysztof's review comments [1]
> [1] -> https://lkml.org/lkml/2020/7/21/150
> 
>  drivers/tty/serial/samsung_tty.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
