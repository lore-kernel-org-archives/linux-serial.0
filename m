Return-Path: <SRS0=m7Km=3K=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3E6C2D0CE
	for <linux-serial@archiver.kernel.org>; Tue, 21 Jan 2020 16:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A301A22525
	for <linux-serial@archiver.kernel.org>; Tue, 21 Jan 2020 16:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pv+3PsrH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbgAUQiC (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 21 Jan 2020 11:38:02 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44614 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729080AbgAUQiB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 21 Jan 2020 11:38:01 -0500
Received: by mail-lj1-f193.google.com with SMTP id q8so3456519ljj.11;
        Tue, 21 Jan 2020 08:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DBI+jODin8/dMS+5H2zNTFg95Djh8pY+zf0IHmhXRG8=;
        b=Pv+3PsrHCYaOFbnWFHFI+7cKpgoY60PPXChSB7KMOjkNfyybXkzqpywC1uqhg4SYs6
         LXdorsv+aABlBBDFLFpGHM3SyT4v/qNyddTJhnxM42bRp7umH9J/Hzr8awqVI5W747Cv
         fmEJwt289q5EgAN40rDHZ36mZQfjCzWQhqxA89hVnOf2CwwTGBCUpOXg3AkkpRSTHzbo
         99YGkvbzcHz/+kGbK6g8nKKDGQrpiHsKA5LVPbR4rh2TyAyJJtQ3E2mBddwwLnc8YNid
         rgQ8eqZcJoSNSeAY/r1Qttw8cuYshy+5pQyPn+C74CVrOxzu5/eR/ZSyqElHcEaYNVD4
         AH8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DBI+jODin8/dMS+5H2zNTFg95Djh8pY+zf0IHmhXRG8=;
        b=sntdV7HXiXKmHRbFkMUSLwF4yINxqUlrZNv/wNkPyGHkD0JXA8vfNT+5m3il2RoLUk
         uWzaewZE4n0kk0xGpOWRhzgbRf60r6w+giokfeQeAqnLaoJYZY0yTQdp9hSUH5uQvD8R
         wCYG/xGUjOA3KPb4wbWnEUj5HTbvlnzOso+Lbz0Tev6FelQjU1aZV0A9EhJnpCXemSAV
         +0ys0+2fenUeDhktmKHH59OZZ5L+fevmMlbnzwEmwsjcD/rNSTbGr/Ak/9ONAoO1BCbP
         ZSnHDcqu2Lj0/RoUnT8bAb+rVmPMLdCSQf6YZhr9XsNrBUAs3X3VBJesRyE3eFdenSyH
         F48A==
X-Gm-Message-State: APjAAAUuxWQnZoTbGbi195E9lV4moiTtzSl9YEZMjgsrJi9/bIsZ6eDe
        qhOwpAAtZunvVIFtv5NqxjU=
X-Google-Smtp-Source: APXvYqy8D1Ip80IsabWyLUnIo2JOJ5Xg28dG3ICjm1MLwvisIb0LgBo+OfgL8zsWMq2eY1CiqGdeZA==
X-Received: by 2002:a2e:3a13:: with SMTP id h19mr17101772lja.16.1579624679207;
        Tue, 21 Jan 2020 08:37:59 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id f8sm1984854lfc.22.2020.01.21.08.37.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 08:37:58 -0800 (PST)
Subject: Re: [PATCH] serial: 8250_tegra: Create Tegra specific 8250 driver
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Jon Hunter <jonathanh@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, Jeff Brasen <jbrasen@nvidia.com>
References: <20200120160149.29072-1-jonathanh@nvidia.com>
 <f02faa4c-5838-15d2-1b76-75c17fcc0d9d@gmail.com>
Message-ID: <788ba1e1-0b00-ee89-dd65-56aba7cb3f19@gmail.com>
Date:   Tue, 21 Jan 2020 19:37:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <f02faa4c-5838-15d2-1b76-75c17fcc0d9d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

21.01.2020 19:31, Dmitry Osipenko пишет:
> Hello Jon,
> 
> 20.01.2020 19:01, Jon Hunter пишет:
> 
> [snip]
> 
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	if (!res)
>> +		return -ENODEV;
>> +
>> +	port->membase = devm_ioremap(&pdev->dev, res->start,
>> +				     resource_size(res));
> 
> devm_platform_ioremap_resource()
> 
>> +	if (!port->membase)
>> +		return -ENOMEM;
>> +
>> +	port->mapbase = res->start;
>> +	port->mapsize = resource_size(res);
>> +
>> +	uart->rst = devm_reset_control_get_optional_shared(&pdev->dev, NULL);
> 
> Why reset is shared? It shall not be shared at least on T20/30/124/210..
> 
> [snip]
> 

Actually, looks like use of a shared reset for a not-really-shared reset
should be fine.
