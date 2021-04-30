Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC535C433B4
	for <linux-serial@archiver.kernel.org>; Fri, 30 Apr 2021 15:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A56186144B
	for <linux-serial@archiver.kernel.org>; Fri, 30 Apr 2021 15:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhD3PTQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 30 Apr 2021 11:19:16 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:40753 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhD3PTQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 30 Apr 2021 11:19:16 -0400
Received: by mail-oi1-f173.google.com with SMTP id u16so53015140oiu.7;
        Fri, 30 Apr 2021 08:18:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5384NKLEMU9HGIIjdN+H7n8KjDIELf2F9qcnO+c7HQk=;
        b=kZI94bYTL6B0xEsuUo4MzDG+KZhV3nANmNAKO3p6BK9BYc+WmUfhEbKYM9PZzlZncS
         jQ/8DOTIvjqa2j0HeOn8xz499+a3wUt08tJGKLP8BQBTucB2PrEmus0aDxDZ5cpqCXD0
         1Kc9X9HJ20IYDy9KrualXs5OSW8iIhXsk18o3i3DjSOWQXzOUJIF0LMbfFjUGHz8/2pk
         61IJaQVRgPrRwni3PWLt2vGHLeXlP849B9u0JET/3w747UbOQJIawxryiB+nTKomW1ea
         6xCkqMpeKOJQf4wjoq2DKk3ILXijqfwLOD2+4Td0TkYMWil1NDD9ocV2QarEVLnVZgw8
         aYig==
X-Gm-Message-State: AOAM531ZMIL32hgtDT8OvkYnmVHPNdrUNztPIXNZNGTuuKyq9KPi1e7/
        gbZ3OyeuimY/uGEZm/Zxkg==
X-Google-Smtp-Source: ABdhPJwf/WD6axTKKyPNM4Yg1tES5AKc0U4Su/y1wYHek1a1jZozdjSNj0RN7KnSbGcODI1u/dhz7Q==
X-Received: by 2002:a05:6808:13cf:: with SMTP id d15mr1747186oiw.11.1619795907672;
        Fri, 30 Apr 2021 08:18:27 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p22sm824449otf.25.2021.04.30.08.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 08:18:26 -0700 (PDT)
Received: (nullmailer pid 3343637 invoked by uid 1000);
        Fri, 30 Apr 2021 15:18:25 -0000
Date:   Fri, 30 Apr 2021 10:18:25 -0500
From:   Rob Herring <robh@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: serial: Normalize the node name of
 the serial port
Message-ID: <20210430151825.GA3339934@robh.at.kernel.org>
References: <20210422085837.513-1-thunder.leizhen@huawei.com>
 <20210422085837.513-2-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210422085837.513-2-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Apr 22, 2021 at 04:58:35PM +0800, Zhen Lei wrote:
> Only letters, digits, and commas that describe the base address of the
> serial port in hexadecimal format are allowed.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  Documentation/devicetree/bindings/serial/serial.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/serial/serial.yaml b/Documentation/devicetree/bindings/serial/serial.yaml
> index 65e75d040521..71aec7fda07d 100644
> --- a/Documentation/devicetree/bindings/serial/serial.yaml
> +++ b/Documentation/devicetree/bindings/serial/serial.yaml
> @@ -21,7 +21,7 @@ description:
>  
>  properties:
>    $nodename:
> -    pattern: "^serial(@.*)?$"
> +    pattern: "^serial(@[0-9a-f,]+)?$"

The format of unit-addresses is dictated by the bus (parent), so this is 
the wrong place to enforce this. 

Rob
