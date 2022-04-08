Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A0AC433F5
	for <linux-serial@archiver.kernel.org>; Fri,  8 Apr 2022 13:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236227AbiDHNey (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 8 Apr 2022 09:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235714AbiDHNex (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 8 Apr 2022 09:34:53 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332281E8156
        for <linux-serial@vger.kernel.org>; Fri,  8 Apr 2022 06:32:50 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id l9-20020a05600c4f0900b0038ccd1b8642so6015156wmq.0
        for <linux-serial@vger.kernel.org>; Fri, 08 Apr 2022 06:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pDC9L0lcr1QHf8qfh13ooZQp7CHb5z3+opmiIbCpO5g=;
        b=jmrr9ES2B8XWO03NQZzQI4F2KKQwsDwVsKRsbWp63khlAKSkmi9C+eilQOfzSCKath
         b3no7GA5N4PEoy7SBC5oRO6EjCTlned/SX99tuyEsBpExUCpvQy48bLQ5u/Ei8+f7+70
         JjoSwIq3ChdypUMSjHJMZXtPDo6LBN4VWGLzEibGOseVKZTsmd8rOjKDQID9fcDLqQLJ
         NDZUZYPMPUPPbnyc0e1+Kc+f3IMnC7PXOXkmbrtOHF4HITAHh0MbxX93nNvzfRQLYfBj
         JRUU1LkEyrPi6gVeOgj1vX501pObHoK8SRG8vDH2evWMkgLQFKGNabXNKtnXXbfryVtb
         7B1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pDC9L0lcr1QHf8qfh13ooZQp7CHb5z3+opmiIbCpO5g=;
        b=xmi8yStDuatVQSAmAlbpOiYKvMoLcmvX9XSK0pzQfz5IABlPZkYQ848K8mx1jC9HGF
         WsrJgrBGvuXXBUjSlqfYGI0BJpNjPU8NgD63QQhr69V2pl88+XJIVn8e2QM4MjrFh37e
         bcnZGi2GlisZHMgNoAXPg9tF1GFwsy6Ncy7t93OlVVp99dmBbY5DzD6LTRiXQgDYu+Ah
         OssvGKSUvbm3lVg191rX80NpEMjejoPjQVjCn/f/byuR7asJ1XpXrbZoM1uMG67dTFB5
         EJJN9u8vdtuzQQ1Z5cwqg4gf7GPFNIdWPE2A2RveLk7ZolX0EltFXyejjDxGyy0ZJ9SF
         fHsA==
X-Gm-Message-State: AOAM532Ze8La+I0ToFO6Z0iTu/79vpGJRhKVfIcGaEjsazyuX2XYxs6w
        cPI4QwmDnOVw34+uUm8IoVB/pA==
X-Google-Smtp-Source: ABdhPJyeiw4bwAQfXU133L8POlyN9oSdy3Td0K/5lQO2DSbqQQ73iq/K4PM/64Hhgx/RD0NCcuI3hQ==
X-Received: by 2002:a05:600c:34c5:b0:38c:30e3:1e6c with SMTP id d5-20020a05600c34c500b0038c30e31e6cmr17255479wmq.144.1649424768622;
        Fri, 08 Apr 2022 06:32:48 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id v26-20020a1cf71a000000b0038ea373273bsm1707695wmh.47.2022.04.08.06.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 06:32:48 -0700 (PDT)
Date:   Fri, 8 Apr 2022 14:32:46 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        SoC Team <soc@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Doug Anderson <dianders@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Peter Zijlstra <peterz@infradead.org>,
        Mike Travis <mike.travis@hpe.com>
Subject: Re: [PATCH v3 1/1] soc: fujitsu: Add A64FX diagnostic interrupt
 driver
Message-ID: <20220408133246.fyw5554lgli4olvg@maple.lan>
References: <20220331092235.3000787-1-hasegawa-hitomi@fujitsu.com>
 <20220331092235.3000787-2-hasegawa-hitomi@fujitsu.com>
 <YkWVTEG5oFO82GPL@kroah.com>
 <CAK8P3a0jnzse4sG58taO5+Yd5vCgh1uddqbtAuim_z9r15Q3BA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0jnzse4sG58taO5+Yd5vCgh1uddqbtAuim_z9r15Q3BA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Mar 31, 2022 at 05:44:55PM +0200, Arnd Bergmann wrote:
> On Thu, Mar 31, 2022 at 1:49 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > +
> > > +static irqreturn_t a64fx_diag_handler(int irq, void *dev_id)
> > > +{
> > > +     handle_sysrq('c');
> >
> >
> > Why is this calling this sysrq call?  From an interrupt?  Why?
> >
> > And you are hard-coding "c", are you sure?
> 
> This is an actual sysrq driver in the traditional sense, where you can send
> a single interrupt to the machine from the outside over a side channel.
> 
> I suggested sysrq instead of just panic() to make it a bit more flexible.
> Unfortunately there is no additional data, so it comes down to always
> sending the same character.
> 
> It would be possible to make that character configurable with a module
> parameter or something like that, but I'm not sure that is an improvement.
> Maybe you have another idea for this.

Given the interrupt can be dismissed then offering non-fatal actions in
response the chassis command seems reasonable.

There is some prior art for this sort of feature. AFAICT SGI UV has a
similar mechanism that can send an NMI-with-no-side-channel to the
kernel. The corresponding driver offers a range of actions using a
module parameter:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/platform/uv/uv_nmi.c#n180

I don't think a hardcoded 'c' makes any sense. With a hardcoded argument
it is just obfuscation. However it is certainly seems attractive to be
able to reuse handle_sysrq() to provide a more powerful set of actions.


Daniel.
