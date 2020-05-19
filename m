Return-Path: <SRS0=bJiX=7B=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF41AC433E1
	for <linux-serial@archiver.kernel.org>; Tue, 19 May 2020 10:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE52120758
	for <linux-serial@archiver.kernel.org>; Tue, 19 May 2020 10:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XWeV8b7S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbgESKhD (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 19 May 2020 06:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbgESKhC (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 19 May 2020 06:37:02 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E0CC061A0C
        for <linux-serial@vger.kernel.org>; Tue, 19 May 2020 03:37:02 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id v12so15246101wrp.12
        for <linux-serial@vger.kernel.org>; Tue, 19 May 2020 03:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=i9H4OZ10YdHZdhc7/rIrHtv9xR5CbfD8gzRd+3adHCg=;
        b=XWeV8b7S4EVjZhJ79Ag3v5DEaPyKNzfmliI3RiiRpgwEJDw+Ncgl4tXOIDiPBN0ehm
         YWZkEFKgex9Pc/rKjydVwahDLrwR8y6N2K4ijHy3Amx1ZdXZ2xBQgWhfRQABcJPNiNen
         rvvr6M54m9ca8L0/CiltsnZCDTQWxVvjmvFJbUT1tWQqdCluvrPTvoiST9aq4ly+lBdO
         9EODHL0fC3KzWE7uHm51t4l8qTtDotOQL7iYLRSY1R7UA8NmexCH9vCLfXBsdeMPYMvj
         3T+qCgXK3atV0sLi8FiY4uh4nBrb+rXL92/CWmN5vPGLifpAvQMdAg7EhyCp2P4iaesc
         Ek2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i9H4OZ10YdHZdhc7/rIrHtv9xR5CbfD8gzRd+3adHCg=;
        b=jSsRjWs5x2GQO8RXS/tU2CeokOljkfQfD/+V5Y0DvfVNphfqt2xXFtRdJyofNN4ykx
         3MZJ+T5wooq+iQ24KB2ZY9iU8Mej4eg69EjKwSkoRSV7SE+w/B6zoQsw5bXtZ2ElE8Dm
         ZrQ17D9cFNS0d8ih7kFPsDMOMRL+3zOXwXxnqqGUa/C1NzqAAoYPBNUF83etFb3Ennzw
         kIsNvn/aI8PfuYPdt4dHv5uL0HM/UR6fZqaHndoIOCQi3qE67inDfOpGJGZroyWZRonE
         yvwgoJjyOXH4v4tvnGMnlKh/umGCQ/OK62YTwYL1iwdFqaAUXbgS5wBSOaTh6vzj660D
         /kWQ==
X-Gm-Message-State: AOAM5333z9eLMoka+3+v46tXrRmaYmWjDDogP9cB++zmwHAGubEEo8tl
        RESDybaYh7NNRuXHzJ322Lm7cw==
X-Google-Smtp-Source: ABdhPJzJiTwMyvVTnOctSw0HxZdkufYRwI8zQqI86F0CX4btXGOdMQMwWIBlYi+xtP8+zww/fzO92g==
X-Received: by 2002:a5d:4dc9:: with SMTP id f9mr24784938wru.407.1589884621033;
        Tue, 19 May 2020 03:37:01 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id l18sm3275536wmj.22.2020.05.19.03.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 03:37:00 -0700 (PDT)
Date:   Tue, 19 May 2020 11:36:58 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     jason.wessel@windriver.com, gregkh@linuxfoundation.org,
        corbet@lwn.net, frowand.list@gmail.com, bjorn.andersson@linaro.org,
        linux-serial@vger.kernel.org, mingo@redhat.com, hpa@zytor.com,
        jslaby@suse.com, kgdb-bugreport@lists.sourceforge.net,
        sumit.garg@linaro.org, will@kernel.org, tglx@linutronix.de,
        agross@kernel.org, catalin.marinas@arm.com, bp@alien8.de,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Enrico Weigelt <info@metux.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        James Morse <james.morse@arm.com>,
        Juergen Gross <jgross@suse.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Russell King <linux@armlinux.org.uk>,
        jinho lim <jordan.lim@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v4 00/12] kgdb: Support late serial drivers; enable early
 debug w/ boot consoles
Message-ID: <20200519103658.eha5zbmun4i56oml@holly.lan>
References: <20200507200850.60646-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507200850.60646-1-dianders@chromium.org>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, May 07, 2020 at 01:08:38PM -0700, Douglas Anderson wrote:
> This whole pile of patches was motivated by me trying to get kgdb to
> work properly on a platform where my serial driver ended up being hit
> by the -EPROBE_DEFER virus (it wasn't practicing social distancing
> from other drivers).  Specifically my serial driver's parent device
> depended on a resource that wasn't available when its probe was first
> called.  It returned -EPROBE_DEFER which meant that when "kgdboc"
> tried to run its setup the serial driver wasn't there.  Unfortunately
> "kgdboc" never tried again, so that meant that kgdb was disabled until
> I manually enalbed it via sysfs.
> 
> <snip>
> 
> This series (and my comments / documentation / commit messages) are
> now long enough that my eyes glaze over when I try to read it all over
> to double-check.  I've nontheless tried to double-check it, but I'm
> pretty sure I did something stupid.  Thank you ahead of time for
> pointing it out to me so I can fix it in v5.  If somehow I managed to
> not do anything stupid (really?) then thank you for double-checking me
> anyway.

Applied (minus the arm64 specific stuff), should be in the next linux-next.


Daniel.
