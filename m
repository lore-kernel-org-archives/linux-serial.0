Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA85C433F5
	for <linux-serial@archiver.kernel.org>; Sat,  6 Nov 2021 20:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5E5B610FD
	for <linux-serial@archiver.kernel.org>; Sat,  6 Nov 2021 20:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235073AbhKFUvP (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 6 Nov 2021 16:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhKFUvO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 6 Nov 2021 16:51:14 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B981C061570;
        Sat,  6 Nov 2021 13:48:33 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id x27so26364131lfu.5;
        Sat, 06 Nov 2021 13:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=VAeOOd6OoG8jIe4twgz7nyq7hcVLOkrGdKItQvlZdwg=;
        b=K6SCRMoR9I6/EMP+kOdrRYbG2L6ciumqh0qEVBwQ6s64fYA5B+SZDadfVS5k60u+9a
         dJvZSccPGbnTl7nXfS9jROKhM4Zv+GUILLAXxoevkZXiBY6KGAFdoecG9FjVtWqEDZAM
         4oghynGPi7S5beX5byO5z327smC7f4Spjq4oUlJWBV7T5P8ihMPQqcV05vZZWHTCp5+u
         nWy6OzBb5kiNU4R02NLnUtL6oF3imqGu5LbiK9zddWsddu17jd8x/0JpFMDZpGAiZI4H
         Y4Pzd0NyaFxE2sbqVfIb/u8poY2xP4EV2patorNXSzlqX3OUQEHgfLbJPCPsbJBqM2Vz
         N/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VAeOOd6OoG8jIe4twgz7nyq7hcVLOkrGdKItQvlZdwg=;
        b=lo31dzBD7ycg5K854Zjaar8apobrpCJtmpcBO60ymvyKKL7pAaS4j6o2QOo1IZyrcY
         HYYzEg699yjEtT+Dk+Ds7EDl2QXjcGtl+OfFsGXUYMEV9AFvluXwIJA0eeX2O9n9GRql
         dQUGMvZQroythMgxB6pLFU4SfXfItrnxI29fEMtySJbq19QO9EMAs13lktx8X3qElRBe
         C7xZruJg6ljWgPqbuUJARdLln5IglIIbw1VjqJW0kQSNjE1vLaJbtNPTtMtfsaDjWH3I
         xBEfv5AP851hIOU6/0tpjl+W/eA+XkeqqMGW5zKmCw3VKbJG7IY07B3zCUb5Z6C/EGNs
         If9w==
X-Gm-Message-State: AOAM533I74emCuERv7Kfd8FOqOwncidHOkmEnU0k375MR8rA2OFhLmS+
        61gnPHMFzq+6xKSlf5Mbits=
X-Google-Smtp-Source: ABdhPJx5sXEct7WHiw/MExJvHFOIcQNFHhQS6099PidFbHk/2UwvrYJjfJcykjBqZym8mGo9sa+LSA==
X-Received: by 2002:ac2:4a89:: with SMTP id l9mr5405710lfp.679.1636231711339;
        Sat, 06 Nov 2021 13:48:31 -0700 (PDT)
Received: from [192.168.1.11] ([217.117.245.207])
        by smtp.gmail.com with ESMTPSA id c3sm594515lfb.122.2021.11.06.13.48.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Nov 2021 13:48:30 -0700 (PDT)
Message-ID: <65c45951-08ba-26bb-f96b-3d4442b1d4d4@gmail.com>
Date:   Sat, 6 Nov 2021 23:48:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] tty: vt: keyboard: do not copy an extra-byte in
 copy_to_user
Content-Language: en-US
To:     Ajay Garg <ajaygargnsit@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>, jirislaby@kernel.org,
        kernel@esmil.dk, David Laight <David.Laight@aculab.com>,
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
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <CAHP4M8XtFiAa1kF5A_rPbcui3DP8L6iyfP8GbwgLLzo0Bo+TNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 11/6/21 23:44, Ajay Garg wrote:
>> >
>> > That's the whole point of the discussion :)
>> >
>> > The method "vt_do_kdgkb_ioctl" does not manage "func_table[kb_func]".
>> > Thus, the method does not know whether or not
>> > strlen(func_table[kb_func]) < sizeof(user_kdgkb->kb_string).
>> >
>>
>> It manages. The code under `case KDSKBSENT:` sets func_table[] entries
>> via vt_kdskbsent().
>>
>> kbs = strndup_user(..., sizeof(user_kdgkb->kb_string));
>>
>> is used to allocate buffer for the func_table[] entry. That's my main
>> point :)
> 
> func_table is set in vt_kdskbent, which itself is external.
> 
> More importantly, vt_kdskbent is handled in case KDSKBSENT:, while the
> strlcpy issue we are dealing with is in case KDGKBSENT:
> In case KDGKBSENT, following are managed :
> 
>                  ssize_t len = sizeof(user_kdgkb->kb_string);
>                  kbs = kmalloc(len, GFP_KERNEL);
> 
> while func_table[kb_func] is external entity here, so no assumption
> ought to be made for it, just my 2 cents though :)
> 
> Anyhow, really, it is the maintainers' choice now :), since there
> isn't a burning (compilation/runtime) issue.
> 

I fully agree here, it's maintainer's choice. Let's sit down and wait 
what experienced people thing about this :)

I've just wanted to explain my idea better to exclude possible 
misunderstanding.

Thanks



With regards,
Pavel Skripkin
