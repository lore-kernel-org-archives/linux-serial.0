Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E98C433EF
	for <linux-serial@archiver.kernel.org>; Sat,  6 Nov 2021 19:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7629861054
	for <linux-serial@archiver.kernel.org>; Sat,  6 Nov 2021 19:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234124AbhKFT7T (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 6 Nov 2021 15:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbhKFT7S (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 6 Nov 2021 15:59:18 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2487C061570;
        Sat,  6 Nov 2021 12:56:36 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id bq11so26137957lfb.10;
        Sat, 06 Nov 2021 12:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/SrIMiSEkY+x5qFXlc6oA7hCfVljirHRWhiQsqbjR28=;
        b=M7ZPPJiIKJDgHZ9aGY79OfDxvpN0GgTqiYv5gldYYtD4qx07UyUsv+EPz0S7O9qkcX
         3nxLMK35L2pbQgCcg6jwlqez9WPxUt0HVMNgWbJVKzi5c0C6DG382TrkOD2ml3aIchCw
         C5dJXbAoEiddtLzBHOHY9p/Tloti6g89hNA9l+JqKoFnjo7gDfYSMMzx0xUj+Gws5G28
         rtf3KHDD7BIjpCVWoKuyX1S11yOs/aD3lbkzlGMIQfmTsxCXlEJ065nm89sG2BseVWFr
         MvVefJxEB3M6hO6mVvoMqPgUxt/xpE31nes/C1uB5/IB/04chDuVcOnv7NBcAccRKueV
         LOTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/SrIMiSEkY+x5qFXlc6oA7hCfVljirHRWhiQsqbjR28=;
        b=5uBNdapDrqYnw9VNtjS3vCt8SGlAHT5IQcS/pbKuAd/JbTWACMd5UQhsuJLlhQpYhs
         9vmFj2mJiJXMkTfSe8q6JDPtyol4IaSdg3tGoDGF/TzTYr1IYa5GtkA5bx5J3EIuco6b
         sep7neig6s/+oZSZTE31KdALMcaCRQVtAG4UXdTZoJc5JCEgxmTlEvtnSwDG0ynzkqx8
         fRyGUQO8/Vh5ANyFp0WxdoWw4tW9nocOmpmvDWIBVxU7lS7zQs+tmzcRhnmc3QR0jjkz
         qzsT+2ia1MHlzbZj79sBCzv8TG+M3riYurPHtDw5Lxpl2mD91/nfoT7OMmn6zCP9GoWT
         Okjg==
X-Gm-Message-State: AOAM533KV+bfxDPZb+uG3AIV8OK1/NGw/iMVUlScu+8D+mFCPB6IP+Ih
        6qRr+iV9JyfDIo1C+08XPuQ=
X-Google-Smtp-Source: ABdhPJxIb4gkY4tOwPQmfpqeLiCriX6z19eQYoSiPekz8ZbGTOrf8/87O80GMFVFXNd9ohG7c7Nkyg==
X-Received: by 2002:a05:6512:3c98:: with SMTP id h24mr60508533lfv.155.1636228594179;
        Sat, 06 Nov 2021 12:56:34 -0700 (PDT)
Received: from [192.168.1.11] ([217.117.245.207])
        by smtp.gmail.com with ESMTPSA id k15sm1092368ljh.102.2021.11.06.12.56.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Nov 2021 12:56:33 -0700 (PDT)
Message-ID: <58f5cf69-3b3b-62f2-9f73-49c51176a534@gmail.com>
Date:   Sat, 6 Nov 2021 22:56:33 +0300
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
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <CAHP4M8Ww0-VqCBKX=iLd=zy1AcDoNdzTOqJuaqRxCGZsMhoX9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 11/6/21 22:20, Ajay Garg wrote:
> I vote for David's strscpy "fix", as it is simple, and does away with
> the dependency on the length of "func_table[kb_func]".
> 

strscpy fix sounds reasonable to me. just to be save in future.

There is only one thing I am wondering about: translation table entries 
are set by user using this struct

struct kbsentry {
	unsigned char kb_func;
	unsigned char kb_string[512];
};

it means entries cannot be longer than sizeof(kbsentry::kb_string) - 1 
at all. Do we need extra branching with strscpy() or do we need to do 
anything else here?



With regards,
Pavel Skripkin
