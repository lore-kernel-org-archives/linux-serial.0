Return-Path: <SRS0=3oyo=EK=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3342AC2D0A3
	for <linux-serial@archiver.kernel.org>; Wed,  4 Nov 2020 20:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C234720825
	for <linux-serial@archiver.kernel.org>; Wed,  4 Nov 2020 20:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604523261;
	bh=6zAbHWmW1GT3bHH2LQ2kNM3lXt/6sN4HezHbOR9CIWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=o1SDUE1LS/EJU2d7BV/NXhE5gmwNDesIxuCkMLnMjc1WhYWpMiUyleqjIdrcjRgta
	 wXRr3YfPNKcDO0GRpEU2Ny9q518imPPb4vSm125eZheccqOGHVHnfrMxrgMa0fPh4Z
	 RKAiVxqpLu8qezMrGOo/CV4qu+Ulde2yjxwSf3/g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731225AbgKDUyV (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 4 Nov 2020 15:54:21 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35511 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbgKDUyV (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 4 Nov 2020 15:54:21 -0500
Received: by mail-ot1-f67.google.com with SMTP id n11so64223ota.2;
        Wed, 04 Nov 2020 12:54:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=itx0JAMDGf7Z6jafviBdxt7jkWpfIA2uVZcjyCHRyto=;
        b=LuBKM967CPzOJ4tdFrmUZx39VB6SVD8gLu/+56/dbvCEBy2Bqb2Ur1mOrzLFWRv9bm
         XS7MrQOyHUzz1LwXN256ERlaj5pvkQQkIWkuJncJO41zj3IlsmI625rA8ZsScT60AkUF
         5xGWeTQuSXGUx65NSi49OkWA99Lm3bY4HtFunOSaaPorOdor4cP7328DqF1LgAMFEnSv
         aCpjGQWSqfyCgmQyKXZ0LTZ41Pkog/nIdMl8VDu7ITt97z52pZ/OLgGOh3wQrII09LHs
         z+QOfoJZhYqcsDw6MYo0zQJl7mAEg976bhkt2WhsM/BeAB4sgwORbmR6iPFdpnwF7Vlp
         7CNQ==
X-Gm-Message-State: AOAM533RJhLHIDtjto+CZuI3rRPIwJ5gTmbPoiPqiMSxYeTZ/zGqQogE
        8HIP30/kL18XTVpg2wSI+A==
X-Google-Smtp-Source: ABdhPJy/UX8zuHldTQ0fTliH7ia19EjObbZl78FqLcC4GYmFFe5FAnccoSuszo34p4/jWlTVhfRUqA==
X-Received: by 2002:a05:6830:1692:: with SMTP id k18mr1498576otr.130.1604523260520;
        Wed, 04 Nov 2020 12:54:20 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t20sm739711oic.1.2020.11.04.12.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 12:54:19 -0800 (PST)
Received: (nullmailer pid 4109282 invoked by uid 1000);
        Wed, 04 Nov 2020 20:54:19 -0000
Date:   Wed, 4 Nov 2020 14:54:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        nm@ti.com, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, nsekhar@ti.com
Subject: Re: [PATCH] dt-bindings: serial: 8250_omap: Add compatible for UART
 controller on AM64 SoC
Message-ID: <20201104205419.GA4109249@bogus>
References: <20201029065318.2437-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029065318.2437-1-vigneshr@ti.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, 29 Oct 2020 12:23:18 +0530, Vignesh Raghavendra wrote:
> AM64 uses a UART controller that is compatible with AM654 UART.
> Introduce a specific compatible to help handle the differences if
> necessary.
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>  Documentation/devicetree/bindings/serial/omap_serial.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
