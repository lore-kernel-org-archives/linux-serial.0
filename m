Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C390BC433DB
	for <linux-serial@archiver.kernel.org>; Fri, 22 Jan 2021 07:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B3C82376F
	for <linux-serial@archiver.kernel.org>; Fri, 22 Jan 2021 07:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbhAVHeX (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 22 Jan 2021 02:34:23 -0500
Received: from mail-ej1-f53.google.com ([209.85.218.53]:36376 "EHLO
        mail-ej1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbhAVHeR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 22 Jan 2021 02:34:17 -0500
Received: by mail-ej1-f53.google.com with SMTP id l9so6293299ejx.3;
        Thu, 21 Jan 2021 23:34:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8GnE4lhfjc87s2oS1RIzXbqjLKjhcRxng05mH9niVa0=;
        b=mJHIsAq/zwMKfOe4QWWIaDZBUce2glnXeLdR0BQECkxRPfA2PvhPuPP7LeischyKi6
         A1NzSgGRq5UTiw82LUhpbiHgiA/FpkamWofn5nwOf3Z8tT46HsBcgPRmmDMgQFo2FuX/
         la9ykRkbv9l50rXr49sK2ctwM9+9ARZwfPQdXSS10gSvOrInl95CCRuJaj9Fo6mxkkvA
         XouyfvYRcvJ312NN7VdbBeLNykzJsE6P8JIGdT54o6C1gySCrIjt6kn8KFpgTttNFlnr
         UI7h9x4Uui+SxRt5jFIWKlG4QAnlbyh4W5N1VCyOLzck0n+W7jNAkN7rNXByNQP5S8Fm
         GMCg==
X-Gm-Message-State: AOAM530NcoECCshadgLSt6ViRNtHlUarcl6HlG0nyG1+dGKFzE9+WuDd
        GTSGBF04XR3o/PQAqVk8IJI=
X-Google-Smtp-Source: ABdhPJzITfJf+ftWJ7SS5BLgVuhhaFCtTpYTjGejyemIaxHG+4fvzWBbnU9tX83Vd4NI3hMaKJHJrA==
X-Received: by 2002:a17:906:2ccb:: with SMTP id r11mr2138635ejr.39.1611300815665;
        Thu, 21 Jan 2021 23:33:35 -0800 (PST)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id x25sm4541261edv.65.2021.01.21.23.33.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jan 2021 23:33:34 -0800 (PST)
Subject: Re: [PATCH 1/6] tty: implement write_iter
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oliver Giles <ohw.giles@gmail.com>,
        Robert Karszniewicz <r.karszniewicz@phytec.de>
References: <20210121090020.3147058-1-gregkh@linuxfoundation.org>
 <f4c72a0a-25e6-5c7a-559b-6d3b7c930100@kernel.org>
 <CAHk-=whE3fmgWx+aNvC6qkNqJtWPre3dVnv-_qYj7GaWnW72Vg@mail.gmail.com>
 <YAnAfNcE8Bw95+SV@kroah.com>
 <CAHk-=wh+-rGsa=xruEWdg_fJViFG8rN9bpLrfLz=_yBYh2tBhA@mail.gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <4ade6b19-dc9e-ef72-dcca-1ddaa8d6c5fd@kernel.org>
Date:   Fri, 22 Jan 2021 08:33:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wh+-rGsa=xruEWdg_fJViFG8rN9bpLrfLz=_yBYh2tBhA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 21. 01. 21, 19:42, Linus Torvalds wrote:
> On Thu, Jan 21, 2021 at 9:57 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>>
>> Incremental patches please as these are already in my public branches
>> and I would have to revert them and add new ones but that's messy, so
>> fixes on top is fine.
> 
> Ok. And since I think you put that first tty_write conversion patch in
> a different branch from the tty_read one, I did the fixup patches for
> the two as separate patches, even though they really just do the exact
> same thing.
> 
> So here's three patches: the two fixups for the hung_up_tty case, and
> the EOVERFLOW error case that Jiri also noted. I've also updated the
> 'tty-splice' branch if you prefer them that way.
> 
> And I *should* say that I still haven't tested _any_ of the HDLC
> changes. I have no idea how to do that, and if somebody can point to a
> test-case (or better yet, actually has a real life situation where
> they use it and can test this all) it would be great.
> 
> Jiri, any other issues, or any comment of yours I missed? I didn't do
> the min() thing, I find the explicit conditional more legible myself,
> but won't complain if somebody else then disagrees and wants to clean
> it up.

I cannot find anything else.

All three:
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

thanks,
-- 
js
