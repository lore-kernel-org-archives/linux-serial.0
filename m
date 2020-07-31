Return-Path: <SRS0=+g8y=BK=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A426C433DF
	for <linux-serial@archiver.kernel.org>; Fri, 31 Jul 2020 21:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF79622BF5
	for <linux-serial@archiver.kernel.org>; Fri, 31 Jul 2020 21:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596230032;
	bh=hMIRdwmttvYnG6R2d8TU5SjlTpwQmxcQIYzbWnRPxws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jnWQBmfYEvZpthFLu9P4NiOoDQDnH5RfZcT+jQGS2Ub89pRLZjjVot65iyjjHjRU4
	 kCdvkMdzJ0uik1XW1f02UEH4pWkj5rOba26QQaYErgnt1qoIlYDXHz0A3Hl8WHbdFY
	 cdgKneyQLQWS5k1GFKg8cFtnAuL26nNXpc7DFSfM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgGaVNw (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 31 Jul 2020 17:13:52 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46638 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbgGaVNw (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 31 Jul 2020 17:13:52 -0400
Received: by mail-io1-f67.google.com with SMTP id a5so17762287ioa.13;
        Fri, 31 Jul 2020 14:13:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0kUiZodQVGoScmGeQBAxfGuNNmJgniCksGkhC2caiFo=;
        b=iTNNulpZ0ubAvngsZf4lqCo7QjBOD8lJt6fkQqRf1qgoYiU0KerajYMIZqGEDesI44
         z4grd22LUCOEObrBWVLErSu0XeA5UFTRHYGdYlCrZUneZB7+Cia9P5KWEyxcaEV977Z5
         I8340FHuodMyHkoSksQ8HtyyC7e5kR3LbK5OIeLtmo4Bd8hMjKP/UAG/LVzH3gLszOCO
         RRaba8/qpy2mBgEdp17Z/eBxWqxsij8GrIFnoDGX7rKrAjlXBrKXW/f1+za7hut7k2Iu
         VYWdv1PFd+u+tFxBoViMM6cquPwq5WDFK7MDm4vz8HT8MQTsY4VqijhGbPGee+x+/Wmf
         Czzg==
X-Gm-Message-State: AOAM5337vY+/L9qttv9eHLP2uX4YoDi84VYgo6068+IIYw2IVMMdjwPM
        a4d2UN2PR2zXNMe+GlVM84ujnzr+JA==
X-Google-Smtp-Source: ABdhPJxkduuS7JPJS9dhqjYDKOUcWmOcyCaz1IWXXBMarQCX27BuT7ZuW1Xheh1N6rFpWa7XPS02Qw==
X-Received: by 2002:a05:6638:2653:: with SMTP id n19mr7238909jat.34.1596230031583;
        Fri, 31 Jul 2020 14:13:51 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id s10sm5360289ilh.4.2020.07.31.14.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 14:13:51 -0700 (PDT)
Received: (nullmailer pid 800839 invoked by uid 1000);
        Fri, 31 Jul 2020 21:13:49 -0000
Date:   Fri, 31 Jul 2020 15:13:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Seiya Wang <seiya.wang@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        srv_heupstream@mediatek.com, Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 3/3] dt-bindings: timer: Add compatible for Mediatek
 MT8192
Message-ID: <20200731211349.GA800755@bogus>
References: <20200729013100.19539-1-seiya.wang@mediatek.com>
 <20200729013100.19539-4-seiya.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729013100.19539-4-seiya.wang@mediatek.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, 29 Jul 2020 09:31:00 +0800, Seiya Wang wrote:
> This commit adds dt-binding documentation of timer for Mediatek MT8192 SoC
> Platform.
> 
> Signed-off-by: Seiya Wang <seiya.wang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
