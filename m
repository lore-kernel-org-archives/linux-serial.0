Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD0AC433ED
	for <linux-serial@archiver.kernel.org>; Mon,  5 Apr 2021 19:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 270036139F
	for <linux-serial@archiver.kernel.org>; Mon,  5 Apr 2021 19:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235225AbhDETY5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 5 Apr 2021 15:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbhDETYz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 5 Apr 2021 15:24:55 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D44C061756
        for <linux-serial@vger.kernel.org>; Mon,  5 Apr 2021 12:24:48 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id r22so1201426edq.9
        for <linux-serial@vger.kernel.org>; Mon, 05 Apr 2021 12:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y6XKTG8GFuacgww4OlAEGV+T7U6wSFcc4617bBtaCOs=;
        b=KnaKu84jJ4/W64OYvLSxW/JEdiXP/6aiYMOwN1An+QEaT1PSGEnXGveRoDa0sqX+OO
         akttChDXFL6+OyKOdhKGxSiX+m6R4Eevz8p0gjQ8yIcCsliVAl2rjnx1jWKQq6ZHLuHR
         UrE+GysloVBGlGEE84vZJkXDA5ph7vHkKjTws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y6XKTG8GFuacgww4OlAEGV+T7U6wSFcc4617bBtaCOs=;
        b=GL+U9EEozz7+gwDQe/OEPmNoZ+2v9l8efdXYs/VnsHdAYcAy+0q6oIYNYfpDT/3a9L
         mx2S/poxqxtxZJgkoFOtavgQTRM9BbtHAadtag9l/Su5c/GiBlzlZGF6HuhI++Io8WGK
         Ik46n+ZDT9gDcHNfVbhIn/MOn5X8sqlR/zMUpkqgLjxrmbJ8uYm+y0FmPLo+Xko5yMX9
         Dfqbo6Gq4mpow6jkaLauDsDJzDh45D7ACX4N0oTjgKAikU0ShDkbMspwKQXOa3jDfbU2
         pge79ihqYmsLTguMu3EwZJmu6bwx75ppw+o99Lk5skNcWkG4YoSk7PS7A7h4N9Imo+kA
         wqkQ==
X-Gm-Message-State: AOAM533kniS+aNHm7tvV/qA4iHwvPkfYlVpCJfLBGu6sC9P1nwhFnbdh
        E+YK0h/OJO0DRGw98bGWi0FB4ZcYWYkECg==
X-Google-Smtp-Source: ABdhPJwvIjiA0aNzAkHwCOHkbv7QU+W21Rsx8xZz1wlgf7fGMO+GJXqc9qZJWAFOPnJlX35Zh/r6cA==
X-Received: by 2002:aa7:c9c8:: with SMTP id i8mr32832981edt.193.1617650686512;
        Mon, 05 Apr 2021 12:24:46 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id gb22sm9294383ejc.78.2021.04.05.12.24.45
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Apr 2021 12:24:45 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id k8so6281529edn.6
        for <linux-serial@vger.kernel.org>; Mon, 05 Apr 2021 12:24:45 -0700 (PDT)
X-Received: by 2002:a05:6402:254f:: with SMTP id l15mr33309110edb.189.1617650684876;
 Mon, 05 Apr 2021 12:24:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAHQZ30CfD_stEhc656odJQGZnVj0ypEB4EFAqfZbV2UpFm_1Lg@mail.gmail.com>
In-Reply-To: <CAHQZ30CfD_stEhc656odJQGZnVj0ypEB4EFAqfZbV2UpFm_1Lg@mail.gmail.com>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Mon, 5 Apr 2021 13:24:34 -0600
X-Gmail-Original-Message-ID: <CAHQZ30C-pUUUHcg5LWX-fMDpBjX2S05ULC6GYZN8JVXRrUx6Qg@mail.gmail.com>
Message-ID: <CAHQZ30C-pUUUHcg5LWX-fMDpBjX2S05ULC6GYZN8JVXRrUx6Qg@mail.gmail.com>
Subject: Re: univ8250_console replaces earlycon too early
To:     linux-serial@vger.kernel.org
Cc:     Daniel Kurtz <djkurtz@chromium.org>, peter@hurleysoftware.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

So I changed the following line:
https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/third_party/kernel/v5.10/drivers/tty/serial/8250/8250_core.c;l=579

diff --git a/drivers/tty/serial/8250/8250_core.c
b/drivers/tty/serial/8250/8250_core.c
index cae61d1ebec5..c26056b67c38 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -576,7 +584,7 @@ serial8250_register_ports(struct uart_driver *drv,
struct device *dev)
        }
 }

-#ifdef CONFIG_SERIAL_8250_CONSOLE
+#if 0

 static void univ8250_console_write(struct console *co, const char *s,
                                   unsigned int count)

I now no longer see the missing gap in my serial logs: https://0paste.com/233818

Here is my command line: earlycon=uart,mmio32,0xfedc9000 console=ttyS0,115200
I can't unset SERIAL_8250_CONSOLE since that provides my earlycon.

What is the purpose of the universal console on x86? It looks like
serial8250_isa_init_ports is called from serial8250_init:
https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/third_party/kernel/v5.10/drivers/tty/serial/8250/8250_core.c;l=1173
When called this way, it tries to probe 0x3f8, and fails, so the
earlyconsole isn't replaced until the ACPI node is parsed.

Thanks,
Raul


On Fri, Apr 2, 2021 at 5:05 PM Raul Rangel <rrangel@chromium.org> wrote:
>
> Hello,
>
> I'm working on an x86 system that doesn't have any legacy UARTs
> (0x3f8, etc) mapped. Instead it uses MMIO UARTs defined by ACPI. It
> seems that in this case the univ8250_console console is registered too
> early. It replaces `earlycon` before the ACPI consoles have had a
> chance to load. This results in losing about 500ms of console logs in
> my case.
>
> Here is my log with some print statements:
> ```
> [    0.677076] serial8250_isa_init_ports: start
> [    0.681808] serial8250_isa_init_ports: checking old serial port 0
> [    0.688566] serial8250_isa_init_ports: iobase: 0x3f8, irq: 4,
> uartclk: 1843200
> [    0.696579] serial8250_isa_init_ports: checking old serial port 1
> [    0.703338] serial8250_isa_init_ports: iobase: 0x2f8, irq: 3,
> uartclk: 1843200
> [    0.711352] serial8250_isa_init_ports: checking old serial port 2
> [    0.718110] serial8250_isa_init_ports: iobase: 0x3e8, irq: 4,
> uartclk: 1843200
> [    0.726124] serial8250_isa_init_ports: checking old serial port 3
> [    0.732884] serial8250_isa_init_ports: iobase: 0x2e8, irq: 3,
> uartclk: 1843200
> [    0.740899] univ8250_console_setup: iobase: 0x3f8, irq: 4, uartclk: 1843200
> [    0.748623] serial8250_console_setup: iobase: 0x3f8, irq: 4, uartclk: 1843200
> [    0.756540] serial8250_console_setup: options: 115200
> [    0.762147] serial8250_console_setup: iobase: 0x3f8, irq: 4, uartclk: 1843200
> [    0.770064] printk: console [ttyS0] enabled <- univ8250_console
> [    0.774789] printk: bootconsole [uart0] disabled
> ... nothing
> [    1.224845] printk: console [ttyS0] enabled <- This is the
> AMDI0020:00 console getting loaded
> [    1.229061] uart_add_one_port: Setting up console!
> [    1.235099] serial8250_register_8250_port: Done!
> [    1.239748] serial8250_register_8250_port: idx: 0, iobase: 0x0,
> membase: ffff96e70007d000, irq: 4, uartclk: 48000000
> [    1.250329] serial8250_register_8250_port: idx: 1, iobase: 0x2f8,
> membase: 0000000000000000, irq: 3, uartclk: 1843200
> [    1.260957] serial8250_register_8250_port: idx: 2, iobase: 0x3e8,
> membase: 0000000000000000, irq: 4, uartclk: 1843200
> [    1.271585] serial8250_register_8250_port: idx: 3, iobase: 0x2e8,
> membase: 0000000000000000, irq: 3, uartclk: 1843200
> [    1.282213] dw-apb-uart AMDI0020:00: RX: register port done
> [    1.287897] dw-apb-uart AMDI0020:00: RX: set active
> [    1.292805] dw-apb-uart AMDI0020:00: RX: done
> [    1.297599] dw-apb-uart AMDI0020:01: RX: dw8250_probe: Probing UART
> [    1.303976] dw-apb-uart AMDI0020:01: RX: UART Clock: 0
> [    1.309143] dw-apb-uart AMDI0020:01: RX: Overriding baud clock: 48000000
> [    1.315911] dw-apb-uart AMDI0020:01: RX: Quirks
> [    1.320674] dw-apb-uart AMDI0020:01: RX: setup port
> [    1.325665] dw-apb-uart AMDI0020:01: RX: setup port done
> [    1.331007] dw-apb-uart AMDI0020:01: RX: register port
> ```
>
> What would be the correct way to fix this?
> Should we probe the legacy (0x3f8) device before attaching
> univ8250_console so it doesn't override earlycon?
>
> Thanks,
> Raul
