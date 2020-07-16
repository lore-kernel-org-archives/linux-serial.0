Return-Path: <SRS0=PhEQ=A3=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3138BC433E2
	for <linux-serial@archiver.kernel.org>; Thu, 16 Jul 2020 07:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 053EA206F5
	for <linux-serial@archiver.kernel.org>; Thu, 16 Jul 2020 07:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594884195;
	bh=+0N0OTs7zVfZ35MGgY+T+NR3IzrxTZFXr2prbhBHbzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=D1TDZSG7tkxBk6maIIZI8t/oAqXI8VNVIYrjeNM8sQbGCj3YKEtcromhRRI1En472
	 qIVz0fqB2l332Ib8SibnpcyRhgEJw/rG/oGwwOmdfRDW7GL5kKI2+J4j8Bx31hWJGa
	 ry0HBPzPQn1imS2njmVxgRA3KLkaA1eyBts3ul+0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgGPHXO (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 16 Jul 2020 03:23:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:51906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbgGPHXO (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 16 Jul 2020 03:23:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 690442067D;
        Thu, 16 Jul 2020 07:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594884193;
        bh=+0N0OTs7zVfZ35MGgY+T+NR3IzrxTZFXr2prbhBHbzg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l4nKUl/5lJae9QZbcA0D4/XE27GXf0WG1HaZCm5ajWMBl4nbwGmhZu67x8iDDdq45
         xxzocNrMcz+l+W+7PTZyNteJ0beDLQ/1TtCZMfELhkYmjqjRMiYi6gM2Ak7fWm6Von
         mSXZAubEq31mXtObwrkl7LTbUFNd2QnYDcdx4+Dk=
Date:   Thu, 16 Jul 2020 09:23:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johnson CH Chen =?utf-8?B?KOmZs+aYreWLsyk=?= 
        <JohnsonCH.Chen@moxa.com>
Cc:     Jiri Slaby <jirislaby@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: [PATCH] tty: Add MOXA NPort Real TTY Driver
Message-ID: <20200716072305.GA970724@kroah.com>
References: <HK2PR01MB328134FB2EF5F9D1E381BDA3FA610@HK2PR01MB3281.apcprd01.prod.exchangelabs.com>
 <20200714073609.GA688099@kroah.com>
 <HK2PR01MB32815CE2F455B909EA32F406FA7F0@HK2PR01MB3281.apcprd01.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <HK2PR01MB32815CE2F455B909EA32F406FA7F0@HK2PR01MB3281.apcprd01.prod.exchangelabs.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jul 16, 2020 at 07:19:02AM +0000, Johnson CH Chen (陳昭勳) wrote:
> Hi Greg,
> 
> Thanks for detailed and good suggestions!
> 
> > From: linux-serial-owner@vger.kernel.org
> > <linux-serial-owner@vger.kernel.org> On Behalf Of Greg Kroah-Hartman
> > Sent: Tuesday, July 14, 2020 3:36 PM
> > To: Johnson CH Chen (陳昭勳) <JohnsonCH.Chen@moxa.com>
> > Cc: Jiri Slaby <jirislaby@gmail.com>; linux-kernel@vger.kernel.org;
> > linux-serial@vger.kernel.org
> > Subject: Re: [PATCH] tty: Add MOXA NPort Real TTY Driver
> > 
> > On Tue, Jul 14, 2020 at 06:24:42AM +0000, Johnson CH Chen (陳昭勳) wrote:
> > > This driver supports tty functions for all of MOXA's NPort series with
> > > v5.0. Using this driver, host part can use tty to connect NPort device
> > > server by ethernet.
> > >
> > > The following Moxa products are supported:
> > > * CN2600 Series
> > > * CN2500 Series
> > > * NPort DE Series
> > > * NPort 5000A-M12 Series
> > > * NPort 5100 Series
> > > * NPort 5200 Series
> > > * NPort 5400 Series
> > > * NPort 5600 Desktop Series
> > > * NPort 5600 Rackmount Series
> > > * NPort Wireless Series
> > > * NPort IA5000 Series
> > > * NPort 6000 Series
> > > * NPort S8000 Series
> > > * NPort S8455I Series
> > > * NPort S9000 Series
> > > * NE-4100 Series
> > > * MiiNePort Series
> > >
> > > Signed-off-by: Johnson Chen <johnsonch.chen@moxa.com>
> > > Signed-off-by: Jason Chen <jason.chen@moxa.com>
> > > Signed-off-by: Danny Lin <danny.lin@moxa.com>
> > > Signed-off-by: Victor Yu <victor.yu@moxa.com>
> > > ---
> > >  drivers/tty/Kconfig   |   11 +
> > >  drivers/tty/Makefile  |    1 +
> > >  drivers/tty/npreal2.c | 3042
> > > +++++++++++++++++++++++++++++++++++++++++
> > >  drivers/tty/npreal2.h |  140 ++
> > >  4 files changed, 3194 insertions(+)
> > >  create mode 100644 drivers/tty/npreal2.c  create mode 100644
> > > drivers/tty/npreal2.h
> > >
> > > diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig index
> > > 93fd984eb2f5..79b545269b71 100644
> > > --- a/drivers/tty/Kconfig
> > > +++ b/drivers/tty/Kconfig
> > > @@ -259,6 +259,17 @@ config MOXA_SMARTIO
> > >  	  This driver can also be built as a module. The module will be called
> > >  	  mxser. If you want to do that, say M here.
> > >
> > > +config MOXA_NPORT_REAL_TTY
> > > +	tristate "Moxa NPort Real TTY support v5.0"
> > > +	help
> > > +	  Say Y here if you have a Moxa NPort serial device server.
> > > +
> > > +	  The purpose of this driver is to map NPort serial port to host tty
> > > +	  port. Using this driver, you can use NPort serial port as local tty port.
> > > +
> > > +	  This driver can also be built as a module. The module will be called
> > > +	  npreal2 by setting M.
> > > +
> > >  config SYNCLINK
> > >  	tristate "Microgate SyncLink card support"
> > >  	depends on SERIAL_NONSTANDARD && PCI && ISA_DMA_API diff --git
> > > a/drivers/tty/Makefile b/drivers/tty/Makefile index
> > > 020b1cd9294f..6d07985d6962 100644
> > > --- a/drivers/tty/Makefile
> > > +++ b/drivers/tty/Makefile
> > > @@ -24,6 +24,7 @@ obj-$(CONFIG_CYCLADES)		+= cyclades.o
> > >  obj-$(CONFIG_ISI)		+= isicom.o
> > >  obj-$(CONFIG_MOXA_INTELLIO)	+= moxa.o
> > >  obj-$(CONFIG_MOXA_SMARTIO)	+= mxser.o
> > > +obj-$(CONFIG_MOXA_NPORT_REAL_TTY) += npreal2.o
> > >  obj-$(CONFIG_NOZOMI)		+= nozomi.o
> > >  obj-$(CONFIG_NULL_TTY)	        += ttynull.o
> > >  obj-$(CONFIG_ROCKETPORT)	+= rocket.o
> > > diff --git a/drivers/tty/npreal2.c b/drivers/tty/npreal2.c new file
> > > mode 100644 index 000000000000..65c773420755
> > > --- /dev/null
> > > +++ b/drivers/tty/npreal2.c
> > > @@ -0,0 +1,3042 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > > +/*
> > > + * npreal2.c  -- MOXA NPort Server family Real TTY driver.
> > > + *
> > > + * Copyright (c) 1999-2020  Moxa Technologies (support@moxa.com)
> > > + *
> > > + * Supports the following Moxa Product:
> > > + * CN2600 Series
> > > + * CN2500 Series
> > > + * NPort DE Series
> > > + * NPort 5000A-M12 Series
> > > + * NPort 5100 Series
> > > + * NPort 5200 Series
> > > + * NPort 5400 Series
> > > + * NPort 5600 Desktop Series
> > > + * NPort 5600 Rackmount Series
> > > + * NPort Wireless Series
> > > + * NPort IA5000 Series
> > > + * NPort 6000 Series
> > > + * NPort S8000 Series
> > > + * NPort S8455I Series
> > > + * NPort S9000 Series
> > > + * NE-4100 Series
> > > + * MiiNePort Series
> > > + */
> > > +
> > > +#include <linux/delay.h>
> > > +#include <linux/errno.h>
> > > +#include <linux/fcntl.h>
> > > +#include <linux/version.h>
> > > +#include <linux/init.h>
> > > +#include <linux/ioport.h>
> > > +#include <linux/interrupt.h>
> > > +#include <linux/major.h>
> > > +#include <linux/mm.h>
> > > +#include <linux/module.h>
> > > +#include <linux/ptrace.h>
> > > +#include <linux/poll.h>
> > > +#include <linux/proc_fs.h>
> > > +#include <linux/uaccess.h>
> > > +#include <linux/serial.h>
> > > +#include <linux/serial_reg.h>
> > > +#include <linux/slab.h>
> > > +#include <linux/string.h>
> > > +#include <linux/signal.h>
> > > +#include <linux/sched.h>
> > > +#include <linux/tty.h>
> > > +#include <linux/tty_flip.h>
> > > +#include <linux/timer.h>
> > > +#include "npreal2.h"
> > > +
> > > +static int ttymajor = NPREALMAJOR;
> > > +static int verbose = 1;
> > > +
> > > +MODULE_AUTHOR("<support@moxa.com>");
> > > +MODULE_DESCRIPTION("MOXA Async/NPort Server Family Real TTY
> > Driver");
> > > +module_param(ttymajor, int, 0); module_param(verbose, int, 0644);
> > > +MODULE_VERSION(NPREAL_VERSION); MODULE_LICENSE("GPL");
> > > +
> > > +struct server_setting_struct {
> > > +	int32_t server_type;
> > > +	int32_t disable_fifo;
> > > +};
> > > +
> > > +struct npreal_struct {
> > > +	struct tty_port ttyPort;
> > > +	struct work_struct tqueue;
> > > +	struct work_struct process_flip_tqueue;
> > > +	struct ktermios normal_termios;
> > > +	struct ktermios callout_termios;
> > > +	/* kernel counters for the 4 input interrupts */
> > > +	struct async_icount icount;
> > > +	struct semaphore rx_semaphore;
> > > +	struct nd_struct *net_node;
> > > +	struct tty_struct *tty;
> > > +	struct pid *session;
> > > +	struct pid *pgrp;
> > > +	wait_queue_head_t open_wait;
> > > +	wait_queue_head_t close_wait;
> > > +	wait_queue_head_t delta_msr_wait;
> > > +	unsigned long baud_base;
> > > +	unsigned long event;
> > > +	unsigned short closing_wait;
> > > +	int port;
> > > +	int flags;
> > > +	int type;  /* UART type */
> > > +	int xmit_fifo_size;
> > > +	int custom_divisor;
> > > +	int x_char; /* xon/xoff character */
> > > +	int close_delay;
> > > +	int modem_control; /* Modem control register */
> > > +	int modem_status;  /* Line status */
> > > +	int count; /* # of fd on device */
> > > +	int xmit_head;
> > > +	int xmit_tail;
> > > +	int xmit_cnt;
> > > +	unsigned char *xmit_buf;
> > > +
> > > +	/*
> > > +	 * We use spin_lock_irqsave instead of semaphonre here.
> > > +	 * Reason: When we use pppd to dialout via Real TTY driver,
> > > +	 * some driver functions, such as npreal_write(), would be
> > > +	 * invoked under interrpute mode which causes warning in
> > > +	 * down/up tx_semaphore.
> > > +	 */
> > > +	spinlock_t tx_lock;
> > > +};
> > > +
> > > +struct nd_struct {
> > > +	struct semaphore cmd_semaphore;
> > > +	struct proc_dir_entry *node_entry;
> > > +	struct npreal_struct *tty_node;
> > > +	struct semaphore semaphore;
> > > +	wait_queue_head_t initialize_wait;
> > > +	wait_queue_head_t select_in_wait;
> > > +	wait_queue_head_t select_out_wait;
> > > +	wait_queue_head_t select_ex_wait;
> > > +	wait_queue_head_t cmd_rsp_wait;
> > > +	int32_t server_type;
> > > +	int do_session_recovery_len;
> > > +	int cmd_rsp_flag;
> > > +	int tx_ready;
> > > +	int rx_ready;
> > > +	int cmd_ready;
> > > +	int wait_oqueue_responsed;
> > > +	int oqueue;
> > > +	int rsp_length;
> > > +	unsigned long flag;
> > > +	unsigned char cmd_buffer[84];
> > > +	unsigned char rsp_buffer[84];
> > 
> > You seem to have two "static" buffers here, for your device, that you
> > semi-randomly write to all over the place, but I can't find any locking or
> > coordination between things that prevents multiple commands from not just
> > overwritting each other.
> > 
> For cmd_buffer[], we use npreal_wait_and_set_command() to make sure
> cmd_buffer[] is safe to be written by checking "cmd_buffer[0] == 0".

And what locks are protecting you there?

> For rsp_buffer[], we use npreal_wait_command_completed() to make sure
> rsp_buffer[] is desired by checking rsp_buffer[0] and rsp_buffer[1].
> Command_set and command should be checked. Besides, rsp_buffer[] is
> got from user space by "NPREAL_NET_CMD_RESPONSE" in
> npreal_net_ioctl().

Again, what locking is really handling this?

> > Also, how does the data get sent to the hardware at all?  I see cmd_buffer[]
> > being written to, but what reads from it and how does the hardware get the
> > data?
> 
> Actually we need to both NPort driver (this driver) and Npreal daemon
> (userspace) to let HW work. Npreal daemon can communicate with HW by
> socket, and Npreal deamon communicates with Nport driver by
> "npreal_net_fops". When commands are ready for driver part, it will
> wake up poll event to let Nport daemon know.

That is not obvious at all, and needs to be really really really
documented here.  Why not put the userspace chunk in the tree too?  At
the least, you need to point at it.

And why is a userspace part needed?  We have tty-over-ethernet drivers
that do not require such a thing in the tree somewhere...

thanks,

greg k-h
