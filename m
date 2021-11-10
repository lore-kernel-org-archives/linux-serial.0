Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7DAC433FE
	for <linux-serial@archiver.kernel.org>; Wed, 10 Nov 2021 07:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09D9B60E98
	for <linux-serial@archiver.kernel.org>; Wed, 10 Nov 2021 07:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbhKJHkH (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 10 Nov 2021 02:40:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhKJHkG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 10 Nov 2021 02:40:06 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8361CC061764;
        Tue,  9 Nov 2021 23:37:19 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id k37so3898645lfv.3;
        Tue, 09 Nov 2021 23:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/X4dkcH3D0KFPXqvr+tVUucDH2yewcV+8RCqw/Q9S8I=;
        b=D37w0J8hPbxHZeo6WRKapuDqP4BxywTntmVZXxBuEA+OrFkI7ysS36XjOC+J2d1KAR
         zCV1e9hOER28kHji5QvbEi9QZpRWOsGyqC+bZKreaswBeicw0Esd7TAzrLSVa+9D9t+C
         1LDv9smpG5+/pfMnhIUwaRy6EY/MKiPLf5ENz4fb7WNtKvftSrvoWlyUnmE4VsxPe88B
         ffBkKRenu1X5yDGYQmenjq5p4NJFt2+Fs3rb8sh4+pJ2ef2hYbIQ3fWOB6KHwsxADRVH
         hHVdIm8O+ZpTmGT1+z+aIVXSEk5TG5xZMNgZpNZZl8NiQ/GxtxRcMeCXMmSdLaX3vfCD
         fKiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/X4dkcH3D0KFPXqvr+tVUucDH2yewcV+8RCqw/Q9S8I=;
        b=0QQ+ePXQsn+de2yNNrx+cEYgArn6VYKS4p2ZAAGjxzPu7CY00lXdrEAjqrcZSAvnwb
         DmN70Ce80/WKf1xiE8PKo94C9/5e9cYIMQwEHFNZhRWFRp4eheVvze7p+wYnIRzDrjWe
         YLg4aUx3DiTMtMy5Y3rHTCZNQZGDkSyZFHfnyvNrFvqMc0v3t7TXaJFYfDfiiv+c9pJE
         Gg8ERQLU0iRk3/SMIfiufwdmcv9bT8ckOz+7xGau6nwf3BK2aqj8On+GGpRqtz6CT7ve
         HiSMDAn/a3LvOX0H5DqKYmo9dsEcGWb5/8cBMMD5EmxRHpQPRI+SP/vfCgyXuBQfBDMH
         dX3g==
X-Gm-Message-State: AOAM5317MItCvGkosk89+j4j9y+sLPDk0Xbym7zLXMhDLCpbdCaW/6sL
        fYJl9eVlLmDmDVr0kFGxs84=
X-Google-Smtp-Source: ABdhPJx514EZzsEjjsfds1helzQj5B+4dgJyAZCC0V+g3tOZH9KPTfSu5jZZFilokN/LiEaWP+mcxg==
X-Received: by 2002:a05:6512:3f86:: with SMTP id x6mr12707697lfa.389.1636529837835;
        Tue, 09 Nov 2021 23:37:17 -0800 (PST)
Received: from [192.168.1.11] ([94.103.224.112])
        by smtp.gmail.com with ESMTPSA id h19sm2646682lfu.60.2021.11.09.23.37.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Nov 2021 23:37:08 -0800 (PST)
Message-ID: <1305bb43-b4bf-e129-af6e-957d1f30f269@gmail.com>
Date:   Wed, 10 Nov 2021 10:37:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] tty: vt: keyboard: do not copy an extra-byte in
 copy_to_user
Content-Language: en-US
To:     Jiri Slaby <jirislaby@kernel.org>,
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
 <08c9e717-4367-5316-87cd-90b5ceb13ed9@kernel.org>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <08c9e717-4367-5316-87cd-90b5ceb13ed9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 11/10/21 08:22, Jiri Slaby wrote:
> I don't quite understand what the problem is. Provided I wrote the code,
> is there something wrong with this commit (and its explanation), in
> particular?
> 
> commit 6ca03f90527e499dd5e32d6522909e2ad390896b
> Author: Jiri Slaby <jirislaby@kernel.org>
> Date:   Mon Oct 19 10:55:16 2020 +0200
> 
>       vt: keyboard, simplify vt_kdgkbsent
> 
>       Use 'strlen' of the string, add one for NUL terminator and simply do
>       'copy_to_user' instead of the explicit 'for' loop. This makes the
>       KDGKBSENT case more compact.
> 
>       The only thing we need to take care about is NULL 'func_table[i]'. Use
>       an empty string in that case.
> 
>       The original check for overflow could never trigger as the func_buf
>       strings are always shorter or equal to 'struct kbsentry's.
> 
> thanks,
> 

As I said in my few previous emails, I don't see any bugs/problems in 
current code.

Ajay wants to be safe and he thinks, that relying on fact, that 
strlen(func_table[kb_func]) < sizeof(user_kdgkb->kb_string) is not good 
approach, since it's external for vt_do_kdgkb_ioctl. (I hope, I've 
explained his idea in the right way)



With regards,
Pavel Skripkin
