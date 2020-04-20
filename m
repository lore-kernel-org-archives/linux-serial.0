Return-Path: <SRS0=2nXW=6E=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FUZZY_XPILL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D81FC54FCF
	for <linux-serial@archiver.kernel.org>; Mon, 20 Apr 2020 11:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26402206D4
	for <linux-serial@archiver.kernel.org>; Mon, 20 Apr 2020 11:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgDTLce (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 20 Apr 2020 07:32:34 -0400
Received: from mga11.intel.com ([192.55.52.93]:61316 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725550AbgDTLce (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 20 Apr 2020 07:32:34 -0400
IronPort-SDR: PcyL/A1PiS25NhaWqHzGCrhU29Z9ttF0I4hExNHACWGjtMRUvMLO9MgzpITA7qgJBxAjzDrZ5o
 foM9R6XTT3eg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 04:32:16 -0700
IronPort-SDR: 3zrEze2YsyFUGEZ9+NjjYl+l4rlhJIpp2ZmU+YKUMcUZBFqtsaJPfzOW/w7ezQjFOdKrxDeBge
 VqsMvRqUg1LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,406,1580803200"; 
   d="scan'208";a="290056767"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002.fm.intel.com with ESMTP; 20 Apr 2020 04:32:15 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jQUev-00210R-QE; Mon, 20 Apr 2020 14:32:17 +0300
Date:   Mon, 20 Apr 2020 14:32:17 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rishi Gupta <gupt21@gmail.com>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com, robh+dt@kernel.org,
        corbet@lwn.net, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 2/4] tty/serial: ttvys: add null modem driver for
 emulation
Message-ID: <20200420113217.GR185537@smile.fi.intel.com>
References: <1587012974-21219-1-git-send-email-gupt21@gmail.com>
 <1587012974-21219-2-git-send-email-gupt21@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587012974-21219-2-git-send-email-gupt21@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Apr 16, 2020 at 10:26:12AM +0530, Rishi Gupta wrote:
> The ttyvs driver creates virtual tty devices that can be
> used with standard POSIX APIs for serial port based applications.
> The driver is used mainly for testing user space applications.
> 
> Devices can be created through device tree and through configfs.
> Various serial port events are emulated through a sysfs file.

...

> +TTYVS VIRTUAL SERIAL DRIVER
> +M:	Rishi Gupta <gupt21@gmail.com>
> +L:	linux-serial@vger.kernel.org

> +L:	linux-kernel@vger.kernel.org

Redundant. It's default for all.

> +S:	Maintained
> +F:	Documentation/admin-guide/virtual-tty-ttyvs.rst
> +F:	Documentation/devicetree/bindings/serial/ttyvs.yaml
> +F:	drivers/tty/ttyvs.c

...

> +#include <linux/init.h>
> +#include <linux/idr.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/slab.h>
> +#include <linux/wait.h>
> +#include <linux/tty.h>
> +#include <linux/tty_driver.h>
> +#include <linux/tty_flip.h>
> +#include <linux/serial.h>
> +#include <linux/sched.h>
> +#include <linux/version.h>
> +#include <linux/mutex.h>
> +#include <linux/device.h>
> +#include <linux/uaccess.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/configfs.h>

Perhaps ordered?

...

> +#define VS_CON_CTS    0x0001
> +#define VS_CON_DCD    0x0002
> +#define VS_CON_DSR    0x0004
> +#define VS_CON_RI     0x0008

> +#define VS_MCR_DTR    0x0001
> +#define VS_MCR_RTS    0x0002
> +#define VS_MCR_LOOP   0x0004

> +#define VS_MSR_CTS    0x0008
> +#define VS_MSR_DCD    0x0010
> +#define VS_MSR_RI     0x0020
> +#define VS_MSR_DSR    0x0040

> +#define VS_CRTSCTS       0x0001
> +#define VS_XON           0x0002
> +#define VS_NONE          0x0004
> +#define VS_DATA_5        0x0008
> +#define VS_DATA_6        0x0010
> +#define VS_DATA_7        0x0020
> +#define VS_DATA_8        0x0040
> +#define VS_PARITY_NONE   0x0080
> +#define VS_PARITY_ODD    0x0100
> +#define VS_PARITY_EVEN   0x0200
> +#define VS_PARITY_MARK   0x0400
> +#define VS_PARITY_SPACE  0x0800
> +#define VS_STOP_1        0x1000
> +#define VS_STOP_2        0x2000

> +#define VS_SNM 0x0001
> +#define VS_CNM 0x0002
> +#define VS_SLB 0x0003
> +#define VS_CLB 0x0004

Can you use TABs to indent?

...

> +/* Represents a virtual tty device in this virtual card */
> +struct vs_dev {
> +	/* index for this device in tty core */

Convert these comments to kernel-doc.

> +	unsigned int own_index;
> +	/* index of the device to which this device is connected */
> +	unsigned int peer_index;
> +	/* shadow modem status register */
> +	int msr_reg;
> +	/* shadow modem control register */
> +	int mcr_reg;
> +	/* rts line connections for this device */
> +	int rts_mappings;
> +	/* dtr line connections for this device */
> +	int dtr_mappings;
> +	int set_odtr_at_open;
> +	int set_pdtr_at_open;
> +	int odevtyp;
> +	/* mutual exclusion at device level */
> +	struct mutex lock;
> +	int is_break_on;
> +	/* currently active baudrate */
> +	int baud;
> +	int uart_frame;
> +	int waiting_msr_chg;
> +	int tx_paused;
> +	int faulty_cable;
> +	struct tty_struct *own_tty;
> +	struct tty_struct *peer_tty;
> +	struct serial_struct serial;
> +	struct async_icount icount;
> +	struct device *device;
> +};

...

> +static ssize_t event_store(struct device *dev,
> +		struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	int ret, push = 1;
> +	struct vs_dev *local_vsdev = dev_get_drvdata(dev);
> +	struct tty_struct *tty_to_write = local_vsdev->own_tty;
> +

> +	if (!buf || (count <= 0))

On which circumstances the count can be < 0 ?!
Have you checked when it can be 0 here? Can it at all?

> +		return -EINVAL;
> +
> +	/*
> +	 * Ensure required structure has been allocated, initialized and
> +	 * port has been opened.
> +	 */
> +	if (!tty_to_write || (tty_to_write->port == NULL)
> +			|| (tty_to_write->port->count <= 0))

Better formatting style and indentation, please.

> +		return -EIO;

When port->count can be less than zero?

> +	if (!test_bit(ASYNCB_INITIALIZED, &tty_to_write->port->flags))
> +		return -EIO;
> +
> +	mutex_lock(&local_vsdev->lock);
> +
> +	switch (buf[0]) {
> +	case '1':
> +		ret = tty_insert_flip_char(tty_to_write->port, -7, TTY_FRAME);
> +		if (ret < 0)
> +			goto fail;
> +		local_vsdev->icount.frame++;
> +		break;
> +	case '2':
> +		ret = tty_insert_flip_char(tty_to_write->port, -8, TTY_PARITY);
> +		if (ret < 0)
> +			goto fail;
> +		local_vsdev->icount.parity++;
> +		break;
> +	case '3':
> +		ret = tty_insert_flip_char(tty_to_write->port, 0, TTY_OVERRUN);
> +		if (ret < 0)
> +			goto fail;
> +		local_vsdev->icount.overrun++;
> +		break;
> +	case '4':
> +		local_vsdev->msr_reg |= VS_MSR_RI;
> +		local_vsdev->icount.rng++;
> +		push = -1;
> +		break;
> +	case '5':
> +		local_vsdev->msr_reg &= ~VS_MSR_RI;
> +		local_vsdev->icount.rng++;
> +		push = -1;
> +		break;
> +	case '6':
> +		ret = tty_insert_flip_char(tty_to_write->port, 0, TTY_BREAK);
> +		if (ret < 0)
> +			goto fail;
> +		local_vsdev->icount.brk++;
> +		break;
> +	case '7':
> +		local_vsdev->faulty_cable = 1;
> +		push = -1;
> +		break;
> +	case '8':
> +		local_vsdev->faulty_cable = 0;
> +		push = -1;
> +		break;
> +	default:
> +		mutex_unlock(&local_vsdev->lock);
> +		return -EINVAL;
> +	}
> +
> +	if (push)
> +		tty_flip_buffer_push(tty_to_write->port);
> +	ret = count;
> +
> +fail:
> +	mutex_unlock(&local_vsdev->lock);
> +	return ret;
> +}
> +static DEVICE_ATTR_WO(event);
> +
> +static struct attribute *ttyvs_attrs[] = {
> +	&dev_attr_event.attr,

> +	NULL,

No comma for terminator line.

> +};
> +ATTRIBUTE_GROUPS(ttyvs);
> +
> +/*
> + * Checks if the given serial port has received its carrier detect
> + * line raised or not. Return 1 if the carrier is raised otherwise 0.
> + */
> +static int vs_port_carrier_raised(struct tty_port *port)
> +{
> +	struct vs_dev *local_vsdev = idr_find(&db, port->tty->index);
> +

> +	return (local_vsdev->msr_reg & VS_MSR_DCD) ? 1 : 0;

Redundant ternary. Use !! if you wish to tight the values to [0..1] range, but
rather simple drop the ternary.

> +}
> +
> +/* Shutdown the given serial port */
> +static void vs_port_shutdown(struct tty_port *port)
> +{
> +	pr_debug("shutting down the port!\n");

dev_dbg()
Everywhere where you have struct device available use dev_*() instead of pr_*().

> +}

...

> +/*
> + * Update modem control and status registers according to the bit
> + * mask(s) provided. The RTS and DTR values can be set only if the
> + * current handshaking state of the tty device allows direct control
> + * of the modem control lines. The pin mappings are honoured.
> + *
> + * Caller holds lock of thegiven virtual tty device.
> + */
> +static int vs_update_modem_lines(struct tty_struct *tty,
> +			unsigned int set, unsigned int clear)
> +{
> +	int ctsint = 0;
> +	int dcdint = 0;
> +	int dsrint = 0;
> +	int rngint = 0;

> +	int mcr_ctrl_reg = 0;

Redundant assignment.
Also check other variables here, and in entire code.

> +	int wakeup_blocked_open = 0;
> +	int rts_mappings, dtr_mappings, msr_state_reg;
> +	struct async_icount *evicount;
> +	struct vs_dev *vsdev, *local_vsdev, *remote_vsdev;
> +
> +	local_vsdev = idr_find(&db, tty->index);
> +
> +	/* Read modify write MSR register */
> +	if (tty->index != local_vsdev->peer_index) {
> +		remote_vsdev = idr_find(&db, local_vsdev->peer_index);
> +		msr_state_reg = remote_vsdev->msr_reg;
> +		vsdev = remote_vsdev;
> +	} else {
> +		msr_state_reg = local_vsdev->msr_reg;
> +		vsdev = local_vsdev;
> +	}
> +
> +	rts_mappings = local_vsdev->rts_mappings;
> +	dtr_mappings = local_vsdev->dtr_mappings;
> +
> +	if (set & TIOCM_RTS) {
> +		mcr_ctrl_reg |= VS_MCR_RTS;
> +		if ((rts_mappings & VS_CON_CTS) == VS_CON_CTS) {
> +			msr_state_reg |= VS_MSR_CTS;
> +			ctsint++;
> +		}
> +		if ((rts_mappings & VS_CON_DCD) == VS_CON_DCD) {
> +			msr_state_reg |= VS_MSR_DCD;
> +			dcdint++;
> +			wakeup_blocked_open = 1;
> +		}
> +		if ((rts_mappings & VS_CON_DSR) == VS_CON_DSR) {
> +			msr_state_reg |= VS_MSR_DSR;
> +			dsrint++;
> +		}
> +		if ((rts_mappings & VS_CON_RI) == VS_CON_RI) {
> +			msr_state_reg |= VS_MSR_RI;
> +			rngint++;
> +		}
> +	}
> +
> +	if (set & TIOCM_DTR) {
> +		mcr_ctrl_reg |= VS_MCR_DTR;
> +		if ((dtr_mappings & VS_CON_CTS) == VS_CON_CTS) {
> +			msr_state_reg |= VS_MSR_CTS;
> +			ctsint++;
> +		}
> +		if ((dtr_mappings & VS_CON_DCD) == VS_CON_DCD) {
> +			msr_state_reg |= VS_MSR_DCD;
> +			dcdint++;
> +			wakeup_blocked_open = 1;
> +		}
> +		if ((dtr_mappings & VS_CON_DSR) == VS_CON_DSR) {
> +			msr_state_reg |= VS_MSR_DSR;
> +			dsrint++;
> +		}
> +		if ((dtr_mappings & VS_CON_RI) == VS_CON_RI) {
> +			msr_state_reg |= VS_MSR_RI;
> +			rngint++;
> +		}
> +	}
> +
> +	if (clear & TIOCM_RTS) {
> +		mcr_ctrl_reg &= ~VS_MCR_RTS;
> +		if ((rts_mappings & VS_CON_CTS) == VS_CON_CTS) {
> +			msr_state_reg &= ~VS_MSR_CTS;
> +			ctsint++;
> +		}
> +		if ((rts_mappings & VS_CON_DCD) == VS_CON_DCD) {
> +			msr_state_reg &= ~VS_MSR_DCD;
> +			dcdint++;
> +		}
> +		if ((rts_mappings & VS_CON_DSR) == VS_CON_DSR) {
> +			msr_state_reg &= ~VS_MSR_DSR;
> +			dsrint++;
> +		}
> +		if ((rts_mappings & VS_CON_RI) == VS_CON_RI) {
> +			msr_state_reg &= ~VS_MSR_RI;
> +			rngint++;
> +		}
> +	}
> +
> +	if (clear & TIOCM_DTR) {
> +		mcr_ctrl_reg &= ~VS_MCR_DTR;
> +		if ((dtr_mappings & VS_CON_CTS) == VS_CON_CTS) {
> +			msr_state_reg &= ~VS_MSR_CTS;
> +			ctsint++;
> +		}
> +		if ((dtr_mappings & VS_CON_DCD) == VS_CON_DCD) {
> +			msr_state_reg &= ~VS_MSR_DCD;
> +			dcdint++;
> +		}
> +		if ((dtr_mappings & VS_CON_DSR) == VS_CON_DSR) {
> +			msr_state_reg &= ~VS_MSR_DSR;
> +			dsrint++;
> +		}
> +		if ((dtr_mappings & VS_CON_RI) == VS_CON_RI) {
> +			msr_state_reg &= ~VS_MSR_RI;
> +			rngint++;
> +		}
> +	}
> +
> +	local_vsdev->mcr_reg = mcr_ctrl_reg;
> +	vsdev->msr_reg = msr_state_reg;
> +
> +	evicount = &vsdev->icount;
> +	evicount->cts += ctsint;
> +	evicount->dsr += dsrint;
> +	evicount->dcd += dcdint;
> +	evicount->rng += rngint;
> +
> +	if (vsdev->own_tty && vsdev->own_tty->port) {
> +		/* Wake up process blocked on TIOCMIWAIT ioctl */
> +		if ((vsdev->waiting_msr_chg == 1) &&
> +				(vsdev->own_tty->port->count > 0)) {
> +			wake_up_interruptible(
> +					&vsdev->own_tty->port->delta_msr_wait);
> +		}
> +
> +		/* Wake up application blocked on carrier detect signal */
> +		if ((wakeup_blocked_open == 1) &&
> +				(vsdev->own_tty->port->blocked_open > 0)) {
> +			wake_up_interruptible(&vsdev->own_tty->port->open_wait);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Invoked when user space process opens a serial port. The tty core
> + * calls this to install tty and initialize the required resources.
> + */
> +static int vs_install(struct tty_driver *drv, struct tty_struct *tty)
> +{
> +	int ret;
> +	struct tty_port *port;
> +

> +	port = kcalloc(1, sizeof(struct tty_port), GFP_KERNEL);

What the point of kcalloc(1, ...) ?

> +	if (!port)
> +		return -ENOMEM;
> +
> +	/* First initialize and then set port operations */
> +	tty_port_init(port);
> +	port->ops = &vs_port_ops;
> +
> +	ret = tty_port_install(port, drv, tty);
> +	if (ret) {
> +		kfree(port);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Invoked when there exist no user process or tty is to be
> + * released explicitly for whatever reason.
> + */
> +static void vs_cleanup(struct tty_struct *tty)
> +{
> +	tty_port_put(tty->port);
> +}
> +
> +/*
> + * Called when open system call is called on virtual tty device node.
> + * The tty core allocates 'struct tty_struct' for this device and
> + * set up various resources, sets up line discipline and call this
> + * function. For first time allocation happens and from next time
> + * onwards only re-opening happens.
> + *
> + * The tty core finds the tty driver serving this device node and the
> + * index of this tty device as registered by this driver with tty core.
> + * From this inded we retrieve the virtual tty device to work on.
> + *
> + * If the same serial port is opened more than once, the tty structure
> + * passed to this function will be same but filp structure will be
> + * different every time. Caller holds tty lock.
> + *
> + * This driver does not set CLOCAL by default. This means that the
> + * open() system call will block until it find its carrier detect
> + * line raised. Application should use O_NONBLOCK/O_NDELAY flag if
> + * it does not want to wait for DCD line change.
> + */
> +static int vs_open(struct tty_struct *tty, struct file *filp)
> +{
> +	int ret;
> +	struct vs_dev *remote_vsdev;
> +	struct vs_dev *local_vsdev = idr_find(&db, tty->index);
> +
> +	local_vsdev->own_tty = tty;
> +
> +	/*
> +	 * If this device is one end of a null modem connection,
> +	 * provide its address to remote end.
> +	 */
> +	if (tty->index != local_vsdev->peer_index) {
> +		remote_vsdev = idr_find(&db, local_vsdev->peer_index);
> +		remote_vsdev->peer_tty = tty;
> +	}
> +
> +	memset(&local_vsdev->serial, 0, sizeof(struct serial_struct));
> +	memset(&local_vsdev->icount, 0, sizeof(struct async_icount));
> +
> +	/*
> +	 * Handle DTR raising logic ourselve instead of tty_port helpers
> +	 * doing it. Locking virtual tty is not required here.
> +	 */
> +	if (local_vsdev->set_odtr_at_open == 1)
> +		vs_update_modem_lines(tty, TIOCM_DTR | TIOCM_RTS, 0);
> +
> +	/* Associate tty with port and do port level opening. */
> +	ret = tty_port_open(tty->port, tty, filp);
> +	if (ret)
> +		return ret;
> +
> +	tty->port->close_delay  = 0;
> +	tty->port->closing_wait = ASYNC_CLOSING_WAIT_NONE;
> +	tty->port->drain_delay  = 0;
> +
> +	return ret;
> +}
> +
> +/*
> + * Invoked by tty layer when release() is called on the file pointer
> + * that was previously created with a call to open().
> + */
> +static void vs_close(struct tty_struct *tty, struct file *filp)
> +{
> +	if (test_bit(TTY_IO_ERROR, &tty->flags))
> +		return;
> +
> +	if (tty && filp && tty->port && (tty->port->count > 0))
> +		tty_port_close(tty->port, tty, filp);
> +
> +	if (tty && C_HUPCL(tty) && tty->port && (tty->port->count < 1))
> +		vs_update_modem_lines(tty, 0, TIOCM_DTR | TIOCM_RTS);
> +}
> +
> +/*
> + * Invoked when write() system call is invoked on device node.
> + * This function constructs evry byte as per the current uart
> + * frame settings. Finally, the data is inserted into the tty
> + * buffer of the receiver tty device.
> + */
> +static int vs_write(struct tty_struct *tty,
> +			const unsigned char *buf, int count)
> +{
> +	int x;
> +	unsigned char *data = NULL;
> +	struct tty_struct *tty_to_write = NULL;
> +	struct vs_dev *rx_vsdev = NULL;
> +	struct vs_dev *tx_vsdev = idr_find(&db, tty->index);

> +	if (tx_vsdev->tx_paused || !tty || tty->stopped
> +			|| (count < 1) || !buf || tty->hw_stopped)

Indentation issue.
Fix in entire code.

> +		return 0;
> +
> +	if (tx_vsdev->is_break_on == 1) {
> +		pr_debug("break condition is on!\n");
> +		return -EIO;
> +	}
> +
> +	if (tx_vsdev->faulty_cable == 1)
> +		return count;
> +
> +	if (tty->index != tx_vsdev->peer_index) {
> +		/* Null modem */
> +		tty_to_write = tx_vsdev->peer_tty;
> +		rx_vsdev = idr_find(&db, tx_vsdev->peer_index);
> +
> +		if ((tx_vsdev->baud != rx_vsdev->baud) ||
> +			(tx_vsdev->uart_frame != rx_vsdev->uart_frame)) {
> +			/*
> +			 * Emulate data sent but not received due to
> +			 * mismatched baudrate/framing.
> +			 */
> +			pr_debug("mismatched serial port settings!\n");
> +			tx_vsdev->icount.tx++;
> +			return count;
> +		}
> +	} else {
> +		/* Loop back */
> +		tty_to_write = tty;
> +		rx_vsdev = tx_vsdev;
> +	}
> +
> +	if (tty_to_write) {
> +		if ((tty_to_write->termios.c_cflag & CSIZE) == CS8) {
> +			data = (unsigned char *)buf;
> +		} else {
> +			data = kcalloc(count, sizeof(char), GFP_KERNEL);
> +			if (!data)
> +				return -ENOMEM;
> +
> +			/* Emulate correct number of data bits */
> +			switch (tty_to_write->termios.c_cflag & CSIZE) {
> +			case CS7:
> +				for (x = 0; x < count; x++)
> +					data[x] = buf[x] & 0x7F;
> +				break;
> +			case CS6:
> +				for (x = 0; x < count; x++)
> +					data[x] = buf[x] & 0x3F;
> +				break;
> +			case CS5:
> +				for (x = 0; x < count; x++)
> +					data[x] = buf[x] & 0x1F;
> +				break;

> +			default:
> +				data = (unsigned char *)buf;

When this possible?

> +			}
> +		}
> +
> +		tty_insert_flip_string(tty_to_write->port, data, count);
> +		tty_flip_buffer_push(tty_to_write->port);
> +		tx_vsdev->icount.tx++;
> +		rx_vsdev->icount.rx++;
> +

> +		if (data != buf)
> +			kfree(data);

> +	} else {
> +		/*
> +		 * Other end is still not opened, emulate transmission from
> +		 * local end but don't make other end receive it as is the
> +		 * case in real world.
> +		 */
> +		tx_vsdev->icount.tx++;
> +	}
> +
> +	return count;
> +}

...

> +	info.type		    = PORT_UNKNOWN;
> +	info.line		    = serial.line;
> +	info.port		    = tty->index;
> +	info.irq			= 0;
> +	info.flags		    = tty->port->flags;
> +	info.xmit_fifo_size = 0;
> +	info.baud_base	    = 0;
> +	info.close_delay	= tty->port->close_delay;
> +	info.closing_wait   = tty->port->closing_wait;
> +	info.custom_divisor = 0;
> +	info.hub6		    = 0;
> +	info.io_type		= SERIAL_IO_MEM;

Full of indentation issues.

> +
> +	ret = copy_to_user((void __user *)arg, &info,
> +				sizeof(struct serial_struct));

Wouldn't

	if (copy_to_user(...))
		return -EFAULT;
	return 0;

work better?

> +
> +	return ret ? -EFAULT : 0;

...

> +	u32 baud;

u32? Why?

...

> +static int vs_ioctl(struct tty_struct *tty,
> +				unsigned int cmd, unsigned long arg)
> +{
> +	switch (cmd) {
> +	case TIOCGSERIAL:
> +		return vs_get_serinfo(tty, arg);
> +	case TIOCMIWAIT:
> +		return vs_wait_change(tty, arg);
> +	}
> +

> +	return -ENOIOCTLCMD;

Perhaps this should be default case above.

> +}

...

> +static void vs_throttle(struct tty_struct *tty)
> +{
> +	struct vs_dev *local_vsdev = idr_find(&db, tty->index);
> +	struct vs_dev *remote_vsdev = idr_find(&db, local_vsdev->peer_index);
> +
> +	if (tty->termios.c_cflag & CRTSCTS) {
> +		mutex_lock(&local_vsdev->lock);
> +		remote_vsdev->tx_paused = 1;
> +		vs_update_modem_lines(tty, 0, TIOCM_RTS);
> +		mutex_unlock(&local_vsdev->lock);

> +	} else if ((tty->termios.c_iflag & IXON) ||
> +				(tty->termios.c_iflag & IXOFF)) {

Indentation issues. Fix in every alike places.

> +		vs_put_char(tty, STOP_CHAR(tty));
> +	} else {
> +		/* do nothing */
> +	}
> +}

...

> +static int vs_tiocmget(struct tty_struct *tty)
> +{
> +	int status, msr_reg, mcr_reg;
> +	struct vs_dev *local_vsdev = idr_find(&db, tty->index);
> +
> +	mutex_lock(&local_vsdev->lock);
> +	mcr_reg = local_vsdev->mcr_reg;
> +	msr_reg = local_vsdev->msr_reg;
> +	mutex_unlock(&local_vsdev->lock);
> +

> +	status = ((mcr_reg & VS_MCR_DTR)  ? TIOCM_DTR  : 0) |
> +			 ((mcr_reg & VS_MCR_RTS)  ? TIOCM_RTS  : 0) |
> +			 ((mcr_reg & VS_MCR_LOOP) ? TIOCM_LOOP : 0) |
> +			 ((msr_reg & VS_MSR_DCD)  ? TIOCM_CAR  : 0) |
> +			 ((msr_reg & VS_MSR_RI)   ? TIOCM_RI   : 0) |
> +			 ((msr_reg & VS_MSR_CTS)  ? TIOCM_CTS  : 0) |
> +			 ((msr_reg & VS_MSR_DSR)  ? TIOCM_DSR  : 0);

Why not to indent by first line properly?
Fix this in all similar places.

> +	return status;
> +}

...

> +static int vs_break_ctl(struct tty_struct *tty, int break_state)
> +{
> +	struct tty_struct *tty_to_write;
> +	struct vs_dev *brk_rx_vsdev;
> +	struct vs_dev *brk_tx_vsdev = idr_find(&db, tty->index);
> +
> +	if (tty->index != brk_tx_vsdev->peer_index) {
> +		tty_to_write = brk_tx_vsdev->peer_tty;
> +		brk_rx_vsdev = idr_find(&db, brk_tx_vsdev->peer_index);
> +	} else {
> +		tty_to_write = tty;
> +		brk_rx_vsdev = brk_tx_vsdev;
> +	}
> +
> +	mutex_lock(&brk_tx_vsdev->lock);
> +

> +	if (break_state != 0) {

	if (break_state) {

> +		if (brk_tx_vsdev->is_break_on == 1)
> +			return 0;
> +
> +		brk_tx_vsdev->is_break_on = 1;
> +		if (tty_to_write != NULL) {
> +			tty_insert_flip_char(tty_to_write->port, 0, TTY_BREAK);
> +			tty_flip_buffer_push(tty_to_write->port);
> +			brk_rx_vsdev->icount.brk++;
> +		}
> +	} else {
> +		brk_tx_vsdev->is_break_on = 0;
> +	}
> +
> +	mutex_unlock(&brk_tx_vsdev->lock);
> +	return 0;
> +}

...

> +static void vs_send_xchar(struct tty_struct *tty, char ch)
> +{
> +	int was_paused;
> +	struct vs_dev *local_vsdev = idr_find(&db, tty->index);
> +
> +	was_paused = local_vsdev->tx_paused;
> +	if (was_paused)
> +		local_vsdev->tx_paused = 0;
> +
> +	vs_put_char(tty, ch);
> +	if (was_paused)
> +		local_vsdev->tx_paused = 1;


Can it be refactored like

	if (local_vsdev->tx_paused) {
		local_vsdev->tx_paused = 0;
		vs_put_char(tty, ch);
		local_vsdev->tx_paused = 1;
	} else {
		vs_put_char(tty, ch);
	}

?

> +}

...

> +static int vs_del_specific_devs(int ownidx, int free_idr)
> +{
> +	struct vs_dev *vsdev1, *vsdev2;
> +
> +	/*
> +	 * If user just created configfs item but did not populated valid
> +	 * index, device will not exist, so bail out early.
> +	 */
> +	vsdev1 = idr_find(&db, ownidx);
> +	if (!vsdev1)
> +		return 0;
> +
> +	vs_unreg_one_dev(ownidx, vsdev1);
> +
> +	/* If this device is part of a null modem, delete peer also */
> +	if (vsdev1->own_index != vsdev1->peer_index) {
> +		vsdev2 = idr_find(&db, vsdev1->peer_index);
> +		if (vsdev2) {
> +			vs_unreg_one_dev(vsdev2->own_index, vsdev2);

> +			if (free_idr)

This...

> +				idr_remove(&db, vsdev2->own_index);
> +			kfree(vsdev2);
> +		}
> +	}

> +	if (free_idr)

...and this. Can you elaborate in which case we won't free IDR?

> +		idr_remove(&db, ownidx);
> +	kfree(vsdev1);
> +
> +	return 0;
> +}

...

> +static int vs_alloc_reg_one_dev(int oidx, int pidx, int rtsmap,
> +			int dtrmap, int dtropn)
> +{
> +	int ret, id;
> +	struct vs_dev *vsdev;
> +	struct device *dev;
> +
> +	/* Allocate and init virtual tty device's private data */

> +	vsdev = kcalloc(1, sizeof(struct vs_dev), GFP_KERNEL);

What the point of kcalloc(1, ...)?

> +	if (!vsdev)
> +		return -ENOMEM;
> +
> +	id = idr_alloc(&db, vsdev, oidx, oidx + 1, GFP_KERNEL);
> +	if (id < 0) {
> +		ret = id;
> +		goto fail_id;
> +	}
> +
> +	vsdev->own_tty = NULL;
> +	vsdev->peer_tty = NULL;
> +	vsdev->own_index = oidx;
> +	vsdev->peer_index =  pidx;
> +	vsdev->rts_mappings = rtsmap;
> +	vsdev->dtr_mappings = dtrmap;
> +	vsdev->set_odtr_at_open = dtropn;
> +	vsdev->msr_reg = 0;
> +	vsdev->mcr_reg = 0;
> +	vsdev->waiting_msr_chg = 0;
> +	vsdev->tx_paused = 0;
> +	vsdev->faulty_cable = 0;
> +	mutex_init(&vsdev->lock);
> +
> +	/*
> +	 * Register with tty core with a specific minor number.
> +	 * Driver core itself will create sysfs nodes (ttyvs_groups).
> +	 */
> +	dev = tty_register_device_attr(ttyvs_driver, oidx, NULL,
> +				vsdev, ttyvs_groups);
> +	if (!dev) {
> +		ret = -ENOMEM;
> +		goto fail_reg;
> +	}
> +
> +	vsdev->device = dev;
> +	return 0;
> +
> +fail_reg:
> +	idr_remove(&db, id);
> +fail_id:
> +	kfree(vsdev);
> +	return ret;
> +}

...

> +		*dtratopen = di->pdtratopn ? 1 : 0;

> +		*dtratopen = di->odtratopn  ? 1 : 0;

Do you need ternary? (Btw, second one has indentation issues)

...

> +static int vs_extract_dev_param_dt(const struct device_node *np,
> +			unsigned int *idx, int *rtsmap, int *dtrmap,
> +			int *dtratopen, int exclude)
> +{
> +	int ret;
> +
> +	ret = of_property_read_u32(np, "dev-num", idx);
> +	if (ret)
> +		return ret;
> +
> +	if (*idx >= max_num_vs_devs)
> +		return -EINVAL;
> +
> +	ret = vs_parse_dt_get_map(np, "rtsmap", rtsmap);
> +	if (ret)
> +		return ret;
> +
> +	ret = vs_parse_dt_get_map(np, "dtrmap", dtrmap);
> +	if (ret)
> +		return ret;
> +

> +	*dtratopen = of_property_read_bool(np,
> +						"set-dtr-at-open") ? 1 : 0;

Why ternary, why two lines?

> +
> +	return 0;
> +}

...

> +fail:

fail_unlock: will better describe what you are doing here.
Same applies to other labels (revisit them all).

> +	mutex_unlock(&card_lock);
> +	return ret;

...

> +static const struct tty_operations vs_serial_ops = {
> +	.install	     = vs_install,
> +	.cleanup	     = vs_cleanup,
> +	.open	         = vs_open,
> +	.close	         = vs_close,
> +	.write	         = vs_write,
> +	.put_char	     = vs_put_char,
> +	.flush_chars     = vs_flush_chars,
> +	.write_room      = vs_write_room,
> +	.chars_in_buffer = vs_chars_in_buffer,
> +	.ioctl	         = vs_ioctl,
> +	.set_termios     = vs_set_termios,
> +	.throttle	     = vs_throttle,
> +	.unthrottle      = vs_unthrottle,
> +	.stop	         = vs_stop,
> +	.start	         = vs_start,
> +	.hangup	         = vs_hangup,
> +	.break_ctl       = vs_break_ctl,
> +	.flush_buffer    = vs_flush_buffer,
> +	.wait_until_sent = vs_wait_until_sent,
> +	.send_xchar      = vs_send_xchar,
> +	.tiocmget	     = vs_tiocmget,
> +	.tiocmset	     = vs_tiocmset,
> +	.get_icount      = vs_get_icount,
> +};

Your code has enormous amount of indentation issues. Please, fix your editor
settings or do something about it.

...

> +		if (of_property_read_u32(child, "peer-dev", &peer)) {
> +			ret = vs_add_lb(NULL, child);
> +			if (ret) {
> +				pr_err("can't create lb %s %d\n",
> +						child->name, ret);
> +				continue;
> +			}
> +		} else {

> +			peer_node = of_find_node_by_phandle(peer);
> +			if (peer_node) {
> +				of_node_set_flag(peer_node, OF_POPULATED);
> +				ret = vs_add_nm(NULL, child, peer_node);
> +				if (ret) {
> +					pr_err("can't create nm %s <-> %s %d\n",
> +						child->name, peer_node->name,
> +						ret);
> +					continue;
> +				}
> +			} else {
> +				pr_err("can't find peer for %s %d\n",
> +						child->name, ret);
> +			}

Besides pr_err(), I guess should be dev_err() or so, above looks like OF voodoo
magic which I believe already implemented in OF framework. Care to think about
it?

> +		}

...

> +	return container_of(to_config_group(item),
> +				struct vs_cfs_dev_info, grp);

It's perfectly one line. Why two?

...

> +static ssize_t vs_dev_create_store(struct config_item *item,
> +		const char *page, size_t len)
> +{
> +	u8 val;
> +	int ret;
> +	struct vs_cfs_dev_info *di;
> +
> +	ret = kstrtou8(page, 0, &val);
> +	if (ret)
> +		return ret;
> +
> +	/* User must write 1 to this node create device */
> +	if (val != 1)
> +		return -EINVAL;

Why above it's not boolean? Why this doesn't accept 0?
Can't you simple ignore 'false' case?

> +
> +	di = to_vs_dinfo(item);
> +
> +	/* devtype must be defined to proceed further */
> +	if (!di->devtype)
> +		return -EINVAL;
> +
> +	if (strncmp(di->devtype, "lb", 2) == 0)
> +		ret = vs_add_lb(di, NULL);
> +	else if (strncmp(di->devtype, "nm", 2) == 0)
> +		ret = vs_add_nm(di, NULL, NULL);
> +	else
> +		return -EINVAL;


match_string() / sysfs_match_string() ?

> +	if (ret)
> +		return ret;
> +	return len;
> +}

...

> +VS_DEV_ATTR_WR_STR(devtype)
> +VS_DEV_ATTR_WR_U16(ownidx)
> +VS_DEV_ATTR_WR_U16(peeridx)
> +VS_DEV_ATTR_WR_U8(ortsmap)
> +VS_DEV_ATTR_WR_U8(odtrmap)
> +VS_DEV_ATTR_WR_U8(odtratopn)
> +VS_DEV_ATTR_WR_U8(prtsmap)
> +VS_DEV_ATTR_WR_U8(pdtrmap)
> +VS_DEV_ATTR_WR_U8(pdtratopn)

Where are semicolons? Above looks fragile.

...

> +static struct configfs_attribute *vs_dev_attrs[] = {
> +	&vs_dev_attr_devtype,
> +	&vs_dev_attr_ownidx,
> +	&vs_dev_attr_ortsmap,
> +	&vs_dev_attr_odtrmap,
> +	&vs_dev_attr_odtratopn,
> +	&vs_dev_attr_peeridx,
> +	&vs_dev_attr_prtsmap,
> +	&vs_dev_attr_pdtrmap,
> +	&vs_dev_attr_pdtratopn,
> +	&vs_dev_attr_create,

> +	NULL,

No comma for terminator line.

> +};

> +/*
> + * By default this driver supports upto 64 virtual devices. This
> + * can be overridden through max_num_vs_devs module parameter or
> + * through max-num-vs-devs device tree property.
> + */
> +module_param(max_num_vs_devs, ushort, 0);
> +MODULE_PARM_DESC(max_num_vs_devs,
> +		"Maximum virtual tty devices to be supported");

Can't you update this dynamically thru sysfs?

-- 
With Best Regards,
Andy Shevchenko


