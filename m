Return-Path: <SRS0=eb60=62=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307BEC54E4A
	for <linux-serial@archiver.kernel.org>; Tue, 12 May 2020 14:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1098E206F5
	for <linux-serial@archiver.kernel.org>; Tue, 12 May 2020 14:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589295183;
	bh=X/7LZNJp6medNXXYa1hSvn26jmA2fs1Mwcif42l7Fg4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=A6HnVxBDtUnokNSUQwRrvA4t1Z2GkGOKq98M9ZjLxmTgB81CA9jyHkQAx+VPJp/3v
	 88H1O2GCAYWy+r44WUkhCewJP4Qn+GKB16klkZTcq18o5iZFGKO6wZR4PkX3+dNNH8
	 lRGFb0Q8R6HL9LzqWDz5H39ulvaYAHuYlcbxlasY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729756AbgELOxA (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 12 May 2020 10:53:00 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46636 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbgELOw7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 12 May 2020 10:52:59 -0400
Received: by mail-ot1-f68.google.com with SMTP id z25so10672616otq.13;
        Tue, 12 May 2020 07:52:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zvQTYh4b4eUlBTZLUxX1hHRbUDU2+a4tZbKUdGnF3aw=;
        b=SRzmVqAsJaWsfn0lMAMVnb0PLU0RsHTZJy67X/1Au9Mex2B+bRm+KCZAPJeEyDrIbk
         98HGSWAH12RkOagZUTcS684fWBN6C8G/Yp3x86ZBdPrlIcxj/D4doL7kbW7H1PQ9qVzN
         LRkNYVQREy+2jFeGaBMtxhu0+3dnDeYNv96lsy63IFB7ubJ1AZO5GJ22XTpII9bP4SGE
         12zAsIEV8DvyF8PK/C7PPNNjJ0Eqcv5gpwr0lxpFIU8bS1y6tH67HHr9uSCSNs+9CVB1
         zSwVDO4cKcQWrxitJumej3cnhYSv2As6iZMNDSQdFrNfZtsZMRLvaeFIn9B5i3R0dCkt
         AIhQ==
X-Gm-Message-State: AGi0PuYC9YD2cKKokLBTICeHp9YfaZ8aYYanDZ32QxRDhcChenPNE9+i
        +tjc7nmXNm/1uph8qs2kdA==
X-Google-Smtp-Source: APiQypIeWKML2Q2yIs+q1ZFta2wuSTpS8VDHIRQT/NP72fQGGMWPfyUkA8nAi41dFXRwTXFKKHTXJw==
X-Received: by 2002:a9d:7e99:: with SMTP id m25mr4092098otp.45.1589295178802;
        Tue, 12 May 2020 07:52:58 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t20sm3475826ott.51.2020.05.12.07.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 07:52:58 -0700 (PDT)
Received: (nullmailer pid 25183 invoked by uid 1000);
        Tue, 12 May 2020 14:52:56 -0000
Date:   Tue, 12 May 2020 09:52:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Lad Prabhakar <prabhakar.csengg@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-serial@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        Magnus Damm <magnus.damm@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Jason Cooper <jason@lakedaemon.net>, dmaengine@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH 17/18] dt-bindings: gpio: rcar: Add r8a7742 (RZ/G1H)
 support
Message-ID: <20200512145256.GA25121@bogus>
References: <1588197415-13747-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1588197415-13747-18-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588197415-13747-18-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, 29 Apr 2020 22:56:54 +0100, Lad Prabhakar wrote:
> Renesas RZ/G1H (R8A7742) SoC GPIO blocks are identical to the R-Car Gen2
> family. Add support for its GPIO controllers.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
