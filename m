Return-Path: <SRS0=JuT/=6L=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42458C54FD0
	for <linux-serial@archiver.kernel.org>; Mon, 27 Apr 2020 13:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3F73206B6
	for <linux-serial@archiver.kernel.org>; Mon, 27 Apr 2020 13:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XvQ7Y9+h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgD0Nkn (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 27 Apr 2020 09:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgD0Nkn (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 27 Apr 2020 09:40:43 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0899CC0610D5
        for <linux-serial@vger.kernel.org>; Mon, 27 Apr 2020 06:40:42 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id t14so20569903wrw.12
        for <linux-serial@vger.kernel.org>; Mon, 27 Apr 2020 06:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+SvAEnjQGoKRVavmP97K2vdMEb3EEIWTHohY4rQOeno=;
        b=XvQ7Y9+hzU5EcfSQ86a6hv1PtqRh31M16VH/0xSAl6+mg4VcTWdI6ztirNiiq99XDR
         fT1BYBCDOFu8V8lTkW8P4YOZ8+RNhxPNDgCw7xQgRWeAXBnWWprsLFTIbPnslLv34xia
         LiSH/pEG//lcwOInyXULQDISTZEmyHdkTlSC1C3nHUpRAeWQaOFO30SbTtDvawGBlf4h
         nz3IPr3vkEFhAlImlaxwqh/zYO8X2i9Jla84ye4f1rC+KQpT7ausyxtw87dLM0Ehvmaq
         /yQm0VVw2UKpaO3xQc2pgJY7MQvjHpSXCL1zcHEC06ZZ13DBV9jfyiYANAJ7UmVAob7w
         U3HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+SvAEnjQGoKRVavmP97K2vdMEb3EEIWTHohY4rQOeno=;
        b=MPblPj+HpLeSMeUCIqie4ZeBNskUnvCbsB0hA0i0kevm8saFQPDnH8PMtvmvgtAdyo
         cTn81IsKOB1oEbiUMbRW1VUCxnIHtJlJEUFBuhq3pzH1Lf5nZ79GntRWHfhHA0XuUsHf
         Yko+3lJ47ymT/IyqnFOaaQmGh67y57QSGFQOycmSG1TzEfAEfJycqxQSefdWUgB4UgVa
         QonBEMxuKfwVGkSV+0yDzuBwoLYJzkGfhhzLp4gfhcLrX2VwseOY/5cjmNG/dgieTt14
         sMsZYJASwiNFBeUOq0XnhfUm3cnVgOsp9Cnq5VF98wM9UR6z8S4dfJKVIXkP9qNWa2OJ
         y6fw==
X-Gm-Message-State: AGi0PuZzx76z2d/ulZ2vSGC4KbLiNjRsJKOL/4EpECOSPjN6vJIiRnan
        grLG3fQpVkTsvWw461Xw9no/YQ==
X-Google-Smtp-Source: APiQypKLt4Y3AQbKJxyRs7ev6STdRbv1Vx2RggZUFm2SboBwevpwPw7zspoBeZRz/dvMXUz+5GsOfQ==
X-Received: by 2002:a5d:5081:: with SMTP id a1mr29784146wrt.81.1587994841629;
        Mon, 27 Apr 2020 06:40:41 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id h137sm88954wme.0.2020.04.27.06.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 06:40:40 -0700 (PDT)
Date:   Mon, 27 Apr 2020 14:40:39 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     jason.wessel@windriver.com, gregkh@linuxfoundation.org,
        kgdb-bugreport@lists.sourceforge.net, mingo@redhat.com,
        hpa@zytor.com, bp@alien8.de, linux-serial@vger.kernel.org,
        agross@kernel.org, tglx@linutronix.de, frowand.list@gmail.com,
        bjorn.andersson@linaro.org, jslaby@suse.com,
        catalin.marinas@arm.com, corbet@lwn.net, will@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/9] kgdb: Disable WARN_CONSOLE_UNLOCKED for all kgdb
Message-ID: <20200427134039.vog2eloyad55cww5@holly.lan>
References: <20200421211447.193860-1-dianders@chromium.org>
 <20200421141234.v2.1.Ied2b058357152ebcc8bf68edd6f20a11d98d7d4e@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421141234.v2.1.Ied2b058357152ebcc8bf68edd6f20a11d98d7d4e@changeid>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Apr 21, 2020 at 02:14:39PM -0700, Douglas Anderson wrote:
> In commit 81eaadcae81b ("kgdboc: disable the console lock when in
> kgdb") we avoided the WARN_CONSOLE_UNLOCKED() yell when we were in
> kgdboc.  That still works fine, but it turns out that we get a similar
> yell when using other I/O drivers.  One example is the "I/O driver"
> for the kgdb test suite (kgdbts).  When I enabled that I again got the
> same yells.
> 
> Even though "kgdbts" doesn't actually interact with the user over the
> console, using it still causes kgdb to print to the consoles.  That
> trips the same warning:
>   con_is_visible+0x60/0x68
>   con_scroll+0x110/0x1b8
>   lf+0x4c/0xc8
>   vt_console_print+0x1b8/0x348
>   vkdb_printf+0x320/0x89c
>   kdb_printf+0x68/0x90
>   kdb_main_loop+0x190/0x860
>   kdb_stub+0x2cc/0x3ec
>   kgdb_cpu_enter+0x268/0x744
>   kgdb_handle_exception+0x1a4/0x200
>   kgdb_compiled_brk_fn+0x34/0x44
>   brk_handler+0x7c/0xb8
>   do_debug_exception+0x1b4/0x228
> 
> Let's increment/decrement the "ignore_console_lock_warning" variable
> all the time when we enter the debugger.
> 
> This will allow us to later revert commit 81eaadcae81b ("kgdboc:
> disable the console lock when in kgdb").
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
