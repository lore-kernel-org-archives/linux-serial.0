Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7469FC433F5
	for <linux-serial@archiver.kernel.org>; Mon,  8 Nov 2021 07:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B890610A0
	for <linux-serial@archiver.kernel.org>; Mon,  8 Nov 2021 07:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236311AbhKHHGL (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 8 Nov 2021 02:06:11 -0500
Received: from mail-ed1-f50.google.com ([209.85.208.50]:39525 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236168AbhKHHGK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 8 Nov 2021 02:06:10 -0500
Received: by mail-ed1-f50.google.com with SMTP id r12so58424132edt.6;
        Sun, 07 Nov 2021 23:03:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aPfdZWgB3g/V643+XMmyCN4+ogGJp3gQCDA9ui5E1hI=;
        b=Ma9FQqCpz7pA25/hshYsjjm2POo9wbtBozfInfI10llgVrSWm8iqi574hz8NuOkyR2
         qJudCtbhf+102Gbq87ARZd+kCHWF2uXBhfaxGzYx3f1yTLBQM4R7HiTWUQRqoSrW+RAp
         PttFrrRnikTIBV7K2Wap/pZvJ53nwoJqOOprz21SHI4kPBCZ/NTabqXZx2x3ijbdGeFH
         tniagiXaiQx8loXBh13aCZkK9pOvKC5H2PsgKt/pqcar9Y4nAQvv/3ay49orcagDoumS
         DuIBLSFubBmpLbInKkHLC5ADwBZkxB53DVBIE+WMdbGYWapYjHHByNjGBIw0APpHwQEr
         ocSw==
X-Gm-Message-State: AOAM533UXPdJHRDrO/bZY35QX6Wlf8zVAADq50sEhgUgQ3JJ2QODxBK1
        ZoE/5dBlXSgCaSi1iVIfcYmt/XtTufc=
X-Google-Smtp-Source: ABdhPJwZJItmY33mo1PNL8oxFCZNejArA89JL438uYHj/Tmioc6GGhUwMTXmdxmLleCNA3jyi3/Lkw==
X-Received: by 2002:a50:d4cd:: with SMTP id e13mr104310252edj.29.1636355005281;
        Sun, 07 Nov 2021 23:03:25 -0800 (PST)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id he17sm4181817ejc.110.2021.11.07.23.03.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Nov 2021 23:03:24 -0800 (PST)
Message-ID: <3ab0e357-dbea-e5aa-49c0-d02b49d532dd@kernel.org>
Date:   Mon, 8 Nov 2021 08:03:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v4] tty: vt: keyboard: add default switch-case, to handle
 smatch-warnings in method vt_do_kdgkb_ioctl
Content-Language: en-US
To:     Ajay Garg <ajaygargnsit@gmail.com>, gregkh@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com, kernel@esmil.dk,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     paskripkin@gmail.com
References: <20211107031721.4734-1-ajaygargnsit@gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20211107031721.4734-1-ajaygargnsit@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 07. 11. 21, 4:17, Ajay Garg wrote:
> smatch-kchecker gives the following warnings when run on keyboard.c :
> 
> vt_do_kdgkb_ioctl() error: uninitialized symbol 'kbs'.
> vt_do_kdgkb_ioctl() error: uninitialized symbol 'ret'.
> 
> This usually happens when switch has no default case and static
> analyzers and even sometimes compilers can’t prove that all possible
> values are covered.
> 
> 
> Thus, the default switch-case has been added, which sets the values
> for the two variables :

Just to shut up random static analyzers? Please don't.


-- 
js
suse labs
