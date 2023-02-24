Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1939BC7EE2F
	for <linux-serial@archiver.kernel.org>; Fri, 24 Feb 2023 21:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjBXVYh (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 24 Feb 2023 16:24:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjBXVYf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 24 Feb 2023 16:24:35 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD221B2F7
        for <linux-serial@vger.kernel.org>; Fri, 24 Feb 2023 13:24:25 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id o12so2477871edb.9
        for <linux-serial@vger.kernel.org>; Fri, 24 Feb 2023 13:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z7FL2J01+S1brZJhkSmrAVHSbND/ljBuG/iYSX39T/M=;
        b=FqYqL229nQFsdT8zagqSYUMC8fLl9jL1yBbVwID9qj6Af/qat8UsxUyPUbVHQpJ7+T
         SJ+IpE7G2Dxp0LqEdrRQIHMRFrAGpcpX6LdLMzlANx2xVHKvm/d88opMaHNpgQBBTE9D
         EsQYuqWJVIcKvbzccwf/F+ujbtwgB68lPVm1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z7FL2J01+S1brZJhkSmrAVHSbND/ljBuG/iYSX39T/M=;
        b=Un4MjCRXn4j+w1dLaH4e0P0j0mwZ5OHQkuUtak9Hjx6424PWuLoVj48aGbbfFaF4xe
         lMRJ/3L23avBMgB7FghdXMEDUfRlicLYfutnAiE1DiO33EL0ywEnrl9iqx625M5dJ9TA
         f8SG79B6DkLtQnRML1X9zCpg4taHIfb6Z4sTnQL0bf2OoC59rZyaV29qbhY+aMPgm5bj
         +spgNvbReNM/ATD+3Codrm7/ga8OEkI8XmmZRXB6hfmB7vaQuxwsCfyYGnwmGGRzje3/
         fuqoWTHhxbUWwgW4EUXhfPlOCzCFCeAW2n7OlJ27UiSmaZSd+mL+OrYrDWewJM83r8kj
         DcjQ==
X-Gm-Message-State: AO0yUKWhwFQGrHElZctYHZNVsxsOKvbtFuAzuDIS6t1n77cYzxZCZFqO
        bbChG2DJ891Yt6yZl30QMbZskzQKsJ2P2zkrK7NnmA==
X-Google-Smtp-Source: AK7set/QfGBuBOPXSvmSUPt10Ku0DGDaixm9LHnWeTKk2+ySeAXtHgOMvuDA8BmufCkT/OFsUjYNbw==
X-Received: by 2002:a17:907:8c88:b0:8ea:5f7d:9007 with SMTP id td8-20020a1709078c8800b008ea5f7d9007mr11216412ejc.48.1677273863700;
        Fri, 24 Feb 2023 13:24:23 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id c15-20020a170906340f00b008e7916f0bdesm12557ejb.138.2023.02.24.13.24.22
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 13:24:23 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id o12so2477521edb.9
        for <linux-serial@vger.kernel.org>; Fri, 24 Feb 2023 13:24:22 -0800 (PST)
X-Received: by 2002:a17:906:b55:b0:8f1:4cc5:f14c with SMTP id
 v21-20020a1709060b5500b008f14cc5f14cmr2756517ejg.0.1677273862668; Fri, 24 Feb
 2023 13:24:22 -0800 (PST)
MIME-Version: 1.0
References: <Y/iywbFbiUAA6ZD3@kroah.com>
In-Reply-To: <Y/iywbFbiUAA6ZD3@kroah.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Feb 2023 13:24:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=whhFCeeuo6vTEmNSx6S-KKkugxgzN_W5Z6v-9yH9gc3Zw@mail.gmail.com>
Message-ID: <CAHk-=whhFCeeuo6vTEmNSx6S-KKkugxgzN_W5Z6v-9yH9gc3Zw@mail.gmail.com>
Subject: Re: [GIT PULL] TTY/Serial driver updates for 6.3-rc1
To:     Greg KH <gregkh@linuxfoundation.org>,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>,
        Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Feb 24, 2023 at 4:51 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
>   - more 8250 device support added

Bah. I didn't notice this while merging, so it's in my tree now, but
that SERIAL_8250_PCI1XXXX shouldn't default to on.

The Kconfig file has

    config SERIAL_8250_PCI1XXXX
        tristate "Microchip 8250 based serial port"
        depends on SERIAL_8250 && PCI
        select SERIAL_8250_PCILIB
        default SERIAL_8250
        ...

and I don't think that "default" line should exist. It's not like this
is some super-common board that everybody should enable.

When I notice things in time, I tend to just fix this up in the merge
itself, but this time I had already done a couple of other of your
pulls before I noticed this thing.

            Linus
