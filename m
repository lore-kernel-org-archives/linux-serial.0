Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA05EE49A0
	for <linux-serial@archiver.kernel.org>; Wed, 23 Aug 2023 07:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbjHWHBW (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 23 Aug 2023 03:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbjHWHBW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 23 Aug 2023 03:01:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34FECE8
        for <linux-serial@vger.kernel.org>; Wed, 23 Aug 2023 00:01:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A96164582
        for <linux-serial@vger.kernel.org>; Wed, 23 Aug 2023 07:01:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE05C433C7;
        Wed, 23 Aug 2023 07:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692774078;
        bh=yI8UvSApzce4G+8RSyXAw6882AmX/21K+UURhiwnKCw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xn0iGOFdBrZZMl1s+5uLHw0U2wO1Si4r85+m27ePl1KPlVM6kL/5zXyZv9K/Xn61g
         0JNJ9NYy3c37y0EAUVB2q7hUAUIjvC2uwMarIOGatRQj25ECG3enf3rkUVdbluwgsY
         h3ybk3JYh/i2kgCPkuIrwxXHV7AETXI6cKeicD98=
Date:   Wed, 23 Aug 2023 09:01:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dan Raymond <draymond@foxvalley.net>
Cc:     linux-serial@vger.kernel.org
Subject: Re: [PATCH] tty/serial: create debugfs interface for UART register
 tracing
Message-ID: <2023082303-cruncher-exporter-ccb1@gregkh>
References: <68ad2521-f902-b0d3-16d6-4d2a36ac656e@foxvalley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <68ad2521-f902-b0d3-16d6-4d2a36ac656e@foxvalley.net>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Aug 22, 2023 at 02:50:45PM -0600, Dan Raymond wrote:
> Implement a UART register tracing facility using the debugfs.  This can be
> used as a "serial port sniffer" to monitor UART traffic and line settings
> with timestamps at microsecond granularity.  This can be useful for general
> serial port debugging or to debug the UART driver itself.

Nice!

Some comments on the patch:

> Signed-off-by: Dan Raymond<draymond@foxvalley.net>

Nit, you need a ' ' before the '<' character.

> ---
> diff -uprN -X a/Documentation/dontdiff a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
> --- a/drivers/tty/serial/8250/8250.h	2022-11-16 02:04:15.000000000 -0700
> +++ b/drivers/tty/serial/8250/8250.h	2023-08-21 16:15:51.429933400 -0600
> @@ -403,3 +403,6 @@ static inline int serial_index(struct ua
>  {
>  	return port->minor - 64;
>  }
> +
> +extern void uart_debug_create(struct uart_port *port);
> +extern void uart_debug_destroy(struct uart_port *port);

This really should be a Kconfig option as some people will not want the
added size, or feature, in their system as many serial ports have data
that other users, even root ones, shouldn't be snooping on (i.e.
cell modems.)

> diff -uprN -X a/Documentation/dontdiff a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> --- a/drivers/tty/serial/8250/8250_core.c	2022-11-16 02:04:15.000000000 -0700
> +++ b/drivers/tty/serial/8250/8250_core.c	2023-08-21 16:16:47.502740700 -0600
> @@ -1094,6 +1094,7 @@ int serial8250_register_8250_port(const
>  			if (ret)
>  				goto err;
> +			uart_debug_create(&uart->port);
>  			ret = uart->port.line;
>  		} else {
>  			dev_info(uart->port.dev,
> @@ -1151,6 +1152,7 @@ void serial8250_unregister_port(int line
>  		spin_unlock_irqrestore(&uart->port.lock, flags);
>  	}
> +	uart_debug_destroy(&uart->port);
>  	uart_remove_one_port(&serial8250_reg, &uart->port);
>  	if (serial8250_isa_devs) {
>  		uart->port.flags &= ~UPF_BOOT_AUTOCONF;
> diff -uprN -X a/Documentation/dontdiff a/drivers/tty/serial/8250/8250_debug.c b/drivers/tty/serial/8250/8250_debug.c
> --- a/drivers/tty/serial/8250/8250_debug.c	1969-12-31 17:00:00.000000000 -0700
> +++ b/drivers/tty/serial/8250/8250_debug.c	2023-08-22 13:19:12.234454600 -0600
> @@ -0,0 +1,519 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + *  This module creates a debugfs interface that can be used to hook the low level serial
> + *  I/O routines and generate timestamped traces of UART register reads and writes.  This
> + *  feature provides an accurate and reliable "serial port sniffer" that can be used for
> + *  debugging problems with the serial port.

Can you wrap comments at 80 columns please?  Code is fine to go to 100.

> + *
> + *  Each serial port ("ttyS0", "ttyS1", etc.) will have its own directory in the root of
> + *  the debug filesystem.  Inside each directory will be the following pseudo-files:
> + *
> + *  trace_all    - toggles tracing of all registers vs. just the RX/TX registers

So 0 is just rx/tx?

> + *  trace_buffer - for consuming the trace data
> + *  trace_enable - enables/disables tracing
> + *  trace_size   - configures the size of the trace buffer

This should be documented somewhere in Documentation/ OR better yet, in
kernel doc format so that when building the documentation, it sucks it
in from this file to be included there automatically.

And what are the default values of these files at boot?

> + *
> + *  When tracing is disabled there will be zero impact to the operation of the UART
> + *  driver.  When tracing is enabled a small cost will be incurred after every register
> + *  access to write an entry to the trace buffer in RAM.  The buffer size is limited
> + *  only by the amount of virtual memory available to the kernel.  This is 128 MiB by
> + *  default but it can be increased using vmalloc=xxx on the kernel command line.  The
> + *  memory will be freed after tracing is disabled and all data in the buffer has been
> + *  consumed.
> + *
> + *  Example session:
> + *
> + *  > mount -t debugfs debugfs /sys/kernel/debug
> + *  > echo '1' > /sys/kernel/debug/ttyS1/trace_all
> + *  > echo '1' > /sys/kernel/debug/ttyS1/trace_enable

Any reason why you didn't just use the existing kernel tracing facility
for all of this?

> + *
> + *  (perform UART operation)
> + *
> + *  > cat /sys/kernel/debug/ttyS1/trace_buffer
> + *
> + *  00:03:04.822166  IER <- 07
> + *  00:03:04.822175  IIR -> C2
> + *  00:03:04.822177  LSR -> 60
> + *  00:03:04.822178  MSR -> 00
> + *  00:03:04.822180  THR <- C9
> + *  00:03:04.822184  IER <- 05
> + *  00:03:04.822185  IIR -> C1
> + *  00:03:05.062943  IIR -> CC
> + *  00:03:05.062945  LSR -> 61
> + *  00:03:05.062948  RBR -> C9
> + *  00:03:05.062950  LSR -> 61
> + *  00:03:05.062952  RBR -> ED
> + *  00:03:05.062953  LSR -> 61
> + *  00:03:05.062954  RBR -> 00
> + *  00:03:05.062955  LSR -> 60
> + *  00:03:05.062965  MSR -> 00
> + *  00:03:05.062967  IIR -> C1
> + */
> +
> +#include <linux/cpufreq.h>
> +#include <linux/debugfs.h>
> +#include <linux/fs.h>
> +#include <linux/math64.h>
> +#include <linux/serial_8250.h>
> +
> +struct reg_event {
> +	uint32_t  cycle_lo;  /* CPU cycle count (lower 32-bits) */

This is the big issue I have with this change, sorry, it's an odd one.

The use of "uintX_t" variable types belongs in userspace, these are not
kernel data types (yes, they are used in places, but no, they do not
make sense, see the many times Linus and I have talked about this in the
past, wrong namespace, etc.)

Can you change these all to the normal types of u32, u16, u8 and so on
please?


> +	uint16_t  cycle_hi;  /* CPU cycle count (upper 16-bits) */
> +	uint8_t   access;    /* write flag + register number */
> +	uint8_t   data;      /* register data */
> +};
> +
> +struct reg_queue {
> +	uint32_t          read_idx;   /* first full (written) slot */
> +	uint32_t          write_idx;  /* first empty (unwritten) slot */
> +	struct reg_event *buf;        /* array to hold the data */
> +	uint32_t          size;       /* array size (number of entries - must be power of 2) */
> +	bool              wrap;       /* true if write_idx wrapped around and reached read_idx */

If you use pahole on this structure, you will see you can get this a bit
smaller.  Although I don't think you use this a lot, right?

> +};
> +
> +struct uart_debug {
> +	spinlock_t        lock;
> +	struct mutex      mutex;

Why 2 locks?  Please document these.

> +	bool              trace_enable;
> +	bool              trace_all;
> +	uint32_t          trace_size;
> +	unsigned int      (*original_serial_in)(struct uart_port *p, int offset);
> +	void              (*original_serial_out)(struct uart_port *p, int offset, int value);
> +	struct reg_queue  register_queue;
> +	char              line[64];  /* buffer to hold text of last item removed from queue */

Why 64?

> +	uint32_t          offset;    /* offset of first unread byte in line */
> +};
> +
> +static ssize_t      all_read(struct file *filp, char __user *buf, size_t size, loff_t *ppos);
> +static ssize_t      all_write(struct file *filp,
> +			const char __user *buf, size_t size, loff_t *ppos);
> +static ssize_t      buffer_read(struct file *filp, char __user *buf, size_t size, loff_t *ppos);
> +static ssize_t      enable_read(struct file *filp, char __user *buf, size_t size, loff_t *ppos);
> +static ssize_t      enable_write(struct file *filp,
> +			const char __user *buf, size_t size, loff_t *ppos);
> +static void         format_cycle(uint64_t cpu_cycles, char *buf, uint32_t size);
> +static void         queue_add(struct uart_port *port, uint8_t reg, uint8_t data, bool write);
> +static bool         queue_alloc(struct uart_port *port);
> +static void         queue_free(struct uart_port *port, bool force);
> +static void         queue_remove(struct uart_port *port, char *buf, uint32_t size);
> +static unsigned int serial_in_wrapper(struct uart_port *port, int offset);
> +static void         serial_out_wrapper(struct uart_port *port, int offset, int value);
> +static ssize_t      size_read(struct file *filp, char __user *buf, size_t size, loff_t *ppos);
> +static ssize_t      size_write(struct file *filp,
> +			const char __user *buf, size_t size, loff_t *ppos);

Any chance to reorginize the code to not need the forward declarations?

> +/*
> + *  Handle writes to the 'trace_enable' pseudo-file.  When tracing is enabled allocate
> + *  memory for the register event queue and install our hooks.  When tracing is disabled
> + *  remove our hooks and free the memory used by the register event queue if it is empty.
> + */
> +static ssize_t enable_write(struct file *filp, const char __user *buf, size_t size, loff_t *ppos)
> +{
> +	struct uart_port *port = filp->private_data;
> +	struct uart_debug *uart_debug = port->private_data;
> +	bool trace_enable;
> +	int error;
> +
> +	error = kstrtobool_from_user(buf, size, &trace_enable);
> +	if (error)
> +		return error;
> +
> +	if (mutex_lock_interruptible(&uart_debug->mutex))
> +		return -ERESTARTSYS;
> +	if (trace_enable == uart_debug->trace_enable)
> +		goto exit;
> +
> +	if (trace_enable) {
> +		uart_debug->line[0] = '\0';
> +		uart_debug->offset = 0;
> +		queue_free(port, true);
> +		if (!queue_alloc(port))
> +			goto exit;
> +
> +		uart_debug->original_serial_out = port->serial_out;
> +		uart_debug->original_serial_in  = port->serial_in;
> +		port->serial_out = serial_out_wrapper;
> +		port->serial_in  = serial_in_wrapper;

Nice hack to make the overhead "zero" but now you have 2 function jumps
per character, on some systems that can be a lot of overhead.  Why not
just use the existing trace functionality for this instead?  If the
feature is not enabled, it will not have any overhead, and if it is, it
will only have the one call to your hook, saving you another function
call jump (which on modern processors is VERY slow thanks to spectre
issues...)

> +/*
> + *  Remove an entry from the register event queue.  The entry will be converted to a text
> + *  string and written to the caller's buffer.  If no entries are available an empty string
> + *  will be written.
> + */
> +static void queue_remove(struct uart_port *port, char *buf, uint32_t size)
> +{
> +	struct uart_debug *uart_debug = port->private_data;
> +	struct reg_queue *queue = &uart_debug->register_queue;
> +	struct reg_event event;
> +	const char * const in_regs[]  = { "RBR", "IER", "IIR", "LCR", "MCR", "LSR", "MSR", "SCR" };
> +	const char * const out_regs[] = { "THR", "IER", "FCR", "LCR", "MCR", "LSR", "MSR", "SCR" };
> +	uint8_t reg;
> +	const char *sym, *dir;
> +	char elapsed[sizeof("hh:mm:ss.mmmuuu")];
> +	uint32_t num_events, events_lost;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&uart_debug->lock, flags);
> +
> +	num_events = queue->write_idx - queue->read_idx;
> +	events_lost = num_events > queue->size ? num_events - queue->size : 0;
> +	events_lost = queue->wrap ? 0xFFFFFFFF : events_lost;

We do have at least 2 different ringbuffer structures in the kernel, why
create another one?

Anyway, again, cool feature, I like it, but if you can tie it into the
existing trace framework better (either by using that entirely which
might be best), or at the least, putting your hook into the data path
with it, that would be best.

thanks,

greg k-h
