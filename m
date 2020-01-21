Return-Path: <SRS0=m7Km=3K=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A903CC2D0CE
	for <linux-serial@archiver.kernel.org>; Tue, 21 Jan 2020 16:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CF842253D
	for <linux-serial@archiver.kernel.org>; Tue, 21 Jan 2020 16:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGmnugat"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbgAUQbj (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 21 Jan 2020 11:31:39 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39368 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbgAUQbi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 21 Jan 2020 11:31:38 -0500
Received: by mail-lj1-f196.google.com with SMTP id o11so3161659ljc.6;
        Tue, 21 Jan 2020 08:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=l4RN8WpVi7+YUOh7CVQBjtO9aqPWqxtwaV5kPcYJuIE=;
        b=iGmnugatZeVXuscmnDlCESgM4MA02qBwbvISmxoxmLCK1dkVPpMDyeadAVQuFXl/bb
         ym4Di5xk/cfSbAGmoKYvzCRMK3AsixkZuv6pX7wW9bzeD8Odoqh4HG0/0EqKg57SR5B6
         0qCKE0bHp4Nv0eLHIEqTKEKONGH2LDWiro6xHLYlSTSz+nvslaPALxgCooGtWLgakUfT
         EAiCVozBr3RxGdq5w6jztFRt8J/EttTb2tB7mc325oYnwD4iEE2c+2DSMiPiuLPNjJab
         5tXfGy0w2bT2/Ce+atZFuodSbNtG9ItFXMhimQ3i7U20PuCsqEOqqZVbTThXZ830vw3H
         +onQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l4RN8WpVi7+YUOh7CVQBjtO9aqPWqxtwaV5kPcYJuIE=;
        b=gQYr6LN8enqH7B9l6zVyJlQxSQkD6Dgfh4+acJypCIIqiBLImHCArA1RPeBHUll1lf
         ZsFrGdD2xKjXCmrlZgFDJYWuBqgIhKodQs/9NxZ6uVm8Rf/INazBJHxAbRv51F0RdvJF
         Q9b/eNgLy7ARL0qce9au8Kh+sXjtVXVU7HLgyfoHiGriH3xv02GmqvDxiVBbn4TRHefx
         QskRElxEm/cf6J6y4WWXc7KQ2Kttuu7PsiZkXxYntTMvavsWjt1I3VQRt6//Yh0wxpzl
         eLswKNqK/0oH4PdiFd/EWLB7SOOygJVHvnf5liWAKNJDYcnK2Rynnvg2x4QYRf8uOhbJ
         1EEw==
X-Gm-Message-State: APjAAAXYcRUlxOhJHtgHYxBrevBpk0a5kYsyJl7nteA8+oL6YaXoN1Hc
        7XYchkvLGoAb4PNaC1fg+fs=
X-Google-Smtp-Source: APXvYqw4WjOLvEg71Yw67EYYG1RcwJU/9QrncHetyJxGbyqIdw6higEiq7qpIoFc24v7xq4NTBHBPQ==
X-Received: by 2002:a2e:2a86:: with SMTP id q128mr17213167ljq.241.1579624296516;
        Tue, 21 Jan 2020 08:31:36 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id 126sm6831633lfm.38.2020.01.21.08.31.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 08:31:35 -0800 (PST)
Subject: Re: [PATCH] serial: 8250_tegra: Create Tegra specific 8250 driver
To:     Jon Hunter <jonathanh@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, Jeff Brasen <jbrasen@nvidia.com>
References: <20200120160149.29072-1-jonathanh@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <f02faa4c-5838-15d2-1b76-75c17fcc0d9d@gmail.com>
Date:   Tue, 21 Jan 2020 19:31:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200120160149.29072-1-jonathanh@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello Jon,

20.01.2020 19:01, Jon Hunter пишет:

[snip]

> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -ENODEV;
> +
> +	port->membase = devm_ioremap(&pdev->dev, res->start,
> +				     resource_size(res));

devm_platform_ioremap_resource()

> +	if (!port->membase)
> +		return -ENOMEM;
> +
> +	port->mapbase = res->start;
> +	port->mapsize = resource_size(res);
> +
> +	uart->rst = devm_reset_control_get_optional_shared(&pdev->dev, NULL);

Why reset is shared? It shall not be shared at least on T20/30/124/210..

[snip]
