Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5D2C433F5
	for <linux-serial@archiver.kernel.org>; Sat,  6 Nov 2021 12:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A65F60F21
	for <linux-serial@archiver.kernel.org>; Sat,  6 Nov 2021 12:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbhKFMl5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 6 Nov 2021 08:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbhKFMl4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 6 Nov 2021 08:41:56 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AEADC061570;
        Sat,  6 Nov 2021 05:39:15 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id t11so19670402ljh.6;
        Sat, 06 Nov 2021 05:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ToP3NoMVqEdCFB5f1dKv6CexiYd/z15XIcMvxzn4MUA=;
        b=lou8HvFwK6Ofz4drZoaQryAtD3PThzvIYdt6umzZXa+sUi4ge9vHJxPwVkyWN9KOWc
         x5PywWC/DGqAaOJdE51YHj2AMGjkkESg5a1F5BmnXTYb04GKLf07udDKbCrx1ZcMyLUu
         FtRApnfwHXoiOwT57VMT8VkWfJCxYEFJOxKJZzcCUP35Y4Ji7mgQHp4c1sk3ZSWQ3UjE
         Q1LMNISpjBoT3YkFkBv9j7ALu+8LF9FR9HPMXfJjTGFjIa3sPm+mD3/A/EqgxG5a0M3n
         nJ6hw7Qb0+tNDWGie8ZAbS+amSSKC4NspnlmROiOmE1cQP4xrdP4K2Te4Mzjoe8xKFHe
         9nZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ToP3NoMVqEdCFB5f1dKv6CexiYd/z15XIcMvxzn4MUA=;
        b=M+xKQa6f9AfQvFrDGoCwFlhYcMaFf396S3bJGkD9FPoWJhr0dPwmIqXk4Nj6iU82bN
         qavWbD7XfaWE72KE59SAdS0/g9PWZIqKbb7UaN2Np3SLHBGWlZeZzr95r4frMtfT2ukk
         k6nI107qbOgog5F4aN8C2yEYqD3o27fWYmS8E03GEG3cEyoW5bw2kr9meY4EZILacBXx
         +yiO379iSRX66aqQSzM0J3HEbY987waht/fIjqJIDJ9eoAQs0Jui7doV6Zpb3clYxO3Z
         LnjR+uyvNAnnvACaxcQiJidJKb+4PrK95hpDH4R/leaKIwChjQfYyh7SawDIE3cfRlEv
         FDjA==
X-Gm-Message-State: AOAM530Gy1L+WEOwMJuDy5A3G5IsN7PZ1CKrOqETzNEkjWZxQWJwRLnu
        fOW9QCyKom6nOaGfwXFFjTwnHmxu4ww=
X-Google-Smtp-Source: ABdhPJwfAQBn/D+z1/JsA99IiTbrUtIqgLvoh+6BPD6A3zcp2BFxRCIVNovDD+HwGlA00863/ETyEg==
X-Received: by 2002:a2e:8746:: with SMTP id q6mr754838ljj.382.1636202353852;
        Sat, 06 Nov 2021 05:39:13 -0700 (PDT)
Received: from [192.168.1.11] ([217.117.245.207])
        by smtp.gmail.com with ESMTPSA id j15sm1147323lfg.1.2021.11.06.05.39.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Nov 2021 05:39:13 -0700 (PDT)
Message-ID: <3d5e87ad-384a-f024-6b4e-8439c983cbfc@gmail.com>
Date:   Sat, 6 Nov 2021 15:39:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] tty: vt: keyboard: do not copy an extra-byte in
 copy_to_user
Content-Language: en-US
To:     Ajay Garg <ajaygargnsit@gmail.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211106092041.43745-1-ajaygargnsit@gmail.com>
 <9eafae1f-d9f0-298d-cf20-212865d0becc@gmail.com>
 <CAHP4M8X5ZrrVBS6Y3tg6c8jK4BA0JK+q8reiGwVeoZX9gUvogw@mail.gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <CAHP4M8X5ZrrVBS6Y3tg6c8jK4BA0JK+q8reiGwVeoZX9gUvogw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 11/6/21 15:05, Ajay Garg wrote:
> Hi Pavel,
> 
> Thanks for the review.
> 
>> >               len = strlcpy(kbs, func_table[kb_func] ? : "", len);
>>
>>                 ^^^^^^^^^
>>
>> len is reinitialized here, i.e len passed to kmalloc and len passed to
>> copy_to_user() can be different.
> 
> Sorry, I missed this part.
> 
> 
>>
>> strlcpy() returns strlen() of source string (2nd argument), that's why
>> we need +1 here to pass null byte to user.
>>
>> Am I missing something?
>>
>>
> 
> Seems things are more screwed.
> I tried to see the behaviour, via a small program as below :
> 
> ##########################
> #include <stdio.h>
> #include <bsd/string.h>
> 
> char a[10] = {0};
> char b[] = "1234567890123456";
> 
> int main()
> {
>      int len = strlcpy(a, b, sizeof(a));
>      printf("len = [%d]\n", len);
>      printf("a = [%s]\n", a);
> 
>      return 0;
> }
> ##########################
> 
> 
> The result is :
> 
> ##########################
> len = [16]
> a = [123456789]
> ##########################
> 
> 
> As seen, len is *not equal* to the number of bytes actually copied.
> (The bytes actually copied are 9 in number, plus 1 for the terminator,
> as expected by strlcpy).
> 
> On re-reading the doc for strlcpy, it seems that strlcpy returns the
> length of src it "intended* to copy, and not the bytes *actually
> copied*. If so, then returned value of len is meaningless.
> 

return value from strlcpy() is simply strlen(src)

lib/string.c:141
```
size_t strlcpy(char *dest, const char *src, size_t size)
{
	size_t ret = strlen(src);

	if (size) {
		size_t len = (ret >= size) ? size - 1 : ret;
		memcpy(dest, src, len);
		dest[len] = '\0';
	}
	return ret;
}

```


I guess, it's what you mean by "intended to copy"


> 
> 
> So, it seems following two changes should be made in the original code :
> 
> 1.
>                  len = strlcpy(kbs, func_table[kb_func] ? : "", len);
> =>
>                  strlcpy(kbs, func_table[kb_func] ? : "", len);
> 
> 
> 2.
> ret = copy_to_user(user_kdgkb->kb_string, kbs, len) ?
>                          -EFAULT : 0;
> =>
> ret = copy_to_user(user_kdgkb->kb_string, kbs, strlen(kbs) + 1) ?
>                          -EFAULT : 0;
> 
> 
> In 1, we change to simply not using the returned value of strlcpy.
> In 2, we change to using strlen(kbs) + 1, as the number of bytes to copy.
> 

If I understood correctly, you are trying to prevent some kind of 
overflow here, right?

I see, that strlen(func_table[i]) cannot be greater than 
sizeof(user_kdgkb->kb_string) - 1.

vt_kdskbsent() is used to set func_table ptrs. It's called only from 
vt_do_kdgkb_ioctl(). Buffer is allocated via

strndup_user(user_kdgkb->kb_string, sizeof(user_kdgkb->kb_string));

It means that maximum strlen() of returned pointer will be 
sizeof(user_kdgkb->kb_string)) - 1, because 2nd argument is size *with* 
null byte.



Back to KDGKBSENT handler: kbs is sizeof(user_kdgkb->kb_string) 
allocated buffer and strlcpy() will return strlen(func_table[kb_func]), 
which is guaranteed to be less than sizeof(user_kdgkb->kb_string). It 
looks save to use strlcpy() return value here, because 3rd argument is 
greater than strlen() of second argument.



Let me know if I am completely wrong here :)



With regards,
Pavel Skripkin
