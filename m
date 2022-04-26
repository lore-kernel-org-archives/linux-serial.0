Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCE5C433F5
	for <linux-serial@archiver.kernel.org>; Tue, 26 Apr 2022 14:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351581AbiDZO03 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 26 Apr 2022 10:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351590AbiDZO02 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 26 Apr 2022 10:26:28 -0400
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CA847AFC;
        Tue, 26 Apr 2022 07:23:18 -0700 (PDT)
Received: by mail-qk1-f178.google.com with SMTP id z126so1619945qkb.2;
        Tue, 26 Apr 2022 07:23:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jokkVbF1ezms1mHbakQHJk8L69eckMvAJzizq9MqELw=;
        b=35nNsdDobxbALX628NAUMsIp7RoCyoNKj4UtgxC1eKaOe2R4efVqTq1Um/QGzagKFA
         C/UX+0/h0oJn3sYBlkC4u7hz7fDwTPtVDDJbp9HJH6rSwsvaTV0oZv4rQUsp/rVe9tba
         VtDNpgzCc+/qkgekbdq0LkI+rHZA6QnvJgRd1Y1vERKzon1zVE7IRrrp1tK6WjoHA+XX
         tFVsVjSAJg658I/lNfk3vohZ1LZXEe/KrvPScNrzcz8yjO0egWmLX/LiKDUC2j2cmnqT
         whr7PL1kpnPxTs+/cQbfqFly6rAFiKxJER3Okb0BzzfPKVFhf4OJlLpffA18W6wu2R3f
         eKyw==
X-Gm-Message-State: AOAM532Ctio59lY727wgZbwpXLNr0sv9RWalEbdoJDUeJSGXNqed8wX7
        mt8M3W2v+bL4x69GmTe5dEtS8HFK56/w3A==
X-Google-Smtp-Source: ABdhPJzeUKDHWAuE68MMJzTkbC6tHbtbc/HrCYthvHRReslckiez9cDwhG6r5EPv+nCTW3ZHMUR9Kg==
X-Received: by 2002:a37:54c4:0:b0:67e:9cbf:a984 with SMTP id i187-20020a3754c4000000b0067e9cbfa984mr13652836qkb.215.1650982996950;
        Tue, 26 Apr 2022 07:23:16 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id n22-20020ac85b56000000b002f1d7a2867dsm7986808qtw.67.2022.04.26.07.23.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 07:23:16 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-2f7c57ee6feso89258387b3.2;
        Tue, 26 Apr 2022 07:23:16 -0700 (PDT)
X-Received: by 2002:a81:c703:0:b0:2d0:cc6b:3092 with SMTP id
 m3-20020a81c703000000b002d0cc6b3092mr21856171ywi.449.1650982996110; Tue, 26
 Apr 2022 07:23:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220330154024.112270-1-phil.edworthy@renesas.com> <20220330154024.112270-6-phil.edworthy@renesas.com>
In-Reply-To: <20220330154024.112270-6-phil.edworthy@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 26 Apr 2022 16:23:05 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX=ugyPDLGBcYXhXFOSJRKC90MCS4DsxYo6rzsWMCr5sg@mail.gmail.com>
Message-ID: <CAMuHMdX=ugyPDLGBcYXhXFOSJRKC90MCS4DsxYo6rzsWMCr5sg@mail.gmail.com>
Subject: Re: [PATCH v2 05/13] serial: 8250: Make SERIAL_8250_EM available for
 arm64 systems
To:     Phil Edworthy <phil.edworthy@renesas.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Al Cooper <alcooperx@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Mar 30, 2022 at 5:41 PM Phil Edworthy <phil.edworthy@renesas.com> wrote:
> This is needed for the Renesas RZ/V2M (r9a09g011) SoC.
>
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
