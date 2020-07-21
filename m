Return-Path: <SRS0=EuFA=BA=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9960C433E0
	for <linux-serial@archiver.kernel.org>; Tue, 21 Jul 2020 08:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD51D2080D
	for <linux-serial@archiver.kernel.org>; Tue, 21 Jul 2020 08:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595318687;
	bh=DfcAnOdK3BxY6jqQpzn4sc8Wri40qkfysNtuloW83bs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fyhTFLDWEceAFJckNtfObV+tcDpl8LgvD/pJ1BYH9kUvlb5ZY+zH4jfaWbp5pOqnq
	 kvTlbjpQ/Dy6OjXOI6mAVKEnq2sxV/BOdY9NEIwRMCDQNsqNN9qpCJk0RYU1WTocal
	 rHBst1WLQCEznoY96SYY+TDUTDV/MnEB9ZFRaaC8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbgGUIEr (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 21 Jul 2020 04:04:47 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53719 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbgGUIEr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 21 Jul 2020 04:04:47 -0400
Received: by mail-wm1-f67.google.com with SMTP id j18so1857174wmi.3;
        Tue, 21 Jul 2020 01:04:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=syvFVe39WCS6I7HZqBbb+16Wl3B+m141J405QHoInHE=;
        b=WOzBDXudrswjLpFnCUlRp0S6MWhUH84fHHDeADyLAeXTDcg8axRSMifiRuaFsqaYQ6
         amedgHwmpkqPRvxZg6ajVG3j18aImUnefB9npjZGSK/N33foieFdG94k8gdCXkS+hvuS
         M7j0P6rGsgLJu8k+eqgHqXJQkFr3RTJLteR7oAXt77PguOYofV0Uu/7ds3GI74NLuaOa
         jRkfbK0UIzNqTHvv7IMByIOgHvzaRMMJMK16pcy6bzam/MOI8fCWKaojUeorobdwghBb
         yXhJPWCeQavFIDcaQMiIYV4OqGVDcaM0wD8Dcy/i+5uG7JUHpqwmCpS6kDqReFjQy7mr
         wRrw==
X-Gm-Message-State: AOAM53254MBRn8uINdEiBVFY8xGjlc/vDpkEPYoKAiXK0AXZpXzQycs3
        mAzE19EOY0d72jFg7Nzq7hRKxqftEhM=
X-Google-Smtp-Source: ABdhPJxda9SdlT7pF9+Os3z3GaDcUTXtBao7aheqKIsfkWKfKAqh6bpMotyBzTDIkJgsfF7Wf+I2vw==
X-Received: by 2002:a7b:cb92:: with SMTP id m18mr2786559wmi.94.1595318684880;
        Tue, 21 Jul 2020 01:04:44 -0700 (PDT)
Received: from kozik-lap ([194.230.155.200])
        by smtp.googlemail.com with ESMTPSA id u65sm2545294wmg.5.2020.07.21.01.04.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Jul 2020 01:04:44 -0700 (PDT)
Date:   Tue, 21 Jul 2020 10:04:42 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Tamseel Shams <m.shams@samsung.com>
Cc:     kgene@kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, alim.akhtar@samsung.com
Subject: Re: [PATCH v4] serial: samsung: change to platform_get_irq_optional
Message-ID: <20200721080442.GA6580@kozik-lap>
References: <CGME20200713141655epcas5p2cdd83477e4fc024457a2b08d8ebfbad0@epcas5p2.samsung.com>
 <20200713135531.68583-1-m.shams@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200713135531.68583-1-m.shams@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Jul 13, 2020 at 07:25:31PM +0530, Tamseel Shams wrote:
> In few older Samsung SoCs like s3c2410, s3c2412
> and s3c2440, UART IP is having 2 interrupt lines.
> However, in other SoCs like s3c6400, s5pv210,
> exynos5433, and exynos4210 UART is having only 1
> interrupt line. Due to this, "platform_get_irq(platdev, 1)"
> call in the driver gives the following false-positive error:
> "IRQ index 1 not found" on recent platforms.
> 
> This patch replaces the platform_get_irq() call with
> platform_get_irq_optional() and hence avoiding the
> false-positive error.

The error is not a false positive on S3C platforms, but a real error.
The existing code did not handle missing TX IRQ but at least printed a
message.  Your change hides the message.

The real problem here is a missing error handling for TX interrupt.
Solving this one, would solve also false-positive error message on newer
SoCs.

Best regards,
Krzysztof

