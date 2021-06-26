Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25536C2B9F4
	for <linux-serial@archiver.kernel.org>; Sat, 26 Jun 2021 03:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08CBE6195B
	for <linux-serial@archiver.kernel.org>; Sat, 26 Jun 2021 03:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhFZDoL (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 25 Jun 2021 23:44:11 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:35660 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbhFZDoK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 25 Jun 2021 23:44:10 -0400
Received: by mail-ed1-f47.google.com with SMTP id df12so16223575edb.2;
        Fri, 25 Jun 2021 20:41:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kb4tD9QFzLlnC9axfCwl7b++Nsd4PGLa4yuvLPb9qjs=;
        b=ao5aTtmjma7bYgPvBvcekOtJHkp9LI0XHIID+aMA2S5DprLH+PBQBzODJ9ESextEdw
         bfp54WEQqD29OGatiPipHzMisF3bt3kd25wiQ+5PIPIoFO4Py9Xv7yJxYqJ5or2IO04P
         oVxAcHYljXW3kCe/b51Z2MRd6FE8WhISnuh6PdMjE1kCDDqvqxFakNvNtg7tKQIhWc6r
         sKuFtcVES5lDKRWdehqITuxSogiUReY+SztXCbNsvw4jDgRXdgw0dOX5figLJi4n+XvC
         CtlBYWIHSWaGastzRFF2LYCoVIAJ5VGDPAl7OLrv/x2GrcsT20shBA7OANH/sjSCW3be
         ocDg==
X-Gm-Message-State: AOAM532WLfZHo5InzB4x6mXBOoWxhEpAh00GJQvYLAhLvSf95SVKPx5n
        K50LT9JGIh+6LUFr4naHgd07n1xboQs=
X-Google-Smtp-Source: ABdhPJyNFnJznUGR7p/hbof71VsAm7mCex525DNY+/yNfWza1N6fLesQUW178AnukhFCrRth1+tgVw==
X-Received: by 2002:a50:a447:: with SMTP id v7mr19323859edb.183.1624678906979;
        Fri, 25 Jun 2021 20:41:46 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id d13sm2470177edt.31.2021.06.25.20.41.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jun 2021 20:41:46 -0700 (PDT)
Subject: Re: [PATCH v2] serial: amba-pl011: add RS485 support
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux@armlinux.org.uk,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210618145153.1906-1-LinoSanfilippo@gmx.de>
 <YNSA1H0cFKiPUn6N@kroah.com> <5d7a4351-2adc-ea31-3290-91d91bd5a5d4@gmx.de>
 <db436292-4115-0755-57d8-d63986f84453@kernel.org>
 <trinity-163a08b4-6e39-4d15-bde2-815342f13fc4-1624620116191@3c-app-gmx-bs05>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <a89dec92-e764-c833-bbeb-ba3d84381e78@kernel.org>
Date:   Sat, 26 Jun 2021 05:41:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <trinity-163a08b4-6e39-4d15-bde2-815342f13fc4-1624620116191@3c-app-gmx-bs05>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On 25. 06. 21, 13:21, Lino Sanfilippo wrote:
> Thats right, the logic has slightly changed. I thought this does not matter as long as
> we make sure that exactly one of both ON_SEND or AFTER_SEND is set.

I actually don't know. But I would remain consistent with other drivers.

> We can stick with the logic
> in serial8250_em485_config() (i.e. always set ON_SEND and delete AFTER_SEND in case
> of an invalid setting), but I think this will require more than the four lines that we
> have now (especially if we want to avoid the !!).

What if you used only a single !?

thanks,
-- 
js
suse labs
