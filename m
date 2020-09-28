Return-Path: <SRS0=Gon6=DF=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3CAC2D0A8
	for <linux-serial@archiver.kernel.org>; Mon, 28 Sep 2020 12:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2806E2068E
	for <linux-serial@archiver.kernel.org>; Mon, 28 Sep 2020 12:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601297817;
	bh=rHjWhbuQhSZ6wB39VTZ0cPR7QckRZkLswwO7ANcUPCw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=H7KI0aMNyF5TiqoeR9CVwNBF0UnyNhdY+NYJ2yTx1rFh23KBM79ufnkAsOmQf4UuQ
	 YkX0gPUNF06DtRL7lzCkq/KrmxVRpQxqMII391CBmvn7usCCIlXOJ8Vp03uXepFhLz
	 TOSJONV+8whw9U0UFukfEP0XVNCBlmILoMokrxXo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgI1M44 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 28 Sep 2020 08:56:56 -0400
Received: from mail-oo1-f65.google.com ([209.85.161.65]:40542 "EHLO
        mail-oo1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbgI1M44 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 28 Sep 2020 08:56:56 -0400
Received: by mail-oo1-f65.google.com with SMTP id r4so270313ooq.7;
        Mon, 28 Sep 2020 05:56:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sMLPLFtdKygZNybR4cqmUVRj9twZY87y7rGYBclpkHA=;
        b=HzlA7gbaX1krDq+D7Kvv4Vjjn3TAf+Bc/u6mGVGVTZ1sp/m3SHS76EI/x4Zx6PZ7lt
         J9vleaKxLCFGmVzsTklWO8hgJESYZE1KgA6IEOYYEw46w8zkab+bxaUppiVwNxJsP8xl
         pIMvo6AioJu4jVUh/9KBWpAw1A5vkOYPqO7RMENQRKuuJKyy/vvITEppoM2tKcRlGx7+
         f/vLm3IUoAZsedIIlEhDi9dVoljPwW0LWZmGQxTA3PtyE6x2s7YXX4TgVyoFg9RLhifX
         oDsD8Ll5hEBL+2b20gCeJ5KV3Sa0vKLrg39jHzOFuxxugOroOtS6sEj7xN7FvqP/3Ji4
         rfqg==
X-Gm-Message-State: AOAM5334Kl3uTKr/QIp2TT8jWvFswi0t+x3oghXgrnSP7WbQOV9KqrYT
        EIZsvmRI3dnWTqKVIA7tvg==
X-Google-Smtp-Source: ABdhPJyPbJ54E1pfq2XatL/TA4r2MuH0qFlT5Gyu3YLe5KnIICICh5/PgjEcenRs6saA0dCqcPGQ+A==
X-Received: by 2002:a4a:5258:: with SMTP id d85mr726841oob.72.1601297808241;
        Mon, 28 Sep 2020 05:56:48 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q81sm167968oia.46.2020.09.28.05.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 05:56:46 -0700 (PDT)
Received: (nullmailer pid 2545734 invoked by uid 1000);
        Mon, 28 Sep 2020 12:56:45 -0000
Date:   Mon, 28 Sep 2020 07:56:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] dt-bindings: serial: fsl-imx-uart: fix i.MX 53 and 6
 compatible matching
Message-ID: <20200928125645.GA2545321@bogus>
References: <20200925212649.23183-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925212649.23183-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, 25 Sep 2020 23:26:49 +0200, Krzysztof Kozlowski wrote:
> The i.MX 53 and i.MX6Q DTS use two compatibles, i.MX 6SL/6SLL/SX three
> so update the binding to fix dtbs_check warnings like:
> 
>   serial@21ec000: compatible: ['fsl,imx6q-uart', 'fsl,imx21-uart'] is not valid under any of the given schemas
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../devicetree/bindings/serial/fsl-imx-uart.yaml          | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
