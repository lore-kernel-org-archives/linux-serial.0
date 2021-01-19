Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF161C433DB
	for <linux-serial@archiver.kernel.org>; Tue, 19 Jan 2021 15:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E50F23119
	for <linux-serial@archiver.kernel.org>; Tue, 19 Jan 2021 15:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389068AbhASPW0 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 19 Jan 2021 10:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391289AbhASPVO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 19 Jan 2021 10:21:14 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D336C061573;
        Tue, 19 Jan 2021 07:20:34 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d4so10690115plh.5;
        Tue, 19 Jan 2021 07:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jxt4w4ggY4vN/CdqHUV7TtDziRTtz0CwnZSmwECkKwE=;
        b=uUlkjJFj2KO4UD0W1i4m2465xydGM4l+ACJN+jL/a9PtdOUN4uQVYvdJUO6JnBe3rl
         OzGiD/RCn1gO80P6GCwnELlFuVjiT0rKy6Uy7foPuPyeW1kNXDi0PHVnxHRjEVQ4xVh5
         oM0JkFai+5zUYoISXL2NCyaZsnS3GE22Maf2OfVe9d43QNgk2kA3OYRtH129XoNkEIhj
         +lFlfA4k0Ma0p49OpbfQTewCOsk6ZZEKtuw/8jue5gUmbgYMQduEvQkjr+LIdNGqWJ+g
         15Wt1lgJQrfsYhX7A+31NyQlSLNZUPNcvVBvQHBcwIzgH5ze5ponpBIlbwO4wLaLJ3Q7
         21NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jxt4w4ggY4vN/CdqHUV7TtDziRTtz0CwnZSmwECkKwE=;
        b=jq5qojm5c+bsTltGuhG+Sh5T2TbdNk0/5+w9ksWo4oUfcHRZdnHmfzpJzKYFw6lib9
         LFCKhcQuqrfsZOYM3lEe7x4p68aVvCcyZNeVCHJUvnicdqY/XNFAabr1PDpfCQl2WLLf
         xUxCpJIwTR8/PdI4W5s5/JgUShuK/a08PRjElz/VwGrUKC5GdQF2sNeTcXr86uxjMW1T
         7yTUl6FL4Qp+875wqSu0RG4315LbRhyFmcUmR2zzaLkbFkW6esJrBT6nFfxXRE1DUfO3
         uRAs/UolP15x1D/vr+a9TeeoAcgsSnOWr8FihPUldzL3+KeEjiPo2ymYJ/ahMJjDlX3e
         pwow==
X-Gm-Message-State: AOAM5318b67eQjjTwpgr9aRvo8ReXpnT5L4TzilgIMuy62cuMyCH1e3u
        XgjokBK1ixzoTkjHQyJEL0GuTGgchFMvQJzah8Q=
X-Google-Smtp-Source: ABdhPJy9cd4uD4ZDVNE5k4wYxMzfD0jsGzIDGtxq0M0R5ffZ9NGiqS5Rfxd7PGqzOuXmA8HLWIRHeQD7hiMi4oabo44=
X-Received: by 2002:a17:90a:6c90:: with SMTP id y16mr147003pjj.129.1611069634063;
 Tue, 19 Jan 2021 07:20:34 -0800 (PST)
MIME-Version: 1.0
References: <20210115211543.33563-1-alcooperx@gmail.com> <20210115211543.33563-3-alcooperx@gmail.com>
In-Reply-To: <20210115211543.33563-3-alcooperx@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 19 Jan 2021 17:21:23 +0200
Message-ID: <CAHp75VdQPQK8jTF3QDKx6mF1QzOg-qiuHrTiojnWn7GskokfoA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] serial: 8250: Add new 8250-core based Broadcom STB driver
To:     Al Cooper <alcooperx@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        devicetree <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Jan 15, 2021 at 11:19 PM Al Cooper <alcooperx@gmail.com> wrote:
>
> Add a UART driver for the new Broadcom 8250 based STB UART. The new
> UART is backward compatible with the standard 8250, but has some
> additional features. The new features include a high accuracy baud
> rate clock system and DMA support.
>
> The driver will use the new optional BAUD MUX clock to select the best
> one of the four master clocks (81MHz, 108MHz, 64MHz and 48MHz) to feed
> the baud rate selection logic for any requested baud rate.  This allows
> for more accurate BAUD rates when high speed baud rates are selected.
>
> The driver will use the new UART DMA hardware if the UART DMA registers
> are specified in Device Tree "reg" property. The DMA functionality can
> be disabled on kernel boot with the argument:
> "8250_bcm7271.disable_dma=Y".
>
> The driver also set the UPSTAT_AUTOCTS flag when hardware flow control
> is enabled. This flag is needed for UARTs that don't assert a CTS
> changed interrupt when CTS changes and AFE (Hardware Flow Control) is
> enabled.
>
> The driver also contains a workaround for a bug in the Synopsis 8250
> core. The problem is that at high baud rates, the RX partial FIFO
> timeout interrupt can occur but there is no RX data (DR not set in
> the LSR register). In this case the driver will not read the Receive
> Buffer Register, which clears the interrupt, and the system will get
> continuous UART interrupts until the next RX character arrives. The
> fix originally suggested by Synopsis was to read the Receive Buffer
> Register and discard the character when the DR bit in the LSR was
> not set, to clear the interrupt. The problem was that occasionally
> a character would arrive just after the DR bit check and a valid
> character would be discarded. The fix that was added will clear
> receive interrupts to stop the interrupt, deassert RTS to insure
> that no new data can arrive, wait for 1.5 character times for the
> sender to react to RTS and then check for data and either do a dummy
> read or a valid read. Sysfs error counters were also added and were
> used to help create test software that would cause the error condition.
> The counters can be found at:
> /sys/devices/platform/rdb/*serial/rx_bad_timeout_late_char
> /sys/devices/platform/rdb/*serial/rx_bad_timeout_no_char

Brief looking into the code raises several questions:
 - is it driver from the last decade?
 - why it's not using what kernel provides?
 - we have a lot of nice helpers:
   - DMA Engine API
   - BIT() and GENMASK() macros
   - tons of different helpers like regmap API (if you wish to dump
registers via debugfs)

Can you shrink this driver by 20-30% (I truly believe it's possible)
and split DMA driver to drivers/dma (which may already have something
similar there)?

-- 
With Best Regards,
Andy Shevchenko
