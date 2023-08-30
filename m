Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 941C7C83F15
	for <linux-serial@archiver.kernel.org>; Wed, 30 Aug 2023 21:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241456AbjH3VaG (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 30 Aug 2023 17:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241446AbjH3VaE (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 30 Aug 2023 17:30:04 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0770CEC
        for <linux-serial@vger.kernel.org>; Wed, 30 Aug 2023 14:29:29 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3a7ca8720a0so48289b6e.2
        for <linux-serial@vger.kernel.org>; Wed, 30 Aug 2023 14:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693430902; x=1694035702; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mX87NFpq5hOfvdT04Pm6d0i+GaLVpBWiM2uVOuPxz60=;
        b=cYHrhovLKJ0sEMTq4zgO8HS67HCdrzFmVUyOFqBC80H2PibOEVEyQmgob1ZHoz+uc3
         ReBfEXceHcuJIGzKuZg91AUrGrm/d7ab0MgnMD/KyCAc295wb3rSmU+XRPMeYeXaBpFA
         Aor+lq3y59gsc7+LGZd94tATl8pE/JJOxarXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693430902; x=1694035702;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mX87NFpq5hOfvdT04Pm6d0i+GaLVpBWiM2uVOuPxz60=;
        b=a0rz47g74+qKFlcfppSNK6N+JrVEySgLkSVmGDNfag7LAxTDzG9HNRSbHdmxpKfLOw
         cCDwiipReroiU427AXqBplc0ErgTw3yhZF6mb69T5zWPGElu1I34GW4R0fAp8K1vlTWd
         xRYSL/BQaNYmNV8ZEbzuFfdCxhLfKYb6Dsz471oRD8c0DB9kkH74YGiGIV9sHkEJlmp6
         URUMImLnRdITnCo4DccvBMQPgsed7BGia0WT6AUoyEtqihCMeiK7hrXE2ADTcJfvkDTb
         Pp9eKscseCYvlbNGnPbuvTDQCFlmN7IyQ+MHPxWBkai1pJgfI3a9d+MoVuuGkIjPAH0+
         XRBA==
X-Gm-Message-State: AOJu0YyKA9VFzbKzmHHzVw0I1Y3EYtpc/HRct+7P4ic9hV1r9CCR9o4h
        OYvRwNxn8zTxmP0/m52IoMbkMg==
X-Google-Smtp-Source: AGHT+IGQ084nkb7iIsJ2XF+m82eh0ID/gW5Gdzzjqr3zKMtpOfpaWSrwZxRRJSR+a0zPwLsgAs5h0Q==
X-Received: by 2002:a05:6808:199e:b0:3a1:c108:41b1 with SMTP id bj30-20020a056808199e00b003a1c10841b1mr4046501oib.25.1693430902532;
        Wed, 30 Aug 2023 14:28:22 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i15-20020a63bf4f000000b00565e96d9874sm34815pgo.89.2023.08.30.14.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 14:28:21 -0700 (PDT)
Date:   Wed, 30 Aug 2023 14:28:21 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] vt: Fix potential read overflow of kernel memory
Message-ID: <202308301421.997C4034B5@keescook>
References: <20230830160410.3820390-1-azeemshaikh38@gmail.com>
 <2023083035-unpadded-amulet-8c7e@gregkh>
 <CADmuW3Wbgb7s+jRm8F0hcjzreWysVdzNvv778yUbGCOxAJHwjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADmuW3Wbgb7s+jRm8F0hcjzreWysVdzNvv778yUbGCOxAJHwjQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Aug 30, 2023 at 03:25:54PM -0400, Azeem Shaikh wrote:
> On Wed, Aug 30, 2023 at 1:57 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Aug 30, 2023 at 04:04:10PM +0000, Azeem Shaikh wrote:
> > > strlcpy() reads the entire source buffer first.
> > > This read may exceed the destination size limit if
> > > a source string is not NUL-terminated [1].
> >
> > But that's not the case here, right?  So your "potential read overflow"
> > isn't relevant here.
> >
> > > The copy_to_user() call uses @len returned from strlcpy() directly
> > > without checking its value. This could potentially lead to read
> > > overflow.
> >
> > But can it?  How?
> >
> 
> The case I was considering is when the null-terminated hardcoded
> string @func_table[kb_func] has length @new_len > @len. In this case,
> strlcpy() will assign @len = @new_len and copy_to_user() would read
> @new_len from the kmalloc-ed memory of @len. This is the potential
> read overflow I was referring to. Let me know if I'm mistaken.

First there is:

ssize_t len = sizeof(user_kdgkb->kb_string);

"struct user_kdgkb" is UAPI (therefore unlikely to change), and kb_string
is 512:

struct kbsentry {
        unsigned char kb_func;
        unsigned char kb_string[512];
};

Then we do:

                len = strlcpy(kbs, func_table[kb_func] ? : "", len);

This is the anti-pattern (take the length of the _source_) we need to
remove. However, func_table[] is made up of either %NUL-terminated
strings:

char func_buf[] = {
        '\033', '[', '[', 'A', 0, 
        '\033', '[', '[', 'B', 0, 
...
char *func_table[MAX_NR_FUNC] = {
        func_buf + 0,
        func_buf + 5,
...

Or a NULL address itself. The ?: operator handles the NULL case, so
"len" can only ever be 0 through the longest string in func_buf. So it's
what I'd call "accidentally correct". i.e. it's using a fragile
anti-pattern, but in this case everything is hard-coded and less than
512.

Regardless, we need to swap for a sane pattern, which you've done. But
the commit log is misleading, so it needs some more detail. :)

-Kees

-- 
Kees Cook
