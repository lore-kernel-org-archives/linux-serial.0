Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A65BC4320E
	for <linux-serial@archiver.kernel.org>; Tue, 31 Aug 2021 00:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9F9160FF2
	for <linux-serial@archiver.kernel.org>; Tue, 31 Aug 2021 00:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239107AbhHaAeq (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 30 Aug 2021 20:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234021AbhHaAep (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 30 Aug 2021 20:34:45 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A77C061760
        for <linux-serial@vger.kernel.org>; Mon, 30 Aug 2021 17:33:51 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id w19-20020a17090aaf9300b00191e6d10a19so1168610pjq.1
        for <linux-serial@vger.kernel.org>; Mon, 30 Aug 2021 17:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TjFdVibCziMMV625QJ8En+pQePJGwxqOLzHHo+cR/2g=;
        b=AzDcWKGtdHyMnoIEjzFPFQjRSRfN6cZcyUfqyg+1RFft/sQblgaz4y7UB0acXhUsAk
         aYq77Xwd7EMjSfEApWR3a558fJLQOEbjXYD1SI5rTv8NJMwK07Xba20kndQ9K5z7nQNv
         VqF6GPhvubvT3lLK/TsJYcG7uj5cuYcL5eVI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TjFdVibCziMMV625QJ8En+pQePJGwxqOLzHHo+cR/2g=;
        b=Tl6TNxN26TZw734qwkq5vxrkRjrj+gt9xYgqK368oO6p+nbLraIb4NIbWrVH92UC0i
         h2Vb5VvEgraZz5SB1Zqqkb+WGcOeWj9jjy8KGRTx5SLAEoCaECsqpTip+v8uccodcTa2
         h19awwKw2YhFA476PFi1XEuVs9WdOa/ukVMyok6YMc8nTm/c9YN9U3+WHfC0F6p6BMIt
         fFqfGx0KDK4D2SQ57TH/hDBDMDhdKtuwVPhEEAo+JJmBfD4iY6ttC61vBLd6hSfJoYbm
         kp+HRqk62ufdlzPfjwO1gmKccmWzdxjBlp1nj3b1jfSZAN8PpwxFiRXy3VGM25G78dP+
         lR/Q==
X-Gm-Message-State: AOAM531eTjwnBFZDiaMRDIumlYyh2bOWiTUPW3uTTeiextylC/093EhS
        ieV4G8ao0bisfodBh8oTlrazEA==
X-Google-Smtp-Source: ABdhPJxdbxW4ryHv5bhuf8dsnrqkWswjsDidSV0lyn6xogTwXPWUAw0uITGdywWoWH5lbvCpqEzDjw==
X-Received: by 2002:a17:90a:bc47:: with SMTP id t7mr2025742pjv.19.1630370030908;
        Mon, 30 Aug 2021 17:33:50 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:69ed:b45b:ceb5:e18b])
        by smtp.gmail.com with ESMTPSA id q12sm15915318pfj.153.2021.08.30.17.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 17:33:50 -0700 (PDT)
Date:   Tue, 31 Aug 2021 09:33:36 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Chengyang Fan <cy.fan@huawei.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        kgdb-bugreport@lists.sourceforge.net,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Vitor Massaru Iha <vitor@massaru.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Changbin Du <changbin.du@intel.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Cengiz Can <cengiz@kernel.wtf>,
        Jiri Slaby <jirislaby@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        kuldip dwivedi <kuldip.dwivedi@puresoftware.com>,
        Wang Qing <wangqing@vivo.com>, Andrij Abyzov <aabyzov@slb.com>,
        Johan Hovold <johan@kernel.org>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Claire Chang <tientzu@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Zhang Qilong <zhangqilong3@huawei.com>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Guenter Roeck <linux@roeck-us.net>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Al Cooper <alcooperx@gmail.com>, linux-serial@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH printk v1 00/10] printk: introduce atomic consoles and
 sync mode
Message-ID: <YS144PMiCJnmoKE4@google.com>
References: <20210803131301.5588-1-john.ogness@linutronix.de>
 <YQwHwT2wYM1dJfVk@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQwHwT2wYM1dJfVk@alley>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On (21/08/05 17:47), Petr Mladek wrote:
[..]
> 3. After introducing console kthread(s):
> 
> 	int printk(...)
> 	{
> 		vprintk_store();
> 		wake_consoles_via_irqwork();
> 	}
> 
> 	+ in panic:
> 
> 	    + with atomic console like after this patchset?
> 	    + without atomic consoles?
> 
> 	+ during early boot?

I guess I'd also add netconsole to the list.
