Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA24C433EF
	for <linux-serial@archiver.kernel.org>; Mon, 13 Dec 2021 11:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbhLMLMs (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 13 Dec 2021 06:12:48 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:34820
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229836AbhLMLMr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 13 Dec 2021 06:12:47 -0500
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 874B43F206
        for <linux-serial@vger.kernel.org>; Mon, 13 Dec 2021 11:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1639393966;
        bh=FMSEJMWB19MJ5un0naaJgLGMwQh7w2xxe+NRt2wvP6I=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=V5xvwzknfqO16mjVNGIblj8LxaFArR6SQFll08DHcUJtYbs6YY901oSZ3+bWoBIQi
         qMHqX0+g5AOUuRHbeOH8HsOpT1MZwrwL9DrvmpVzbBGrEtWLR0YjC4P/Rql8+ZS3C9
         JS75Xz7hmVIErAVhiZgXO+Uh6PMuJM9+doimYzOndqDiJs8n1trj8FNpxr97znBs+4
         2Ql+A7gRA2PbTp7o71wWCrc+tkVBTregw/+iGgPRGlRovhmNU9kVuuarmKOVJCtNCV
         iwMdi5NPxI2w64EJN7AemCjkjpvWYnOZE1QuDCRHXlXval2ta29qGiRW7v3hHyEE0/
         CPd4q/1r8t1EA==
Received: by mail-lf1-f71.google.com with SMTP id bi30-20020a0565120e9e00b00415d0e471e0so7333949lfb.19
        for <linux-serial@vger.kernel.org>; Mon, 13 Dec 2021 03:12:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FMSEJMWB19MJ5un0naaJgLGMwQh7w2xxe+NRt2wvP6I=;
        b=AeZLOcxT5PKs+rj/84ykCoR849a4Dg5ZMB+HnMqr1WOOv+C3BOGrwCu9N+B4l4qTml
         IkfPuN9Jc26JBzPU+j4ehrcSc5c2CUGveHkgAEEciFw2jFFxuVOlkd+CmysQvpePodzu
         20XbpVykfCyIeciGF2iZ8dxSL2bU6tkhJ1jcWouuqk/eS5PFzaTiQl5l/ppVeTpoyl/8
         8u4NujRGG2/T/rTsY18EnOIFSMfqx+kAhYp6C942Ewc+qfm0lA8RqzQEhuYxMoY+dU+r
         jU4TR6dunQbN/RJOV9nZFKnsa17LJaNFHJrb0fD8uzd/n2kEjf5S1kce3peaZLUIr3XK
         ++Pg==
X-Gm-Message-State: AOAM531yZYZ0Ws2+mwAdIEt5dPgXWIRmw5wb4P53Xrdvp6MO1u8mtbmx
        VWAZFhIPoEBSXKC9AE/MtFtFJVi1UlHW/At2s1NwEJy+d53GhCPFVA41rFNcuQUCxGhANYMlOOA
        ycUqCjCGkrGnAeAm+E+wvAHpEN66OGX+QdboKflGNrA==
X-Received: by 2002:a2e:9dcf:: with SMTP id x15mr29777717ljj.223.1639393965778;
        Mon, 13 Dec 2021 03:12:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwEhn19N9dmWSefufj0sS+SE52ZpsFM6hnx/XdA1Kb8kvUIW90VKYiArQTWBmcr1sR0Y6R8xg==
X-Received: by 2002:a2e:9dcf:: with SMTP id x15mr29777688ljj.223.1639393965543;
        Mon, 13 Dec 2021 03:12:45 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id i11sm1387791lfu.141.2021.12.13.03.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 03:12:45 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Jaewon Kim <jaewon02.kim@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Youngmin Nam <youngmin.nam@samsung.com>,
        devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH v3 1/5] dt-bindings: soc: samsung: Add Exynos USI bindings
Date:   Mon, 13 Dec 2021 12:12:41 +0100
Message-Id: <163939390678.7492.14453883652552774452.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211204195757.8600-2-semen.protsenko@linaro.org>
References: <20211204195757.8600-1-semen.protsenko@linaro.org> <20211204195757.8600-2-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, 4 Dec 2021 21:57:53 +0200, Sam Protsenko wrote:
> Add constants for choosing USIv2 configuration mode in device tree.
> Those are further used in USI driver to figure out which value to write
> into SW_CONF register. Also document USIv2 IP-core bindings.
> 
> 

Applied, thanks!

[1/5] dt-bindings: soc: samsung: Add Exynos USI bindings
      commit: e522ae91b8ff7bf89d22d9322308aba1a6326996

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
