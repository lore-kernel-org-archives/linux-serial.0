Return-Path: <SRS0=xWBg=BY=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0EF9C433E1
	for <linux-serial@archiver.kernel.org>; Fri, 14 Aug 2020 01:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B5DB20771
	for <linux-serial@archiver.kernel.org>; Fri, 14 Aug 2020 01:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRaW7s6n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgHNBjv (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 13 Aug 2020 21:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbgHNBju (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 13 Aug 2020 21:39:50 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA416C061757;
        Thu, 13 Aug 2020 18:39:50 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id r4so3475846pls.2;
        Thu, 13 Aug 2020 18:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ucwMhSrbSIS+geFiJPFbLh/10bUBQsiRpXGuHS0d2Ek=;
        b=gRaW7s6nWoOflNE02kTZswBl5Fv3jtAsfVWJyLQyFIq29U7UbYOV3oUUY5EbK6y/hX
         snUTTWEJ3BTy9lhmwyrvckJClhEO55aCN3uOod3x1PWoE+xhtdPe++S7zrWiofhP9B29
         RYRoB9fPhT7Kz+HD22Mllss/9YYVwWq5Ko/2Almanz74VKxbEdVwkaahWWu45snG78wm
         IkdnkcAOSEMDMGJYwy7GI6HmIkRfchrKw2KZW5Y9DVhl19vNqMduyoDPn0rt+pgNNDdc
         p5sA7UtO4miy3p/rWwYEnyubHaeXTMeeiOMujqiTiRDjsvVK1N4S+2f05QcGcQOPhVC1
         bAgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ucwMhSrbSIS+geFiJPFbLh/10bUBQsiRpXGuHS0d2Ek=;
        b=Lb04Ezv1+clx6DNkhjLUHowOj4K0OVFu4N6Xh9Hv3rWbuu5t6xsaoD0z2MPSm0EuiD
         ILmSKvLzxmu3hqicj07JB+gDMBDfzFNRu3UQ9OFsP0uFuECxu8/mNmz362vYU4AImF2x
         PKN6zbdvWk431mLuoCmcL2Ka7ISxfdk9Pngrkhw7VyEJOwL0VlHf2dO+tJtxtySYqoKx
         /4qRaroDJ6cFVaJBEd1h2SQpnUT8pUvCCL9RAo4XWas+5DDxmwR/ovCXRIDsXS8gOYTz
         GwWsdE7w1broc6+0tNGAr8yf92boulkqOfSBtgO9rVZL1hIuTGhQjk+HRozFuR9lf6Xb
         nAaA==
X-Gm-Message-State: AOAM533vwta1Lu/eYTobGW4hPfCSj8d3LJc8O8Ghk23HETghQM6AGQ6/
        8XqdkAzLj63S5si8MMW5nAc=
X-Google-Smtp-Source: ABdhPJxHemgMxApjKK6EZW0+jIi/iIgDCvbWbdKO+NVvljwfhmqcOFUjD5pxlm5zMpX00z1i5pOjWg==
X-Received: by 2002:a17:902:aa4c:: with SMTP id c12mr403702plr.237.1597369190464;
        Thu, 13 Aug 2020 18:39:50 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id fv21sm6202032pjb.16.2020.08.13.18.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 18:39:49 -0700 (PDT)
Date:   Fri, 14 Aug 2020 10:39:48 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        John Ogness <john.ogness@linutronix.de>, kurt@linutronix.de,
        Raul Rangel <rrangel@google.com>,
        "S, Shirish" <Shirish.S@amd.com>
Subject: Re: Recursive/circular locking in
 serial8250_console_write/serial8250_do_startup
Message-ID: <20200814013948.GA356684@jagdpanzerIV.localdomain>
References: <20200812154813.GA46894@roeck-us.net>
 <20200813050629.GA95559@roeck-us.net>
 <20200813115948.GA3854926@kroah.com>
 <20200813142022.GY1891694@smile.fi.intel.com>
 <c9421d8a-7a2b-23ce-61f5-41f2136cf228@roeck-us.net>
 <e78b85b6-3134-290e-88e2-f1d6e88f0db0@roeck-us.net>
 <20200813180013.GZ1891694@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813180013.GZ1891694@smile.fi.intel.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Andy,

On (20/08/13 21:00), Andy Shevchenko wrote:
> That's basically what Sergey (IIRC) proposed in [1].
> (You missed enable_irq() part in above)
> 
> I guess we may try it. Sergey, can you submit a formal patch?

OK, let me try.

	-ss
