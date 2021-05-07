Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1FCCC433B4
	for <linux-serial@archiver.kernel.org>; Fri,  7 May 2021 01:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCB4F610CE
	for <linux-serial@archiver.kernel.org>; Fri,  7 May 2021 01:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbhEGBPv (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 6 May 2021 21:15:51 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:45845 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbhEGBPv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 6 May 2021 21:15:51 -0400
Received: by mail-ot1-f52.google.com with SMTP id f75-20020a9d03d10000b0290280def9ab76so6592653otf.12;
        Thu, 06 May 2021 18:14:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oEfCN0pfoA/qDroFhgTH+ere0rMR3Q9MSvHYsosWDl8=;
        b=SYbdMGQlWXB9JVLfx+09kg2z6CmWN/VmrzAfWH6SQwi2LUgq+iaMweh0rKpZX+LYs8
         NyMOuCM175oWGO7XfLIhiayR4Nf8W3WvL29WUAuOHBffEnBdWq5vxdMqnIqbdkEXwqUW
         dxZlfhaujmJY7q/znQ+YbJjU0G90pVJQ1a4FFzjLuDhegXQzjKu04NObMqr/+w6mfVP0
         VQTuIEb9fuZgW9FwQMYUGO+sWSFr3eazkHa7eXHSat9esYgWzHly7qbNE/3Y5eNcsFry
         1gG9A9ykI/VohGKQnjLjURxriwvaXrY2ye503lRntwuD9U+Rvu8bvCRAeFz0lFPPFm7U
         TkDw==
X-Gm-Message-State: AOAM532YCRuWu9vv/TjGmaIB+/oBiP91ULGJNFk+HJ+KbkcNrrJNQGrs
        awDaSnzXfMRAo0WDWPjWDw==
X-Google-Smtp-Source: ABdhPJwH6pLpfJTNIPyBF2g8fBrl9A07O+m3Rx4UXrIsglOnYIjflryN7rQAEjYLNNSULq8cGge4wQ==
X-Received: by 2002:a9d:7997:: with SMTP id h23mr6097466otm.366.1620350091104;
        Thu, 06 May 2021 18:14:51 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f13sm948681ote.46.2021.05.06.18.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 18:14:50 -0700 (PDT)
Received: (nullmailer pid 1127217 invoked by uid 1000);
        Fri, 07 May 2021 01:14:49 -0000
Date:   Thu, 6 May 2021 20:14:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-stm32 <linux-stm32@st-md-mailman.stormreply.com>,
        Rob Herring <robh+dt@kernel.org>,
        Al Cooper <alcooperx@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        devicetree <devicetree@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: serial: Change to reference the
 kernel-defined serial.yaml
Message-ID: <20210507011449.GA1126886@robh.at.kernel.org>
References: <20210506132049.1513-1-thunder.leizhen@huawei.com>
 <20210506132049.1513-2-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210506132049.1513-2-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, 06 May 2021 21:20:48 +0800, Zhen Lei wrote:
> The /schemas/serial.yaml from dt-schema only has the property $nodename,
> whereas the kernel-defined /schemas/serial/serial.yaml contains more
> useful properties, support for more complex application scenarios.
> 
> For example:
> 1) The property "current-speed" in fsl-lx2160a.dtsi
> 2) The subnode "bluetooth" in hi3660-hikey960.dts
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  Documentation/devicetree/bindings/serial/8250.yaml            | 2 +-
>  .../devicetree/bindings/serial/brcm,bcm7271-uart.yaml         | 2 +-
>  Documentation/devicetree/bindings/serial/ingenic,uart.yaml    | 2 +-
>  Documentation/devicetree/bindings/serial/pl011.yaml           | 4 ++--
>  Documentation/devicetree/bindings/serial/qca,ar9330-uart.yaml | 4 ++--
>  Documentation/devicetree/bindings/serial/renesas,em-uart.yaml | 2 +-
>  Documentation/devicetree/bindings/serial/samsung_uart.yaml    | 2 +-
>  Documentation/devicetree/bindings/serial/sifive-serial.yaml   | 4 ++--
>  .../devicetree/bindings/serial/snps-dw-apb-uart.yaml          | 2 +-
>  Documentation/devicetree/bindings/serial/st,stm32-uart.yaml   | 3 +--
>  10 files changed, 13 insertions(+), 14 deletions(-)
> 

Thanks for doing this!

Reviewed-by: Rob Herring <robh@kernel.org>
