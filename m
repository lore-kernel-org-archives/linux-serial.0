Return-Path: <SRS0=nVIq=DB=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7E3C4363D
	for <linux-serial@archiver.kernel.org>; Thu, 24 Sep 2020 18:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC3632220C
	for <linux-serial@archiver.kernel.org>; Thu, 24 Sep 2020 18:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLtAOzU3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbgIXSQb (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 24 Sep 2020 14:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbgIXSQa (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 24 Sep 2020 14:16:30 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44FAC0613CE;
        Thu, 24 Sep 2020 11:16:30 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id q13so48869ejo.9;
        Thu, 24 Sep 2020 11:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mGESpiEzOKa7JWPfKFIYfSED5VO+75GF96iPVXfF+Kg=;
        b=CLtAOzU3BgNVNu1gojyqGBjQuq22IQDYzDfs6JdPNWAI/JWqWACEEVHXCFoVobuDB4
         AtIHhxoCp0HZWF41RVl1DaeVlSSdBzBoVGadW4q0ygM1JZe4xJv/zSrNTqQ21hvzyEC7
         yes1jegUSzrOweYSowYYuKokTioATcLirmvjEGruRxzibd0cRuUkc6UPEiEc9tCKUBIN
         4PFqv50TSean5yzLkjbQJMgHXtZt0ns/AHM/DE9paUbKrUi5yw/9remsJ5+efqhv+S2R
         gGI75iE3Xq7iaBZsnIC3QbSz06KPSUVOl1MrZ902U9tnCE4aGn7ywlx7xNAK+qnx7g+N
         YILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mGESpiEzOKa7JWPfKFIYfSED5VO+75GF96iPVXfF+Kg=;
        b=WXYVQD4rK9SZpPO1Bg6WsGiAXBMljgU7xbYt54RqNRuh2hbiJTKxHYDqjrucEbfIee
         0PXRJBJvk9F2Wr0I9HU0Y48kThzl0fazVEnZu/gL0RpsSa+1hCEgGj88AOfgxfbV0s+o
         OeP0c1J4oqlWgi+S6h8J2epEz96JQ7E1zkAFLgxGqGSvrhcNvIzNmCmDSsDo6tuK9FUH
         GVX8OPTxmm0L+TeRrfSA7fvfAM68O7SSXWgcBZeEccwrZNL7U7k1OZl82A27XxbM8J/7
         Ks01o9apy/U+mZ5HJALIeTCsSKwUUmAWZ5oyOe7O12U+nVi8yPxEwN4GdoBMiUpvSLWj
         7htg==
X-Gm-Message-State: AOAM530ZJ2fw/zmUu6tnT1tNlu6FhGYhHcVQC64W+OrOxh7gjC0SwFmN
        Ev2uk528CpFsVFoGL8NHfDs=
X-Google-Smtp-Source: ABdhPJyToUdtjxrnM4oq3+PfWhcDBfZgX94hmno4D6/N5nYaEY/A6ZxOkj45D8DRKqwtiPYQfE2bhw==
X-Received: by 2002:a17:906:8508:: with SMTP id i8mr1278315ejx.390.1600971389341;
        Thu, 24 Sep 2020 11:16:29 -0700 (PDT)
Received: from [192.168.2.202] (pd9e5a9d2.dip0.t-ipconnect.de. [217.229.169.210])
        by smtp.gmail.com with ESMTPSA id j18sm3147882edj.62.2020.09.24.11.16.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2020 11:16:28 -0700 (PDT)
Subject: Re: [RFC PATCH 1/9] misc: Add Surface Aggregator subsystem
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?Q?Bla=c5=be_Hrastnik?= <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>
References: <20200923151511.3842150-1-luzmaximilian@gmail.com>
 <20200923151511.3842150-2-luzmaximilian@gmail.com>
 <20200923165745.GA3732240@kroah.com>
 <de24d687-62c2-1f34-cac2-d32246c68a09@gmail.com>
 <20200924064838.GB593984@kroah.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <3a139bc4-3f47-6af9-ad47-effb4b00ac85@gmail.com>
Date:   Thu, 24 Sep 2020 20:16:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200924064838.GB593984@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 9/24/20 8:48 AM, Greg Kroah-Hartman wrote:
> On Wed, Sep 23, 2020 at 10:34:23PM +0200, Maximilian Luz wrote:
>> In short: Concurrent execution of the counter functions works, as far as
>> I can tell at least, and, as you see by the long answer, I have to spend
>> some time and think about the duplicate-value problem (again). If you've
>> managed to read through this wall of text (sorry about that) and you
>> have any ideas/preferences, please let me know.
> 
> No, this all answers my question really well, thanks, what you have now
> is fine, no need to change it.

Okay, thank you again!

Regards,
Max
