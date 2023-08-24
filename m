Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB710C7113B
	for <linux-serial@archiver.kernel.org>; Thu, 24 Aug 2023 21:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjHXVSM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 24 Aug 2023 17:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjHXVSF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 24 Aug 2023 17:18:05 -0400
Received: from zproxy1.foxvalley.net (zimbra.foxvalley.net [212.78.26.134])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id D646BCD2
        for <linux-serial@vger.kernel.org>; Thu, 24 Aug 2023 14:18:03 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy1.foxvalley.net (Postfix) with ESMTP id 74A1B40F09;
        Thu, 24 Aug 2023 16:18:03 -0500 (CDT)
Received: from zproxy1.foxvalley.net ([127.0.0.1])
 by localhost (zproxy1.foxvalley.net [127.0.0.1]) (amavis, port 10032)
 with ESMTP id RF5EcL6QEDuE; Thu, 24 Aug 2023 16:18:02 -0500 (CDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy1.foxvalley.net (Postfix) with ESMTP id CAD3640F7F;
        Thu, 24 Aug 2023 16:18:02 -0500 (CDT)
X-Virus-Scanned: amavis at zproxy1.foxvalley.net
Received: from zproxy1.foxvalley.net ([127.0.0.1])
 by localhost (zproxy1.foxvalley.net [127.0.0.1]) (amavis, port 10026)
 with ESMTP id E-G9b7bFwXtC; Thu, 24 Aug 2023 16:18:02 -0500 (CDT)
Received: from [192.168.1.3] (unknown [161.97.241.227])
        by zproxy1.foxvalley.net (Postfix) with ESMTPSA id 6AD4B40F09;
        Thu, 24 Aug 2023 16:18:02 -0500 (CDT)
Message-ID: <e6d0def1-4b72-9b30-a0a7-0bbce37f09b7@foxvalley.net>
Date:   Thu, 24 Aug 2023 15:18:00 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] tty/serial: create debugfs interface for UART register
 tracing
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>
References: <68ad2521-f902-b0d3-16d6-4d2a36ac656e@foxvalley.net>
 <9c63a3a-2720-4e2b-5155-eb6e36aef257@linux.intel.com>
 <9d0ff4b7-2584-6003-a213-6de11f6513fa@foxvalley.net>
 <7d437f22-277-de25-6296-97483fb81792@linux.intel.com>
From:   Dan Raymond <draymond@foxvalley.net>
In-Reply-To: <7d437f22-277-de25-6296-97483fb81792@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 8/24/2023 6:13 AM, Ilpo Järvinen wrote:

>> Currently this feature only supports those and it also
>> relies on the TSC which is an x86 thing.
> 
> I wonder why you have to rely on that. Why e.g. ktime_get_boottime() is 
> not enough for this usecase?

I was motivated to make the tracing as unobtrusive as possible and it seemed
like the rdtsc instruction would be very fast and very precise.  I'll have to
profile ktime_get_boottime() to see how much overhead that adds.

>>>> +		ptr = uart_debug->line + uart_debug->offset;
>>>> +		len = strlen(ptr);
>>> Why you need to calculate length? Shouldn't queue_remove() be able to return
>>> this information?
>>
>> Yes, we can return the string length from queue_remove() but we still need to
>> call strlen() to accommodate all code paths.  The user might call read() with
>> a very small buffer and that requires us to advance ptr past the beginning of
>> the string on subsequent calls.
> 
> I still find it hard to believe you could not keep track of it all 
> without strlen(), snprintf() returns the number of chars it wrote to 
> uart_debug->line so it should be that length - uart_debug->offset?

True.  I could store the total string length and trade a little more memory and
a little more complexity for a little less CPU time.  Do you think it's a good
tradeoff?  The strlen() call should be pretty fast since the string is a maximum
of 27 characters.  Also, this is in the trace consumer path where performance
is not as important as the trace producer path.
 
>>>> +	static uint64_t cpu_freq;  /* cycles per second */
>>>> +	uint32_t h, m, s, us;
>>>> +
>>>> +	if (cpu_freq == 0)
>>>> +		cpu_freq = arch_freq_get_on_cpu(0) * 1000ULL;
>>>> +
>>>> +	s = div64_u64_rem(cpu_cycles, cpu_freq, &cpu_cycles);
>>>> +	us = div64_u64(cpu_cycles * 1000 * 1000 + 500 * 1000, cpu_freq);
>>>> +
>>>> +	m = s / 60; s = s % 60;
>>>> +	h = m / 60; m = m % 60;
>>>> +
>>>> +	snprintf(buf, size, "%02d:%02d:%02d.%06u", h, m, s, us);
>>> seconds.us is enough. If some additional formatting is to happen, it
>>> should be done in userspace.
>>
>> I can see your point.  If the user does want to reformat this it will be
>> easier to start with the format you suggested.  Is this a general rule for
>> kernel space?
> 
> I don't know if there's a rule. But having had to parse those :: inputs 
> way too many times in the past, I have very little love for that format 
> being forced on user ;-).

OK, I've changed the format from "hh:mm:ss:mmmuuu" to "ssssssss:mmmuuu".

>>>> +/*
>>>> + *  Create the debugfs interface.  This should be called during port
>>>> registration after
>>>> + *  port->name, port->serial_in, and port->serial_out have been
>>>> initialized.
>>>> We are
>>>> + *  using port->private_data to store a pointer to our data structure.
>>>> That
>>>> field appears
>>>> + *  to be otherwise unused.  If this is wrong we will need to create a
>>>> new
>>>> field.
>>>> + */
>>>> +void uart_debug_create(struct uart_port *port)
>>>> +{
>>>> +	struct uart_debug *uart_debug;
>>>> +	struct dentry *dir;
>>>> +
>>>> +	uart_debug = port->private_data = kzalloc(sizeof(struct uart_debug),
>>>> GFP_KERNEL);
>>> How about the drivers which use port->private_data?
>>
>> It didn't look like this field was used.  Was I wrong about this?
> 
> ~/linux/uart/drivers/tty/serial/8250$ git grep 'private_data =' | wc -l
> 20
> 
> There are multiple 8250 variant drivers using it.
> 
> Some also come with additional registers so it's all relevant also in 
> serial/8250/ domain.

OK, I've added a new field named 'debug_data' and I'll use that instead of
'private_data'.  My latest changes are in the v3 patch.
