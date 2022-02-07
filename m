Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15257C35296
	for <linux-serial@archiver.kernel.org>; Mon,  7 Feb 2022 13:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235279AbiBGNwD (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 7 Feb 2022 08:52:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449341AbiBGNZl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 7 Feb 2022 08:25:41 -0500
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C891BC043181;
        Mon,  7 Feb 2022 05:25:39 -0800 (PST)
Received: by mail-ua1-f54.google.com with SMTP id w18so19414123uar.8;
        Mon, 07 Feb 2022 05:25:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wd3WPkRmWQkvJcLllFtReOXpDqEuuoBl0LhJt/0llQU=;
        b=Rsae0927/6vFkqsu8jqH837/6nd3zD0mhiIYjNfhwrDSSN6ix0vAPoLyM9kadm+7yl
         m+R88G9wjRtA9XSBLFp+ZWJ1LIl1K9uvUPy36sEC1CPdmaywFUGZ/VzwnCepj+A83Cgx
         np/N3DJ5EAe6qS11RCVAINVkp3FESxG4fBYMOMzlyCC5ZM3Oj0+GPa7u7GYDBu1vALDx
         +nbnVmWes8WylVy696pBAIJREgkq60lr0xTJJo/YxBDKUrowQ0p2tELksdMMs5p7eTkY
         pruIj3OxSb9xNc+E7+tVter8wF29hHfuxpShGB1sVsvuFKuWwowqNRht4FJo3SbdIczg
         4ymA==
X-Gm-Message-State: AOAM533Ngg5G73l+DOXt67+9SUpbHOgFqhYGN9R3Famym12g3AklJeCE
        BhqqP74Efz0HqwQI6MHKbccKX1rGgF+1DA==
X-Google-Smtp-Source: ABdhPJyRWNFVY779latvad8uC2fI9gA/e8HlbopuAFYZWXCktk1GOG0zHKYlAnDeJXTBcDwJsuVfBA==
X-Received: by 2002:ab0:6851:: with SMTP id a17mr507703uas.97.1644240338922;
        Mon, 07 Feb 2022 05:25:38 -0800 (PST)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com. [209.85.221.171])
        by smtp.gmail.com with ESMTPSA id y12sm2496968uai.11.2022.02.07.05.25.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 05:25:38 -0800 (PST)
Received: by mail-vk1-f171.google.com with SMTP id u25so7775615vkk.3;
        Mon, 07 Feb 2022 05:25:38 -0800 (PST)
X-Received: by 2002:a05:6122:c8f:: with SMTP id ba15mr5085345vkb.39.1644240338388;
 Mon, 07 Feb 2022 05:25:38 -0800 (PST)
MIME-Version: 1.0
References: <20220206184749.11532-1-biju.das.jz@bp.renesas.com> <20220206184749.11532-3-biju.das.jz@bp.renesas.com>
In-Reply-To: <20220206184749.11532-3-biju.das.jz@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 7 Feb 2022 14:25:27 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUGS9fzJo8D-g8NC-A6ST3-eh=DDa_sdLHnwiUBeRa8Qw@mail.gmail.com>
Message-ID: <CAMuHMdUGS9fzJo8D-g8NC-A6ST3-eh=DDa_sdLHnwiUBeRa8Qw@mail.gmail.com>
Subject: Re: [PATCH 3/3] dt-bindings: serial: renesas,sci: Document RZ/G2UL SoC
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, Feb 6, 2022 at 7:48 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> Add SCI binding documentation for Renesas RZ/G2UL SoC. No driver changes
> are required as generic compatible string "renesas,sci" will be used as
> a fallback.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
