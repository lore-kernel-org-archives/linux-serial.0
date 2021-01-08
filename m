Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C34C433E9
	for <linux-serial@archiver.kernel.org>; Fri,  8 Jan 2021 03:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 221AE236F9
	for <linux-serial@archiver.kernel.org>; Fri,  8 Jan 2021 03:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbhAHDl6 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 7 Jan 2021 22:41:58 -0500
Received: from mail-il1-f176.google.com ([209.85.166.176]:40498 "EHLO
        mail-il1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbhAHDl6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 7 Jan 2021 22:41:58 -0500
Received: by mail-il1-f176.google.com with SMTP id e7so8994959ile.7;
        Thu, 07 Jan 2021 19:41:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DTFufe6Sy2YM2DeAfpZBvXqla7sbEC0jFDWNKo2hAZM=;
        b=YJ+pyR70Dcs6yXe/il/a3HxCXVUZeFNTlzh9KuJcoygVdps6CbaofRIpBgF0vx8r1x
         uBeeMZytQ6s65gU/BDZQxF6vYH6CPx+YoknHgTreoTuJJjaoDosAmdee8dAg5YRXzl1x
         mvCv6cmsqCA4BxHb8vI3Zn9WgEjbrm/ctA0/Fi+vhaKH5TiOCTpJb58uYstDH2+XFE1+
         Vmy/576R6K6lgX1jwx70bchfi1CTuEhPgmyNMwYLDi0pz+QBDiDJxtrz07nDJz7mzIfx
         umW8aIO9Obn9JkhRY+ZYvz5U6PApleVIe9z8R075sefFyFd4tDHp5ANUQwx+HuD0JyCV
         w3fQ==
X-Gm-Message-State: AOAM533v/gfdD8uXGo3+jah2ItMqw7hLzm/JBZZUj5AEkhjy+3k2rXsA
        UNG8YqHZt5h8GYP2BQ8gGilfyMTjBg==
X-Google-Smtp-Source: ABdhPJw1wGmcEGsYPOLEDGtXI5bijHQS2zxSUqYotD0M+dcSsFSsnGxfAEMW4BqENTSkIAQ/It09Kg==
X-Received: by 2002:a92:9f59:: with SMTP id u86mr2003489ili.205.1610077277235;
        Thu, 07 Jan 2021 19:41:17 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id n4sm5954847ilm.63.2021.01.07.19.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 19:41:16 -0800 (PST)
Received: (nullmailer pid 1845862 invoked by uid 1000);
        Fri, 08 Jan 2021 03:41:15 -0000
Date:   Thu, 7 Jan 2021 20:41:14 -0700
From:   Rob Herring <robh@kernel.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-renesas-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH 3/6] dt-bindings: serial: renesas,hscif: Add r8a779a0
 support
Message-ID: <20210108034114.GA1845830@robh.at.kernel.org>
References: <20201228112715.14947-1-wsa+renesas@sang-engineering.com>
 <20201228112715.14947-4-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201228112715.14947-4-wsa+renesas@sang-engineering.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, 28 Dec 2020 12:27:10 +0100, Wolfram Sang wrote:
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  Documentation/devicetree/bindings/serial/renesas,hscif.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
