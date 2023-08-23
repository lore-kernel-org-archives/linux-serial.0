Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E566EE4993
	for <linux-serial@archiver.kernel.org>; Wed, 23 Aug 2023 08:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233882AbjHWIeZ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 23 Aug 2023 04:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234726AbjHWIcl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 23 Aug 2023 04:32:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB68CE77
        for <linux-serial@vger.kernel.org>; Wed, 23 Aug 2023 01:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692779417; x=1724315417;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=0Yl70CpRNnL4i1H/HMSbTL7DgrnFUmdxI/KVV9jssuQ=;
  b=I38DHa/FtliH+ro0qmj7JICJTs6BfeyGsuTJtLg8TJQ/9QGqVPN/NSZQ
   2hQOfWunNXVujrtBAHS6VaB7vazXsoKrZPryTrGTSRnqNvhVeH3XYvutg
   4p+2KUPv6s0cmBtOlVad9wleZetbbvxC3ejD2ctrgLE8dqxPW3mTO73Nn
   oWknSY5x7ktZ02SDHAYyded12ef7YmiuOkMkQDQ62XYRc1cq0nd29Demg
   2d2XHSkhq4r7o3lYb+MXIwJVynElz6IBvl4aYqXMNLBrEWBSpOsO0MFVr
   HhLkCy8MNl+mRn/Hpc5oNxU1aN4XliachgC9F9SA6zYXAIeNa0GFkUjdP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="374077960"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="374077960"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 01:30:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="983192078"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="983192078"
Received: from amangalo-mobl4.ger.corp.intel.com ([10.252.55.236])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 01:30:15 -0700
Date:   Wed, 23 Aug 2023 11:30:13 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Dan Raymond <draymond@foxvalley.net>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH] tty/serial: create debugfs interface for UART register
 tracing
In-Reply-To: <68ad2521-f902-b0d3-16d6-4d2a36ac656e@foxvalley.net>
Message-ID: <9c63a3a-2720-4e2b-5155-eb6e36aef257@linux.intel.com>
References: <68ad2521-f902-b0d3-16d6-4d2a36ac656e@foxvalley.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1373145534-1692776700=:1805"
Content-ID: <1b6a8522-a4bf-49c4-d74-16625f8498d@linux.intel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1373145534-1692776700=:1805
Content-Type: text/plain; CHARSET=ISO-8859-7
Content-Transfer-Encoding: 8BIT
Content-ID: <76efb36d-3a71-29b5-ea3-9cd152efba6d@linux.intel.com>

On Tue, 22 Aug 2023, Dan Raymond wrote:

> Implement a UART register tracing facility using the debugfs.  This can be
> used as a "serial port sniffer" to monitor UART traffic and line settings
> with timestamps at microsecond granularity.  This can be useful for general
> serial port debugging or to debug the UART driver itself.

Thanks, looks useful (although it might have challenge in tracing hw 
during early init).

> Signed-off-by: Dan Raymond<draymond@foxvalley.net>
> ---
> diff -uprN -X a/Documentation/dontdiff a/drivers/tty/serial/8250/8250.h
> b/drivers/tty/serial/8250/8250.h
> --- a/drivers/tty/serial/8250/8250.h	2022-11-16 02:04:15.000000000 -0700
> +++ b/drivers/tty/serial/8250/8250.h	2023-08-21 16:15:51.429933400 -0600
> @@ -403,3 +403,6 @@ static inline int serial_index(struct ua
>  {
>  	return port->minor - 64;
>  }
> +
> +extern void uart_debug_create(struct uart_port *port);
> +extern void uart_debug_destroy(struct uart_port *port);
> diff -uprN -X a/Documentation/dontdiff a/drivers/tty/serial/8250/8250_core.c
> b/drivers/tty/serial/8250/8250_core.c
> --- a/drivers/tty/serial/8250/8250_core.c	2022-11-16 02:04:15.000000000
> -0700
> +++ b/drivers/tty/serial/8250/8250_core.c	2023-08-21 16:16:47.502740700
> -0600
> @@ -1094,6 +1094,7 @@ int serial8250_register_8250_port(const
>  			if (ret)
>  				goto err;
>  +			uart_debug_create(&uart->port);
>  			ret = uart->port.line;
>  		} else {
>  			dev_info(uart->port.dev,
> @@ -1151,6 +1152,7 @@ void serial8250_unregister_port(int line
>  		spin_unlock_irqrestore(&uart->port.lock, flags);
>  	}
>  +	uart_debug_destroy(&uart->port);
>  	uart_remove_one_port(&serial8250_reg, &uart->port);
>  	if (serial8250_isa_devs) {
>  		uart->port.flags &= ~UPF_BOOT_AUTOCONF;
> diff -uprN -X a/Documentation/dontdiff a/drivers/tty/serial/8250/8250_debug.c
> b/drivers/tty/serial/8250/8250_debug.c
> --- a/drivers/tty/serial/8250/8250_debug.c	1969-12-31 17:00:00.000000000
> -0700
> +++ b/drivers/tty/serial/8250/8250_debug.c	2023-08-22 13:19:12.234454600
> -0600
> @@ -0,0 +1,519 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + *  This module creates a debugfs interface that can be used to hook the low
> level serial
> + *  I/O routines and generate timestamped traces of UART register reads and
> writes.  This
> + *  feature provides an accurate and reliable "serial port sniffer" that can
> be used for
> + *  debugging problems with the serial port.
> + *
> + *  Each serial port ("ttyS0", "ttyS1", etc.) will have its own directory in
> the root of
> + *  the debug filesystem.  Inside each directory will be the following
> pseudo-files:
> + *
> + *  trace_all    - toggles tracing of all registers vs. just the RX/TX
> registers
> + *  trace_buffer - for consuming the trace data
> + *  trace_enable - enables/disables tracing
> + *  trace_size   - configures the size of the trace buffer
> + *
> + *  When tracing is disabled there will be zero impact to the operation of
> the UART
> + *  driver.  When tracing is enabled a small cost will be incurred after
> every register
> + *  access to write an entry to the trace buffer in RAM.  The buffer size is
> limited
> + *  only by the amount of virtual memory available to the kernel.  This is
> 128 MiB by
> + *  default but it can be increased using vmalloc=xxx on the kernel command
> line.  The
> + *  memory will be freed after tracing is disabled and all data in the buffer
> has been
> + *  consumed.
> + *
> + *  Example session:
> + *
> + *  > mount -t debugfs debugfs /sys/kernel/debug
> + *  > echo '1' > /sys/kernel/debug/ttyS1/trace_all
> + *  > echo '1' > /sys/kernel/debug/ttyS1/trace_enable
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
> +	uint16_t  cycle_hi;  /* CPU cycle count (upper 16-bits) */
> +	uint8_t   access;    /* write flag + register number */
> +	uint8_t   data;      /* register data */

Some HW-specific registers are larger than 8 bits.

> +};

> +
> +struct reg_queue {
> +	uint32_t          read_idx;   /* first full (written) slot */
> +	uint32_t          write_idx;  /* first empty (unwritten) slot */
> +	struct reg_event *buf;        /* array to hold the data */
> +	uint32_t          size;       /* array size (number of entries - must
> be power of 2) */
> +	bool              wrap;       /* true if write_idx wrapped around and
> reached read_idx */
> +};
> +
> +struct uart_debug {
> +	spinlock_t        lock;
> +	struct mutex      mutex;
> +	bool              trace_enable;
> +	bool              trace_all;
> +	uint32_t          trace_size;
> +	unsigned int      (*original_serial_in)(struct uart_port *p, int
> offset);
> +	void              (*original_serial_out)(struct uart_port *p, int
> offset, int value);
> +	struct reg_queue  register_queue;
> +	char              line[64];  /* buffer to hold text of last item
> removed from queue */
> +	uint32_t          offset;    /* offset of first unread byte in line */
> +};
> +
> +static ssize_t      all_read(struct file *filp, char __user *buf, size_t
> size, loff_t *ppos);
> +static ssize_t      all_write(struct file *filp,
> +			const char __user *buf, size_t size, loff_t *ppos);
> +static ssize_t      buffer_read(struct file *filp, char __user *buf, size_t
> size, loff_t *ppos);
> +static ssize_t      enable_read(struct file *filp, char __user *buf, size_t
> size, loff_t *ppos);
> +static ssize_t      enable_write(struct file *filp,
> +			const char __user *buf, size_t size, loff_t *ppos);
> +static void         format_cycle(uint64_t cpu_cycles, char *buf, uint32_t
> size);
> +static void         queue_add(struct uart_port *port, uint8_t reg, uint8_t
> data, bool write);
> +static bool         queue_alloc(struct uart_port *port);
> +static void         queue_free(struct uart_port *port, bool force);
> +static void         queue_remove(struct uart_port *port, char *buf, uint32_t
> size);
> +static unsigned int serial_in_wrapper(struct uart_port *port, int offset);
> +static void         serial_out_wrapper(struct uart_port *port, int offset,
> int value);
> +static ssize_t      size_read(struct file *filp, char __user *buf, size_t
> size, loff_t *ppos);
> +static ssize_t      size_write(struct file *filp,
> +			const char __user *buf, size_t size, loff_t *ppos);
> +
> +static const struct file_operations all_fops = {
> +	.open  = simple_open,
> +	.read  = all_read,
> +	.write = all_write,
> +};
> +
> +static const struct file_operations buffer_fops = {
> +	.open = simple_open,
> +	.read = buffer_read,
> +};
> +
> +static const struct file_operations enable_fops = {
> +	.open  = simple_open,
> +	.read  = enable_read,
> +	.write = enable_write,
> +};
> +
> +static const struct file_operations size_fops = {
> +	.open  = simple_open,
> +	.read  = size_read,
> +	.write = size_write,
> +};
> +
> +/*
> + *  Handle reads from the 'trace_all' pseudo-file.  Report the state of the
> trace_all flag.
> + */
> +static ssize_t all_read(struct file *filp, char __user *buf, size_t size,
> loff_t *ppos)
> +{
> +	struct uart_port *port = filp->private_data;
> +	struct uart_debug *uart_debug = port->private_data;
> +	char text[16];
> +	uint32_t len;
> +
> +	len = snprintf(text, sizeof(text), "%u\n", uart_debug->trace_all);
> +	return simple_read_from_buffer(buf, size, ppos, text, len);
> +}
> +
> +/*
> + *  Handle writes to the 'trace_all' pseudo-file.  Set the state of the
> trace_all flag.
> + */
> +static ssize_t all_write(struct file *filp, const char __user *buf, size_t
> size, loff_t *ppos)
> +{
> +	struct uart_port *port = filp->private_data;
> +	struct uart_debug *uart_debug = port->private_data;
> +	int error;
> +
> +	error = kstrtobool_from_user(buf, size, &uart_debug->trace_all);
> +	if (error)
> +		return error;
> +
> +	return size;
> +}
> +
> +/*
> + *  Handle reads from the 'trace_buffer' pseudo-file.  This function consumes
> content in
> + *  the register event queue.  A best effort will be made to avoid splitting
> lines of text.
> + */
> +static ssize_t buffer_read(struct file *filp, char __user *buf, size_t size,
> loff_t *ppos)
> +{
> +	struct uart_port *port = filp->private_data;
> +	struct uart_debug *uart_debug = port->private_data;
> +	uint32_t len, num_bytes, total_bytes = 0;
> +	const char *ptr;
> +	int error = 0;
> +
> +	if (mutex_lock_interruptible(&uart_debug->mutex))
> +		return -ERESTARTSYS;
> +
> +	while (size) {
> +		if (uart_debug->line[uart_debug->offset] == '\0') {
> +			uart_debug->offset = 0;
> +			queue_remove(port, uart_debug->line,
> sizeof(uart_debug->line));
> +			if (uart_debug->line[0] == '\0')
> +				break;
> +		}
> +
> +		ptr = uart_debug->line + uart_debug->offset;
> +		len = strlen(ptr);

Why you need to calculate length? Shouldn't queue_remove() be able to return 
this information?

> +		num_bytes = (size < len) ? size : len;

min_t().

> +
> +		if (num_bytes < len && total_bytes)
> +			break;
> +		if (copy_to_user(buf, ptr, num_bytes)) {
> +			error = -EFAULT;
> +			break;
> +		}
> +
> +		buf += num_bytes;
> +		size -= num_bytes;
> +		total_bytes += num_bytes;
> +		uart_debug->offset += num_bytes;
> +	}
> +
> +	if (!uart_debug->trace_enable)
> +		queue_free(port, false);
> +
> +	mutex_unlock(&uart_debug->mutex);
> +	if (error)
> +		return total_bytes ? total_bytes : error;
> +	return total_bytes;

So this is same as:
	if (!total_bytes)
		return error;

	return total_bytes;

> +}
> +
> +/*
> + *  Handle reads from the 'trace_enable' pseudo-file.  Report the current
> state of the
> + *  trace_enable flag.
> + */
> +static ssize_t enable_read(struct file *filp, char __user *buf, size_t size,
> loff_t *ppos)
> +{
> +	struct uart_port *port = filp->private_data;
> +	struct uart_debug *uart_debug = port->private_data;
> +	char text[16];
> +	uint32_t len;
> +
> +	len = snprintf(text, sizeof(text), "%u\n", uart_debug->trace_enable);
> +	return simple_read_from_buffer(buf, size, ppos, text, len);
> +}
> +
> +/*
> + *  Handle writes to the 'trace_enable' pseudo-file.  When tracing is enabled
> allocate
> + *  memory for the register event queue and install our hooks.  When tracing
> is disabled
> + *  remove our hooks and free the memory used by the register event queue if
> it is empty.
> + */
> +static ssize_t enable_write(struct file *filp, const char __user *buf, size_t
> size, loff_t *ppos)
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
> +	} else {
> +		port->serial_out = uart_debug->original_serial_out;
> +		port->serial_in  = uart_debug->original_serial_in;
> +
> +		queue_free(port, false);
> +	}
> +
> +	uart_debug->trace_enable = trace_enable;
> +exit:
> +	mutex_unlock(&uart_debug->mutex);
> +	return size;
> +}
> +
> +/*
> + *  Convert 'cpu_cycles' to a string that reports the time elapsed since boot
> in
> + *  hours/mins/seconds/microseconds.
> + */
> +static void format_cycle(uint64_t cpu_cycles, char *buf, uint32_t size)

For in-kernel interfaces, use u64 and u32, uintxx_t is for userspace 
interactions.

> +{
> +	static uint64_t cpu_freq;  /* cycles per second */
> +	uint32_t h, m, s, us;
> +
> +	if (cpu_freq == 0)
> +		cpu_freq = arch_freq_get_on_cpu(0) * 1000ULL;
> +
> +	s = div64_u64_rem(cpu_cycles, cpu_freq, &cpu_cycles);
> +	us = div64_u64(cpu_cycles * 1000 * 1000 + 500 * 1000, cpu_freq);
> +
> +	m = s / 60; s = s % 60;
> +	h = m / 60; m = m % 60;
> +
> +	snprintf(buf, size, "%02d:%02d:%02d.%06u", h, m, s, us);

seconds.us is enough. If some additional formatting is to happen, it 
should be done in userspace.

> +}
> +
> +/*
> + *  Add an entry to the register event queue.  This can run in interrupt
> context
> + *  so it needs to be as fast as possible.
> + */
> +static void queue_add(struct uart_port *port, uint8_t reg, uint8_t data, bool
> write)
> +{
> +	struct uart_debug *uart_debug = port->private_data;
> +	struct reg_queue *queue = &uart_debug->register_queue;
> +	uint64_t cpu_cycle;
> +	struct reg_event event;
> +	unsigned long flags;
> +
> +	if (!uart_debug->trace_all && reg != 0x00)
> +		return;
> +
> +	cpu_cycle      = rdtsc();
> +	event.cycle_lo = (uint32_t)cpu_cycle;
> +	event.cycle_hi = (uint16_t)(cpu_cycle >> 32);
> +	event.access   = (write ? 0x08 : 0x00) | reg;

Use defines for these literals.

> +	event.data     = data;
> +
> +	spin_lock_irqsave(&uart_debug->lock, flags);
> +
> +	queue->buf[queue->write_idx & (queue->size - 1)] = event;
> +	queue->write_idx++;
> +
> +	if (queue->write_idx == queue->read_idx)
> +		queue->wrap = true;
> +
> +	spin_unlock_irqrestore(&uart_debug->lock, flags);
> +}
> +
> +/*
> + *  Allocate memory for the register event queue.  We use vmalloc() instead
> of kmalloc()
> + *  because we don't need physically contiguous memory and kmalloc() is
> limited to 4 MiB.
> + *  If memory allocation fails we will try again with a smaller buffer.  The
> user can
> + *  detect this by reading 'trace_size' after enabling tracing.
> + */
> +static bool queue_alloc(struct uart_port *port)
> +{
> +	struct uart_debug *uart_debug = port->private_data;
> +	struct reg_queue *queue = &uart_debug->register_queue;
> +
> +	queue->size = uart_debug->trace_size;
> +	queue->buf = vmalloc(queue->size * sizeof(struct reg_event));
> +
> +	while (queue->buf == NULL) {
> +		queue->size >>= 1;
> +		if (queue->size == 0)
> +			return false;
> +		queue->buf = vmalloc(queue->size * sizeof(struct reg_event));
> +	}
> +
> +	uart_debug->trace_size = queue->size;
> +	return true;
> +}
> +
> +/*
> + *  Free the memory used by the register event queue if the queue is empty.
> If the 'force'
> + *  flag is 'true' free the memory even if the queue is not empty.
> + *
> + *  The noinline attribute suppresses a bug in gcc 11.3.0 that generates a
> bogus error:
> + *
> + *  error: ¡__builtin_memset¢ offset [0, 19] is out of the bounds [0, 0]
> [-Werror=array-bounds]
> + */
> +static noinline void queue_free(struct uart_port *port, bool force)
> +{
> +	struct uart_debug *uart_debug = port->private_data;
> +	struct reg_queue *queue = &uart_debug->register_queue;
> +
> +	if (force || queue->read_idx == queue->write_idx) {

Why cannot the only place where force=true just reset the indexes before 
making the call so no force parameter is required? ...I think there's a 
bug anyway with the indexes not getting properly reset in that case.

> +		vfree(queue->buf);
> +		memset(queue, 0, sizeof(*queue));
> +	}
> +}
> +
> +/*
> + *  Remove an entry from the register event queue.  The entry will be
> converted to a text
> + *  string and written to the caller's buffer.  If no entries are available
> an empty string
> + *  will be written.
> + */
> +static void queue_remove(struct uart_port *port, char *buf, uint32_t size)
> +{
> +	struct uart_debug *uart_debug = port->private_data;
> +	struct reg_queue *queue = &uart_debug->register_queue;
> +	struct reg_event event;
> +	const char * const in_regs[]  = { "RBR", "IER", "IIR", "LCR", "MCR",
> "LSR", "MSR", "SCR" };
> +	const char * const out_regs[] = { "THR", "IER", "FCR", "LCR", "MCR",
> "LSR", "MSR", "SCR" };
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
> +
> +	if (events_lost) {
> +		queue->read_idx += num_events - queue->size;
> +		queue->wrap = false;
> +	} else if (num_events) {
> +		event = queue->buf[queue->read_idx & (queue->size - 1)];
> +		queue->read_idx++;
> +	}
> +
> +	spin_unlock_irqrestore(&uart_debug->lock, flags);
> +
> +	if (events_lost) {
> +		snprintf(buf, size, "queue overflow (%u events lost)\n",
> events_lost);
> +	} else if (num_events) {
> +		reg = event.access & 0x07;
> +		sym = event.access & 0x08 ? out_regs[reg] : in_regs[reg];

Some uarts have registers beyond 0x07 so this doesn't seem enough.
It would be nice if the driver could provide alternative set of names for 
the registers.

> +		dir = event.access & 0x08 ? "<-" : "->";
> +		format_cycle((((uint64_t)event.cycle_hi << 32) |
> event.cycle_lo),
> +			elapsed, sizeof(elapsed));
> +		snprintf(buf, size, "%s  %s %s %02X\n", elapsed, sym, dir,
> event.data);
> +	} else if (size) {
> +		buf[0] = '\0';
> +	}
> +}
> +
> +/*
> + *  This is the hook we install for register reads when tracing is enabled.
> It calls
> + *  the original serial_in function and logs the read to the register event
> queue.
> + */
> +static unsigned int serial_in_wrapper(struct uart_port *port, int offset)
> +{
> +	struct uart_debug *uart_debug = port->private_data;
> +	uint8_t value;
> +
> +	value = uart_debug->original_serial_in(port, offset);
> +	queue_add(port, offset, value, false);
> +	return value;
> +}
> +
> +/*
> + *  This is the hook we install for register writes when tracing is enabled.
> It calls
> + *  the original serial_out function and logs the write to the register event
> queue.
> + */
> +static void serial_out_wrapper(struct uart_port *port, int offset, int value)
> +{
> +	struct uart_debug *uart_debug = port->private_data;
> +
> +	uart_debug->original_serial_out(port, offset, value);
> +	queue_add(port, offset, value, true);
> +}
> +
> +/*
> + *  Handle reads from the 'trace_size' pseudo-file.  Report the configured
> trace size.
> + *  If it changes between (partial) reads then the output will likely be
> corrupted.  The
> + *  only way to fix this is to store the text buffer in the file private
> data.  Users
> + *  should be encouraged to provide a buffer large enough to read the entire
> value at once.
> + */
> +static ssize_t size_read(struct file *filp, char __user *buf, size_t size,
> loff_t *ppos)
> +{
> +	struct uart_port *port = filp->private_data;
> +	struct uart_debug *uart_debug = port->private_data;
> +	char text[16];
> +	uint32_t len;
> +
> +	len = snprintf(text, sizeof(text), "%u\n", uart_debug->trace_size);
> +	return simple_read_from_buffer(buf, size, ppos, text, len);
> +}
> +
> +/*
> + *  Handle writes to the 'trace_size' pseudo-file.  Set the configured trace
> size (maximum
> + *  number of log entries).
> + */
> +static ssize_t size_write(struct file *filp, const char __user *buf, size_t
> size, loff_t *ppos)
> +{
> +	struct uart_port *port = filp->private_data;
> +	struct uart_debug *uart_debug = port->private_data;
> +	uint32_t trace_size, rounded_size = 1;
> +	int error;
> +
> +	error = kstrtouint_from_user(buf, size, 0, &trace_size);
> +	if (error)
> +		return error;
> +
> +	if (trace_size == 0)
> +		return -EINVAL;
> +	while (trace_size >>= 1)
> +		rounded_size <<= 1;  /* round down to nearest power of 2 */

Comment is certainly misplaces as it's the whole while loop which 
calculates that.

> +	uart_debug->trace_size = rounded_size;
> +	return size;
> +}
> +
> +/*
> + *  Create the debugfs interface.  This should be called during port
> registration after
> + *  port->name, port->serial_in, and port->serial_out have been initialized.
> We are
> + *  using port->private_data to store a pointer to our data structure.  That
> field appears
> + *  to be otherwise unused.  If this is wrong we will need to create a new
> field.
> + */
> +void uart_debug_create(struct uart_port *port)
> +{
> +	struct uart_debug *uart_debug;
> +	struct dentry *dir;
> +
> +	uart_debug = port->private_data = kzalloc(sizeof(struct uart_debug),
> GFP_KERNEL);

How about the drivers which use port->private_data?

It would make this look cleaner if you split the double assignment.

> +	if (uart_debug == NULL)
> +		return;
> +
> +	spin_lock_init(&uart_debug->lock);
> +	mutex_init(&uart_debug->mutex);
> +	uart_debug->trace_size = 4096;

SZ_4K

> +
> +	dir = debugfs_create_dir(port->name, NULL);  /* ie. "ttyS0" */
> +	debugfs_create_file("trace_all",    0644, dir, port, &all_fops);
> +	debugfs_create_file("trace_buffer", 0444, dir, port, &buffer_fops);
> +	debugfs_create_file("trace_enable", 0644, dir, port, &enable_fops);
> +	debugfs_create_file("trace_size",   0644, dir, port, &size_fops);
> +}
> +
> +/*
> + *  Destroy the debugfs interface.  This should be called during port
> deregistration.
> + */
> +void uart_debug_destroy(struct uart_port *port)
> +{
> +	struct uart_debug *uart_debug;
> +
> +	uart_debug = port->private_data;
> +	port->private_data = NULL;
> +
> +	if (uart_debug) {
> +		debugfs_lookup_and_remove(port->name, NULL);  /* ie. "ttyS0 */
> +		queue_free(port, true);
> +		kfree(uart_debug);
> +	}
> +}


-- 
 i.
--8323329-1373145534-1692776700=:1805--
