Return-Path: <SRS0=XS4C=B5=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B2BC433DF
	for <linux-serial@archiver.kernel.org>; Wed, 19 Aug 2020 01:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34F912067C
	for <linux-serial@archiver.kernel.org>; Wed, 19 Aug 2020 01:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGNEsJ/v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgHSBwO (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 18 Aug 2020 21:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbgHSBwN (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 18 Aug 2020 21:52:13 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B6FC061389;
        Tue, 18 Aug 2020 18:52:13 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id i92so460045pje.0;
        Tue, 18 Aug 2020 18:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OpYNdJDWzCST/R1je/Em9I1MvhpnltYoed5u0cht/Co=;
        b=fGNEsJ/vyLjCqPWImEz2G9E827M++jeZ3faMUhrGrGe5445m9NMJEXrHxLndOZLEUw
         U65X/NHBiqHJkCN3JRiWglfCqJjjOEZ8+4HK3e08pVxd4UvGioqOma+bnbHer5L8PPUf
         cVInSJxa6eIu9wGmTvP7itJ57JjmyTAkar/rPdEJvssCUCE7McJ12qh2GRY4KUX3s5Px
         4EClSE+V7i2vwg9RFbniStCgDKq46YH6PZVIUnzYZL4+FLrwiDMYrTPfZV+4NmPiPduB
         i+4F1JgCRM6Lp4HTGgCLBtBIIyd9K0XhD7kzt0/brvD4oV/xjOG4InSyHkctAnUxQtyt
         G4QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OpYNdJDWzCST/R1je/Em9I1MvhpnltYoed5u0cht/Co=;
        b=sn1X6xhlR5Q3MYUeYUOB7qEBMCYwyCsBPXzCS3PLf0FwD+ElS1ZDuSO8vIMEfY4MCK
         GeNj2BoENxlJIMB+sawLpgxfflViaGHpeSoSh2hlmengsaRatBlXANrGMH4Y7KX2PgFi
         kTLi/OyU6J71hMkoIda4HFKmxAKzrd/clRA3VoJdtZuV46mGi6G8zZXaVYDAZjbviKc8
         Olj098IVhN0PN0ZwkADQ735rnMUQQKbAzh5SbJBK4azOlHjLcKWW+l5xGgy4J1FkTwJ4
         u5/yM9z/vxV13ERgE3j4yswk/OFhwevfAvK8oUmBW1RBUgjSSraBtty6weeAm7D/J6Sf
         F/TQ==
X-Gm-Message-State: AOAM533NQvDLLRqL+C/2gamTMYrqs/daeSDs8RSNua42TY8Depk9K6Y0
        tPI1nCxEAadlQ/C6a5T7FlM=
X-Google-Smtp-Source: ABdhPJz//0HBha2vm5s2Cw1pbLA+U65g0nyXnDZNQHC6jQa1+qBw7OY89ILPyD/oZc5WnN5GyXf5rw==
X-Received: by 2002:a17:90a:6f85:: with SMTP id e5mr2157074pjk.128.1597801931409;
        Tue, 18 Aug 2020 18:52:11 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id i1sm26492162pfo.212.2020.08.18.18.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 18:52:10 -0700 (PDT)
Date:   Wed, 19 Aug 2020 10:52:09 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Tony Lindgren <tony@atomide.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Raul Rangel <rrangel@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH] uart:8250: change lock order in serial8250_do_startup()
Message-ID: <20200819015209.GA3302@jagdpanzerIV.localdomain>
References: <20200814013802.357412-1-sergey.senozhatsky@gmail.com>
 <20200814095928.GK1891694@smile.fi.intel.com>
 <20200818125218.GC17612@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818125218.GC17612@alley>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On (20/08/18 14:52), Petr Mladek wrote:
> > I guess we may add some tags here
> > 
> > Fixes: 768aec0b5bcc ("serial: 8250: fix shared interrupts issues with SMP and RT kernels")
> > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > Reported-by: Raul Rangel <rrangel@google.com>
> > BugLink: https://bugs.chromium.org/p/chromium/issues/detail?id=1114800
> > Link: https://lore.kernel.org/lkml/CAHQZ30BnfX+gxjPm1DUd5psOTqbyDh4EJE=2=VAMW_VDafctkA@mail.gmail.com/T/#u
> 
> "Link:" tag should point to the mail that is applied using git am.
> I am not sure if there is a tag for related discussion in another
> mail threads.

Yes, that's a good point. I wonder if we can slightly change that
rule. That link points to a thread where we discussed various
approaches to the problem, what would work, what wouldn't and why;
there is some valuable feedback there. The "8250-fix-locks-v2.patch"
link, on the other hand, points to nothing valuable.

> Sounds reasonable to me.
> 
> Andy proposed many changes. Sergey, could you please send v2?

Sure, I think I sent v2 already.

	-ss
