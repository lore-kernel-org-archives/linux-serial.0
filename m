Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2C8C433F5
	for <linux-serial@archiver.kernel.org>; Fri, 28 Jan 2022 12:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348393AbiA1MbK (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 28 Jan 2022 07:31:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41462 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348392AbiA1MbJ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 28 Jan 2022 07:31:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643373069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XIRDUYVVBIv4oABEPDHoK/N//51UTD6HqpxDkdZpS2Q=;
        b=I+qSAK+KKZ5GeEaj5pkc+eo3ASY4Mpoe3b5T+pCq+Bo1SM14jXzb9pF6EAVKt4LAvYdQ4V
        9xUEFmeijDWXo503TZmkbSHvkyW9bBwZh86K7W2iTxgnyPD3mmx6DNKP3Jm806rG8ry85k
        nkdj3j+CxP6nEqT+rRFfeEwpFgYwfsI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-124-hykQ0bK1M_aEoPEk6fGfRQ-1; Fri, 28 Jan 2022 07:31:03 -0500
X-MC-Unique: hykQ0bK1M_aEoPEk6fGfRQ-1
Received: by mail-ej1-f70.google.com with SMTP id gb4-20020a170907960400b0069d1ebc4538so2834516ejc.2
        for <linux-serial@vger.kernel.org>; Fri, 28 Jan 2022 04:31:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XIRDUYVVBIv4oABEPDHoK/N//51UTD6HqpxDkdZpS2Q=;
        b=m5irAJMSqhBl2xwJgtUyxY1ohKiAEMso4BMbdygiw4T/hMI2YLJdx2/i5gUqK6y2E8
         zz7FEBb/wjSrcm8FX7VJT7SrDGUHUG9gROzZmMtHQoLzMAFnIFFgb57yFJF1TQDOKoup
         mPjmZgcl+XPXDoUOB3suyCeN8k0hd0nde5GDuWyAAV/VNm5b8hyHSul6Yj3fJgqS8iUq
         X8Vep3KSI5F0aAXBLFvnoBmgO87C1IKa8VtvSBLzZSOEn0E6ZmBmS20tWUNnbRTPXeoP
         fmrF2lJak1+/MfTj9idpgzv9eTfv7TLpfAazMpKQgDkyeiFV2/qQkK1O8j30eipMbFl5
         jAhw==
X-Gm-Message-State: AOAM533KUgTrJD/cO1U0EXQLYlAN2mfp+tyLn4dYR9v+Ce8OLcc3wSZY
        V9Ra9uzTpUjhm+tZnIyo+9r17TWSEONVsIBFZTQBO++wDlSivunVZ1LquhUj6gcOi48P4YbGcB9
        7uvr84ndztnmdyTgHL+av94IE01YDBQhJRU2Sd4da
X-Received: by 2002:a17:907:1b1a:: with SMTP id mp26mr6704323ejc.450.1643373062517;
        Fri, 28 Jan 2022 04:31:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyvjyELGFxOKKskpejzb2JP1D9Jfa6SMOyCUQiGyJQjx+SNJ8mteW7mUFRCEu3JrdCTAqBI9cdGrOOA1I7u5dE=
X-Received: by 2002:a17:907:1b1a:: with SMTP id mp26mr6704304ejc.450.1643373062272;
 Fri, 28 Jan 2022 04:31:02 -0800 (PST)
MIME-Version: 1.0
References: <YfMpk7DM9zA7NfmI@debian>
In-Reply-To: <YfMpk7DM9zA7NfmI@debian>
From:   Wander Costa <wcosta@redhat.com>
Date:   Fri, 28 Jan 2022 09:30:50 -0300
Message-ID: <CAAq0SUnNtS8b3419egw-WVH8ic+MxH8oQELm1K0s4iqt8pYKnQ@mail.gmail.com>
Subject: Re: Regression with 5021d709b31b ("tty: serial: Use fifo in 8250
 console driver")
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Wander Lairson Costa <wander@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=wcosta@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jan 27, 2022 at 8:24 PM Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
>
> Hi Wander,
>
> Not sure if this has been reported before but since last few weeks I am
> seeing a problem with the rpi4 serial port on my test setup. The initial
> boot message will be completely garbled as you can see at:
> https://lava.qa.codethink.co.uk/scheduler/job/543#L380.
> The last good boot was https://lava.qa.codethink.co.uk/scheduler/job/540#L390.
>
> The bisect log:
>
> # bad: [455e73a07f6e288b0061dfcf4fcf54fa9fe06458] Merge tag 'clk-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux
> # good: [7e7b69654724c72bd3219b71f58937845dca0b2b] Merge tag 'dma-mapping-5.17' of git://git.infradead.org/users/hch/dma-mapping
> git bisect start '455e73a07f6e288b0061dfcf4fcf54fa9fe06458' '7e7b69654724c72bd3219b71f58937845dca0b2b'
> # bad: [342465f5337f7bd5b8bd3b6f939ac12b620cbb43] Merge tag 'tty-5.17-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty
> git bisect bad 342465f5337f7bd5b8bd3b6f939ac12b620cbb43
> # good: [6dc69d3d0d18d587ab9d809fe060ba4417cf0279] Merge tag 'driver-core-5.17-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core
> git bisect good 6dc69d3d0d18d587ab9d809fe060ba4417cf0279
> # good: [e269f7acdc53623769da31135f60afeb3a65eaff] staging: r8188eu: remove the private ioctl "wps_assoc_req_ie"
> git bisect good e269f7acdc53623769da31135f60afeb3a65eaff
> # bad: [ad234e2bac274a43c9fa540bde8cd9f0c627b71f] tty: serial: meson: Drop the legacy compatible strings and clock code
> git bisect bad ad234e2bac274a43c9fa540bde8cd9f0c627b71f
> # good: [c66453ce8af8bac78a72ba4e21fd9a86720127d7] tty: fix kernel-doc in n_tty.c
> git bisect good c66453ce8af8bac78a72ba4e21fd9a86720127d7
> # good: [0882b473b084df31288003b3bee974aabac9dcf9] tty: serial: samsung: Enable console as module
> git bisect good 0882b473b084df31288003b3bee974aabac9dcf9
> # bad: [b4a29b94804c4774f22555651296b838df6ec0e4] serial: 8250: Move Alpha-specific quirk out of the core
> git bisect bad b4a29b94804c4774f22555651296b838df6ec0e4
> # good: [e822b4973f49015e1c6f63b91c8641ed9bfaf229] tty/ldsem: Fix syntax errors in comments
> git bisect good e822b4973f49015e1c6f63b91c8641ed9bfaf229
> # good: [fb09d0ac07725b442b32dbf53f0ab0bea54804e9] tty: Fix the keyboard led light display problem
> git bisect good fb09d0ac07725b442b32dbf53f0ab0bea54804e9
> # bad: [5021d709b31b8a14317998a33cbc78be0de9ab30] tty: serial: Use fifo in 8250 console driver
> git bisect bad 5021d709b31b8a14317998a33cbc78be0de9ab30
> # good: [adbfddc757aec1ed54ccb35c4a7ca9170df827e0] docs/driver-api: Replace a comma in the n_gsm.rst with a double colon
> git bisect good adbfddc757aec1ed54ccb35c4a7ca9170df827e0
> # first bad commit: [5021d709b31b8a14317998a33cbc78be0de9ab30] tty: serial: Use fifo in 8250 console driver
>
> And, indeed reverting 5021d709b31b ("tty: serial: Use fifo in 8250 console
> driver") on top of 23a46422c561 ("Merge tag 'net-5.17-rc2' of
> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net") fixes the problem
> for me.
>
> This is seen on every boot and I will be happy to test any patch.
>

Hi Sudip,

Thanks for the report. As Greg said, the patch has been reverted. In
the meantime, could you please apply this patch and report if the
problem still happens:

diff --git a/drivers/tty/serial/8250/8250_port.c
b/drivers/tty/serial/8250/8250_port.c
index 2abb3de11a48..d3a93e5d55f7 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3343,7 +3343,7 @@ static void serial8250_console_fifo_write(struct
uart_8250_port *up,
 {
        int i;
        const char *end = s + count;
-       unsigned int fifosize = up->port.fifosize;
+       unsigned int fifosize = up->tx_loadsz;
        bool cr_sent = false;

        while (s != end) {
@@ -3409,8 +3409,8 @@ void serial8250_console_write(struct
uart_8250_port *up, const char *s,
        }

        use_fifo = (up->capabilities & UART_CAP_FIFO) &&
-               port->fifosize > 1 &&
-               (serial_port_in(port, UART_FCR) & UART_FCR_ENABLE_FIFO) &&
+               up->tx_loadsz > 1 &&
+               (up->fcr & UART_FCR_ENABLE_FIFO) &&
                /*
                 * After we put a data in the fifo, the controller will send
                 * it regardless of the CTS state. Therefore, only use fifo


>
> --
> Regards
> Sudip
>

