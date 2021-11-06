Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C08C433EF
	for <linux-serial@archiver.kernel.org>; Sat,  6 Nov 2021 22:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC9E660E94
	for <linux-serial@archiver.kernel.org>; Sat,  6 Nov 2021 22:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhKFWP3 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 6 Nov 2021 18:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbhKFWP3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 6 Nov 2021 18:15:29 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C26AC061570;
        Sat,  6 Nov 2021 15:12:47 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id j2so26688598lfg.3;
        Sat, 06 Nov 2021 15:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=NeiT0mSDoDVgb/7n1xYrK8xG03w6WQESwJe/usLnGKM=;
        b=ZlTXxAPnbBPHW57L0y7QLsrOaosn3J8pBbhdZl5X83yqmODNh8txyGAQlQzvx5879x
         4w5iCRjNrniPNZ9m/kxtaQe9Ti6O/VRzTSO8HtU1jouEGBcShJudSxAQ1fBK/rrQP5zH
         L5ziLUjbvtlxsUuxXAmqU+vBNe4LU+lPUtbf06I/iEeTUWlmjyyYgRuFvnIuWi7+Z1AG
         jsdXyjuope+/Hnumhy37+mms++Kox6y1/YZ7V+SQpF6rBE/vDd1wD7wLRVtq3FlJxyiA
         YgT+3xmWjWZn7hJApJHo5QbWRkseL5CjNWrPvKdgZ8fExkpO2nNSQ/3IfF/OwMcY2Ye3
         BZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NeiT0mSDoDVgb/7n1xYrK8xG03w6WQESwJe/usLnGKM=;
        b=S7Aea/7xGlhB/4B59gvyQNnMrVnSbXu8hFaUBGWmUo108Ydy2DHYYJ+sf2ZuJPbQR2
         MFuP3E2WKazuwt0om2Yg4dSPVVmfMP4wac9Iy2XCruWy9xTb5QUote2P434wzF1p3vci
         P8a4xLjCarQodnm5oPA4NLrsvlgaxChgmbfxJqtdoEXg/KSV31JDa+mWvL1vEoC/FuvN
         jyh0i3uBDZ1ahu0Cm3o2JlXgMRXHUAB07X+NaNMVmV2f/9WULNXbkDGCRM56YNveBwPy
         IwXkwTKCCBbeZgYJwO2JjfmalG2tsJpvfSNYN85aDs4JUjK/Q5bJPSLSin8v+edCfqe8
         aPsg==
X-Gm-Message-State: AOAM533wLIev4bGEnckZyQgrZeUi302SEWp78LcvVeOlxlv8tmt4U1c1
        TClwCWKtxeocfO83zzfP+Xiq3Q2n5r4=
X-Google-Smtp-Source: ABdhPJyx2OYWgFFJj7SbFvRCAdz6bnSvdmUikwcRJaBdSxuUHHjM4vfjvwcjKICXrz5mVdF0XKnfEw==
X-Received: by 2002:a05:6512:c28:: with SMTP id z40mr3336166lfu.457.1636236765678;
        Sat, 06 Nov 2021 15:12:45 -0700 (PDT)
Received: from [192.168.1.11] ([217.117.245.207])
        by smtp.gmail.com with ESMTPSA id p3sm160926lfg.273.2021.11.06.15.12.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Nov 2021 15:12:45 -0700 (PDT)
Message-ID: <8d0346ba-4819-c25e-f208-0b51116d9147@gmail.com>
Date:   Sun, 7 Nov 2021 01:12:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v3] tty: vt: keyboard: add default switch-case, to handle
 smatch-warnings in method vt_do_kdgkb_ioctl
Content-Language: en-US
To:     Ajay Garg <ajaygargnsit@gmail.com>, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, andriy.shevchenko@linux.intel.com,
        kernel@esmil.dk, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211106220315.392842-1-ajaygargnsit@gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20211106220315.392842-1-ajaygargnsit@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 11/7/21 01:03, Ajay Garg wrote:
> diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
> index c7fbbcdcc346..b83e7669658d 100644
> --- a/drivers/tty/vt/keyboard.c
> +++ b/drivers/tty/vt/keyboard.c
> @@ -2090,6 +2090,12 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
>   
>   		ret = 0;
>   		break;
> +	default: {
> +		kbs = NULL;
> +		ret = -ENOIOCTLCMD;
> +
> +		break;
> +	}

Are these brackets needed here? There are no local variables inside 
default case.


just my 2c,

With regards,
Pavel Skripkin
