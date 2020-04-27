Return-Path: <SRS0=JuT/=6L=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0D5C55199
	for <linux-serial@archiver.kernel.org>; Mon, 27 Apr 2020 16:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 082402087E
	for <linux-serial@archiver.kernel.org>; Mon, 27 Apr 2020 16:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qX0Zz/fn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbgD0Qw7 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 27 Apr 2020 12:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbgD0Qw7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 27 Apr 2020 12:52:59 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2DCC03C1A7
        for <linux-serial@vger.kernel.org>; Mon, 27 Apr 2020 09:52:59 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id u16so385491wmc.5
        for <linux-serial@vger.kernel.org>; Mon, 27 Apr 2020 09:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L+f5rXb1fm0ddPawdaHU5SqIUExIWo7ZaWY7+7ST/oQ=;
        b=qX0Zz/fnIDcCTmTrZNOvEAVu0G15kUG2va77BGRxQ+BmnBFWZsRrnaLHz5AJeDtNzy
         im1UlPKai40zbHFsTmlFjs0ZlJ8dSJxK5mwzZ+nAIEwEmIgCwcYm7RTGYxfXNXUnv7iT
         GvITdFyEQESb0fEeHG9nVNlC93iR5CJnTVdL0pJBSMI/cuHkO/7l0VAJaTkmAeFHzYYM
         zph00Gm2PW/XDw3Tg+sdx8+1m/6xFtHAP1MWzfbVvhm2Xbiz/TC41CE+rwGou+JPnFT8
         pd5dUPNqNOceRTLdcITOTJqqCb8zhCttUIrobwkSJqKbvweOrdCnityaPhTQz1J5bPDo
         cz+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L+f5rXb1fm0ddPawdaHU5SqIUExIWo7ZaWY7+7ST/oQ=;
        b=enSQBLTCnRt3jNrFX/k1XWTABFs5j98LF2kIPtynu9wGh/gq4x1MV+vSrWGyauNaX+
         0ZR8QOENVbTRc/oi33RwmZvGvjnudskHtfNvDUGPliF8aaRk1AIQQ1Ps+fNUAOl7xQmE
         YrfbvDei3nmO3XE9oxd3KEf8T+VXXkDGf3heF9mgWsuBBUhWTXRZCtIL4dSATqOqKcan
         MMEDbz0FZxyT14isY6WVina8uh70toLhYwS8XZVjPqxGvHLVV5ab8KuFBj3NEPeZ2UtA
         XKwMTW0AnDXQRIw9q1X5/6ZBjrW9EjUOTCd3IwaB7ck63FENpx60xIhrLWiTzrdmQh7L
         e0MQ==
X-Gm-Message-State: AGi0PuYcSzOR3tmpOiZ71eJtlw4mzqj4WszPAtPLYCQ2UKDED1sYbQ8c
        gL6wKrwEad5rqQ9SL9fAi7Lklg==
X-Google-Smtp-Source: APiQypIg33MdzG1fsD4Vtx7fCSqJxX2k4oqiO4ZdOMqbRC/BCATKrNwRWvi691/BgqaV0F5UCCKSag==
X-Received: by 2002:a7b:c927:: with SMTP id h7mr417005wml.122.1588006377727;
        Mon, 27 Apr 2020 09:52:57 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id v16sm16085225wml.30.2020.04.27.09.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 09:52:57 -0700 (PDT)
Date:   Mon, 27 Apr 2020 17:52:55 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     jason.wessel@windriver.com, gregkh@linuxfoundation.org,
        kgdb-bugreport@lists.sourceforge.net, mingo@redhat.com,
        hpa@zytor.com, bp@alien8.de, linux-serial@vger.kernel.org,
        agross@kernel.org, tglx@linutronix.de, frowand.list@gmail.com,
        bjorn.andersson@linaro.org, jslaby@suse.com,
        catalin.marinas@arm.com, corbet@lwn.net, will@kernel.org,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Dave Martin <Dave.Martin@arm.com>,
        Enrico Weigelt <info@metux.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        jinho lim <jordan.lim@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/9] arm64: Add call_break_hook() to early_brk64() for
 early kgdb
Message-ID: <20200427165255.bjwkjobfzinzzlxb@holly.lan>
References: <20200421211447.193860-1-dianders@chromium.org>
 <20200421141234.v2.5.I22067ad43e77ddfd4b64c2d49030628480f9e8d9@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421141234.v2.5.I22067ad43e77ddfd4b64c2d49030628480f9e8d9@changeid>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Apr 21, 2020 at 02:14:43PM -0700, Douglas Anderson wrote:
> In order to make early kgdb work properly we need early_brk64() to be
> able to call into it.  This is as easy as adding a call into
> call_break_hook() just like we do later in the normal brk_handler().
> 
> Once we do this we can let kgdb know that it can break into the
> debugger a little earlier (specifically when parsing early_param's).
> 
> NOTE: without this patch it turns out that arm64 can't do breakpoints
> even at dbg_late_init(), so if we decide something about this patch is
> wrong we might need to move dbg_late_init() a little later.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>

I haven't done any testing at this point (I'd hope to enable tests
for this in the test suite), however FWIW and just so you know I didn't
forget about this patch:

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
