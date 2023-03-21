Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2E6C7618D
	for <linux-serial@archiver.kernel.org>; Tue, 21 Mar 2023 10:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjCUKwJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 21 Mar 2023 06:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbjCUKvq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 21 Mar 2023 06:51:46 -0400
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF0019100
        for <linux-serial@vger.kernel.org>; Tue, 21 Mar 2023 03:51:43 -0700 (PDT)
Received: by mail-pl1-f180.google.com with SMTP id u5so15540962plq.7
        for <linux-serial@vger.kernel.org>; Tue, 21 Mar 2023 03:51:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679395903;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:to:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qswG2/ZBW7aTCsKI3gXz0TlSSCCucbrgwXXHtDYCg7M=;
        b=vIwYz7nlIOaxXDkD6NQe2iUvL1ARNY2xQuHedKOlqaYRP94mqiYuOLxcZaOqRKamnu
         CC992hXIjlaPXknB0ydZP4Gth+fiu7AwxFObBv8SPdTj97unzTj5UskKwBlTn42LUfoh
         uhQdg7uOn1XeW0kPRQBmC9OKpeLx5+NOosVNCFM/KFyYTKbsv/XIP3/9BZBKv/K5Ncj/
         itSlmRYbH/LsABnTU45nsnVbhxKKyuZKtjNM2S9w1fQjq0HuIR8RJqMGCyYD+3oXCZDw
         y8zcbgS+GvV0fbsB4rhDhUxB68B77ru5C/rcmFf2/MsmLnHu86NEY+x8zBvCMr0qvL7W
         z9cw==
X-Gm-Message-State: AO0yUKWk55cujEJzdbZ/c8QGbq0B7HA99fpt7qjfYG5z+QEgiWalJ7aj
        MlviWY2q5EsQiF0SRxzvFz1Dhw==
X-Google-Smtp-Source: AK7set/9jppZ/8fvwHpwmrSJGSCQmBWnfdRTrTdLhtDmmxg2bsp/b1grQinpEEOPKC3NJrRBf73Yag==
X-Received: by 2002:a17:903:3092:b0:1a1:a706:5df3 with SMTP id u18-20020a170903309200b001a1a7065df3mr1614761plc.15.1679395903364;
        Tue, 21 Mar 2023 03:51:43 -0700 (PDT)
Received: from localhost (63-228-113-140.tukw.qwest.net. [63.228.113.140])
        by smtp.gmail.com with ESMTPSA id g2-20020a170902c38200b001960706141fsm8408525plg.149.2023.03.21.03.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 03:51:42 -0700 (PDT)
From:   Kevin Hilman <khilman@kernel.org>
To:     Bernhard =?utf-8?Q?Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com,
        gregkh@linuxfoundation.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, maz@kernel.org, tglx@linutronix.de
Subject: Re: [PATCH v11 3/3] arm64: dts: mediatek: Initial mt8365-evk support
In-Reply-To: <20230309213501.794764-4-bero@baylibre.com>
References: <20230309213501.794764-1-bero@baylibre.com>
 <20230309213501.794764-4-bero@baylibre.com>
Date:   Tue, 21 Mar 2023 03:51:41 -0700
Message-ID: <7h8rfqwf5u.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Bernhard Rosenkränzer <bero@baylibre.com> writes:

> From: Fabien Parent <fparent@baylibre.com>
>
> This adds minimal support for the Mediatek 8365 SOC and the EVK reference
> board, allowing the board to boot to initramfs with serial port I/O.
>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> [bero@baylibre.com: Removed parts depending on drivers that aren't upstream yet, cleanups, add CPU cache layout, add systimer, fix GIC]
> Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
> [aouledameur@baylibre.com: Fix systimer properties]
> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> Tested-by: Kevin Hilman <khilman@baylibre.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Tested (again) and things are working well.  This is the last patch
remaining to be merged.  As soon as this lands in linux-next, I'll add
this board to my KernelCI lab.

Kevin
