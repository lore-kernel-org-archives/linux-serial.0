Return-Path: <SRS0=K9fp=4L=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8773C35671
	for <linux-serial@archiver.kernel.org>; Sun, 23 Feb 2020 12:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BC2720656
	for <linux-serial@archiver.kernel.org>; Sun, 23 Feb 2020 12:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Ra/xiyzp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgBWMKa (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 23 Feb 2020 07:10:30 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41927 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgBWMKa (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 23 Feb 2020 07:10:30 -0500
Received: by mail-ed1-f66.google.com with SMTP id c26so8428221eds.8
        for <linux-serial@vger.kernel.org>; Sun, 23 Feb 2020 04:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cV9GjFprkx5E+1tvh5117LArIb5v3xn1vwpYjJGKOo0=;
        b=Ra/xiyzpCPj28cQwon38F3i34wQN0plYY8gbU83lAC61Yq1MnThyuJ09Xvu5hhzAth
         WBZQ1rjdDWipPC33/p8+/xLuTiojUwTPBt3oQUi9mz85susjzHV6RsLIsHjzvva6YY6O
         A5vLC7gLx1vH7ToJF5W+DaQF/eb6CVUkbvKYC11GoNMVDBP3ipv4ntSJcg2kyBh2LcWC
         CW2k2VgZME7ppRCAJUXyZM7NlR3O9RfPKOeuoUv5jXJjS7AUhHE/0rNWAF1JS/4OG2Yz
         vl7Ct90tdD81Eom0MHWXk9rpyGNC7lgWlQif5AhWxA/maOQJpqduz5MCVFEIgt0XGX6K
         yFvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cV9GjFprkx5E+1tvh5117LArIb5v3xn1vwpYjJGKOo0=;
        b=jCuryKwgW2gnNMGz/CF5FTWr0bQUhK/bCaiBeEHFmcXdPj459mOT8mPsJtKc0eYAVP
         QOn3A74qxa/ZJQYF+BFE9erPwdNIAP7mpam/QsvFWCKw4GvwmGd8ZXuIu/M1VWUsu4wZ
         cMSAU4BF0ythyxHHHA26QEqf+xrva2IidOj1yxHf5qkndV7/ZF6POjpMaAZqccuQ7NB8
         eHV37SzsEBCsek5mW0D2rGIhF8/iQa8AxChRgK5bWhHd3JW+IB5HIHZuAdDx/LfsbOav
         0ec0QNdw3hiw5KmhHkJ0Qz5QHlMUPo6s9+VdXH/OoJ27Qp732SavkuEnIDvsHdpsErU0
         mlyw==
X-Gm-Message-State: APjAAAVqVUcTzXIFMEKhXbufjV+9CK1Z1s191vqSvBU4cwXkZQJxGf2F
        aKRLV1JZHGKKorVFZMLUajn9Kg==
X-Google-Smtp-Source: APXvYqx8lLXn7cqqR0bYOZYmgpBpKi/9KGwso3Nkcit3DnBx58J6Qyr8fWLSZcFMK7GB3e48selV5w==
X-Received: by 2002:a17:906:1117:: with SMTP id h23mr43290636eja.88.1582459828548;
        Sun, 23 Feb 2020 04:10:28 -0800 (PST)
Received: from ?IPv6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id l22sm659207ejq.25.2020.02.23.04.10.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Feb 2020 04:10:28 -0800 (PST)
Subject: Re: [PATCHv2-next 1/3] sysctl/sysrq: Remove __sysrq_enabled copy
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Iurii Zaikin <yzaikin@google.com>,
        Jiri Slaby <jslaby@suse.com>, Joe Perches <joe@perches.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org
References: <20200114171912.261787-1-dima@arista.com>
 <20200114171912.261787-2-dima@arista.com>
 <20200115123601.GA3461986@kroah.com>
 <eef8e82a-c254-9391-506b-c9de8e52ee0f@arista.com>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <9ce5cadb-5e00-a9cf-c22d-92f077141efa@arista.com>
Date:   Sun, 23 Feb 2020 12:10:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <eef8e82a-c254-9391-506b-c9de8e52ee0f@arista.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 2/23/20 12:08 PM, Dmitry Safonov wrote:
> 
> On 1/15/20 12:36 PM, Greg Kroah-Hartman wrote:
>> On Tue, Jan 14, 2020 at 05:19:10PM +0000, Dmitry Safonov wrote:
> [..]
>>> +int sysrq_get_mask(void)
>>> +{
>>> +	if (sysrq_always_enabled)
>>> +		return 1;
>>> +	return sysrq_enabled;
>>> +}
>>
>> Naming is hard.  And this name is really hard to understand.
> 
> Agree.
> 
> 
>> Traditionally get/put are used for incrementing reference counts.  You
>> don't have a sysrq_put_mask() call, right?  :)
> 
> Yes, fair point
> 
> 
>> I think what you want this function to do is, "is sysrq enabled right
>> now" (hint, it's a global function, add kernel-doc to it so we know what
>> it does...).  If so, it should maybe be something like:
>>
>> 	bool sysrq_is_enabled(void);
>>
>> which to me makes more sense.
> 
> Err, not exactly: there is a function for that which is sysrq_on().
> But for sysctl the value of the mask (or 1 for always_enabled) is
> actually needed to show a proper value back to the userspace reader.

I'll call it sysrq_mask(), add the kernel-doc to it in v3.

Thanks again,
          Dmitry
