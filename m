Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BECC433F5
	for <linux-serial@archiver.kernel.org>; Sat,  6 Nov 2021 12:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8971760EC0
	for <linux-serial@archiver.kernel.org>; Sat,  6 Nov 2021 12:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbhKFMsj (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 6 Nov 2021 08:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232900AbhKFMsj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 6 Nov 2021 08:48:39 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064FEC061570;
        Sat,  6 Nov 2021 05:45:58 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id f3so24428473lfu.12;
        Sat, 06 Nov 2021 05:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Wij71fKA1HG2jiSYInwTXYj/LtZwp9diZJCmSGprZss=;
        b=PrWVoE3BZTjFRpJsGE5x62Fu125ksbCKl0cApBawk3P3OuMDYy6DQwYfMbCTVKTp/k
         PeTBOzjpBD8QEn+u5B7hdgX1uFPP3JMJeVmt8ECT8e22v2l8bGgAV2dpV0rHZq7QDQsN
         bxlphXuk9shR2qBbfT/n8n5atjkdj0wnMrg7izZRMi/jlPQI5VSfdA8t9kxjVSyI4K0F
         z3BDe0gSsrnxDWmGvsHU5BPFOLPgGs5uLXc9N45gdNqhiyct7t0ANieRS2Rv1/Gwx3Ff
         ucDuZaq4GDgQLgzFY6fFIxVC7gwCmT77qLOQi8I3K2J2KCq6qgpfnRESpXNurxoAs4P8
         hf3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Wij71fKA1HG2jiSYInwTXYj/LtZwp9diZJCmSGprZss=;
        b=7dV5LH8G2MhsbzONhr5R6cPJ5Tsz9/U5XoQrmG8bvQCzSn/lcxwFGhXB48ilI8mk4G
         CWWzS5wWJZTkcfTgzyIbws73jKFovpKx1xt6rSzczhcula1GzSaH4tVvffbhtIDXs/oU
         bBQDYJqyCz4hj4EXsuqpCLiKhezEkaH70al4z0bV29O93gO3hnn0y+KMkEy1iHwz3AQe
         Cvenz8fpCLNGO73VgNNdB40j1KxPRIemXXic8QksKdjPp2GjvKuu1+EPyKJuicpAE0I1
         ziJ6NuB7ank1EXZOZ6phcTn4AHRSWIONTYQs7X7Qb4ihq/Kjws8xL0Q6OURq0lfmLYSY
         zJBg==
X-Gm-Message-State: AOAM531NJoqWJFKO7UoI4s7wcruJqkCfl63/gDeNM/ZwEJX62nmdbyhF
        QMNPyA7sWs1UuNcNCZT+vBNaftuu1Do=
X-Google-Smtp-Source: ABdhPJx6tFzdxq+w7p7JRTF8uxwBxJTCnAQ8nZaXHWWqqHw92Bf7Zdbyq3AmV1cZq2qLLebrPGOEVw==
X-Received: by 2002:a05:6512:31d1:: with SMTP id j17mr60960429lfe.11.1636202756239;
        Sat, 06 Nov 2021 05:45:56 -0700 (PDT)
Received: from [192.168.1.11] ([217.117.245.207])
        by smtp.gmail.com with ESMTPSA id z1sm1151234lfu.222.2021.11.06.05.45.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Nov 2021 05:45:55 -0700 (PDT)
Message-ID: <ae60b19d-aef8-7822-0837-b995f796c2da@gmail.com>
Date:   Sat, 6 Nov 2021 15:45:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v2] tty: vt: keyboard: initialize "kbs" so that kfree(kbs)
 runs fine even if kbs is not kmalloced.
Content-Language: en-US
To:     Ajay Garg <ajaygargnsit@gmail.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211106104053.98761-1-ajaygargnsit@gmail.com>
 <dd7e35fc-d5b2-c41b-f03a-cbf467401205@gmail.com>
 <CAHP4M8XaWtagZcocGoeT2Rb6F6JeKqMFa2ZzTZ0ddCES0-T-jw@mail.gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <CAHP4M8XaWtagZcocGoeT2Rb6F6JeKqMFa2ZzTZ0ddCES0-T-jw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 11/6/21 15:16, Ajay Garg wrote:
> Hi Pavel,
> 
> Thanks for the review.
> 
>>
>> Please, don't put change log into commit message. It should go under ---
>>
> 
> Ok, many thanks Pavel.
> Will take care in all my future patches.
> 
> 
>>
>> These is only one caller of vt_do_kdgkb_ioctl, which simple does:
>>
>>
>>         case KDGKBSENT:
>>         case KDSKBSENT:
>>                 return vt_do_kdgkb_ioctl(cmd, up, perm);
>>
>> It means, that cmd can not be different from KDGKBSENT and KDSKBSENT.
>>
>> I guess, you found this "issue" via static analysis tool like smatch or
>> smth similar, but this bug is impossible right now.
>>
> 
> Yes, following was reported by smatch (amongst others) :
> vt_do_kdgkb_ioctl() error: uninitialized symbol 'kbs'.
> 
> 
> Regarding the current state, "vt_do_kdgkb_ioctl" should ideally behave
> correctly independently, without bothering whether a cmd is a valid
> one. From that perspective, it makes sense to ensure that kfree never
> crashes.
> 
> However, I don't have any strong opinions on what is right or what is
> wrong, as long as things work fine.
> 
> So, if there is a general consensus that the change should not be made
> currently, I would be ok.
> In case the change should be made, kindly let me know, I will post the
> v3 patch (making change as per the review-comment of moving changelog
> below ---).
> 
> 

I can't say if it needed or not, since I am not the maintainer. I've 
just said my thoughts on this change. It looks like you missed all 
maintainers emails in your CC list :)

└──$ ./scripts/get_maintainer.pl -f drivers/tty/vt/keyboard.c
Greg Kroah-Hartman <gregkh@linuxfoundation.org> (supporter:TTY 
LAYER,commit_signer:10/10=100%,authored:2/10=20%,added_lines:31/66=47%,removed_lines:31/59=53%)
Jiri Slaby <jirislaby@kernel.org> (supporter:TTY 
LAYER,commit_signer:6/10=60%,authored:3/10=30%,added_lines:14/66=21%,removed_lines:4/59=7%)
Andy Shevchenko <andriy.shevchenko@linux.intel.com> 
(commit_signer:4/10=40%,authored:4/10=40%,added_lines:18/66=27%,removed_lines:21/59=36%)
Emil Renner Berthing <kernel@esmil.dk> 
(commit_signer:1/10=10%,authored:1/10=10%,removed_lines:3/59=5%)
linux-kernel@vger.kernel.org (open list)


This is the list of people you need to send patches to. Please, use this 
script next time to not miss people related to your change :)


The same for your other patch.



With regards,
Pavel Skripkin
