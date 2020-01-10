Return-Path: <SRS0=sEmL=27=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3DEC282DD
	for <linux-serial@archiver.kernel.org>; Fri, 10 Jan 2020 22:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 309C520721
	for <linux-serial@archiver.kernel.org>; Fri, 10 Jan 2020 22:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="WE14lDoD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbgAJWcr (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Jan 2020 17:32:47 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45337 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbgAJWcr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Jan 2020 17:32:47 -0500
Received: by mail-pg1-f193.google.com with SMTP id b9so1626497pgk.12
        for <linux-serial@vger.kernel.org>; Fri, 10 Jan 2020 14:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vBfZ8F2SBSNbowGcriH5UQ3hf4Zffir9FW0Q23pW4yg=;
        b=WE14lDoDEbkpXBppfu7UVGESrqK28fZMUuMXaCrwxhio0e/9w52+kgFz74YUQNkg7F
         pQIrbcirN0kzwTMfD34Otj8AQot546oaawZVTZ/j/3+67GSPVLJLNJYg1Oku8nYSpA/P
         Yp+ZvNC4HBTVCsyinMbJPjnyTdBUYP5U63SFlYPmJCDJOmYi/3Swkq9K7Z+Oi+62o+cm
         N47kDs6kwr2uhELSWr5tHNVklIhMC/enRWq0LkG6/Et+Q178ZPoCZES4pHHNIhGGsNGy
         GY3fZ2FRGT1kW/Nnq1s22sxqs4pS5BOGb+aJX+lRt+XP9VATLeAXGH0RjevHaRBmo9cy
         agew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vBfZ8F2SBSNbowGcriH5UQ3hf4Zffir9FW0Q23pW4yg=;
        b=jc6v8JsO/sM0iQI4DL2sc4MttwhmFzgBE/pOnmAkHGUjc55iZLJLszyrE/IdTlH8Qw
         Si+PE+vBrN9wOYQM43Ay7sFtBXvMA478U63I5psomRNtkZ76BqTNC+s8D14V8QD+2xR8
         Zufae90UdomBqlpIhg99cTsI3URTJ4Jj2kyrfqJFmUPSdjvpMwVsE6fBuSI+6zqnWuoB
         1cPx3oli2soa2OeX/5axqKuwKiIES0fSf0C4obviv5eop5UuJYKs8Orm/d2f23/JM1MX
         EXNZl45r0d5rfiZFIakVUDsTgE0w7mq4N9I/ByxpmgQizPDuYeKbYr2X8Xe7PkMvKZPX
         ii5Q==
X-Gm-Message-State: APjAAAVW1iZ8/lsaTcvuQCMw7mxxg/gK6PpQR9rWFs8wsDDieoCd0qF0
        4Qmt7nIOsQJfn6gz0s5yUFv8BQ==
X-Google-Smtp-Source: APXvYqwXdceLNmTvsF2rC/BLsakHNxefR1IsEkWZp/E0RDbWI+j75fsnAS5Me5q3y3F2XyMIRpfNEQ==
X-Received: by 2002:a63:62c2:: with SMTP id w185mr7409012pgb.271.1578695564830;
        Fri, 10 Jan 2020 14:32:44 -0800 (PST)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id k12sm3744129pgm.65.2020.01.10.14.32.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2020 14:32:44 -0800 (PST)
Subject: Re: [PATCH-next 3/3] serial/sysrq: Add MAGIC_SYSRQ_SERIAL_SEQUENCE
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
References: <20200109215444.95995-1-dima@arista.com>
 <20200109215444.95995-4-dima@arista.com> <20200110164643.GB1822445@kroah.com>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <a6a3ee46-9537-c287-b366-797c787c28b6@arista.com>
Date:   Fri, 10 Jan 2020 22:32:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200110164643.GB1822445@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 1/10/20 4:46 PM, Greg Kroah-Hartman wrote:
[..]
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
> Do we want to say what serial port it is enabled on?

Makes sense, will add.

> And why is this done in a workqueue?

uart_try_toggle_sysrq() sometimes is called under
spin_lock_irqsave(&port->lock, flags);

And sysrq_toggle_support() calls input_register_handler() internally
which can sleep.

>> +}
>> +static DECLARE_WORK(sysrq_enable_work, uart_sysrq_on);
>> +
>> +static int uart_try_toggle_sysrq(struct uart_port *port, unsigned int ch)
>> +{
>> +	if (sysrq_toggle_seq[0] == '\0')
>> +		return 0;
> 
> Is constantly checking the data stream like this going to slow things
> down overall?  Ah, we are just checking this after BREAK, right?  So
> that hopefully will not be that bad...

Yes, it's after BREAK. In my POV it's fine as originally it would cause
sysrq handler being called (if sysrq is enabled).

> 
>> +
>> +	BUILD_BUG_ON(ARRAY_SIZE(sysrq_toggle_seq) >= sizeof(port->sysrq_seq)*U8_MAX);
>> +	if (sysrq_toggle_seq[port->sysrq_seq] != ch) {
>> +		port->sysrq_seq = 0;
>> +		return 0;
>> +	}
>> +
>> +	/* Without the last \0 */
>> +	if (++port->sysrq_seq < (ARRAY_SIZE(sysrq_toggle_seq) - 1)) {
>> +		port->sysrq = jiffies + HZ*5;
> 
> 5 second delay?  You should document what this value is for somewhere
> here...

Fair enough, I'll add
#define SYSRQ_TIMEOUT	(HZ*5)

And use it in uart_handle_break() too.

>> @@ -3090,9 +3122,13 @@ int uart_handle_sysrq_char(struct uart_port *port, unsigned int ch)
>>  		return 0;
>>  
>>  	if (ch && time_before(jiffies, port->sysrq)) {
>> -		handle_sysrq(ch);
>> -		port->sysrq = 0;
>> -		return 1;
>> +		if (sysrq_get_mask()) {
>> +			handle_sysrq(ch);
>> +			port->sysrq = 0;
>> +			return 1;
>> +		}
> 
> Isn't this change to test for sysrq_get_mask() a different change than
> checking for the "magic" data stream?

It's for the case when sysrq is already enabled.
Than sysrq_get_mask() will return something and it makes uart call
handle_sysrq() instead of checking the toggle sequence.

>> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
>> index 255e86a474e9..1f4443db5474 100644
>> --- a/include/linux/serial_core.h
>> +++ b/include/linux/serial_core.h
>> @@ -243,10 +243,10 @@ struct uart_port {
>>  	unsigned long		sysrq;			/* sysrq timeout */
>>  	unsigned int		sysrq_ch;		/* char for sysrq */
>>  	unsigned char		has_sysrq;
>> +	unsigned char		sysrq_seq;		/* index in sysrq_toggle_seq */
>>  
>>  	unsigned char		hub6;			/* this should be in the 8250 driver */
>>  	unsigned char		suspended;
>> -	unsigned char		unused;
> 
> This is an unrelated change, let's leave it for a different patch that
> cleans up the layout of this structure, ok?

Yes, sure.

Thanks,
          Dmitry
