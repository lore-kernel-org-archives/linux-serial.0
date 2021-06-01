Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380B6C47080
	for <linux-serial@archiver.kernel.org>; Tue,  1 Jun 2021 08:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17513613AB
	for <linux-serial@archiver.kernel.org>; Tue,  1 Jun 2021 08:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbhFAI3f (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 1 Jun 2021 04:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbhFAI3f (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 1 Jun 2021 04:29:35 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED972C06174A
        for <linux-serial@vger.kernel.org>; Tue,  1 Jun 2021 01:27:53 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id f2so2245237wri.11
        for <linux-serial@vger.kernel.org>; Tue, 01 Jun 2021 01:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MI5T5t/RSz+ApO+As7ezT0+58RDmFWuhI+3uzR4JPe4=;
        b=1zpALENTQHe3VELwLjYwa+30ISnGRBvpQzPITvFEY1PXf3sRSBz5HKuHnufj7UBVXd
         cpkDOQbdRWOhpz8jfujjf4hN6zN6fmaGxheGjP8yGdbqWOfJG2UXXv/6IUiL+16Wi0EP
         1cGF5n16gUCuE0hIPA6D2n+Xa72I7RR6+gkCdZbFGtL/5tFlPANmejVeBcsL6wZ6JOCp
         QLeIGVVV0+Qd9aXvXK4390Yf2NYq8g/JJzo7EebPaHqdSRVxvwpNIGFt9bAcJ++lIC3e
         13gXrSi04vaTUyZ5paX0UfZ52CHfzz8prGYr3lKaTx77+xYjg/Wd92oOcCD3i5vHY24T
         xtNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MI5T5t/RSz+ApO+As7ezT0+58RDmFWuhI+3uzR4JPe4=;
        b=Lsz1fW6p2YDJL+v4WSxueZW4sCGX6JjuFOIPIveBAkBAX6UOPPhdEv8EOIxk4tO+zU
         h24K/Z2E5832RFQRfSxJFG/vp7JGH96NboPfiitLPM/EiCEWgquXT+hQlV1dlez2xJT7
         0+N2wrmKSooZtKmAZNhh4YO23KrSAasOsqkq+4Ny1nlGwPU9Pl/RD9FNxHThv+f7Hauk
         RAAfTQu0XyupeCnfV5dkymng2e5U+gaG4tDFsupDGDaadj4yd7zBat3q6T50OBsezZjg
         c1FiRgwAbIoSy11tbZSE1N5Sd566IRVzZNvUm25YEl6N809oBVOsWwtvCdJTdtqTJkP8
         15wQ==
X-Gm-Message-State: AOAM530ww4H1bZ6BDeW661we/eZLJSUmoHx+y2sHFqw+7CDJhUKUkA3q
        Bau+xT1KmugvOYDXSGcKDSiT68Hyd2Kdlnes
X-Google-Smtp-Source: ABdhPJyyI2URE4xiLGQHVBO5sTCDl85S7jb21pp1/Y2kp9vGS1CNoRz8Xc5TlzWexfirhG6BqS+x8A==
X-Received: by 2002:adf:a446:: with SMTP id e6mr10999521wra.219.1622536072548;
        Tue, 01 Jun 2021 01:27:52 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:a3a:d001:6a80:207a])
        by smtp.gmail.com with ESMTPSA id f7sm17108936wmq.30.2021.06.01.01.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 01:27:51 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     gregkh@linuxfoundation.org,
        Neil Armstrong <narmstrong@baylibre.com>, jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: (subset) [PATCH 0/3] tty: serial: meson: add amlogic,uart-fifosize property
Date:   Tue,  1 Jun 2021 10:27:48 +0200
Message-Id: <162253604769.258225.7812835099305638317.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210518075833.3736038-1-narmstrong@baylibre.com>
References: <20210518075833.3736038-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On Tue, 18 May 2021 09:58:30 +0200, Neil Armstrong wrote:
> On most of the Amlogic SoCs, the first UART controller in the "Everything-Else"
> power domain has 128bytes of RX & TX FIFO, so add an optional property to describe
> a different FIFO size from the other ports (64bytes).
> 
> This adds a property in the bindings, reads the property from the driver and updates
> the DT with the new property.
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v5.14/dt64)

[3/3] arm64: dts: meson: set 128bytes FIFO size on uart A
      https://git.kernel.org/amlogic/c/a270a2b24de5

-- 
Neil
