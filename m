Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A167CC433E3
	for <linux-serial@archiver.kernel.org>; Fri, 26 Mar 2021 20:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90D3761A02
	for <linux-serial@archiver.kernel.org>; Fri, 26 Mar 2021 20:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbhCZUTN (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 26 Mar 2021 16:19:13 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:34577 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbhCZUSz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 26 Mar 2021 16:18:55 -0400
Received: by mail-io1-f50.google.com with SMTP id x16so6670300iob.1;
        Fri, 26 Mar 2021 13:18:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z5fnCZ8eriALH/wVywXxei9R/GBDBcSFb+uK/SYuxjI=;
        b=ZMQV0bYl6z2dr9dfUPGZwyl6zmW+OF9FL17gwg5Ea/rF7bgzv/mtHnJKGrO5wN0IfS
         L3SiBnKWfGXnFvLj8ZchlQUEFsGGERtij1tdyUKhINHScWZTnY1ZtTkw7QOAg4X0QMWc
         rGpropGgbCB/48DDJzyHnwrRw9WdZe0iTSIbmMn1DNWhItPlJEbzjBxijxmlDJFZzil1
         eQHc0MkoPFOxdqnyAeuFrVcNpEZEsR3bsgbiO6zoovl+xd3vwzVTAxKlBFQFovgfXVK/
         Dc5dqvOsMNPDqawh9cIE8HTOL5cMX8Pq5QKXNpH2QXa7CXYGPw4OXMC1m1iO8U1FL/aI
         JdvQ==
X-Gm-Message-State: AOAM532JjKihVWJ7TxJDbfbkjl/Jt6q3fagASZxNAVUrTjjFv00sD9P7
        ot4NMrbQRUFIFKat/dXwR0lLlagaTA==
X-Google-Smtp-Source: ABdhPJw8hxpqliqEqveCE0yBH3PreXUErj+X7V6Syn7BEnO+wv2aoj4g5Y+Msh+D4irsnKkg8+KstA==
X-Received: by 2002:a02:cb8f:: with SMTP id u15mr13266031jap.45.1616789935338;
        Fri, 26 Mar 2021 13:18:55 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id r15sm4864130iot.5.2021.03.26.13.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 13:18:53 -0700 (PDT)
Received: (nullmailer pid 3799500 invoked by uid 1000);
        Fri, 26 Mar 2021 20:18:50 -0000
Date:   Fri, 26 Mar 2021 14:18:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     dillon.minfei@gmail.com
Cc:     mcoquelin.stm32@gmail.com, devicetree@vger.kernel.org,
        gregkh@linuxfoundation.org, lkp@intel.com,
        valentin.caron@foss.st.com, linux-arm-kernel@lists.infradead.org,
        vladimir.murzin@arm.com, afzal.mohd.ma@gmail.com,
        erwan.leray@foss.st.com, erwan.leray@st.com,
        linux-stm32@st-md-mailman.stormreply.com,
        Alexandre.torgue@foss.st.com, linux-serial@vger.kernel.org,
        rong.a.chen@intel.com, a.fatoum@pengutronix.de,
        linux-kernel@vger.kernel.org, linux@armlinux.org.uk
Subject: Re: [PATCH v6 9/9] dt-bindings: serial: stm32: Use 'type: object'
 instead of false for 'additionalProperties'
Message-ID: <20210326201850.GA3799452@robh.at.kernel.org>
References: <1616757302-7889-1-git-send-email-dillon.minfei@gmail.com>
 <1616757302-7889-8-git-send-email-dillon.minfei@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616757302-7889-8-git-send-email-dillon.minfei@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, 26 Mar 2021 19:15:02 +0800, dillon.minfei@gmail.com wrote:
> From: dillon min <dillon.minfei@gmail.com>
> 
> To use additional properties 'bluetooth' on serial, need replace false with
> 'type: object' for 'additionalProperties' to make it as a node, else will
> run into dtbs_check warnings.
> 
> 'arch/arm/boot/dts/stm32h750i-art-pi.dt.yaml: serial@40004800:
> 'bluetooth' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Fixes: af1c2d81695b ("dt-bindings: serial: Convert STM32 UART to json-schema")
> Reported-by: kernel test robot <lkp@intel.com>
> Tested-by: Valentin Caron <valentin.caron@foss.st.com>
> Signed-off-by: dillon min <dillon.minfei@gmail.com>
> ---
> 
> v6: no changes
> 
>  Documentation/devicetree/bindings/serial/st,stm32-uart.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
