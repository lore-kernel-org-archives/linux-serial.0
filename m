Return-Path: <SRS0=2C4M=7Z=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99073C433E0
	for <linux-serial@archiver.kernel.org>; Fri, 12 Jun 2020 15:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75AAD207F7
	for <linux-serial@archiver.kernel.org>; Fri, 12 Jun 2020 15:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JkcibBjZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgFLPwL (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 12 Jun 2020 11:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgFLPwK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 12 Jun 2020 11:52:10 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356ACC03E96F;
        Fri, 12 Jun 2020 08:52:09 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id r9so8626543wmh.2;
        Fri, 12 Jun 2020 08:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NakzWRM9YS38023tyzkXCgU45379YlUYam+cS/rkKzA=;
        b=JkcibBjZFtxDJjCe7rNgAWuZPSFz/l74sya5KCgxX1puQYARTDVPkMTqKyIt5EpIUH
         4F3kyF+oTM6HJVj5TS0Br88XcWz4oMVCvxm+GaMJQ/grSt4phr3AarzBJesFzobd3Mwc
         d+fEreUGvnqMyRN6ApKvTwQLhzufl5SwNsJh3n9szMFpRspEHfIYOrHY/So9fmW7Q2M4
         AOXVDtU4CCLqqAUBydr7iHsxmL0EA7LD/npE2dlo8ytAZLIbD4rEElJS//+0LzBeqLrV
         gkypsnxnMO4YWAvA8/HmQcOsu7WEuxJnWlI1p0X/p7fX1oq0BdQ3w29vZelIaXWzckx2
         H5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NakzWRM9YS38023tyzkXCgU45379YlUYam+cS/rkKzA=;
        b=C34xSePMJmOdBAS7W8ThjhZbiswYHCrGC0q9ld8udGARBRWLJc0mg976GwymNaaoKr
         s6T/BEd7EnbmUccV0FTxCScgwhS0azWXgLOVPbU0xenmBVi9BhWipt+yX2hTi+EbZQwp
         XD2lJ/7TyXuy7cXk8e1Hy1z9zEp2FydRiIQ1xI1+BUJKtAu/zPX9z4yKXZaUYTlXRQmu
         AJYCgb2gtjktydJaJYVCQBFenQAIGYDdZ+jrCUA+yhrOn+pzhyOW9AR4sQXz8X9Tf3ub
         fTWzDAGZ02tL0RhOJTEKOlbFMgiC95/P1bwszgl3G/X6xJ2DgNIV0jmlES39eULfhq/O
         kqmg==
X-Gm-Message-State: AOAM532B8ROt12mVY7jQKuuYdcnl6eo4jwJ3I4DfJo6sb6EKmI9NLA3m
        cT86/SsRd1vQVX1FYpTyKA6yX0GH
X-Google-Smtp-Source: ABdhPJz9rJQyiph7wv5btXmqBVlSkIVBLc5HurMludqDUg1MJgJISCmF1zBCH3yhhOLXRWvX7e9rPQ==
X-Received: by 2002:a05:600c:2045:: with SMTP id p5mr15005247wmg.91.1591977128004;
        Fri, 12 Jun 2020 08:52:08 -0700 (PDT)
Received: from ?IPv6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id p16sm11413855wru.27.2020.06.12.08.52.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2020 08:52:07 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] serial: core: fix sysrq overhead regression
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200610152232.16925-1-johan@kernel.org>
 <20200610152232.16925-3-johan@kernel.org>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Message-ID: <8c6d7bae-0ebd-caa7-f9c7-96ec7035abfb@gmail.com>
Date:   Fri, 12 Jun 2020 16:52:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200610152232.16925-3-johan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 6/10/20 4:22 PM, Johan Hovold wrote:
> Commit 8e20fc391711 ("serial_core: Move sysrq functions from header
> file") converted the inline sysrq helpers to exported functions which
> are now called for every received character, interrupt and break signal
> also on systems without CONFIG_MAGIC_SYSRQ_SERIAL instead of being
> optimised away by the compiler.
> 
> Inlining these helpers again also avoids the function call overhead when
> CONFIG_MAGIC_SYSRQ_SERIAL is enabled (e.g. when the port is not used as
> a console).
> 
> Fixes: 8e20fc391711 ("serial_core: Move sysrq functions from header file")
> Cc: Dmitry Safonov <0x7f454c46@gmail.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Thanks for sending and the numbers, it's a bit pity that we need to move
them back to the header, but as it matters for your setup,

Reviewed-by: Dmitry Safonov <0x7f454c46@gmail.com>

Thanks,
           Dmitry
