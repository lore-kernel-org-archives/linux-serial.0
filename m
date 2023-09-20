Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83ABDC00523
	for <linux-serial@archiver.kernel.org>; Wed, 20 Sep 2023 15:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235264AbjITPNg (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 20 Sep 2023 11:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234864AbjITPNf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 20 Sep 2023 11:13:35 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2DFCE
        for <linux-serial@vger.kernel.org>; Wed, 20 Sep 2023 08:13:30 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c47309a8ccso7027765ad.1
        for <linux-serial@vger.kernel.org>; Wed, 20 Sep 2023 08:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695222809; x=1695827609; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/hyiPJzwLyvz53eOPwWn5KTS3ATXYJRveFNMbAiYRwk=;
        b=P3YvM4YLE5mdSNDQP8M83pygwFAlb3uI5G0LrtEMOn+sJK3er3zTqU/QyIncSs7RoK
         JTMEpFCaTV+ADa9cf4nqwf4nXcWkg8LOHtpidLsiri2q4GtYqUjSghXbS5d5y9lvRvBh
         FJJHr/rKVG9xIiHK/lVpHNeOzMRRTPPAWtpVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695222809; x=1695827609;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/hyiPJzwLyvz53eOPwWn5KTS3ATXYJRveFNMbAiYRwk=;
        b=hyHLGdE+6ZCG6S2sREeR0sevKVWVGDSrQrlWZqDvq2GkQC0z+/sKDMOP7Tl80QCOxB
         Z3kXqs4YFKGXxIIm2oAn9QtxEGEnZZst6AOMbRufT8HOvO6UYK0W+2e/RLW1p/+OzoRI
         2+vLFHV2tkFJg8IF3034m6UvCIx6KuCCTDYwCax/iiPHiz6fd/Xk5rlOqHTG5KMiWJJo
         l2uHFNcwph/KeRrd8HEZIkfGaqlSrxyO6/6Qjhtmf120oNnvEleWZKi86OYeEH/61fUo
         9bE7CSyKjLxNAU+6Ij4tnNR+DrZWqA4pm25lPOJFobrQYh4zjGu8Y1+l8FO6gyLC7RBb
         7NIw==
X-Gm-Message-State: AOJu0Yw6BRYjiBhbTZwMMzKxIqb6UXvrkGpxPd8qzieVs20QA/wU0Yn6
        bllUWAc37hU4DNOYVu0azcIVbw==
X-Google-Smtp-Source: AGHT+IHjY/EA4Uaz2uN8Hf+rV5YjM1d2ccJFzhZB2yI5nZQzuRgpHsCOPdzZTHTUX2L8rGpX2Z27SA==
X-Received: by 2002:a17:902:d2cd:b0:1c5:6f43:9502 with SMTP id n13-20020a170902d2cd00b001c56f439502mr4352961plc.14.1695222809493;
        Wed, 20 Sep 2023 08:13:29 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u7-20020a170903124700b001bb0eebd90asm11948601plh.245.2023.09.20.08.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 08:13:28 -0700 (PDT)
Date:   Wed, 20 Sep 2023 08:13:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeems@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v2] vt: Replace strlcpy with strscpy
Message-ID: <202309200813.1B0C125@keescook>
References: <20230919192156.121503-1-azeems@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919192156.121503-1-azeems@google.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Sep 19, 2023 at 07:21:56PM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first and returns the size of
> the source string, not the destination string, which can be accidentally
> misused [1].
> 
> The copy_to_user() call uses @len returned from strlcpy() directly
> without checking its value. This could potentially lead to read
> overflow. There is no existing bug since @len is always guaranteed to be
> greater than hardcoded strings in @func_table[kb_func]. But as written
> it is very fragile and specifically uses a strlcpy() result without sanity
> checking and using it to copy to userspace.
> 
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeems@google.com>
> ---
> v2:
>  * Return -ENOSPC instead of -EFAULT in case of truncation.
>  * Update commit log to clarify that there is no exploitable bug but instead the code uses a fragile anti-pattern.

Changes look good. Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
