Return-Path: <SRS0=mq3J=B4=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73455C433DF
	for <linux-serial@archiver.kernel.org>; Tue, 18 Aug 2020 10:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4387B20789
	for <linux-serial@archiver.kernel.org>; Tue, 18 Aug 2020 10:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597745694;
	bh=+Zqyns5fr5aleNLaiK0QWLzKFW+r1zhmB2qJtDw8x+4=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=cU4LRMcrG1E2xT292Hk555iH4aWQZ5a7dv9uU9g6ENxkQ0XkR/PN+odHt0DlN9Ga3
	 JOxL72NjvFsY/+6LTqEUvEehQMR+sqz0bJTEMQLvumx8bmDdEWuypWl+ZqVmy5dEGf
	 pVwMMZgi3YmXBC6Fo9iEr39ewXmAxTMN3KWrgm8M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbgHRKOx (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 18 Aug 2020 06:14:53 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:42303 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgHRKOx (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 18 Aug 2020 06:14:53 -0400
Received: by mail-ej1-f66.google.com with SMTP id g19so21373763ejc.9;
        Tue, 18 Aug 2020 03:14:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Qo0ZTyLHdSH3DqbADOB/G5DPbn8Ln+pQn6AyzMnKExE=;
        b=C4wbBgck08Y23yEuJiDg8eDtTMh0gFydusRMknkqwm+rVDwd+gZf9RyPcRqTI+wzp1
         CnTYXfdPJO4J0yKWalslbF429uv3zIDgl0hq2rx1Kv1i1S+5No9DTIOTWVsRPU/haufg
         njLoEmO1o+fgMruQyQxxDBq64Da5yl9105pRKhkrOth0BuNEwThyiPLO+3a8YrwGIZbD
         jVW3cbpq770sjT8xop7lDcxAewQMj2+rvDSEmq1mlglB4CVMXnd4uN5ihQvZzCWoBbck
         hAhgVuYfFcvnvCGReumAzDEOvfa7p6qArHmKEyoaynoKrT0wttSMBmxwDz22KfRRN0/D
         7yiw==
X-Gm-Message-State: AOAM533jPk7DXWerDTefSqBSiFojYFrBS4qorvCsfkXT+o4btQTzNohy
        jAHkVYwSNumOxxUOnrgT4fvFdQP5Cf4=
X-Google-Smtp-Source: ABdhPJwyO865jEMhSti2UMkbE56po+m1jE40HYn/02VzLOJCJQ6zgCjXoUr6J3B5U8PPZUM5ohpIYQ==
X-Received: by 2002:a17:906:d181:: with SMTP id c1mr18866183ejz.181.1597745691178;
        Tue, 18 Aug 2020 03:14:51 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id j5sm15992236ejk.87.2020.08.18.03.14.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 03:14:50 -0700 (PDT)
Subject: Re: [PATCH] n_gsm: Fix write handling for zero bytes written
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20200817135454.28505-1-tony@atomide.com>
 <1b8538a8-d8b6-4287-36e1-aa1e0863ff2d@kernel.org>
 <20200818095609.GQ2994@atomide.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <ea5e0639-4419-c60b-059a-8fbd057fc6e3@kernel.org>
Date:   Tue, 18 Aug 2020 12:14:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200818095609.GQ2994@atomide.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 18. 08. 20, 11:56, Tony Lindgren wrote:
> Hi,
> 
> * Jiri Slaby <jirislaby@kernel.org> [200818 08:24]:
>> On 17. 08. 20, 15:54, Tony Lindgren wrote:
>>> If write returns zero we currently end up removing the message
>>> from the queue. Instead of removing the message, we want to just
>>> break out of the loop just like we already do for error codes.
>>
>> When exactly does the only writer (gsmld_output) return zero for
>> non-zero len parameter?
> 
> I ran into this when testing with the WIP serial core PM runtime
> changes from Andy Shevchenko earlier. If there are also other
> cases where we have serial drivers return 0, I don't know about
> them.

Sorry, I don't understand: my gsmld_output() ignores the return value
from drivers' write and returns something greater than zero or a
negative error. What tree/SHA do you run?

> Basically with the WIP serial core changes, if the open serial port
> is in PM runtime suspended state with it's autosuspend_delay_ms
> expired, we have write return 0 and just wake up the serial device
> on TX.


-- 
js
