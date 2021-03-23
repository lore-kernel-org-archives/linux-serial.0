Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D936C433DB
	for <linux-serial@archiver.kernel.org>; Tue, 23 Mar 2021 22:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 037FC619D7
	for <linux-serial@archiver.kernel.org>; Tue, 23 Mar 2021 22:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233972AbhCWWgo (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 Mar 2021 18:36:44 -0400
Received: from mail-io1-f41.google.com ([209.85.166.41]:33431 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233872AbhCWWgW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Mar 2021 18:36:22 -0400
Received: by mail-io1-f41.google.com with SMTP id n198so19481262iod.0;
        Tue, 23 Mar 2021 15:36:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p0AQRDiXloaWL2PE0nIM1QihgCc/0cGpQ0uPyeGQCPo=;
        b=AgjbaVm+TEN3FNvfwOrZGldZgn32kT1g/vnHahevLOziHsR9lUFfvs8z5ilBn+E8Zi
         fZppKWL3DOubzQkcUM5Sx5zGWEMxn5qWXocEJLOXUEIhtroCbH623Hj0GML+TsCQeXTM
         rToxnphEffK5y1sjeqSIg+pU3L1A2PpSFUVm8/Ad/msC1Piva4irXMkt62mtf07OyGe0
         mCrIqGrr6g2KUDBcy+ly3ev24zW2+F0Hw4deCshDyoe2AaXovC1ERglaCp5DoSqxEJ6z
         QGNEA31NpHGmSP0OjiB/tGUBrS0ZQp39MvSdvFfav0nc91Re/zQlPzFwS04wokthR1wc
         BKcA==
X-Gm-Message-State: AOAM530mEtCIUYvFyfLxDHiQunOfKXBMDFBWa2IqYQg9PlX+qXYahBpF
        KZSYtaMxAt1yHM3QqP0BNw==
X-Google-Smtp-Source: ABdhPJwsO6YFlFxo0TnTUC3c8fMtA5YZQ8QSiPKwPCESl/WBQSchQHb8uEp4YGks2fMqb6I09kfYvA==
X-Received: by 2002:a05:6638:210d:: with SMTP id n13mr251740jaj.74.1616538980727;
        Tue, 23 Mar 2021 15:36:20 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id r5sm100681ilb.75.2021.03.23.15.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 15:36:19 -0700 (PDT)
Received: (nullmailer pid 1472420 invoked by uid 1000);
        Tue, 23 Mar 2021 22:36:17 -0000
Date:   Tue, 23 Mar 2021 16:36:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Al Cooper <alcooperx@gmail.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v6 1/2] dt-bindings: Add support for the Broadcom UART
 driver
Message-ID: <20210323223617.GA1472356@robh.at.kernel.org>
References: <20210318191131.35992-1-alcooperx@gmail.com>
 <20210318191131.35992-2-alcooperx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318191131.35992-2-alcooperx@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, 18 Mar 2021 15:11:30 -0400, Al Cooper wrote:
> Add DT bindings for the Broadcom 8250 based UART driver. This
> UART is based on an 8250 but adds additional functionality. The
> additional features include the ability to use DMA for transfers and
> a baud rate clock system that is more accurate at high baud rates.
> This UART is backward compatible with the standard 8250 UART.
> 
> Signed-off-by: Al Cooper <alcooperx@gmail.com>
> ---
>  .../bindings/serial/brcm,bcm7271-uart.yaml    | 95 +++++++++++++++++++
>  1 file changed, 95 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
