Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE124C43460
	for <linux-serial@archiver.kernel.org>; Thu,  6 May 2021 08:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93F2360E09
	for <linux-serial@archiver.kernel.org>; Thu,  6 May 2021 08:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbhEFIcx (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 6 May 2021 04:32:53 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:45908 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233479AbhEFIco (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 6 May 2021 04:32:44 -0400
Received: by mail-wm1-f47.google.com with SMTP id s5-20020a7bc0c50000b0290147d0c21c51so2555467wmh.4;
        Thu, 06 May 2021 01:31:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jdCwYwppTlBb66RQGVcaxMJxswPj0yVdGz+T2ee7UvU=;
        b=i2eHiRRvzlTL+6+4hSJnIfvQKv9h4CpOe+4lo8XUPqy65RpwF11of7nnpOWEZNzY+i
         qobPYi79FPH48Xkl2F5C97tFMaFAD8/OSdYIDZL8+urN3n8vDa0B9hCZgv6Wyjazpt+S
         JDr70Td4qT4ye2hzejp3TNZJ6pLRSuKKJueId3NGqhfp4cgbKSlxPHLsxFL0z5xFbn3g
         gkIp8pTonbFApDbzdvN7qodb8rsChhYtGBh0bZgIje1etZRsBYOk3wtd1i2W0SN10Of+
         KvGEXrcMqVRdVtDl4FTY9mt6mjJNGXQha1vqvy86y5rOQ2PnbOYRQVKcV2mbDcs5EmNF
         2tZQ==
X-Gm-Message-State: AOAM532g+QVCjND0BK2cX5LrAxfNxrZZ5YsU38lVWcpU5Sw85RJGpX8g
        7NUG9BpXT4UBtk4/ohh4Oi90QNBlbUjyWw==
X-Google-Smtp-Source: ABdhPJyteP3dy+j3FLa84WwMPk1u2FJXXKvIr5hwaOJRXcEmLu3SLt583QIZYlTF1065M2uhsd7Iug==
X-Received: by 2002:a1c:b60b:: with SMTP id g11mr14092208wmf.68.1620289898367;
        Thu, 06 May 2021 01:31:38 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id q20sm15785912wmq.2.2021.05.06.01.31.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 May 2021 01:31:37 -0700 (PDT)
Subject: Re: [PATCH 34/35] tty: make tty_get_byte_size available
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Joe Perches <joe@perches.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210505091928.22010-1-jslaby@suse.cz>
 <20210505091928.22010-35-jslaby@suse.cz>
 <ef1bd57095e941560530be43806791966a6735ad.camel@perches.com>
 <CAHp75Vfq6ABW7ukwaKmZOF2DszmuHD28S=wcLcFowvRdXTnWmg@mail.gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <7830c076-0d42-662c-5baa-2baecf1ad3b0@kernel.org>
Date:   Thu, 6 May 2021 10:31:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <CAHp75Vfq6ABW7ukwaKmZOF2DszmuHD28S=wcLcFowvRdXTnWmg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 06. 05. 21, 10:24, Andy Shevchenko wrote:
> if (!account_flags)
>    return bits;
> 
> ?

So I have:

unsigned char tty_get_byte_size(unsigned int cflag, bool account_flags)
{
         unsigned char bits;

         switch (cflag & CSIZE) {
         case CS5:
                 bits = 5;
                 break;
         case CS6:
                 bits = 6;
                 break;
         case CS7:
                 bits = 7;
                 break;
         case CS8:
         default:
                 bits = 8;
                 break;
         }

         if (!account_flags)
                 return bits;

         if (cflag & CSTOPB)
                 bits++;
         if (cflag & PARENB)
                 bits++;

         return bits + 2;
}

thanks,
-- 
js
suse labs
