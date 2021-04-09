Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963DBC433ED
	for <linux-serial@archiver.kernel.org>; Fri,  9 Apr 2021 09:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E00B611BF
	for <linux-serial@archiver.kernel.org>; Fri,  9 Apr 2021 09:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbhDIJwE (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 9 Apr 2021 05:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbhDIJwD (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 9 Apr 2021 05:52:03 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAD9C061760;
        Fri,  9 Apr 2021 02:51:51 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id z16so3503258pga.1;
        Fri, 09 Apr 2021 02:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=835Zi1xTmXJGXAKE9J8dlAI7VhoZUO683V3q48FcZac=;
        b=sFZA1KURzYxVfNqPMbAd7kOI8nAXYDBBkDp2lXqno5ehHUF0HY6pdl6TQdcRNy7B9l
         4394fjcntVMReHZRGPCLcI560NL5JjHY805ktidW4xX52LLrSlm4oH6xn4R0wN3UBd1l
         T8x51L3OBXnP8n2b1KfP87k2WFvVCAEHyCzhiBVY2gL3bYk/LEUcnMs48ksgtgQMvCKF
         0tdm4Vacdlq3ywbRwNPK6wnWoiWhSENFS0WIxS3g/V28ZmFX1snmg4xMnOJsCOHED3yE
         6jikz9rVOhqcZyOg58Ncd/zht+6knivVAqzcKf/QsqgHerSkfyHUTuul60DTsF/yewd7
         eZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=835Zi1xTmXJGXAKE9J8dlAI7VhoZUO683V3q48FcZac=;
        b=RIXmftcgCMFjIhUM+KyqMFSkXFXpKeCXKcSgFjRQ03091IpOI8N+pKOHaDAzYy+vNG
         b/lmS39hMTe33F2IH3Uen8Z1EX190LPEw1ijkuV+9lCtnsNYZlFqhaBWGsB0qQIa6xD8
         DqWqfMFmbZh2F8GGeigv5Mlv/mLAe0/2yqym2PHRDHt6j8QqVYpk+u+Kg6Lg2ED+H8kV
         7nbym+aMtmsf4a/QlRxSfwxjoHVFDBt8ooGQrbj5zNuSahi2IeDv7FzgGPaeszlToC48
         Lbox1PMIXjUshIxTDAygEiOTLDxn/ZQxFnXZN2CJSq5UY+8JnRMoElhwmUqfEE7Tx0x5
         S2Bw==
X-Gm-Message-State: AOAM530Cd13lb5F4tOmRI47yunWf9kF7nUwqoRH8DDnvkpH2MNnd/9Lh
        EGJ3g8pZf+AXHLDEPbaBZwgc2zUHUwctdLOmNs4=
X-Google-Smtp-Source: ABdhPJwHvBsJQE4ylmZcWPrAUIq/SkKRzEotMiouB2sMwJnEEC0377S6hgWN898bfdz+ZUvTZ9V6cqy4TPYEfnaOV20=
X-Received: by 2002:a63:c48:: with SMTP id 8mr12275599pgm.74.1617961910677;
 Fri, 09 Apr 2021 02:51:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210408011637.5361-1-zev@bewilderbeest.net> <20210408011637.5361-3-zev@bewilderbeest.net>
 <CAHp75Vd6kk0E-kALEGOhsg=YHKhmKLY6cpCTdviOFenO4p1-2A@mail.gmail.com> <YHAEfn4li6F8L9JC@hatter.bewilderbeest.net>
In-Reply-To: <YHAEfn4li6F8L9JC@hatter.bewilderbeest.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 9 Apr 2021 12:51:34 +0300
Message-ID: <CAHp75VfpE-AvhzN216KwJvxQ25euGTN_kziJ0hKxYCOXXA2BTw@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] drivers/tty/serial/8250: refactor sirq and lpc
 address setting code
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Joel Stanley <joel@jms.id.au>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Apr 9, 2021 at 10:38 AM Zev Weiss <zev@bewilderbeest.net> wrote:
>
> On Fri, Apr 09, 2021 at 02:24:08AM CDT, Andy Shevchenko wrote:
> >On Thursday, April 8, 2021, Zev Weiss <zev@bewilderbeest.net> wrote:
> >
> >> This splits dedicated aspeed_vuart_set_{sirq,lpc_address}() functions
> >> out of the sysfs store functions in preparation for adding DT
> >> properties that will be poking the same registers.  While we're at it,
> >> these functions now provide some basic bounds-checking on their
> >> arguments.
> >>
> >>
> >
> >Please, use prefix =E2=80=9Cserial: 8250_aspeed_vuart:=E2=80=9D instead =
of what you have in
> >the subject line. I think I have told this already
> >
> >
>
> Ah, sorry -- I fixed the cover letter after your first comment (which
> had definitely been under-tagged); for the patches themselves I was
> following the example of the last patch in that particular area
> (8d310c9107a2), though I guess that wasn't the right model to follow.
> I'll use the requested format in the future.

Just random amount of most recent patches against 8250 driver:

e47eb5241a8f serial: 8250: Avoid new transfers when shutting down
e49950d3e737 serial: 8250_dma: use linear buffer for transmit
34255381fabd serial: 8250_port: Try to run DMA Rx on timeout condition
7d7dec450a66 8250_tegra: clean up tegra_uart_handle_break
c3ae3dc896fa serial: 8250_pci: Drop bogus __refdata annotation
d96f04d347e4 serial: 8250_omap: Avoid FIFO corruption caused by MDR1 access
6e4e636e0e3e serial: 8250-mtk: Fix reference leak in mtk8250_probe
a609c58086e3 tty: serial: 8250: 8250_port: Move prototypes to shared locati=
on
6f9918504129 serial: 8250: 8250_omap: Fix unused variable warning
d4548b14dd7e serial: 8250: 8250_omap: Fix possible array out of bounds acce=
ss
912ab37c7987 serial: 8250_mtk: Fix uart_get_baud_rate warning
439c7183e5b9 serial: 8250: 8250_omap: Disable RX interrupt after DMA enable
32ed248042d1 tty: serial: 8250: serial_cs: Remove unused/unchecked
variable 'err'
85985a3dcd74 serial: 8250_dw: Fix clk-notifier/port suspend deadlock
c8dff3aa8241 serial: 8250: Skip uninitialized TTY port baud rate update
7718453e3696 serial: 8250: Discard RTS/DTS setting from clock update method
409cc4541ade serial: 8250_fsl: Fix TX interrupt handling condition
3c5a87be170a serial: 8250_pci: Add Realtek 816a and 816b
ea4de367e57d tty: serial: 8250_mtk: set regshift for mmio32
57cee0713118 serial: 8250_pci: Remove unused function get_pci_irq()
11361610b005 serial: 8250_fsl: Add ACPI support




--=20
With Best Regards,
Andy Shevchenko
