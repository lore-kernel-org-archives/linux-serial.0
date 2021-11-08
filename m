Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F57C433F5
	for <linux-serial@archiver.kernel.org>; Mon,  8 Nov 2021 11:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E6726120D
	for <linux-serial@archiver.kernel.org>; Mon,  8 Nov 2021 11:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239303AbhKHMAx (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 8 Nov 2021 07:00:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbhKHMAw (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 8 Nov 2021 07:00:52 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1139CC061570;
        Mon,  8 Nov 2021 03:58:08 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id u11so35619987lfs.1;
        Mon, 08 Nov 2021 03:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hrYIwuaickwVIX9nv5A/yaHsS4Ix6DSVs2dpM8KjH4o=;
        b=d1GUMgFByKbIgoH5GKMfZLg18V3Pvs1vpLAjCSW6tR9WEbVeRvjda+OrwVgn55Xvi3
         MMN61cx70hV0Hpd+qlq+gQk+get5yUBBISi5bZ9ybBoddoKtfalsgKvU2fKJh951WdGM
         UV4iLu88mZCur1cXaZHq63eUBedPtx3V2BazJQL2oanX2l0yAqZaLBMMd1Nt9y7p3SUB
         M0/gyfOqCT9fdnIeTp5l5u8J6bI96Z07CSQyv9j8qKaOMUFGQRwHijNvCphmuRNFUBvl
         +ZvakDZkdfHEHMmge2V09SnqIkjaXpDqmaDvmPPwNMCoW22FyPkBgCCztpwvttxfP7lI
         TdLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hrYIwuaickwVIX9nv5A/yaHsS4Ix6DSVs2dpM8KjH4o=;
        b=EdEZXwyLB/rc75dI3/1D0zNUtxaP649Q5Io4+u6z/TGNBLhuHjcq5N9iKjCaBzWwTj
         9j0tBAG6VfODroSk0QP2B9yL9bX4584NMZhzv1UyzBPsNbTrPRfqx0TGQ31FN3wOvlwG
         ZyDYC6nQjQJqqPTehTLT3kpng5Abmpd6c9lZCzDGvx8tMQWt/II9lwoHpdHYBzrm15ri
         cZVF2A4uqQOVseZVrjLOFN6KXHfPWme83zF+9l7bSCj1DON7GwCQmqF8QvCb/K5HJCL8
         aS/d3Z6t3WC7b1GWxjlu0vcieXrvLOxTcBMj/xHYA8aVKPj+5bw/1mY9v8lZBEael2iI
         Gs4Q==
X-Gm-Message-State: AOAM532pWFFjA+x5b+ZxKCZMyY9xzynJtbAhm9jHe2fl7KtKVgyFHxSa
        4RQBU08R7bdcsHfqprB9CLI=
X-Google-Smtp-Source: ABdhPJw+/HXa6QCL/PDO4vo2ym6gJYbrgnqVuNy8PJ3XD9TeQLKLdch4iVk9MaFPGCCXQAOhDsOWGw==
X-Received: by 2002:a05:6512:aca:: with SMTP id n10mr8634445lfu.649.1636372686350;
        Mon, 08 Nov 2021 03:58:06 -0800 (PST)
Received: from [192.168.1.11] ([94.103.224.112])
        by smtp.gmail.com with ESMTPSA id u12sm1148267lff.271.2021.11.08.03.58.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Nov 2021 03:58:05 -0800 (PST)
Message-ID: <9e3047a9-ad29-ab83-670b-4d28e6ec6dbf@gmail.com>
Date:   Mon, 8 Nov 2021 14:58:04 +0300
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
 <65c45951-08ba-26bb-f96b-3d4442b1d4d4@gmail.com>
 <CAHP4M8X_D4WdK9TwQoeV=WTEGUyLCs1VV5qWbYbfWJyZ9+C_5w@mail.gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <CAHP4M8X_D4WdK9TwQoeV=WTEGUyLCs1VV5qWbYbfWJyZ9+C_5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 11/8/21 11:59, Ajay Garg wrote:
> Dropping all further discussions on this thread, as a RFC for a new
> string-copy method has been posted at :
> https://lore.kernel.org/linux-hardening/CAHP4M8U=0aTHgfREGJpSboV6J4X+E3Y6+H_kb-PvXxDKtV=n-g@mail.gmail.com/T/#t
> 
> which, if accepted, will make the clients' lives a lot easier.
> 

Honestly, I can't get what you are trying to achieve with new string 
function.

If caller knows, that there is no possible overflow, it can omit bounds 
checking (like in vt_do_kdgkb_ioctl). If caller needs return value equal 
to destination length it can use strscpy().

There is a bunch of str*cpy() functions and every month I see new 
conversations between them on ML. As Andy said it's really chaos. These 
conversation are needed, of course, from security point of view, but 
lib/string is already big. It contains functions for every possible 
scenario, caller just needs to pick right one.

I might be too dumb in this topic, so it's just my IMHO, since I am on 
CC list.




With regards,
Pavel Skripkin
