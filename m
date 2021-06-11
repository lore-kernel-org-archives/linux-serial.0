Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E166CC48BE0
	for <linux-serial@archiver.kernel.org>; Fri, 11 Jun 2021 09:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB76A613D3
	for <linux-serial@archiver.kernel.org>; Fri, 11 Jun 2021 09:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbhFKJhC (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 11 Jun 2021 05:37:02 -0400
Received: from mail-pl1-f181.google.com ([209.85.214.181]:40529 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbhFKJhB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 11 Jun 2021 05:37:01 -0400
Received: by mail-pl1-f181.google.com with SMTP id e7so2551133plj.7
        for <linux-serial@vger.kernel.org>; Fri, 11 Jun 2021 02:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=IcKwowicRBY+WFRXCMNgjtubHQbbf/h7juQp42wAOAU=;
        b=tOHp9HPozjX63ndz8ziYqtp/beuKAx/oZXSWk29V29v9IslVXaTyfEubSwyCt/Rpb6
         toM0yIxWJhYxsJsNo5pnqlZsX+6Y3ph9IevcogMxRAIwCI8sd/xMFf+m4MOgXKU5l3Ny
         67pmmk26sILUXkOAg7cQuwbsVMmvz4cJGeoGsIbLj0OCD3RwEGasZIRwSm3TJWlcOlSz
         J4M8mKzpB9DM6PVQGDLNAS2clqS0/k2ZI8Vi815E9qDS0m5LZZgd8VOZD/j3eug2KuNt
         CP2zQ+hnXXCRhf/5m2MQqmogE60sx8M+4/JrokzRlNFYEMk0rMM2KwhBpdKWoUUXx+AU
         jqcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=IcKwowicRBY+WFRXCMNgjtubHQbbf/h7juQp42wAOAU=;
        b=oCYhixOwtHvuTXmcoi/Diir/BwjFx2sfh6a6aUNyaHsEqLpstBiArbr40JJbeurB2h
         JCBgfJGe1LD7etL/ejqh+fJJwsrF/Wcm5L6LGPB8Ozt+fpHiYNYqeUvjOPXxwxMoVjbE
         OKZOFQitPSkFnCdmnqVVhVXpjFIMhH6bg4xM7QK90sDeJ9k1AIgl4o81mfmz8TC2N1E3
         /DY8AYJSqKTGf4zXEGW/KR5SyAAyTzArlupkwna/PQ9wu2bbYkXEdZU9Cxw2PyY7aDOk
         dvZ8Lt48NMEpv4KHIIf1QKfIS5RvV7wmUoBDkpCoMYp1KuAnpm9e0Po4vgwixRLa8MxA
         sFnA==
X-Gm-Message-State: AOAM532zZK6cWQXucjUXbAbTH3RbiLNZucvrp/VnNvoXGy0wumP3dIP0
        4QD0nPaB8EnrXjd2tLYpjKmwxiczHpyVdTf7
X-Google-Smtp-Source: ABdhPJwsRuRcqRLmZUIn7QPGgi/wASxNY23hk0WSh9XXVDl+1W8Ksg+ttTXOTT/5CcufxseXLT3eTg==
X-Received: by 2002:a17:90a:f094:: with SMTP id cn20mr3647125pjb.157.1623404027189;
        Fri, 11 Jun 2021 02:33:47 -0700 (PDT)
Received: from [192.168.0.118] ([103.242.196.232])
        by smtp.gmail.com with ESMTPSA id m12sm4699304pjq.53.2021.06.11.02.33.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 02:33:46 -0700 (PDT)
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, ldv-project@linuxtesting.org,
        andrianov@ispras.ru
From:   Saubhik Mukherjee <saubhik.mukherjee@gmail.com>
Subject: [question] Is it possible to remove an active port (without
 shutdown)?
Message-ID: <07b2ccfa-cf98-54a2-d03c-50507de06d52@gmail.com>
Date:   Fri, 11 Jun 2021 15:03:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Consider the following events involving drivers/tty/serial/owl-uart.c:

Suppose the driver is registered, and the owl_uart_probe() was called.
Then uart_startup() can be called in serial core. This calls
owl_uart_startup() which registers the interrupt handler owl_uart_irq.

Now suppose uart_remove_one_port() in serial core is called. This
detaches port from the core. This calls owl_uart_release_port(port).
This writes NULL to port->membase after iounmap of port->membase from
port->dev.

During this point, an interrupt is triggered and the interrupt callback
owl_uart_irq() is called (parallel with uart_remove_one_port()). This
tries to read port->membase to send or receive chars (with spinlock on
port->lock). This introduces a race condition on port->membase.

QUESTION: Is it possible to remove an active port (without shutdown)?
