Return-Path: <SRS0=XS4C=B5=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E067FC433DF
	for <linux-serial@archiver.kernel.org>; Wed, 19 Aug 2020 07:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B93EC207DA
	for <linux-serial@archiver.kernel.org>; Wed, 19 Aug 2020 07:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597821069;
	bh=Q1TUCVyfAYh8p7Z2eIiuchdSuHa7Tv2QtwNlIaXU4+Y=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=NXDz/1YHMEuiu+zSi9DQlWfGHJldxTvYmOUkztt71COMd/wAmf5f7AkPMuxlrWVsf
	 KeJCg++Xn6jg5Qoc8OHkkQIsk2dR8EiYOenAICnocxb8owNbzTHS8ag0V/yFIMQvdS
	 DlYU09yP908LhY+YEtGIMLIImQT5YrLhDtu5DSew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgHSHK6 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 Aug 2020 03:10:58 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35664 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbgHSHJH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 Aug 2020 03:09:07 -0400
Received: by mail-ed1-f68.google.com with SMTP id m20so17238994eds.2;
        Wed, 19 Aug 2020 00:09:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=fEkH4ZxpxTY42f36NAcppi2kiNk4M3AwqeTbG0SRAps=;
        b=XMNlfuMgTF6xKPHeD7ii2g8uJGlt3u0JfKNKWQ9ZPkL9taZouE2W9RhhuFCqAPHdHr
         dGospbZKYb0yYd8LeJqqKnWsbDeyp0hjDkGLcByuIU99Tz2ylDhv/cIBtfLMpMk+oaWl
         sj5OllHnOq8+6G/hGbus3OvuzSLIogvpo5EACMT8sKpfoELXLLJ/vSisMklCNQI5ldy8
         SLXfrAc0Uo6C0bKfN0Y6vJyxdS7yXzN970qkRW2Uhz8zCZQAyWNiSdnfUf5rhDGPFbl0
         TcHPTodnFkSAauwilRpFlZ8RU1HdRcrwu+203l9v8fvBmC71gJtgEGTsrNYHIsymoPKU
         cQgw==
X-Gm-Message-State: AOAM531K4tTU6wxbZNkOUynE3jkR5Qr7tcRPh/fOVVn8jfWPwRSww5K5
        gGNiPhRizyTpeNEhVuc2YxB9Fw/6iV4=
X-Google-Smtp-Source: ABdhPJzZjN7yLJ+YMGWbIoHiOG2baBTgjcXtigIJw11DlVTj77AU08DC1d25Da8nBcT/V81rq9KKcg==
X-Received: by 2002:a50:fd83:: with SMTP id o3mr22404496edt.170.1597820942993;
        Wed, 19 Aug 2020 00:09:02 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id t19sm17329336edw.63.2020.08.19.00.09.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2020 00:09:02 -0700 (PDT)
Subject: Re: [PATCH 02/16] vt: declare xy for get/putconsxy properly
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200818085706.12163-1-jslaby@suse.cz>
 <20200818085706.12163-2-jslaby@suse.cz> <20200818114341.GA343779@kroah.com>
From:   Jiri Slaby <jirislaby@kernel.org>
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
Message-ID: <791f5ae5-134e-794d-903e-a39d5f6ac3e2@kernel.org>
Date:   Wed, 19 Aug 2020 09:09:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200818114341.GA343779@kroah.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 18. 08. 20, 13:43, Greg KH wrote:
> On Tue, Aug 18, 2020 at 10:56:52AM +0200, Jiri Slaby wrote:
>> That is:
>> 1) call the parameter 'xy' to denote what it really is, not generic 'p'
>> 2) tell the compiler and users that we expect an array:
>>    * with at least 2 chars (static 2)
>>    * which we don't modify in putconsxy (const)
>>
>> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
>> ---
>>  drivers/tty/vt/vt.c       | 10 +++++-----
>>  include/linux/selection.h |  4 ++--
>>  2 files changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
>> index 8f283221330e..a0da7771c327 100644
>> --- a/drivers/tty/vt/vt.c
>> +++ b/drivers/tty/vt/vt.c
>> @@ -4769,17 +4769,17 @@ unsigned short *screen_pos(const struct vc_data *vc, int w_offset, int viewed)
>>  }
>>  EXPORT_SYMBOL_GPL(screen_pos);
>>  
>> -void getconsxy(const struct vc_data *vc, unsigned char *p)
>> +void getconsxy(const struct vc_data *vc, unsigned char xy[static 2])
> 
> I didn't realize we could do "[static 2]" in the kernel now, is that
> thanks to the bump of the minimum gcc version?  If so, nice!

gcc supports it since some time around 3.x (these kinds of declaration
are defined in c99). So hopefully nothing breaks.

thanks,
-- 
js
suse labs
