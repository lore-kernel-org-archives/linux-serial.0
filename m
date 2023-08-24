Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20EFC7113B
	for <linux-serial@archiver.kernel.org>; Thu, 24 Aug 2023 20:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243621AbjHXU7Q convert rfc822-to-8bit (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 24 Aug 2023 16:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243684AbjHXU7J (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 24 Aug 2023 16:59:09 -0400
Received: from zproxy1.foxvalley.net (zimbra.foxvalley.net [212.78.26.134])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 2C2A41BD9
        for <linux-serial@vger.kernel.org>; Thu, 24 Aug 2023 13:59:05 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy1.foxvalley.net (Postfix) with ESMTP id A5BBC40F30;
        Thu, 24 Aug 2023 15:59:04 -0500 (CDT)
Received: from zproxy1.foxvalley.net ([127.0.0.1])
 by localhost (zproxy1.foxvalley.net [127.0.0.1]) (amavis, port 10032)
 with ESMTP id spTiSvxBI6IC; Thu, 24 Aug 2023 15:59:03 -0500 (CDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy1.foxvalley.net (Postfix) with ESMTP id 067AA40F4C;
        Thu, 24 Aug 2023 15:59:03 -0500 (CDT)
X-Virus-Scanned: amavis at zproxy1.foxvalley.net
Received: from zproxy1.foxvalley.net ([127.0.0.1])
 by localhost (zproxy1.foxvalley.net [127.0.0.1]) (amavis, port 10026)
 with ESMTP id t6jLhB-7NbcA; Thu, 24 Aug 2023 15:59:02 -0500 (CDT)
Received: from [192.168.1.3] (unknown [161.97.241.227])
        by zproxy1.foxvalley.net (Postfix) with ESMTPSA id BB6F740F30;
        Thu, 24 Aug 2023 15:59:02 -0500 (CDT)
Message-ID: <eb8a598c-414e-aecf-e903-e2c01db1979a@foxvalley.net>
Date:   Thu, 24 Aug 2023 14:59:01 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        ilpo.jarvinen@linux.intel.com
From:   Dan Raymond <draymond@foxvalley.net>
Subject: [PATCH v3] tty/serial: create debugfs interface for UART register
 tracing
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Implement a UART register tracing facility using the debugfs.  This can be
used as a "serial port sniffer" to monitor UART traffic and line settings
with timestamps at microsecond granularity.  This can be useful for general
serial port debugging or to debug the UART driver itself.

Signed-off-by: Dan Raymond <draymond@foxvalley.net>
---
V1 -> V2:
  - add Kconfig option to disable SERIAL_8250_DEBUG feature
  - limit comments to 80 columns
  - add defaults to documentation for debugfs files
  - convert documentation to kernel-doc and link to Documentation/trace/index.rst
  - switch user types (uint32_t) to kernel types (u32)
  - reorganize reg_queue structure to prevent memory holes
  - embed spinlock inside structure it protects
  - reduce size of line[] buffer to avoid wasted memory
  - use min_t() macro to select minimum of two integers
  - simplify return statement from buffer_read()
  - move comment for "round down to nearest power of 2"
  - split double assignment of pointers into two lines
  - use SZ_4K instead of 4096

V2 -> V3:
  - change formatting of timestamp from "hh:mm:ss.mmmuuu" to "ssssssss.mmmuuu"
  - create a new field in 'struct uart_port' instead of using 'private_data'

 Documentation/trace/index.rst        |   1 +
 Documentation/trace/serial.rst       |   5 +
 drivers/tty/serial/8250/8250.h       |   8 +
 drivers/tty/serial/8250/8250_core.c  |   2 +
 drivers/tty/serial/8250/8250_debug.c | 530 +++++++++++++++++++++++++++
 drivers/tty/serial/8250/Kconfig      |   9 +
 drivers/tty/serial/8250/Makefile     |   1 +
 include/linux/serial_core.h          |   1 +
 8 files changed, 557 insertions(+)
 create mode 100644 Documentation/trace/serial.rst
 create mode 100644 drivers/tty/serial/8250/8250_debug.c

diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
index 2d73e8697523..2f85814204f0 100644
--- a/Documentation/trace/index.rst
+++ b/Documentation/trace/index.rst
@@ -33,3 +33,4 @@ Linux Tracing Technologies
    coresight/index
    user_events
    rv/index
+   serial
diff --git a/Documentation/trace/serial.rst b/Documentation/trace/serial.rst
new file mode 100644
index 000000000000..c40c2a727f20
--- /dev/null
+++ b/Documentation/trace/serial.rst
@@ -0,0 +1,5 @@
+UART Tracing
+------------
+
+.. kernel-doc:: drivers/tty/serial/8250/8250_debug.c
+   :doc: UART register tracing
diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 287153d32536..a0a224414d92 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -403,3 +403,11 @@ static inline int serial_index(struct uart_port *port)
 {
 	return port->minor - 64;
 }
+
+#ifdef CONFIG_SERIAL_8250_DEBUG
+extern void uart_debug_create(struct uart_port *port);
+extern void uart_debug_destroy(struct uart_port *port);
+#else
+static inline void uart_debug_create(struct uart_port *port) { }
+static inline void uart_debug_destroy(struct uart_port *port) { }
+#endif
diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 94fbf0add2ce..1f7f8005e3ee 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -1094,6 +1094,7 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
 			if (ret)
 				goto err;
 
+			uart_debug_create(&uart->port);
 			ret = uart->port.line;
 		} else {
 			dev_info(uart->port.dev,
@@ -1151,6 +1152,7 @@ void serial8250_unregister_port(int line)
 		spin_unlock_irqrestore(&uart->port.lock, flags);
 	}
 
+	uart_debug_destroy(&uart->port);
 	uart_remove_one_port(&serial8250_reg, &uart->port);
 	if (serial8250_isa_devs) {
 		uart->port.flags &= ~UPF_BOOT_AUTOCONF;
diff --git a/drivers/tty/serial/8250/8250_debug.c b/drivers/tty/serial/8250/8250_debug.c
new file mode 100644
index 000000000000..2404b2e30ac9
--- /dev/null
+++ b/drivers/tty/serial/8250/8250_debug.c
@@ -0,0 +1,530 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  This module provides debugging features for the 8250/16550 UART driver.
+ */
+
+/**
+ * DOC: UART register tracing
+ *
+ * The low level serial I/O routines can be hooked to generate timestamped
+ * traces of UART register reads and writes.  This feature can be used as a
+ * "serial port sniffer" to monitor UART traffic and line settings.  Each
+ * serial port ("ttyS0", "ttyS1", etc.) will have its own directory in the
+ * root of the debug filesystem.  Inside each directory will be the following
+ * pseudo-files::
+ *
+ *   trace_all<1>     - 0 = trace RX/TX registers, 1 = trace all registers
+ *   trace_buffer     - consumes the trace data
+ *   trace_enable<0>  - 0 = disable tracing, 1 = enable tracing
+ *   trace_size<4096> - configures the size of the trace buffer
+ *
+ * When tracing is disabled there will be zero impact to the operation of the
+ * UART driver.  When tracing is enabled a small cost will be incurred after
+ * every register access to write an entry to the trace buffer in RAM.  The
+ * buffer size is limited only by the amount of virtual memory available to the
+ * kernel.  This is 128 MiB by default but it can be increased using
+ * vmalloc=xxx on the kernel command line.  The memory will be freed after
+ * tracing is disabled and all data in the buffer has been consumed.
+ *
+ * Example session::
+ *
+ *   > mount -t debugfs debugfs /sys/kernel/debug
+ *   > echo 1 > /sys/kernel/debug/ttyS1/trace_enable
+ *
+ *   (perform UART operation)
+ *
+ *   > cat /sys/kernel/debug/ttyS1/trace_buffer
+ *
+ *        131.819407  IER <- 07
+ *        131.819419  IIR -> C2
+ *        131.819420  LSR -> 60
+ *        131.819422  MSR -> 00
+ *        131.819424  THR <- C9
+ *        131.819428  IER <- 05
+ *        131.819430  IIR -> C1
+ *        131.875916  IIR -> CC
+ *        131.875918  LSR -> 61
+ *        131.875920  RBR -> C9
+ *        131.875922  LSR -> 61
+ *        131.875924  RBR -> EC
+ *        131.875925  LSR -> 61
+ *        131.875926  RBR -> 00
+ *        131.875928  LSR -> 60
+ *        131.875938  MSR -> 00
+ *        131.875939  IIR -> C1
+ */
+
+#include <linux/cpufreq.h>
+#include <linux/debugfs.h>
+#include <linux/fs.h>
+#include <linux/math64.h>
+#include <linux/serial_8250.h>
+
+struct reg_event {
+	u32  cycle_lo;  /* CPU cycle count (lower 32-bits) */
+	u16  cycle_hi;  /* CPU cycle count (upper 16-bits) */
+	u8   access;    /* write flag + register number */
+	u8   data;      /* register data */
+};
+
+struct reg_queue {
+	spinlock_t        lock;       /* protects this structure */
+	struct reg_event *buf;        /* array to hold the data */
+	u32               size;       /* array size (number of entries - must be power of 2) */
+	u32               read_idx;   /* first full (written) slot */
+	u32               write_idx;  /* first empty (unwritten) slot */
+	bool              wrap;       /* true if write_idx wrapped around and reached read_idx */
+};
+
+struct uart_debug {
+	struct mutex      mutex;     /* protects this structure */
+	bool              trace_enable;
+	bool              trace_all;
+	u32               trace_size;
+	unsigned int      (*original_serial_in)(struct uart_port *p, int offset);
+	void              (*original_serial_out)(struct uart_port *p, int offset, int value);
+	struct reg_queue  register_queue;
+	char              line[28];  /* buffer to hold text of last item removed from queue */
+	u32               offset;    /* offset of first unread byte in line */
+};
+
+static ssize_t      all_read(struct file *filp, char __user *buf, size_t size, loff_t *ppos);
+static ssize_t      all_write(struct file *filp,
+			const char __user *buf, size_t size, loff_t *ppos);
+static ssize_t      buffer_read(struct file *filp, char __user *buf, size_t size, loff_t *ppos);
+static ssize_t      enable_read(struct file *filp, char __user *buf, size_t size, loff_t *ppos);
+static ssize_t      enable_write(struct file *filp,
+			const char __user *buf, size_t size, loff_t *ppos);
+static void         format_cycle(uint64_t cpu_cycles, char *buf, u32 size);
+static void         queue_add(struct uart_port *port, u8 reg, u8 data, bool write);
+static bool         queue_alloc(struct uart_port *port);
+static void         queue_free(struct uart_port *port, bool force);
+static void         queue_remove(struct uart_port *port, char *buf, u32 size);
+static unsigned int serial_in_wrapper(struct uart_port *port, int offset);
+static void         serial_out_wrapper(struct uart_port *port, int offset, int value);
+static ssize_t      size_read(struct file *filp, char __user *buf, size_t size, loff_t *ppos);
+static ssize_t      size_write(struct file *filp,
+			const char __user *buf, size_t size, loff_t *ppos);
+
+static const struct file_operations all_fops = {
+	.open  = simple_open,
+	.read  = all_read,
+	.write = all_write,
+};
+
+static const struct file_operations buffer_fops = {
+	.open = simple_open,
+	.read = buffer_read,
+};
+
+static const struct file_operations enable_fops = {
+	.open  = simple_open,
+	.read  = enable_read,
+	.write = enable_write,
+};
+
+static const struct file_operations size_fops = {
+	.open  = simple_open,
+	.read  = size_read,
+	.write = size_write,
+};
+
+/*
+ *  Handle reads from the 'trace_all' pseudo-file.  Report the state of the
+ *  trace_all flag.
+ */
+static ssize_t all_read(struct file *filp, char __user *buf, size_t size, loff_t *ppos)
+{
+	struct uart_port *port = filp->private_data;
+	struct uart_debug *uart_debug = port->debug_data;
+	char text[16];
+	u32 len;
+
+	len = snprintf(text, sizeof(text), "%u\n", uart_debug->trace_all);
+	return simple_read_from_buffer(buf, size, ppos, text, len);
+}
+
+/*
+ *  Handle writes to the 'trace_all' pseudo-file.  Set the state of the
+ *  trace_all flag.
+ */
+static ssize_t all_write(struct file *filp, const char __user *buf, size_t size, loff_t *ppos)
+{
+	struct uart_port *port = filp->private_data;
+	struct uart_debug *uart_debug = port->debug_data;
+	int error;
+
+	error = kstrtobool_from_user(buf, size, &uart_debug->trace_all);
+	if (error)
+		return error;
+
+	return size;
+}
+
+/*
+ *  Handle reads from the 'trace_buffer' pseudo-file.  This function consumes
+ *  content in the register event queue.  A best effort will be made to avoid
+ *  splitting lines of text.
+ */
+static ssize_t buffer_read(struct file *filp, char __user *buf, size_t size, loff_t *ppos)
+{
+	struct uart_port *port = filp->private_data;
+	struct uart_debug *uart_debug = port->debug_data;
+	u32 len, num_bytes, total_bytes = 0;
+	const char *ptr;
+	int error = 0;
+
+	if (mutex_lock_interruptible(&uart_debug->mutex))
+		return -ERESTARTSYS;
+
+	while (size) {
+		if (uart_debug->line[uart_debug->offset] == '\0') {
+			uart_debug->offset = 0;
+			queue_remove(port, uart_debug->line, sizeof(uart_debug->line));
+			if (uart_debug->line[0] == '\0')
+				break;
+		}
+
+		ptr = uart_debug->line + uart_debug->offset;
+		len = strlen(ptr);
+		num_bytes = min_t(size_t, size, len);
+
+		if (num_bytes < len && total_bytes)
+			break;
+		if (copy_to_user(buf, ptr, num_bytes)) {
+			error = -EFAULT;
+			break;
+		}
+
+		buf += num_bytes;
+		size -= num_bytes;
+		total_bytes += num_bytes;
+		uart_debug->offset += num_bytes;
+	}
+
+	if (!uart_debug->trace_enable)
+		queue_free(port, false);
+
+	mutex_unlock(&uart_debug->mutex);
+	return total_bytes ? total_bytes : error;  /* suppress error if any data was copied */
+}
+
+/*
+ *  Handle reads from the 'trace_enable' pseudo-file.  Report the current state
+ *  of the trace_enable flag.
+ */
+static ssize_t enable_read(struct file *filp, char __user *buf, size_t size, loff_t *ppos)
+{
+	struct uart_port *port = filp->private_data;
+	struct uart_debug *uart_debug = port->debug_data;
+	char text[16];
+	u32 len;
+
+	len = snprintf(text, sizeof(text), "%u\n", uart_debug->trace_enable);
+	return simple_read_from_buffer(buf, size, ppos, text, len);
+}
+
+/*
+ *  Handle writes to the 'trace_enable' pseudo-file.  When tracing is enabled
+ *  allocate memory for the register event queue and install our hooks.  When
+ *  tracing is disabled remove our hooks and free the memory used by the
+ *  register event queue if it is empty.
+ */
+static ssize_t enable_write(struct file *filp, const char __user *buf, size_t size, loff_t *ppos)
+{
+	struct uart_port *port = filp->private_data;
+	struct uart_debug *uart_debug = port->debug_data;
+	bool trace_enable;
+	int error;
+
+	error = kstrtobool_from_user(buf, size, &trace_enable);
+	if (error)
+		return error;
+
+	if (mutex_lock_interruptible(&uart_debug->mutex))
+		return -ERESTARTSYS;
+	if (trace_enable == uart_debug->trace_enable)
+		goto exit;
+
+	if (trace_enable) {
+		uart_debug->line[0] = '\0';
+		uart_debug->offset = 0;
+		queue_free(port, true);
+		if (!queue_alloc(port))
+			goto exit;
+
+		uart_debug->original_serial_out = port->serial_out;
+		uart_debug->original_serial_in  = port->serial_in;
+		port->serial_out = serial_out_wrapper;
+		port->serial_in  = serial_in_wrapper;
+	} else {
+		port->serial_out = uart_debug->original_serial_out;
+		port->serial_in  = uart_debug->original_serial_in;
+
+		queue_free(port, false);
+	}
+
+	uart_debug->trace_enable = trace_enable;
+exit:
+	mutex_unlock(&uart_debug->mutex);
+	return size;
+}
+
+/*
+ *  Convert 'cpu_cycles' to a string that reports the time elapsed since boot in
+ *  seconds/microseconds.
+ */
+static void format_cycle(uint64_t cpu_cycles, char *buf, u32 size)
+{
+	static uint64_t cpu_freq;  /* cycles per second */
+	u32 s, us;
+
+	if (cpu_freq == 0)
+		cpu_freq = arch_freq_get_on_cpu(0) * 1000ULL;
+
+	s = div64_u64_rem(cpu_cycles, cpu_freq, &cpu_cycles);
+	us = div64_u64(cpu_cycles * 1000 * 1000 + 500 * 1000, cpu_freq);
+
+	snprintf(buf, size, "%8u.%06u", s, us);
+}
+
+/*
+ *  Add an entry to the register event queue.  This can run in interrupt context
+ *  so it needs to be as fast as possible.
+ */
+static void queue_add(struct uart_port *port, u8 reg, u8 data, bool write)
+{
+	struct uart_debug *uart_debug = port->debug_data;
+	struct reg_queue *queue = &uart_debug->register_queue;
+	uint64_t cpu_cycle;
+	struct reg_event event;
+	unsigned long flags;
+
+	if (!uart_debug->trace_all && reg != 0x00)
+		return;
+
+	cpu_cycle      = rdtsc();
+	event.cycle_lo = (u32)cpu_cycle;
+	event.cycle_hi = (u16)(cpu_cycle >> 32);
+	event.access   = (write ? 0x08 : 0x00) | reg;
+	event.data     = data;
+
+	spin_lock_irqsave(&queue->lock, flags);
+
+	queue->buf[queue->write_idx & (queue->size - 1)] = event;
+	queue->write_idx++;
+
+	if (queue->write_idx == queue->read_idx)
+		queue->wrap = true;
+
+	spin_unlock_irqrestore(&queue->lock, flags);
+}
+
+/*
+ *  Allocate memory for the register event queue.  We use vmalloc() instead of
+ *  kmalloc() because we don't need physically contiguous memory and kmalloc()
+ *  is limited to 4 MiB.  If memory allocation fails we will try again with a
+ *  smaller buffer.  The user can detect this by reading 'trace_size' after
+ *  enabling tracing.
+ */
+static bool queue_alloc(struct uart_port *port)
+{
+	struct uart_debug *uart_debug = port->debug_data;
+	struct reg_queue *queue = &uart_debug->register_queue;
+
+	queue->size = uart_debug->trace_size;
+	queue->buf = vmalloc(queue->size * sizeof(struct reg_event));
+
+	while (queue->buf == NULL) {
+		queue->size >>= 1;
+		if (queue->size == 0)
+			return false;
+		queue->buf = vmalloc(queue->size * sizeof(struct reg_event));
+	}
+
+	uart_debug->trace_size = queue->size;
+	return true;
+}
+
+/*
+ *  Free the memory used by the register event queue if the queue is empty.  If
+ *  the 'force' flag is 'true' free the memory even if the queue is not empty.
+ *
+ *  The noinline attribute suppresses a bug in gcc 11.3.0 that generates a bogus
+ *  error:
+ *
+ *  error: ‘__builtin_memset’ offset [0, 19] is out of the bounds [0, 0] [-Werror=array-bounds]
+ */
+static noinline void queue_free(struct uart_port *port, bool force)
+{
+	struct uart_debug *uart_debug = port->debug_data;
+	struct reg_queue *queue = &uart_debug->register_queue;
+
+	if (force || queue->read_idx == queue->write_idx) {
+		vfree(queue->buf);
+		memset(queue, 0, sizeof(*queue));
+	}
+}
+
+/*
+ *  Remove an entry from the register event queue.  The entry will be converted
+ *  to a text string and written to the caller's buffer.  If no entries are
+ *  available an empty string will be written.
+ */
+static void queue_remove(struct uart_port *port, char *buf, u32 size)
+{
+	struct uart_debug *uart_debug = port->debug_data;
+	struct reg_queue *queue = &uart_debug->register_queue;
+	struct reg_event event;
+	const char * const in_regs[]  = { "RBR", "IER", "IIR", "LCR", "MCR", "LSR", "MSR", "SCR" };
+	const char * const out_regs[] = { "THR", "IER", "FCR", "LCR", "MCR", "LSR", "MSR", "SCR" };
+	u8 reg;
+	const char *sym, *dir;
+	char elapsed[sizeof("ssssssss.mmmuuu")];
+	u32 num_events, events_lost;
+	unsigned long flags;
+
+	spin_lock_irqsave(&queue->lock, flags);
+
+	num_events = queue->write_idx - queue->read_idx;
+	events_lost = num_events > queue->size ? num_events - queue->size : 0;
+	events_lost = queue->wrap ? 0xFFFFFFFF : events_lost;
+
+	if (events_lost) {
+		queue->read_idx += num_events - queue->size;
+		queue->wrap = false;
+	} else if (num_events) {
+		event = queue->buf[queue->read_idx & (queue->size - 1)];
+		queue->read_idx++;
+	}
+
+	spin_unlock_irqrestore(&queue->lock, flags);
+
+	if (events_lost) {
+		snprintf(buf, size, "queue overflow (%u events lost)\n", events_lost);
+	} else if (num_events) {
+		reg = event.access & 0x07;
+		sym = event.access & 0x08 ? out_regs[reg] : in_regs[reg];
+		dir = event.access & 0x08 ? "<-" : "->";
+		format_cycle((((uint64_t)event.cycle_hi << 32) | event.cycle_lo),
+			elapsed, sizeof(elapsed));
+		snprintf(buf, size, "%s  %s %s %02X\n", elapsed, sym, dir, event.data);
+	} else if (size) {
+		buf[0] = '\0';
+	}
+}
+
+/*
+ *  This is the hook we install for register reads when tracing is enabled.
+ *  It calls the original serial_in function and logs the read to the register
+ *  event queue.
+ */
+static unsigned int serial_in_wrapper(struct uart_port *port, int offset)
+{
+	struct uart_debug *uart_debug = port->debug_data;
+	u8 value;
+
+	value = uart_debug->original_serial_in(port, offset);
+	queue_add(port, offset, value, false);
+	return value;
+}
+
+/*
+ *  This is the hook we install for register writes when tracing is enabled.
+ *  It calls the original serial_out function and logs the write to the register
+ *  event queue.
+ */
+static void serial_out_wrapper(struct uart_port *port, int offset, int value)
+{
+	struct uart_debug *uart_debug = port->debug_data;
+
+	uart_debug->original_serial_out(port, offset, value);
+	queue_add(port, offset, value, true);
+}
+
+/*
+ *  Handle reads from the 'trace_size' pseudo-file.  Report the configured trace
+ *  size.  If it changes between (partial) reads then the output will likely be
+ *  corrupted.  The only way to fix this is to store the text buffer in the file
+ *  private data.  Users should be encouraged to provide a buffer large enough
+ *  to read the entire value at once.
+ */
+static ssize_t size_read(struct file *filp, char __user *buf, size_t size, loff_t *ppos)
+{
+	struct uart_port *port = filp->private_data;
+	struct uart_debug *uart_debug = port->debug_data;
+	char text[16];
+	u32 len;
+
+	len = snprintf(text, sizeof(text), "%u\n", uart_debug->trace_size);
+	return simple_read_from_buffer(buf, size, ppos, text, len);
+}
+
+/*
+ *  Handle writes to the 'trace_size' pseudo-file.  Set the configured trace
+ *  size (maximum number of log entries).
+ */
+static ssize_t size_write(struct file *filp, const char __user *buf, size_t size, loff_t *ppos)
+{
+	struct uart_port *port = filp->private_data;
+	struct uart_debug *uart_debug = port->debug_data;
+	u32 trace_size, rounded_size = 1;
+	int error;
+
+	error = kstrtouint_from_user(buf, size, 0, &trace_size);
+	if (error)
+		return error;
+
+	if (trace_size == 0)
+		return -EINVAL;
+	while (trace_size >>= 1)  /* round down to nearest power of 2 */
+		rounded_size <<= 1;
+	uart_debug->trace_size = rounded_size;
+	return size;
+}
+
+/*
+ *  Create the debugfs interface.  This should be called during port
+ *  registration after port->name, port->serial_in, and port->serial_out have
+ *  been initialized.  We are using port->debug_data to store a pointer to our
+ *  data structure.
+ */
+void uart_debug_create(struct uart_port *port)
+{
+	struct uart_debug *uart_debug;
+	struct dentry *dir;
+
+	port->debug_data = kzalloc(sizeof(struct uart_debug), GFP_KERNEL);
+	uart_debug = port->debug_data;
+	if (uart_debug == NULL)
+		return;
+
+	spin_lock_init(&uart_debug->register_queue.lock);
+	mutex_init(&uart_debug->mutex);
+	uart_debug->trace_all = true;
+	uart_debug->trace_size = SZ_4K;
+
+	dir = debugfs_create_dir(port->name, NULL);  /* ie. "ttyS0" */
+	debugfs_create_file("trace_all",    0644, dir, port, &all_fops);
+	debugfs_create_file("trace_buffer", 0444, dir, port, &buffer_fops);
+	debugfs_create_file("trace_enable", 0644, dir, port, &enable_fops);
+	debugfs_create_file("trace_size",   0644, dir, port, &size_fops);
+}
+
+/*
+ *  Destroy the debugfs interface.  This should be called during port
+ *  deregistration.
+ */
+void uart_debug_destroy(struct uart_port *port)
+{
+	struct uart_debug *uart_debug;
+
+	uart_debug = port->debug_data;
+	port->debug_data = NULL;
+
+	if (uart_debug) {
+		debugfs_lookup_and_remove(port->name, NULL);  /* ie. "ttyS0 */
+		queue_free(port, true);
+		kfree(uart_debug);
+	}
+}
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 7b3ffb7f50ab..9b7cf09500f7 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -34,6 +34,15 @@ config SERIAL_8250
 	  Most people will say Y or M here, so that they can use serial mice,
 	  modems and similar devices connecting to the standard serial ports.
 
+config SERIAL_8250_DEBUG
+	bool "Debugging features for 8250/16550 serial ports"
+	depends on SERIAL_8250
+	default SERIAL_8250
+	help
+	  This builds debugging support that can be used with 8250/16550
+	  compatible UART controllers.  Currently this includes tracing of
+	  UART register I/O.
+
 config SERIAL_8250_DEPRECATED_OPTIONS
 	bool "Support 8250_core.* kernel options (DEPRECATED)"
 	depends on SERIAL_8250
diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
index bee908f99ea0..d0dc1c26d99c 100644
--- a/drivers/tty/serial/8250/Makefile
+++ b/drivers/tty/serial/8250/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_SERIAL_8250)		+= 8250.o 8250_base.o
 8250-$(CONFIG_ALPHA_JENSEN)		+= 8250_alpha.o
 8250-$(CONFIG_SERIAL_8250_PNP)		+= 8250_pnp.o
 8250_base-y				:= 8250_port.o
+8250_base-$(CONFIG_SERIAL_8250_DEBUG)	+= 8250_debug.o
 8250_base-$(CONFIG_SERIAL_8250_DMA)	+= 8250_dma.o
 8250_base-$(CONFIG_SERIAL_8250_DWLIB)	+= 8250_dwlib.o
 8250_base-$(CONFIG_SERIAL_8250_FINTEK)	+= 8250_fintek.o
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index beb2ffd31fea..d44dfaf4c20c 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -581,6 +581,7 @@ struct uart_port {
 	struct gpio_desc	*rs485_term_gpio;	/* enable RS485 bus termination */
 	struct serial_iso7816   iso7816;
 	void			*private_data;		/* generic platform data pointer */
+	void			*debug_data;		/* used for debug purposes only */
 };
 
 static inline int serial_port_in(struct uart_port *up, int offset)

base-commit: be8b93b5cc7d533eb8c9b0590cdac055ecafe13a
-- 
2.25.1
