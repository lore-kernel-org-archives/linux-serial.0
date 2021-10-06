Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CD6C433EF
	for <linux-serial@archiver.kernel.org>; Wed,  6 Oct 2021 21:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 354EE61177
	for <linux-serial@archiver.kernel.org>; Wed,  6 Oct 2021 21:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239583AbhJFVJw (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 6 Oct 2021 17:09:52 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:39755 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239454AbhJFVJw (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 6 Oct 2021 17:09:52 -0400
Received: by mail-ot1-f49.google.com with SMTP id j11-20020a9d190b000000b00546fac94456so4817850ota.6;
        Wed, 06 Oct 2021 14:07:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=gKyYCRzor8NqVeWyaMvpWRZAZvL0zYpO2MrhtBbCXXI=;
        b=H0LBcMLuXxfOuSj8cP4xoZncnxLR93um2txNtAxeOaR+h2DbSFSoryrhUbhzrKFNsj
         O+BNYCkh1qXVtnGQtBTgG7tCX8Z/tA2LAn0SHfj3Tr3+4utkw61eH0aG7wvKXer+c5eb
         inY1IrB3Q07d0a8kQLCbqx0YVqHA6yK4nidxCqhmkcbsw6n2IPnW6H7smn6ixd3HXpoZ
         a80XTXBAep6aa5G/NEhZaePO50XZBQHO2k55paPcjh8SZtGv5zGKenDr8N/GlAnvSwXw
         OMOo52YqAIqpUUN8XWrIyH57RYI6U6JNawbFEfaA6dLr9/C6xI1FAh4Hu6DZ2C3k4vJp
         IsWA==
X-Gm-Message-State: AOAM532xRkK+k6Qg4AyrHJ/1ZfVRa/uNzXrPQ1iNCgTUNecytDvnT4Iv
        J+ckQ12+buQgBv4OXZ4SCQ==
X-Google-Smtp-Source: ABdhPJyaP6AYmkHmSM+Ba+z1SgPqZVHEgktY6WljJpCCCS50gZ6TDQa/i+zfiXOL96FNtQ2m/4UaGw==
X-Received: by 2002:a05:6830:23a3:: with SMTP id m3mr397205ots.111.1633554479432;
        Wed, 06 Oct 2021 14:07:59 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id s189sm3647339oif.14.2021.10.06.14.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 14:07:58 -0700 (PDT)
Received: (nullmailer pid 2876990 invoked by uid 1000);
        Wed, 06 Oct 2021 21:07:57 -0000
Date:   Wed, 6 Oct 2021 16:07:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>, linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v7 3/6] dt-bindings: mvebu-uart: document DT bindings for
 marvell,armada-3700-uart-clock
Message-ID: <YV4QLXbN8xR+OR/L@robh.at.kernel.org>
References: <20210930095838.28145-1-pali@kernel.org>
 <20210930095838.28145-4-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210930095838.28145-4-pali@kernel.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, 30 Sep 2021 11:58:35 +0200, Pali Rohár wrote:
> This change adds DT bindings documentation for device nodes with compatible
> string "marvell,armada-3700-uart-clock".
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> 
> ---
> Changes in v7
> * Fix errors
> 
> Changes in v6
> * Fix license
> * Rename node to clock-controller@12010
> * Remove maxItems
> ---
>  .../clock/marvell,armada-3700-uart-clock.yaml | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/marvell,armada-3700-uart-clock.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
