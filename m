Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 445E7C433F5
	for <linux-serial@archiver.kernel.org>; Sat,  6 Nov 2021 20:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D69460D43
	for <linux-serial@archiver.kernel.org>; Sat,  6 Nov 2021 20:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233869AbhKFUVN (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 6 Nov 2021 16:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbhKFUVN (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 6 Nov 2021 16:21:13 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A2FC061570;
        Sat,  6 Nov 2021 13:18:31 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id e11so1901932ljo.13;
        Sat, 06 Nov 2021 13:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=88qCoN8PEpI6RV4cVB/bp4pbyXm2b0XUSZtuu/Gd9aw=;
        b=PnjxXggs3iYs0WY02NX+m0pWTMDosWg9AdSgsy03QxSqaEt+ey43FAYkKZyNC9I7z5
         8xCkvH8qtIzDReaTQtky+SuCHfoi4QaCyfKdoIgQciAfpKmaylU2W3mXZZ1tTEz8x9a0
         vZxgw428w3GT5XMfRz9xZIgETbTdaCzFKhGQZJk0hibWAIImGQIB2ZCqSqpILyamh9E8
         ajuh54TWnEE1cWZhB5zAIAsT53d6q6G3N9Vp/A+FmtKYawZC5pnRSuK1Dly27BjqFxlz
         +xNlcEXhPE4TtUOM0gzkK4XqVJr9PSxxflkPBWfm72J4VTQ5z75HIIhvLvI3jdsCJwIw
         UaYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=88qCoN8PEpI6RV4cVB/bp4pbyXm2b0XUSZtuu/Gd9aw=;
        b=fw2Vov9QlG5ahcmCLKE7VFqcGsqc1q5HK3rnPN/qQJpTidx/igLASEMMYniSlPV5/l
         5GiDtG1qtzWNl39q75yjLuD/CINwnv+YdLJchla4bLGX2QuTgcSAe+TaLddlR/BzdO7S
         qbaD94TpEK3LM/TIb7WDDnlwBfeL3kyUJcJmHBOg6737LAupss63s8uolbJh7J60SplL
         0pe9go4iE7BsS3hZOXCmDL/2Fn9Ymz7e2q4YFrAiY/S1SBsJt7faweH/dmvEWLwGm2Tm
         vfzUFtP8xp7A+GigXdNhCar6C0452XgECnrldududvzb33E3TXBjKuRHfP+uU+jZmjDL
         785Q==
X-Gm-Message-State: AOAM5325DJi0cjb9Gt/1XOZPxaopF/bO9xW0/yINxGSgTGzg9bnYVALf
        c0oXScIHcUcxwqCYjf1zq0U=
X-Google-Smtp-Source: ABdhPJz0mX1WoYEhhk4WgPsSWfdGi9E3K0d6DpdkeS60QFf0e4KDri5Bo0zY1HUKaNOCw8q/7OfsQQ==
X-Received: by 2002:a2e:a5c8:: with SMTP id n8mr71717765ljp.367.1636229909496;
        Sat, 06 Nov 2021 13:18:29 -0700 (PDT)
Received: from [192.168.1.11] ([217.117.245.207])
        by smtp.gmail.com with ESMTPSA id p16sm1246655lfa.266.2021.11.06.13.18.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Nov 2021 13:18:28 -0700 (PDT)
Message-ID: <6b58a3e1-f2ea-cc4c-03b2-06334b559373@gmail.com>
Date:   Sat, 6 Nov 2021 23:18:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] tty: vt: keyboard: do not copy an extra-byte in
 copy_to_user
Content-Language: en-US
To:     Ajay Garg <ajaygargnsit@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>, jirislaby@kernel.org,
        kernel@esmil.dk, David Laight <David.Laight@aculab.com>
Cc:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20211106092041.43745-1-ajaygargnsit@gmail.com>
 <9eafae1f-d9f0-298d-cf20-212865d0becc@gmail.com>
 <868025b485b94480ad17d0ec971b3ee9@AcuMS.aculab.com>
 <CAHP4M8Ww0-VqCBKX=iLd=zy1AcDoNdzTOqJuaqRxCGZsMhoX9w@mail.gmail.com>
 <CAHP4M8UcZ=ttB8jbN1yOY6YH8SiQ27NhdEKi9SDH1CWG-GY6eg@mail.gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <CAHP4M8UcZ=ttB8jbN1yOY6YH8SiQ27NhdEKi9SDH1CWG-GY6eg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 11/6/21 22:46, Ajay Garg wrote:
> Actually, on further thoughts, even David's solution will require an
> extra check, if -E2BIG is returned.
> 
> So, I guess the solution suggested by me looks the best
> (https://lore.kernel.org/linux-serial/868025b485b94480ad17d0ec971b3ee9@AcuMS.aculab.com/T/#m1c4aaa4347b02fd4c11ce611ff5029fcb71c37a1)
> :
> 
> 1.
> == Do not use the return value from strlcpy. ==
> 
>                  len = strlcpy(kbs, func_table[kb_func] ? : "", len);
> =>
>                  strlcpy(kbs, func_table[kb_func] ? : "", len);
> 
> 
> 2.
> == Calculate the actual length of kbs, add 1, and then copy those many
> bytes to user-buffer ==
> 
> ret = copy_to_user(user_kdgkb->kb_string, kbs, len + 1) ?
>                          -EFAULT : 0;
> =>
> ret = copy_to_user(user_kdgkb->kb_string, kbs, strlen(kbs) + 1) ?
>                          -EFAULT : 0;
> 

But isn't strlen(kbs) is guaranteed to be equal to strlcpy() return 
value in this case? As I said in previous emails,
strlen(func_table[kb_func]) < sizeof(user_kdgkb->kb_string) by design of 
this function.

Do we need extra strlen() call here? Let's see what more experienced 
people think about it :)



With regards,
Pavel Skripkin
