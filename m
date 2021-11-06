Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F62CC433EF
	for <linux-serial@archiver.kernel.org>; Sat,  6 Nov 2021 11:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C24461074
	for <linux-serial@archiver.kernel.org>; Sat,  6 Nov 2021 11:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbhKFLH7 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 6 Nov 2021 07:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhKFLH6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 6 Nov 2021 07:07:58 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0460C061570;
        Sat,  6 Nov 2021 04:05:16 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id p16so24170349lfa.2;
        Sat, 06 Nov 2021 04:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=eQmD+gMMzVUaF1sQOhJIfyh/NK+bcmnK5vkeRUuT4Os=;
        b=JxvjCXWG5WnHsurXDLDcnFkmLCuppIx6R3iM987zvP7sRs8Bet2XzAYOzzjSmlWzKt
         UmHfjwtRrma8oEwNGGonlwHknqZO1BdXIZRwrb5b5jOSEXYqV7E9HBmbmPzYdLSY1bkB
         Ntaj/R/cvU79Ckr7EGYDlC/JOK0/rju9qgG4gKb3EA+sFE8brcB7nACGR0W/yzJDFOSN
         F+xWI3hgGbaMTWhm0nS5dk785Na3RsQz9Xn/nqmqrO7njkyeAluE59iSV4Adp28nYUt1
         vLKExZCx5TssVIsDXGdqtzJdsSXKuYD9v3lfTqziYg72zRZ0LFSIEf/qdqFN/myjpyoj
         emMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eQmD+gMMzVUaF1sQOhJIfyh/NK+bcmnK5vkeRUuT4Os=;
        b=ES8DzAvPDI+J/Imc8m1FLaefwjqBFtZoUuoFylRXtcOHHT6F/vK+kWtXduyLmF/xAw
         XWbg06WEGQPuyXF6Yi5lLQBVZlkw+4fAZe0XjQxqsm+eIWR/guhaj0TiF6IiyJNe2Tdq
         lGC0OcoEwMJVxc34NYBBaW2Jlj+D1W0Uq2cwSEjpaJWrsuZVd7SVThaX+mv4WUYd/iAU
         ELx2MIAl39OWZxybIJL1RQy1r9oE6+Feimrb65JPc0Rph4GjbH2j1x3ZNz0iaDA1MzTJ
         ypO4XlUSO3Xo7Hv14ImnkVl5sGiRERQ7CpU49uyNLORhDitJvyu9YQHUB0/+j6XAi8df
         GPGQ==
X-Gm-Message-State: AOAM530QddAJ716bJOBKxMDsvsY61U2zOtFbcWEvJ6kvNIfehvZHD/T6
        zMfaJYNxp/i0xqIxywkmguAitVR5Acg=
X-Google-Smtp-Source: ABdhPJxUVdJvDqHEQrLU2WGHHH6oOFxD5l8VdEGfuytbBhUphxW+mSdnItKp91n0r2RJgZkZd4kgAQ==
X-Received: by 2002:a05:6512:21c7:: with SMTP id d7mr4697271lft.434.1636196714418;
        Sat, 06 Nov 2021 04:05:14 -0700 (PDT)
Received: from [192.168.1.11] ([217.117.245.207])
        by smtp.gmail.com with ESMTPSA id f9sm1127467lfg.148.2021.11.06.04.05.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Nov 2021 04:05:13 -0700 (PDT)
Message-ID: <dd7e35fc-d5b2-c41b-f03a-cbf467401205@gmail.com>
Date:   Sat, 6 Nov 2021 14:05:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v2] tty: vt: keyboard: initialize "kbs" so that kfree(kbs)
 runs fine even if kbs is not kmalloced.
Content-Language: en-US
To:     Ajay Garg <ajaygargnsit@gmail.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211106104053.98761-1-ajaygargnsit@gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20211106104053.98761-1-ajaygargnsit@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


Hi, Ajay!

On 11/6/21 13:40, Ajay Garg wrote:
> 
> v1 patch at :
> https://lore.kernel.org/linux-serial/YYZN30qfaKMskVwE@kroah.com/T/#t
> 
> 
> Changes in v2 :
> 
>          * Changes as required by scripts/checkpatch.pl
> 
>          * Checking whether kbs is not NULL before kfree is not required,
>            as kfree(NULL) is safe. So, dropped the check.
> 
> 
> For brevity, here is the background :
> 
> 

Please, don't put change log into commit message. It should go under ---

> In "vt_do_kdgkb_ioctl", kbs is kmalloced, if cmd is one of KDGKBSENT or
> KDSKBSENT.
> 
> If cmd is none of the above, kbs is not kmalloced, and runs
> direct to kfree(kbs).
> 
> Values of local-variables on the stack can take indeterminate values,
> so we initialize kbs to NULL. Then, if kbs is not kmalloced, we have
> kfree(NULL) at the last.
> 
> Note that kfree(NULL) is safe.
> 
> 

These is only one caller of vt_do_kdgkb_ioctl, which simple does:


	case KDGKBSENT:
	case KDSKBSENT:
		return vt_do_kdgkb_ioctl(cmd, up, perm);

It means, that cmd can not be different from KDGKBSENT and KDSKBSENT.

I guess, you found this "issue" via static analysis tool like smatch or 
smth similar, but this bug is impossible right now.

> 
> Signed-off-by: Ajay Garg <ajaygargnsit@gmail.com>
> ---
<--- here

>   drivers/tty/vt/keyboard.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
> index dfef7de8a057..54155fc91cd2 100644
> --- a/drivers/tty/vt/keyboard.c
> +++ b/drivers/tty/vt/keyboard.c
> @@ -2049,7 +2049,7 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
>   {
>   	unsigned char kb_func;
>   	unsigned long flags;
> -	char *kbs;
> +	char *kbs = NULL;
>   	int ret;
>   
>   	if (get_user(kb_func, &user_kdgkb->kb_func))
> 


With regards,
Pavel Skripkin
