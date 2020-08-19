Return-Path: <SRS0=XS4C=B5=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C43AC433E1
	for <linux-serial@archiver.kernel.org>; Wed, 19 Aug 2020 06:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 463DF20738
	for <linux-serial@archiver.kernel.org>; Wed, 19 Aug 2020 06:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597818004;
	bh=vl71KL+eGXR0jV2XwfQLzxUirijwxQjH7PY1V4bGlN8=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=BQE9uJ4e2L+5AVzpBOyjLtO2cRrrHhVI4Ir/AkMFVJdj9bya6uCD9IjbmyeMkg/rH
	 KwYPN6Maly0XKoVMOhkkF3itwhNKqk+ponSjabdGrDZMLjDDQc13WNfjtAxDWGe3/R
	 5gZeO3G/Muue0kBUbbd/ibojJAHdiyrbMIAdKE8k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgHSGUD (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 Aug 2020 02:20:03 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:36700 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgHSGUC (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 Aug 2020 02:20:02 -0400
Received: by mail-ej1-f66.google.com with SMTP id kq25so24901057ejb.3;
        Tue, 18 Aug 2020 23:20:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=el+F6G6X74vs681XhpTMhoN92meVVmppJ6dMHUb8u5s=;
        b=q9OKDBF5lfC70/MY76NGmsQKAhpbFkK3NweccqZhgUy2PfAxbmqfYKlWfv2TVEpgXx
         ZtuY8rBHCPPEWaPNJ1JqSPHRyPf9hlGpE5KDkEALG3/XA3bVdlfWUn4VVQZOGm4tWLmH
         utrJjls1quog+5NBDfA+VTn5SXCiuUapEt9ayscyCH3n9qBqtFQbTqKSl2RQGF6vqOG0
         RkLuGAPqCk9RIMcDVbAXCLJw2wZnN9kRLTb8rpg5b7Lx/ZKXXNMxm8YpzQPpbuDd6ccA
         5CpB+GMXaa88wHT/Z76YStqrrNmPgVIJcur7bEZKLx4rmBiG5RGZmsmtllrPQv86GD7m
         qn5w==
X-Gm-Message-State: AOAM530xJW+XEZanonCXPdbFKgUXJ1KnTrhhxiHO/yL7xRL+PD6BG0hF
        Z7UK/XkUdZNotjLvZtitUjX09oktFuY=
X-Google-Smtp-Source: ABdhPJxZRI+rHX1AL3hw80zpDQrRYPm0EuVAmVt4YL9021IB+bNagX7l7JaJOvbIX2gil9cAe9M8gA==
X-Received: by 2002:a17:906:858:: with SMTP id f24mr23152924ejd.543.1597818000880;
        Tue, 18 Aug 2020 23:20:00 -0700 (PDT)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id d2sm18214610ejm.19.2020.08.18.23.19.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 23:20:00 -0700 (PDT)
Subject: Re: [PATCH] n_gsm: Fix write handling for zero bytes written
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20200817135454.28505-1-tony@atomide.com>
 <1b8538a8-d8b6-4287-36e1-aa1e0863ff2d@kernel.org>
 <20200818095609.GQ2994@atomide.com>
 <ea5e0639-4419-c60b-059a-8fbd057fc6e3@kernel.org>
 <20200818104714.GR2994@atomide.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <34dd61d2-01c3-dcc1-21bd-494eb90759ac@kernel.org>
Date:   Wed, 19 Aug 2020 08:19:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200818104714.GR2994@atomide.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 18. 08. 20, 12:47, Tony Lindgren wrote:
> * Jiri Slaby <jirislaby@kernel.org> [200818 10:14]:
>> On 18. 08. 20, 11:56, Tony Lindgren wrote:
>>> Hi,
>>>
>>> * Jiri Slaby <jirislaby@kernel.org> [200818 08:24]:
>>>> On 17. 08. 20, 15:54, Tony Lindgren wrote:
>>>>> If write returns zero we currently end up removing the message
>>>>> from the queue. Instead of removing the message, we want to just
>>>>> break out of the loop just like we already do for error codes.
>>>>
>>>> When exactly does the only writer (gsmld_output) return zero for
>>>> non-zero len parameter?
>>>
>>> I ran into this when testing with the WIP serial core PM runtime
>>> changes from Andy Shevchenko earlier. If there are also other
>>> cases where we have serial drivers return 0, I don't know about
>>> them.
>>
>> Sorry, I don't understand: my gsmld_output() ignores the return value
>> from drivers' write and returns something greater than zero or a
>> negative error. What tree/SHA do you run?
> 
> Oh right, good catch. I also had my WIP serdev-ngsm patches applied
> that uses gsm_serdev_output() and returns the bytes written. Andy's
> patches do not touch n_gsm.c.
> 
> Hmm sounds like we should also start returning value also from
> gsmld_output()? Any objections to making that change?

No objections here.

thanks,
-- 
js
suse labs
