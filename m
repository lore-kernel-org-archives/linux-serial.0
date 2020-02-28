Return-Path: <SRS0=j4md=4Q=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7FCC3F2D1
	for <linux-serial@archiver.kernel.org>; Fri, 28 Feb 2020 12:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06F02246A0
	for <linux-serial@archiver.kernel.org>; Fri, 28 Feb 2020 12:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgB1M7l (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 28 Feb 2020 07:59:41 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34196 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgB1M7l (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 28 Feb 2020 07:59:41 -0500
Received: by mail-wm1-f68.google.com with SMTP id i10so8195718wmd.1;
        Fri, 28 Feb 2020 04:59:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=gl/K3quWUljoEPQV4VV0LS4SMY0aYpsAWuBXNu17G6I=;
        b=bBIwJbT5HDLHJCeEdKyIP0C0EdsoZYHYvLpFKtEWsCMgxcho0m75JQDAzwN5alUIGr
         rvRPG5viFhaXg1rcHtHUHmMuMLpFjRNw1rPP0BhM1wLQPrVQ7aKVkc+MhjRtpb+f0Lfr
         FZMdgxBbpSps3K8TrN7dZxb4EeVedYSGNvFKD33xV4nCr7Vg7Ml+tlhqF7fFWJyLFVWO
         szauk75Qb5AGEYvROwHCDRdtDCAWj48KpaSrM6wjPCoCv35vBjwF65swwq1rub3dRWGi
         RjySh25rVMN0cDDOkNFqd4mINuajNNmqbyQvo/22Nwxn9NzPUXXKrQwSgLvFxCfhu+Ma
         WrBg==
X-Gm-Message-State: APjAAAWmI9PAV0u64T4IdcubvM/mblqlWWZWZLNkzV9TqVDNVeD3ILpS
        2gMTnjjGOI0vq8csLFToeq5zgMqiZ5s=
X-Google-Smtp-Source: APXvYqw9NSen7cQY5ihM6dPNjNQ+VKIrM+hDXiW7r0BWchfXJV1ew4T3l/YNj5JLz0Hcg78VH/Pc0g==
X-Received: by 2002:a05:600c:290:: with SMTP id 16mr2343285wmk.64.1582894778471;
        Fri, 28 Feb 2020 04:59:38 -0800 (PST)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id c9sm12581204wrq.44.2020.02.28.04.59.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2020 04:59:37 -0800 (PST)
Subject: Re: [PATCH 2/2] vt: selection, push sel_lock up
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+26183d9746e62da329b8@syzkaller.appspotmail.com
References: <20200228115406.5735-1-jslaby@suse.cz>
 <20200228115406.5735-2-jslaby@suse.cz> <20200228120332.GA3011426@kroah.com>
From:   Jiri Slaby <jslaby@suse.cz>
Autocrypt: addr=jslaby@suse.cz; prefer-encrypt=mutual; keydata=
 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
Message-ID: <71582fee-257c-3ef4-7c03-3d43651898ff@suse.cz>
Date:   Fri, 28 Feb 2020 13:59:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200228120332.GA3011426@kroah.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 28. 02. 20, 13:03, Greg KH wrote:
> On Fri, Feb 28, 2020 at 12:54:06PM +0100, Jiri Slaby wrote:
>> sel_lock cannot nest in the console lock. Thanks to syzkaller, the
>> kernel states firmly:
>>
>>> WARNING: possible circular locking dependency detected
>>> 5.6.0-rc3-syzkaller #0 Not tainted
>>> ------------------------------------------------------
>>> syz-executor.4/20336 is trying to acquire lock:
>>> ffff8880a2e952a0 (&tty->termios_rwsem){++++}, at: tty_unthrottle+0x22/0x100 drivers/tty/tty_ioctl.c:136
...
>>> other info that might help us debug this:
>>>
>>> Chain exists of:
>>>   &tty->termios_rwsem --> console_lock --> sel_lock
>>
>> Clearly. From the above, we have:
>>  console_lock -> sel_lock
>>  sel_lock -> termios_rwsem
>>  termios_rwsem -> console_lock
>>
>> Fix this by reversing the console_lock -> sel_lock dependency in
>> ioctl(TIOCL_SETSEL). First, lock sel_lock, then console_lock.
>>
>> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
>> Reported-by: syzbot+26183d9746e62da329b8@syzkaller.appspotmail.com
>> Fixes: 07e6124a1a46 ("vt: selection, close sel_buffer race")
> 
> As 07e6124a1a46 was marked for stable, both of these should be as well,
> right?

Ah, yes. My bad again, sorry.

> And did you happen to test these two with the syzbot tool to see if it
> really did fix the report?

Nope, this syz* stuff is a black magic for me. How can I do that?

thanks,
-- 
js
suse labs
