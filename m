Return-Path: <SRS0=su8x=3S=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C69C2D0DB
	for <linux-serial@archiver.kernel.org>; Wed, 29 Jan 2020 19:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3818D206D4
	for <linux-serial@archiver.kernel.org>; Wed, 29 Jan 2020 19:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPdNw+Uf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbgA2TEF (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 29 Jan 2020 14:04:05 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39775 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbgA2TEF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 29 Jan 2020 14:04:05 -0500
Received: by mail-wr1-f66.google.com with SMTP id y11so763149wrt.6;
        Wed, 29 Jan 2020 11:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pC0C76/9mV+NSA1IB3Fzi6RwKXSA9zm82uxlw8G+lLQ=;
        b=fPdNw+UfMoeCpNCzvk4CFkQaaV/6it1c037+DWLeqKBrn/H00XJjignKFnBp4qaXN2
         XYKOsc0C+SkzgTkyEz7R5XKdgxIv1S8tVGPCuVRIEFqHOk6HX9bNtOmUfA2ORchaz36+
         KZjfwXpbm3RyYZtspx1+5WV+/aD7n9C2pezzYyZ1crU8U9SR8F0CRo962CWH+4C+gKtt
         nIYF83JX/t/twNQJA7QQlhjOK8hknRIFhE6pQVV6i56fBLqbzYat1VGIdy7FFnRWclpv
         bwfBJ8nUeRIzza56fcfZIisZ3DFOFd3pOFUi/1q7Zr/DDVLGmEW6AU9MrWLdUXK1k62D
         CDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pC0C76/9mV+NSA1IB3Fzi6RwKXSA9zm82uxlw8G+lLQ=;
        b=MtkrxLn2ndSd6eNdgN/WM5VnZ1MJMlqU4aYqtF8A+u2T0hnNrx7ouY4YdelDRwVJEG
         4FC1yDd3PVpoBCQNaA/i5FPNnC4IL1ij+fluFKiIkwR6oD4gzIzESED6j4SLjTMApCPP
         e1cAsJR91q3NlqYs22MkLpq4Z/Q8wvMIf+zh/NR8dRiSqE5zJfDoTnnESOuMC+TqxpSK
         P7sgxEwxr4keqVE0chSehQbpCJt9aCBaY3mz3vB1Ev7P7kNFK4zriscOiDeyV/WJ9ZoH
         gkuUw8lfzFkayH96yG/IeLZCXXMPEcwgp5Jg/6dCleDxbhsFtzrSHkWMI8kqHefpMEMq
         NQWQ==
X-Gm-Message-State: APjAAAUIXVcbSmR5xoKfCnxIvbyoPNRHWPvPL9RLlC/RGMNa6kIHPKw1
        K+y61qRd8HoHHS+nsythjU4=
X-Google-Smtp-Source: APXvYqwd8FNF+iWDTfZMah7Wdv/R2tWBq2MBMAUfDbx9IIqnimpMXTzC594qlJ63P2HwO2/bH8Ou2A==
X-Received: by 2002:a5d:4752:: with SMTP id o18mr278260wrs.330.1580324643222;
        Wed, 29 Jan 2020 11:04:03 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id z10sm3138545wmk.31.2020.01.29.11.04.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2020 11:04:02 -0800 (PST)
Subject: Re: [PATCH V3] serial: 8250_tegra: Create Tegra specific 8250 driver
To:     Jon Hunter <jonathanh@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, Jeff Brasen <jbrasen@nvidia.com>
References: <20200129132817.26343-1-jonathanh@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <45ac5b66-e09a-e328-6ebf-3fbbe97b7873@gmail.com>
Date:   Wed, 29 Jan 2020 22:04:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200129132817.26343-1-jonathanh@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

29.01.2020 16:28, Jon Hunter пишет:
...
> +#ifdef CONFIG_PM_SLEEP
> +static int tegra_uart_suspend(struct device *dev)
> +{

Nit: the ifdef'ing in the code could be avoided by using the
__maybe_unused attribute.
