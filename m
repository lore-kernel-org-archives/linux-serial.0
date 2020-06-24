Return-Path: <SRS0=VIcj=AF=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D54C433DF
	for <linux-serial@archiver.kernel.org>; Wed, 24 Jun 2020 09:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1E0320885
	for <linux-serial@archiver.kernel.org>; Wed, 24 Jun 2020 09:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592991783;
	bh=KASGkkb2+9TZ5D3MTFps6xxCzzfzZnMWkY3aYuoNZBY=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=M+Kk/zanY6NcFQSI4xlqx4jyqXOmdz4v1phnSrtYdwjP6ON7Du5jOWilampE9vnAL
	 fv9GfWsOPl5+XkAYjICxIL0s9CWyRp6A5N8jwWsbnPdH3bO20rl7SE6N7ZD/Hot34d
	 U9lqLCo2q5T+2yPYXpxjnwY/HIUN6uyczuDvzxx8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389330AbgFXJnD (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 24 Jun 2020 05:43:03 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:33683 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388005AbgFXJnD (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 24 Jun 2020 05:43:03 -0400
Received: by mail-ej1-f65.google.com with SMTP id n24so1830997ejd.0;
        Wed, 24 Jun 2020 02:43:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tuRg7gxTgMVv/uknaC+ELM+anUqsXoZl+UXIEfmUtI8=;
        b=nCVNzS09I7YYKan0SKKC5cycBPYap9XyBDmHfAKVAoI0hgAgYJ3o6v8mYJGN90Pseq
         YRTYTxhQ4Vdl3SbeVO/ukqqLzWsiigvjbpKdxGBhiQuj0q10o+s6SHn4DyvCGhVtAG4+
         JgcLvfJpfmq4xmIt8Pt3oNZDImC3FXxnXNQOfEKG6teRhVfPdZN20wId+5/Fi9UWfUoV
         n4e07rDhiUdt+zH8o6wYfHtSs/+N1dasoJkxCFM46PuXj5TAFot1nt+T4qK2OMAKYtSO
         fXBP+PQKS3vewYNtO1sZY/GQN6IbeTQLC2SgyiGzhMgFMDo4RYgTbmQxtPIqd7PbYqKj
         YtJw==
X-Gm-Message-State: AOAM533KsAdgEWoOjEcEKcf/tdg7nRDbkueWdTzFjCYfTYFOq6rQPkLG
        IvrK2b0onkLwvKoBIgRhf1s=
X-Google-Smtp-Source: ABdhPJyXuw1w74SJp+f5TnTPPdp4LJtBdwIvxmYExbMYBQxxIMYMugMnVTgU9jBcDGAcIDuY7XsGyw==
X-Received: by 2002:a17:906:7ad7:: with SMTP id k23mr25079698ejo.439.1592991780914;
        Wed, 24 Jun 2020 02:43:00 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id f17sm3036261ejr.71.2020.06.24.02.43.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2020 02:43:00 -0700 (PDT)
Subject: Re: [PATCH] tty: serial_core: Fix uart_state refcnt leak when the
 port startup
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        yuanxzhang@fudan.edu.cn, kjlu@umn.edu,
        Xin Tan <tanxin.ctf@gmail.com>
References: <1592052738-95202-1-git-send-email-xiyuyang19@fudan.edu.cn>
 <20200624093407.GB1751086@kroah.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <954840f0-2078-fe0f-1e52-d985a4997564@kernel.org>
Date:   Wed, 24 Jun 2020 11:42:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200624093407.GB1751086@kroah.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 24. 06. 20, 11:34, Greg Kroah-Hartman wrote:
> On Sat, Jun 13, 2020 at 08:52:18PM +0800, Xiyu Yang wrote:
>> uart_port_startup() invokes uart_port_lock(), which returns a reference
>> of the uart_port object if increases the refcount of the uart_state
>> object successfully or returns NULL if fails.
>>
>> However, uart_port_startup() don't take the return value of
>> uart_port_lock() as the new uart_port object to "uport" and use the old
>> "uport" instead to balance refcount in uart_port_unlock(), which may
>> cause a redundant decrement of refcount occurred when the new "uport"
>> equals to NULL and then cause a potential memory leak.
>>
>> Fix this issue by update the "uport" object to the return value of
>> uart_port_lock() when invoking uart_port_lock().
>>
>> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
>> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
>> ---
>>  drivers/tty/serial/serial_core.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
>> index 57840cf90388..968fd619aec0 100644
>> --- a/drivers/tty/serial/serial_core.c
>> +++ b/drivers/tty/serial/serial_core.c
>> @@ -205,7 +205,7 @@ static int uart_port_startup(struct tty_struct *tty, struct uart_state *state,
>>  	if (!page)
>>  		return -ENOMEM;
>>  
>> -	uart_port_lock(state, flags);
>> +	uport = uart_port_lock(state, flags);
> 
> How is this a different pointer than you originally had?

Was this patch sent twice? As I had very same questions on the other
one, but never received a feedback:
https://lore.kernel.org/linux-serial/bf6c1e7b-3dc6-aba6-955a-fee351a6d800@suse.com/


Oh, wait: this is uart_port_startup, I commented on the uart_shutdown
one. But whatever, I would scratch both of them.

> And if it is a different pointer, shouldn't you be calling this function
> and using the pointer much earlier in the function instead of just here?
> 
> Can you trigger a problem that this patch solves?  If so, how?

thanks,
-- 
js
suse labs
