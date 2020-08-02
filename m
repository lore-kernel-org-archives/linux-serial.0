Return-Path: <SRS0=oHof=BM=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59809C433E0
	for <linux-serial@archiver.kernel.org>; Sun,  2 Aug 2020 10:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 300EB20738
	for <linux-serial@archiver.kernel.org>; Sun,  2 Aug 2020 10:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ErBQg6md"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgHBKur (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 2 Aug 2020 06:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbgHBKur (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 2 Aug 2020 06:50:47 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32FE7C06174A;
        Sun,  2 Aug 2020 03:50:47 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id d4so4260pjx.5;
        Sun, 02 Aug 2020 03:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kwwr83/FGYC32MxT7n0i2OVrINeNsqcZKefoo0LIK0E=;
        b=ErBQg6mdniY6rwVCzNY8+Sna2q/9hInua4lYuJFfbde0zt40yuIXtB0Gx1PsafNC+n
         tjpveSjOwHkpRR7P9qJ8K9KHYdhqvGTDW4YMDyv9iQ23cMdUXHhu7Cx5Xs4NziId4ikU
         yw69QnQsxuOT5CAqaCCG1xvjaGuMttxqm3FL19CyeUjl6SPGjjBdThTy5H55oY25k0Rm
         X/nfcyIt2fqUyGGjg2A8jnyE2CZX7qFpzvHxquC/d1Kcqsn84po5AkYFiwc140i4NtMq
         4PXJcR6iWQP8SKLfFvezr78njxn3679iikVMAWCYfTpLPzYGjaBK/kgHKRTIEGghWatp
         nmhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kwwr83/FGYC32MxT7n0i2OVrINeNsqcZKefoo0LIK0E=;
        b=k9y2CYiFUUkeuoCcr/8YN8fqAqPa5qJzUnSDdND6HYWzXTMOgoIaWb6lbF/DE6zlZh
         vyd+5rBTusdnlkFJJkhUkGfhH1llm60MH3mINZnV8ZF/OEmvKf8sNVtvIYpnw0AX0Nzw
         7n1fLwIbqbuW+gff/UEKA/X836M2jovTerunKDgZIkMJWoE+wuCiPCibhYYmJNfgZEft
         zjeukuvxJPYHJ9YCAzOQ34o3eR2f9dJdJn9ofNutCePOCaj1sGXZb1z69o4iFccUGXP7
         XCnmARLTcMZQ1uI0o9lCWBqnfphQHV3x3aRXC5f4cktPRiVKKpE2hVJQ4sIO5ZXDGjQ8
         59rA==
X-Gm-Message-State: AOAM530UJGYz8wlkC4dVYPsKYys0PefigM8chVfbF25CW2CwAuYPGKYm
        pqQTAmCPUGlQJEIbXR+SeqoIiPij87VoHqWPyKk=
X-Google-Smtp-Source: ABdhPJwPXJuETUv49y3W3LPcJZdMl3Z2UxDwcyOI38TVXYiJWyaT8IwAQZ2Vp/EPszqH5lMz1+taIy9/nuwGG2lVl3U=
X-Received: by 2002:a17:90a:390f:: with SMTP id y15mr11964856pjb.181.1596365446601;
 Sun, 02 Aug 2020 03:50:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200802054852.GR23458@shao2-debian>
In-Reply-To: <20200802054852.GR23458@shao2-debian>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 2 Aug 2020 13:50:29 +0300
Message-ID: <CAHp75Vcdwz2RynZ0KVCDMFyO_GPREgGdCNVNGqosjf6iV0_uog@mail.gmail.com>
Subject: Re: [serial] 679193b7ba: BUG:spinlock_bad_magic_on_CPU
To:     kernel test robot <lkp@intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        lkp@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, Aug 2, 2020 at 8:54 AM kernel test robot <lkp@intel.com> wrote:
>
> Greeting,
>
> FYI, we noticed the following commit (built with gcc-9):
>
> commit: 679193b7baf8d88e41cbeb397ca17f797654947d ("serial: 8250: Let serial core initialise spin lock")
> https://git.kernel.org/cgit/linux/kernel/git/gregkh/tty.git tty-next
>
>
> in testcase: boot
>
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
>
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>
>
> +-------------------------------+------------+------------+
> |                               | f3af1b68fc | 679193b7ba |
> +-------------------------------+------------+------------+
> | boot_successes                | 4          | 0          |
> | boot_failures                 | 0          | 4          |
> | BUG:spinlock_bad_magic_on_CPU | 0          | 4          |
> +-------------------------------+------------+------------+
>
>
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <lkp@intel.com>

Thanks for the report. I didn't see it on real hardware though. Maybe
because of timing (race?) differences.

Greg, I think the best is to revert the change until I will have better one.

-- 
With Best Regards,
Andy Shevchenko
