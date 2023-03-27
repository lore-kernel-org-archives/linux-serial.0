Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9281C761A6
	for <linux-serial@archiver.kernel.org>; Mon, 27 Mar 2023 09:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbjC0Jti convert rfc822-to-8bit (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 27 Mar 2023 05:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbjC0Jtd (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 27 Mar 2023 05:49:33 -0400
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA4C4C15;
        Mon, 27 Mar 2023 02:49:21 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-544787916d9so158785377b3.13;
        Mon, 27 Mar 2023 02:49:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679910560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OIUcewTtZhKhGPfN3Y/89VYWw8yL2wWAKrkVuJWSYSA=;
        b=5e2GVEpkwCtrlFM/zy2q5BGgAWbWAjd92JVYecgOjUxMFUgPQDZHaqqkx7eLJPPfUd
         8v7TXue5hTafPd0/C7gIHNRXtMb1Ct5++1nFDfYCIV3ftBPp8gbfETuv2Otn5lOYueT+
         Hf/ql8Tj6a4giP2EBP4WpSnZg5SDOcLgm97I78pPhmLV0iMp6Px5o0T5l9RbxM7YZ5XQ
         DBTFOePGzCqpw/+VIacvniaT3ggei7AS9VuqX+kfuqvzu1/BWp1Swgjp95HAZ5FRGuAu
         Qux15R9teglzHDA2yjyFzQ5yaj0DPDV7dwmP2k6CasXuhTm4MdAYV21DGn8sM0DMq2ma
         nrBQ==
X-Gm-Message-State: AAQBX9d9KTfApK9Brm3605dPIJcBqij5vJaysAQleslRx5uZy/X4typY
        iYhXqJ/toAWAMxXyMRRA3BmmbGEmvI4IEA==
X-Google-Smtp-Source: AKy350YBRpn1vM/MqHjbxQQ4bsy/A93kybcNKCpjBkpfxXaxRuiMoim4Nej3eDA3VDldm014iDHkng==
X-Received: by 2002:a81:5a83:0:b0:544:7850:b62f with SMTP id o125-20020a815a83000000b005447850b62fmr10782131ywb.18.1679910560556;
        Mon, 27 Mar 2023 02:49:20 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id c1-20020a811c01000000b00545a081848fsm1884888ywc.31.2023.03.27.02.49.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 02:49:20 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-536af432ee5so160250847b3.0;
        Mon, 27 Mar 2023 02:49:19 -0700 (PDT)
X-Received: by 2002:a81:b65f:0:b0:544:8bc1:a179 with SMTP id
 h31-20020a81b65f000000b005448bc1a179mr5122130ywk.4.1679910559684; Mon, 27 Mar
 2023 02:49:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230324100222.116666-1-biju.das.jz@bp.renesas.com> <20230324100222.116666-2-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230324100222.116666-2-biju.das.jz@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 27 Mar 2023 11:49:08 +0200
X-Gmail-Original-Message-ID: <CAMuHMdULJcDryguGd-Y1fxkq2mrTQEkeEnrf_+yVhGU1SDUp0Q@mail.gmail.com>
Message-ID: <CAMuHMdULJcDryguGd-Y1fxkq2mrTQEkeEnrf_+yVhGU1SDUp0Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] tty: serial: sh-sci: Remove setting
 {src,dst}_{addr,addr_width} based on DMA direction
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Mar 24, 2023 at 11:02 AM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> The direction field in the DMA config is deprecated. The sh-sci driver
> sets {src,dst}_{addr,addr_width} based on the DMA direction and
> it results in dmaengine_slave_config() failure as RZ DMAC driver
> validates {src,dst}_addr_width values independent of DMA direction.
>
> Fix this issue by passing both {src,dst}_{addr,addr_width}
> values independent of DMA direction.
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
