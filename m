Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE8EC433EF
	for <linux-serial@archiver.kernel.org>; Mon,  7 Feb 2022 22:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243913AbiBGWOX (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 7 Feb 2022 17:14:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243902AbiBGWOW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 7 Feb 2022 17:14:22 -0500
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83530C061A73;
        Mon,  7 Feb 2022 14:14:22 -0800 (PST)
Received: by mail-oi1-f173.google.com with SMTP id u3so2724493oiv.12;
        Mon, 07 Feb 2022 14:14:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sQCDCj3+e+Dc5OzJAj/k0PQ1NJhIP60Z18RpM0DwG3c=;
        b=QWYfGrwb5aWy8HXRI2ejSDHUAKwhUOimCI9aex1ooClKqzgDxZUacSjAqN4ujNKh+z
         +8q5NWFgln5JwdZuoVEh6L8UcPrWausJ2U5YZBvNlZLQwxvYihh3hk2E11rlWvXQnDVJ
         jgHZ4zWwcPpsxlnjgYQS0VUDOae/il8MyuK3FbHNkPcSpkJ7bVxpVkj1IDKcgTtSTkMK
         TEDypAXNhfiJXyVvVts5TswtNAOi4whTEUT1GclKyD3VhNlc7DZFFq96DYYuigVKg+x2
         YMSuWd5k/cfoU1Jw5zNNx+/0loziYiwjqaSWtTx9Oxx8/qhdQM+5l8jhNyPyy252Oawl
         gMHw==
X-Gm-Message-State: AOAM532B3sWU3JTWNOQzM1qafjTU5yDxF94eK6t84bzXD7uSA5aDFtPB
        P3GPGSYTTuTATVTYstMRCQ==
X-Google-Smtp-Source: ABdhPJyyhaaXVGAE/AOlCQnz/doyik9GRDbbalbdk8mykVHPei01qLnN3MXjgv9ComtO4jFc+Y+ScA==
X-Received: by 2002:a05:6808:aa5:: with SMTP id r5mr491661oij.115.1644272061817;
        Mon, 07 Feb 2022 14:14:21 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id l18sm4471432oov.29.2022.02.07.14.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 14:14:21 -0800 (PST)
Received: (nullmailer pid 1020642 invoked by uid 1000);
        Mon, 07 Feb 2022 22:14:20 -0000
Date:   Mon, 7 Feb 2022 16:14:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     linux-serial@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Fugang Duan <fugang.duan@nxp.com>, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] dt-bindings: serial: fsl-lpuart: Add i.MX8DXL
 compatible
Message-ID: <YgGZvOQ+T6qEjhyj@robh.at.kernel.org>
References: <20220118131715.2051965-1-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118131715.2051965-1-abel.vesa@nxp.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, 18 Jan 2022 15:17:15 +0200, Abel Vesa wrote:
> Add i.MX8DXL lpuart compatible to the bindings documentation.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
> 
> Changes since v1:
>  * imx8dxl will only be backwards compatible with imx8qxp now,
>    like imx8qm
> 
> Here is the last version of this patch:
> https://lore.kernel.org/all/1640085372-1972-1-git-send-email-abel.vesa@nxp.com/
> 
>  Documentation/devicetree/bindings/serial/fsl-lpuart.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
