Return-Path: <SRS0=7vif=63=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA45EC433DF
	for <linux-serial@archiver.kernel.org>; Wed, 13 May 2020 23:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D107A2053B
	for <linux-serial@archiver.kernel.org>; Wed, 13 May 2020 23:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d91N+o6U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732274AbgEMXMh (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 13 May 2020 19:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728315AbgEMXMZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 13 May 2020 19:12:25 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FB7C061A0C
        for <linux-serial@vger.kernel.org>; Wed, 13 May 2020 16:12:25 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id z1so839432vsn.11
        for <linux-serial@vger.kernel.org>; Wed, 13 May 2020 16:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NzQVGwBy98yyKuXlmBNvWD4o+eLGqCxtgVxPgKw63Do=;
        b=d91N+o6UMzxTsz1St1Hu66m8IAaS2jE1/WCro4T3FXi2sc/4AHW4ODcGwfEnvDzHjj
         /PKKX5txh+2AdFLEuJtnkNNG0IRWzECKUG3SGfFwrIcEdqW19nhO2jFicMOUMvz6T+C1
         tNR/mldiveHPbJerAbyvqheERVBHSeb8Q1lg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NzQVGwBy98yyKuXlmBNvWD4o+eLGqCxtgVxPgKw63Do=;
        b=d49PgJNccyR3LzCl2zVfaLuhmLQqaZCOh0JL1UjmhLicJxcP+ADFtpB41b1pL4t+QN
         zFM6uDBB7w9/YD13NA3QUeTt8ZXZj0eDCvUmKr9sCssndmzY0SrFDuU1BYj21ky2XMCL
         s8fSi9oS5bhASvmSjpTL9qK2yiKCTTuWZDua4URXd87CuQSNxzNr0KoE9EtLwij+gE+4
         TOHxHohRqvgc5BANUXxsaAW9jngfThrRjjNBoCC8ro0HhGmPs4XncpYEBAHYGqDidoGZ
         FBdo5J661pJtN8lYLcOS1/bANBhRQ8Lc7U49uwYFEf3lWlZxZ22Z52nrv5Zwuvkh+TOR
         tDiw==
X-Gm-Message-State: AOAM531TU6taQT3LTVWWjU31iRERHebtn7Q0u/Wovja8HCfh/MbjeG5I
        b67ftTQtJ/CZG8Teea8CY/lIY8yW1iA=
X-Google-Smtp-Source: ABdhPJwtyIaLKprJdL7YnzSRowZmmSGDH9qp3YndgmHLg0WvskkNKAmlgJyCJ8V5xiiaStkX4nqd+w==
X-Received: by 2002:a67:2204:: with SMTP id i4mr1398875vsi.87.1589411544183;
        Wed, 13 May 2020 16:12:24 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id i199sm270381vke.20.2020.05.13.16.12.22
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 16:12:23 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id b11so833981vsa.13
        for <linux-serial@vger.kernel.org>; Wed, 13 May 2020 16:12:22 -0700 (PDT)
X-Received: by 2002:a67:bd07:: with SMTP id y7mr1357400vsq.109.1589411542393;
 Wed, 13 May 2020 16:12:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200507200850.60646-1-dianders@chromium.org> <20200507130644.v4.5.I22067ad43e77ddfd4b64c2d49030628480f9e8d9@changeid>
In-Reply-To: <20200507130644.v4.5.I22067ad43e77ddfd4b64c2d49030628480f9e8d9@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 13 May 2020 16:12:11 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wq1bnaMnUa09GZzQq5rZeQHUM9WAmxED3foc_Rjdsg2A@mail.gmail.com>
Message-ID: <CAD=FV=Wq1bnaMnUa09GZzQq5rZeQHUM9WAmxED3foc_Rjdsg2A@mail.gmail.com>
Subject: Re: [PATCH v4 05/12] arm64: Add call_break_hook() to early_brk64()
 for early kgdb
To:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Frank Rowand <frowand.list@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-serial@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Jiri Slaby <jslaby@suse.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Sumit Garg <sumit.garg@linaro.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>, bp@alien8.de,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Dave Martin <Dave.Martin@arm.com>,
        Enrico Weigelt <info@metux.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        jinho lim <jordan.lim@samsung.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On Thu, May 7, 2020 at 1:09 PM Douglas Anderson <dianders@chromium.org> wrote:
>
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
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>
> Changes in v4:
> - Add "if KGDB" to "select ARCH_HAS_EARLY_DEBUG" in Kconfig.
>
> Changes in v3:
> - Change boolean weak function to KConfig.
>
> Changes in v2: None
>
>  arch/arm64/Kconfig                      | 1 +
>  arch/arm64/include/asm/debug-monitors.h | 2 ++
>  arch/arm64/kernel/debug-monitors.c      | 2 +-
>  arch/arm64/kernel/traps.c               | 3 +++
>  4 files changed, 7 insertions(+), 1 deletion(-)

As discussed in the replies to the v3 version of this patch [1], I
have posted a replacement patch for this one [2].  After the cut in
the replacement patch I talk about different ways it could land.
Hopefully that's not too confusing.  I can also re-spam everyone with
a v5 of the whole series if that makes it clearer.

[1] https://lore.kernel.org/r/20200428141218.v3.5.I22067ad43e77ddfd4b64c2d49030628480f9e8d9@changeid
[2] https://lore.kernel.org/r/20200513160501.1.I0b5edf030cc6ebef6ab4829f8867cdaea42485d8@changeid

-Doug
