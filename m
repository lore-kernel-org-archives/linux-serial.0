Return-Path: <SRS0=sEmL=27=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AC8C282DD
	for <linux-serial@archiver.kernel.org>; Fri, 10 Jan 2020 21:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A88320842
	for <linux-serial@archiver.kernel.org>; Fri, 10 Jan 2020 21:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="fFk+ijjG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgAJVpp (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Jan 2020 16:45:45 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:32928 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbgAJVpo (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Jan 2020 16:45:44 -0500
Received: by mail-pg1-f195.google.com with SMTP id 6so1607179pgk.0
        for <linux-serial@vger.kernel.org>; Fri, 10 Jan 2020 13:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=85uBcaKJVYynn+Km3yZLrt2LABn/ujp4kH1tchf72pQ=;
        b=fFk+ijjG8oQy7LHiL7KQwoSUrPKToO3xGIfQktv7xCVRr50sD04tjZDR0VioAFl3mE
         2UvNLpoV/EQaPK8Tw6WgOPZbbBU89HmvvmmGkCkPrVtcWA6ZlnkyO2lFqW4vmq367U49
         kNrRqygH2oUX4SawAcIrPySvrA8TbliPHsgcBw0tIChmiwryBDq+EqZ4BKclRoSrYDhH
         +oYPiQ/6TmgYTA3EAP1+7vjvNkhj2k5F5bx4v9ReVyJJnqNmdIZzoZAl4QL4YT/mdanr
         Jwc9lwCptjwNXWa9qP3KOLSOq8QrEUAWTrbcKwny7SgVvmx2avkQt5RnZBI3zg/i+dEf
         UPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=85uBcaKJVYynn+Km3yZLrt2LABn/ujp4kH1tchf72pQ=;
        b=fqcTkCQg1PUAT/SZl/S7qCW5Z8OfTCkys1OIuylKDPmvCg+F/3ExzqzBpIYnOM7/3J
         8uU+I3llxC9wraOZnb+EFjp/xSjFw8VMsAvhDS6hDTLHbwDROZzWjpdmqLM0gitpv8Lf
         wZjadwQ33CcLkjGXLpIxfLd2wrrevkq6vPMAes+tS5RVCVemLNtXHHiSv3xvpUFElHQZ
         9GDkNjoDpfYNy/PNMu6aB5mp3LxfdX3fzGa00E//humVtK00YORDS5D1s0DfFqWkqKjx
         bHM20o3gvPQLVVLeM993tFotgQqslh+mPwPR3ofhXuohlZ/d/491MliC8yNiLk2DUdEG
         TC3Q==
X-Gm-Message-State: APjAAAU00ru7KEoGoUWV9zw1fGdVbK1WDLUxZGOoTFWfuIV7K7SG3k38
        F8QTwhOQfCZlZoVLfuvDHhx9fw==
X-Google-Smtp-Source: APXvYqxgE7a0uaAsLuTGuMgpdPUQxw+3dqFpxr4k4kTVVg1Wowt51riMR900Qq1pwViSA3TKwYiZVg==
X-Received: by 2002:a63:1101:: with SMTP id g1mr6656701pgl.435.1578692743701;
        Fri, 10 Jan 2020 13:45:43 -0800 (PST)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j2sm4059514pfi.22.2020.01.10.13.45.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2020 13:45:42 -0800 (PST)
Subject: Re: [PATCH-next 2/3] sysctl/sysrq: Remove __sysrq_enabled copy
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org, Iurii Zaikin <yzaikin@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org
References: <20200109215444.95995-1-dima@arista.com>
 <20200109215444.95995-3-dima@arista.com> <20200110164035.GA1822445@kroah.com>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <04436968-5e89-0286-81e5-61acbe583f73@arista.com>
Date:   Fri, 10 Jan 2020 21:45:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200110164035.GA1822445@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Greg,

On 1/10/20 4:40 PM, Greg Kroah-Hartman wrote:
> On Thu, Jan 09, 2020 at 09:54:43PM +0000, Dmitry Safonov wrote:
[..]
>> @@ -2844,6 +2827,26 @@ static int proc_dostring_coredump(struct ctl_table *table, int write,
>>  }
>>  #endif
>>  
>> +#ifdef CONFIG_MAGIC_SYSRQ
>> +static int sysrq_sysctl_handler(struct ctl_table *table, int write,
>> +				void __user *buffer, size_t *lenp, loff_t *ppos)
>> +{
>> +	int tmp, ret;
>> +
>> +	tmp = sysrq_get_mask();
>> +
>> +	ret = __do_proc_dointvec(&tmp, table, write, buffer,
>> +			       lenp, ppos, NULL, NULL);
>> +	if (ret || !write)
>> +		return ret;
>> +
>> +	if (write)
>> +		sysrq_toggle_support(tmp);
>> +
>> +	return 0;
>> +}
>> +#endif
> 
> Why did you move this function down here?  Can't it stay where it is and
> you can just fix the logic there?  Now you have two different #ifdef
> blocks intead of just one :(

Yeah, well __do_proc_dointvec() made me do it.

sysrq_sysctl_handler() declaration should be before ctl_table array of
sysctls, so I couldn't remove the forward-declaration.

So, I could forward-declare __do_proc_dointvec() instead, but looking at
the neighborhood, I decided to follow the file-style (there is a couple
of forward-declarations before the sysctl array, some under ifdefs).

I admit that the result is imperfect and can put __do_proc_dointvec()
definition before instead, no hard feelings.

Thanks,
          Dmitry
