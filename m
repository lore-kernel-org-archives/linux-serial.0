Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39556C433ED
	for <linux-serial@archiver.kernel.org>; Thu,  6 May 2021 07:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0417961106
	for <linux-serial@archiver.kernel.org>; Thu,  6 May 2021 07:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhEFHUd (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 6 May 2021 03:20:33 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:52007 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233262AbhEFHUd (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 6 May 2021 03:20:33 -0400
Received: by mail-wm1-f46.google.com with SMTP id n205so2774538wmf.1;
        Thu, 06 May 2021 00:19:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7eMcgdHi/j8YW5PeXfqZNQnqB9mn6+EoVANH2pmJ2rs=;
        b=EHVW+Qbly12RMjc56UG7y8aI8i/knyienVQs69HjKUINogRVR2HoMAGk3DnUlE2QMW
         pjERsIa10ifiAm2TmVxti7WRiZW1NHshKcZM8TU/kZJVcl2dicHg6Y4m5IOuEO6DE5uD
         d2xTiPy/ggnjdpAUWAG9Y9c+RbWibL9omKJ3p0fShhFMK2MgW3klngbDPQPByzJcdtLO
         Cr2RlulefKUU7ZN0oexRBjZALOpzKgZukGACd8a3ceCdYLUfXgXlNu/ZZv1Xd3Wg7mlM
         O7MXIzC57tz50bipKMPSMKbmfymbf2mrnRM8D921gaEaPlJe/TtC9neNzC6Kx/U1lJma
         3DAA==
X-Gm-Message-State: AOAM533JBAUBCq+wTGvk4/Nbkb4rxu1bhiZLhnuElw2QSx0z3O7A3hyD
        h1PK2/6n/gDklCcK2CGz6HgLHpriUSc=
X-Google-Smtp-Source: ABdhPJxP9EWtuFWuPWGBwOci6DwojMB+rL/xGNMSOZU+ZSD3U2jsl5xcUlqOXWYFZPOpLqwbNntE2w==
X-Received: by 2002:a7b:c348:: with SMTP id l8mr14077054wmj.152.1620285574624;
        Thu, 06 May 2021 00:19:34 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id c15sm2757695wrr.3.2021.05.06.00.19.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 May 2021 00:19:33 -0700 (PDT)
Subject: Re: [PATCH 34/35] tty: make tty_get_byte_size available
To:     Joe Perches <joe@perches.com>, gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210505091928.22010-1-jslaby@suse.cz>
 <20210505091928.22010-35-jslaby@suse.cz>
 <ef1bd57095e941560530be43806791966a6735ad.camel@perches.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <949f77aa-2429-3fe9-9163-5a7b2c5c499a@kernel.org>
Date:   Thu, 6 May 2021 09:19:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <ef1bd57095e941560530be43806791966a6735ad.camel@perches.com>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 06. 05. 21, 9:16, Joe Perches wrote:
> On Wed, 2021-05-05 at 11:19 +0200, Jiri Slaby wrote:
>> Many tty drivers contain code to compute bits count depending on termios
>> cflags. So extract this code from serial core to a separate tty helper
>> function called tty_get_byte_size.
> []
>> diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
> []
>> +/**
>> + *	tty_get_byte_size	-	get size of a byte
>> + *	@cflag: termios cflag value
>> + *	@account_flags: account for start and stop bits, second stop bit (if
>> + *			set), and parity (if set)
>> + *
>> + *	Get the size of a byte in bits depending on @cflag. Depending on
>> + *	@account_flags parameter, the result also accounts start and stop bits,
>> + *	the second stop bit, and parity bit.
>> + */
>> +unsigned char tty_get_byte_size(unsigned int cflag, bool account_flags)
>> +{
>> +	unsigned char bits = account_flags ? 2 : 0;
>> +
>> +	/* byte size and parity */
>> +	switch (cflag & CSIZE) {
>> +	case CS5:
>> +		bits += 5;
>> +		break;
>> +	case CS6:
>> +		bits += 6;
>> +		break;
>> +	case CS7:
>> +		bits += 7;
>> +		break;
>> +	case CS8:
>> +	default:
>> +		bits += 8;
>> +		break;
>> +	}
>> +
>> +	if (account_flags && (cflag & CSTOPB))
>> +		bits++;
>> +
>> +	if (account_flags && (cflag & PARENB))
>> +		bits++;
>> +
>> +	return bits;
>> +}
>> +EXPORT_SYMBOL_GPL(tty_get_byte_size);
> 
> Perhaps clearer not testing account_flags multiple times.

Right. Originally, I had account_start_stop, account_stop, and 
account_parity parameters. But they were either all false or all true. 
So I unified them to account_flags, but the code remained overly complex.

> unsigned char tty_get_byte_size(unsigned int cflag, bool account_flags)
> {
> 	unsigned char bits;
> 
> 	/* byte size and parity */
> 	switch (cflag & CSIZE) {
> 	case CS5:
> 		bits = 5;
> 		break;
> 	case CS6:
> 		bits = 6;
> 		break;
> 	case CS7:
> 		bits = 7;
> 		break;
> 	case CS8:
> 	default:
> 		bits = 8;
> 		break;
> 	}
> 
> 	if (account_flags) {
> 		bits += 2;	/* start/stop bits */
> 
> 		if (cflag & CSTOPB)
> 			bits++;
> 
> 		if (cflag & PARENB)
> 			bits++;
> 	}
> 
> 	return bits;
> }
> 
> 

thanks,
-- 
js
suse labs
