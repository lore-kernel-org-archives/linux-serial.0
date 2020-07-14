Return-Path: <SRS0=SZDA=AZ=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B124CC433E3
	for <linux-serial@archiver.kernel.org>; Tue, 14 Jul 2020 07:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84B912220F
	for <linux-serial@archiver.kernel.org>; Tue, 14 Jul 2020 07:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594710710;
	bh=8OJ3wAK6ioWTrV8isgRhbidmbF9JYbmjmphtK8fKUaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gs8aaWQCV2tCkfpk6CFalKwNPUO1b3vn3TDR1qe28JrjpF+sQ51L2MotbJmbvZrEb
	 dqMixPcdqmDmjWBfMQgnWFSiu/fTo5xQEngt0VBParRzlVbp65f+dCJIkUCDCigGRT
	 4F5sZxy9ojM4K5pf5bF7f9UVdjz2Gj6U8DgmH5n8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725931AbgGNHLu (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 14 Jul 2020 03:11:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:55074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725905AbgGNHLt (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 14 Jul 2020 03:11:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAD0C2076D;
        Tue, 14 Jul 2020 07:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594710709;
        bh=8OJ3wAK6ioWTrV8isgRhbidmbF9JYbmjmphtK8fKUaQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FCXcQB48GxvdmPKVXYNJrNXLMfbV4aBqTVcHyD9dNCBxM5Gi+AtDQo5Vq39SslITC
         nH+baRmyq9chWcdmSu08m9/G2HgG2v6hbMrDHqUkyzBF0mnZHYb1ogxgO6Bc1iSKqt
         uYCB8JyxVdi5hVULFgD9pQGe5Jry6KA46dcOwawM=
Date:   Tue, 14 Jul 2020 09:11:42 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johnson CH Chen =?utf-8?B?KOmZs+aYreWLsyk=?= 
        <JohnsonCH.Chen@moxa.com>
Cc:     Jiri Slaby <jirislaby@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: [PATCH] tty: Add MOXA NPort Real TTY Driver
Message-ID: <20200714071142.GB680233@kroah.com>
References: <HK2PR01MB328134FB2EF5F9D1E381BDA3FA610@HK2PR01MB3281.apcprd01.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <HK2PR01MB328134FB2EF5F9D1E381BDA3FA610@HK2PR01MB3281.apcprd01.prod.exchangelabs.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jul 14, 2020 at 06:24:42AM +0000, Johnson CH Chen (陳昭勳) wrote:
> This driver supports tty functions for all of MOXA's NPort series
> with v5.0. Using this driver, host part can use tty to connect NPort
> device server by ethernet.

A new serial driver, nice!

> 
> The following Moxa products are supported:
> * CN2600 Series
> * CN2500 Series
> * NPort DE Series
> * NPort 5000A-M12 Series
> * NPort 5100 Series
> * NPort 5200 Series
> * NPort 5400 Series
> * NPort 5600 Desktop Series
> * NPort 5600 Rackmount Series
> * NPort Wireless Series
> * NPort IA5000 Series
> * NPort 6000 Series
> * NPort S8000 Series
> * NPort S8455I Series
> * NPort S9000 Series
> * NE-4100 Series
> * MiiNePort Series
> 
> Signed-off-by: Johnson Chen <johnsonch.chen@moxa.com>
> Signed-off-by: Jason Chen <jason.chen@moxa.com>
> Signed-off-by: Danny Lin <danny.lin@moxa.com>
> Signed-off-by: Victor Yu <victor.yu@moxa.com>
> ---
>  drivers/tty/Kconfig   |   11 +
>  drivers/tty/Makefile  |    1 +
>  drivers/tty/npreal2.c | 3042 +++++++++++++++++++++++++++++++++++++++++
>  drivers/tty/npreal2.h |  140 ++
>  4 files changed, 3194 insertions(+)
>  create mode 100644 drivers/tty/npreal2.c
>  create mode 100644 drivers/tty/npreal2.h
> 
> diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
> index 93fd984eb2f5..79b545269b71 100644
> --- a/drivers/tty/Kconfig
> +++ b/drivers/tty/Kconfig
> @@ -259,6 +259,17 @@ config MOXA_SMARTIO
>  	  This driver can also be built as a module. The module will be called
>  	  mxser. If you want to do that, say M here.
>  
> +config MOXA_NPORT_REAL_TTY
> +	tristate "Moxa NPort Real TTY support v5.0"
> +	help
> +	  Say Y here if you have a Moxa NPort serial device server.
> +
> +	  The purpose of this driver is to map NPort serial port to host tty
> +	  port. Using this driver, you can use NPort serial port as local tty port.
> +
> +	  This driver can also be built as a module. The module will be called
> +	  npreal2 by setting M.
> +
>  config SYNCLINK
>  	tristate "Microgate SyncLink card support"
>  	depends on SERIAL_NONSTANDARD && PCI && ISA_DMA_API
> diff --git a/drivers/tty/Makefile b/drivers/tty/Makefile
> index 020b1cd9294f..6d07985d6962 100644
> --- a/drivers/tty/Makefile
> +++ b/drivers/tty/Makefile
> @@ -24,6 +24,7 @@ obj-$(CONFIG_CYCLADES)		+= cyclades.o
>  obj-$(CONFIG_ISI)		+= isicom.o
>  obj-$(CONFIG_MOXA_INTELLIO)	+= moxa.o
>  obj-$(CONFIG_MOXA_SMARTIO)	+= mxser.o
> +obj-$(CONFIG_MOXA_NPORT_REAL_TTY) += npreal2.o
>  obj-$(CONFIG_NOZOMI)		+= nozomi.o
>  obj-$(CONFIG_NULL_TTY)	        += ttynull.o
>  obj-$(CONFIG_ROCKETPORT)	+= rocket.o
> diff --git a/drivers/tty/npreal2.c b/drivers/tty/npreal2.c
> new file mode 100644
> index 000000000000..65c773420755
> --- /dev/null
> +++ b/drivers/tty/npreal2.c
> @@ -0,0 +1,3042 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * npreal2.c  -- MOXA NPort Server family Real TTY driver.
> + *
> + * Copyright (c) 1999-2020  Moxa Technologies (support@moxa.com)
> + *
> + * Supports the following Moxa Product:
> + * CN2600 Series
> + * CN2500 Series
> + * NPort DE Series
> + * NPort 5000A-M12 Series
> + * NPort 5100 Series
> + * NPort 5200 Series
> + * NPort 5400 Series
> + * NPort 5600 Desktop Series
> + * NPort 5600 Rackmount Series
> + * NPort Wireless Series
> + * NPort IA5000 Series
> + * NPort 6000 Series
> + * NPort S8000 Series
> + * NPort S8455I Series
> + * NPort S9000 Series
> + * NE-4100 Series
> + * MiiNePort Series
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/errno.h>
> +#include <linux/fcntl.h>
> +#include <linux/version.h>
> +#include <linux/init.h>
> +#include <linux/ioport.h>
> +#include <linux/interrupt.h>
> +#include <linux/major.h>
> +#include <linux/mm.h>
> +#include <linux/module.h>
> +#include <linux/ptrace.h>
> +#include <linux/poll.h>
> +#include <linux/proc_fs.h>
> +#include <linux/uaccess.h>
> +#include <linux/serial.h>
> +#include <linux/serial_reg.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +#include <linux/signal.h>
> +#include <linux/sched.h>
> +#include <linux/tty.h>
> +#include <linux/tty_flip.h>
> +#include <linux/timer.h>
> +#include "npreal2.h"
> +
> +static int ttymajor = NPREALMAJOR;
> +static int verbose = 1;

Please do not do that, just use the normal dynamic debug logic that the
kernel has and that everyone uses.  No per-driver type of debugging
functionality, as obviously that does not scale at all.

> +
> +MODULE_AUTHOR("<support@moxa.com>");

We need a real author name here if you want to be the maintainer.
Otherwise a support address can't be an author :)

> +MODULE_DESCRIPTION("MOXA Async/NPort Server Family Real TTY Driver");
> +module_param(ttymajor, int, 0);
> +module_param(verbose, int, 0644);

No module parameters please, they should not be needed at all.

> +MODULE_VERSION(NPREAL_VERSION);

No need for a driver version once the code is in the kernel tree, as the
kernel version is what matters.

> +MODULE_LICENSE("GPL");
> +
> +struct server_setting_struct {
> +	int32_t server_type;
> +	int32_t disable_fifo;

Please use kernel types, like u32, instead of userspace types like
these.

> +};
> +
> +struct npreal_struct {
> +	struct tty_port ttyPort;
> +	struct work_struct tqueue;
> +	struct work_struct process_flip_tqueue;

None of these should be pointers?

> +	struct ktermios normal_termios;
> +	struct ktermios callout_termios;
> +	/* kernel counters for the 4 input interrupts */
> +	struct async_icount icount;
> +	struct semaphore rx_semaphore;
> +	struct nd_struct *net_node;
> +	struct tty_struct *tty;
> +	struct pid *session;
> +	struct pid *pgrp;
> +	wait_queue_head_t open_wait;
> +	wait_queue_head_t close_wait;
> +	wait_queue_head_t delta_msr_wait;
> +	unsigned long baud_base;
> +	unsigned long event;
> +	unsigned short closing_wait;
> +	int port;
> +	int flags;
> +	int type;  /* UART type */

enumerated type?

> +	int xmit_fifo_size;
> +	int custom_divisor;
> +	int x_char; /* xon/xoff character */
> +	int close_delay;
> +	int modem_control; /* Modem control register */
> +	int modem_status;  /* Line status */
> +	int count; /* # of fd on device */
> +	int xmit_head;
> +	int xmit_tail;

Do you really need these?  Why not just use a ringbuffer structure from
the kernel?

> +	int xmit_cnt;
> +	unsigned char *xmit_buf;
> +
> +	/*
> +	 * We use spin_lock_irqsave instead of semaphonre here.
> +	 * Reason: When we use pppd to dialout via Real TTY driver,
> +	 * some driver functions, such as npreal_write(), would be
> +	 * invoked under interrpute mode which causes warning in
> +	 * down/up tx_semaphore.
> +	 */
> +	spinlock_t tx_lock;
> +};
> +
> +struct nd_struct {
> +	struct semaphore cmd_semaphore;
> +	struct proc_dir_entry *node_entry;
> +	struct npreal_struct *tty_node;
> +	struct semaphore semaphore;

2 locks in the same structure???

> +	wait_queue_head_t initialize_wait;
> +	wait_queue_head_t select_in_wait;
> +	wait_queue_head_t select_out_wait;
> +	wait_queue_head_t select_ex_wait;
> +	wait_queue_head_t cmd_rsp_wait;

That's a lot of different queues a specific thing can be on at the same
time.  Are you sure you want that to happen?

> +	int32_t server_type;

Enumerated type?

> +	int do_session_recovery_len;
> +	int cmd_rsp_flag;
> +	int tx_ready;
> +	int rx_ready;
> +	int cmd_ready;
> +	int wait_oqueue_responsed;
> +	int oqueue;
> +	int rsp_length;
> +	unsigned long flag;
> +	unsigned char cmd_buffer[84];
> +	unsigned char rsp_buffer[84];
> +};
> +
> +static const struct proc_ops npreal_net_fops;

Serial port drivers should never create /proc files.  If you want
debugging stuff, use debugfs.

> +static int npreal_set_used_command_done(struct nd_struct *nd, char *rsp_buf, int *rsp_len)
> +{
> +	nd->cmd_buffer[0] = 0;
> +	npreal_wait_and_set_command(nd, NPREAL_LOCAL_COMMAND_SET, LOCAL_CMD_TTY_USED);
> +	nd->cmd_buffer[2] = 0;
> +	nd->cmd_ready = 1;
> +	smp_mb(); /* use smp_mb() with waitqueue_active() */

Huh?   Why is that needed?

> +	/* used waitqueue_active() is safe because smp_mb() is used */

Why?

Are you _sure_ you need that barrier?  If so, please document it really
really really well for you to be able to understand it in 10 years when
people have questions about it :)

> +static int npreal_chars_in_buffer(struct tty_struct *tty)
> +{
> +	struct npreal_struct *info = (struct npreal_struct *)tty->driver_data;
> +
> +	if (!info)
> +		return -EIO;

How can that ever happen?

> +
> +	return info->xmit_cnt;
> +}


> +/**

No need for kernel doc format for static functions.

> + * npreal_get_lsr_info() - get line status register info
> + *
> + * Let user call ioctl() to get info when the UART physically is emptied.
> + * On bus types like RS485, the transmitter must release the bus after
> + * transmitting. This must be done when the transmit shift register is
> + * empty, not be done when the transmit holding register is empty.
> + * This functionality allows an RS485 driver to be written in user space.
> + *
> + * Always return 0 when function is ended.
> + */
> +static int npreal_get_lsr_info(struct npreal_struct *info,
> +				unsigned int *value)
> +{
> +	unsigned int result = 0;
> +
> +	if (npreal_wait_oqueue(info, 0) == 0)
> +		result = TIOCSER_TEMT;
> +
> +	put_user(result, value);

Did you run sparse on this code?  Please do so and fix up the
errors/warnings it gives you for stuff like this.

> +static int npreal_net_open(struct inode *inode, struct file *file)
> +{
> +	struct nd_struct *nd;
> +	int rtn = 0;
> +
> +	try_module_get(THIS_MODULE);

That is racy and not needed and even wrong here.

Do not do this, it is not the way to correctly do it at all.

> +	if (!capable(CAP_SYS_ADMIN)) {
> +		rtn = -EPERM;
> +		goto done;
> +	}
> +
> +	if (file->private_data) {

How could that ever happen?

> +		rtn = -EINVAL;
> +		goto done;
> +	}
> +
> +	nd = (struct nd_struct *)PDE_DATA(inode);
> +	if (!nd) {
> +		rtn = -ENXIO;
> +		goto done;
> +	}
> +
> +	down(&nd->semaphore);
> +
> +	if (nd->flag & NPREAL_NET_NODE_OPENED) {
> +		rtn = -EBUSY;
> +		goto unlock;
> +	}
> +
> +	nd->flag |= NPREAL_NET_NODE_OPENED;
> +	nd->tx_ready = 0;
> +	nd->rx_ready = 1;
> +	nd->cmd_ready = 0;
> +	tty_register_device(npvar_sdriver, nd->tty_node->port, NULL);
> +
> +unlock:
> +	up(&nd->semaphore);
> +	file->private_data = (void *)nd;
> +done:
> +	if (rtn)
> +		module_put(THIS_MODULE);
> +
> +	return rtn;
> +}
> +
> +static int npreal_net_close(struct inode *inode, struct file *file)
> +{
> +	struct nd_struct *nd;
> +
> +	nd = (struct nd_struct *)(file->private_data);

No need to cast.

> +	if (!nd)
> +		goto done;
> +
> +	/* This flag will be checked when npreal_net_open() is called again. */
> +	nd->flag &= ~NPREAL_NET_NODE_OPENED;

No locking?

> +	tty_unregister_device(npvar_sdriver, nd->tty_node->port);
> +
> +done:
> +	file->private_data = NULL;
> +	module_put(THIS_MODULE);

again, not needed.

> +	return 0;
> +}
> +
> +static unsigned int npreal_net_select(struct file *file, struct poll_table_struct *table)
> +{
> +	struct nd_struct *nd = file->private_data;
> +	unsigned int retval = 0;
> +
> +	if (!nd)
> +		return retval;
> +
> +	poll_wait(file, &nd->select_in_wait, table);
> +	poll_wait(file, &nd->select_out_wait, table);
> +	poll_wait(file, &nd->select_ex_wait, table);
> +
> +	if (nd->tx_ready)
> +		retval |= POLLIN | POLLRDNORM;
> +	if (nd->rx_ready)
> +		retval |= POLLOUT | POLLWRNORM;
> +	if (nd->cmd_ready)
> +		retval |= POLLPRI;
> +
> +	return retval;
> +}
> +
> +static long npreal_net_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> +{
> +	struct nd_struct *nd = file->private_data;
> +	int ret = 0;
> +	int size, len;
> +
> +	if (!nd) {
> +		ret = -ENXIO;
> +		return ret;
> +	}
> +
> +	size = _IOC_SIZE(cmd);
> +
> +	switch (_IOC_NR(cmd)) {
> +	case NPREAL_NET_CMD_RETRIEVE:

Do not make up custom ioctls for a single serial driver, just use the
default ones, that should be all that is needed, correct?

If not, what do you need to do that the serial layer does not provide
for you?

> +static int __init npreal2_module_init(void)
> +{
> +	int i, retval;
> +
> +	npvar_sdriver = alloc_tty_driver(NPREAL_PORTS);
> +	if (!npvar_sdriver)
> +		return -ENOMEM;
> +
> +	npvar_sdriver->name = "ttyr";
> +	npvar_sdriver->major = ttymajor;
> +	npvar_sdriver->minor_start = 0;
> +	npvar_sdriver->type = TTY_DRIVER_TYPE_SERIAL;
> +	npvar_sdriver->subtype = SERIAL_TYPE_NORMAL;
> +	npvar_sdriver->init_termios = tty_std_termios;
> +	npvar_sdriver->init_termios.c_cflag = B9600 | CS8 | CREAD | HUPCL | CLOCAL;
> +	npvar_sdriver->flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV;
> +
> +	npvar_table = kmalloc_array(NPREAL_PORTS, sizeof(struct npreal_struct), GFP_KERNEL);
> +	if (npvar_table == NULL)
> +		return -1;
> +
> +	npvar_net_nodes = kmalloc_array(NPREAL_PORTS, sizeof(struct nd_struct), GFP_KERNEL);
> +	if (npvar_net_nodes == NULL) {
> +		kfree(npvar_table);
> +		return -1;
> +	}
> +
> +	tty_set_operations(npvar_sdriver, &mpvar_ops);
> +	memset(npvar_table, 0, NPREAL_PORTS * sizeof(struct npreal_struct));
> +
> +	for (i = 0; i < NPREAL_PORTS; i++) {
> +		tty_port_init(&npvar_table[i].ttyPort);
> +		tty_port_link_device(&npvar_table[i].ttyPort, npvar_sdriver, i);
> +	}
> +
> +	retval = tty_register_driver(npvar_sdriver);
> +	if (retval) {
> +		pr_err("Couldn't install MOXA Async/NPort server family driver !\n");
> +		put_tty_driver(npvar_sdriver);
> +		return -1;
> +	}
> +
> +	retval = npreal_init(npvar_table, npvar_net_nodes);
> +	if (retval) {
> +		tty_unregister_driver(npvar_sdriver);
> +		pr_err("Couldn't install MOXA Async/NPort server family Real TTY driver !\n");
> +		return -1;
> +	}
> +
> +	pr_info("MOXA Nport driver version %s\n", NPREAL_VERSION);

No need to be noisy if all works properly, a driver should be silent.

But why are you doing all of this initialization without actually
checking if your hardware is present in the system?  Please use the
bus-specific logic that your hardware is on to properly set things up in
the probe function, not all in the module init function, as this will
probably cause failures if loaded on a system without the hardware,
right?

And what causes the module to properly load automatically?  I missed
that logic somewhere in here, where is it?

> --- /dev/null
> +++ b/drivers/tty/npreal2.h

No need for a .h file for a single .c file.

thanks,

greg k-h
