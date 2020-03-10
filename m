Return-Path: <SRS0=jKy5=43=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6981FC10F27
	for <linux-serial@archiver.kernel.org>; Tue, 10 Mar 2020 17:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BB9420578
	for <linux-serial@archiver.kernel.org>; Tue, 10 Mar 2020 17:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLYLMbu4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgCJRGK (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 10 Mar 2020 13:06:10 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37518 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbgCJRGK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 10 Mar 2020 13:06:10 -0400
Received: by mail-wr1-f67.google.com with SMTP id 6so16875284wre.4
        for <linux-serial@vger.kernel.org>; Tue, 10 Mar 2020 10:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jHSzPIe7UkE4oaeuz7UEqGgpY9qJ5SXsYj5E9ovROlU=;
        b=jLYLMbu4ovc8dFtuvtpbsZ8vrzkv7KsQZeesJlhV1atV4rHATPTIHvzkQNbL7hfT9D
         mW6mdpg3ZxnpTTwgQLKxXxdlJyKa4vRUhHbS0p836hUtemMt2Eu8o2sSIDNZ372n9qg3
         w0Suw1j6M+MK/gdnpfwzCVWovw603cqHUncDD9XC6fFnIhwBSBzn+tg/1RzikmVqIjUi
         2HNw8UC2SZ5r+VA3U9tt/XgNqEQidZdxAXT4BqEMGSJrXuCqdO2krXl4SbAuJ2shwR6Q
         jk6MzDvWiSo6C5eCwROvt10hH9evS/kf62G7uqhCmGJ96zkaTNXUh/NZK3QG2JAHlkOP
         Sk5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jHSzPIe7UkE4oaeuz7UEqGgpY9qJ5SXsYj5E9ovROlU=;
        b=psa5iLG7PD1rjzpHHcdl44hCrJQT7Q6sstPSsK2LBFO1dtC44RaU2g2vpabnxJdS6u
         OikwNSm5p4ehmNMCUsXRqXadOvDt1kIEpHjxYycZX9A6tiAR6duvPJVIytd7jWspNmKV
         tMZ6OV6Hhiy25ANomthkWj6NLnVEczpVOTKSoUkLT56JByPlV/HozFu5NP6+0SNCilB6
         2+01YlaYHf7maheTMOTrDTO0ewKRadBYHanQSdVLSoR3GOu/yuyHPGTX8VhtRM48uKYo
         6tlvBhZyt4K87MMoMbC9p/70nG84mPDoyIQSeg6HuMEdEAL6gShXi5Gk1aClb4t4PoSZ
         iYCQ==
X-Gm-Message-State: ANhLgQ1HhUPJm/gHspnIbYcklfyF+8wGGL8rpEH6YqlC87i4n5+AKP/a
        3tzoagrmDe1Ft90DRqVg6zU=
X-Google-Smtp-Source: ADFU+vvu5URQoahAi/lxDIKNpLYdwqyogr6E1XxqEPO0o2j8Y9P0DqAPJEdKeBAqeeioVpCPgHRexQ==
X-Received: by 2002:adf:fad0:: with SMTP id a16mr1794591wrs.119.1583859968494;
        Tue, 10 Mar 2020 10:06:08 -0700 (PDT)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id l83sm4986852wmf.43.2020.03.10.10.06.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2020 10:06:07 -0700 (PDT)
Subject: Re: [PATCH v1 1/4] serial: core: Use string length for SysRq magic
 sequence
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
References: <20200310132004.86367-1-andriy.shevchenko@linux.intel.com>
 <64f650b7-8c39-4bef-f1d9-ff2720923c8c@gmail.com>
 <20200310145706.GQ1922688@smile.fi.intel.com>
 <c26a1397-6b65-7d80-7fec-cb0f94ff412d@gmail.com>
 <20200310164851.GT1922688@smile.fi.intel.com>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Message-ID: <11b21afc-fbd8-a148-de69-077fcbc928fa@gmail.com>
Date:   Tue, 10 Mar 2020 17:06:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200310164851.GT1922688@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 3/10/20 4:48 PM, Andy Shevchenko wrote:
> 
> Have you seen to the assembly?
> 
> For me it seems that GCC is clever enough to precalc length for constant
> literals.
> 
> With default string (empty) there is no uart_sysrq_on() at all in the code.
> 
> With "pqr" I see this function and in particular:
>      621:       be 03 00 00 00          mov    $0x3,%esi
> 
> With "pqrst"
> 
>      621:       be 05 00 00 00          mov    $0x5,%esi
> 
> (Note, I compiled entire series, that's why uart_sysrq_on() has strlen() in)

Ah, that solves all worries I have.

Thanks again,
          Dmitry
