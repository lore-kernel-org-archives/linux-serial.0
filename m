Return-Path: <SRS0=jKy5=43=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E44C10F27
	for <linux-serial@archiver.kernel.org>; Tue, 10 Mar 2020 14:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C44D20848
	for <linux-serial@archiver.kernel.org>; Tue, 10 Mar 2020 14:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cU08dHIl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgCJOkd (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 10 Mar 2020 10:40:33 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36910 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbgCJOkd (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 10 Mar 2020 10:40:33 -0400
Received: by mail-wr1-f67.google.com with SMTP id 6so16214524wre.4
        for <linux-serial@vger.kernel.org>; Tue, 10 Mar 2020 07:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=5RGsrWCswY35yK2g0l2ecBgd6UdadjKx28yIjLXJj8c=;
        b=cU08dHIlZyUvRiRuNbmSz4Ju2/+fPtbwwZ6gV9QfJrwGLsS6D8QHJMVp3NyxRrqQHX
         OdYd5kXZmSqJw/BIy2WNwKZ22cRUdfCbrtKWxj+RSWJgtRDgL/8cz7bFc09iwqijeHTR
         QwF5XSldE4FDuHXLTPEaxyulr/gYFXgPEMprQeiZRFWceHinC0p5WoCMxGivlJhER1My
         NxOXKmNFF+5OUGWG7bDHPhbXZ2RqsdAzaD2HlSpZnwQ18X66lteEz3pkTOdcxlVRfIGr
         HJLZN8b7HdrgHJSg2yK7Fxz/y7ESQT293TdDKhbpM2Vq0TBJzKwd7oe7QPzSLX70X6Hj
         Zxjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5RGsrWCswY35yK2g0l2ecBgd6UdadjKx28yIjLXJj8c=;
        b=V2tBLEV8ZAH83SK5mkZXNI0P0Sbr3t0XZ+ExRXjFhOPkMtxZ09JYachsr5GQxyIHoj
         46YNbRY4kHIRCkbKZYPzqRj+PvMIop9DEpACtARar++T+hIcoRKABkAanemlb222qVyy
         6CkbykSohYXshSnkQNkr91XaeS2Kr7UpelevNxsR9Eb4cm6GL6BJlPVJfBLXxjMxW7KE
         ldP3Q+iy4XrNEsNfKGjADHgapT9uDiaGXgyK9s0cAtujwbzZthz+Hw1M7VzOGQ4GKDE+
         eJVnaRwlJpo4Xsc1VKo0s1wSV4vQd1Qj3h8YUV1/f0K5CmZnAxVPr/cxc7W3VnD4lI7o
         qLSw==
X-Gm-Message-State: ANhLgQ12jNXg0j291XGoBDSUuw93fj5+zmPed/ovBwOUnwnE0lkPmKWs
        DCM1yTuv1AE4Neu4P4SCrUU=
X-Google-Smtp-Source: ADFU+vv9Ke1aIdoGOTPcojocsnZQhbFltKgvifFBeY61UyGNHbtBNAMP31uGo/9pkYFmHSX1DoB4Lg==
X-Received: by 2002:adf:eaca:: with SMTP id o10mr27550223wrn.401.1583851231551;
        Tue, 10 Mar 2020 07:40:31 -0700 (PDT)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id w16sm32990387wrp.8.2020.03.10.07.40.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2020 07:40:30 -0700 (PDT)
Subject: Re: [PATCH v1 2/4] serial: core: Print escaped SysRq Magic sequence
 if enabled
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
References: <20200310132004.86367-1-andriy.shevchenko@linux.intel.com>
 <20200310132004.86367-2-andriy.shevchenko@linux.intel.com>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Message-ID: <533ed799-6652-0a75-77be-1f1b1220ad46@gmail.com>
Date:   Tue, 10 Mar 2020 14:40:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200310132004.86367-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 3/10/20 1:20 PM, Andy Shevchenko wrote:
> It is useful to see on the serial console the magic sequence itself
> to enable SysRq without rummaging source code.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Dmitry Safonov <0x7f454c46@gmail.com>

> ---
>  drivers/tty/serial/serial_core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index ec3b833e9f22..e3f2afc15ad4 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -3191,8 +3191,11 @@ static const char sysrq_toggle_seq[] = CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE;
>  
>  static void uart_sysrq_on(struct work_struct *w)
>  {
> +	int sysrq_toggle_seq_len = strlen(sysrq_toggle_seq);
> +
>  	sysrq_toggle_support(1);
> -	pr_info("SysRq is enabled by magic sequence on serial\n");
> +	pr_info("SysRq is enabled by magic sequence '%*pE' on serial\n",
> +		sysrq_toggle_seq_len, sysrq_toggle_seq);
>  }
>  static DECLARE_WORK(sysrq_enable_work, uart_sysrq_on);
>  
> 

Thanks,
          Dmitry
