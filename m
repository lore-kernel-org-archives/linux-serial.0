Return-Path: <SRS0=m7Km=3K=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7896C2D0CE
	for <linux-serial@archiver.kernel.org>; Tue, 21 Jan 2020 18:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A5E620678
	for <linux-serial@archiver.kernel.org>; Tue, 21 Jan 2020 18:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsvLm3FS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbgAUSqR (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 21 Jan 2020 13:46:17 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45901 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728901AbgAUSqR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 21 Jan 2020 13:46:17 -0500
Received: by mail-ed1-f65.google.com with SMTP id v28so4013267edw.12;
        Tue, 21 Jan 2020 10:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Yc0IP3XS/A/MF2SKNkD0xb3ocUvgaUcyJ5PYh1S4XEg=;
        b=hsvLm3FSNOomINeqzZ/xklDiLcUduPd78vmEQ6qHk3y1dKVsPck+EnftcAtN1iEIEV
         SQrgMj2lFc5H+RdAheIfqmH/rKm7P7NzsC1VYv8APNfdq9/GoMNZWUP+hIyVZy02AaaA
         VpXVKXf4k/nWBG4ZaW5uOPdvI4fXuedN3Y03swDTOlNxIuMyp6PqsN1pdCWsQEiLkw7C
         NnMlyBHlVB80drsW61y+1oIyvwu3eVPJQRBsatMUkYAB5zIwDbXkBELKVP7oPr21UxX6
         zYcn3uHnykU2QNzQuebHsDoK5+QXAiPVrCBoQzKLiB7r4Q+2JQtsr6DPRvpPu+Gu1E6w
         VATg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Yc0IP3XS/A/MF2SKNkD0xb3ocUvgaUcyJ5PYh1S4XEg=;
        b=FLSnjkb9oRWahy1E87hesf+3V1CMwYc2rl9aiQIhGiEOJf7Yst+YLGreC4o1fVOwXg
         0U3UzPvvw1K9ienKri4X1E5uO2N39zvxP24AH/RzLSC/Scpuy//z3GVsvYIGjTAYVyFB
         K9CHPZAqH8CRgciLRh8xlSk+mvMaXNj7q9txo1y9jnGUSPrKysVnlt6EHJBHYJ6KEe63
         sfZmpH1ev+8WMZPl9tAEH0M6ZFgJ1w8oo1SSuR500cZYd4pWhHaOvCHd/XHfmnco0FcS
         adTtY7w/4GLSfGJIuB6vy1um6hUANpf42UbeWmM/VKXR2CBSg7p582y/kRWFcybZg61s
         eZTA==
X-Gm-Message-State: APjAAAVzs9l1/ftubZpso9BhlQHMUYmNnehYfT6LWwT5+AOKJWQLGKAR
        Fi2aMaqBpqocqieMv7i0whI=
X-Google-Smtp-Source: APXvYqwcgcgDplAyYwb3Xj91MUH46aidLOBTjN9PuBERrHhJk98x6VpN1ATV4R5SNXb9KMui8W9g8g==
X-Received: by 2002:a17:906:114e:: with SMTP id i14mr5750317eja.358.1579632374944;
        Tue, 21 Jan 2020 10:46:14 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id w12sm1441106edq.94.2020.01.21.10.46.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 10:46:14 -0800 (PST)
Subject: Re: [PATCH] serial: 8250_tegra: Create Tegra specific 8250 driver
To:     Jon Hunter <jonathanh@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, Jeff Brasen <jbrasen@nvidia.com>
References: <20200120160149.29072-1-jonathanh@nvidia.com>
 <f02faa4c-5838-15d2-1b76-75c17fcc0d9d@gmail.com>
 <714eb00b-bb49-9536-ce9c-8928941edef3@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <176b695b-6790-ff26-8c32-a3920639e6ca@gmail.com>
Date:   Tue, 21 Jan 2020 21:46:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <714eb00b-bb49-9536-ce9c-8928941edef3@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

21.01.2020 21:34, Jon Hunter пишет:
> 
> On 21/01/2020 16:31, Dmitry Osipenko wrote:
>> Hello Jon,
>>
>> 20.01.2020 19:01, Jon Hunter пишет:
>>
>> [snip]
>>
>>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>> +	if (!res)
>>> +		return -ENODEV;
>>> +
>>> +	port->membase = devm_ioremap(&pdev->dev, res->start,
>>> +				     resource_size(res));
>>
>> devm_platform_ioremap_resource()
> 
> That would be ideal, but we cannot. The driver needs the res structure
> as well later on.

Oh, indeed.
