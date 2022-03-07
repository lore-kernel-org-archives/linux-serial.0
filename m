Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF51C433EF
	for <linux-serial@archiver.kernel.org>; Mon,  7 Mar 2022 14:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243143AbiCGOY5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 7 Mar 2022 09:24:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243140AbiCGOY4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 7 Mar 2022 09:24:56 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D0C6E8F0
        for <linux-serial@vger.kernel.org>; Mon,  7 Mar 2022 06:24:00 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id q14so8004830wrc.4
        for <linux-serial@vger.kernel.org>; Mon, 07 Mar 2022 06:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mIIVvuK2N/32KeIEXgX7T/cu6Rp6fCq2WJv1t+elJk0=;
        b=F2EkS1OkeFcBz8FzJ1PYrn6nmbbnh/LcjsYdslyLyKZouoZOngfzPhavOHdNWb7ntF
         lMAgQWVFgb49+9jjYedUUgGDvRPwtCEPF3NcY6CddSac5a65ceBDeKdeRDx6SbE2t+BC
         gHnLBtUa4KBEJzs26sxJjjlCII0LOpkjS2+HXgBAsIvNNBZ/RvzRs2LyEfle51GLFuEQ
         +QIzEPukRNOi04Ew6pYfB6zcXlT4hEx0ppXmoFcwMVBY69ad7YNJxhFEuu72csDcx1eH
         xY6WwAFodItq4zPMUqlzV8XDP17LIDgSqj9umFJOElv28rbY7NuoxbVuvoU8Q/yICaoX
         ndSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mIIVvuK2N/32KeIEXgX7T/cu6Rp6fCq2WJv1t+elJk0=;
        b=yR1vS/9fzo0zjktDyLfR7/KCPfxrxmCb0ClyuV01YgiVuwD8eJ3Np7KqqBBCetN67R
         60aXDQxy1DIDYe9TFzznYAzd+6qxt9U3spCU1GWxgMpWaUDnykVIPT4oNFuyTTAoihHk
         5xYfTCnzd1bcYYreYnAP7j9KZU0hgYV5ArYRXsL/QKkC3ZK5+ovjlz1E0FqP9Z6Z24Oy
         CVqNvZ4TaywqFn0YQKaiEX/lMHWkTzREzoSBkMmHZCV5loNgOwA4yIQ5/6SFb687IOX3
         PwH4KXrZ727rmcd4IsDGMaMn1ND81/X3Uv1kkFc37qia7NQcQDAXOo3DbnHv+qrNBR7y
         Jliw==
X-Gm-Message-State: AOAM533xfNYeEf/WfJ+e3ZGynv8llE9rvADAIvQWIhHVC7QRqhIBktnm
        ekUNio3axQB84uG0rMcHkrAizi97k4gL+Jp/
X-Google-Smtp-Source: ABdhPJzQI4QjqhdFPG0fJBteqt1+29zzxkApr9e/9w3GgGEmpxrbvRqsxvfQsyX3DLpyuuTW1sis/A==
X-Received: by 2002:adf:ea0f:0:b0:1f0:61f6:c3df with SMTP id q15-20020adfea0f000000b001f061f6c3dfmr8407228wrm.543.1646663038946;
        Mon, 07 Mar 2022 06:23:58 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id p3-20020a05600c358300b003897e440047sm10853608wmq.28.2022.03.07.06.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 06:23:58 -0800 (PST)
Date:   Mon, 7 Mar 2022 14:23:56 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     linux-serial@vger.kernel.org, hasegawa-hitomi@fujitsu.com,
        dianders@chromium.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, jason.wessel@windriver.com,
        linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
        arnd@arndb.de, peterz@infradead.org
Subject: Re: [RFT v4] tty/sysrq: Make sysrq handler NMI aware
Message-ID: <20220307142356.ksx7k5xalqlsxnqk@maple.lan>
References: <20220307110328.2557655-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307110328.2557655-1-sumit.garg@linaro.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Mar 07, 2022 at 04:33:28PM +0530, Sumit Garg wrote:
> Allow a magic sysrq to be triggered from an NMI context. This is done
> via marking some sysrq actions as NMI safe. Safe actions will be allowed
> to run from NMI context whilst that cannot run from an NMI will be queued
> as irq_work for later processing.
>
> <snip>
>
> @@ -566,12 +573,46 @@ static void __sysrq_put_key_op(int key, const struct sysrq_key_op *op_p)
>  		sysrq_key_table[i] = op_p;
>  }
>  
> +static atomic_t sysrq_key = ATOMIC_INIT(-1);
> +
> +static void sysrq_do_irq_work(struct irq_work *work)
> +{
> +	const struct sysrq_key_op *op_p;
> +	int orig_suppress_printk;
> +	int key = atomic_read(&sysrq_key);
> +
> +	orig_suppress_printk = suppress_printk;
> +	suppress_printk = 0;
> +
> +	rcu_sysrq_start();
> +	rcu_read_lock();
> +
> +	op_p = __sysrq_get_key_op(key);
> +	if (op_p)
> +		op_p->handler(key);
> +
> +	rcu_read_unlock();
> +	rcu_sysrq_end();
> +
> +	suppress_printk = orig_suppress_printk;
> +	atomic_set(&sysrq_key, -1);
> +}
> +
> +static DEFINE_IRQ_WORK(sysrq_irq_work, sysrq_do_irq_work);
> +
>  void __handle_sysrq(int key, bool check_mask)
>  {
>  	const struct sysrq_key_op *op_p;
>  	int orig_log_level;
>  	int orig_suppress_printk;
>  	int i;
> +	bool irq_work = false;
> +
> +	/* Skip sysrq handling if one already in progress */
> +	if (atomic_cmpxchg(&sysrq_key, -1, key) != -1) {
> +		pr_warn("Skip sysrq key: %i as one already in progress\n", key);
> +		return;
> +	}

Doesn't this logic needlessly jam sysrq handling if the irq_work cannot
be undertaken?

A console user could unwittingly attempt an !nmi_safe SysRq action on
a damaged system that cannot service interrupts. Logic that prevents
things like backtrace, ftrace dump, kgdb or reboot is actively harmful
to that user's capability to figure out why their original sysrq doesn't
work.

I think the logic to prohibht multiple deferred sysrqs should only
be present on code paths where we are actually going to defer the sysrq.


Daniel.
