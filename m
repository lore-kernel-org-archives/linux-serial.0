Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBF7C433B4
	for <linux-serial@archiver.kernel.org>; Fri, 23 Apr 2021 19:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BEAE61422
	for <linux-serial@archiver.kernel.org>; Fri, 23 Apr 2021 19:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243832AbhDWT54 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 23 Apr 2021 15:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232645AbhDWT5t (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 23 Apr 2021 15:57:49 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0391C061574;
        Fri, 23 Apr 2021 12:57:10 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id g9so33464718wrx.0;
        Fri, 23 Apr 2021 12:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=YUWtKeLe5I3ivX9OWOWDdvoRTK1oFcdFGPOroMjkEGU=;
        b=pP43qJzRbMc7oBFX6BIx9wdJdjyZs3EicjlsAriHVvOYX5lKsMe9zhxDORKpVYQny+
         cO2i6/su2kN/5c3BiUe0vnDlLKwNjuq5WGpYjLYPwxZR77n/6GtEp0ik6t0omkvNeV7X
         obWAx5nNHri7Z5Nn6/4h35/yfmB6z+PbZMmyQ5LLP8Zof0ULH6QQ5yt5x3bEtR91a2X5
         8dYiSv6k4iO8Mo7PNzspAOl56rOQXKuIHH4UEUo0Q3ypNU33Zw1ZTHWq9VVDNz81nNsC
         Moj1blT+oUwqHAMEJdYZ1xVp5q2gAhULLIaxMWl0LzoGbgDu48kPzo4u+x5AD2cZcBsA
         XP+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=YUWtKeLe5I3ivX9OWOWDdvoRTK1oFcdFGPOroMjkEGU=;
        b=UPiQ46Z9Dq7QJCyQ2yLtBamX1320sG+MC0z8+ypp17vd5oyzN5tTQsVYknP1+VbayQ
         tEf4K87M3MV++tnstwRP7PHq/wadkA2ei0FLsONqwo5BvUC09n07DTdFKoQsuxXZ5Ifj
         ChsJLwy7s2ltOZwkmbqamm7GdFdeylmIRe8IJiNgPiDnbrF/xy/a2AWiz7IWvhVqaSaB
         cwHMxbSP/2pKykOZdLVUCkd1uTlge7mCUfrTnjo4Hki/chaXVejQprxMQW1MYjo0xXGn
         naVr3G27NqtJ0ygDTOYxhkB3WDx9WjXJnN1C7EHYxXIFxkLdoCRwbLzr/qRSyGtz/gnP
         jleg==
X-Gm-Message-State: AOAM530mCij3EBb1zP9BdxmOThgxXofbDqK2DsG2I2pvGxr0U/4viIYG
        GzHokqbobSE0jlYTlbNNG0g=
X-Google-Smtp-Source: ABdhPJwQQ3NVkauuahkUyYLy7f2M0TQNKHjhhwiQTHGeC2er70LNaQJ48W1s2+bxcRlhMsqxOYpokQ==
X-Received: by 2002:a5d:468b:: with SMTP id u11mr6691554wrq.293.1619207829509;
        Fri, 23 Apr 2021 12:57:09 -0700 (PDT)
Received: from [192.168.2.202] (p5487b3cb.dip0.t-ipconnect.de. [84.135.179.203])
        by smtp.gmail.com with ESMTPSA id a2sm10593342wrt.82.2021.04.23.12.57.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Apr 2021 12:57:08 -0700 (PDT)
To:     linux-serial@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wang Hongcheng <annie.wang@amd.com>, Ken Xue <Ken.Xue@amd.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Subject: Support for AMDI0022 UART
Message-ID: <295686a0-240d-71d1-a6a0-f3752cf24477@gmail.com>
Date:   Fri, 23 Apr 2021 21:57:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi all,

I received a report from a Surface Laptop 4 which has a UART that is
identified as AMDI0022 in ACPI [1] and that does not seem to be
supported by the kernel yet.

 From what I can tell via ACPI, this is similar to the AMDI0020 [2] UART
that's already supported by the kernel (well, both are devices with two
MMIO regions and an interrupt as far as I can tell...). So it's possible
that all that's needed is adding it to the respective device ID lists
[3, 4]. Unfortunately, I a) don't have a device to test this myself, b)
haven't found any more details on that online, and c) don't want to tell
others to test this without knowing a bit more about that (potentially
writing random stuff to some unknown MMIO region that I don't know
anything about doesn't sound as safe to me as I'd like).

Does anyone here have some pointers on what it'd take to support this,
or any contacts at AMD that could provide more insight?

Regards
Max

[1]: AMDI0022 in ACPI (Surface Laptop 4)
https://github.com/linux-surface/acpidumps/blob/2e24c80d4c7a99a9295aa0b1b2e5e92df93378b4/surface_laptop_4_amd/dsdt.dsl#L1432

[2]: AMDI0020 in ACPI (Surface Laptop 3)
https://github.com/linux-surface/acpidumps/blob/62972f0d806cef45ca01341e3cfbabc04c6dd583/surface_laptop_3_15/dsdt.dsl#L1806

[3]: ID list for 8250_dw
https://elixir.bootlin.com/linux/v5.12-rc8/source/drivers/tty/serial/8250/8250_dw.c#L715

[4]: ID list for acpi_apd
https://elixir.bootlin.com/linux/v5.12-rc8/source/drivers/acpi/acpi_apd.c#L228
