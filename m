Return-Path: <SRS0=iYMu=4J=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DD6C35640
	for <linux-serial@archiver.kernel.org>; Fri, 21 Feb 2020 08:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C58EC20637
	for <linux-serial@archiver.kernel.org>; Fri, 21 Feb 2020 08:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732839AbgBUIaU (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:30:20 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33112 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387477AbgBUIQI (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 21 Feb 2020 03:16:08 -0500
Received: by mail-wm1-f68.google.com with SMTP id m10so4587861wmc.0;
        Fri, 21 Feb 2020 00:16:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=+1THt+IQYItC43nkA6uEMA3TL4OZQRC2HipyCW3vLnA=;
        b=shmZdcwqDftWAQLjUOjRjRNAVhKigZ7kBBYNB7sIi+ZtU80J7g6WYskcy4R18B4zkH
         yUVEvQKotYyhtPTAqb+dkm6z0AQXWYFUjyks/6PCC0ZrQNWA9Dr+o5noJeWCjV0rastk
         Ere1g//26zFZqokJj1j9QGivadRaXK/D6xNcDN/49tMH1KuxjgmffWjxzHL9rNfkOg3T
         rYEMt6BU+Q0bNEtryXAkXv46V1J30AqNbiXFRrj4FlKJ58yjYOjIwg0BQJiT8AoBxMAh
         j/UFKREL4QdUaWZ5qPnomPeX4uaiKdyRxDrW8hw6dCL+xqX2yUttBNkKZwzzxdap4T+c
         tWSQ==
X-Gm-Message-State: APjAAAXH/dDAbXbh7prJIC3xvVQAKtGSl5D+dl5mQrJsR/37Uo6WBJkq
        mGmkI7A5aHbuVZNZmiyOzcP3iZoXyKwVOQ==
X-Google-Smtp-Source: APXvYqz9tYUSyCSz1aGkzB1BXY4p0Ixp0DiLA4SjwE6Qyp9LNoLJrKdTUryxOKdKgKK0KRYqSiBe1w==
X-Received: by 2002:a1c:4857:: with SMTP id v84mr2243868wma.8.1582272964437;
        Fri, 21 Feb 2020 00:16:04 -0800 (PST)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id r7sm742279wmh.45.2020.02.21.00.16.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2020 00:16:03 -0800 (PST)
Subject: Re: [PATCH 03/24] n_hdlc: convert debuglevel use to pr_debug
To:     Joe Perches <joe@perches.com>, gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200219084118.26491-1-jslaby@suse.cz>
 <20200219084118.26491-3-jslaby@suse.cz>
 <f3bac52dffc9e5402eb6c6106256dffaf550ee90.camel@perches.com>
From:   Jiri Slaby <jslaby@suse.cz>
Autocrypt: addr=jslaby@suse.cz; prefer-encrypt=mutual; keydata=
 mQINBE6S54YBEACzzjLwDUbU5elY4GTg/NdotjA0jyyJtYI86wdKraekbNE0bC4zV+ryvH4j
 rrcDwGs6tFVrAHvdHeIdI07s1iIx5R/ndcHwt4fvI8CL5PzPmn5J+h0WERR5rFprRh6axhOk
 rSD5CwQl19fm4AJCS6A9GJtOoiLpWn2/IbogPc71jQVrupZYYx51rAaHZ0D2KYK/uhfc6neJ
 i0WqPlbtIlIrpvWxckucNu6ZwXjFY0f3qIRg3Vqh5QxPkojGsq9tXVFVLEkSVz6FoqCHrUTx
 wr+aw6qqQVgvT/McQtsI0S66uIkQjzPUrgAEtWUv76rM4ekqL9stHyvTGw0Fjsualwb0Gwdx
 ReTZzMgheAyoy/umIOKrSEpWouVoBt5FFSZUyjuDdlPPYyPav+hpI6ggmCTld3u2hyiHji2H
 cDpcLM2LMhlHBipu80s9anNeZhCANDhbC5E+NZmuwgzHBcan8WC7xsPXPaiZSIm7TKaVoOcL
 9tE5aN3jQmIlrT7ZUX52Ff/hSdx/JKDP3YMNtt4B0cH6ejIjtqTd+Ge8sSttsnNM0CQUkXps
 w98jwz+Lxw/bKMr3NSnnFpUZaxwji3BC9vYyxKMAwNelBCHEgS/OAa3EJoTfuYOK6wT6nadm
 YqYjwYbZE5V/SwzMbpWu7Jwlvuwyfo5mh7w5iMfnZE+vHFwp/wARAQABtBtKaXJpIFNsYWJ5
 IDxqc2xhYnlAc3VzZS5jej6JAjgEEwECACIFAk6S6NgCGwMGCwkIBwMCBhUIAgkKCwQWAgMB
 Ah4BAheAAAoJEL0lsQQGtHBJgDsP/j9wh0vzWXsOPO3rDpHjeC3BT5DKwjVN/KtP7uZttlkB
 duReCYMTZGzSrmK27QhCflZ7Tw0Naq4FtmQSH8dkqVFugirhlCOGSnDYiZAAubjTrNLTqf7e
 5poQxE8mmniH/Asg4KufD9bpxSIi7gYIzaY3hqvYbVF1vYwaMTujojlixvesf0AFlE4x8WKs
 wpk43fmo0ZLcwObTnC3Hl1JBsPujCVY8t4E7zmLm7kOB+8EHaHiRZ4fFDWweuTzRDIJtVmrH
 LWvRDAYg+IH3SoxtdJe28xD9KoJw4jOX1URuzIU6dklQAnsKVqxz/rpp1+UVV6Ky6OBEFuoR
 613qxHCFuPbkRdpKmHyE0UzmniJgMif3v0zm/+1A/VIxpyN74cgwxjhxhj/XZWN/LnFuER1W
 zTHcwaQNjq/I62AiPec5KgxtDeV+VllpKmFOtJ194nm9QM9oDSRBMzrG/2AY/6GgOdZ0+qe+
 4BpXyt8TmqkWHIsVpE7I5zVDgKE/YTyhDuqYUaWMoI19bUlBBUQfdgdgSKRMJX4vE72dl8BZ
 +/ONKWECTQ0hYntShkmdczcUEsWjtIwZvFOqgGDbev46skyakWyod6vSbOJtEHmEq04NegUD
 al3W7Y/FKSO8NqcfrsRNFWHZ3bZ2Q5X0tR6fc6gnZkNEtOm5fcWLY+NVz4HLaKrJuQINBE6S
 54YBEADPnA1iy/lr3PXC4QNjl2f4DJruzW2Co37YdVMjrgXeXpiDvneEXxTNNlxUyLeDMcIQ
 K8obCkEHAOIkDZXZG8nr4mKzyloy040V0+XA9paVs6/ice5l+yJ1eSTs9UKvj/pyVmCAY1Co
 SNN7sfPaefAmIpduGacp9heXF+1Pop2PJSSAcCzwZ3PWdAJ/w1Z1Dg/tMCHGFZ2QCg4iFzg5
 Bqk4N34WcG24vigIbRzxTNnxsNlU1H+tiB81fngUp2pszzgXNV7CWCkaNxRzXi7kvH+MFHu2
 1m/TuujzxSv0ZHqjV+mpJBQX/VX62da0xCgMidrqn9RCNaJWJxDZOPtNCAWvgWrxkPFFvXRl
 t52z637jleVFL257EkMI+u6UnawUKopa+Tf+R/c+1Qg0NHYbiTbbw0pU39olBQaoJN7JpZ99
 T1GIlT6zD9FeI2tIvarTv0wdNa0308l00bas+d6juXRrGIpYiTuWlJofLMFaaLYCuP+e4d8x
 rGlzvTxoJ5wHanilSE2hUy2NSEoPj7W+CqJYojo6wTJkFEiVbZFFzKwjAnrjwxh6O9/V3O+Z
 XB5RrjN8hAf/4bSo8qa2y3i39cuMT8k3nhec4P9M7UWTSmYnIBJsclDQRx5wSh0Mc9Y/psx9
 B42WbV4xrtiiydfBtO6tH6c9mT5Ng+d1sN/VTSPyfQARAQABiQIfBBgBAgAJBQJOkueGAhsM
 AAoJEL0lsQQGtHBJN7UQAIDvgxaW8iGuEZZ36XFtewH56WYvVUefs6+Pep9ox/9ZXcETv0vk
 DUgPKnQAajG/ViOATWqADYHINAEuNvTKtLWmlipAI5JBgE+5g9UOT4i69OmP/is3a/dHlFZ3
 qjNk1EEGyvioeycJhla0RjakKw5PoETbypxsBTXk5EyrSdD/I2Hez9YGW/RcI/WC8Y4Z/7FS
 ITZhASwaCOzy/vX2yC6iTx4AMFt+a6Z6uH/xGE8pG5NbGtd02r+m7SfuEDoG3Hs1iMGecPyV
 XxCVvSV6dwRQFc0UOZ1a6ywwCWfGOYqFnJvfSbUiCMV8bfRSWhnNQYLIuSv/nckyi8CzCYIg
 c21cfBvnwiSfWLZTTj1oWyj5a0PPgGOdgGoIvVjYXul3yXYeYOqbYjiC5t99JpEeIFupxIGV
 ciMk6t3pDrq7n7Vi/faqT+c4vnjazJi0UMfYnnAzYBa9+NkfW0w5W9Uy7kW/v7SffH/2yFiK
 9HKkJqkN9xYEYaxtfl5pelF8idoxMZpTvCZY7jhnl2IemZCBMs6s338wS12Qro5WEAxV6cjD
 VSdmcD5l9plhKGLmgVNCTe8DPv81oDn9s0cIRLg9wNnDtj8aIiH8lBHwfUkpn32iv0uMV6Ae
 sLxhDWfOR4N+wu1gzXWgLel4drkCJcuYK5IL1qaZDcuGR8RPo3jbFO7Y
Message-ID: <c0b9a410-c3db-a7ac-729c-fd204d7bd20d@suse.cz>
Date:   Fri, 21 Feb 2020 09:16:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <f3bac52dffc9e5402eb6c6106256dffaf550ee90.camel@perches.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 19. 02. 20, 13:20, Joe Perches wrote:
> On Wed, 2020-02-19 at 09:40 +0100, Jiri Slaby wrote:
>> With pr_debug we have a fine-grained control about debugging prints. So
>> convert the use of global debuglevel variable and tests to a commonly
>> used pr_debug. And drop debuglevel completely.
>>
>> This also implicitly adds a loglevel to the messages (KERN_DEBUG) as it
>> was missing on most of them.
> []
>> diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
> []
>> @@ -310,11 +306,9 @@ static int n_hdlc_tty_open (struct tty_struct *tty)
>>  {
>>  	struct n_hdlc *n_hdlc = tty2n_hdlc (tty);
>>  
>> -	if (debuglevel >= DEBUG_LEVEL_INFO)	
>> -		printk("%s(%d)n_hdlc_tty_open() called (device=%s)\n",
>> -		__FILE__,__LINE__,
>> -		tty->name);
>> -		
>> +	pr_debug("%s(%d)%s() called (device=%s)\n",
>> +			__FILE__, __LINE__, __func__, tty->name);
> 
> Perhaps remove all the __FILE__ and __LINE__ arguments as
> dynamic debug could emit module and __LINE__ when necessary.

Noted for later.

thanks,
-- 
js
suse labs
