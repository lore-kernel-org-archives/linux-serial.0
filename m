Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF052C433E6
	for <linux-serial@archiver.kernel.org>; Mon, 15 Mar 2021 16:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A58B164F21
	for <linux-serial@archiver.kernel.org>; Mon, 15 Mar 2021 16:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbhCOQ1P (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Mar 2021 12:27:15 -0400
Received: from mail-il1-f172.google.com ([209.85.166.172]:40351 "EHLO
        mail-il1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbhCOQ0x (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Mar 2021 12:26:53 -0400
Received: by mail-il1-f172.google.com with SMTP id e7so9901463ile.7;
        Mon, 15 Mar 2021 09:26:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uNo6vdAx+jzMNRzSxihSuYm26CfiZWtwAB/YSlTgofg=;
        b=PvCsskFvMP9wvE+EB8y4IgPN/FP2Uy09S0u3hc8xaYG6c7dk45nERtE/MMTxXxCpl+
         PuYrhfR+gsfEvfHQd9HysnKb+0iAgZ4mivy9xS6B2JJfKEyYmepR0bAfJuPGdjmHya/I
         zjH1sfZT857HI2LsnOQzzAhgXVyk8ex9bnw+9n/W/eCJa4Pcn40Y7AkkIrh/M3ZTYNjf
         WPgULmU1Kokn6nGFTdxUUA8Hl6PuKrn3lwtQfrKohcUbNONGwtD2i8Y8M68iIE4yAkkk
         8wu3R+sF+gJXDi6JsIK3lkK1K8TJtuS0EDfx68XtUEntZkf8VE8jxj9RT1f78Gy8iCHM
         ghtA==
X-Gm-Message-State: AOAM5330NzdYvQhLZEdIsDciMGPzBHjW/j3e9IcxAf/42YUYknMJlRfg
        ClnoXXeit4DdtTawsLrOJQ==
X-Google-Smtp-Source: ABdhPJw+veskbFJEXXCKZ2E/BDJV2CNNfMgN0Pv1qQFI928Wh1rpDctvLR3CxE8mWqEyWroMro7orw==
X-Received: by 2002:a92:d6cf:: with SMTP id z15mr355098ilp.40.1615825612758;
        Mon, 15 Mar 2021 09:26:52 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id s9sm7125949iob.33.2021.03.15.09.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 09:26:52 -0700 (PDT)
Received: (nullmailer pid 982357 invoked by uid 1000);
        Mon, 15 Mar 2021 16:26:48 -0000
Date:   Mon, 15 Mar 2021 10:26:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     dillon.minfei@gmail.com
Cc:     linux-kernel@vger.kernel.org, mcoquelin.stm32@gmail.com,
        gregkh@linuxfoundation.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux@armlinux.org.uk, erwan.leray@st.com,
        linux-arm-kernel@lists.infradead.org, erwan.leray@foss.st.com,
        alexandre.torgue@st.com, a.fatoum@pengutronix.de,
        robh+dt@kernel.org, afzal.mohd.ma@gmail.com,
        vladimir.murzin@arm.com, alexandre.torgue@foss.st.com
Subject: Re: [PATCH v3 3/9] dt-bindings: pinctrl: stm32: Add stm32h750 pinctrl
Message-ID: <20210315162648.GB981570@robh.at.kernel.org>
References: <1615801436-3016-1-git-send-email-dillon.minfei@gmail.com>
 <1615801436-3016-4-git-send-email-dillon.minfei@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615801436-3016-4-git-send-email-dillon.minfei@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, 15 Mar 2021 17:43:50 +0800, dillon.minfei@gmail.com wrote:
> From: dillon min <dillon.minfei@gmail.com>
> 
> This patch intend to add pinctrl configuration support for
> stm32h750 value line
> 
> The datasheet of stm32h750 value line can be found at:
> https://www.st.com/resource/en/datasheet/stm32h750ib.pdf
> 
> Signed-off-by: dillon min <dillon.minfei@gmail.com>
> ---
>  Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

