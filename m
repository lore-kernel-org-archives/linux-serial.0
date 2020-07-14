Return-Path: <SRS0=SZDA=AZ=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E892C433EA
	for <linux-serial@archiver.kernel.org>; Tue, 14 Jul 2020 09:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 534BF208C3
	for <linux-serial@archiver.kernel.org>; Tue, 14 Jul 2020 09:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAjhs67V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgGNJeM (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 14 Jul 2020 05:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbgGNJeK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 14 Jul 2020 05:34:10 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72DEC061755;
        Tue, 14 Jul 2020 02:34:09 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id h28so16400608edz.0;
        Tue, 14 Jul 2020 02:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ktmvM3rXBiBca0otGZiEmnYGcST4bKkpYKeKascTclQ=;
        b=FAjhs67V1k377IU4/OG8O6XupN0tahHXJoyO9evixMFIJ3CntyvTDBKGGyQAZDsuAE
         Ej09+8u3c8bj1/JJ+jdd9mkuQyLy6pm97oSrVg2IjVsCVHtldQBNzdRob/SXUK2TXXyy
         bNTOIHLgETrhQoNA9EahLtmVoSAlj6T48b6R3byul1hIDOm9S73GzGW3wi2CZw7WAL7g
         CUa9UZ1KiDDdg6NvKh4bNWloE0LmW/0kl0j/rUS4PwwG/30ZYyW+fmQ1glo9nTIDctm2
         tWDiGLl8+uLWksEvu/NoEZo2ylVoHWsLV9qcl5B2HoMylrUrNh3p9ls3lXdgV5rFPaEX
         FelQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ktmvM3rXBiBca0otGZiEmnYGcST4bKkpYKeKascTclQ=;
        b=UUCercgeupEWSsXftlMG5zYULvwHGBC1dPHjYjEBeF0v1ADLpYNOdKRPXAseISVTT+
         h8JYK+7pPsAcOXogNQ664z3kZ8AZtcqfQfQaEQRdZd06EP7hK26Axq3swMMl79RqNnZM
         BSOveaZerCxX/NkBMVcQpUt6peJQ6CnwWMDt34YkJeIS+d9W8Vn3gXiV6JNNdXLE0sj6
         HwvYw+POwYXmPo2nON0ryRyh67GWYjF7KsRHDc4pFHndnx7mMTKWQ1nvI4LvOOMkqRls
         7bFr6yRxYZU8xtqeois4nxrR1RI1vbapoe8577QEso6Wcomw7M586vJeZdvlu3DqNKEd
         E7Kw==
X-Gm-Message-State: AOAM531BO8UnzSsv1Qq4RivEoUT4denE4iY1VwRGhOMF39kaNT5DWDxM
        LY3KXHOK3UZvu6Tp0dSLMod+1F4e
X-Google-Smtp-Source: ABdhPJymJSGPRMo8FMh2GsXi1kGnLN+gG9R7XPc3OMDvaHc5bUStMK8Y2v5dg+nXCycDQmX0aeL+rw==
X-Received: by 2002:a50:ab52:: with SMTP id t18mr3648180edc.195.1594719247561;
        Tue, 14 Jul 2020 02:34:07 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id r6sm10060176ejd.55.2020.07.14.02.34.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 02:34:06 -0700 (PDT)
Subject: Re: [PATCH] tty: Add MOXA NPort Real TTY Driver
To:     =?UTF-8?B?Sm9obnNvbiBDSCBDaGVuICjpmbPmmK3li7Mp?= 
        <JohnsonCH.Chen@moxa.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
References: <HK2PR01MB328134FB2EF5F9D1E381BDA3FA610@HK2PR01MB3281.apcprd01.prod.exchangelabs.com>
From:   Jiri Slaby <jirislaby@gmail.com>
Autocrypt: addr=jirislaby@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <7b190f5c-c2f4-032a-af89-444a1f7d9a80@gmail.com>
Date:   Tue, 14 Jul 2020 11:34:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <HK2PR01MB328134FB2EF5F9D1E381BDA3FA610@HK2PR01MB3281.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=big5
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 14. 07. 20, 8:24, Johnson CH Chen (³¯¬L¾±) wrote:
> This driver supports tty functions for all of MOXA's NPort series
> with v5.0. Using this driver, host part can use tty to connect NPort
> device server by ethernet.
...
> Signed-off-by: Johnson Chen <johnsonch.chen@moxa.com>
> Signed-off-by: Jason Chen <jason.chen@moxa.com>
> Signed-off-by: Danny Lin <danny.lin@moxa.com>
> Signed-off-by: Victor Yu <victor.yu@moxa.com>
> ---
...
> --- a/drivers/tty/Kconfig
> +++ b/drivers/tty/Kconfig
> @@ -259,6 +259,17 @@ config MOXA_SMARTIO
>  	  This driver can also be built as a module. The module will be called
>  	  mxser. If you want to do that, say M here.
>  
> +config MOXA_NPORT_REAL_TTY
> +	tristate "Moxa NPort Real TTY support v5.0"

MOXA_SMARTIO is lexicographically after MOXA_NPORT_REAL_TTY. So move
this before MOXA_SMARTIO.

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

The same.

>  obj-$(CONFIG_NOZOMI)		+= nozomi.o
>  obj-$(CONFIG_NULL_TTY)	        += ttynull.o
>  obj-$(CONFIG_ROCKETPORT)	+= rocket.o
> diff --git a/drivers/tty/npreal2.c b/drivers/tty/npreal2.c
> new file mode 100644
> index 000000000000..65c773420755
> --- /dev/null
> +++ b/drivers/tty/npreal2.c
> @@ -0,0 +1,3042 @@
...
> +#include <linux/delay.h>
> +#include <linux/errno.h>
> +#include <linux/fcntl.h>
> +#include <linux/version.h>

What do you need version.h for? Are you sure, you need all these headers?

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

You want dynamic major anyway. So kill this all.

> +static int verbose = 1;
> +
> +MODULE_AUTHOR("<support@moxa.com>");
> +MODULE_DESCRIPTION("MOXA Async/NPort Server Family Real TTY Driver");
> +module_param(ttymajor, int, 0);
> +module_param(verbose, int, 0644);
> +MODULE_VERSION(NPREAL_VERSION);
> +MODULE_LICENSE("GPL");
> +
> +struct server_setting_struct {
> +	int32_t server_type;
> +	int32_t disable_fifo;
> +};
> +
> +struct npreal_struct {
> +	struct tty_port ttyPort;
> +	struct work_struct tqueue;
> +	struct work_struct process_flip_tqueue;
> +	struct ktermios normal_termios;
> +	struct ktermios callout_termios;

callout in 2020?

> +	/* kernel counters for the 4 input interrupts */
> +	struct async_icount icount;
> +	struct semaphore rx_semaphore;

semaphores in new code? You have to explain why are you not using
simpler and faset mutexes.

> +	struct nd_struct *net_node;
> +	struct tty_struct *tty;
> +	struct pid *session;
> +	struct pid *pgrp;

Why does a driver need to care about pgrp? And session? You should kill
all these set, but unused fields. Note that you should also use fields
from struct tty_port instead of the duplicates here.

> +	wait_queue_head_t open_wait;
> +	wait_queue_head_t close_wait;
> +	wait_queue_head_t delta_msr_wait;
> +	unsigned long baud_base;
> +	unsigned long event;
> +	unsigned short closing_wait;
> +	int port;
> +	int flags;
> +	int type;  /* UART type */
> +	int xmit_fifo_size;
> +	int custom_divisor;
> +	int x_char; /* xon/xoff character */
> +	int close_delay;
> +	int modem_control; /* Modem control register */
> +	int modem_status;  /* Line status */
> +	int count; /* # of fd on device */
> +	int xmit_head;
> +	int xmit_tail;
> +	int xmit_cnt;
> +	unsigned char *xmit_buf;

ringbuf (as Greg suggests) or kfifo.

> +	/*
> +	 * We use spin_lock_irqsave instead of semaphonre here.

"semaphonre"?

> +	 * Reason: When we use pppd to dialout via Real TTY driver,
> +	 * some driver functions, such as npreal_write(), would be
> +	 * invoked under interrpute mode which causes warning in

"interrpute"?

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
> +	wait_queue_head_t initialize_wait;
> +	wait_queue_head_t select_in_wait;
> +	wait_queue_head_t select_out_wait;
> +	wait_queue_head_t select_ex_wait;
> +	wait_queue_head_t cmd_rsp_wait;
> +	int32_t server_type;
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
> +static const struct tty_operations mpvar_ops;
> +static struct proc_dir_entry *npvar_proc_root;
> +static struct tty_driver *npvar_sdriver;
> +static struct npreal_struct *npvar_table;
> +static struct nd_struct *npvar_net_nodes;

Could you reorder the code, so that you don't need these forward
declarations?

> +static void npreal_do_softint(struct work_struct *work)
> +{

Well, this is the old way of doing things.

> +	struct npreal_struct *info = container_of(work, struct npreal_struct, tqueue);
> +	struct tty_struct *tty;
> +
> +	if (!info)
> +		return;
> +
> +	tty = info->tty;
> +	if (tty) {
> +		if (test_and_clear_bit(NPREAL_EVENT_TXLOW, &info->event)) {

Do you ever set that flag?

> +			if ((tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) &&
> +				tty->ldisc->ops->write_wakeup)
> +				(tty->ldisc->ops->write_wakeup)(tty);
> +			wake_up_interruptible(&tty->write_wait);
> +		}
> +
> +		if (test_and_clear_bit(NPREAL_EVENT_HANGUP, &info->event)) {
> +			/* Do it when entering npreal_hangup() */
> +			tty_hangup(tty);

Have you checked what tty_hangup actually does? Drop this whole function.

> +		}
> +	}
> +}
> +
> +/**
> + * npreal_flush_to_ldisc() - Read data from tty device to line discipline
> + * @tty: pointer for struct tty_struct
> + * @filp: pointer for struct file
> + *
> + * This routine is called out of the software interrupt to flush data
> + * from the flip buffer to the line discipline.
> + *
> + */
> +
> +static void npreal_flush_to_ldisc(struct work_struct *work)
> +{

Ugh, the same as above, drop this and call flip directly.

> +	struct npreal_struct *info = container_of(work, struct npreal_struct, process_flip_tqueue);
> +	struct tty_struct *tty;
> +	struct tty_port *port;
> +
> +	if (info == NULL)
> +		return;
> +
> +	tty = info->tty;
> +	if (tty == NULL)
> +		return;
> +
> +	port = tty->port;
> +	tty_flip_buffer_push(port);
> +}
> +
> +static inline void npreal_check_modem_status(struct npreal_struct *info, int status)
> +{
> +	int is_dcd_changed = 0;
> +
> +	if ((info->modem_status & UART_MSR_DSR) != (status & UART_MSR_DSR))
> +		info->icount.dsr++;
> +	if ((info->modem_status & UART_MSR_DCD) != (status & UART_MSR_DCD)) {
> +		info->icount.dcd++;
> +		is_dcd_changed = 1;
> +	}
> +
> +	if ((info->modem_status & UART_MSR_CTS) != (status & UART_MSR_CTS))
> +		info->icount.cts++;
> +
> +	info->modem_status = status;
> +	wake_up_interruptible(&info->delta_msr_wait);
> +
> +	if ((info->flags & ASYNC_CHECK_CD) && (is_dcd_changed)) {
> +		if (status & UART_MSR_DCD) {
> +			wake_up_interruptible(&info->open_wait);
> +		} else {
> +			set_bit(NPREAL_EVENT_HANGUP, &info->event);
> +			schedule_work(&info->tqueue);
> +		}
> +	}
> +}
> +
> +static int npreal_wait_and_set_command(struct nd_struct *nd, char command_set, char command)
> +{
> +	unsigned long et;
> +
> +	if ((command_set != NPREAL_LOCAL_COMMAND_SET) &&
> +		((nd->flag & NPREAL_NET_DO_SESSION_RECOVERY) ||
> +		(nd->flag & NPREAL_NET_NODE_DISCONNECTED))) {
> +
> +		if (nd->flag & NPREAL_NET_DO_SESSION_RECOVERY)
> +			return -EAGAIN;
> +
> +		return -EIO;
> +	}
> +
> +	down(&nd->cmd_semaphore);
> +	nd->cmd_rsp_flag = 0;
> +	up(&nd->cmd_semaphore);
> +
> +	et = jiffies + NPREAL_CMD_TIMEOUT;
> +	while (1) {
> +		down(&nd->cmd_semaphore);
> +		if (!(nd->cmd_buffer[0] == 0 || ((jiffies - et >= 0) ||
> +			signal_pending(current)))) {
> +			up(&nd->cmd_semaphore);
> +			current->state = TASK_INTERRUPTIBLE;
> +			schedule_timeout(1);

This is very bad.

This calls for wait_event_interruptible or alike.  "jiffies - et >= 0"
is broken in any case. time_after() is your friend.

> +		} else {
> +			nd->cmd_buffer[0] = command_set;
> +			nd->cmd_buffer[1] = command;
> +			up(&nd->cmd_semaphore);
> +			return 0;
> +		}
> +	}
> +}
> +
> +static int npreal_wait_command_completed(struct nd_struct *nd, char command_set, char command,
> +						long timeout, char *rsp_buf, int *rsp_len)
> +{
> +	long st = 0, tmp = 0;
> +
> +	if ((command_set != NPREAL_LOCAL_COMMAND_SET) &&
> +		((nd->flag & NPREAL_NET_DO_SESSION_RECOVERY) ||
> +		(nd->flag & NPREAL_NET_NODE_DISCONNECTED))) {
> +
> +		if (nd->flag & NPREAL_NET_DO_SESSION_RECOVERY)
> +			return -EAGAIN;
> +		else
> +			return -EIO;
> +	}
> +
> +	if (*rsp_len <= 0)
> +		return -EIO;
> +
> +	while (1) {
> +		down(&nd->cmd_semaphore);
> +
> +		if ((nd->rsp_length) && (nd->rsp_buffer[0] == command_set) &&
> +					(nd->rsp_buffer[1] == command)) {

You should break the loop here and do the processing below after the
loop. Making thuse the loop minimalistic.

> +			if (nd->rsp_length > *rsp_len)
> +				return -1;
> +
> +			*rsp_len = nd->rsp_length;
> +			memcpy(rsp_buf, nd->rsp_buffer, *rsp_len);
> +			nd->rsp_length = 0;
> +			up(&nd->cmd_semaphore);
> +			return 0;
> +
> +		} else if (timeout > 0) {
> +			up(&nd->cmd_semaphore);
> +			if (signal_pending(current))
> +				return -EIO;
> +
> +			st = jiffies;
> +			if (wait_event_interruptible_timeout(nd->cmd_rsp_wait,
> +							nd->cmd_rsp_flag == 1, timeout) != 0) {
> +				down(&nd->cmd_semaphore);
> +				nd->cmd_rsp_flag = 0;
> +				up(&nd->cmd_semaphore);
> +			}
> +
> +			tmp = abs((long)jiffies - (long)st);
> +
> +			if (tmp >= timeout)
> +				timeout = 0;
> +			else
> +				timeout -= tmp;

wait_event_interruptible_timeout already returns what you compute here
in a complicated way, IIUC.

> +		} else {
> +			up(&nd->cmd_semaphore);
> +			return -ETIME;
> +		}
> +	}
> +}
> +
> +static int npreal_set_unused_command_done(struct nd_struct *nd, char *rsp_buf, int *rsp_len)
> +{
> +	npreal_wait_and_set_command(nd, NPREAL_LOCAL_COMMAND_SET, LOCAL_CMD_TTY_UNUSED);
> +	nd->cmd_buffer[2] = 0;
> +	nd->cmd_ready = 1;
> +	smp_mb(); /* use smp_mb() with waitqueue_active() */
> +	/* used waitqueue_active() is safe because smp_mb() is used */
> +	if (waitqueue_active(&nd->select_ex_wait))
> +		wake_up_interruptible(&nd->select_ex_wait);
> +
> +	return npreal_wait_command_completed(nd, NPREAL_LOCAL_COMMAND_SET, LOCAL_CMD_TTY_UNUSED,
> +						NPREAL_CMD_TIMEOUT, rsp_buf, rsp_len);
> +}
> +
> +static int npreal_set_used_command_done(struct nd_struct *nd, char *rsp_buf, int *rsp_len)
> +{
> +	nd->cmd_buffer[0] = 0;
> +	npreal_wait_and_set_command(nd, NPREAL_LOCAL_COMMAND_SET, LOCAL_CMD_TTY_USED);
> +	nd->cmd_buffer[2] = 0;
> +	nd->cmd_ready = 1;
> +	smp_mb(); /* use smp_mb() with waitqueue_active() */
> +	/* used waitqueue_active() is safe because smp_mb() is used */
> +	if (waitqueue_active(&nd->select_ex_wait))
> +		wake_up_interruptible(&nd->select_ex_wait);
> +
> +	return npreal_wait_command_completed(nd, NPREAL_LOCAL_COMMAND_SET, LOCAL_CMD_TTY_USED,
> +						NPREAL_CMD_TIMEOUT, rsp_buf, rsp_len);
> +}
> +
> +static int npreal_set_tx_fifo_command_done(struct npreal_struct *info, struct nd_struct *nd,
> +								char *rsp_buf, int *rsp_len)
> +{
> +	int ret;
> +
> +	ret = npreal_wait_and_set_command(nd, NPREAL_ASPP_COMMAND_SET, ASPP_CMD_TX_FIFO);
> +	if (ret < 0)
> +		return ret;
> +
> +	nd->cmd_buffer[2] = 1;
> +	nd->cmd_buffer[3] = info->xmit_fifo_size;
> +	nd->cmd_ready = 1;
> +	smp_mb(); /* use smp_mb() with waitqueue_active() */
> +	/* used waitqueue_active() is safe because smp_mb() is used */
> +	if (waitqueue_active(&nd->select_ex_wait))
> +		wake_up_interruptible(&nd->select_ex_wait);
> +
> +	*rsp_len = RSP_BUFFER_SIZE;
> +	ret = npreal_wait_command_completed(nd, NPREAL_ASPP_COMMAND_SET, ASPP_CMD_TX_FIFO,
> +						NPREAL_CMD_TIMEOUT, rsp_buf, rsp_len);
> +	if (ret)
> +		return -EIO;
> +
> +	return 0;
> +}
> +
> +static int npreal_set_port_command_done(struct npreal_struct *info, struct nd_struct *nd,
> +					struct ktermios *termio, char *rsp_buf, int *rsp_len,
> +					int32_t mode, int32_t baud, int baudIndex)
> +{
> +	int ret;
> +
> +	ret = npreal_wait_and_set_command(nd, NPREAL_ASPP_COMMAND_SET, ASPP_CMD_PORT_INIT);
> +	if (ret < 0)
> +		return ret;
> +
> +	nd->cmd_buffer[2] = 8;
> +	nd->cmd_buffer[3] = baudIndex;
> +	nd->cmd_buffer[4] = mode;
> +
> +	if (info->modem_control & UART_MCR_DTR)
> +		nd->cmd_buffer[5] = 1;
> +	else
> +		nd->cmd_buffer[5] = 0;

Or simply:
nd->cmd_buffer[5] = !!(info->modem_control & UART_MCR_DTR);
In all of them below:

> +	if (info->modem_control & UART_MCR_RTS)
> +		nd->cmd_buffer[6] = 1;
> +	else
> +		nd->cmd_buffer[6] = 0;
> +
> +	if (termio->c_cflag & CRTSCTS) {
> +		nd->cmd_buffer[7] = 1;
> +		nd->cmd_buffer[8] = 1;
> +	} else {
> +		nd->cmd_buffer[7] = 0;
> +		nd->cmd_buffer[8] = 0;
> +	}
> +
> +	if (termio->c_iflag & IXON)
> +		nd->cmd_buffer[9] = 1;
> +	else
> +		nd->cmd_buffer[9] = 0;
> +
> +	if (termio->c_iflag & IXOFF)
> +		nd->cmd_buffer[10] = 1;
> +	else
> +		nd->cmd_buffer[10] = 0;

What is this cmd_buffer good for actually? Only to let the user know?
Then -- drop it.

> +	nd->cmd_ready = 1;
> +	smp_mb(); /* use smp_mb() with waitqueue_active() */
> +	/* used waitqueue_active() is safe because smp_mb() is used */
> +	if (waitqueue_active(&nd->select_ex_wait))
> +		wake_up_interruptible(&nd->select_ex_wait);
> +
> +	ret = npreal_wait_command_completed(nd, NPREAL_ASPP_COMMAND_SET, ASPP_CMD_PORT_INIT,
> +					NPREAL_CMD_TIMEOUT, rsp_buf, rsp_len);
> +	if (ret)
> +		return -EIO;
> +
> +	if ((*rsp_len != 6) || (rsp_buf[2] != 3))
> +		return -EIO;
> +
> +	return 0;
> +}
...
> +static int npreal_set_generic_command_done(struct npreal_struct *info, int cmd)
> +{
> +	struct nd_struct *nd;
> +	char rsp_buffer[RSP_BUFFER_SIZE];
> +	int rsp_length = RSP_BUFFER_SIZE;
> +
> +	nd = info->net_node;
> +	if (!nd)
> +		return -EIO;
> +
> +	if (npreal_wait_and_set_command(nd, NPREAL_ASPP_COMMAND_SET, cmd) < 0)
> +		return -EIO;
> +
> +	nd->cmd_buffer[2] = 0;
> +	nd->cmd_ready = 1;
> +	smp_mb(); /* use smp_mb() with waitqueue_active() */
> +	/* used waitqueue_active() is safe because smp_mb() is used */
> +	if (waitqueue_active(&nd->select_ex_wait))
> +		wake_up_interruptible(&nd->select_ex_wait);
> +	if (npreal_wait_command_completed(nd, NPREAL_ASPP_COMMAND_SET, cmd, NPREAL_CMD_TIMEOUT,
> +						rsp_buffer, &rsp_length))
> +		return -EIO;
> +
> +	if ((rsp_length != 4) || (rsp_buffer[2] != 'O') || (rsp_buffer[3] != 'K'))

Too many parentheses in all these functions.

> +		return -EIO;
> +
> +	return 0;
> +}
...
> +static void npreal_flush_buffer(struct tty_struct *tty)
> +{
> +	struct npreal_struct *info = (struct npreal_struct *)tty->driver_data;
> +	struct nd_struct *nd;
> +	char rsp_buffer[RSP_BUFFER_SIZE];
> +	int rsp_length = RSP_BUFFER_SIZE;
> +	unsigned long flags;
> +
> +	if (!info)
> +		return;
> +
> +	spin_lock_irqsave(&info->tx_lock, flags);
> +	info->xmit_tail = 0;
> +	info->xmit_head = 0;
> +	info->xmit_cnt = 0;
> +	spin_unlock_irqrestore(&info->tx_lock, flags);
> +	wake_up_interruptible(&tty->write_wait);
> +
> +	if ((tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) && tty->ldisc->ops->write_wakeup)
> +		(tty->ldisc->ops->write_wakeup)(tty);

Why not tty_wakeup?

> +
> +	nd = info->net_node;
> +	if (!nd)
> +		return;
> +
> +	nd->tx_ready = 0;
> +	if (npreal_wait_and_set_command(nd, NPREAL_ASPP_COMMAND_SET, ASPP_CMD_FLUSH) < 0)
> +		return;
> +
> +	nd->cmd_buffer[2] = 1;
> +	nd->cmd_buffer[3] = ASPP_FLUSH_ALL_BUFFER;
> +	nd->cmd_ready = 1;
> +	smp_mb(); /* use smp_mb() with waitqueue_active() */
> +	/* used waitqueue_active() is safe because smp_mb() is used */
> +	if (waitqueue_active(&nd->select_ex_wait))
> +		wake_up_interruptible(&nd->select_ex_wait);
> +
> +	npreal_wait_command_completed(nd, NPREAL_ASPP_COMMAND_SET, ASPP_CMD_FLUSH,
> +					NPREAL_CMD_TIMEOUT, rsp_buffer, &rsp_length);
> +}
> +
> +static long npreal_wait_oqueue(struct npreal_struct *info, long timeout)
> +{
> +	struct nd_struct *nd;
> +	long st = 0, tmp = 0;
> +	uint32_t tout;
> +
> +	nd = info->net_node;
> +	if (!nd)
> +		return -EIO;
> +
> +	if (npreal_wait_and_set_command(nd, NPREAL_ASPP_COMMAND_SET, ASPP_CMD_WAIT_OQUEUE) < 0)
> +		return -EIO;
> +
> +	if (timeout < HZ / 10)
> +		timeout = HZ / 10;
> +
> +	st = jiffies;
> +
> +	if (timeout != MAX_SCHEDULE_TIMEOUT)
> +		tout = (uint32_t)timeout;
> +	else
> +		tout = 0x7FFFFFFF;
> +
> +	nd->cmd_buffer[2] = 4;
> +	memcpy(&nd->cmd_buffer[3], (void *)&tout, 4);
> +	nd->wait_oqueue_responsed = 0;
> +	nd->cmd_ready = 1;
> +	smp_mb(); /* use smp_mb() with waitqueue_active() */
> +	/* used waitqueue_active() is safe because smp_mb() is used */
> +	if (waitqueue_active(&nd->select_ex_wait))
> +		wake_up_interruptible(&nd->select_ex_wait);
> +
> +	while (nd->cmd_ready == 1) {
> +		if (wait_event_interruptible_timeout(nd->cmd_rsp_wait, nd->cmd_rsp_flag == 1,
> +							timeout) != 0) {
> +			down(&nd->cmd_semaphore);
> +			nd->cmd_rsp_flag = 0;
> +			up(&nd->cmd_semaphore);
> +		} else {
> +			return -EIO;
> +		}
> +	}
> +
> +	nd->cmd_buffer[0] = 0;
> +	do {
> +		if (nd->wait_oqueue_responsed == 0) {
> +			if (wait_event_interruptible_timeout(nd->cmd_rsp_wait,
> +							nd->cmd_rsp_flag == 1, timeout)) {
> +				down(&nd->cmd_semaphore);
> +				nd->cmd_rsp_flag = 0;
> +				up(&nd->cmd_semaphore);
> +			}
> +
> +			tmp = abs((long)jiffies - (long)st);
> +			if (tmp >= timeout)
> +				timeout = 0;
> +			else
> +				timeout -= tmp;

Again this beast.

> +		} else {
> +			return nd->oqueue;
> +		}
> +	} while (timeout > 0);
> +
> +	return -EIO;
> +}
...
> +static void npreal_port_init_baud(struct npreal_struct *info, struct ktermios *termio,
> +				struct ktermios *old_termios, int32_t *baud_ret, int *index_ret)
> +{
> +	int baudIndex;
> +	int32_t baud;
> +
> +	switch (termio->c_cflag & (CBAUD | CBAUDEX)) {
> +	case B921600:
> +		baud = 921600L;

Why those L (long) suffixes when you assign to an int? Why is not the
int unsigned?

> +		baudIndex = ASPP_IOCTL_B921600;
> +		break;
> +
> +	case B460800:
> +		baud = 460800;
> +		baudIndex = ASPP_IOCTL_B460800;
> +		break;
> +
> +	case B230400:
> +		baud = 230400L;
> +		baudIndex = ASPP_IOCTL_B230400;
> +		break;
...
> +	default:
> +		baud = tty_termios_baud_rate(termio);
> +		baudIndex = 0xff;
> +	}
> +
> +#ifdef ASYNC_SPD_CUST
> +	if ((info->flags & ASYNC_SPD_MASK) == ASYNC_SPD_CUST)
> +		baudIndex = 0xff;
> +#endif
> +
> +	if (baud > 921600L) {
> +		termio->c_cflag &= ~(CBAUD | CBAUDEX);
> +		termio->c_cflag |= old_termios->c_cflag & (CBAUD | CBAUDEX);
> +	}
> +
> +	*baud_ret = baud;
> +	*index_ret = baudIndex;
> +}
> +
> +static int npreal_port_init(struct npreal_struct *info, struct ktermios *old_termios)
> +{
> +	struct ktermios *termio;
> +	struct nd_struct *nd;
> +	int rsp_length = RSP_BUFFER_SIZE;
> +	int baudIndex, modem_status;
> +	int ret;
> +	int32_t baud, mode;
> +	char rsp_buffer[RSP_BUFFER_SIZE];
> +
> +	nd = info->net_node;
> +	if (!info->tty || !nd)
> +		return -EIO;
> +
> +	termio = &(info->tty->termios);
> +	mode = npreal_port_init_mode(termio);
> +	npreal_port_init_baud(info, termio, old_termios, &baud, &baudIndex);
> +	ret = npreal_set_port_command_done(info, nd, termio, rsp_buffer, &rsp_length, mode, baud,
> +						baudIndex);
> +	if (ret < 0)
> +		return ret;
> +
> +	modem_status = 0;
> +	if (((unsigned char)rsp_buffer[3] == 0xff) && ((unsigned char)rsp_buffer[4] == 0xff) &&
> +		((unsigned char)rsp_buffer[5] == 0xff)) {
> +		termio->c_cflag &= ~(CBAUD | CBAUDEX);
> +		termio->c_cflag |= old_termios->c_cflag & (CBAUD | CBAUDEX);
> +	} else {
> +		if (rsp_buffer[3])
> +			modem_status |= UART_MSR_DSR;
> +		if (rsp_buffer[4])
> +			modem_status |= UART_MSR_CTS;
> +		if (rsp_buffer[5])
> +			modem_status |= UART_MSR_DCD;
> +	}
> +
> +	npreal_check_modem_status(info, modem_status);
> +
> +	if ((baudIndex == 0xff) && (baud != 0)) {
> +		ret = npreal_set_baud_command_done(info, nd, rsp_buffer, &rsp_length, baud);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (termio->c_iflag & (IXON | IXOFF)) {
> +		ret = npreal_set_xonxoff_command_done(info, termio, nd, rsp_buffer, &rsp_length);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (termio->c_cflag & CLOCAL)
> +		info->flags &= ~ASYNC_CHECK_CD;
> +	else
> +		info->flags |= ASYNC_CHECK_CD;
> +
> +	if (!info->tty)
> +		return -EIO;
> +
> +	return 0;
> +}
> +
> +static void npreal_init_net_node(struct nd_struct *net_node, struct npreal_struct *tty_node,
> +								struct proc_dir_entry *de)
> +{
> +	net_node->tty_node = tty_node;
> +	net_node->node_entry = de;
> +	net_node->cmd_rsp_flag = 0;
> +	net_node->flag = 0;
> +
> +	sema_init(&net_node->cmd_semaphore, 1);
> +	sema_init(&net_node->semaphore, 1);
> +
> +	init_waitqueue_head(&net_node->initialize_wait);
> +	init_waitqueue_head(&net_node->select_in_wait);
> +	init_waitqueue_head(&net_node->select_out_wait);
> +	init_waitqueue_head(&net_node->select_ex_wait);
> +	init_waitqueue_head(&net_node->cmd_rsp_wait);
> +}
> +
> +static void npreal_init_tty_node(struct npreal_struct *tty_node, struct nd_struct *net_node, int i)
> +{
> +	tty_node->net_node = net_node;
> +	tty_node->port = i;
> +	tty_node->type = PORT_16550A;
> +	tty_node->flags = 0;
> +	tty_node->xmit_fifo_size = 16;
> +	tty_node->baud_base = 921600L;
> +	tty_node->close_delay = 5 * HZ / 10;
> +	tty_node->closing_wait = 30 * HZ;
> +	tty_node->normal_termios = npvar_sdriver->init_termios;
> +
> +	memset(&tty_node->icount, 0, sizeof(tty_node->icount));
> +	INIT_WORK(&tty_node->process_flip_tqueue, npreal_flush_to_ldisc);
> +	INIT_WORK(&tty_node->tqueue, npreal_do_softint);
> +	spin_lock_init(&tty_node->tx_lock);
> +	sema_init(&tty_node->rx_semaphore, 1);
> +
> +	init_waitqueue_head(&tty_node->open_wait);
> +	init_waitqueue_head(&tty_node->close_wait);
> +	init_waitqueue_head(&tty_node->delta_msr_wait);
> +}
> +
> +static int npreal_init(struct npreal_struct *tty_node, struct nd_struct *net_node)
> +{
> +	struct proc_dir_entry *de;
> +	char buf[4];
> +	int i;
> +
> +	npvar_proc_root = proc_mkdir("npreal2", NULL);
> +	if (!npvar_proc_root)
> +		return -ENOMEM;
> +
> +	tty_node = &npvar_table[0];
> +	net_node = &npvar_net_nodes[0];
> +
> +	for (i = 0; i < NPREAL_PORTS; i++, tty_node++, net_node++) {
> +		sprintf(buf, "%d", i);
> +		de = proc_create_data(buf, 0666 | S_IFREG, npvar_proc_root, &npreal_net_fops,
> +					(void *)net_node);
> +		if (!de)
> +			return -ENOMEM;
> +
> +		npreal_init_net_node(net_node, tty_node, de);
> +		npreal_init_tty_node(tty_node, net_node, i);
> +	}
> +
> +	return 0;
> +}
> +
> +static int npreal_chars_in_buffer(struct tty_struct *tty)
> +{
> +	struct npreal_struct *info = (struct npreal_struct *)tty->driver_data;
> +
> +	if (!info)
> +		return -EIO;
> +
> +	return info->xmit_cnt;
> +}
> +
> +static int npreal_block_till_ready(struct tty_struct *tty, struct file *filp,
> +						struct npreal_struct *info)

Why are you not using tty_port_block_til_ready?

> +{
> +	DECLARE_WAITQUEUE(wait, current);
> +	struct nd_struct *nd;
> +	int do_clocal = 0;
> +	int retval = 0;
> +
> +	nd = info->net_node;
> +	if (!nd)
> +		return -EIO;
> +
> +	if ((filp->f_flags & O_NONBLOCK) || test_bit(TTY_IO_ERROR, &tty->flags)) {
> +		info->flags |= ASYNC_NORMAL_ACTIVE;
> +		return 0;
> +	}
> +
> +	if (tty->termios.c_cflag & CLOCAL)
> +		do_clocal = 1;
> +
> +	add_wait_queue(&info->open_wait, &wait);
> +	while (1) {
> +		if (tty_hung_up_p(filp))
> +			break;
> +		else if (info->flags & ASYNC_CLOSING) {
> +			if (SERIAL_DO_RESTART && !(info->flags & ASYNC_HUP_NOTIFY))
> +				retval = -ERESTARTSYS;
> +			else
> +				retval = -EAGAIN;
> +			break;
> +		}
> +
> +		if (!(info->flags & ASYNC_CLOSING) &&
> +			(do_clocal || (info->modem_status & UART_MSR_DCD)))
> +			break;
> +
> +		if (signal_pending(current)) {
> +			retval = -EIO;
> +			break;
> +		}
> +
> +		current->state = TASK_INTERRUPTIBLE;
> +		schedule();
> +	}
> +
> +	remove_wait_queue(&info->open_wait, &wait);
> +	if (!retval)
> +		info->flags |= ASYNC_NORMAL_ACTIVE;
> +
> +	return retval;
> +}
> +
> +static void set_common_xmit_fifo_size(struct npreal_struct *info, struct nd_struct *nd)
> +{
> +	if (info->type == PORT_16550A) {
> +		if (nd->server_type == CN2500)
> +			info->xmit_fifo_size = 64;
> +		else
> +			info->xmit_fifo_size = 16;
> +	} else {
> +		info->xmit_fifo_size = 1;
> +	}
> +}
> +
> +static int npreal_port_shutdown(struct npreal_struct *info)
> +{
> +	struct nd_struct *nd;
> +	char rsp_buffer[RSP_BUFFER_SIZE];
> +	int rsp_length = RSP_BUFFER_SIZE;
> +
> +	nd = info->net_node;
> +	if (!nd)
> +		return -EIO;
> +
> +	npreal_disconnect(nd, rsp_buffer, &rsp_length);
> +	nd->flag &= ~NPREAL_NET_TTY_INUSED;
> +	return 0;
> +}
> +
> +static int npreal_get_serial_info(struct npreal_struct *info, struct serial_struct *retinfo)
> +{
> +	struct serial_struct tmp;
> +
> +	if (!retinfo)
> +		return -EFAULT;
> +
> +	memset(&tmp, 0, sizeof(tmp));
> +	tmp.type = info->type;
> +	tmp.line = info->port;
> +	tmp.flags = info->flags;
> +	tmp.close_delay = info->close_delay;
> +	tmp.closing_wait = info->closing_wait;
> +	tmp.custom_divisor = info->custom_divisor;
> +	tmp.baud_base = info->baud_base;
> +	tmp.hub6 = 0;
> +
> +	if (copy_to_user(retinfo, &tmp, sizeof(*retinfo)))
> +		return -EFAULT;
> +	else
> +		return 0;
> +}
> +
> +static int npreal_set_serial_info(struct npreal_struct *info, struct serial_struct *new_info)
> +{
> +	struct serial_struct new_serial;
> +	int rsp_length = RSP_BUFFER_SIZE;
> +	int retval = 0;
> +	unsigned int flags;
> +	char rsp_buffer[RSP_BUFFER_SIZE];
> +
> +
> +	if ((!new_info) || copy_from_user(&new_serial, new_info, sizeof(new_serial)))
> +		return -EFAULT;
> +
> +	flags = info->flags & ASYNC_SPD_MASK;
> +
> +	if (!capable(CAP_SYS_ADMIN)) {
> +		if ((new_serial.close_delay != info->close_delay) ||
> +			((new_serial.flags & ~ASYNC_USR_MASK) != (info->flags & ~ASYNC_USR_MASK)))
> +			return -EPERM;
> +
> +		info->flags = ((info->flags & ~ASYNC_USR_MASK) |
> +				(new_serial.flags & ASYNC_USR_MASK));
> +	} else {
> +		info->flags = ((info->flags & ~ASYNC_FLAGS) | (new_serial.flags & ASYNC_FLAGS));
> +		info->close_delay = new_serial.close_delay * HZ / 100;
> +
> +		if (new_serial.closing_wait == ASYNC_CLOSING_WAIT_NONE)
> +			info->closing_wait = ASYNC_CLOSING_WAIT_NONE;
> +		else
> +			info->closing_wait = new_serial.closing_wait * HZ / 100;
> +	}
> +
> +	info->type = new_serial.type;
> +	set_common_xmit_fifo_size(info, info->net_node);
> +
> +	if (info->flags & ASYNC_INITIALIZED) {
> +		if (flags != (info->flags & ASYNC_SPD_MASK))
> +			retval = npreal_port_init(info, 0);
> +
> +		if (info->net_node)
> +			npreal_set_tx_fifo_command_done(info, info->net_node, rsp_buffer,
> +							&rsp_length);
> +
> +	}
> +
> +	info->custom_divisor = new_serial.custom_divisor;
> +
> +	if (info->custom_divisor == 0)
> +		info->baud_base = 921600L;
> +	else
> +		info->baud_base = new_serial.baud_base;
> +
> +	return retval;
> +}
> +
> +/**
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
> +
> +	return 0;
> +}
> +
> +static int npreal_start_break(struct nd_struct *nd)
> +{
> +	char rsp_buffer[RSP_BUFFER_SIZE];
> +	int rsp_length = RSP_BUFFER_SIZE;
> +
> +	npreal_wait_and_set_command(nd, NPREAL_ASPP_COMMAND_SET, ASPP_CMD_START_BREAK);
> +	nd->cmd_buffer[2] = 0;
> +	nd->cmd_ready = 1;
> +	smp_mb(); /* use smp_mb() with waitqueue_active() */
> +	/* used waitqueue_active() is safe because smp_mb() is used */
> +	if (waitqueue_active(&nd->select_ex_wait))
> +		wake_up_interruptible(&nd->select_ex_wait);
> +
> +	if (npreal_wait_command_completed(nd, NPREAL_ASPP_COMMAND_SET, ASPP_CMD_START_BREAK,
> +					NPREAL_CMD_TIMEOUT, rsp_buffer, &rsp_length))
> +		return -EIO;
> +
> +	if ((rsp_length != 4) || (rsp_buffer[2] != 'O') || (rsp_buffer[3] != 'K'))
> +		return -EIO;
> +
> +	return 0;
> +}
> +
> +static int npreal_stop_break(struct nd_struct *nd)
> +{
> +	char rsp_buffer[RSP_BUFFER_SIZE];
> +	int rsp_length = RSP_BUFFER_SIZE;
> +
> +	npreal_wait_and_set_command(nd, NPREAL_ASPP_COMMAND_SET, ASPP_CMD_STOP_BREAK);
> +	nd->cmd_buffer[2] = 0;
> +	nd->cmd_ready = 1;
> +	smp_mb(); /* use smp_mb() with waitqueue_active() */
> +	/* used waitqueue_active() is safe because smp_mb() is used */
> +	if (waitqueue_active(&nd->select_ex_wait))
> +		wake_up_interruptible(&nd->select_ex_wait);
> +
> +	rsp_length = sizeof(rsp_buffer);
> +	if (npreal_wait_command_completed(nd, NPREAL_ASPP_COMMAND_SET, ASPP_CMD_STOP_BREAK,
> +					NPREAL_CMD_TIMEOUT, rsp_buffer, &rsp_length))
> +		return -EIO;
> +
> +	if (rsp_length != 4  || (rsp_buffer[2] != 'O') || (rsp_buffer[3] != 'K'))
> +		return -EIO;
> +
> +	return 0;
> +}
> +
> +/**
> + * npreal_send_break() - Sends break characters out the serial port.
> + * @info: pointer for npread_struct
> + * @duration: the time during sending break signals
> + *
> + * This is called by npreal_ioctl() with case of TCSBRK or TCSBRKP
> + */
> +static void npreal_send_break(struct npreal_struct *info, unsigned int duration)
> +{
> +	struct nd_struct *nd;
> +
> +	nd = info->net_node;
> +	if (!nd)
> +		return;
> +
> +	npreal_start_break(nd);
> +	current->state = TASK_INTERRUPTIBLE;
> +	schedule_timeout(duration);
> +	npreal_stop_break(nd);
> +}
> +
> +static void npreal_remove_proc_entry(struct proc_dir_entry *pde, int idx)
> +{
> +	char tmp[10];
> +
> +	if (!pde)
> +		return;
> +
> +	sprintf(tmp, "%d", idx);
> +
> +	if (idx == 404)
> +		remove_proc_entry("npreal2", NULL);
> +	else
> +		remove_proc_entry(tmp, npvar_proc_root);
> +}
> +
> +static void npreal_process_notify(struct nd_struct *nd, char *rsp_buffer, int rsp_length)
> +{
> +	struct npreal_struct *info = nd->tty_node;
> +	int state;
> +
> +	if (!info || rsp_length != 5)
> +		return;
> +
> +	if (rsp_buffer[2] & ASPP_NOTIFY_MSR_CHG) {
> +		state = 0;
> +
> +		if (rsp_buffer[3] & 0x10)
> +			state |= UART_MSR_CTS;
> +		if (rsp_buffer[3] & 0x20)
> +			state |= UART_MSR_DSR;
> +		if (rsp_buffer[3] & 0x80)
> +			state |= UART_MSR_DCD;
> +		npreal_check_modem_status(info, state);
> +	}
> +
> +	if (rsp_buffer[2] & ASPP_NOTIFY_BREAK) {
> +		struct tty_struct *tty;
> +
> +		down(&info->rx_semaphore);
> +		tty = info->tty;
> +		if (!tty || !info->ttyPort.low_latency) {
> +			up(&info->rx_semaphore);
> +			return;
> +		}
> +
> +		tty_insert_flip_char(&info->ttyPort, 0, TTY_BREAK);
> +		up(&info->rx_semaphore);
> +		info->icount.rx++;
> +		info->icount.brk++;
> +		schedule_work(&info->process_flip_tqueue);
> +
> +		if (info->flags & ASYNC_SAK)
> +			do_SAK(info->tty);
> +	}
> +
> +	if (rsp_buffer[2] & ASPP_NOTIFY_PARITY)
> +		info->icount.parity++;
> +	if (rsp_buffer[2] & ASPP_NOTIFY_FRAMING)
> +		info->icount.frame++;
> +	if ((rsp_buffer[2] & ASPP_NOTIFY_SW_OVERRUN) || (rsp_buffer[2] & ASPP_NOTIFY_HW_OVERRUN))
> +		info->icount.overrun++;
> +}
> +
> +static int32_t npreal_do_session_mode(struct ktermios *termio)
> +{
> +	int32_t mode;
> +
> +	mode = termio->c_cflag & CSIZE;
> +	switch (mode) {
> +	case CS5:
> +		mode = ASPP_IOCTL_BITS5;
> +		break;
> +
> +	case CS6:
> +		mode = ASPP_IOCTL_BITS6;
> +		break;
> +
> +	case CS7:
> +		mode = ASPP_IOCTL_BITS7;
> +		break;
> +
> +	case CS8:
> +		mode = ASPP_IOCTL_BITS8;
> +		break;
> +
> +	}
> +
> +	if (termio->c_cflag & CSTOPB)
> +		mode |= ASPP_IOCTL_STOP2;
> +	else
> +		mode |= ASPP_IOCTL_STOP1;
> +
> +	if (termio->c_cflag & PARENB) {
> +		if (termio->c_cflag & PARODD)
> +			mode |= ASPP_IOCTL_ODD;
> +		else
> +			mode |= ASPP_IOCTL_EVEN;
> +	} else {
> +		mode |= ASPP_IOCTL_NONE;
> +	}
> +
> +	return mode;
> +}
> +
> +static void npreal_do_session_baud(struct npreal_struct *info, struct ktermios *termio,
> +							int32_t *baud_ret, int *baud_ind_ret)
> +{
> +	int32_t baud;
> +	int baudIndex;
> +
> +	switch (termio->c_cflag & (CBAUD | CBAUDEX)) {
> +	case B921600:
> +		baud = 921600L;
> +		baudIndex = ASPP_IOCTL_B921600;
> +		break;

Do I have deja-vu? Why all this duplicated code?

> +	case B460800:
> +		baud = 460800;
> +		baudIndex = ASPP_IOCTL_B460800;
> +		break;
...
> +static void npreal_do_session_buffer(struct nd_struct *nd, struct npreal_struct *info,
> +				struct ktermios *termio, int baud, int mode, int baudIndex)
> +{
> +	nd->cmd_buffer[0] = NPREAL_ASPP_COMMAND_SET;
> +	nd->cmd_buffer[1] = ASPP_CMD_PORT_INIT;
> +	nd->cmd_buffer[2] = 8;
> +	nd->cmd_buffer[3] = baudIndex;   /* baud rate */
> +	nd->cmd_buffer[4] = mode;       /* mode */
> +
> +	/* line control */
> +	if (info->modem_control & UART_MCR_DTR)
> +		nd->cmd_buffer[5] = 1;
> +	else
> +		nd->cmd_buffer[5] = 0;

And this duplicated code?

> +	if (info->modem_control & UART_MCR_RTS)
> +		nd->cmd_buffer[6] = 1;
> +	else
> +		nd->cmd_buffer[6] = 0;
> +
> +	/* flow control */
> +	if ((info->flags & ASYNC_INITIALIZED) && (termio->c_cflag & CRTSCTS)) {
> +		nd->cmd_buffer[7] = 1;
> +		nd->cmd_buffer[8] = 1;
> +	} else {
> +		nd->cmd_buffer[7] = 0;
> +		nd->cmd_buffer[8] = 0;
> +	}
> +
> +	if (termio->c_iflag & IXON)
> +		nd->cmd_buffer[9] = 1;
> +	else
> +		nd->cmd_buffer[9] = 0;
> +	if (termio->c_iflag & IXOFF)
> +		nd->cmd_buffer[10] = 1;
> +	else
> +		nd->cmd_buffer[10] = 0;
> +
> +	if ((baudIndex == 0xff) && (baud != 0)) {
> +		nd->cmd_buffer[11] = ASPP_CMD_SETBAUD;
> +		nd->cmd_buffer[12] = 4;
> +
> +		if (((info->flags & ASYNC_SPD_MASK) == ASYNC_SPD_CUST) && info->custom_divisor)
> +			baud = info->baud_base/info->custom_divisor;
> +
> +		memcpy(&nd->cmd_buffer[13], &baud, 4);
> +	}
> +
> +	if (termio->c_iflag & (IXON | IXOFF)) {
> +		nd->cmd_buffer[17] = ASPP_CMD_XONXOFF;
> +		nd->cmd_buffer[18] = 2;
> +		nd->cmd_buffer[19] = termio->c_cc[VSTART];
> +		nd->cmd_buffer[20] = termio->c_cc[VSTOP];
> +	}
> +
> +	nd->cmd_buffer[21] = ASPP_CMD_TX_FIFO;
> +	nd->cmd_buffer[22] = 1;
> +	nd->cmd_buffer[23] = info->xmit_fifo_size;
> +	nd->cmd_buffer[24] = ASPP_CMD_LINECTRL;
> +	nd->cmd_buffer[25] = 2;
> +
> +	if (info->modem_control & UART_MCR_DTR)
> +		nd->cmd_buffer[26] = 1;
> +	else
> +		nd->cmd_buffer[26] = 0;
> +	if (info->modem_control & UART_MCR_RTS)
> +		nd->cmd_buffer[27] = 1;
> +	else
> +		nd->cmd_buffer[27] = 0;
> +
> +	nd->do_session_recovery_len = 27 + 1;
> +}
> +
> +static void npreal_do_session_recovery(struct npreal_struct *info)
> +{
> +	struct tty_struct *tty;
> +	struct nd_struct *nd;
> +	struct ktermios *termio;
> +	int32_t baud, mode;
> +	int baudIndex;
> +
> +	tty = info->tty;
> +	nd = info->net_node;
> +
> +	if (!tty || !nd)
> +		return;
> +
> +	if (!(nd->flag & NPREAL_NET_NODE_OPENED) || !(nd->flag & NPREAL_NET_NODE_CONNECTED))
> +		return;
> +
> +	if (info->flags & ASYNC_INITIALIZED) {
> +		termio = &(info->tty->termios);
> +	} else {
> +		termio = &info->normal_termios;
> +
> +		if (!termio)
> +			return;
> +	}
> +
> +	down(&nd->cmd_semaphore);
> +	mode = npreal_do_session_mode(termio);
> +	npreal_do_session_baud(info, termio, &baud, &baudIndex);
> +	npreal_do_session_buffer(nd, info, termio, baud, mode, baudIndex);
> +	nd->flag |= NPREAL_NET_DO_SESSION_RECOVERY;
> +	nd->cmd_ready = 1;
> +	up(&nd->cmd_semaphore);
> +	/* waitqueue_active() is safe because nd->cmd_ready is in semaphore.*/
> +	if (waitqueue_active(&nd->select_ex_wait))
> +		wake_up_interruptible(&nd->select_ex_wait);
> +}
> +
> +static int npreal_startup_serial_port(struct npreal_struct *info, struct nd_struct *nd)
> +{
> +	int ret;
> +
> +	nd->flag &= ~NPREAL_NET_DO_SESSION_RECOVERY;
> +	info->modem_status = 0;
> +	info->modem_control = 0;
> +
> +	if (info->tty->termios.c_cflag & CBAUD)
> +		info->modem_control = UART_MCR_DTR | UART_MCR_RTS;
> +
> +	ret = npreal_port_init(info, 0);
> +	if (ret != 0)
> +		return ret;
> +
> +	set_common_xmit_fifo_size(info, nd);
> +	return 0;
> +}
> +
> +static int npreal_startup_init(struct npreal_struct *info, struct nd_struct *nd,
> +					struct tty_struct *tty, unsigned long *page)
> +{
> +	DECLARE_WAITQUEUE(wait, current);
> +
> +	if (!nd)
> +		return -EIO;
> +
> +	add_wait_queue(&nd->initialize_wait, &wait);
> +	while (test_and_set_bit(NPREAL_NET_DO_INITIALIZE, &nd->flag)) {
> +		if (signal_pending(current))
> +			break;
> +
> +		schedule();

Nah. wait_event and friends.

> +	}
> +
> +	remove_wait_queue(&nd->initialize_wait, &wait);
> +
> +	info->tty = tty;
> +
> +	if (info->flags & ASYNC_INITIALIZED) {
> +		clear_bit(NPREAL_NET_DO_INITIALIZE, &nd->flag);
> +		smp_mb(); /* use smp_mb() with waitqueue_active() */
> +		/* used waitqueue_active() is safe because smp_mb() is used */
> +		if (waitqueue_active(&nd->initialize_wait))
> +			wake_up_interruptible(&nd->initialize_wait);
> +
> +		return 0;
> +	}
> +
> +	*page = __get_free_page(GFP_KERNEL);
> +	if (!(*page)) {
> +		clear_bit(NPREAL_NET_DO_INITIALIZE, &nd->flag);
> +		smp_mb(); /* use smp_mb() with waitqueue_active() */
> +		/* used waitqueue_active() is safe because smp_mb() is used */
> +		if (waitqueue_active(&nd->initialize_wait))
> +			wake_up_interruptible(&nd->initialize_wait);
> +
> +		return -ENOMEM;
> +	}
> +
> +	return 1;
> +}
> +
> +static int npreal_startup_tty_usage(struct npreal_struct *info, struct nd_struct *nd,
> +							char *rsp_buf, int *rsp_len)
> +{
> +	int ret;
> +
> +	ret = npreal_set_used_command_done(nd, rsp_buf, rsp_len);
> +	if (ret != 0) {
> +		npreal_set_unused_command_done(nd, rsp_buf, rsp_len);
> +		return ret;
> +	} else if (OFFLINE_POLLING) {
> +		if (!rsp_buf[2]) {
> +			npreal_set_unused_command_done(nd, rsp_buf, rsp_len);
> +			return ret;
> +		}
> +	}
> +
> +	nd->flag |= NPREAL_NET_TTY_INUSED;
> +	return 0;
> +}
> +
> +static int npreal_startup_disconnect(struct npreal_struct *info, struct nd_struct *nd,
> +								char *rsp_buf, int *rsp_len)
> +{
> +	int ret;
> +
> +	nd->flag &= ~NPREAL_NET_NODE_DISCONNECTED;
> +
> +	ret = npreal_set_unused_command_done(nd, rsp_buf, rsp_len);
> +	if (ret != 0)
> +		nd->flag |= NPREAL_NET_NODE_DISCONNECTED;
> +	else
> +		nd->flag &= ~NPREAL_NET_TTY_INUSED;
> +
> +	return ret;
> +}
> +
> +static int npreal_startup(struct npreal_struct *info, struct file *filp,
> +			struct tty_struct *tty)
> +{
> +	struct nd_struct *nd = info->net_node;
> +	unsigned long page;
> +	int rsp_length = RSP_BUFFER_SIZE;
> +	int cnt = 0, ret;
> +	char rsp_buffer[RSP_BUFFER_SIZE];
> +
> +	ret = npreal_startup_init(info, nd, tty, &page);
> +	if (ret < 1)
> +		return ret;
> +
> +	if (!(nd->flag & NPREAL_NET_TTY_INUSED)) {
> +		ret = npreal_startup_tty_usage(info, nd, rsp_buffer, &rsp_length);
> +		if (ret)
> +			goto startup_err;
> +	} else {
> +		if (nd->flag & NPREAL_NET_NODE_DISCONNECTED) {
> +			npreal_startup_disconnect(info, nd, rsp_buffer, &rsp_length);
> +			goto startup_err;
> +		}
> +
> +		while ((nd->cmd_ready == 1) && (cnt++ < 10)) {
> +			current->state = TASK_INTERRUPTIBLE;
> +			schedule_timeout(HZ / 100);

All these random schedules needs to go.

> +		}
> +	}
> +
> +	ret = npreal_startup_serial_port(info, nd);
> +	if (ret)
> +		goto startup_err;
> +
> +	ret = npreal_set_tx_fifo_command_done(info, nd, rsp_buffer, &rsp_length);
> +	if (ret)
> +		goto startup_err;
> +
> +	if (info->xmit_buf)
> +		free_page(page);
> +	else
> +		info->xmit_buf = (unsigned char *)page;
> +
> +	if (info->tty)
> +		test_and_clear_bit(TTY_IO_ERROR, &info->tty->flags);
> +
> +	info->xmit_tail = 0;
> +	info->xmit_head = 0;
> +	info->xmit_cnt = 0;
> +	info->flags |= ASYNC_INITIALIZED;
> +	clear_bit(NPREAL_NET_DO_INITIALIZE, &nd->flag);
> +	smp_mb(); /* use smp_mb() with waitqueue_active() */
> +	/* used waitqueue_active() is safe because smp_mb() is used */
> +	if (waitqueue_active(&nd->initialize_wait))
> +		wake_up_interruptible(&nd->initialize_wait);
> +
> +	return 0;
> +
> +startup_err:
> +	npreal_disconnect(nd, rsp_buffer, &rsp_length);
> +	free_page(page);
> +	clear_bit(NPREAL_NET_DO_INITIALIZE, &nd->flag);
> +	smp_mb(); /* use smp_mb() with waitqueue_active() */
> +	/* used waitqueue_active() is safe because smp_mb() is used */
> +	if (waitqueue_active(&nd->initialize_wait))
> +		wake_up_interruptible(&nd->initialize_wait);
> +
> +	return ret;
> +}
> +
> +static int npreal_open_startup(struct tty_struct *tty, struct npreal_struct *info,
> +								struct file *filp)
> +{
> +	long jiff_th;
> +	int ret, retry;
> +
> +	retry = NPREAL_CMD_TRY - 1;
> +	while (retry) {
> +		/* For some circumstance, device may reset the connection
> +		 * during the port opening. These code is to reopen the port
> +		 * without telling application. Considering a real situation
> +		 * of connection lost, we use -ETIME to exit the retry loop.
> +		 */
> +		ret = npreal_startup(info, filp, tty);
> +		if (ret == 0)
> +			break;
> +		else if (ret == -ETIME) {
> +			pr_err("npreal_startup failed(%d)\n", ret);
> +			return -EIO;
> +		}
> +
> +		jiff_th = (NPREAL_CMD_TRY-retry)*HZ/2;
> +		schedule_timeout_uninterruptible(jiff_th);

So msleep((NPREAL_CMD_TRY-retry)*500)?

> +		retry--;
> +		if (retry < 0) {
> +			pr_err("npreal_startup failed\n");
> +			return -EIO;
> +		}
> +	}
> +	return 0;
> +}
> +
> +/**
> + * npreal_throttle() - Notify the tty driver input buffer is full
> + * @tty: pointer for struct tty_struct
> + *
> + * This routine is called by the upper-layer tty layer to signal that
> + * incoming characters should be throttled. (tty driver buffer is full)
> + *
> + */
> +static void npreal_throttle(struct tty_struct *tty)
> +{
> +	struct npreal_struct *info = (struct npreal_struct *)tty->driver_data;
> +	struct nd_struct *nd;
> +
> +	if (!info)
> +		return;
> +
> +	nd = info->net_node;
> +	if (!nd)
> +		return;
> +
> +	nd->rx_ready = 0;
> +	smp_mb(); /* use smp_mb() with waitqueue_active() */
> +	/* used waitqueue_active() is safe because smp_mb() is used */
> +	if (waitqueue_active(&nd->select_out_wait))

Why do you actully do these racy waitqueue_active checks all over the code?

> +		wake_up_interruptible(&nd->select_out_wait);
> +}
...
> +static void npreal_shutdown(struct npreal_struct *info)
> +{
> +	struct nd_struct *nd = info->net_node;
> +	unsigned long flags;
> +
> +	while (test_and_set_bit(NPREAL_NET_DO_INITIALIZE, &nd->flag)) {
> +		if (signal_pending(current))
> +			break;
> +		current->state = TASK_INTERRUPTIBLE;
> +		schedule_timeout(HZ / 100);

You already know what, right?

> +	}
> +
> +	if (!(info->flags & ASYNC_INITIALIZED))
> +		goto done;
> +
> +	spin_lock_irqsave(&info->tx_lock, flags);
> +	if (info->xmit_buf) {
> +		free_page((unsigned long)info->xmit_buf);
> +		info->xmit_buf = 0;
> +	}
> +	spin_unlock_irqrestore(&info->tx_lock, flags);
> +
> +	if (info->tty) {
> +		set_bit(TTY_IO_ERROR, &info->tty->flags);
> +		npreal_unthrottle(info->tty);
> +	}
> +
> +	if (!info->tty || (info->tty->termios.c_cflag & HUPCL))
> +		info->modem_control &= ~(UART_MCR_DTR | UART_MCR_RTS);
> +
> +done:
> +	npreal_port_shutdown(info);
> +	info->flags &= ~(ASYNC_NORMAL_ACTIVE |
> +	ASYNC_INITIALIZED | ASYNC_CLOSING);
> +	down(&info->rx_semaphore);
> +	info->tty = 0;

0 is not a pointer.

> +	up(&info->rx_semaphore);
> +	clear_bit(NPREAL_NET_DO_INITIALIZE, &nd->flag);
> +	wake_up_interruptible(&info->open_wait);
> +	wake_up_interruptible(&info->close_wait);
> +	smp_mb(); /* use smp_mb() with waitqueue_active() */
> +	/* used waitqueue_active() is safe because smp_mb() is used */
> +	if (waitqueue_active(&nd->initialize_wait))
> +		wake_up_interruptible(&nd->initialize_wait);
> +}
...
> +static int npreal_open(struct tty_struct *tty, struct file *filp)
> +{

Why not to use tty_port_open?

> +}
...
> +static void npreal_close(struct tty_struct *tty, struct file *filp)
> +{

And tty_port_close?

> +}
...
> +static int npreal_write(struct tty_struct *tty, const unsigned char *buf, int count)
> +{
> +	struct npreal_struct *info = (struct npreal_struct *)tty->driver_data;
> +	struct nd_struct *nd;
> +	unsigned long flags;
> +	int c, total = 0;
> +
> +	if ((!info) || !tty || !info->xmit_buf)
> +		return 0;
> +
> +	nd = info->net_node;
> +
> +	if (!nd)
> +		return 0;
> +	while (1) {
> +		c = min(count, min((int)(SERIAL_XMIT_SIZE - info->xmit_cnt - 1),
> +					(int)(SERIAL_XMIT_SIZE - info->xmit_head)));

Casts here only mean you have wrong types somewhere. If it must be (not
in this case), use min_t.

> +		if (c <= 0)
> +			break;
> +
> +		spin_lock_irqsave(&info->tx_lock, flags);
> +		memcpy(info->xmit_buf + info->xmit_head, buf, c);
> +		info->xmit_head = (info->xmit_head + c) & (SERIAL_XMIT_SIZE - 1);

If you used modulo (which is what you want here), you need not decrement
by one, right?

> +		info->xmit_cnt += c;
> +		spin_unlock_irqrestore(&info->tx_lock, flags);
> +
> +		buf += c;
> +		count -= c;
> +		total += c;
> +	}
> +
> +	if (info->xmit_cnt) {
> +		nd->tx_ready = 1;
> +		smp_mb(); /* use smp_mb() with waitqueue_active() */
> +		/* used waitqueue_active() is safe because smp_mb() is used */
> +		if (waitqueue_active(&nd->select_in_wait))
> +			wake_up_interruptible(&nd->select_in_wait);
> +	}
> +
> +	return total;
> +}
...
> +static int npreal_ioctl(struct tty_struct *tty, unsigned int cmd,
> +			unsigned long arg)
> +{
> +	struct npreal_struct *info = (struct npreal_struct *)tty->driver_data;
> +	struct serial_icounter_struct *p_cuser; /* user space */
> +	unsigned long templ;
> +	int ret = 0;
> +
> +	if (!info)
> +		return -ENODEV;
> +
> +	if ((cmd != TIOCGSERIAL) && (cmd != TIOCMIWAIT) && (cmd != TIOCGICOUNT) &&
> +		test_bit(TTY_IO_ERROR, &tty->flags))
> +		return -EIO;
> +
> +	switch (cmd) {
> +	case TCFLSH:

You should not handle ioctl like these in the driver, should you?

> +		ret = tty_check_change(tty);
> +		if (!ret) {
> +			switch (arg) {
> +			case TCIFLUSH:
> +				if (tty->ldisc->ops->flush_buffer)
> +					tty->ldisc->ops->flush_buffer(tty);
> +				break;
> +
> +			case TCIOFLUSH:
> +				if (tty->ldisc->ops->flush_buffer)
> +					tty->ldisc->ops->flush_buffer(tty);
> +				npreal_flush_buffer(tty);
> +				break;
> +
> +			case TCOFLUSH:
> +				npreal_flush_buffer(tty);
> +				break;
> +
> +			default:
> +				ret = -EINVAL;
> +			}
> +		}
> +		break;
...
> +static const struct tty_operations mpvar_ops = {
> +	.open               = npreal_open,
> +	.close              = npreal_close,
> +	.write              = npreal_write,
> +	.put_char           = npreal_put_char,
> +	.write_room         = npreal_write_room,
> +	.chars_in_buffer    = npreal_chars_in_buffer,
> +	.flush_buffer       = npreal_flush_buffer,
> +	.wait_until_sent    = npreal_wait_until_sent,
> +	.break_ctl          = npreal_break,
> +	.ioctl              = npreal_ioctl,
> +	.throttle           = npreal_throttle,
> +	.unthrottle         = npreal_unthrottle,
> +	.set_termios        = npreal_set_termios,
> +	.hangup             = npreal_hangup,
> +	.tiocmget           = npreal_tiocmget,
> +	.tiocmset           = npreal_tiocmset,
> +};
...
> +static ssize_t npreal_net_read(struct file *file, char *buf, size_t count, loff_t *ppos)
> +{
> +	struct nd_struct *nd = file->private_data;
> +	struct npreal_struct *info;
> +	struct tty_struct *tty;
> +	ssize_t rtn = 0;
> +	int min_val;
> +	unsigned long flags;
> +
> +
> +	info = (struct npreal_struct *)nd->tty_node;
> +	tty = info->tty;
> +
> +	if (!nd || !info || !tty) {
> +		rtn = -ENXIO;
> +		return rtn;
> +	}
> +
> +	if (info->x_char) {
> +		rtn = 1;
> +		if (copy_to_user(buf, &info->x_char, rtn)) {

I.e. put_user.

...
> +static ssize_t npreal_net_write(struct file *file, const char *buf, size_t count, loff_t *ppos)
> +{
> +	struct nd_struct *nd = file->private_data;
> +	struct npreal_struct *info;
> +	struct tty_struct *tty;
> +	unsigned char *k_buf = NULL;
> +	ssize_t rtn = 0;
> +	int cnt;
> +	unsigned long tmp;
> +
> +	if (!buf) {
> +		rtn = count;
> +		goto done;
> +	}
> +
> +	k_buf = kmalloc_array(count, sizeof(unsigned char), GFP_KERNEL);
> +	info = (struct npreal_struct *)nd->tty_node;
> +	tmp =  copy_from_user(k_buf, buf, count);

Is buf a user buffer? It is not marked as such. Ah, this is the proc
interface you should drop.

> +	if ((k_buf == NULL || tmp) || (!nd || !info) || (info->flags & ASYNC_CLOSING)) {
> +		rtn = count;
> +		goto done;
> +	}



Overall, you shall deduplicate the code and use tty_port helpers
wherever possible. This will simplify the code a lot. I wonder where you
get from this submission with "3194 insertions".

thanks,
-- 
js
