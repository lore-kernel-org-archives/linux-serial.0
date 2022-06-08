Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FFD8C43334
	for <linux-serial@archiver.kernel.org>; Wed,  8 Jun 2022 08:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbiFHI6H (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 8 Jun 2022 04:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbiFHI53 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 8 Jun 2022 04:57:29 -0400
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDB63DFC5C;
        Wed,  8 Jun 2022 01:18:39 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id m20so39838347ejj.10;
        Wed, 08 Jun 2022 01:18:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=R6F0CDpGaTM+B6F9IgNcI5zYQkrD/OzPr5NTBsSy6CI=;
        b=T/G1HOLHvau5dBiAjjFaaTFVnez+9mR6M+W9VPqQqjspdzko01l7GSIYUxkSZ6qXOZ
         yLBrHKGDmjMvm6vfx1zkcfALpuusS2IzvdTXVsCLqrjyJ1vM0dJKUVSK5GKKtox14xjd
         7c7ofLURU5ZgpxQH0KAtT4xxM7T2hq1h228RWSC2LL7c9Ab7ONuc49p1g9l8PvY9qAfQ
         F0SZpG/D2s2jg5YSd7OvWTLslrS6E5lRER4m3GBfTJiB/ejkQt0aQWBimKwHm4o4UqAA
         ferBmDCKoqf/F2nxYo6YgzYkJ6hWREWSt1pi0XibLP1M2oOsigKMPh6q1YNL9eVHDqKC
         xIZA==
X-Gm-Message-State: AOAM5303qOdPPLaBUDIzeZi+1wPYY5ExQbjsWzSZ8AAryYIeNvJZrZMD
        OzswKoRS4s2JlmtnmmJW+40=
X-Google-Smtp-Source: ABdhPJwtthGbpaS/YHkXO9VDjVNhEuA9eBzbZ5evpL1jABtsb/kdS+Th36CHGmkqKooA1um2V/v+Ow==
X-Received: by 2002:a17:906:f996:b0:711:d208:bfb2 with SMTP id li22-20020a170906f99600b00711d208bfb2mr12214855ejb.163.1654676306459;
        Wed, 08 Jun 2022 01:18:26 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id ck16-20020a170906c45000b006feb20b5235sm8863850ejb.84.2022.06.08.01.18.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 01:18:25 -0700 (PDT)
Message-ID: <fdd3607e-cc2e-9f75-0553-a006aa0eddd5@kernel.org>
Date:   Wed, 8 Jun 2022 10:18:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 10/36] tty/vt: consolemap: introduce UNI_*() macros
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220607104946.18710-1-jslaby@suse.cz>
 <20220607104946.18710-10-jslaby@suse.cz>
 <2e2623a0-4b9f-f15d-78e0-d6e335bdcdff@linux.intel.com>
 <54049291-db20-a536-0615-cc3b56ceb3a3@kernel.org>
 <e9fdf394-9dd2-b1d3-29c9-66eb3353c0ec@kernel.org>
 <96808a-1c54-ed9b-ea35-565f49a6f360@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <96808a-1c54-ed9b-ea35-565f49a6f360@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 08. 06. 22, 10:02, Ilpo Järvinen wrote:
> It doesn't raise any warnings if I do:
> 
> #define UNI_DIR_BITS           GENMASK(15, 11)
> 
> As UNI_DIRS is 32 it cannot ever be larger than that?

Right, conv_uni_to_pc() properly checks:
   if (ucs > 0xffff)
       return -4;
before
   dir = dict->uni_pgdir[UNI_DIR(ucs)];


Even better!

I also noted to my TODO to check why ucs is "long" there. It makes no 
sense at all. Be it negative, or long-sized. IMO, it should simply be u32.

There is so much crap in the code :/...

thanks,
-- 
js
suse labs
