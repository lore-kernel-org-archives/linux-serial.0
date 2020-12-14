Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D147FC1B0E3
	for <linux-serial@archiver.kernel.org>; Mon, 14 Dec 2020 12:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D361206FC
	for <linux-serial@archiver.kernel.org>; Mon, 14 Dec 2020 12:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439038AbgLNMld (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 14 Dec 2020 07:41:33 -0500
Received: from mail-ej1-f65.google.com ([209.85.218.65]:33520 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405336AbgLNMjz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 14 Dec 2020 07:39:55 -0500
Received: by mail-ej1-f65.google.com with SMTP id b9so22253905ejy.0;
        Mon, 14 Dec 2020 04:39:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Jnd/4aY9dAQDER69V5GznysggrKivLx5zBLqZJJ/zu0=;
        b=YdxB0+YyFf1Pq2RYMcbR20izyE+mmMQcFaux7MzScqzWSLAkjbtSSAi4HPkPyzC4Vc
         em0GW8pKv06a0BunieWJaa/qggfexktqEsuA5s+yisqT2HNCJF9bWRAMslkOZmXgnJ+P
         QU+2pOxpRGKE6J7KiT7cJT2fscsEWsQ0MpG18ckE4QAYGk2ORSoC55Lidr4r/NhFJdI8
         2d0pi5yejNIWwtpnzhE4isKFyUtmJCnJq8AYxQp6xJkNwOuM5/TJWXk+TQePfhvEwE0e
         t5y8GY1hcj7ZZ/Wz8dFu04cqBgDqF9+auYShFerD7qFNoDJpQhAriVcsDZrMj4yCj4ER
         Rd+Q==
X-Gm-Message-State: AOAM532mZh5xWv28V2cXAoLGTGEbayZKGHmXY+NTtfStipm6gz1m5p/a
        +EVNf7BGBbKBfybPMHCwNQ7Ul7UEsMqcyg==
X-Google-Smtp-Source: ABdhPJycMC2SeFP3Jq3dhhZ6LzLfRmGggegB+hc3Af/l9+D1a0mq+6eunktjr1wdg/aEHwJsGoEDFg==
X-Received: by 2002:a17:906:3712:: with SMTP id d18mr23043935ejc.178.1607949551897;
        Mon, 14 Dec 2020 04:39:11 -0800 (PST)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id s19sm15561207edx.7.2020.12.14.04.39.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Dec 2020 04:39:11 -0800 (PST)
Subject: Re: [PATCH v4] Serial: silabs si4455 serial driver
To:     =?UTF-8?Q?J=c3=b3zsef_Horv=c3=a1th?= <info@ministro.hu>
Cc:     'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        'Rob Herring' <robh+dt@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201212070944.GA13909@dincontrollerdev>
 <2855efaf-79a5-f43b-ff8c-9c01a3f14df7@kernel.org>
 <20201214123519.GA10229@dev>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <77bb5835-b1f2-125a-d2d1-ad67612b164d@kernel.org>
Date:   Mon, 14 Dec 2020 13:39:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201214123519.GA10229@dev>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 14. 12. 20, 13:35, József Horváth wrote:
> I'm in trouble with the device tree binding schema of this driver too.

Sorry, someone else has to help you who actually masters DT details.

-- 
js
