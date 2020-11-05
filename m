Return-Path: <SRS0=qe7h=EL=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A77C4741F
	for <linux-serial@archiver.kernel.org>; Thu,  5 Nov 2020 08:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0172221F8
	for <linux-serial@archiver.kernel.org>; Thu,  5 Nov 2020 08:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604566526;
	bh=VTqnKk1zzQ+IpPNJ8O7pmyP/AcNf1z5HtDcChbZssdQ=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=Tu4nhUbrVnV2hTkCqE6Isn8N329JD0mTQKl7r75ZX7lDF2Z7iDL1LvPRvrL5cXfbO
	 sm60Ze1jEbGyFdgRyi4KWMK0iwRDgtK/0jZue22iIcVCQ+vDq6JwjtTIBISUp7fh9c
	 xUE6sAN7vL70f3SDO+tGqNEMSFkpJMk3uSRrQ+QQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729977AbgKEIz0 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 5 Nov 2020 03:55:26 -0500
Received: from mail-ej1-f65.google.com ([209.85.218.65]:43360 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgKEIz0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 5 Nov 2020 03:55:26 -0500
Received: by mail-ej1-f65.google.com with SMTP id k3so1452312ejj.10;
        Thu, 05 Nov 2020 00:55:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GGv1/NsFYMq8a8x8p1Q5v+BEw3Nc7uWhGOg4cbDcIXA=;
        b=adR9/VMoQntunKG+BhwmxlUA4fLk7F611U5Vw2l/d4ynCME0fdgIvE/EgE8K+4KZaf
         iVvpp7aiaJjj49LGlfXDLiCBdvKZjup9thCgKBTPaSBJL1N/Qou46nTaUI+Yh/8qPlzf
         0pJwqxCU9sWEgpj9g3Awe0CbDr/V/fcNR0yzWygwFjl03GAWfA02L8LZnYeC+73Zpixm
         KeBPigwNNLSBT1+8tlTX7sveEyZ0P4vtcIM83OMF8/wbuBri+ON43ns6MmL5iy3fSs+P
         uL8OXaWz5Q/Thu09t1QHkfvQH8X1KyGKsfCUUxtqN4bji0lS2rXfkiNg7EiIUa4XDx0z
         fCig==
X-Gm-Message-State: AOAM530K5+8YNWyLkAX+b/VpnKIBv6AJZP06BB3pgfyN3qwhR8jsNZYS
        sk3mlcwsyqjFYW3jlvExceT4HH/j4WA=
X-Google-Smtp-Source: ABdhPJwlV6BHk/ukWXn9K8mMtuqyPYhxriyIPdn8c/NN7zuf0Gv4HEl392plPlhi70fVhuuDI3r/kg==
X-Received: by 2002:a17:906:c43:: with SMTP id t3mr1234400ejf.219.1604566523454;
        Thu, 05 Nov 2020 00:55:23 -0800 (PST)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id b12sm492530edn.86.2020.11.05.00.55.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 00:55:22 -0800 (PST)
Subject: Re: [PATCH 34/36] tty: serial: pmac_zilog: Make disposable variable
 __always_unused
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>, linux-serial@vger.kernel.org
References: <20201104193549.4026187-1-lee.jones@linaro.org>
 <20201104193549.4026187-35-lee.jones@linaro.org>
 <445a6440-b4c8-4536-891b-0cefc78e5f57@csgroup.eu>
 <e027b620-56f8-7d8b-84ff-54839f94a4c7@kernel.org>
 <20201105083626.GW4488@dell>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <a6b63789-1315-cec1-9575-0d858a6da1d5@kernel.org>
Date:   Thu, 5 Nov 2020 09:55:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <20201105083626.GW4488@dell>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 05. 11. 20, 9:36, Lee Jones wrote:
> On Thu, 05 Nov 2020, Jiri Slaby wrote:
> 
>> On 05. 11. 20, 8:04, Christophe Leroy wrote:
>>>
>>>
>>> Le 04/11/2020 à 20:35, Lee Jones a écrit :
>>>> Fixes the following W=1 kernel build warning(s):
>>>>
>>>>    drivers/tty/serial/pmac_zilog.h:365:58: warning: variable
>>>> ‘garbage’ set but not used [-Wunused-but-set-variable]
>>>
>>> Explain how you are fixing this warning.
>>>
>>> Setting  __always_unused is usually not the good solution for fixing
>>> this warning, but here I guess this is likely the good solution. But it
>>> should be explained why.
> 
> There are normally 3 ways to fix this warning;
> 
>   - Start using/checking the variable/result
>   - Remove the variable
>   - Mark it as __{always,maybe}_unused
> 
> The later just tells the compiler that not checking the resultant
> value is intentional.  There are some functions (as Jiri mentions
> below) which are marked as '__must_check' which *require* a dummy
> (garbage) variable to be used.
> 
>> Or, why is the "garbage =" needed in the first place? read_zsdata is not
>> defined with __warn_unused_result__.
> 
> I used '__always_used' here for fear of breaking something.
> 
> However, if it's safe to remove it, then all the better.

Yes please -- this "garbage" is one of the examples of volatile misuses. 
If readb didn't work on volatile pointer, marking the return variable as 
volatile wouldn't save it.

>> And even if it was, would (void)!read_zsdata(port) fix it?
> 
> That's hideous. :D

Sure, marking reads as must_check would be insane.

> *Much* better to just use '__always_used' in that use-case.

Then using a dummy variable to fool must_check must mean must_check is 
used incorrectly, no :)? But there are always exceptions…

thanks,
-- 
js
suse labs
