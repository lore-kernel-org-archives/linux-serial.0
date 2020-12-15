Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A86C4361B
	for <linux-serial@archiver.kernel.org>; Tue, 15 Dec 2020 00:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C68722226A
	for <linux-serial@archiver.kernel.org>; Tue, 15 Dec 2020 00:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729242AbgLOAa2 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 14 Dec 2020 19:30:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbgLOAaY (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 14 Dec 2020 19:30:24 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9BFC061793;
        Mon, 14 Dec 2020 16:29:44 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id g18so14050146pgk.1;
        Mon, 14 Dec 2020 16:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jL8gEw3KjszESCiPFTBqaClClb2pp1eS3R1B+8QHNwI=;
        b=BFpZvX9tKF8LN/zcRBIJMD/HpdGXHKDX7v3fwNBMw9fObOLv43UQtrkyJbwHAnNJ82
         SCDWeYl05r0N6dbHQfTsPAGfNzReRuLvXs4RNKIC7kkL4GHWEfF6hLt9x0+O10zBkB/w
         tQpIr0pUBhnIpP1db0y5DX+DmOYhdEybgwfnq5ZKv3L91E4pZbLyuUZTpf8dsi36c8B/
         3YHJKkyAShCPcn3AG8TvOE1lMolYSzOx5T0o9D9nc/rJwJ4VNSsk/zRozH46rJNR/kQT
         w/D5YC56l5szvV7g6rx6DjFX8yA734tbWoP8mJlBIDZDtI6rMydJ3QpnqbAOV5ZZmMxX
         VdvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jL8gEw3KjszESCiPFTBqaClClb2pp1eS3R1B+8QHNwI=;
        b=U1JdH95FtBVaYy4BejoQy/RY7B74qYwhhWeCtjgeC4aTW8VDtPeCnfobn9yCV4rRUK
         546Q1KH3QM8BHw8ZZzqghaKgBA1aVelZaeFjqWYaL1EHGDk1wL0MiC93ewDZkIIs2LpP
         q6WK3Hn0/ntpqBwlGfciQjE6msNKcdz9IaVOk84ThkUau3FYvMwcsZn54VJxjG7CbHzx
         x25t0yqh2vj0AGXDs4dcQKFEuFrGBaPLIiF2q6xXO2ISyfJbBG/mdKah9G2asUUWPIq+
         nZojhp91y6qGzey16OUNclXRXLs/QS3XnZgdaz5Ntc+qZQDLxRp1sosAsNeFYHKrknmj
         fOEA==
X-Gm-Message-State: AOAM530T25TajZASeJyzXV67+T2Fs+R24+muVNrWj276+g09ScCNwWdp
        LFBasJ3ZVGV+Yw54QHqDweFGpaHGMS/BFA==
X-Google-Smtp-Source: ABdhPJxRieM0KSeN1Aw59xtHFgi21XDqajp6HP/I7XNNRrDTI0++uAeR8DOEdgR/jfEGmWP6wEXR0Q==
X-Received: by 2002:a05:6a00:1593:b029:198:195:4d93 with SMTP id u19-20020a056a001593b029019801954d93mr26280189pfk.32.1607992183684;
        Mon, 14 Dec 2020 16:29:43 -0800 (PST)
Received: from [192.168.1.60] (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id jz20sm19380479pjb.4.2020.12.14.16.29.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Dec 2020 16:29:42 -0800 (PST)
Subject: Re: [PATCH v1] serial: 8250_fintek: Print Fintek chip name
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Flavio Suligoi <f.suligoi@asem.it>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201214131445.954822-1-f.suligoi@asem.it>
 <X9dr2IvOgPyhsalE@kroah.com>
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Message-ID: <1b5f557d-165b-d2be-2c61-ef133019edf7@gmail.com>
Date:   Tue, 15 Dec 2020 08:29:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <X9dr2IvOgPyhsalE@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

Greg Kroah-Hartman 於 2020/12/14 下午 09:42 寫道:
>>   	pdata->pid = chip;
>> +
>> +	pr_info("%s%s%s Fintek %s\n",
>> +		uart->port.dev ? dev_name(uart->port.dev) : "",
>> +		uart->port.dev ? ": " : "",
>> +		uart->port.name,
>> +		chip_name);
> 
> Drivers, if all goes well, should not print anything to the kernel log.
> This isn't ok.
> 
> And even if it was, dev_info() would be the correct thing to do...

Maybe can transform pr_info() to dev_dbg() for debug usage ?

-- 
With Best Regards,
Peter Hong
