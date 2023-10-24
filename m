Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7BFC00A8F
	for <linux-serial@archiver.kernel.org>; Tue, 24 Oct 2023 18:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbjJXSg5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 24 Oct 2023 14:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234902AbjJXSg4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 24 Oct 2023 14:36:56 -0400
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26B7171A
        for <linux-serial@vger.kernel.org>; Tue, 24 Oct 2023 11:36:48 -0700 (PDT)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1c9d922c039so40280195ad.3
        for <linux-serial@vger.kernel.org>; Tue, 24 Oct 2023 11:36:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698172608; x=1698777408;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VFRf6XqzP9QsqxWKnaeZzWuxmA4QRHsXUAeuBRt8Xy8=;
        b=M13t639Lli5AuEGktioiXjE2CxtrXGPf6UfHmFHX/kZajAEC+uZ+PO3m4HuP9i5/G7
         fyJSe9aH27vluaMZi1j6O3sdnynqCEbVHLVbs5qwILiLD8Cbfs//JPvooAxbvtspJSeg
         otMSGr5XFyVEmboopgzM42P+M4TnAU3RFu7wEpI+03mafQM6ZXZ52EJRDBQJ2kyTE5ts
         DlMEhHX0oapAAYuO4gZ3/VZra6ZB9AwYEC014M4bs5yXeQJnWH0RLAeQexXQII0KokXp
         yhFHvE8CvX74pTyAYjNEraLX+YFJteXCXtYeZGM3uIOZXklxPKlFHVtkwipHZiHP1pqF
         K2Yw==
X-Gm-Message-State: AOJu0YwyvpcRvUrvDnItKIHy+RPLTnVR5THnLoAmZWXd+/52EPjURpxC
        m4rCwXWaUkL1tWD0ex5jY2qC8w==
X-Google-Smtp-Source: AGHT+IGze9eJnvujAQLNDv1qlvbHIgvMe+H6GFmhQfegYXwP4TkbMR7I1F+MMn2mjBug2crPs7SITg==
X-Received: by 2002:a17:903:30d2:b0:1ca:e491:f525 with SMTP id s18-20020a17090330d200b001cae491f525mr6383119plc.31.1698172607741;
        Tue, 24 Oct 2023 11:36:47 -0700 (PDT)
Received: from localhost (97-113-50-134.tukw.qwest.net. [97.113.50.134])
        by smtp.gmail.com with ESMTPSA id x4-20020a170902ec8400b001c74df14e6fsm7640301plg.284.2023.10.24.11.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 11:36:47 -0700 (PDT)
From:   Kevin Hilman <khilman@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Thomas Richard <thomas.richard@bootlin.com>,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, gregory.clement@bootlin.com,
        u-kumar1@ti.com, d-gole@ti.com, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH] serial: 8250_omap: Set the console genpd always on if
 no console suspend
In-Reply-To: <20231024045109.GT27774@atomide.com>
References: <20231017130540.1149721-1-thomas.richard@bootlin.com>
 <7hfs213u0r.fsf@baylibre.com> <20231024045109.GT27774@atomide.com>
Date:   Tue, 24 Oct 2023 11:36:46 -0700
Message-ID: <7hjzrbj29t.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

> * Kevin Hilman <khilman@kernel.org> [231023 21:31]:
>> Instead, what should be happening is that when `no_console_suspend` is
>> set, there should be an extra pm_runtime_get() which increases the
>> device usecount such that the device never runtime suspends, and thus
>> the domain will not get powered off.
>
> We already have the runtime PM usage count kept in the driver (unless
> there's a bug somewhere). The issue is that on suspend the power domain
> still gets shut down.
>
> I suspect that some of the SoC power domains get
> force shut down on suspend somewhere?

If setting GENPD_FLAG_ALWAYS_ON works as this patch proposes, then a
force shutdown would override that genpd flag also, so I suspect the 
runtime PM usage count is not correct.

I quick skim of 8250_omap.c, and I don't see any pm_runtime_get() calls
that are conditional on no_console_suspend, which is what I would
suspect for the domain to stay on.

Kevin


