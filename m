Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA2FC433E9
	for <linux-serial@archiver.kernel.org>; Mon, 15 Mar 2021 16:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDF5C64F3A
	for <linux-serial@archiver.kernel.org>; Mon, 15 Mar 2021 16:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbhCOQ1O (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Mar 2021 12:27:14 -0400
Received: from mail-io1-f41.google.com ([209.85.166.41]:33478 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbhCOQ0t (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Mar 2021 12:26:49 -0400
Received: by mail-io1-f41.google.com with SMTP id n132so34037282iod.0;
        Mon, 15 Mar 2021 09:26:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0ieBQNPwnDUff5E3dhDZ7DWgA7wwq4ZCQbYomZZouuY=;
        b=KH2UVX7W/JOilvnwmU7392/EybNjN6qz/wQrniF+YfHIEPnmQTLcnlHDTV13ozG5NJ
         zhEehHWlrujCEJVLztWqxMmGN2w9rPrLGMDStDwHE8Qv4d5Vwe4tQz0cZaXtnH/cHRJA
         wllkRqYgdKU+FnBwCbgMfzQetZQGpKQZenPlcC/q8Z5DOxeCxtI8bgUobpZdbxxmWf2R
         M8BHB6JlMhfdxnNpPQDlq6Agxl4s2IrS2AydnZnpQUmTl8Mb2RHTcAKvtrXGi5si9bw4
         NOUhgYfeS+m98dLOJJx0SMY4DQBmtU1JSPuZ+To3yxN6fXPPLQ+ueMkKIHVwehhWTXd3
         44sQ==
X-Gm-Message-State: AOAM533CZbvtOsI29jW9hXVvljzBYwNMyfSmwc2dmewbeRVPNciIImlg
        iLg2iXcjeNz4Ocjxt4RDow==
X-Google-Smtp-Source: ABdhPJxLIWknlh7o/MSDV+7LZUrCDS1i2kWkQTRH9ONlNxCo83oQ5gys+66T7t4mkSC+AdTd1uBUxg==
X-Received: by 2002:a05:6638:218f:: with SMTP id s15mr10351318jaj.58.1615825608370;
        Mon, 15 Mar 2021 09:26:48 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id j5sm1410203ile.52.2021.03.15.09.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 09:26:47 -0700 (PDT)
Received: (nullmailer pid 982241 invoked by uid 1000);
        Mon, 15 Mar 2021 16:26:45 -0000
Date:   Mon, 15 Mar 2021 10:26:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     dillon.minfei@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        alexandre.torgue@foss.st.com, robh+dt@kernel.org,
        alexandre.torgue@st.com, linux@armlinux.org.uk,
        vladimir.murzin@arm.com, linux-stm32@st-md-mailman.stormreply.com,
        a.fatoum@pengutronix.de, erwan.leray@foss.st.com,
        linux-kernel@vger.kernel.org, mcoquelin.stm32@gmail.com,
        gregkh@linuxfoundation.org, erwan.leray@st.com,
        linux-serial@vger.kernel.org, afzal.mohd.ma@gmail.com
Subject: Re: [PATCH v3 2/9] dt-bindings: arm: stm32: Add compatible strings
 for ART-PI board
Message-ID: <20210315162645.GA981570@robh.at.kernel.org>
References: <1615801436-3016-1-git-send-email-dillon.minfei@gmail.com>
 <1615801436-3016-3-git-send-email-dillon.minfei@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615801436-3016-3-git-send-email-dillon.minfei@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, 15 Mar 2021 17:43:49 +0800, dillon.minfei@gmail.com wrote:
> From: dillon min <dillon.minfei@gmail.com>
> 
> Art-pi based on stm32h750xbh6, with following resources:
> 
> -8MiB QSPI flash
> -16MiB SPI flash
> -32MiB SDRAM
> -AP6212 wifi, bt, fm
> 
> detail information can be found at:
> https://art-pi.gitee.io/website/
> 
> Signed-off-by: dillon min <dillon.minfei@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

