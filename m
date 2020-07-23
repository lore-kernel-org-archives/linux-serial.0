Return-Path: <SRS0=2ftc=BC=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE350C433EA
	for <linux-serial@archiver.kernel.org>; Thu, 23 Jul 2020 21:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0631207C4
	for <linux-serial@archiver.kernel.org>; Thu, 23 Jul 2020 21:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595539689;
	bh=pk+rm6RtFtDuDJYX5QlmBpWj1i6nuD3M8mLx0YOEiqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zBMX1bEK9AoSiBWLy97ZaPyntRg3sS8ZfnjcmncVM7SZF08K/6a3sYmFVcmeouWk5
	 HMsMkUWabZHd+2NTv+VuBD7Tm1gxjSkylGmCSFkP+x8uqVz5W6NMuHiQRbj9x77z6K
	 0mrho/sIgNdZue3c+z68+YQ1b3Q6XEozY4TkFX+Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgGWV2F (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 23 Jul 2020 17:28:05 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:36546 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgGWV2F (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 23 Jul 2020 17:28:05 -0400
Received: by mail-il1-f195.google.com with SMTP id x9so5601096ila.3;
        Thu, 23 Jul 2020 14:28:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SGrdVeSEpiWCWaFeRxn1THIMaeD/i6V3qXeYtCopQ5M=;
        b=cj1xRVdGqSA8pMYHHNLZp18j2ZVe6BRkkzoUZdOnmbdYTm6gls5SoAEWjm0VVLzN9U
         FwOVQsEFM8DIfvkuQLFyMKuV7/iJRvX/xW4FRNRL5/cCaZcHNlBj3Ycqba9nZLwaHRij
         pQrknlUiI5wJemxvfLaL2ANO3iudAWHtk9Y2Bn05xbu7Ys1KHRnpp2b6lFiJcmnm0QSD
         4bqQSg7OGVuIFQjqD376Tz6TRZ037maBKQx/0NpUSVoof+QgELMfgTH5Xr65j12Lodto
         rQulRlX1DaatI0iMeIJVXIfdAVyLi3FKYXtep3ZNLiryIdz49cxh48c0hbVVwR16DWj5
         Awbw==
X-Gm-Message-State: AOAM533X62y3CZYWolfv7NESZ0sNt/huTeQVGlYXvuZ1SBe0EvMMV7eQ
        jz4siNZI8Lfk0DB1GHGYWQ==
X-Google-Smtp-Source: ABdhPJz7NZ07oV2YI6+xdgYtE3bNTA7ewz+4xk+gmQaRX1u2WcAI2yQMS726ZBZHBEXxDhgzeLJPAA==
X-Received: by 2002:a92:9e5c:: with SMTP id q89mr317408ili.265.1595539684704;
        Thu, 23 Jul 2020 14:28:04 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id t21sm2086484ioc.0.2020.07.23.14.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 14:28:04 -0700 (PDT)
Received: (nullmailer pid 889370 invoked by uid 1000);
        Thu, 23 Jul 2020 21:28:03 -0000
Date:   Thu, 23 Jul 2020 15:28:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Seiya Wang <seiya.wang@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-kernel@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: serial: Add compatible for Mediatek
 MT8192
Message-ID: <20200723212803.GA889323@bogus>
References: <20200723090731.4482-1-seiya.wang@mediatek.com>
 <20200723090731.4482-3-seiya.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723090731.4482-3-seiya.wang@mediatek.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, 23 Jul 2020 17:07:29 +0800, Seiya Wang wrote:
> This commit adds dt-binding documentation of uart for Mediatek MT8192 SoC
> Platform.
> 
> Signed-off-by: Seiya Wang <seiya.wang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/serial/mtk-uart.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
