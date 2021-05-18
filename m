Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D85C433ED
	for <linux-serial@archiver.kernel.org>; Tue, 18 May 2021 21:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8570761073
	for <linux-serial@archiver.kernel.org>; Tue, 18 May 2021 21:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352511AbhERVh6 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 18 May 2021 17:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352514AbhERVhz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 18 May 2021 17:37:55 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD575C061761;
        Tue, 18 May 2021 14:36:33 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id p6so5846664plr.11;
        Tue, 18 May 2021 14:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=icxAzkT3ZX9rQrnQsCaFNbpiN8Ie5NShLTTVXPLFhIA=;
        b=S8sjDYZclNoGkNBEz878gDknynOyrBDAfTJDJZDr+pXnCLVcDYedYpDJMaH+Ulfg4N
         EB3k3dVJRnxfXBnmKKczSSQzyZciDZie6UtLvvpZWSG4IxO/Im/DNuysj++WkqL6wACd
         0p9QbAUFn0IM5nJWpD9cJXbqBWo2pw2e4dtgaAIVPCHhxWGNvL+7MyGzvHX+2GxxyejM
         QshvyRiSgFrIWR+tSmrqnCdDlVGhIKQcwRfF3570XCiXip7pHy8tkXgRaYKhkjeP93eh
         alj0Wqc1AwiFgwLyAX9xQ/JiEHpipUuKolFyU3aHFLegt6FJtwaMfY+LVfYzk9mSNA6b
         xFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=icxAzkT3ZX9rQrnQsCaFNbpiN8Ie5NShLTTVXPLFhIA=;
        b=SRONIjnC9hfJ8BGdq/I7Fswb1/C84mfHBPLPYmDQQldjuAK65B+k1hDwYds8aWttxV
         x2WTAy51zcMZnOCHEuRahVdT0+vovlH8kxPWzAWX3dM+AvpJIpE30rKKtMA5aoRlqBUF
         KRaA72yvJOn0pcsPHBjoZ3P0cNI3y5iyB3WCj5lGqEdxXyDs/ob7HbSRcGIRu2w/01k/
         Caix6Ien3D+o4tijos4cURSnUTmhZkhZJLrzSQE8Y2iy5n/U3DafOgqj4jqE5u1f9So+
         GZnVhmEaDLo1Wskfqs7VS1mq+7Os4R+jVzcyagbtmeqUHuKcQi5+NwiCeho+IzoJeDBm
         dCxg==
X-Gm-Message-State: AOAM530It6Jy6NGM5fTZzRYmjanWprZbbsZYhpK4fyJiy6QHqQ4hbwH/
        Y1k7b/FjVjbMKDAQ0NZZd2RGNCrq2qYA5w==
X-Google-Smtp-Source: ABdhPJyMzKepZYOEpCyfslfA2Zow9uK63qbOcG8bxlxWjS/Wsc9Dz3uAyXmugL8crVO0F0XmdidDtw==
X-Received: by 2002:a17:902:65:b029:ef:abd6:477f with SMTP id 92-20020a1709020065b02900efabd6477fmr6759293pla.77.1621373793360;
        Tue, 18 May 2021 14:36:33 -0700 (PDT)
Received: from localhost (g1.222-224-229.ppp.wakwak.ne.jp. [222.224.229.1])
        by smtp.gmail.com with ESMTPSA id z13sm13589628pgc.60.2021.05.18.14.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 14:36:32 -0700 (PDT)
Date:   Wed, 19 May 2021 06:36:30 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Joel Stanley <joel@jms.id.au>
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
Subject: Re: [PATCH v2] serial: liteuart: Add support for earlycon
Message-ID: <YKQzXrReKqJxRQ6T@antec>
References: <20210517115453.24365-1-shorne@gmail.com>
 <CACPK8Xei8g4Bq5jGo0gHctFMny8U5dTLe9zHF_xBs_NFpRfejA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPK8Xei8g4Bq5jGo0gHctFMny8U5dTLe9zHF_xBs_NFpRfejA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, May 18, 2021 at 12:02:57PM +0000, Joel Stanley wrote:
> On Mon, 17 May 2021 at 11:55, Stafford Horne <shorne@gmail.com> wrote:
> >
> > Most litex boards using RISC-V soft cores us the sbi earlycon, however
> > this is not available for non RISC-V litex SoC's.  This patch enables
> > earlycon for liteuart which is available on all Litex SoC's making
> > support for earycon debugging more widely available.
> >
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
> > Cc: Florent Kermarrec <florent@enjoy-digital.fr>
> > Cc: Mateusz Holenko <mholenko@antmicro.com>
> > Cc: Joel Stanley <joel@jms.id.au>
> > Cc: Gabriel L. Somlo <gsomlo@gmail.com>
> > Reviewed-and-tested-by: Gabriel Somlo <gsomlo@gmail.com>
> 
> Reviewed-by: Joel Stanley <joel@jms.id.au>

Thanks for reviewing.

-Stafford
