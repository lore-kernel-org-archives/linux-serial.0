Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D292C433F5
	for <linux-serial@archiver.kernel.org>; Sat,  6 Nov 2021 11:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F106611C4
	for <linux-serial@archiver.kernel.org>; Sat,  6 Nov 2021 11:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234031AbhKFL0h (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 6 Nov 2021 07:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhKFL0f (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 6 Nov 2021 07:26:35 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8FBC061570;
        Sat,  6 Nov 2021 04:23:53 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id x27so24216320lfu.5;
        Sat, 06 Nov 2021 04:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=BXlRYAh3YbYC5iv9ffYa4vhrR4jRNdTVq66Mwt+GBbg=;
        b=gsdlYLrvVpUTDPBvvJZS76uYyeUIpM5B+eIlVguR/cQJN6Cp+pxA2Cg3gnXAe+9rL1
         ziwR/yfXxbtJxR9D2cUNH+ZsAXyrMacNazeKA/8m+h9aI4uHasJ4HzX1Hqi7XXn/CXRH
         0sfg09EOHNebN+eSvHFNGtzCg1BdtAUE22c9oMsVfqQCV+Rs98zZuS7RduM1hQhR8+BE
         8mwuWhiWk7YjzllCfqiyJeE7S2nPUHup470Dfm2DpRvHMIlcm/2oi6Gj5xURXUrUjbmX
         Bcr2a8FcnpTeEGay5Eewdi3YGdgBtOp9pbpJVWRWUhFphzpn9P534lkfLXtj3bGcZvYW
         nQsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BXlRYAh3YbYC5iv9ffYa4vhrR4jRNdTVq66Mwt+GBbg=;
        b=0ClQfSTQzCGvWhH8M/MCfqbF4Nzh4X1HNVqRvRgbNGSe1mJG6zqm6THB57E+HCEyOH
         eF0RMyuh84IPN7wnLViqy4rX8asQlIufhcLYxcxgdHCvcrjL/OQdD6Qk+1EWIoik+YyP
         en5XCSGNEUZB94SysKoR66SlbUaqTdGqQA52zpBL7rsks93j2pQi+I269CHWP4xVVf/b
         rPuNDXSVXYVzqm1b7p6wB+d+20F1QlZ/k/5PmOHyiam7w0oQO+K8XtIp/EqIEjA9wYdh
         BaH9V3rdrysj+tACiY/HJpWrJ0J5N4jiPmA01aWDd+Z70PMxzRlUjbecSGyn+iH8Q21g
         N/Qw==
X-Gm-Message-State: AOAM532+hxb8SiNoTCBRybaF38SPsTWGT0tzx1x8s53Bw5v4+0UgfTqj
        jc0UhBjqNeN9dCyTgf20DvVpZ+GxU80=
X-Google-Smtp-Source: ABdhPJwAQ0K0aEpUaWJeJeSRvrwtwtjWJPD/UpOt9NZZanATEu5R1JZ/RppbBYH4qqNQmSq/sJGztA==
X-Received: by 2002:a19:5e42:: with SMTP id z2mr27215648lfi.102.1636197832193;
        Sat, 06 Nov 2021 04:23:52 -0700 (PDT)
Received: from [192.168.1.11] ([217.117.245.207])
        by smtp.gmail.com with ESMTPSA id d21sm877535lfv.78.2021.11.06.04.23.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Nov 2021 04:23:51 -0700 (PDT)
Message-ID: <9eafae1f-d9f0-298d-cf20-212865d0becc@gmail.com>
Date:   Sat, 6 Nov 2021 14:23:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] tty: vt: keyboard: do not copy an extra-byte in
 copy_to_user
Content-Language: en-US
To:     Ajay Garg <ajaygargnsit@gmail.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211106092041.43745-1-ajaygargnsit@gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20211106092041.43745-1-ajaygargnsit@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi, Ajay!

On 11/6/21 12:20, Ajay Garg wrote:
> Both (statically-allocated) "user_kdgkb->kb_string" and
> (dynamically-allocated) "kbs" are of length "len", so we must
> not copy more than "len" bytes.
> 
> Signed-off-by: Ajay Garg <ajaygargnsit@gmail.com>
> ---
>   drivers/tty/vt/keyboard.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
> index c7fbbcdcc346..dfef7de8a057 100644
> --- a/drivers/tty/vt/keyboard.c
> +++ b/drivers/tty/vt/keyboard.c
> @@ -2070,7 +2070,7 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
>   		len = strlcpy(kbs, func_table[kb_func] ? : "", len);

		^^^^^^^^^

len is reinitialized here, i.e len passed to kmalloc and len passed to 
copy_to_user() can be different.

strlcpy() returns strlen() of source string (2nd argument), that's why 
we need +1 here to pass null byte to user.

Am I missing something?


>   		spin_unlock_irqrestore(&func_buf_lock, flags);
>   
> -		ret = copy_to_user(user_kdgkb->kb_string, kbs, len + 1) ?
> +		ret = copy_to_user(user_kdgkb->kb_string, kbs, len) ?
>   			-EFAULT : 0;
>   
>   		break;
> 


With regards,
Pavel Skripkin
