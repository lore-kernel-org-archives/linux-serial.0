Return-Path: <SRS0=zL5S=3D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB91C33CB6
	for <linux-serial@archiver.kernel.org>; Tue, 14 Jan 2020 17:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB43224679
	for <linux-serial@archiver.kernel.org>; Tue, 14 Jan 2020 17:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="foRWn/Sx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbgANRhF (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 14 Jan 2020 12:37:05 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41109 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728880AbgANRhE (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 14 Jan 2020 12:37:04 -0500
Received: by mail-pg1-f193.google.com with SMTP id x8so6705582pgk.8
        for <linux-serial@vger.kernel.org>; Tue, 14 Jan 2020 09:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EC1V31kkUKO1e4THTwUpln5DsH8XNb9uCr/r/2oHaQg=;
        b=foRWn/SxPpwzIYpPv9YpeG9HklGuam9AgV1o5mwQsvaYNVZJ8JxscJsD7TgVtkbQob
         oRlJfldyaUDAJdT3dKT75Hb9FuALBQMR4mgZUCpHxptwaK6YPnezeRhYMO0JlZCOA+X9
         TgbTcUIKzmtIO7/aLb5aPmJ4MMyoGS3nicS8HxyAQAJDNEh03y4LWuuG5mzqFblUr5Oo
         vxCvNyYHDUu4/33/3Nb+XPCa62GAN7cG1NsYjuH0WsWPpBWpsLOY7n6iwdsaXy1EIhCI
         KE+O9mWenc4TyeytPTsn2vW4RTofbvX0t6XJIkqfvyAyMfqYtZKgUaD3AAONtpynBVYR
         a8Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EC1V31kkUKO1e4THTwUpln5DsH8XNb9uCr/r/2oHaQg=;
        b=ZCdjtPJOpOEE00lBrba1aoQipiQNHX9pRweP3P1EPqxYcivKOVT0dMgDWVgmh+QHOr
         z0ki0IQZHRlAfnKEdt5aITeU6Z6WywMbAxePAVYAWqglk2Lm3dtMpkGBpdsi7SJYKZPa
         VG/lg7tKHxsAhkuM5Fs+EtckricLh/rYLdPbLXu9ApssI5KJoG5N/0IBXobf5iJ27zSG
         vguigwcOLa7BGLtSMhrVsb1d3g57H/jrWvjtoNhNl5IFWzRKpV6H4qyqtOkGdNfyTd0V
         CKycS/H7jO6rX3m6Sd7+7J812ApHG6Pca6aZKLL9h74ZFSskseKUPk+FVDX2VedpwNsf
         AfjA==
X-Gm-Message-State: APjAAAWgm82FruFMAU7fITS8yHAMF/qpPvr2iCPJqyu/e/FvNyesu2Lo
        Ep7ioGPkcVcTk/TzpsehjOdKhg==
X-Google-Smtp-Source: APXvYqyzpnXWDZlOjta8/q0rFUjicssGmDGoJZEC4U64CAy+P3MaBYClXvzSbj7vwaK72Y0QxRVj4Q==
X-Received: by 2002:a62:b508:: with SMTP id y8mr26409909pfe.251.1579023423632;
        Tue, 14 Jan 2020 09:37:03 -0800 (PST)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id z11sm19621730pfk.96.2020.01.14.09.37.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2020 09:37:02 -0800 (PST)
Subject: Re: [PATCHv2-next 2/3] serial/sysrq: Add MAGIC_SYSRQ_SERIAL_SEQUENCE
To:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Jiri Slaby <jslaby@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
References: <20200114171912.261787-1-dima@arista.com>
 <20200114171912.261787-3-dima@arista.com>
 <24455cb643415cf9379bb8343525b844ead4236b.camel@perches.com>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <a8d1a5df-8c72-049f-3bb4-5fae0166d760@arista.com>
Date:   Tue, 14 Jan 2020 17:36:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <24455cb643415cf9379bb8343525b844ead4236b.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Joe,

On 1/14/20 5:30 PM, Joe Perches wrote:
> On Tue, 2020-01-14 at 17:19 +0000, Dmitry Safonov wrote:
>> Many embedded boards have a disconnected TTL level serial which can
>> generate some garbage that can lead to spurious false sysrq detects.
> 
> Hi again Dmitry.  trivia:
> 
>> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> []
>> +/**
>> + *	uart_try_toggle_sysrq - Enables SysRq from serial line
>> + *	@port: uart_port structure where char(s) after BREAK met
>> + *	@ch: new character in the sequence after received BREAK
>> + *
>> + *	Enables magic SysRq when the required sequence is met on port
>> + *	(see CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE).
>> + *
>> + *	Returns 0 if @ch is out of enabling sequence and should be
>> + *	handled some other way, 1 if @ch was consumed.
>> + */
> 
> Normally bool functions return values are true/false not 1/0.

I agree. Though, somehow it seems to me that `return 1` is a bit closer
to "one character consumed" than "return true".
Again, no hard feelings, just a preference.
I can change those returns to bools if you insist :)

> 
>> +static bool uart_try_toggle_sysrq(struct uart_port *port, unsigned int ch)
>> +{
>> +	if (ARRAY_SIZE(sysrq_toggle_seq) <= 1)
>> +		return 0;
> 
> 		return false;
> 
> etc...
> 
> 

Thanks,
          Dmitry
