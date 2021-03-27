Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99424C433E3
	for <linux-serial@archiver.kernel.org>; Sat, 27 Mar 2021 16:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8543E619B4
	for <linux-serial@archiver.kernel.org>; Sat, 27 Mar 2021 16:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbhC0Qh4 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 27 Mar 2021 12:37:56 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:39845 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbhC0Qhg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 27 Mar 2021 12:37:36 -0400
Received: by mail-oi1-f182.google.com with SMTP id i81so8955319oif.6;
        Sat, 27 Mar 2021 09:37:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=RnOFizufyIzLXsx9L23De4K+FgNMVS+9BTUlSwp8+vY=;
        b=RAoSfplD7iJgU/pXKGRbLsngEbDX07DPfjrZuE3dwDAEwFXc+Eq3Oo39isxcMgE7tS
         leKBuIsTRsi94ZuOnD6A9x+2jE2jdfhhi3KRQpElwcm55iZd/K+rROTU1fE1qyRWxG7r
         g7O56sbg2xS5Fx0DdOxVya1Zx8kfMd8EhpxW/EYX3M/lqFfCAYJ8ZpTFAiPMmTCiX/OC
         r6loWO8xt7sp0IR5hQiLtOU9HqxpTzUjavgMGcUmAvT9AmsIOPP0asMuT1v91yTAZTve
         SHvJBOjLfLx5ljjf8pIakI0ZB4ENBlEFnAkBGxBRYDReg2eyLjdHAthbpDNlQWya24Fh
         nQCg==
X-Gm-Message-State: AOAM531b7a9EjobEs/nm5xGhuxFPQd71/bJyd8R91QMWG9D+54XYiFJy
        hUk9XP3vtQ1d3bTtp/zrTg==
X-Google-Smtp-Source: ABdhPJwMW+5msovF4j3LhZVPkAZxnjhyXEJfi28WekI0rNOvvjcMhtfDXWeZQcP+h8f1pRC42DQUZA==
X-Received: by 2002:aca:90a:: with SMTP id 10mr13640983oij.35.1616863056268;
        Sat, 27 Mar 2021 09:37:36 -0700 (PDT)
Received: from robh.at.kernel.org ([172.58.99.140])
        by smtp.gmail.com with ESMTPSA id d24sm2826126otf.12.2021.03.27.09.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 09:37:35 -0700 (PDT)
Received: (nullmailer pid 212999 invoked by uid 1000);
        Sat, 27 Mar 2021 16:37:33 -0000
Date:   Sat, 27 Mar 2021 10:37:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-serial@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 04/14] dt-bindings: serial: 8250: Add nuvoton,wpcm450-uart
Message-ID: <20210327163733.GA212953@robh.at.kernel.org>
References: <20210320181610.680870-1-j.neuschaefer@gmx.net>
 <20210320181610.680870-5-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210320181610.680870-5-j.neuschaefer@gmx.net>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, 20 Mar 2021 19:16:00 +0100, Jonathan Neuschäfer wrote:
> Add a compatible string for the UART inside the Nuvoton WPCM450 SoC.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
>  Documentation/devicetree/bindings/serial/8250.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
