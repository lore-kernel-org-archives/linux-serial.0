Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BD8C43460
	for <linux-serial@archiver.kernel.org>; Fri,  2 Apr 2021 23:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC13B61185
	for <linux-serial@archiver.kernel.org>; Fri,  2 Apr 2021 23:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbhDBXGC (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 2 Apr 2021 19:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235559AbhDBXGC (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 2 Apr 2021 19:06:02 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D1BC061788
        for <linux-serial@vger.kernel.org>; Fri,  2 Apr 2021 16:06:00 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id l18so6751246edc.9
        for <linux-serial@vger.kernel.org>; Fri, 02 Apr 2021 16:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=1o3mwroNBoAuLOlIh15manz3+II8YB7vap48CyP33FM=;
        b=DgCGLWdoQPmW0QWE3q5Z6g+kA2oav3BWO9wxqe+GT9Jt2RdyBgeD8Z5X9WCQcc6YPX
         gqTpH0isx9WgNLjGq7byl8U3b8ewySalLYm54x5XzdlROU9oLSiiadZ8GwPYNkqn6DLG
         QrnXAXKivJelx9MPqgVq9sOmOE/5CD2gCXK4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=1o3mwroNBoAuLOlIh15manz3+II8YB7vap48CyP33FM=;
        b=PS73NJZN5RJCEOcGWPxwn49n62Fu7C9dLqMwM/QoFBQDhYqma5jNAzU81LuELEqKLI
         0vdRxtwaGoulbtfpxeRFLOYhCGy8x1/DmMXxM76ppFYUDrECXV7BuIN8HPvO3bTzwbxS
         D6RXWw5VhRQ/TQQXV2J2gD911oINIoxbbWtZ9tW8kIWksSz/Cf987mxEyoaLkwKoulaD
         59BRO3X0pE0LqHX8smnvJwzDk4bVp/e93ryxDqwxsMYvhlZU394eUIpyMVHGg6YJwKYP
         t4525UgjtkvNHxeE4ScV6xALwoBd3iuynkHXUegxABOaZf9uaf2MyQa7ZHBsEy5qbtyC
         6qvg==
X-Gm-Message-State: AOAM532lxt6eSZllb5qdcoBGLBNbW/zUAPXMfAe14IAkmHgIw6LDUAF7
        7kY+RVRtM4bwtWDmIU8TwcwnHNyybc69fg==
X-Google-Smtp-Source: ABdhPJw68eoIJ13ehs1Uje6q44/fnnOooC7D+uxHI2lQX858hWyHRl8IDPPgACQALvKCjNv1vb54Lg==
X-Received: by 2002:aa7:da06:: with SMTP id r6mr18231355eds.86.1617404759207;
        Fri, 02 Apr 2021 16:05:59 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id k12sm6199530edr.60.2021.04.02.16.05.58
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Apr 2021 16:05:58 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id h10so6723815edt.13
        for <linux-serial@vger.kernel.org>; Fri, 02 Apr 2021 16:05:58 -0700 (PDT)
X-Received: by 2002:aa7:c551:: with SMTP id s17mr18107194edr.291.1617404757601;
 Fri, 02 Apr 2021 16:05:57 -0700 (PDT)
MIME-Version: 1.0
From:   Raul Rangel <rrangel@chromium.org>
Date:   Fri, 2 Apr 2021 17:05:47 -0600
X-Gmail-Original-Message-ID: <CAHQZ30CfD_stEhc656odJQGZnVj0ypEB4EFAqfZbV2UpFm_1Lg@mail.gmail.com>
Message-ID: <CAHQZ30CfD_stEhc656odJQGZnVj0ypEB4EFAqfZbV2UpFm_1Lg@mail.gmail.com>
Subject: univ8250_console replaces earlycon too early
To:     linux-serial@vger.kernel.org
Cc:     Daniel Kurtz <djkurtz@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello,

I'm working on an x86 system that doesn't have any legacy UARTs
(0x3f8, etc) mapped. Instead it uses MMIO UARTs defined by ACPI. It
seems that in this case the univ8250_console console is registered too
early. It replaces `earlycon` before the ACPI consoles have had a
chance to load. This results in losing about 500ms of console logs in
my case.

Here is my log with some print statements:
```
[    0.677076] serial8250_isa_init_ports: start
[    0.681808] serial8250_isa_init_ports: checking old serial port 0
[    0.688566] serial8250_isa_init_ports: iobase: 0x3f8, irq: 4,
uartclk: 1843200
[    0.696579] serial8250_isa_init_ports: checking old serial port 1
[    0.703338] serial8250_isa_init_ports: iobase: 0x2f8, irq: 3,
uartclk: 1843200
[    0.711352] serial8250_isa_init_ports: checking old serial port 2
[    0.718110] serial8250_isa_init_ports: iobase: 0x3e8, irq: 4,
uartclk: 1843200
[    0.726124] serial8250_isa_init_ports: checking old serial port 3
[    0.732884] serial8250_isa_init_ports: iobase: 0x2e8, irq: 3,
uartclk: 1843200
[    0.740899] univ8250_console_setup: iobase: 0x3f8, irq: 4, uartclk: 1843200
[    0.748623] serial8250_console_setup: iobase: 0x3f8, irq: 4, uartclk: 1843200
[    0.756540] serial8250_console_setup: options: 115200
[    0.762147] serial8250_console_setup: iobase: 0x3f8, irq: 4, uartclk: 1843200
[    0.770064] printk: console [ttyS0] enabled <- univ8250_console
[    0.774789] printk: bootconsole [uart0] disabled
... nothing
[    1.224845] printk: console [ttyS0] enabled <- This is the
AMDI0020:00 console getting loaded
[    1.229061] uart_add_one_port: Setting up console!
[    1.235099] serial8250_register_8250_port: Done!
[    1.239748] serial8250_register_8250_port: idx: 0, iobase: 0x0,
membase: ffff96e70007d000, irq: 4, uartclk: 48000000
[    1.250329] serial8250_register_8250_port: idx: 1, iobase: 0x2f8,
membase: 0000000000000000, irq: 3, uartclk: 1843200
[    1.260957] serial8250_register_8250_port: idx: 2, iobase: 0x3e8,
membase: 0000000000000000, irq: 4, uartclk: 1843200
[    1.271585] serial8250_register_8250_port: idx: 3, iobase: 0x2e8,
membase: 0000000000000000, irq: 3, uartclk: 1843200
[    1.282213] dw-apb-uart AMDI0020:00: RX: register port done
[    1.287897] dw-apb-uart AMDI0020:00: RX: set active
[    1.292805] dw-apb-uart AMDI0020:00: RX: done
[    1.297599] dw-apb-uart AMDI0020:01: RX: dw8250_probe: Probing UART
[    1.303976] dw-apb-uart AMDI0020:01: RX: UART Clock: 0
[    1.309143] dw-apb-uart AMDI0020:01: RX: Overriding baud clock: 48000000
[    1.315911] dw-apb-uart AMDI0020:01: RX: Quirks
[    1.320674] dw-apb-uart AMDI0020:01: RX: setup port
[    1.325665] dw-apb-uart AMDI0020:01: RX: setup port done
[    1.331007] dw-apb-uart AMDI0020:01: RX: register port
```

What would be the correct way to fix this?
Should we probe the legacy (0x3f8) device before attaching
univ8250_console so it doesn't override earlycon?

Thanks,
Raul
