Return-Path: <SRS0=YTEb=4U=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7D1C3F2D7
	for <linux-serial@archiver.kernel.org>; Tue,  3 Mar 2020 15:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E37F820842
	for <linux-serial@archiver.kernel.org>; Tue,  3 Mar 2020 15:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729800AbgCCPJk (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 3 Mar 2020 10:09:40 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42705 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729605AbgCCPJk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 3 Mar 2020 10:09:40 -0500
Received: by mail-oi1-f193.google.com with SMTP id l12so3301826oil.9;
        Tue, 03 Mar 2020 07:09:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zclMu55pOEbtJ5KEkFvG4eYtDTAQiBFtjRyibvrv2jA=;
        b=FeUQKiA9yVZ+yF/F65raOKbarvNcQPl2RJ3tKGJBQXNEYDUMWngvlbulpZIOFULexx
         /HDIsnDLHyZRERCUeIkkrFzagQyW5hw7/pRGqADRv/EojCmKldrvImEwdBT/z+x9m7XM
         w2sQ1GpcfmRQWJApag/fPiBWVV1qgR9CdKhku23mVjYtVrQ0CwMbmQGcwvp2mxkJ8b09
         zUN7wD4XCXINg6PYhcxirQynL/rTfFzzbLHc019q+ISt5Er4PCh5X9kbguC/viP/uiXF
         1PQ6oLRB1g2DO4MZ66YzltqrT6ahrvcUgH8by9Zko9GyiiDXy6GwaR84DhWex7HlsU8L
         ig2Q==
X-Gm-Message-State: ANhLgQ02OMt5Bm6wY/Jz6Und+p547fcZ6rCKjgBFpyizmHFBXBbXgaaW
        OtlgcBlRBR4PG7N+4cggfaDMwZ1HNap2PGJ4Lmo=
X-Google-Smtp-Source: ADFU+vvF5cyBy3Mj/JGSTRJ4KUYjVjpIJvvzrSNL5lKharapSjyQoSa/pwNf3BU5ywQoBS5GNl8MzNZoUy2WptJa1IA=
X-Received: by 2002:aca:b4c3:: with SMTP id d186mr2672596oif.131.1583248179287;
 Tue, 03 Mar 2020 07:09:39 -0800 (PST)
MIME-Version: 1.0
References: <20200303134351.22270-1-geert+renesas@glider.be> <20200303134351.22270-2-geert+renesas@glider.be>
In-Reply-To: <20200303134351.22270-2-geert+renesas@glider.be>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 3 Mar 2020 16:09:28 +0100
Message-ID: <CAMuHMdWFDLEnwm7cMMLF6a_vc8U24aGEh3hO33gA=TFgBDGoCA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: serial: Convert generic bindings to json-schema
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Mar 3, 2020 at 2:44 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> Convert the generic serial interface Device Tree binding documentation
> to json-schema.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  .../devicetree/bindings/serial/serial.txt     | 56 -----------
>  .../devicetree/bindings/serial/serial.yaml    | 95 +++++++++++++++++++
>  2 files changed, 95 insertions(+), 56 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/serial/serial.txt
>  create mode 100644 Documentation/devicetree/bindings/serial/serial.yaml

There are a few references to serial.txt that need to be updated.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
