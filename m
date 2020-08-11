Return-Path: <SRS0=7S4r=BV=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E50C433E0
	for <linux-serial@archiver.kernel.org>; Tue, 11 Aug 2020 13:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51C2E204FD
	for <linux-serial@archiver.kernel.org>; Tue, 11 Aug 2020 13:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F7HWNzuT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbgHKNv3 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 11 Aug 2020 09:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728721AbgHKNuo (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 11 Aug 2020 09:50:44 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C8EC061787
        for <linux-serial@vger.kernel.org>; Tue, 11 Aug 2020 06:50:39 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id 185so13580853ljj.7
        for <linux-serial@vger.kernel.org>; Tue, 11 Aug 2020 06:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i4nkoFmCJzzL1SkDVNUF5LncMf3gqSptzGPM/hRINOw=;
        b=F7HWNzuTxoTo7n+A7nt9eRcE7ODxZuX8PPec8qjyEnaLtoJ6mTxyC8TkKoh1/Wc2JZ
         YL9py4gevaJ+/g17NW9EgLePULdGQrxquDHfvpCtkpZZyPZbs9JrB8b5bSwUXciqSc9e
         C9cCs60raxbZLt4fS0V2khQANzLfsQd231OIz3EkdBiD0Cl4G1YGAa9G3Y0o+abKPyqD
         oOH1XDgZDb21rxAT3TbRORsYYwF/wLaQkvTiByNcO+TYJmqNehylDdOuziLD0JX/oEtb
         F/If9/Ia6n+DoU9pO0Bm4nf99MoML1fDjfiS65QKU6qbt0w4QinY0Jmqo8d//1XRWWKu
         iC1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i4nkoFmCJzzL1SkDVNUF5LncMf3gqSptzGPM/hRINOw=;
        b=EJh3AuwSzw4CwFNrjA6F5RkxAl/s5JhSSXlWy0Sy2tBezt7BXT5cc8OIB42IMrp2TO
         iU2TgKErHE+rcm+5DnV+4/s1+HjbNiC8cpJomsL1QzJ33je3CHSqM4aiIUTQNrMhMrdP
         94hkrcMj7eGxJW3X4m63RWy50Y2bU4rRNqnPPkPTM2X4UEQa30lrBQYjWBdW75VMzAid
         LS9dc0qNKlAdNE+rie9ewO488pKw4wE6C5sAdvko7uYzLGim+6r6nnrvQ381TO6LMUpw
         ZZuWqivehHtB/QLBReMsQjIh79qrXM2wboAMzZdAyGc/mPvNG5iR12oZTMBZWpN5UETf
         BBKQ==
X-Gm-Message-State: AOAM533BZFgFyhnU7MMPPJpgwVBdQ9G41JaWAbcm3s5Rp+0BkOhteIhw
        fmuL8D9yNlsypq87h1TJGFMXaEMEeK3YPoSuoIKk2A==
X-Google-Smtp-Source: ABdhPJxveGqBC6naFwxbBb/tftPi4ZI9ehibmsHubBYae/7EuAKXoEmf7JSw+kxTu+hUqP/WNud9nUKgzXFLU1zm2sY=
X-Received: by 2002:a05:651c:1293:: with SMTP id 19mr2935439ljc.427.1597153837662;
 Tue, 11 Aug 2020 06:50:37 -0700 (PDT)
MIME-Version: 1.0
References: <1595333413-30052-1-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1595333413-30052-1-git-send-email-sumit.garg@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 11 Aug 2020 19:20:26 +0530
Message-ID: <CAFA6WYMN=na4Pxnu1LYRVAAZRdV==5EwU-Vcq-QkRb_jaLiPmw@mail.gmail.com>
Subject: Re: [RFC 0/5] Introduce NMI aware serial drivers
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-serial@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net
Cc:     Jiri Slaby <jslaby@suse.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Jason Wessel <jason.wessel@windriver.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, 21 Jul 2020 at 17:40, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Make it possible for UARTs to trigger magic sysrq from an NMI. With the
> advent of pseudo NMIs on arm64 it became quite generic to request serial
> device interrupt as an NMI rather than IRQ. And having NMI driven serial
> RX will allow us to trigger magic sysrq as an NMI and hence drop into
> kernel debugger in NMI context.
>
> The major use-case is to add NMI debugging capabilities to the kernel
> in order to debug scenarios such as:
> - Primary CPU is stuck in deadlock with interrupts disabled and hence
>   doesn't honor serial device interrupt. So having magic sysrq triggered
>   as an NMI is helpful for debugging.
> - Always enabled NMI based magic sysrq irrespective of whether the serial
>   TTY port is active or not.
>
> Currently there is an existing kgdb NMI serial driver which provides
> partial implementation in upstream to have a separate ttyNMI0 port but
> that remained in silos with the serial core/drivers which made it a bit
> odd to enable using serial device interrupt and hence remained unused. It
> seems to be clearly intended to avoid almost all custom NMI changes to
> the UART driver.
>
> But this patch-set allows the serial core/drivers to be NMI aware which
> in turn provides NMI debugging capabilities via magic sysrq and hence
> there is no specific reason to keep this special driver. So remove it
> instead.
>
> Approach:
> ---------
>
> The overall idea is to intercept serial RX characters in NMI context, if
> those are specific to magic sysrq then allow corresponding handler to run
> in NMI context. Otherwise, defer all other RX and TX operations onto IRQ
> work queue in order to run those in normal interrupt context.
>
> This approach is demonstrated using amba-pl011 driver.
>
> Patch-wise description:
> -----------------------
>
> Patch #1 prepares magic sysrq handler to be NMI aware.
> Patch #2 adds NMI framework to serial core.
> Patch #3 and #4 demonstrates NMI aware uart port using amba-pl011 driver.
> Patch #5 removes kgdb NMI serial driver.
>
> Goal of this RFC:
> -----------------
>
> My main reason for sharing this as an RFC is to help decide whether or
> not to continue with this approach. The next step for me would to port
> the work to a system with an 8250 UART.
>

A gentle reminder to seek feedback on this series.

-Sumit

> Usage:
> ------
>
> This RFC has been developed on top of 5.8-rc3 and if anyone is interested
> to give this a try on QEMU, just enable following config options
> additional to arm64 defconfig:
>
> CONFIG_KGDB=y
> CONFIG_KGDB_KDB=y
> CONFIG_ARM64_PSEUDO_NMI=y
>
> Qemu command line to test:
>
> $ qemu-system-aarch64 -nographic -machine virt,gic-version=3 -cpu cortex-a57 \
>   -smp 2 -kernel arch/arm64/boot/Image -append 'console=ttyAMA0,38400 \
>   keep_bootcon root=/dev/vda2 irqchip.gicv3_pseudo_nmi=1 kgdboc=ttyAMA0' \
>   -initrd rootfs-arm64.cpio.gz
>
> NMI entry into kgdb via sysrq:
> - Ctrl a + b + g
>
> Reference:
> ----------
>
> For more details about NMI/FIQ debugger, refer to this blog post [1].
>
> [1] https://www.linaro.org/blog/debugging-arm-kernels-using-nmifiq/
>
> I do look forward to your comments and feedback.
>
> Sumit Garg (5):
>   tty/sysrq: Make sysrq handler NMI aware
>   serial: core: Add framework to allow NMI aware serial drivers
>   serial: amba-pl011: Re-order APIs definition
>   serial: amba-pl011: Enable NMI aware uart port
>   serial: Remove KGDB NMI serial driver
>
>  drivers/tty/serial/Kconfig       |  19 --
>  drivers/tty/serial/Makefile      |   1 -
>  drivers/tty/serial/amba-pl011.c  | 232 +++++++++++++++++-------
>  drivers/tty/serial/kgdb_nmi.c    | 383 ---------------------------------------
>  drivers/tty/serial/kgdboc.c      |   8 -
>  drivers/tty/serial/serial_core.c | 120 +++++++++++-
>  drivers/tty/sysrq.c              |  33 +++-
>  include/linux/kgdb.h             |  10 -
>  include/linux/serial_core.h      |  67 +++++++
>  include/linux/sysrq.h            |   1 +
>  kernel/debug/debug_core.c        |   1 +
>  11 files changed, 386 insertions(+), 489 deletions(-)
>  delete mode 100644 drivers/tty/serial/kgdb_nmi.c
>
> --
> 2.7.4
>
