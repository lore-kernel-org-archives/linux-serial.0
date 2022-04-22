Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DE4C433F5
	for <linux-serial@archiver.kernel.org>; Fri, 22 Apr 2022 12:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447524AbiDVMdl (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 22 Apr 2022 08:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447528AbiDVMdk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 22 Apr 2022 08:33:40 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D17517EA
        for <linux-serial@vger.kernel.org>; Fri, 22 Apr 2022 05:30:47 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id o20-20020a05600c511400b0038ebbbb2ad8so5304406wms.0
        for <linux-serial@vger.kernel.org>; Fri, 22 Apr 2022 05:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=uYpfhyLIZUoxSaL7aclvytyYyaHl2rC8E7mXVViSyfc=;
        b=uRlDT3KghQ72J48ecDEdO6TbGuBv79C9de1+zDTZgknkJmgnuE/r1vj8Pz3Rt8qy2R
         HrMpv6ImE2wqji+7uwsnk6qL3uQlr6zXL8QIjGiKTPnfXN14BI+JUnT0BpBKQTav9Wmv
         MfU06RpRMiFymu9hXeZCZY8UAdetQOws9cngYkAH9J2Goqd0yJnUVmWUqkw5ut9Htguj
         gxJmTGiY1eo4el2mxgnzb6RTc/wlYvqM21V/BQfkMg7FC2c7W+I04t/QCnxIVObffiQq
         Qi5kisx98/GiAN0p27vcH4dV1tn1mPpR2pmdCcMaIiN+sisPBq5r9N/irdTLx3xxh2B7
         5yfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=uYpfhyLIZUoxSaL7aclvytyYyaHl2rC8E7mXVViSyfc=;
        b=4DFU2Cxs3AbzTOOj8hMCQgLD0BnnpTcNSf+pEEZoLWeSwAXAY3UX1fpz+Rv5CaVtXa
         vzvKeophrJUFylnl8Y6tcFmY7frMeL6u00y5WRpVO/mqyfbOCY4iyP+bKn1xmuMlEdo/
         8tHQTvvK/dClXe3SwCfytCdF3Q0KC1/+wDF53iL4MrphvEgcvBj52pVjoMRB7WVOAFXX
         b+NPqF6FRD5f2ncgmx5/ugtGhK1wQyJ6/pO2hOXzYtyigL6t6+wb3VrI2MIwKTwtz2Ep
         9WO/hr8pli9zr6vzfDEDCJyljQnBTsvLlaTmOIeRdEdm+Q0+PhnP2jPE34XNJm9Xe2QC
         em/w==
X-Gm-Message-State: AOAM531MnAR0/M+E/+o2Q/V36nn43/Xpww8Nd6MW+c46MhUupNgzV8xC
        G6QWUTuEw4hnMyFy2cfxnRO6Sw==
X-Google-Smtp-Source: ABdhPJz+Jz9pR1hcwEuMnRxUjM1J9wCJDr7UgRKwD7/jIw3O0t/ayEtSDbmDFocJ9N4ZPRpi3INr+A==
X-Received: by 2002:a05:600c:3ac8:b0:392:a821:7975 with SMTP id d8-20020a05600c3ac800b00392a8217975mr13087552wms.138.1650630645810;
        Fri, 22 Apr 2022 05:30:45 -0700 (PDT)
Received: from ?IPV6:2001:861:44c0:66c0:3ce1:1ed1:5e14:cd49? ([2001:861:44c0:66c0:3ce1:1ed1:5e14:cd49])
        by smtp.gmail.com with ESMTPSA id l10-20020a05600002aa00b0020a7cc29000sm1766232wry.75.2022.04.22.05.30.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 05:30:45 -0700 (PDT)
Message-ID: <3406cabe-4fac-ce1c-d710-ccd5f628aaaf@baylibre.com>
Date:   Fri, 22 Apr 2022 14:30:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V3 0/2] Add q 12MHz internal clock rate to calculate
Content-Language: en-US
To:     Yu Tu <yu.tu@amlogic.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20220422111320.19234-1-yu.tu@amlogic.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <20220422111320.19234-1-yu.tu@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 22/04/2022 13:13, Yu Tu wrote:
> 1.Added 12Mhz as the clock source for calculating baud rate.
> 
> 2.Added S4 SOC compatibility.
> 
> 
> Yu Tu (2):
>    tty: serial: meson: Add a 12MHz internal clock rate to calculate baud
>      rate in order to meet the baud rate requirements of special BT
>      modules
>    tty: serial: meson: Added S4 SOC compatibility
> 
> V1 -> V2: Change format as discussed in the email.
> V2 -> V3: Change format as discussed in the email.
> 
> Link:https://lore.kernel.org/linux-amlogic/20220418053202.24528-2-yu.tu@amlogic.com/
> 
>   drivers/tty/serial/meson_uart.c | 25 +++++++++++++++++++++++--
>   1 file changed, 23 insertions(+), 2 deletions(-)
> 
> 
> base-commit: 05fe70dd2efd13de700c2dfe5169d3a7a5050bc2

Thanks for this v3, all fine for me !

Neil
