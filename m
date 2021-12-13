Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886B1C433F5
	for <linux-serial@archiver.kernel.org>; Mon, 13 Dec 2021 11:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234480AbhLMLMx (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 13 Dec 2021 06:12:53 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:46002
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234582AbhLMLMx (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 13 Dec 2021 06:12:53 -0500
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 851C840037
        for <linux-serial@vger.kernel.org>; Mon, 13 Dec 2021 11:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1639393972;
        bh=dyuKF4BAHeuRIOQc7e3kDFRJ6K0OTMq0h/Tat1BAxlc=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=Ih11eHNaYj0dxFuvmRrWBYN5/6W5SYgkTBvGJJhJx40Kgi+VHBQXVucqyoaJZ1gHH
         ohQkJxnQoIQLRUjWdEnKVMEYWS9xmybqCyfHKRcoRNU6e/KJmR7gc3UUgnt9CnXO6f
         hVv7nh7Q04RZ9cIF4uGEQOCO19ExWTLFY1tI8KqbDnwclC4sp8dny3eOXrmq9cRjwf
         /j9+Xpnhzgfskapa0aOKpFK8wnTbHMJnFuRhf/QxdDoUdHdVcoISMy1dUasYXF6Hf0
         j/nXApthytfETBGnk3rvfgC/aitdhRXcXRa2GL305f7O1/cXQBQz2+ojr5xNDqX34F
         QOUYxUJSTr8Dw==
Received: by mail-lf1-f70.google.com with SMTP id m1-20020ac24281000000b004162863a2fcso7335701lfh.14
        for <linux-serial@vger.kernel.org>; Mon, 13 Dec 2021 03:12:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dyuKF4BAHeuRIOQc7e3kDFRJ6K0OTMq0h/Tat1BAxlc=;
        b=3nkx1cFF+AOWXHlrlRYe+/jgEkA9XcbZSr59gRNyPgaX3MQplZiikXOby8xYSUkB5z
         DKl0G1w40Z3H/Zl8tNK/u4/+LY9PiD+pCoTMes3twDNEpLRS0xHLZn1yj7A7vCI2MjzF
         JQuwmGZS2A7lMwJujzcsWwj3RF3kQVpVLFO44prILDqyqm/z3Lfae1iCoZi190FI4NX0
         s+8c5UazUx6umbnOr5jy/RZ4gI51vwaroJ/1DayTHNtHcDL+AZIIBOnxLdoDlL3KjV8G
         95qCgPu6GIPgcIhTI9iPV7QHoFiv5JXPI+IzXb5KRiVwU5K8Zq2uz+UxJmD8him7KJKE
         gyWg==
X-Gm-Message-State: AOAM531XibaBOfK+IKRmCL+qh+ks51mnz5HcJrteySaTKFeOhkdAxXx6
        2PsSaIubRYgcmJib604q+L8UwVSa9+/wIQi/+Xx7BkJAi6uY3651wHuYYKHwlGRD6iPb6TcYD2R
        5W9w9UUhSscwnIBu2RKeapDCt9EKJyimvO5Cf7ph2Bw==
X-Received: by 2002:ac2:4e11:: with SMTP id e17mr28408240lfr.126.1639393971806;
        Mon, 13 Dec 2021 03:12:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx1IzXqmfov2eGoZQZq7xcYOB6+DRCqVGkPLZlbedDR/KWTooAqu//trmEodH0hP+3eA1oDOA==
X-Received: by 2002:ac2:4e11:: with SMTP id e17mr28408116lfr.126.1639393970107;
        Mon, 13 Dec 2021 03:12:50 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id i11sm1387791lfu.141.2021.12.13.03.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 03:12:49 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Jaewon Kim <jaewon02.kim@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Youngmin Nam <youngmin.nam@samsung.com>,
        devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH v3 2/5] soc: samsung: Add USI driver
Date:   Mon, 13 Dec 2021 12:12:42 +0100
Message-Id: <163939390678.7492.6547802857453426522.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211204195757.8600-3-semen.protsenko@linaro.org>
References: <20211204195757.8600-1-semen.protsenko@linaro.org> <20211204195757.8600-3-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, 4 Dec 2021 21:57:54 +0200, Sam Protsenko wrote:
> USIv2 IP-core is found on modern ARM64 Exynos SoCs (like Exynos850) and
> provides selectable serial protocol (one of: UART, SPI, I2C). USIv2
> registers usually reside in the same register map as a particular
> underlying protocol it implements, but have some particular offset. E.g.
> on Exynos850 the USI_UART has 0x13820000 base address, where UART
> registers have 0x00..0x40 offsets, and USI registers have 0xc0..0xdc
> offsets. Desired protocol can be chosen via SW_CONF register from System
> Register block of the same domain as USI.
> 
> [...]

Applied, thanks!

[2/5] soc: samsung: Add USI driver
      commit: cc4fcd60ac51d99ef75fa80f14ac6202f46c3dfc

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
