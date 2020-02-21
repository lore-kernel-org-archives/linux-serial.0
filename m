Return-Path: <SRS0=iYMu=4J=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806BCC3565B
	for <linux-serial@archiver.kernel.org>; Fri, 21 Feb 2020 19:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 504CA206E2
	for <linux-serial@archiver.kernel.org>; Fri, 21 Feb 2020 19:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAH5OMkF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbgBUTKb (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 21 Feb 2020 14:10:31 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39644 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbgBUTKa (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 21 Feb 2020 14:10:30 -0500
Received: by mail-lf1-f66.google.com with SMTP id n30so1454537lfh.6;
        Fri, 21 Feb 2020 11:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uHowV/ER1jV7ml5qvZrVFJn7AemGPNZYwVliqP36QYw=;
        b=SAH5OMkFdGtk9oHkzbLJJSKQHgvWzmI5RBWbYve752WF8/tFhfeI9SbMFTIdQ9uL0d
         Vq4e3QKNAU1W5HY98vc7UPHefXsWyaCIz8lagxtqFagm0BIP38CZVrimQf1exDv2dUiw
         BcKWKMK4doKxk+uEeJVq27eCXdk+nm+np7FAOv0bA5ZHCycUI/ytmCSHKoJtLm0VkpnD
         NyWg4wP0EJ+wu74uhjb09FKgknSNbl1nXopX9TBmOiGL9eTnhz4wK3YDcv5Gj0jcEbP3
         aqZY4egBl5+k4moWSFkQDYQ+m/ymsjsqriAZ1Cqe+q/5cRbP0GSEKQXZOVQsIXQeTtvd
         UznA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uHowV/ER1jV7ml5qvZrVFJn7AemGPNZYwVliqP36QYw=;
        b=QdHN1xzItVz8Z5lRSQ+VNArDuB9QfrAg71G6QnR5y4SG67/fFjukIjp/4cl60Bdhva
         DYYMF03W3j7bp3Q9xeBLn1OwwOl+7wt2qU7PbDPENlTWcRRG5X3ndvgz4NKVL5dhiKqV
         lw8r1uE4vnk8XRk0cS7Cyvo/pP+eZolsSor6ctLOvDZnWUia57FIu5R0C6eW92Ykaxkx
         53LwmWgBkbnEWEfGI6hr9z7e6fcFzU47p6NuY9BURL1mzqkcGEIsJWT+tn4qrLFlBMoG
         N4e81VrOQhIdCmBgUumjQ3ex1MhZgSv2rJgNa6bocqJuXOEayYGg/WIl9pPN1JKnm1+F
         Vp4A==
X-Gm-Message-State: APjAAAVOLmA7gOAnnLazDJWHzBUNZP2+5Cyh3NqKJMuG3HjcI6FNQm72
        vYUwq/dX8LunS/SliAYGt77kbfj+
X-Google-Smtp-Source: APXvYqwVeTJz9to9o2SyGyf5HKQIVsBCVpweTnyOA4imSqj4VBG64NQCimLgX0A2FCDHa3XYJUq+DQ==
X-Received: by 2002:ac2:5ec3:: with SMTP id d3mr21058392lfq.176.1582312228058;
        Fri, 21 Feb 2020 11:10:28 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id p26sm2120131lfh.64.2020.02.21.11.10.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2020 11:10:27 -0800 (PST)
Subject: Re: [PATCH for 5.6 v2] tty: serial: tegra: Handle RX transfer in PIO
 mode if DMA wasn't started
To:     Jon Hunter <jonathanh@nvidia.com>, Jiri Slaby <jslaby@suse.cz>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200209164415.9632-1-digetx@gmail.com>
 <15b01f79-007d-09bb-03be-050c009ceff6@suse.cz>
 <4d9a2352-6daa-4dcc-376b-175b1398ff6a@gmail.com>
 <01397ba1-a738-257a-adb1-84cdcba68a57@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <008a54e3-3585-2f73-a4cb-198fd2fa725a@gmail.com>
Date:   Fri, 21 Feb 2020 22:10:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <01397ba1-a738-257a-adb1-84cdcba68a57@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

19.02.2020 17:38, Jon Hunter пишет:
> 
> On 19/02/2020 12:25, Dmitry Osipenko wrote:
>> 17.02.2020 10:37, Jiri Slaby пишет:
>>> On 09. 02. 20, 17:44, Dmitry Osipenko wrote:
>>>> It is possible to get an instant RX timeout or end-of-transfer interrupt
>>>> before RX DMA was started, if transaction is less than 16 bytes. Transfer
>>>> should be handled in PIO mode in this case because DMA can't handle it.
>>>> This patch brings back the original behaviour of the driver that was
>>>> changed by accident by a previous commit, it fixes occasional Bluetooth HW
>>>> initialization failures which I started to notice recently.
>>>>
>>>> Fixes: d5e3fadb7012 ("tty: serial: tegra: Activate RX DMA transfer by request")
>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>> ---
>>>>
>>>> Changelog:
>>>>
>>>> v2: - Corrected commit's title by adding the accidentally missed "tegra: "
>>>>       to the prefix.
>>>>
>>>>  drivers/tty/serial/serial-tegra.c | 35 ++++++++++++++-----------------
>>>>  1 file changed, 16 insertions(+), 19 deletions(-)
>>>>
>>>> diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
>>>> index 33034b852a51..8de8bac9c6c7 100644
>>>> --- a/drivers/tty/serial/serial-tegra.c
>>>> +++ b/drivers/tty/serial/serial-tegra.c
>>>> @@ -692,11 +692,22 @@ static void tegra_uart_copy_rx_to_tty(struct tegra_uart_port *tup,
>>>>  				   count, DMA_TO_DEVICE);
>>>>  }
>>>>  
>>>> +static void do_handle_rx_pio(struct tegra_uart_port *tup)
>>>> +{
>>>> +	struct tty_struct *tty = tty_port_tty_get(&tup->uport.state->port);
>>>> +	struct tty_port *port = &tup->uport.state->port;
>>>> +
>>>> +	tegra_uart_handle_rx_pio(tup, port);
>>>> +	if (tty) {
>>>
>>> What's the tty good for here, actually?
>>>
>>>> +		tty_flip_buffer_push(port);
>>>> +		tty_kref_put(tty);
>>>> +	}
>>>> +}
>>
>> I'm not really a TTY expert..
>>
>> Jon, maybe you have any clue whether TTY could disappear while port is
>> opened?
> 
> Nothing specific that I am aware of. The function tty_kref_get() appears
> to check that the tty pointer is valid and so it would seem logical to
> check here as well. But happy to be corrected :-)

Okay, thanks.
