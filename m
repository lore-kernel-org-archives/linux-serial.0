Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0ABC433EF
	for <linux-serial@archiver.kernel.org>; Wed, 10 Nov 2021 05:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F2BB60F6E
	for <linux-serial@archiver.kernel.org>; Wed, 10 Nov 2021 05:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbhKJFZM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 10 Nov 2021 00:25:12 -0500
Received: from mail-ed1-f42.google.com ([209.85.208.42]:35356 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhKJFZL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 10 Nov 2021 00:25:11 -0500
Received: by mail-ed1-f42.google.com with SMTP id g14so5744977edz.2;
        Tue, 09 Nov 2021 21:22:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=w5QVzIT0GU6il2AlxxvG2r90YxDxLvpX2DJ/AZiJHgI=;
        b=3RwFZBoErMgUojUfOW4GStx5Hq6mKhAaYsjUVisHJXkiPDHb2RfW9mkbUSmyXUNatM
         pd6SEw3Phn4mXFHelNobjwDTlG1dY+fZgItQ0sjDwjcdbRUevkzJgsVl2N4XdwsUSrGA
         hjFhPkMcS8McdkT+dOS2MducNrG3tyOz8JOKJqdDhwgx6s5wneqeIE61t6E87fDWgTsV
         mtQ3K9wVZQU+u06HKQj3tlnez+LgKpzuYPpjhfScgmvz1tNt3HwqdfEHWC9rTbuxN6v9
         jf3upbtN9exoeQSxakrCZtjyYFc4S2zu3ccb/psWapWNVWB/qjM8ko80X9zpCbs22rAK
         bI6w==
X-Gm-Message-State: AOAM530Gv4ZlJk/EifcfOpxP1lbAQnOjAhtkvjG+pWKOS/cwMPmWWt/0
        FiQAqamnTbPsdUKI7I283PI=
X-Google-Smtp-Source: ABdhPJy1yURuCTrsL/0yJ6ylr3cbtoXEOneXPYs8z3aaLjr6ug3ouOoM+GPuOU5L4KqjGiUEIe5j7w==
X-Received: by 2002:a50:e184:: with SMTP id k4mr17996997edl.217.1636521743295;
        Tue, 09 Nov 2021 21:22:23 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id a20sm10327102ejd.112.2021.11.09.21.22.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Nov 2021 21:22:22 -0800 (PST)
Message-ID: <08c9e717-4367-5316-87cd-90b5ceb13ed9@kernel.org>
Date:   Wed, 10 Nov 2021 06:22:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] tty: vt: keyboard: do not copy an extra-byte in
 copy_to_user
Content-Language: en-US
To:     Pavel Skripkin <paskripkin@gmail.com>,
        Ajay Garg <ajaygargnsit@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>, kernel@esmil.dk,
        David Laight <David.Laight@aculab.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20211106092041.43745-1-ajaygargnsit@gmail.com>
 <9eafae1f-d9f0-298d-cf20-212865d0becc@gmail.com>
 <868025b485b94480ad17d0ec971b3ee9@AcuMS.aculab.com>
 <CAHP4M8Ww0-VqCBKX=iLd=zy1AcDoNdzTOqJuaqRxCGZsMhoX9w@mail.gmail.com>
 <CAHP4M8UcZ=ttB8jbN1yOY6YH8SiQ27NhdEKi9SDH1CWG-GY6eg@mail.gmail.com>
 <6b58a3e1-f2ea-cc4c-03b2-06334b559373@gmail.com>
 <CAHP4M8Vs8a8u98enuHXaBcC7D4fCZzCOtEq06VnvuPUqhqPK=Q@mail.gmail.com>
 <9717b429-597f-7778-c880-94361bcdee7f@gmail.com>
 <CAHP4M8XtFiAa1kF5A_rPbcui3DP8L6iyfP8GbwgLLzo0Bo+TNQ@mail.gmail.com>
 <65c45951-08ba-26bb-f96b-3d4442b1d4d4@gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <65c45951-08ba-26bb-f96b-3d4442b1d4d4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 06. 11. 21, 21:48, Pavel Skripkin wrote:
> On 11/6/21 23:44, Ajay Garg wrote:
>>> >
>>> > That's the whole point of the discussion :)
>>> >
>>> > The method "vt_do_kdgkb_ioctl" does not manage "func_table[kb_func]".
>>> > Thus, the method does not know whether or not
>>> > strlen(func_table[kb_func]) < sizeof(user_kdgkb->kb_string).
>>> >
>>>
>>> It manages. The code under `case KDSKBSENT:` sets func_table[] entries
>>> via vt_kdskbsent().
>>>
>>> kbs = strndup_user(..., sizeof(user_kdgkb->kb_string));
>>>
>>> is used to allocate buffer for the func_table[] entry. That's my main
>>> point :)
>>
>> func_table is set in vt_kdskbent, which itself is external.
>>
>> More importantly, vt_kdskbent is handled in case KDSKBSENT:, while the
>> strlcpy issue we are dealing with is in case KDGKBSENT:
>> In case KDGKBSENT, following are managed :
>>
>>                  ssize_t len = sizeof(user_kdgkb->kb_string);
>>                  kbs = kmalloc(len, GFP_KERNEL);
>>
>> while func_table[kb_func] is external entity here, so no assumption
>> ought to be made for it, just my 2 cents though :)
>>
>> Anyhow, really, it is the maintainers' choice now :), since there
>> isn't a burning (compilation/runtime) issue.
>>
> 
> I fully agree here, it's maintainer's choice. Let's sit down and wait 
> what experienced people thing about this :)

I don't quite understand what the problem is. Provided I wrote the code, 
is there something wrong with this commit (and its explanation), in 
particular?

commit 6ca03f90527e499dd5e32d6522909e2ad390896b
Author: Jiri Slaby <jirislaby@kernel.org>
Date:   Mon Oct 19 10:55:16 2020 +0200

     vt: keyboard, simplify vt_kdgkbsent

     Use 'strlen' of the string, add one for NUL terminator and simply do
     'copy_to_user' instead of the explicit 'for' loop. This makes the
     KDGKBSENT case more compact.

     The only thing we need to take care about is NULL 'func_table[i]'. Use
     an empty string in that case.

     The original check for overflow could never trigger as the func_buf
     strings are always shorter or equal to 'struct kbsentry's.

thanks,
-- 
js
suse labs
