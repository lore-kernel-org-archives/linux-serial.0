Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901DFC433ED
	for <linux-serial@archiver.kernel.org>; Thu, 15 Apr 2021 21:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B70161073
	for <linux-serial@archiver.kernel.org>; Thu, 15 Apr 2021 21:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235606AbhDOVN0 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 15 Apr 2021 17:13:26 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:41929 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235411AbhDOVN0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 15 Apr 2021 17:13:26 -0400
Received: by mail-oi1-f170.google.com with SMTP id x77so16327135oix.8;
        Thu, 15 Apr 2021 14:13:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hsGbbCuNHyHicec2zlV4ieUDQ0EApXEKhu0lF/4S5gk=;
        b=gbBH3124CNyzs3R45y/OmXPdeWxhOShveb7WVKmBgS1VczPHutElPLGv8hHMgVhNSL
         8fVlZLSNPyfeCjMD1eiKBkz/3h8meN3qoRaxuJmgc2BjbpSEnyboQYuY0KcH5ClaWsJ6
         HZgzWAIsKvQAxRKSyHJHDEisdgBKZcpk31GsB9tC0ExvDLYJ4WmH/lMJ+8l5cTzMMM1D
         MmXGvhW70mikMtwwyStqeUvaMlcSYbVbwaZP0NfDaHfy3iorGP5JI8Rp+hpkeFz81VUM
         d9aAOTufUgMV3fX6EGHmMwDjY3wTUHzgpAQOMZ+HEPaVjJmOhex6yd9g1vT1HcWojd3y
         8/1A==
X-Gm-Message-State: AOAM5324FIaY9Q1EbeUiarsaK26rT0+FSyfnpH2SoiXdBiW8J+/1nwzt
        Ay4ODeykOy1NXOVyIhrUdw==
X-Google-Smtp-Source: ABdhPJxoyqjr8cK8/sf8EzyhHArK/AKn+UIzTkRXOW0E2wQJb4XwbZYWwALod6aOyM9ibZPUjzmEgA==
X-Received: by 2002:aca:df44:: with SMTP id w65mr3877224oig.36.1618521182433;
        Thu, 15 Apr 2021 14:13:02 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f5sm799950oom.35.2021.04.15.14.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 14:13:01 -0700 (PDT)
Received: (nullmailer pid 1891784 invoked by uid 1000);
        Thu, 15 Apr 2021 21:13:00 -0000
Date:   Thu, 15 Apr 2021 16:13:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Erwan Le Ray <erwan.leray@foss.st.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Jiri Slaby <jslaby@suse.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Valentin Caron <valentin.caron@foss.st.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 2/4] dt-bindings: serial: stm32: override FIFO
 threshold properties
Message-ID: <20210415211300.GA1891734@robh.at.kernel.org>
References: <20210413174015.23011-1-erwan.leray@foss.st.com>
 <20210413174015.23011-3-erwan.leray@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413174015.23011-3-erwan.leray@foss.st.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, 13 Apr 2021 19:40:13 +0200, Erwan Le Ray wrote:
> Override rx-threshold and tx-threshold properties:
> - extend description
> - provide default and expected values
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> Signed-off-by: Erwan Le Ray <erwan.leray@foss.st.com>
> 
> Changes in v2:
> Change added properties naming and factorize it in serial.yaml as proposed
> by Rob Herring.
> 

Reviewed-by: Rob Herring <robh@kernel.org>
