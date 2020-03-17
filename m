Return-Path: <SRS0=6uIZ=5C=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D6CC10F29
	for <linux-serial@archiver.kernel.org>; Tue, 17 Mar 2020 10:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C624205ED
	for <linux-serial@archiver.kernel.org>; Tue, 17 Mar 2020 10:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="hsHzKaLO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgCQKFF (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 17 Mar 2020 06:05:05 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41166 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgCQKFE (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 17 Mar 2020 06:05:04 -0400
Received: by mail-lj1-f196.google.com with SMTP id o10so22065524ljc.8
        for <linux-serial@vger.kernel.org>; Tue, 17 Mar 2020 03:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n09seZt9zQSEmn7PnJzgCcHPTYjmqdsKfcWkGxOyoSw=;
        b=hsHzKaLO8KEYIAs97rD1AMV6mMcqn8KvHqg4ovsIqvIqJsmunKOt1qYqCT5n50NIxg
         5W5zLGTss9f2hdJk1xumbMBaQMEDyvjcEyPZ3jrVx+WFRbtYyH8TPSgzOsF/O0ZDV+R+
         YjoSBTZStIUKJShmEh3hEBHRdVxm1SY6SdsdZnyJxUDVSUVZF76uON1MxQVFXMBzq7je
         dlg8JkAxS2yIyOnnmUE/68pzDOxpbgCvnSFoZcOm6vs6rcpTxYbjby1S67f7NF/Fv36c
         IE9PiIrFyxQp03l/Q0rCM6x04ylSD3FBrTKVotFLkqpNP2woyYPVF4wSIq4KiiZs1osm
         q5YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n09seZt9zQSEmn7PnJzgCcHPTYjmqdsKfcWkGxOyoSw=;
        b=kgch1KEdSYm2vzNcx2pfm4SM8JI+NYHsOS+GekHAlvZGO7/gA0n7b1eNUa2SFcRgBO
         FUR6BmsCvoPhuT5ZagTfEtg6wnYvhlvJG+JlRnM2WjQqxp7F/6ITB52tib9DLcdmg3fR
         lbd7IkRF2lQuPC4vXAxaERTNOhEIOkKMFPf33W0PWrUC1jsdHJIxbGpmZ5acpzNlVYoq
         aoVegZw+KlBr3r/vfXPdgRTG2u7xlU5hn3q00ZYYOk20o/iVnbqowHDwM9k6mVgTFxdJ
         ZPfEvsI/hnjqiVKv3NNqCbnoJr81/Ua006Hfh0c6KhPxPgJcS9p7hVPdjJwBukLnPh6X
         CruQ==
X-Gm-Message-State: ANhLgQ3T8jPmgqCpKNUt1ZU1xpXKuFX8mjaHsI/uaryInbXbzfKPwj9b
        np51uWFQm5cP0wgbsvd0+ueIsQ==
X-Google-Smtp-Source: ADFU+vvDFgn0Sv1qdBbtE4XeAKrxupkPbSjYz/5IJ9Z1M/fD+IB/2XXNoyEDPpVkBc5aUWJYf1e6nA==
X-Received: by 2002:a2e:8119:: with SMTP id d25mr2329766ljg.39.1584439502560;
        Tue, 17 Mar 2020 03:05:02 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:48ef:94a3:a481:5e62:4324:124b? ([2a00:1fa0:48ef:94a3:a481:5e62:4324:124b])
        by smtp.gmail.com with ESMTPSA id r7sm1932099ljc.3.2020.03.17.03.05.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2020 03:05:01 -0700 (PDT)
Subject: Re: [PATCH 17/28] dt-bindings: mmc: Fix up clk-phase-sd-hs in an
 example
To:     Lubomir Rintel <lkundrak@v3.sk>, Rob Herring <robh+dt@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-usb@vger.kernel.org
References: <20200317093922.20785-1-lkundrak@v3.sk>
 <20200317093922.20785-18-lkundrak@v3.sk>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <d7ccf5c1-4bfa-2fd2-b32d-a520e96bdd1e@cogentembedded.com>
Date:   Tue, 17 Mar 2020 13:04:55 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200317093922.20785-18-lkundrak@v3.sk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello!

On 17.03.2020 12:39, Lubomir Rintel wrote:

> This way the validator can know that the two cells constitute a singlej

    Single?

> pair of clock phase degrees value, not separate items Otherwise it is

    Forgot a period after "items"?

> unhappy:
> 
>    mmc-controller.example.dt.yaml: mmc@ab000000: clk-phase-sd-hs:0:
>        [63] is too short
>    mmc-controller.example.dt.yaml: mmc@ab000000: clk-phase-sd-hs:1:
>        [72] is too short
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
[...]

MBR, Sergei
