Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A231AC6FD1C
	for <linux-serial@archiver.kernel.org>; Fri, 24 Mar 2023 10:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjCXKTg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 24 Mar 2023 06:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjCXKTg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 24 Mar 2023 06:19:36 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922301B314;
        Fri, 24 Mar 2023 03:19:30 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5447d217bc6so24536567b3.7;
        Fri, 24 Mar 2023 03:19:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679653169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u44WcnuqyHzepBxdvX3IGwCYzPtovczf29Qc9lcrlJ4=;
        b=fw526iE0CNqNV4kp+kSJqH+uo+F3c6T/kva32UUWRd+dopsM0AVl47/79oPCs7JwLt
         3hzZnXLuoYD/pd0z2RwXrmjYweRwfuPh4OyC2IQbGuPeUnEtXEMPuR+IEV9TCvh1UkfP
         6MuTgJlIXSWvhnaBUUBsJ2iLthCekrQ4/IK1HFqy6jmlGf9RqMKhi9GoLD9I7z+tsMwZ
         mz8s+FL5NEY7Jbwyw3TRJdX3DCWuPr0fv60zy2B7sQRHTqfxu96OSabEUP1FpR0uUqLA
         qGXZgR36prjUwrL+ot1LOG+OhMVTdvjb02nZcwXIHTaf/DYPRDZY7jwhkRjdfcaQOs3E
         Oeuw==
X-Gm-Message-State: AAQBX9f0DIk3S+1Sb6N6+GLXu5AFlHw3NB6rYDvmxojLZOFkCsumgMrG
        0K/PaJoUN3BV8ECwJXQazkipPPTzv9vmSA==
X-Google-Smtp-Source: AKy350YPLkhoCEI4WdRzzxsKVRIEx3jDox3QVhFQaSt9OYsIKVmXzXA6FiB+1Enjp1KvF0+//Busvw==
X-Received: by 2002:a81:52cf:0:b0:545:21f2:7bb5 with SMTP id g198-20020a8152cf000000b0054521f27bb5mr1729783ywb.35.1679653169610;
        Fri, 24 Mar 2023 03:19:29 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id 206-20020a810fd7000000b00545a0818487sm332114ywp.23.2023.03.24.03.19.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 03:19:28 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id r187so1508819ybr.6;
        Fri, 24 Mar 2023 03:19:28 -0700 (PDT)
X-Received: by 2002:a25:2749:0:b0:a99:de9d:d504 with SMTP id
 n70-20020a252749000000b00a99de9dd504mr1012626ybn.12.1679653167954; Fri, 24
 Mar 2023 03:19:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230324100222.116666-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230324100222.116666-1-biju.das.jz@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 24 Mar 2023 11:19:15 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVD-545UeLZcBKc3OKSyO0=+YSBwN=invZVAvGjhmH58w@mail.gmail.com>
Message-ID: <CAMuHMdVD-545UeLZcBKc3OKSyO0=+YSBwN=invZVAvGjhmH58w@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Add RZ/G2L SCIFA DMAC support
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

Hi Biju,

Thanks for your series!

On Fri, Mar 24, 2023 at 11:05 AM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> This patch series aims to add DMA support for SCIFA IP found on
> RZ/G2L alike SoCs.
>
> v1->v2:
>  * Added support for DMA tx and rx.

All individual patches say "no changes from v1->v2"?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
