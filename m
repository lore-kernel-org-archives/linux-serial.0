Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E98C4332F
	for <linux-serial@archiver.kernel.org>; Mon, 21 Nov 2022 09:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbiKUJ5R convert rfc822-to-8bit (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 21 Nov 2022 04:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbiKUJ5M (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 21 Nov 2022 04:57:12 -0500
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB5393;
        Mon, 21 Nov 2022 01:57:11 -0800 (PST)
Received: by mail-qt1-f175.google.com with SMTP id l2so6907454qtq.11;
        Mon, 21 Nov 2022 01:57:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bajdHYdVWPN35JSI3uh58zSxMZgupl/Y01sde+6nnAM=;
        b=u4uZydQYNl0VDhJ3M+B0C99tKvsIqcquhOu4NEpuOw8k9vbC2VXzKNWzi9oaL4/VuA
         CVREGrCwnPlLKecZHO39b/SMax4kvRihq629fC4QTI0J2gdlU8LcnTp6C91E9c+9ZSqF
         dMCAJOMaIXQmJawAeOuG2b9LsW48tBQcBtVcnVCKbJOCDquF5L8nQmit0bOBFuMGkzdV
         5hovoGYljoPSB/tSxm01SMlshqsnMjMeZ95rjIteD+l/0QtuGqkLnHXxBKt1noNMp2Mn
         pm2L3kGqbZrZi3tJGGv29GKKkmVkAzRnBDGLnDCelnVaHr9uOZ7zpwXcwvihS4us/q/w
         S+MA==
X-Gm-Message-State: ANoB5pkD6cVccCygRtZ75f+7kXXodJh+j92R/NOHhMYtXjnmaJBQt/i7
        o21wcZMr/FoPqxgyK52AAR6m1BctphwwCw==
X-Google-Smtp-Source: AA0mqf7rDf+Nq8vdMwakt2kYy5ArHCLGLe1p5sQwI99G+1iIve50bA1pRmw0qUBTBoyTYoR608aycQ==
X-Received: by 2002:ac8:7f83:0:b0:3a5:1fa1:f2 with SMTP id z3-20020ac87f83000000b003a51fa100f2mr2059879qtj.91.1669024630463;
        Mon, 21 Nov 2022 01:57:10 -0800 (PST)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id v9-20020ac873c9000000b003a54a19c550sm6396180qtp.57.2022.11.21.01.57.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 01:57:09 -0800 (PST)
Received: by mail-yb1-f173.google.com with SMTP id f201so12947963yba.12;
        Mon, 21 Nov 2022 01:57:09 -0800 (PST)
X-Received: by 2002:a25:9e84:0:b0:6de:6183:c5c3 with SMTP id
 p4-20020a259e84000000b006de6183c5c3mr1445076ybq.89.1669024628902; Mon, 21 Nov
 2022 01:57:08 -0800 (PST)
MIME-Version: 1.0
References: <20221118145512.509950-1-gsomlo@gmail.com> <20221118145512.509950-9-gsomlo@gmail.com>
In-Reply-To: <20221118145512.509950-9-gsomlo@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 21 Nov 2022 10:56:57 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUszhxJF8gU-A=rRET9PsdiaqOS-rDrkbxjpQK7p5mk8A@mail.gmail.com>
Message-ID: <CAMuHMdUszhxJF8gU-A=rRET9PsdiaqOS-rDrkbxjpQK7p5mk8A@mail.gmail.com>
Subject: Re: [PATCH v5 08/14] serial: liteuart: simplify passing of
 uart_insert_char() flag
To:     Gabriel Somlo <gsomlo@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        kgugala@antmicro.com, mholenko@antmicro.com, joel@jms.id.au,
        david.abdurachmanov@gmail.com, florent@enjoy-digital.fr,
        ilpo.jarvinen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Nov 18, 2022 at 3:56 PM Gabriel Somlo <gsomlo@gmail.com> wrote:
> Simply provide the hard-coded TTY_NORMAL flag to uart_insert_char()
> directly -- no need to dedicate a variable for that exclusive purpose.
>
> Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
