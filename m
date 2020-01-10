Return-Path: <SRS0=sEmL=27=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A071C282DD
	for <linux-serial@archiver.kernel.org>; Fri, 10 Jan 2020 22:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 317FD20678
	for <linux-serial@archiver.kernel.org>; Fri, 10 Jan 2020 22:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="NOpOBQRE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbgAJWKf (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Jan 2020 17:10:35 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41442 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbgAJWKf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Jan 2020 17:10:35 -0500
Received: by mail-pf1-f194.google.com with SMTP id w62so1775586pfw.8
        for <linux-serial@vger.kernel.org>; Fri, 10 Jan 2020 14:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FflZTkcc1ts8SyPh1Tv6O3mO6woDMPvlWHZ4MJqJNrs=;
        b=NOpOBQRE66u6KQN87/vkmAkItKOSF4ij4xbS9VnxPrl+sbpTcbCd6GfbYid59Uimc9
         ARE5i9QvhqmIGUARO+5nRQQ3fMm1FExit60q2VXJKjSkTlSCDuVpxR8Kz68/5leDKeG+
         lsIyS6w0ShaK/JeNAXkGbemqcBQYtv73CmfldBMfiGT4W+f0qBuMR3SGl1xczxNbGvs9
         WVe0swkgvPGojIyB/1YfgZfGPx2z5aIpZICIyCTl1DTU2SSpEVyir+OfPhSJ7WncC5qV
         ujd8osY5v3oblUdBcBZ2N/2wyEu4ysqlXpgxe4xKvogWmjNUF9q1c6yFzzTE+FL2Fej6
         ZinA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FflZTkcc1ts8SyPh1Tv6O3mO6woDMPvlWHZ4MJqJNrs=;
        b=VVBbwuBuSjsQmrOo7rxyZcB0P58WUeFHdjnpJiVk/v6PWj3vynJzTlJP5bbw177Ayn
         ReHlzuqcXu+tiMRgWecaFFBiO+a2NOGspHOvFjtBTSl+8CPpe2Zi3R6QRkfPDR4KgJYS
         JXpMtqeqHQrLWRMKug53+aTW9iytOP/fm7cmzuapy1TKoOAFObo+Fycie+miF9Y6jZnh
         QSGqCmKGmDX4XmsLrN3UZTNDutZcav2GQhibMCGAtYv4L3735dQtO40ceFU0JZ/QI/vS
         /ndE844GoE5i6SkgjlqWPjR1LYLXwuz8V1I+/Vd7DT8QYWBFFMuaty75ExD6tgKFT0zk
         HnIQ==
X-Gm-Message-State: APjAAAVmPv3hjIu2Qnx1kjQQUHIk3pASlntrMIEvPORsIc5eu+eIUVy5
        sLi6wBrJ1NuE4fOhALAHG0XxXEH+uXI=
X-Google-Smtp-Source: APXvYqwPVEhjrJvHFlfWZvKdXjGSTwzhF4/7AP0pRc7ulrfBKq+w05WIwBr+6YtpkcxiucBcZA+ZbQ==
X-Received: by 2002:a63:7045:: with SMTP id a5mr7179821pgn.49.1578694234777;
        Fri, 10 Jan 2020 14:10:34 -0800 (PST)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id g24sm4238709pfk.92.2020.01.10.14.10.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2020 14:10:33 -0800 (PST)
Subject: Re: [PATCH-next 3/3] serial/sysrq: Add MAGIC_SYSRQ_SERIAL_SEQUENCE
To:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
References: <20200109215444.95995-1-dima@arista.com>
 <20200109215444.95995-4-dima@arista.com>
 <5293a7cb1ccb16275ddb36c7f26fb9e83f4fac9b.camel@perches.com>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <056bff50-f67e-f00f-c98f-ccb427344691@arista.com>
Date:   Fri, 10 Jan 2020 22:10:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <5293a7cb1ccb16275ddb36c7f26fb9e83f4fac9b.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Joe,

On 1/10/20 4:50 PM, Joe Perches wrote:
> On Thu, 2020-01-09 at 21:54 +0000, Dmitry Safonov wrote:
>> Many embedded boards have a disconnected TTL level serial which can
>> generate some garbage that can lead to spurious false sysrq detects.
> 
> trivia:
> 
>> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> []
>> @@ -3081,6 +3081,38 @@ void uart_insert_char(struct uart_port *port, unsigned int status,
> []
>> +const char sysrq_toggle_seq[] = CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE;
> 
> static const?

Will do, thanks!

> 
>> +static int uart_try_toggle_sysrq(struct uart_port *port, unsigned int ch)
> 
> This function return might read better as bool not int

Yeah, no hard feelings, will convert.

[..]
>> @@ -243,10 +243,10 @@ struct uart_port {
>>  	unsigned long		sysrq;			/* sysrq timeout */
>>  	unsigned int		sysrq_ch;		/* char for sysrq */
>>  	unsigned char		has_sysrq;
>> +	unsigned char		sysrq_seq;		/* index in sysrq_toggle_seq */
> 
> unsigned int?
> 
> Or maybe set a maximum length of MAGIC_SYSRQ_SERIAL_SEQUENCE.

I think, 256 chars should be enough to send on serial (c)

I'm not aware of a way to put the max string length in Kconfig, so I did
in the patch:
BUILD_BUG_ON(ARRAY_SIZE(sysrq_toggle_seq) >=
sizeof(port->sysrq_seq)*U8_MAX);

Do you have something more elegant in your mind?

Thanks,
          Dmitry
