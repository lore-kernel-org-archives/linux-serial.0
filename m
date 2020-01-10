Return-Path: <SRS0=sEmL=27=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C246C33CA4
	for <linux-serial@archiver.kernel.org>; Fri, 10 Jan 2020 22:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CA4020848
	for <linux-serial@archiver.kernel.org>; Fri, 10 Jan 2020 22:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Fq+MP69W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbgAJWDP (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Jan 2020 17:03:15 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39055 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727338AbgAJWDP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Jan 2020 17:03:15 -0500
Received: by mail-pf1-f193.google.com with SMTP id q10so1765512pfs.6
        for <linux-serial@vger.kernel.org>; Fri, 10 Jan 2020 14:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0Abg147KGItynyBfHEl7b67Xp6iR3DdAKc0n7Z2WsdA=;
        b=Fq+MP69WGga+3DgUs/c3imZJTB2FGSls1TCtzh3aqFMF4g096k27iXsNFnGQxP4LY8
         zUkrWlxicfOaC7OJI79DLRwDtMdTp+TSp/XUyyltmSu+ixbOgFZnr6FURS4nZaQCoQom
         gIiDHMM04gRcYN3d/q5z8mp5CVrwgZZXp/+k85e1KSx09ESoDbrl0UBPttJ3usB4PrPk
         eYhgvPwDLS0qHBq4/hayxxXlVFJu/RVfNlFsab5OvwHq6w05gq4/1vfuU1oNyJjeFd01
         Ue4Wi+4gsTD6XEjKU3REt9mjEjm5eddJBcfqqlNx2P70cIva0oP2Ey7/su81gHU/BVY8
         rSYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0Abg147KGItynyBfHEl7b67Xp6iR3DdAKc0n7Z2WsdA=;
        b=dJGhjKGB6Q/fj+7NnqLmrwRIJ/oV3JVn4Hex1Ry1nH8bxHQPF/j9rfqFJrDgkkv451
         q4+56E/tRZZLv1JlrBbI7gkX7uu65gxBW1VLNde9zqtP8uesncWQKnpz8Y6HJC6M/nrm
         S5Vn7wYOtl90XCrSlkGeV3VRd5Sf/R9btOoCsmBJRlSbaA5JJ4i+1aVrFt3gquxOGHKS
         uEDD6+u6+gw/3kTbML6Or1IFprnUcCdtFG+zEkq2Do0/jPP3FTyhGlskRro3ulPcB382
         hWX+JlHXqucOV/90gixY6MZWvZy5K1VE9TkpcmVIRP3qxp5tl4KHsnp/vrD7i3Qe0uAu
         zL7g==
X-Gm-Message-State: APjAAAVrhyxwy6/UWZo+SYzzproeT1L4KZA1FilwtycJB/T4K/SNW5nu
        Zq5Cn+BZG0Kk/oqdasqM5e8kww==
X-Google-Smtp-Source: APXvYqzLcGmK3wvhN4M2dOlmvl0d8H+nrBoejtJBxn2csJnNOxvNjLW+wP9F+IdwdH/QfNSa86sMjA==
X-Received: by 2002:a63:cf55:: with SMTP id b21mr6880362pgj.69.1578693794465;
        Fri, 10 Jan 2020 14:03:14 -0800 (PST)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id m3sm4058655pfh.116.2020.01.10.14.03.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2020 14:03:13 -0800 (PST)
Subject: Re: [PATCH-next 3/3] serial/sysrq: Add MAGIC_SYSRQ_SERIAL_SEQUENCE
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
References: <20200109215444.95995-1-dima@arista.com>
 <20200109215444.95995-4-dima@arista.com>
 <9e622d11-0eb7-274e-8f0a-132d296420fe@infradead.org>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <30427484-7e1d-7112-1714-7947f4145db1@arista.com>
Date:   Fri, 10 Jan 2020 22:02:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <9e622d11-0eb7-274e-8f0a-132d296420fe@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Randy,

On 1/9/20 11:53 PM, Randy Dunlap wrote:
> Hi,
> 
> On 1/9/20 1:54 PM, Dmitry Safonov wrote:
>>
>> Based-on-patch-by: Vasiliy Khoruzhick <vasilykh@arista.com>
>> Signed-off-by: Dmitry Safonov <dima@arista.com>
>> ---
>>  drivers/tty/serial/serial_core.c | 52 ++++++++++++++++++++++++++++----
>>  include/linux/serial_core.h      |  2 +-
>>  lib/Kconfig.debug                |  8 +++++
>>  3 files changed, 55 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
>> index 6ac9dfed3423..f70eba032d0b 100644
>> --- a/drivers/tty/serial/serial_core.c
>> +++ b/drivers/tty/serial/serial_core.c
>> @@ -3081,6 +3081,38 @@ void uart_insert_char(struct uart_port *port, unsigned int status,
>>  }
>>  EXPORT_SYMBOL_GPL(uart_insert_char);
>>  
>> +const char sysrq_toggle_seq[] = CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE;
>> +
>> +static void uart_sysrq_on(struct work_struct *w)
>> +{
>> +	sysrq_toggle_support(1);
>> +	pr_info("SysRq is enabled by magic sequience on serial\n");
> 
> typo:	                                   sequence

Thanks on catching this,
          Dmitry
