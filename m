Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D9EFC49EA7
	for <linux-serial@archiver.kernel.org>; Thu, 24 Jun 2021 13:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8DB5613C3
	for <linux-serial@archiver.kernel.org>; Thu, 24 Jun 2021 13:03:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbhFXNF2 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 24 Jun 2021 09:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbhFXNF1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 24 Jun 2021 09:05:27 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B004C061756;
        Thu, 24 Jun 2021 06:03:08 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id v13so2915572ple.9;
        Thu, 24 Jun 2021 06:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=E3eH9j6x/2bPR+R4Avd9Zya3U/JJfgeOubfcePdRb30=;
        b=TM507lOrxyUf7DwSIdZ7SwnXqo3TOVOBtptLkJUtdPw6FUmGiD5mxOBaHx62zls0Bb
         TuIqQC/7Itk4IJ8J79dXkgWHrjh72TtEfoI1LmnUQI/zcKb/P9uRPzRyA5BT24wRLv/R
         Ip4zGeZ1zd8Px2QZM/+PSCFZJN6D44+7AEnUiBv3jEx9wQkRK9icAfNLGBe0ozsVm/0T
         9XjJpBLGMC7P/68LRtijJlIPmMgyUlpDoZDGSUITbjWaAAsPhDrZTsl+vp79xS6nQt79
         /g0Sn01KE1QUWzkLPTPy4yZvKct4KYxAAXFfakZ8z7Pfl8RVYmYbU/SGP/79FpzlWjKK
         ktzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E3eH9j6x/2bPR+R4Avd9Zya3U/JJfgeOubfcePdRb30=;
        b=H7AYq/dWihGFuJLAafK3x+w1ciKJMRpB2r4Zv0RG9sRNz1py/4aersETiTRw3D4rbO
         tipQQGMfgsqp80o1gM7ot0LPtSca4n80MolmpmXAt/mDGQ7Zr+6ytuMffC0hs6BteJyr
         Y91SjJVESG+RCQ6ZfN2l0qFVbAyc7DhFoecSiMZrgHOxuW8tQryY0eHePcOkfpxG9T3G
         vGxlixOSEV3g+wF2nwg2jTp2uMjuL/8PFFo7ERjHBU78Ca1VdY6Fuc5bh2XOQvnifli8
         p4Qu8bU3a9up+7QsrHnyHFlhI+6kIPusK+REaaWwX3jxMoFNHgRrwgV+t8q2WwLy8dGj
         9kGA==
X-Gm-Message-State: AOAM533l38yzgrXnStu//sjq+Km1RG6uMawMuozzs3qmCWPwxdSw0e91
        2dARZ+UJ/hJ10lQdWFaC9i4=
X-Google-Smtp-Source: ABdhPJw/7HIeSLNQgrQDsvyahW7D55+qe5uZfS2tJQUQjAUWRCQM5f+XuC8Wy2S1cmK9CngRgiHofA==
X-Received: by 2002:a17:902:da8c:b029:127:a075:cb with SMTP id j12-20020a170902da8cb0290127a07500cbmr1224288plx.26.1624539787903;
        Thu, 24 Jun 2021 06:03:07 -0700 (PDT)
Received: from [192.168.0.118] ([103.242.196.10])
        by smtp.gmail.com with ESMTPSA id z24sm1939330pfr.79.2021.06.24.06.03.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jun 2021 06:03:07 -0700 (PDT)
Subject: Re: [question] De-registration does not remove port
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     vgupta@synopsys.com, Jiri Slaby <jirislaby@kernel.org>,
        linux-snps-arc@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org,
        Pavel Andrianov <andrianov@ispras.ru>
References: <3e131267-e1b3-1b83-f8be-0577da479223@gmail.com>
 <YNLfcKFL1LkJgXAR@kroah.com>
From:   Saubhik Mukherjee <saubhik.mukherjee@gmail.com>
Message-ID: <7af6c0a5-c990-5a40-104e-13f44b1cb4c5@gmail.com>
Date:   Thu, 24 Jun 2021 18:33:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YNLfcKFL1LkJgXAR@kroah.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 6/23/21 12:44 PM, Greg KH wrote:
> On Wed, Jun 23, 2021 at 11:42:36AM +0530, Saubhik Mukherjee wrote:
>> In drivers/tty/serial/arc_uart.c, arc_serial_remove always returns 0,
>> instead of calling uart_remove_one_port to remove uart port from serial
>> core. The comment says "This will be never be called". In my understanding,
>> a port added using uart_add_one_port should be removed during
>> de-registration.
>>
>> Is there a reason for this behavior?
> 
> Did you test the code to see if that function will ever be called?

I would like to reformulate the question: Suppose arc_serial_remove is 
never called. Then I would like to know how the driver de-registration 
is organized since the UART port is never removed?
