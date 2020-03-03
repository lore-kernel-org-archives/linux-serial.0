Return-Path: <SRS0=YTEb=4U=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B56C3F2C6
	for <linux-serial@archiver.kernel.org>; Tue,  3 Mar 2020 15:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 138412073D
	for <linux-serial@archiver.kernel.org>; Tue,  3 Mar 2020 15:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbgCCPKT (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 3 Mar 2020 10:10:19 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42300 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbgCCPKT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 3 Mar 2020 10:10:19 -0500
Received: by mail-ot1-f67.google.com with SMTP id 66so3286730otd.9;
        Tue, 03 Mar 2020 07:10:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Kca1ycYP9hx1ciCp/Eg/F25DgiVO44FVhWaPbRYxPU=;
        b=MGpH+b4/qMf16bHmH1A7gs4FaOxMcOAXopZcSwgNVyKZdFZZKgb+Il9qKBgVEyEC5U
         QOKGWt92CVWJdaIlvpXrJyCFUnko5Zf81xtR2tAIWbATUH6KaWc0PiaTosyolcifuh6i
         uy8zY7WH7azasEGYg0hDlUQE+jrLZ76hUanU3I6BIaDFz7Kv/6fTwDPjj8XJEK5lt1iA
         KyVVvqE/STuYR2sg3O5kDrBLOHmJ+TaGxuZHYhEU2p/6gcpBBYzaU16x9wjJJgzPGS0i
         lQq2ZkBHhgjb3NmHu6RB3PKtcsD/NaulwV/eUJA7+G1Klb186+xWK0VkgnIL/8AkB5QV
         Zyzg==
X-Gm-Message-State: ANhLgQ2w/a0jt9NPBXYGmRQXnfuLvmaIu5rigOx6Cl8tDc+THcu2yht+
        bGiGQGcnzMSfFfdMxcr3mZvI+cpzDy4oNRr1eDw=
X-Google-Smtp-Source: ADFU+vsjLmSFCjHTsjuoqrUuFQxZRfHMpmUpBKx5AXsN6z/FTWlqxSa34xUOvoolY68R52SGPfoHlQRIAKInM1tjicU=
X-Received: by 2002:a9d:5c0c:: with SMTP id o12mr3707646otk.145.1583248218506;
 Tue, 03 Mar 2020 07:10:18 -0800 (PST)
MIME-Version: 1.0
References: <20200303134351.22270-1-geert+renesas@glider.be> <20200303134351.22270-3-geert+renesas@glider.be>
In-Reply-To: <20200303134351.22270-3-geert+renesas@glider.be>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 3 Mar 2020 16:10:07 +0100
Message-ID: <CAMuHMdXzyp1KCzztbifFgg5N6diHKFnMUihbu_cVOFkTzyf9Yg@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: serial: Convert slave-device bindings to json-schema
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Mar 3, 2020 at 2:43 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> Convert the serial slave-device Device Tree binding documentation to
> json-schema, and incorporate it into the generic serial bindings.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  .../devicetree/bindings/serial/serial.yaml    | 53 +++++++++++++++++++
>  .../bindings/serial/slave-device.txt          | 45 ----------------
>  MAINTAINERS                                   |  2 +-
>  3 files changed, 54 insertions(+), 46 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/serial/slave-device.txt

There are a few references to slave-device.txt that need to be updated.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
