Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028D2C433EF
	for <linux-serial@archiver.kernel.org>; Sat,  6 Nov 2021 20:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C07A161056
	for <linux-serial@archiver.kernel.org>; Sat,  6 Nov 2021 20:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233920AbhKFUgq (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 6 Nov 2021 16:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbhKFUgp (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 6 Nov 2021 16:36:45 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE65C061570;
        Sat,  6 Nov 2021 13:34:04 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id v15so14075919ljc.0;
        Sat, 06 Nov 2021 13:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ivr2Awm9A6W/30hhTq73ud4rsNlqaBVMqxR8KOFQptk=;
        b=AKtRUSajJsvlDyun9EJrnS9kuS+3JXDGuUXdpPiWdMu8EyHVghqDAhCIKvfd51b9cV
         RwgAEMPDX9wBScMVLCEvlXaa+mXvkAIDyl5x1/DH0K48E7rTDieDAb5BS+IcrHVY7VFZ
         uwWRfYmxRamBiS1z/MkR1nl19jU1ezCllWgVANSoqZcgRDc1Vrts6v225rpsdmRDwM8A
         tRlF4tvjdzXFQliG7jEAA5+LOS/uOtJ7HBoVgoslk+eTi/LdAjF2UVO3ktOoiq402ZL1
         OHc0cEuECX5EkWRACPXgejpcF+RX/hgoUKL7Vcq9lZQBhN5n1hd+CeqQrj0ca4OQXgRD
         zsng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ivr2Awm9A6W/30hhTq73ud4rsNlqaBVMqxR8KOFQptk=;
        b=EfNxiReCt+qAa83Gszer2V9CzcgrdQzxdPfYn6KMl1B8/S9i4bsCtieF1rUzfNaffG
         Fh9aeyrDl86rqAzmlRJJ0DRhh40qoyEx4RZkkc+n9SYWii74104vjUoUbfPMCesWZgj9
         cZSIi8afgtlSuw8Bf1vLm76dtH1t+vtN81V+ADIRtUzVTyrShsg3/qjfZpdMoVdwgLpv
         nQc9q1+jI3nHKIANWNyHK/22rSBZKx1DGSrimbyeOMtxTuQUEJCcncPIVRhGnOK2Yurr
         ojrAkXgL0HUBgsM/4Numd9cjYsA5bMQJVSwf0UMckBIfvxRqz3vMnhGPqBiLe3j2hjCw
         mThA==
X-Gm-Message-State: AOAM532USi4UvX2Rh8JDb13OQ2/gs5mp5pnLuCOA041M21VDQma/Wb/x
        9O9NlyPHSZN1botcuYrq7qI=
X-Google-Smtp-Source: ABdhPJwskimdziV3Xu1QK80amoB8+QHyv3a+m9FFGKrtPPyCaYW0nEDZZy9A2WuOZtUnsShgAN+JTA==
X-Received: by 2002:a2e:7c0c:: with SMTP id x12mr15443100ljc.210.1636230842507;
        Sat, 06 Nov 2021 13:34:02 -0700 (PDT)
Received: from [192.168.1.11] ([217.117.245.207])
        by smtp.gmail.com with ESMTPSA id y1sm1248023lfd.204.2021.11.06.13.34.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Nov 2021 13:34:02 -0700 (PDT)
Message-ID: <9717b429-597f-7778-c880-94361bcdee7f@gmail.com>
Date:   Sat, 6 Nov 2021 23:34:01 +0300
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
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <CAHP4M8Vs8a8u98enuHXaBcC7D4fCZzCOtEq06VnvuPUqhqPK=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 11/6/21 23:30, Ajay Garg wrote:
>> > 2.
>> > == Calculate the actual length of kbs, add 1, and then copy those many
>> > bytes to user-buffer ==
>> >
>> > ret = copy_to_user(user_kdgkb->kb_string, kbs, len + 1) ?
>> >                          -EFAULT : 0;
>> > =>
>> > ret = copy_to_user(user_kdgkb->kb_string, kbs, strlen(kbs) + 1) ?
>> >                          -EFAULT : 0;
>> >
>>
>> But isn't strlen(kbs) is guaranteed to be equal to strlcpy() return
>> value in this case? As I said in previous emails,
>> strlen(func_table[kb_func]) < sizeof(user_kdgkb->kb_string) by design of
>> this function.
> 
> That's the whole point of the discussion :)
> 
> The method "vt_do_kdgkb_ioctl" does not manage "func_table[kb_func]".
> Thus, the method does not know whether or not
> strlen(func_table[kb_func]) < sizeof(user_kdgkb->kb_string).
> 

It manages. The code under `case KDSKBSENT:` sets func_table[] entries 
via vt_kdskbsent().

kbs = strndup_user(..., sizeof(user_kdgkb->kb_string));

is used to allocate buffer for the func_table[] entry. That's my main 
point :)




With regards,
Pavel Skripkin
