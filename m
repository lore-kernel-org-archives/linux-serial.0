Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D76DC433B4
	for <linux-serial@archiver.kernel.org>; Tue, 18 May 2021 12:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A9AE610CD
	for <linux-serial@archiver.kernel.org>; Tue, 18 May 2021 12:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242576AbhERME2 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 18 May 2021 08:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240508AbhERME2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 18 May 2021 08:04:28 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D29AC061573;
        Tue, 18 May 2021 05:03:10 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id h21so7193962qtu.5;
        Tue, 18 May 2021 05:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dgRjgMF0jpsraJsvUZJyoQ74gDZ410mdS1Ik8FUl2pc=;
        b=Ov+dRmqVOvfiYBO+R0s8Tr2ERLhRBuYwIKSjFCVmnY/blbI7kWi7p4/RPYIkLyOQMb
         U4fD4gnn8kT3TjEo4tc2x/0QHfA/3XhwDVmiAWlD5TR/FroWT5vQZa8fkw6lw90Ztkid
         bqCEpNoe7ruFwuHyLzAvAVyPD+WFeqX5aXLtI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dgRjgMF0jpsraJsvUZJyoQ74gDZ410mdS1Ik8FUl2pc=;
        b=iTTz2EtNyqyorIp/21sxCw6W38RO5skScmRv/I6VEGV40PnHK+8c0f/H21nwwZgqHa
         NL/DNlNkmvR8NBUs2YLTDA76kqAnc34urBEX5GeTJbY1UEoukNvlpNKoLeQY7iJVx+1I
         9sFqz8q3DjIbTo0l9e1Ba0hekyY0BzZ6aabnEg4vIvzDv2FttrgbH8wQqWzsVKfg/IIO
         WZ5gk7IbDuF4wI2erCDo8PGezmtBoyZrzbGX5+yAv+B6v6Y8O6V770dmAkqKoTCOOtOp
         tGGsEHDHjA8Luvz72RcP1q5Q7WOXMqQjWaGdEyS8jiET9hvtN7y3T/Y7fWgGiiWb6xiY
         IwBA==
X-Gm-Message-State: AOAM5325SXyrOJQX4a4smaRp16GJU9eErdRRg5aeXBsZMq22F+BKZqsM
        I7abYZVuZPGGgzXyb0gnqbYS4yD61UGVafS6xSQ=
X-Google-Smtp-Source: ABdhPJyobAJKZGC8ZGdMH4a907xXw5PK/xCf/KDb+klYPSUEqJ06d4loYKbP3ckdn3yy0TREmonQMnfo4BUD0e3dEKs=
X-Received: by 2002:ac8:5e51:: with SMTP id i17mr4417331qtx.263.1621339389452;
 Tue, 18 May 2021 05:03:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210517115453.24365-1-shorne@gmail.com>
In-Reply-To: <20210517115453.24365-1-shorne@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 18 May 2021 12:02:57 +0000
Message-ID: <CACPK8Xei8g4Bq5jGo0gHctFMny8U5dTLe9zHF_xBs_NFpRfejA@mail.gmail.com>
Subject: Re: [PATCH v2] serial: liteuart: Add support for earlycon
To:     Stafford Horne <shorne@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Florent Kermarrec <florent@enjoy-digital.fr>,
        Mateusz Holenko <mholenko@antmicro.com>,
        "Gabriel L . Somlo" <gsomlo@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Karol Gugala <kgugala@antmicro.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-doc@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, 17 May 2021 at 11:55, Stafford Horne <shorne@gmail.com> wrote:
>
> Most litex boards using RISC-V soft cores us the sbi earlycon, however
> this is not available for non RISC-V litex SoC's.  This patch enables
> earlycon for liteuart which is available on all Litex SoC's making
> support for earycon debugging more widely available.
>
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> Cc: Florent Kermarrec <florent@enjoy-digital.fr>
> Cc: Mateusz Holenko <mholenko@antmicro.com>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Gabriel L. Somlo <gsomlo@gmail.com>
> Reviewed-and-tested-by: Gabriel Somlo <gsomlo@gmail.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

Cheers,

Joel
