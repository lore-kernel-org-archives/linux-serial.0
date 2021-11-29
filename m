Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E091C433EF
	for <linux-serial@archiver.kernel.org>; Mon, 29 Nov 2021 00:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbhK2A15 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 28 Nov 2021 19:27:57 -0500
Received: from mail-oi1-f182.google.com ([209.85.167.182]:36435 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376343AbhK2AZ4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 28 Nov 2021 19:25:56 -0500
Received: by mail-oi1-f182.google.com with SMTP id t23so31305634oiw.3;
        Sun, 28 Nov 2021 16:22:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CbsF1xcuqt7P+diOdv7BChnjrBiFtTcwuF6zSxf2jN0=;
        b=0+3QEsgURLIQt/P3tcLzv7PikzSywWvBit3Ssp4lF/7LdL1dIjuQsFkq6oQ1v4eT4X
         DKpUJetBNO78eIg5acadQ+f9pyCab1wMqK1E8lGOoPUszz1xKpUQZrqgpwf6NmhsOglc
         FDhsSPq1d+ztuGhNjAFA+y9Rj9kpClTO+D5H0Ir8UFhj2mJFTu46Qm9cN9T3YnGaOJ1i
         IcwcfRMNCcxYkE5P4ZclbXChJ0KFfo/hH61PoR30WBr/FEvyRQvDE0v4nGGCuqPm2WJB
         IcczbBCyE6Xcf5zopfoHHu76mK/YcCA6nkhJKk2Cq3VAjdU9xFh5hRaGyz4ZhO7KBtod
         OT7g==
X-Gm-Message-State: AOAM533o20zwrdk3Ils0UZTBUMcDQaoiN3+EcQ64vRWjHZ9exgMmPerl
        Vr7vULwpOHLwlFNXiBZSdw==
X-Google-Smtp-Source: ABdhPJwr8Vf3nh0ZqXFcTKdx06qCGZIzJbgoshUGgimoxAMNjQBrUZt9xpq78T2/PA3iWpzS+kUFsA==
X-Received: by 2002:aca:646:: with SMTP id 67mr37018108oig.175.1638145359861;
        Sun, 28 Nov 2021 16:22:39 -0800 (PST)
Received: from robh.at.kernel.org ([172.58.99.242])
        by smtp.gmail.com with ESMTPSA id x16sm2382207ott.8.2021.11.28.16.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 16:22:39 -0800 (PST)
Received: (nullmailer pid 2879901 invoked by uid 1000);
        Mon, 29 Nov 2021 00:22:36 -0000
Date:   Sun, 28 Nov 2021 18:22:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hammer Hsieh <hammerh0314@gmail.com>
Cc:     Hammer Hsieh <hammer.hsieh@sunplus.com>, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        wells.lu@sunplus.com, robh+dt@kernel.org, tony.huang@sunplus.com,
        linux-serial@vger.kernel.org, jirislaby@kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v3 1/2] dt-bindings:serial:Add bindings doc for Sunplus
 SoC UART Driver
Message-ID: <YaQdTLoN/FFPtI3A@robh.at.kernel.org>
References: <1635752903-14968-1-git-send-email-hammer.hsieh@sunplus.com>
 <1637299163-6460-1-git-send-email-hammer.hsieh@sunplus.com>
 <1637299163-6460-2-git-send-email-hammer.hsieh@sunplus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1637299163-6460-2-git-send-email-hammer.hsieh@sunplus.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, 19 Nov 2021 13:19:22 +0800, Hammer Hsieh wrote:
> Add bindings doc for Sunplus SoC UART Driver
> 
> Signed-off-by: Hammer Hsieh <hammer.hsieh@sunplus.com>
> ---
> Changes in v3:
>  - Modify yaml file based on uart driver (remove dma function).
> 
>  .../bindings/serial/sunplus,sp7021-uart.yaml       | 58 ++++++++++++++++++++++
>  MAINTAINERS                                        |  5 ++
>  2 files changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
