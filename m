Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99006C2BB48
	for <linux-serial@archiver.kernel.org>; Wed, 16 Dec 2020 00:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 725D622DD6
	for <linux-serial@archiver.kernel.org>; Wed, 16 Dec 2020 00:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725829AbgLPAy1 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 15 Dec 2020 19:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbgLPAyY (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 15 Dec 2020 19:54:24 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB80C061793;
        Tue, 15 Dec 2020 16:53:44 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id t22so6136844pfl.3;
        Tue, 15 Dec 2020 16:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZHsdjJjZYqPQQ8i9RcfIDAhMUcF69HvRYyLWExltWQU=;
        b=HvDfqr2btLaPZIHamotAAtuDzvG+19I2+HSQZgZNCKMcDLxuSfP2kSywuciHNPPMcJ
         sOttH1Zq+otbu1h05Cj96Qj7PMjx6HKgwdmRCKkspX6DBzj2OgFmItf4f6aaTnK1WqF/
         iZXdCv0oGtODW4AGiAo1BFOF9fXTaTpfifMI3Wn11QURwcV0WFMbJWUn8HLfMTOBJbRa
         uMtPz4cIs0ZyFLTolqHvPruDrRcHnTBiE2YiyzXYMd2ruTbiNZQY/J1cnit65KHWKly0
         yPoFLvKxrfe+EOJx5/ATGMpkqrTYwgCck8IsVggpeIYtBuLtQ3kx0axmwmz74RdNpJI8
         MxXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZHsdjJjZYqPQQ8i9RcfIDAhMUcF69HvRYyLWExltWQU=;
        b=MEMRQrq93RJzmukyViGO9SSSeqc8kzFJVNsEG8nI2mETQq/4snUdGbvoeD9h76AShf
         fn5Q4N5Gpo2W9T8kqwL00ev5hYVtsloPmuGs7ADn8NuGGOKa+eJLT8Vjd2UfJfcWDEH/
         cmHMZfiJcKcYmqZ3FU9rNKYE258IyVyV12Vekg1gu2pDBN8p6wA5jBVbxXh2ZW6mGmSG
         T4raacvVVEg3TGvE4VfUtL4/tcqxJkjV++sJ5l1yjBvNLw/Ya91He7bdgdIRz67lNNbb
         OCfEvBg1kgzmO+MZXkfiF9LtK9VL+qZAyxjcpNF7LoWZyS/LpjkLpRpI6enOeygt9feg
         uiuA==
X-Gm-Message-State: AOAM532JZAqbdxd1eOUSARlWBYYHX/sa415KGpXJADUl5kbONH0b3nEk
        TxOQs7YwcDTDtFJ1QoxJGYLUnaR+FDJerA==
X-Google-Smtp-Source: ABdhPJxZ4fpvNiEH6jU5uFr/OmWqs3yLe2/Ff+aGEJi0HtxAMVObs3lDB5tw8rdLkO24hswJbitQmQ==
X-Received: by 2002:a63:df0d:: with SMTP id u13mr30637030pgg.305.1608080023616;
        Tue, 15 Dec 2020 16:53:43 -0800 (PST)
Received: from [192.168.1.60] (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id v12sm173148pgq.3.2020.12.15.16.53.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 16:53:42 -0800 (PST)
Subject: Re: R: R: R: [PATCH v1] serial: 8250_fintek: Print Fintek chip name
To:     Flavio Suligoi <f.suligoi@asem.it>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20201214131445.954822-1-f.suligoi@asem.it>
 <X9dr2IvOgPyhsalE@kroah.com> <ff8f6af85d27448d93d1220545f163be@asem.it>
 <X9i9RKAbpoR0F7Y+@kroah.com> <178bf34c76184d39b6b17d5e54133821@asem.it>
 <X9jKTZoX9Se+Ghn/@kroah.com> <08c7185573314b5ba622e5a872defd33@asem.it>
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Message-ID: <47f3c665-df17-27ca-7835-5917f70a9665@gmail.com>
Date:   Wed, 16 Dec 2020 08:53:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <08c7185573314b5ba622e5a872defd33@asem.it>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

Flavio Suligoi 於 2020/12/15 下午 11:06 寫道:
>>> we produce some x86 boards with multistandard RS232/422/485 ports
>>> and, to have this feature, in some of these boards, we use a
>>> Fintek uart or superIO.
>>> So this additional info "extra_name" can be useful for
>>> a quick check if the serial ports are multistandard or not,
>>> without any other investigations, but using only a simple command
>>> like:
>>>
>>> dmesg| grep ttyS
>>
>> But as they work the same, why does it matter?
> 
> Yes you are right, by the user point of view, they are the same.
> 
>>
>> Userspace should not care here.  Isn't there some other id you can
>> read/query for a hardware database tool to determine this?


As Greg mentions, The userspace don't care what IC they are using.
We can use Linux RS485 API to control or check the serial port.

https://www.kernel.org/doc/html/latest/driver-api/serial/serial-rs485.html

-- 
With Best Regards,
Peter Hong
