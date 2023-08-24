Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 581A7C3DA6F
	for <linux-serial@archiver.kernel.org>; Thu, 24 Aug 2023 06:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240020AbjHXGYO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 24 Aug 2023 02:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240050AbjHXGYF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 24 Aug 2023 02:24:05 -0400
Received: from zproxy1.foxvalley.net (zimbra.foxvalley.net [212.78.26.134])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 62C2DDB
        for <linux-serial@vger.kernel.org>; Wed, 23 Aug 2023 23:24:03 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy1.foxvalley.net (Postfix) with ESMTP id F1A3140F3C;
        Thu, 24 Aug 2023 01:24:02 -0500 (CDT)
Received: from zproxy1.foxvalley.net ([127.0.0.1])
 by localhost (zproxy1.foxvalley.net [127.0.0.1]) (amavis, port 10032)
 with ESMTP id AS2_30hmnEFP; Thu, 24 Aug 2023 01:24:02 -0500 (CDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy1.foxvalley.net (Postfix) with ESMTP id 8656140F43;
        Thu, 24 Aug 2023 01:24:02 -0500 (CDT)
X-Virus-Scanned: amavis at zproxy1.foxvalley.net
Received: from zproxy1.foxvalley.net ([127.0.0.1])
 by localhost (zproxy1.foxvalley.net [127.0.0.1]) (amavis, port 10026)
 with ESMTP id RCwm7MQXDo5J; Thu, 24 Aug 2023 01:24:02 -0500 (CDT)
Received: from [192.168.1.3] (unknown [161.97.241.227])
        by zproxy1.foxvalley.net (Postfix) with ESMTPSA id 576F240F3C;
        Thu, 24 Aug 2023 01:24:02 -0500 (CDT)
Message-ID: <9d0ff4b7-2584-6003-a213-6de11f6513fa@foxvalley.net>
Date:   Thu, 24 Aug 2023 00:24:01 -0600
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
From:   Dan Raymond <draymond@foxvalley.net>
In-Reply-To: <9c63a3a-2720-4e2b-5155-eb6e36aef257@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 8/23/2023 2:30 AM, Ilpo Järvinen wrote:

> Thanks, looks useful (although it might have challenge in tracing hw
> during early init).

I suppose there would need to be a mechanism to enable tracing by 
default (kernel cmd line?)  Is the UART driver even used very early in 
the boot process?

>> +struct reg_event {
>> +	uint32_t  cycle_lo;  /* CPU cycle count (lower 32-bits) */
>> +	uint16_t  cycle_hi;  /* CPU cycle count (upper 16-bits) */
>> +	uint8_t   access;    /* write flag + register number */
>> +	uint8_t   data;      /* register data */
> Some HW-specific registers are larger than 8 bits.

Not for 8250/16550?  Currently this feature only supports those and it 
also relies on the TSC which is an x86 thing.

>
>> +
>> +		ptr = uart_debug->line + uart_debug->offset;
>> +		len = strlen(ptr);
> Why you need to calculate length? Shouldn't queue_remove() be able to return
> this information?

Yes, we can return the string length from queue_remove() but we still 
need to call strlen() to accommodate all code paths.  The user might 
call read() with a very small buffer and that requires us to advance ptr 
past the beginning of the string on subsequent calls.

>
>> +		num_bytes = (size < len) ? size : len;
> min_t().

Done.

>
>> +	
>> +	if (error)
>> +		return total_bytes ? total_bytes : error;
>> +	return total_bytes;
> So this is same as:
> 	if (!total_bytes)
> 		return error;
>
> 	return total_bytes;

OK, I simplified this.

> For in-kernel interfaces, use u64 and u32, uintxx_t is for userspace
> interactions.

Done.

>> +	static uint64_t cpu_freq;  /* cycles per second */
>> +	uint32_t h, m, s, us;
>> +
>> +	if (cpu_freq == 0)
>> +		cpu_freq = arch_freq_get_on_cpu(0) * 1000ULL;
>> +
>> +	s = div64_u64_rem(cpu_cycles, cpu_freq, &cpu_cycles);
>> +	us = div64_u64(cpu_cycles * 1000 * 1000 + 500 * 1000, cpu_freq);
>> +
>> +	m = s / 60; s = s % 60;
>> +	h = m / 60; m = m % 60;
>> +
>> +	snprintf(buf, size, "%02d:%02d:%02d.%06u", h, m, s, us);
> seconds.us is enough. If some additional formatting is to happen, it
> should be done in userspace.

I can see your point.  If the user does want to reformat this it will be 
easier to start with the format you suggested.  Is this a general rule 
for kernel space?

>> +
>> +	cpu_cycle      = rdtsc();
>> +	event.cycle_lo = (uint32_t)cpu_cycle;
>> +	event.cycle_hi = (uint16_t)(cpu_cycle >> 32);
>> +	event.access   = (write ? 0x08 : 0x00) | reg;
> Use defines for these literals.
>
>> +static noinline void queue_free(struct uart_port *port, bool force)
>> +{
>> +	struct uart_debug *uart_debug = port->private_data;
>> +	struct reg_queue *queue = &uart_debug->register_queue;
>> +
>> +	if (force || queue->read_idx == queue->write_idx) {
> Why cannot the only place where force=true just reset the indexes before
> making the call so no force parameter is required? ...I think there's a
> bug anyway with the indexes not getting properly reset in that case.

Only the queue_xxx() functions read or write the queue structure.  The 
indices are reset below when we memset() the entire structure to 0.

>
>> +		vfree(queue->buf);
>> +		memset(queue, 0, sizeof(*queue));
>> +	}
>> ...
>> +	} else if (num_events) {
>> +		reg = event.access & 0x07;
>> +		sym = event.access & 0x08 ? out_regs[reg] : in_regs[reg];
> Some uarts have registers beyond 0x07 so this doesn't seem enough.
> It would be nice if the driver could provide alternative set of names for
> the registers.

I'll have to look into how difficult it would be to support other UARTs 
besides 8250/16550.

>> +	while (trace_size >>= 1)
>> +		rounded_size <<= 1;  /* round down to nearest power of 2 */
> Comment is certainly misplaces as it's the whole while loop which
> calculates that.

Fixed.

>> +/*
>> + *  Create the debugfs interface.  This should be called during port
>> registration after
>> + *  port->name, port->serial_in, and port->serial_out have been initialized.
>> We are
>> + *  using port->private_data to store a pointer to our data structure.  That
>> field appears
>> + *  to be otherwise unused.  If this is wrong we will need to create a new
>> field.
>> + */
>> +void uart_debug_create(struct uart_port *port)
>> +{
>> +	struct uart_debug *uart_debug;
>> +	struct dentry *dir;
>> +
>> +	uart_debug = port->private_data = kzalloc(sizeof(struct uart_debug),
>> GFP_KERNEL);
> How about the drivers which use port->private_data?

It didn't look like this field was used.  Was I wrong about this?

> It would make this look cleaner if you split the double assignment.

Done.

>> +
>> +	uart_debug->trace_size = 4096;
> SZ_4K

Done.

Thanks for looking at this.  I've created another patch that 
incorporates most of your suggestions.

