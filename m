Return-Path: <SRS0=zL5S=3D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16520C33C9E
	for <linux-serial@archiver.kernel.org>; Tue, 14 Jan 2020 19:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7242222C4
	for <linux-serial@archiver.kernel.org>; Tue, 14 Jan 2020 19:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="KfMcqSca"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbgANTKx (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 14 Jan 2020 14:10:53 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37966 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbgANTKw (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 14 Jan 2020 14:10:52 -0500
Received: by mail-pg1-f196.google.com with SMTP id a33so6824309pgm.5
        for <linux-serial@vger.kernel.org>; Tue, 14 Jan 2020 11:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Jh4MVY28TLmOvtnKjMwqmE9PCs0MNoKAOnUNKma/4Ys=;
        b=KfMcqScafpLXwRh02Sj7gQrwWIejqGLu3q1y31aNIF+59v/iI+I5sw3GcTfwXDJXWH
         2pV0Q0rkADPn5yhaIlLrgmbE4IbFaPCdu2PCN+M0SaFfUXxdKYYSFH2o/53yzovJ1zs5
         mvQ9aKhOHHRhc32FHcEjcf0C56od2hW1+ksC8mw4Skeejz2qgVgYdp0dQqiX2TEWeYis
         aOC7s5urnDeJ9wFCMVEP1RVHR6UXpDCl5cUxt6Qa+Jv5C9fxuqeZfZTq5Fb8Jorl8392
         vwzKtf0AoIKGYQM7GyKaqw/LALBj/x+SO7Bnz8kKudchYOIXeWFoOmLzPSUKKWXdpEEK
         GiwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Jh4MVY28TLmOvtnKjMwqmE9PCs0MNoKAOnUNKma/4Ys=;
        b=g4O4WhzClXjlFmcInuVV5sLtLcPL4AgafW3qT028rgNwsHChshC1/IcTErT/v9UrBb
         5yGTRLbn5g8aYQ940CTqz8OXGGc66rqJUSPJ0tn8XEebpjLgqAdqzk1JJBBnDM4r26Pc
         d/M8H+XKCw7NAZFz6AAWtUllx0gMFQIB77sT2+UMU+M67q4VuHTlhvny5RJ886/6FTK7
         ZZTbnXrUJwuo5he4h1aNEMc8vnAP5P03wtSz1N4L4Yts9UgwgxM39xIAeABbIsaY2enA
         3ynkDXxoP0jsujRtv5x3mgyIKTzhXzueA0ejjn38UBUGLNTlv9EcGwrBVqkM4WVfGnqx
         vdcg==
X-Gm-Message-State: APjAAAVXvSLcjVVYPMSe+zIyjr0uYUNziCvoemI6s1mdlK2RkDlmRyZs
        w1IEpNfxqquxwGDUCPk3QAGQiQ==
X-Google-Smtp-Source: APXvYqyCMudVIu/tZb/LWHyQ/ln+ti2nF0ZnV1cD1dFatM2ksK89jpS5Ad0uvf1N0JK4hRJC5YGrLw==
X-Received: by 2002:a63:2fc4:: with SMTP id v187mr28115896pgv.55.1579029051987;
        Tue, 14 Jan 2020 11:10:51 -0800 (PST)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id o134sm19598426pfg.137.2020.01.14.11.10.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2020 11:10:51 -0800 (PST)
Subject: Re: [PATCH-next 3/3] serial/sysrq: Add MAGIC_SYSRQ_SERIAL_SEQUENCE
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
References: <20200109215444.95995-1-dima@arista.com>
 <20200109215444.95995-4-dima@arista.com> <20200110164643.GB1822445@kroah.com>
 <a6a3ee46-9537-c287-b366-797c787c28b6@arista.com>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <41435a7b-48a2-438c-998a-14481fbc3a1a@arista.com>
Date:   Tue, 14 Jan 2020 19:10:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <a6a3ee46-9537-c287-b366-797c787c28b6@arista.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 1/10/20 10:32 PM, Dmitry Safonov wrote:
> On 1/10/20 4:46 PM, Greg Kroah-Hartman wrote:
> [..]
>>> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
>>> index 6ac9dfed3423..f70eba032d0b 100644
>>> --- a/drivers/tty/serial/serial_core.c
>>> +++ b/drivers/tty/serial/serial_core.c
>>> @@ -3081,6 +3081,38 @@ void uart_insert_char(struct uart_port *port, unsigned int status,
>>>  }
>>>  EXPORT_SYMBOL_GPL(uart_insert_char);
>>>  
>>> +const char sysrq_toggle_seq[] = CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE;
>>> +
>>> +static void uart_sysrq_on(struct work_struct *w)
>>> +{
>>> +	sysrq_toggle_support(1);
>>> +	pr_info("SysRq is enabled by magic sequience on serial\n");
>>
>> Do we want to say what serial port it is enabled on?
> 
> Makes sense, will add.

Ah, I've managed to forget to mention that I didn't add the port name
into the message in v2. I experimented a bit - it's getting a bit
complicated how-to protect (char *name) for just this message.
Like, SysRq can be theoretically enabled on two serials at the same
moment - so some locking is needed to make the printed name sane.

As sysrq_toggle_support() is a global-enable knob for sysrq (also can be
switched in /proc/sys/kernel/sysrq) I'm not sure if it's worth to
complicate code to print through which serial console SysRq has been
enabled.

I can still do it in v3 if you insist.

And sorry about forgetting to mention this - thought I'll write reply
after I send v2 and somehow it slipped my mind.

Thanks,
           Dmitry
