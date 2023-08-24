Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C95C27C40
	for <linux-serial@archiver.kernel.org>; Thu, 24 Aug 2023 06:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239934AbjHXGXJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 24 Aug 2023 02:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240049AbjHXGWi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 24 Aug 2023 02:22:38 -0400
Received: from zproxy1.foxvalley.net (zimbra.foxvalley.net [212.78.26.134])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 0F898DB
        for <linux-serial@vger.kernel.org>; Wed, 23 Aug 2023 23:22:35 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy1.foxvalley.net (Postfix) with ESMTP id 72B5140F2A;
        Thu, 24 Aug 2023 01:22:34 -0500 (CDT)
Received: from zproxy1.foxvalley.net ([127.0.0.1])
 by localhost (zproxy1.foxvalley.net [127.0.0.1]) (amavis, port 10032)
 with ESMTP id hGsQ1IbdMCuK; Thu, 24 Aug 2023 01:22:33 -0500 (CDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy1.foxvalley.net (Postfix) with ESMTP id 7F4D040F3C;
        Thu, 24 Aug 2023 01:22:33 -0500 (CDT)
X-Virus-Scanned: amavis at zproxy1.foxvalley.net
Received: from zproxy1.foxvalley.net ([127.0.0.1])
 by localhost (zproxy1.foxvalley.net [127.0.0.1]) (amavis, port 10026)
 with ESMTP id L069RT_IrlCd; Thu, 24 Aug 2023 01:22:33 -0500 (CDT)
Received: from [192.168.1.3] (unknown [161.97.241.227])
        by zproxy1.foxvalley.net (Postfix) with ESMTPSA id 3948640F2A;
        Thu, 24 Aug 2023 01:22:33 -0500 (CDT)
Message-ID: <ebb4e530-d0f5-d61b-658b-9cd621db65ae@foxvalley.net>
Date:   Thu, 24 Aug 2023 00:22:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] tty/serial: create debugfs interface for UART register
 tracing
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
References: <68ad2521-f902-b0d3-16d6-4d2a36ac656e@foxvalley.net>
 <2023082303-cruncher-exporter-ccb1@gregkh>
From:   Dan Raymond <draymond@foxvalley.net>
In-Reply-To: <2023082303-cruncher-exporter-ccb1@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 8/23/2023 1:01 AM, Greg KH wrote:

> This really should be a Kconfig option as some people will not want the
> added size, or feature, in their system as many serial ports have data
> that other users, even root ones, shouldn't be snooping on (i.e.
> cell modems.)

Done.

> Can you wrap comments at 80 columns please?  Code is fine to go to 100.

Sure.

>> + *
>> + *  Each serial port ("ttyS0", "ttyS1", etc.) will have its own directory in the root of
>> + *  the debug filesystem.  Inside each directory will be the following pseudo-files:
>> + *
>> + *  trace_all    - toggles tracing of all registers vs. just the RX/TX registers
> So 0 is just rx/tx?

Yes, 0 is just rx/tx.  I've updated the comment to reflect that.

> This should be documented somewhere in Documentation/ OR better yet, in
> kernel doc format so that when building the documentation, it sucks it
> in from this file to be included there automatically.
>
> And what are the default values of these files at boot?

I've converted this to kernel-doc format and linked it to 
Documentation/trace/index.rst.  I've also documented the default values.

>> + *  Example session:
>> + *
>> + *  > mount -t debugfs debugfs /sys/kernel/debug
>> + *  > echo '1' > /sys/kernel/debug/ttyS1/trace_all
>> + *  > echo '1' > /sys/kernel/debug/ttyS1/trace_enable
> Any reason why you didn't just use the existing kernel tracing facility
> for all of this?

No, it just seemed easier to use the debugfs.  Not a good reason, I 
know.  I'll take a closer look at the tracefs for this.

> This is the big issue I have with this change, sorry, it's an odd one.
>
> The use of "uintX_t" variable types belongs in userspace, these are not
> kernel data types (yes, they are used in places, but no, they do not
> make sense, see the many times Linus and I have talked about this in the
> past, wrong namespace, etc.)
>
> Can you change these all to the normal types of u32, u16, u8 and so on
> please?

Done.

>> +struct reg_queue {
>> +	uint32_t          read_idx;   /* first full (written) slot */
>> +	uint32_t          write_idx;  /* first empty (unwritten) slot */
>> +	struct reg_event *buf;        /* array to hold the data */
>> +	uint32_t          size;       /* array size (number of entries - must be power of 2) */
>> +	bool              wrap;       /* true if write_idx wrapped around and reached read_idx */
> If you use pahole on this structure, you will see you can get this a bit
> smaller.  Although I don't think you use this a lot, right?

I was using a 32-bit target and pahole didn't show any gaps. Does the 
pointer cause a gap on 64-bit targets?  In any case I moved the pointer 
to the top of the structure.

>> +
>> +struct uart_debug {
>> +	spinlock_t        lock;
>> +	struct mutex      mutex;
> Why 2 locks?  Please document these.

The spinlock protects the 'struct reg_queue' which can be accessed from 
interrupt context and normal context.  The mutex protects the outer data 
structure which only the user accesses so it doesn't need to disable 
interrupts.  I moved the spinlock to the reg_queue to make this more 
explicit.

>> +	char              line[64];  /* buffer to hold text of last item removed from queue */
> Why 64?

I changed it to 28 which is just enough to hold the 26-character 
register event string + newline + NUL.

>> +static ssize_t      all_read(struct file *filp, char __user *buf, size_t size, loff_t *ppos);
>> +static ssize_t      all_write(struct file *filp,
>> +			const char __user *buf, size_t size, loff_t *ppos);
>> +static ssize_t      buffer_read(struct file *filp, char __user *buf, size_t size, loff_t *ppos);
>> +static ssize_t      enable_read(struct file *filp, char __user *buf, size_t size, loff_t *ppos);
>> +static ssize_t      enable_write(struct file *filp,
>> +			const char __user *buf, size_t size, loff_t *ppos);
>> +static void         format_cycle(uint64_t cpu_cycles, char *buf, uint32_t size);
>> +static void         queue_add(struct uart_port *port, uint8_t reg, uint8_t data, bool write);
>> +static bool         queue_alloc(struct uart_port *port);
>> +static void         queue_free(struct uart_port *port, bool force);
>> +static void         queue_remove(struct uart_port *port, char *buf, uint32_t size);
>> +static unsigned int serial_in_wrapper(struct uart_port *port, int offset);
>> +static void         serial_out_wrapper(struct uart_port *port, int offset, int value);
>> +static ssize_t      size_read(struct file *filp, char __user *buf, size_t size, loff_t *ppos);
>> +static ssize_t      size_write(struct file *filp,
>> +			const char __user *buf, size_t size, loff_t *ppos);
> Any chance to reorginize the code to not need the forward declarations?

I generally keep functions in alphabetical order and choose names 
accordingly so they are grouped the way I want.  For example, the 
queue_xxx() functions are the only ones that touch the reg_queue 
structure.  I use forward declarations (whether needed or not) to avoid 
compiler errors regardless of the function order.  Is this a bad practice?

> Nice hack to make the overhead "zero" but now you have 2 function jumps
> per character, on some systems that can be a lot of overhead.  Why not
> just use the existing trace functionality for this instead?  If the
> feature is not enabled, it will not have any overhead, and if it is, it
> will only have the one call to your hook, saving you another function
> call jump (which on modern processors is VERY slow thanks to spectre
> issues...)

Can you clarify the functionality you are suggesting?  Is it the mcount 
call inserted by the compiler for function tracing?  I guess I need to 
get more familiar with the kernel tracing facility to make a comparison 
but maybe you could point me in the right direction?

>
> We do have at least 2 different ringbuffer structures in the kernel, why
> create another one?

Can you point me to the structures you have in mind?  One thought is 
that I have a 'wrap' flag which is a little paranoid but it ensures that 
a buffer overflow is detected.

> Anyway, again, cool feature, I like it, but if you can tie it into the
> existing trace framework better (either by using that entirely which
> might be best), or at the least, putting your hook into the data path
> with it, that would be best.
>
> thanks,
>
> greg k-h

Thanks for your review!  I've created another patch that incorporates 
most of your suggestions and I'll post that next. I'll also spend some 
more time looking at the tracefs to address your other suggestions.

