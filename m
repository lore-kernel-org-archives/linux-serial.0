From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: [PATCH V4 2/2] serial: rp2: New driver for Comtrol RocketPort 2
 cards
Date: Tue, 19 Feb 2013 19:40:44 +0000 (UTC)
Message-ID: <kg0kfr$748$1@ger.gmane.org>
References: <1ee681e19fb4ce83f2a133c35fe635ae@localhost>
 <cddfa2c3b23f14c35109a07544c6a2bf@localhost>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:44282 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933049Ab3BSTlE (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 19 Feb 2013 14:41:04 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1U7t42-00063d-0W
	for linux-serial@vger.kernel.org; Tue, 19 Feb 2013 20:41:18 +0100
Received: from dsl.comtrol.com ([64.122.56.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Tue, 19 Feb 2013 20:41:17 +0100
Received: from grant.b.edwards by dsl.comtrol.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Tue, 19 Feb 2013 20:41:17 +0100
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On 2013-01-17, Kevin Cernekee <cernekee@gmail.com> wrote:

> This driver supports the RocketPort EXPRESS and RocketPort INFINITY
> families of PCI/PCIe multiport serial adapters.  These adapters use a
> "RocketPort 2" ASIC that is not compatible with the original
> RocketPort driver (CONFIG_ROCKETPORT).

Hi, i've been doing some work on this driver, and wanted to share the
results.  The changes I've made to date are

 * Add code for backwards compatibilty back to 2.6.25.  The goal is
   still 2.6.18, but further backwards compatibility work has been
   postponed.

 * Add compile-time option to use built-in microcode.  I'm afraid
   adding a dependancy on a working firmware subsystem was too risky.

 * Enable use of rx FIFO.  Use of interrupt-per-byte mode is not
   feasible at higher baud rates.  The interrupt-per-byte mode can be
   selected at run-time by setting the "low_latency" flag on the tty
   device.

 * Add support for RS422, RS232-half-duplex, and RS485 modes.  Modes
   are set at module load time by "port_modes" module parameter.  [I'm
   not fond of the format of the parameter value string, but I'm stuck
   with it due to backwards compatibility requirements.]

 * Finished hardware Xon/Xoff flow control support.

 * Disable hardware Xon/Xoff flow control support because bug in
   serial_core prevents it from working.

 * Add board descriptions so that syslog and /proc/tty/driver/rp2 will
   show which serial ports are assigned to which boards. [This is
   important to some customers and to support staff.]

 * Add polled mode and make it the default.  Interrupt vs. polling
   (and polling frequency) are controlled at load time by polling_mode
   module parameter.  [The old driver ran in polled mode, and the
   default behavior for the new one needs to match the old driver.]

 * Stop pushing rx data to tty when there's no room left.  This is
   required in order to allow hardware flow control to work.

 * Add Comtrol as module author.

Kevin, let me know if you'd like your name and/or e-mail address
removed from the source file (either in the comments or in the
MODULE_AUTHOR macro).  I know that getting e-mails asking about bugs
in somebody elses code can get old.
 
I realize that things like backwards compatibility stuff and the
internal firmware aren't welcome in the kernel source tree, but I'm
afraid they're required by many of my customers.  Here's a snapshot of
my version of the driver. Below that, there's a description of module
parameters.

=================================rp2.c=========================================
/*
 * Driver for Comtrol RocketPort EXPRESS/INFINITY cards
 *
 * Copyright (C) 2012 Kevin Cernekee <cernekee@gmail.com>
 *
 * Updates and modifications by Comtrol Corp.
 *
 * Inspired by, and loosely based on:
 *
 *   ar933x_uart.c
 *     Copyright (C) 2011 Gabor Juhos <juhosg@openwrt.org>
 *
 *   rocketport_infinity_express-linux-1.20.tar.gz
 *     Copyright (C) 2004-2011 Comtrol, Inc.
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License version 2 as published
 * by the Free Software Foundation.
 */

#include <linux/bitops.h>
#include <linux/compiler.h>
#include <linux/completion.h>
#include <linux/console.h>
#include <linux/delay.h>
#include <linux/firmware.h>
#include <linux/init.h>
#include <linux/io.h>
#include <linux/ioport.h>
#include <linux/irq.h>
#include <linux/kernel.h>
#include <linux/log2.h>
#include <linux/module.h>
#include <linux/pci.h>
#include <linux/serial.h>
#include <linux/serial_core.h>
#include <linux/slab.h>
#include <linux/sysrq.h>
#include <linux/tty.h>
#include <linux/tty_flip.h>
#include <linux/types.h>

#define USE_INTERNAL_FIRMWARE 1
#define DEBUG_PORT_MODES 0

#define TraceLine(fmt, ...) printk(KERN_INFO "nslink: Trace %s():%d " fmt "\n", __FUNCTION__, __LINE__, ##__VA_ARGS__)

//======================================================================
// start of backwards compatibilty stuff
#include <linux/version.h>

#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,25)
# error "======================================================="
# error "== Sorry: kernel too old -- 2.6.25 or newer required =="
# error "======================================================="
#endif

#if !defined(BIT)
# define BIT(n) (1<<(n))
#endif

#if !defined PORT_RP2
# define PORT_RP2 102
#endif

#if !defined(CONFIG_SERIAL_RP2_NR_UARTS)
# define CONFIG_SERIAL_RP2_NR_UARTS 128
#endif

#if !defined(for_each_set_bit)
# define for_each_set_bit(bit, addr, size)                 \
    for ((bit) = find_first_bit((addr), (size));            \
       (bit) < (size);                                    \
       (bit) = find_next_bit((addr), (size), (bit) + 1))
#endif

#if !defined DEFINE_PCI_DEVICE_TABLE
#define DEFINE_PCI_DEVICE_TABLE(_table) \
    const struct pci_device_id _table[] __devinitdata
#endif

#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,33)
# define request_firmware_nowait(module, uevent, name, device, gfp, context, cont) \
    request_firmware_nowait(module, uevent, name, device, context, cont)
# define release_firmware(fw) \
    // continuation functions don't release firmware prior to 2.6.33
#endif

// macros to handle things that have moved around in the serial_core/tty API
#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,32)
# define rp2_state(up)           up->port.info
# define rp2_tty(up)             up->port.info->tty
# define rp2_delta_msr_wait(up)  up->port.info->delta_msr_wait
#else
# define rp2_state(up)           up->port.state
# define rp2_tty(up)             up->port.state->port.tty
# define rp2_delta_msr_wait(up)  up->port.state->port.delta_msr_wait
#endif

#if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
# define rp2_tty_flip_buffer_push(up) tty_flip_buffer_push(rp2_tty(up))
#else
# define rp2_flip_buffer_push(up) tty_flip_buffer_push(up->port.state->port)
#endif

// end of backwards compatibility stuff
//======================================================================


//======================================================================
// To avoid problems with old distros/kernels, use internal firmware blob
#if USE_INTERNAL_FIRMWARE
static u8 rp2_firmware_blob[] = {
        0xF6, 0x8B, 0x9D, 0xC4, 0x13, 0xC4, 0x11, 0x98,   /* 0x00 */
        0x20, 0x0A, 0x21, 0x0A, 0x8D, 0xFA, 0x86, 0x01,   /* 0x08 */
        0x40, 0x11, 0x19, 0x0A, 0x00, 0x40, 0x13, 0x19,   /* 0x10 */
        0x0A, 0xFA, 0x83, 0x01, 0x0A, 0x00, 0x0A, 0x41,   /* 0x18 */
        0xFF, 0x89, 0xC2, 0x66, 0x86, 0x81, 0x91, 0x40,   /* 0x20 */
        0x65, 0x8E, 0x89, 0xC2, 0x66, 0x86, 0x81, 0x88,   /* 0x28 */
        0x40, 0x65, 0x85, 0x84, 0x00, 0x82, 0x0A, 0x08,   /* 0x30 */
        0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x08, 0x0A          /* 0x38 */
};
static struct firmware rp2_firmware = {
        .size = sizeof rp2_firmware_blob,
        .data = rp2_firmware_blob,
};
#endif
//
//======================================================================

#define DRV_VERS                        "2.00"
#define DRV_NAME			"rp2"

#define RP2_FW_NAME			"rp2.fw"
#define RP2_UCODE_BYTES			0x3f

#define PORTS_PER_ASIC			16
#define ALL_PORTS_MASK			(BIT(PORTS_PER_ASIC) - 1)

#define UART_CLOCK			44236800
#define DEFAULT_BAUD_DIV		(UART_CLOCK / (9600 * 16))
#define FIFO_SIZE			512

/* BAR0 registers */
#define RP2_FPGA_CTL0			0x110
#define RP2_FPGA_CTL1			0x11c
#define RP2_IRQ_MASK			0x1ec
#define RP2_IRQ_MASK_EN_m		BIT(0)
#define RP2_IRQ_STATUS			0x1f0

/* BAR1 registers */
#define RP2_ASIC_SPACING		0x1000
#define RP2_ASIC_OFFSET(i)		((i) << ilog2(RP2_ASIC_SPACING))

#define RP2_PORT_BASE			0x000
#define RP2_PORT_SPACING		0x040

#define RP2_UCODE_BASE			0x400
#define RP2_UCODE_SPACING		0x80

#define RP2_CLK_PRESCALER		0xc00
#define RP2_CH_IRQ_STAT			0xc04
#define RP2_CH_IRQ_MASK			0xc08
#define RP2_ASIC_IRQ			0xd00
#define RP2_ASIC_IRQ_EN_m		BIT(20)
#define RP2_GLOBAL_CMD			0xd0c
#define RP2_ASIC_CFG			0xd04

/* port registers */
#define RP2_DATA_DWORD			0x000

#define RP2_DATA_BYTE			0x008
#define RP2_DATA_BYTE_ERR_PARITY_m	BIT(8)
#define RP2_DATA_BYTE_ERR_OVERRUN_m	BIT(9)
#define RP2_DATA_BYTE_ERR_FRAMING_m	BIT(10)
#define RP2_DATA_BYTE_BREAK_m		BIT(11)

/* This lets uart_insert_char() drop bytes received on a !CREAD port */
#define RP2_DUMMY_READ			BIT(16)

#define RP2_DATA_BYTE_EXCEPTION_MASK	(RP2_DATA_BYTE_ERR_PARITY_m | \
					 RP2_DATA_BYTE_ERR_OVERRUN_m | \
					 RP2_DATA_BYTE_ERR_FRAMING_m | \
					 RP2_DATA_BYTE_BREAK_m)

#define RP2_RX_FIFO_COUNT		0x00c
#define RP2_TX_FIFO_COUNT		0x00e

#define RP2_CHAN_STAT			0x010
#define RP2_CHAN_STAT_RXDATA_m		BIT(0)
#define RP2_CHAN_STAT_DCD_m		BIT(3)
#define RP2_CHAN_STAT_DSR_m		BIT(4)
#define RP2_CHAN_STAT_CTS_m		BIT(5)
#define RP2_CHAN_STAT_RI_m		BIT(6)
#define RP2_CHAN_STAT_OVERRUN_m		BIT(13)
#define RP2_CHAN_STAT_DSR_CHANGED_m	BIT(16)
#define RP2_CHAN_STAT_CTS_CHANGED_m	BIT(17)
#define RP2_CHAN_STAT_CD_CHANGED_m	BIT(18)
#define RP2_CHAN_STAT_RI_CHANGED_m	BIT(22)
#define RP2_CHAN_STAT_TXEMPTY_m		BIT(25)

#define RP2_CHAN_STAT_MS_CHANGED_MASK	(RP2_CHAN_STAT_DSR_CHANGED_m | \
					 RP2_CHAN_STAT_CTS_CHANGED_m | \
					 RP2_CHAN_STAT_CD_CHANGED_m | \
					 RP2_CHAN_STAT_RI_CHANGED_m)

#define RP2_TXRX_CTL			0x014
#define RP2_TXRX_CTL_MSRIRQ_m		BIT(0)
#define RP2_TXRX_CTL_RXIRQ_m		BIT(2)
#define RP2_TXRX_CTL_RX_TRIG_s		3
#define RP2_TXRX_CTL_RX_TRIG_m		(0x3 << RP2_TXRX_CTL_RX_TRIG_s)
#define RP2_TXRX_CTL_RX_TRIG_1		(0x1 << RP2_TXRX_CTL_RX_TRIG_s)
#define RP2_TXRX_CTL_RX_TRIG_256	(0x2 << RP2_TXRX_CTL_RX_TRIG_s)
#define RP2_TXRX_CTL_RX_TRIG_448	(0x3 << RP2_TXRX_CTL_RX_TRIG_s)
#define RP2_TXRX_CTL_RX_EN_m		BIT(5)
#define RP2_TXRX_CTL_RTSFLOW_m		BIT(6)
#define RP2_TXRX_CTL_DTRFLOW_m		BIT(7)
#define RP2_TXRX_CTL_RX_TMOUTIRQ_m      BIT(9)
#define RP2_TXRX_CTL_TX_TRIG_s		16
#define RP2_TXRX_CTL_TX_TRIG_m		(0x3 << RP2_TXRX_CTL_RX_TRIG_s)
#define RP2_TXRX_CTL_DSRFLOW_m		BIT(18)
#define RP2_TXRX_CTL_TXIRQ_m		BIT(19)
#define RP2_TXRX_CTL_TX_FIFO_INT_EN_m   BIT(20)
#define RP2_TXRX_CTL_RTS_POLARITY_m     BIT(21)
#define RP2_TXRX_CTL_RTS_TOGGLE_m       BIT(22)
#define RP2_TXRX_CTL_CTSFLOW_m		BIT(23)
#define RP2_TXRX_CTL_TX_EN_m		BIT(24)
#define RP2_TXRX_CTL_RTS_m		BIT(25)
#define RP2_TXRX_CTL_DTR_m		BIT(26)
#define RP2_TXRX_CTL_LOOP_m		BIT(27)
#define RP2_TXRX_CTL_BREAK_m		BIT(28)
#define RP2_TXRX_CTL_CMSPAR_m		BIT(29)
#define RP2_TXRX_CTL_nPARODD_m		BIT(30)
#define RP2_TXRX_CTL_PARENB_m		BIT(31)

#define RP2_UART_CTL			0x018
#define RP2_UART_CTL_MODE_m             0x7
#define RP2_UART_CTL_MODE_rs232         0x1
#define RP2_UART_CTL_MODE_rs422         0x2
#define RP2_UART_CTL_MODE_rs485m	0x2
#define RP2_UART_CTL_MODE_rs485s	0x3
#define RP2_UART_CTL_MODE_rs485         0x4
#define RP2_UART_CTL_FLUSH_RX_m		BIT(3)
#define RP2_UART_CTL_FLUSH_TX_m		BIT(4)
#define RP2_UART_CTL_RESET_CH_m		BIT(5)
#define RP2_UART_CTL_XMIT_EN_m		BIT(6)
#define RP2_UART_CTL_DATABITS_s		8
#define RP2_UART_CTL_DATABITS_m		(0x3 << RP2_UART_CTL_DATABITS_s)
#define RP2_UART_CTL_DATABITS_8		(0x3 << RP2_UART_CTL_DATABITS_s)
#define RP2_UART_CTL_DATABITS_7		(0x2 << RP2_UART_CTL_DATABITS_s)
#define RP2_UART_CTL_DATABITS_6		(0x1 << RP2_UART_CTL_DATABITS_s)
#define RP2_UART_CTL_DATABITS_5		(0x0 << RP2_UART_CTL_DATABITS_s)
#define RP2_UART_CTL_STOPBITS_m		BIT(10)

#define RP2_BAUD			0x01c

/* ucode registers */
#define RP2_TX_SWFLOW			0x02
#define RP2_TX_SWFLOW_ena		0x81
#define RP2_TX_SWFLOW_dis		0x9d

#define RP2_RX_SWFLOW			0x0c
#define RP2_RX_SWFLOW_ena		0x81
#define RP2_RX_SWFLOW_dis		0x8d

#define RP2_TX_XOFF_CHAR                0x11
#define RP2_RX_XOFF_CHAR                0x04
#define RP2_TX_XON_CHAR                 0x16
#define RP2_RX_XON_CHAR                 0x06

#define RP2_XANY                        0x07
#define RP2_XANY_ena                    0x83
#define RP2_XANY_dis                    0x98

#define RP2_RX_FIFO			0x37
#define RP2_RX_FIFO_ena			0x08
#define RP2_RX_FIFO_dis			0x81

static struct uart_driver rp2_uart_driver = {
        .owner        = THIS_MODULE,
        .driver_name  = DRV_NAME,
        .dev_name     = "ttyRP",
        .nr           = CONFIG_SERIAL_RP2_NR_UARTS,
};

struct rp2_card;

struct rp2_uart_port {
        struct uart_port		port;
        int				idx;
        int				active;
        const struct port_mode        *mode;
        struct rp2_card		*card;
        void __iomem			*asic_base;
        void __iomem			*base;
        void __iomem			*ucode;
};

struct rp2_card {
        struct pci_dev		*pdev;
        struct rp2_uart_port		*ports;
        int				n_ports;
        int				initialized_ports;
        int				minor_start;
        int				smpte;
        void __iomem			*bar0;
        void __iomem			*bar1;
        spinlock_t			card_lock;
        bool                          shutting_down;
        const char *                  description;
        struct completion		fw_loaded;
        struct timer_list             poll_timer;
};

static const char *board_description(unsigned device_id);

// map three-character mode abbreviation strings from port_modes module
// parameter string into mode control bits and descriptive strings

static char* port_modes;

static struct port_mode {
        const char *abbrev;      // 3-letter abbreviation specified in portMode modle param
        unsigned    modebits;    // mode control bits for TX control register
        unsigned    rtstoggle;   // RTS toggle enable bit
        unsigned    rtspolarity; // RTS polarity bit
        const char *modestr;
} port_mode_tbl[] = {
        {"232", RP2_UART_CTL_MODE_rs232,  0,                         0,                           "rs232"},     // default
        {"233", RP2_UART_CTL_MODE_rs232,  RP2_TXRX_CTL_RTS_TOGGLE_m, 0,                           "rs232 half-duplex"},
        {"422", RP2_UART_CTL_MODE_rs422,  0,                         0,                           "rs422"},
        {"485", RP2_UART_CTL_MODE_rs485,  RP2_TXRX_CTL_RTS_TOGGLE_m, RP2_TXRX_CTL_RTS_POLARITY_m, "rs485 2-wire"},
        {"486", RP2_UART_CTL_MODE_rs485s, RP2_TXRX_CTL_RTS_TOGGLE_m, RP2_TXRX_CTL_RTS_POLARITY_m, "rs485 4-wire slave"},
        {"487", RP2_UART_CTL_MODE_rs485m, 0,                         0,                           "rs485 4-wire master"},
        {NULL, 0, 0, 0, NULL}
};

#define DEFAULT_MODE (&port_mode_tbl[0])
#define SMPTE_MODE (&port_mode_tbl[2])

static const struct port_mode *get_port_mode(int line) {
        char tmp[4];
        const char *ms;
        const struct port_mode *mp;

        if (!port_modes || strlen(port_modes) <= line*3)
                return DEFAULT_MODE;

        ms = port_modes+(line*3);

        for (mp = port_mode_tbl; mp->abbrev; ++mp)
                if (!strncmp(ms,mp->abbrev,3))
                        return mp;

        strlcpy(tmp,ms,sizeof tmp);
        printk(KERN_WARNING "rp2: mode '%s' for port %d unrecognized -- defaulting to rs232\n", tmp, line);
        return DEFAULT_MODE;
}

#define RP_ID(prod) PCI_VDEVICE(RP, (prod))
#define RP_CAP(ports, smpte) (((ports) << 8) | ((smpte) << 0))

static inline void rp2_decode_cap(const struct pci_device_id *id,
                                  int *ports, int *smpte)
{
        *ports = id->driver_data >> 8;
        *smpte = id->driver_data & 0xff;
}

static DEFINE_SPINLOCK(rp2_minor_lock);
static int rp2_minor_next;

static int polling_mode = 100;  // 0 is interrupt-mode, >0 is polling freq (Hz)
static int polling_jiffies; // jiffies per polling cycle

static int rp2_alloc_ports(int n_ports)
{
        int ret = -ENOSPC;

        spin_lock(&rp2_minor_lock);
        if (rp2_minor_next + n_ports <= CONFIG_SERIAL_RP2_NR_UARTS) {
                /* sorry, no support for hot unplugging individual cards */
                ret = rp2_minor_next;
                rp2_minor_next += n_ports;
        }
        spin_unlock(&rp2_minor_lock);

        return ret;
}

static inline struct rp2_uart_port *port_to_up(struct uart_port *port) {
        return container_of(port, struct rp2_uart_port, port);
}

static void rp2_rmw(struct rp2_uart_port *up, int reg,
                    u32 clr_bits, u32 set_bits)
{
        u32 tmp = readl(up->base + reg);
        tmp &= ~clr_bits;
        tmp |= set_bits;
        writel(tmp, up->base + reg);
}

static void rp2_rmw_clr(struct rp2_uart_port *up, int reg, u32 val)
{
        rp2_rmw(up, reg, val, 0);
}

static void rp2_rmw_set(struct rp2_uart_port *up, int reg, u32 val)
{
        rp2_rmw(up, reg, 0, val);
}

static void rp2_mask_ch_irq(struct rp2_uart_port *up, int ch_num,
                            int is_enabled)
{
        unsigned long flags, irq_mask;

        spin_lock_irqsave(&up->card->card_lock, flags);

        irq_mask = readl(up->asic_base + RP2_CH_IRQ_MASK);
        if (is_enabled)
                irq_mask &= ~BIT(ch_num);
        else
                irq_mask |= BIT(ch_num);
        writel(irq_mask, up->asic_base + RP2_CH_IRQ_MASK);

        spin_unlock_irqrestore(&up->card->card_lock, flags);
}

static unsigned int rp2_uart_tx_empty(struct uart_port *port)
{
        struct rp2_uart_port *up = port_to_up(port);
        unsigned long tx_fifo_bytes, flags;

        /*
         * This should probably check the transmitter, not the FIFO.
         * But the TXEMPTY bit doesn't seem to work unless the TX IRQ is
         * enabled.
         */
        spin_lock_irqsave(&up->port.lock, flags);
        tx_fifo_bytes = readw(up->base + RP2_TX_FIFO_COUNT);
        spin_unlock_irqrestore(&up->port.lock, flags);

        return tx_fifo_bytes ? 0 : TIOCSER_TEMT;
}

static unsigned int rp2_uart_get_mctrl(struct uart_port *port)
{
        struct rp2_uart_port *up = port_to_up(port);
        u32 status;

        status = readl(up->base + RP2_CHAN_STAT);
        return ((status & RP2_CHAN_STAT_DCD_m) ? TIOCM_CAR : 0) |
               ((status & RP2_CHAN_STAT_DSR_m) ? TIOCM_DSR : 0) |
               ((status & RP2_CHAN_STAT_CTS_m) ? TIOCM_CTS : 0) |
               ((status & RP2_CHAN_STAT_RI_m) ? TIOCM_RI : 0);
}

static void rp2_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
{
        rp2_rmw(port_to_up(port), RP2_TXRX_CTL,
                RP2_TXRX_CTL_DTR_m | RP2_TXRX_CTL_RTS_m | RP2_TXRX_CTL_LOOP_m,
                ((mctrl & TIOCM_DTR) ? RP2_TXRX_CTL_DTR_m : 0) |
                ((mctrl & TIOCM_RTS) ? RP2_TXRX_CTL_RTS_m : 0) |
                ((mctrl & TIOCM_LOOP) ? RP2_TXRX_CTL_LOOP_m : 0));
}

static void rp2_uart_start_tx(struct uart_port *port)
{
        rp2_rmw_set(port_to_up(port), RP2_TXRX_CTL, RP2_TXRX_CTL_TXIRQ_m);
}

static void rp2_uart_stop_tx(struct uart_port *port)
{
        rp2_rmw_clr(port_to_up(port), RP2_TXRX_CTL, RP2_TXRX_CTL_TXIRQ_m);
}

static void rp2_uart_stop_rx(struct uart_port *port)
{
        rp2_rmw_clr(port_to_up(port), RP2_TXRX_CTL, RP2_TXRX_CTL_RXIRQ_m);
}

static void rp2_uart_break_ctl(struct uart_port *port, int break_state)
{
        unsigned long flags;

        spin_lock_irqsave(&port->lock, flags);
        rp2_rmw(port_to_up(port), RP2_TXRX_CTL, RP2_TXRX_CTL_BREAK_m,
                break_state ? RP2_TXRX_CTL_BREAK_m : 0);
        spin_unlock_irqrestore(&port->lock, flags);
}

static void rp2_uart_enable_ms(struct uart_port *port)
{
        rp2_rmw_set(port_to_up(port), RP2_TXRX_CTL, RP2_TXRX_CTL_MSRIRQ_m);
}

static void __rp2_uart_set_termios(struct rp2_uart_port *up,
                                   unsigned long cfl,
                                   unsigned long ifl,
                                   cc_t *c_cc,
                                   unsigned int baud_div)
{
        /* baud rate divisor (calculated elsewhere).  0 = divide-by-1 */
        writew(baud_div - 1, up->base + RP2_BAUD);

        /* data bits and stop bits */
        rp2_rmw(up, RP2_UART_CTL,
                RP2_UART_CTL_STOPBITS_m | RP2_UART_CTL_DATABITS_m,
                ((cfl & CSTOPB) ? RP2_UART_CTL_STOPBITS_m : 0) |
                (((cfl & CSIZE) == CS8) ? RP2_UART_CTL_DATABITS_8 : 0) |
                (((cfl & CSIZE) == CS7) ? RP2_UART_CTL_DATABITS_7 : 0) |
                (((cfl & CSIZE) == CS6) ? RP2_UART_CTL_DATABITS_6 : 0) |
                (((cfl & CSIZE) == CS5) ? RP2_UART_CTL_DATABITS_5 : 0));

        /* parity and hardware flow control */
        rp2_rmw(up, RP2_TXRX_CTL,
                RP2_TXRX_CTL_PARENB_m | RP2_TXRX_CTL_nPARODD_m |
                RP2_TXRX_CTL_CMSPAR_m | RP2_TXRX_CTL_DTRFLOW_m |
                RP2_TXRX_CTL_DSRFLOW_m | RP2_TXRX_CTL_RTSFLOW_m |
                RP2_TXRX_CTL_CTSFLOW_m,
                ((cfl & PARENB) ? RP2_TXRX_CTL_PARENB_m : 0) |
                ((cfl & PARODD) ? 0 : RP2_TXRX_CTL_nPARODD_m) |
                ((cfl & CMSPAR) ? RP2_TXRX_CTL_CMSPAR_m : 0) |
                ((cfl & CRTSCTS) ? (RP2_TXRX_CTL_RTSFLOW_m |
                                    RP2_TXRX_CTL_CTSFLOW_m) : 0));
        if (0) {
                // Hardware xon/xoff support currently can not be used because
                // of overly "clever" serial_core code that hides some termios
                // changes from us -- but here's how it should work if
                // serial_core gets fixed:

                if (c_cc) {
                        writeb(c_cc[VSTOP], up->ucode+RP2_TX_XOFF_CHAR);
                        writeb(c_cc[VSTOP], up->ucode+RP2_RX_XOFF_CHAR);
                        writeb(c_cc[VSTART], up->ucode+RP2_TX_XON_CHAR);
                        writeb(c_cc[VSTART], up->ucode+RP2_RX_XON_CHAR);
                }

                writeb((ifl & IXANY) ? RP2_XANY_ena : RP2_XANY_dis, up->ucode+RP2_XANY);
                writeb((ifl & IXON ) ? RP2_TX_SWFLOW_ena : RP2_TX_SWFLOW_dis, up->ucode + RP2_TX_SWFLOW);
                writeb((ifl & IXOFF) ? RP2_RX_SWFLOW_ena : RP2_RX_SWFLOW_dis, up->ucode + RP2_RX_SWFLOW);
        }
}

static void rp2_uart_set_termios(struct uart_port *port,
                                 struct ktermios *new,
                                 struct ktermios *old)
{
        struct rp2_uart_port *up = port_to_up(port);
        unsigned long flags;
        unsigned int baud, baud_div;

        baud = uart_get_baud_rate(port, new, old, 0, port->uartclk / 16);
        baud_div = uart_get_divisor(port, baud);

        if (tty_termios_baud_rate(new))
                tty_termios_encode_baud_rate(new, baud, baud);

        spin_lock_irqsave(&port->lock, flags);

        /* ignore all characters if CREAD is not set */
        port->ignore_status_mask = (new->c_cflag & CREAD) ? 0 : RP2_DUMMY_READ;

        __rp2_uart_set_termios(up, new->c_cflag, new->c_iflag, new->c_cc, baud_div);
        uart_update_timeout(port, new->c_cflag, baud);

        spin_unlock_irqrestore(&port->lock, flags);
}

static void rp2_rx_chars(struct rp2_uart_port *up)
{
        u16 bytes = readw(up->base + RP2_RX_FIFO_COUNT);
        struct tty_struct *tty = rp2_tty(up);

        if (bytes > tty->receive_room)
                bytes = tty->receive_room;

        for (; bytes != 0; bytes--) {
                u32 byte = readw(up->base + RP2_DATA_BYTE) | RP2_DUMMY_READ;
                char ch = byte & 0xff;

                if (likely(!(byte & RP2_DATA_BYTE_EXCEPTION_MASK))) {
                        if (!uart_handle_sysrq_char(&up->port, ch))
                                uart_insert_char(&up->port, byte, 0, ch,
                                                 TTY_NORMAL);
                } else {
                        char flag = TTY_NORMAL;

                        if (byte & RP2_DATA_BYTE_BREAK_m)
                                flag = TTY_BREAK;
                        else if (byte & RP2_DATA_BYTE_ERR_FRAMING_m)
                                flag = TTY_FRAME;
                        else if (byte & RP2_DATA_BYTE_ERR_PARITY_m)
                                flag = TTY_PARITY;
                        uart_insert_char(&up->port, byte,
                                         RP2_DATA_BYTE_ERR_OVERRUN_m, ch, flag);
                }
                up->port.icount.rx++;
        }

        rp2_tty_flip_buffer_push(up);
}


static void rp2_tx_chars(struct rp2_uart_port *up)
{
        u16 max_tx = FIFO_SIZE - readw(up->base + RP2_TX_FIFO_COUNT);
        struct circ_buf *xmit = &rp2_state(up)->xmit;

        if (uart_tx_stopped(&up->port)) {
                rp2_uart_stop_tx(&up->port);
                return;
        }

        for (; max_tx != 0; max_tx--) {
                if (up->port.x_char) {
                        writeb(up->port.x_char, up->base + RP2_DATA_BYTE);
                        up->port.x_char = 0;
                        up->port.icount.tx++;
                        continue;
                }
                if (uart_circ_empty(xmit)) {
                        rp2_uart_stop_tx(&up->port);
                        break;
                }
                writeb(xmit->buf[xmit->tail], up->base + RP2_DATA_BYTE);
                xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
                up->port.icount.tx++;
        }

        if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
                uart_write_wakeup(&up->port);
}

static void rp2_ch_interrupt(struct rp2_uart_port *up)
{
        u32 status;


        spin_lock(&up->port.lock);
        if (!up->active) {
                spin_unlock(&up->port.lock);
                return;
        }

        // The IRQ status bits are clear-on-write.  Other status bits in
        // this register aren't, so it's harmless to write to them.

        status = readl(up->base + RP2_CHAN_STAT);
        writel(status, up->base + RP2_CHAN_STAT);

        if (status & RP2_CHAN_STAT_RXDATA_m)
                rp2_rx_chars(up);
        if (status & RP2_CHAN_STAT_TXEMPTY_m)
                rp2_tx_chars(up);
        if (status & RP2_CHAN_STAT_MS_CHANGED_MASK)
                wake_up_interruptible(&rp2_delta_msr_wait(up));

        spin_unlock(&up->port.lock);
}

static int rp2_asic_interrupt(struct rp2_card *card, unsigned int asic_id)
{
        void __iomem *base = card->bar1 + RP2_ASIC_OFFSET(asic_id);
        int ch, handled = 0;
        unsigned long status = readl(base + RP2_CH_IRQ_STAT) &
                               ~readl(base + RP2_CH_IRQ_MASK);

        for_each_set_bit(ch, &status, PORTS_PER_ASIC) {
                rp2_ch_interrupt(&card->ports[ch]);
                handled++;
        }
        return handled;
}

static irqreturn_t rp2_uart_interrupt(int irq, void *dev_id)
{
        struct rp2_card *card = dev_id;
        int handled;

        handled = rp2_asic_interrupt(card, 0);
        if (card->n_ports >= PORTS_PER_ASIC)
                handled += rp2_asic_interrupt(card, 1);

        return handled ? IRQ_HANDLED : IRQ_NONE;
}

static inline void rp2_flush_fifos(struct rp2_uart_port *up)
{
        rp2_rmw_set(up, RP2_UART_CTL,
                    RP2_UART_CTL_FLUSH_RX_m | RP2_UART_CTL_FLUSH_TX_m);
        readl(up->base + RP2_UART_CTL);
        udelay(10);
        rp2_rmw_clr(up, RP2_UART_CTL,
                    RP2_UART_CTL_FLUSH_RX_m | RP2_UART_CTL_FLUSH_TX_m);
}

static int rp2_uart_startup(struct uart_port *port)
{
        struct rp2_uart_port *up = port_to_up(port);
        struct tty_struct *tty = rp2_tty(up);

        rp2_flush_fifos(up);
        rp2_rmw(up, RP2_TXRX_CTL, RP2_TXRX_CTL_MSRIRQ_m, RP2_TXRX_CTL_RXIRQ_m| RP2_TXRX_CTL_RX_TMOUTIRQ_m);
        rp2_rmw(up, RP2_TXRX_CTL, RP2_TXRX_CTL_RX_TRIG_m, tty->low_latency ? RP2_TXRX_CTL_RX_TRIG_1 : RP2_TXRX_CTL_RX_TRIG_256);
        rp2_rmw(up, RP2_CHAN_STAT, 0, 0);
        rp2_mask_ch_irq(up, up->idx, 1);
        up->active = 1;
        return 0;
}

static void rp2_uart_shutdown(struct uart_port *port)
{
        struct rp2_uart_port *up = port_to_up(port);
        unsigned long flags;

        rp2_uart_break_ctl(port, 0);
        spin_lock_irqsave(&port->lock, flags);
        up->active = 0;
        rp2_mask_ch_irq(up, up->idx, 0);
        rp2_rmw(up, RP2_CHAN_STAT, 0, 0);
        spin_unlock_irqrestore(&port->lock, flags);
}

static const char *rp2_uart_type(struct uart_port *port)
{
        if (port->type == PORT_RP2) {
                struct rp2_uart_port *up = port_to_up(port);
                static char buffer[1024];
                snprintf(buffer, sizeof buffer, "%s (%s)",up->card->description ,up->mode->modestr);
                return buffer;
        }
        return NULL;
}

static void rp2_uart_release_port(struct uart_port *port)
{
        /* Nothing to release ... */
}

static int rp2_uart_request_port(struct uart_port *port)
{
        /* UARTs always present */
        return 0;
}

static void rp2_uart_config_port(struct uart_port *port, int flags)
{
        if (flags & UART_CONFIG_TYPE)
                port->type = PORT_RP2;
}

static int rp2_uart_verify_port(struct uart_port *port,
                                struct serial_struct *ser)
{
        if (ser->type != PORT_UNKNOWN && ser->type != PORT_RP2)
                return -EINVAL;

        return 0;
}

static const struct uart_ops rp2_uart_ops = {
        .tx_empty	= rp2_uart_tx_empty,
        .set_mctrl	= rp2_uart_set_mctrl,
        .get_mctrl	= rp2_uart_get_mctrl,
        .stop_tx	= rp2_uart_stop_tx,
        .start_tx	= rp2_uart_start_tx,
        .stop_rx	= rp2_uart_stop_rx,
        .enable_ms	= rp2_uart_enable_ms,
        .break_ctl	= rp2_uart_break_ctl,
        .startup	= rp2_uart_startup,
        .shutdown	= rp2_uart_shutdown,
        .set_termios	= rp2_uart_set_termios,
        .type		= rp2_uart_type,
        .release_port	= rp2_uart_release_port,
        .request_port	= rp2_uart_request_port,
        .config_port	= rp2_uart_config_port,
        .verify_port	= rp2_uart_verify_port,
};

static void rp2_reset_asic(struct rp2_card *card, unsigned int asic_id)
{
        void __iomem *base = card->bar1 + RP2_ASIC_OFFSET(asic_id);
        u32 clk_cfg;

        writew(1, base + RP2_GLOBAL_CMD);
        readw(base + RP2_GLOBAL_CMD);
        msleep(100);
        writel(0, base + RP2_CLK_PRESCALER);

        /* TDM clock configuration */
        clk_cfg = readw(base + RP2_ASIC_CFG);
        clk_cfg = (clk_cfg & ~BIT(8)) | BIT(9);
        writew(clk_cfg, base + RP2_ASIC_CFG);

        /* IRQ routing */
        writel(ALL_PORTS_MASK, base + RP2_CH_IRQ_MASK);
        if (!polling_mode)
                writel(RP2_ASIC_IRQ_EN_m, base + RP2_ASIC_IRQ);
}

static void rp2_init_card(struct rp2_card *card)
{
        writel(4, card->bar0 + RP2_FPGA_CTL0);
        writel(0, card->bar0 + RP2_FPGA_CTL1);

        rp2_reset_asic(card, 0);
        if (card->n_ports >= PORTS_PER_ASIC)
                rp2_reset_asic(card, 1);

        if (!polling_mode)
                writel(RP2_IRQ_MASK_EN_m, card->bar0 + RP2_IRQ_MASK);
}

static void rp2_init_port(struct rp2_uart_port *up, const struct firmware *fw)
{
        int i;

        writel(RP2_UART_CTL_RESET_CH_m, up->base + RP2_UART_CTL);
        readl(up->base + RP2_UART_CTL);
        udelay(1);

        writel(0, up->base + RP2_TXRX_CTL);
        writel(0, up->base + RP2_UART_CTL);
        readl(up->base + RP2_UART_CTL);
        udelay(1);

        rp2_flush_fifos(up);

        for (i = 0; i < min_t(int, fw->size, RP2_UCODE_BYTES); i++)
                writeb(fw->data[i], up->ucode + i);

        __rp2_uart_set_termios(up, CS8 | CREAD | CLOCAL, 0, NULL, DEFAULT_BAUD_DIV);
        rp2_uart_set_mctrl(&up->port, 0);

        writeb(RP2_RX_FIFO_ena, up->ucode + RP2_RX_FIFO);
        rp2_rmw(up, RP2_UART_CTL, RP2_UART_CTL_MODE_m, RP2_UART_CTL_XMIT_EN_m | up->mode->modebits);
        rp2_rmw(up, RP2_TXRX_CTL,  RP2_TXRX_CTL_RTS_TOGGLE_m, up->mode->rtstoggle);
        rp2_rmw(up, RP2_TXRX_CTL,  RP2_TXRX_CTL_RTS_POLARITY_m, up->mode->rtspolarity);
        rp2_rmw_set(up, RP2_TXRX_CTL, RP2_TXRX_CTL_TX_EN_m | RP2_TXRX_CTL_RX_EN_m);
}

static void rp2_remove_ports(struct rp2_card *card)
{
        int i;

        for (i = 0; i < card->initialized_ports; i++)
                uart_remove_one_port(&rp2_uart_driver, &card->ports[i].port);
        card->initialized_ports = 0;
}

// called by per-card timer at a frequency set by polling_mode module
// parameter
static void rp2_card_poll(unsigned long data)
{
        int i;
        struct rp2_card *card = (void*)data;
        if (card->shutting_down)
                return;
        for (i = 0; i < card->n_ports; i++)
                rp2_ch_interrupt(&card->ports[i]);
        mod_timer(&card->poll_timer, jiffies + polling_jiffies);
}

static void rp2_fw_cb(const struct firmware *fw, void *context)
{
        struct rp2_card *card = context;
        resource_size_t phys_base;
        int i, rc = -ENOENT;

        if (!fw) {
                dev_err(&card->pdev->dev, "cannot find '%s' firmware image\n", RP2_FW_NAME);
                goto no_fw;
        }

        phys_base = pci_resource_start(card->pdev, 1);

        for (i = 0; i < card->n_ports; i++) {
                struct rp2_uart_port *rp = &card->ports[i];
                struct uart_port *p;
                int j = (unsigned)i % PORTS_PER_ASIC;
                int line = card->minor_start + i;

                rp->asic_base = card->bar1;
                rp->base = card->bar1 + RP2_PORT_BASE + j*RP2_PORT_SPACING;
                rp->ucode = card->bar1 + RP2_UCODE_BASE + j*RP2_UCODE_SPACING;
                rp->card = card;
                rp->idx = j;
                rp->mode = card->smpte ? SMPTE_MODE : get_port_mode(line);
                p = &rp->port;
                p->line = line;
                p->dev = &card->pdev->dev;
                p->type = PORT_RP2;
                p->iotype = UPIO_MEM32;
                p->uartclk = UART_CLOCK;
                p->regshift = 2;
                p->fifosize = FIFO_SIZE;
                p->ops = &rp2_uart_ops;
                p->irq = card->pdev->irq;
                p->membase = rp->base;
                p->mapbase = phys_base + RP2_PORT_BASE + j*RP2_PORT_SPACING;

                if (i >= PORTS_PER_ASIC) {
                        rp->asic_base += RP2_ASIC_SPACING;
                        rp->base += RP2_ASIC_SPACING;
                        rp->ucode += RP2_ASIC_SPACING;
                        p->mapbase += RP2_ASIC_SPACING;
                }

                rp2_init_port(rp, fw);
                rc = uart_add_one_port(&rp2_uart_driver, p);
                if (rc) {
                        dev_err(&card->pdev->dev,
                                "error registering port %d: %d\n", i, rc);
                        rp2_remove_ports(card);
                        break;
                }
                card->initialized_ports++;
        }

#if !USE_INTERNAL_FIRMWARE
        release_firmware(fw);
#endif

no_fw:
        /*
         * rp2_fw_cb() is called from a workqueue long after rp2_probe()
         * has already returned success.  So if something failed here,
         * we'll just leave the now-dormant device in place until somebody
         * unbinds it.
         */
        if (rc)
                dev_warn(&card->pdev->dev, "driver initialization failed\n");

        complete(&card->fw_loaded);

        if (polling_mode) {
                dev_info(&card->pdev->dev, "polling at %dHz\n", HZ/polling_jiffies);
                setup_timer(&card->poll_timer, rp2_card_poll, (unsigned long)card);
                mod_timer(&card->poll_timer, jiffies+1);
        }
}

static int rp2_probe(struct pci_dev *pdev,
                     const struct pci_device_id *id)
{
        struct rp2_card *card;
        struct rp2_uart_port *ports;
        void __iomem * const *bars;
        int rc;

        card = devm_kzalloc(&pdev->dev, sizeof(*card), GFP_KERNEL);
        if (!card)
                return -ENOMEM;
        pci_set_drvdata(pdev, card);
        spin_lock_init(&card->card_lock);
        init_completion(&card->fw_loaded);

        rc = pcim_enable_device(pdev);
        if (rc)
                return rc;

        rc = pcim_iomap_regions_request_all(pdev, 0x03, DRV_NAME);
        if (rc)
                return rc;

        bars = pcim_iomap_table(pdev);
        card->bar0 = bars[0];
        card->bar1 = bars[1];
        card->pdev = pdev;
        card->description = board_description(id->device);

        rp2_decode_cap(id, &card->n_ports, &card->smpte);
        dev_info(&pdev->dev, "found %s with %d ports\n", card->description, card->n_ports);

        card->minor_start = rp2_alloc_ports(card->n_ports);
        if (card->minor_start < 0) {
                dev_err(&pdev->dev,
                        "too many ports (try increasing CONFIG_SERIAL_RP2_NR_UARTS)\n");
                return -EINVAL;
        }

        rp2_init_card(card);

        ports = devm_kzalloc(&pdev->dev, sizeof(*ports) * card->n_ports,
                             GFP_KERNEL);
        if (!ports)
                return -ENOMEM;
        card->ports = ports;

        if (!polling_mode) {
                rc = devm_request_irq(&pdev->dev, pdev->irq, rp2_uart_interrupt, IRQF_SHARED, DRV_NAME, card);
                if (rc)
                        return rc;
        }

#if USE_INTERNAL_FIRMWARE
        rp2_fw_cb(&rp2_firmware,card);
#else
        // Only catastrophic errors (e.g. ENOMEM) are reported here.  If the
        // FW image is missing, we'll find out in rp2_fw_cb() and print an
        // error message.
        rc = request_firmware_nowait(THIS_MODULE, 1, RP2_FW_NAME, &pdev->dev, GFP_KERNEL, card, rp2_fw_cb);
        if (rc)
                return rc;
#endif

        dev_dbg(&pdev->dev, "waiting for firmware blob...\n");

        return 0;
}

static void rp2_remove(struct pci_dev *pdev)
{
        struct rp2_card *card = pci_get_drvdata(pdev);

        wait_for_completion(&card->fw_loaded);

        if (polling_mode) {
                int i = 10;
                card->shutting_down = true;
                while (--i) {
                        if (del_timer_sync(&card->poll_timer)==0)
                                break;
                        msleep(100);
                }
                if (i==0)
                        dev_info(&pdev->dev,"error removing poll timer\n");
        }
        rp2_remove_ports(card);
}

//======================================================================
// When adding a new board, it must be added to _both_ tables below:
// the description table used to generate messages and the PCI device
// table used to register the driver with the kernel.

static const struct rp2descr {
        unsigned device_id;
        const char *board_descr;
} board_descr_tbl[] = {
        {0x40, "RocketPort Infinity, Octa RJ45, Selectable" },
        {0x41, "RocketPort Infinity 32, External Interface" },
        {0x42, "RocketPort Infinity 8, External Interface" },
        {0x43, "RocketPort Infinity 16, External Interface" },
        {0x44, "RocketPort Infinity 4, Quad DB, Selectable" },
        {0x45, "RocketPort Infinity 8, Octa DB, Selectable" },
        {0x46, "RocketPort Infinity 4, External Interface" },
        {0x47, "RocketPort Infinity, 4, RJ45" },
        {0x4a, "RocketPort Infinity Plus, Quad" },
        {0x4b, "RocketPort Infinity Plus, Octa" },
        {0x4c, "RocketModem Infinity III, 8" },
        {0x4d, "RocketModem Infinity III, 4" },
        {0x4e, "RocketPort Infinity Plus 2, 232" },
        {0x4f, "RocketPort Infinity 2, SMPTE" },
        {0x50, "RocketPort Infinity Plus 4, RJ45" },
        {0x51, "RocketPort Infinity Plus 8, RJ11" },
        {0x52, "RocketPort Infinity Octa SMPTE" },

        {0x60, "RocketPort Express, Octa RJ45, Selectable" },
        {0x61, "RocketPort Express 32, External Interface" },
        {0x62, "RocketPort Express 8, External Interface" },
        {0x63, "RocketPort Express 16, External Interface" },
        {0x64, "RocketPort Express 4, Quad DB, Selectable" },
        {0x65, "RocketPort Express 8, Octa DB, Selectable" },
        {0x66, "RocketPort Express 4, External Interface" },
        {0x67, "RocketPort Express, 4, RJ45" },
        {0x68, "RocketPort Express, 9, RJ11" },
        {0x72, "RocketPort Express Octa SMPTE" },
        { }
};

static const char *board_description(unsigned device_id)
{
        const struct rp2descr *p;
        for (p=board_descr_tbl; p->device_id; ++p)
                if (device_id == p->device_id)
                        return p->board_descr;
        return "<unkown>";
}

static DEFINE_PCI_DEVICE_TABLE(rp2_pci_tbl) = {
        /* RocketPort INFINITY cards */

        { RP_ID(0x0040), RP_CAP(8,  0) }, /* INF Octa, RJ45, selectable */
        { RP_ID(0x0041), RP_CAP(32, 0) }, /* INF 32, ext interface */
        { RP_ID(0x0042), RP_CAP(8,  0) }, /* INF Octa, ext interface */
        { RP_ID(0x0043), RP_CAP(16, 0) }, /* INF 16, ext interface */
        { RP_ID(0x0044), RP_CAP(4,  0) }, /* INF Quad, DB, selectable */
        { RP_ID(0x0045), RP_CAP(8,  0) }, /* INF Octa, DB, selectable */
        { RP_ID(0x0046), RP_CAP(4,  0) }, /* INF Quad, ext interface */
        { RP_ID(0x0047), RP_CAP(4,  0) }, /* INF Quad, RJ45 */
        { RP_ID(0x004a), RP_CAP(4,  0) }, /* INF Plus, Quad */
        { RP_ID(0x004b), RP_CAP(8,  0) }, /* INF Plus, Octa */
        { RP_ID(0x004c), RP_CAP(8,  0) }, /* INF III, Octa */
        { RP_ID(0x004d), RP_CAP(4,  0) }, /* INF III, Quad */
        { RP_ID(0x004e), RP_CAP(2,  0) }, /* INF Plus, 2, RS232 */
        { RP_ID(0x004f), RP_CAP(2,  1) }, /* INF Plus, 2, SMPTE */
        { RP_ID(0x0050), RP_CAP(4,  0) }, /* INF Plus, Quad, RJ45 */
        { RP_ID(0x0051), RP_CAP(8,  0) }, /* INF Plus, Octa, RJ45 */
        { RP_ID(0x0052), RP_CAP(8,  1) }, /* INF Octa, SMPTE */

        /* RocketPort EXPRESS cards */

        { RP_ID(0x0060), RP_CAP(8,  0) }, /* EXP Octa, RJ45, selectable */
        { RP_ID(0x0061), RP_CAP(32, 0) }, /* EXP 32, ext interface */
        { RP_ID(0x0062), RP_CAP(8,  0) }, /* EXP Octa, ext interface */
        { RP_ID(0x0063), RP_CAP(16, 0) }, /* EXP 16, ext interface */
        { RP_ID(0x0064), RP_CAP(4,  0) }, /* EXP Quad, DB, selectable */
        { RP_ID(0x0065), RP_CAP(8,  0) }, /* EXP Octa, DB, selectable */
        { RP_ID(0x0066), RP_CAP(4,  0) }, /* EXP Quad, ext interface */
        { RP_ID(0x0067), RP_CAP(4,  0) }, /* EXP Quad, RJ45 */
        { RP_ID(0x0068), RP_CAP(8,  0) }, /* EXP Octa, RJ11 */
        { RP_ID(0x0072), RP_CAP(8,  1) }, /* EXP Octa, SMPTE */
        { }
};
MODULE_DEVICE_TABLE(pci, rp2_pci_tbl);

static struct pci_driver rp2_pci_driver = {
        .name		= DRV_NAME,
        .id_table	= rp2_pci_tbl,
        .probe	= rp2_probe,
        .remove	= rp2_remove,
};

static int __init rp2_uart_init(void)
{
        int rc;

        printk(KERN_INFO "rp2: Comtrol RocketPort Infinity/Express driver version " DRV_VERS " (%s mode)\n", polling_mode ? "Polled" : "Interrupt");
        if (DEBUG_PORT_MODES)
                printk(KERN_INFO "rp2: port_modes '%s'\n", port_modes);

        if (polling_mode) {
                if (HZ < 10) {
                        printk("rp2: Polling frequency (%dHz) is too low -- using %dHz\n",polling_mode,10);
                        polling_mode = 10;
                }
                polling_jiffies = HZ/polling_mode;
                if (polling_jiffies == 0) {
                        printk("rp2: Polling frequency (%dHz) is too high -- defaulting to %dHz\n",polling_mode,HZ);
                        polling_jiffies = 1;
                }
        }

        rc = uart_register_driver(&rp2_uart_driver);
        if (rc)
                return rc;

        rc = pci_register_driver(&rp2_pci_driver);
        if (rc) {
                uart_unregister_driver(&rp2_uart_driver);
                printk(KERN_INFO "rp2: error registering PCI driver\n");
                return rc;
        }

        return 0;
}

static void __exit rp2_uart_exit(void)
{
        printk(KERN_INFO "rp2: unregistering driver\n");
        pci_unregister_driver(&rp2_pci_driver);
        uart_unregister_driver(&rp2_uart_driver);
}

module_param(port_modes,charp,0);
module_param(polling_mode,int,0);
module_init(rp2_uart_init);
module_exit(rp2_uart_exit);

MODULE_DESCRIPTION("Comtrol RocketPort EXPRESS/INFINITY driver");
MODULE_AUTHOR("Kevin Cernekee <cernekee@gmail.com>");
MODULE_AUTHOR("Comtrol Corp. <support@comtrol.com>");
MODULE_LICENSE("GPL v2");
#if !USE_INTERNAL_FIRMWARE
MODULE_FIRMWARE(RP2_FW_NAME);
#endif
==============================================================================


MODULE PARAMETERS
-----------------

The module accepts two command-line parameters: polling_mode and
port_modes.


    polling_mode=<poll-frequency>

       <poll-frequency> is an integer that controls whether the driver
       runs in polled or interrupt-driven mode.  A zero poll-frequency
       value will run the driver in interrupt-driven mode.  If a
       non-zero value is specified, the board will not generate
       interrupts and the driver will poll the board at the specified
       frequency (in Hz).  The default value for polling_mode is 100:
       if the parameter is absent, interrupts will not be used and
       ports will be polled 100 times per second (every 10ms).

       For example, to enable interrupt-driven mode, the following
       command line could be used:

          insmod ./rp2.ko polling_mode=0

       To set the polling rate to 1000Hz (1ms polling cycle), the
       following command line could be used:

          insmod ./rp2.ko polling_mode=1000


    port_modes=<mode-string>

       <mode-string> is a string that is used to set the electrical
       interface modes for the serial ports.  If absent, all ports
       will default to RS-232 mode.  If present, the first three
       characters in the string set the mode for the first port
       (ttyRP0), the next three characters for the second port
       (ttyRP1) and so on.  The available 3-character mode specifiers
       are:

           232  Standard RS-232 mode. This is the default.

           233  RS-232 half-duplex mode. RTS will automatically be
                asserted while data is being transmitted and
                de-asserted when no data is being transmitted.  This
                mode is usually used when the RS-232 port is connected
                to a half-duplex modem or line-driver.

           422  RS-422 mode. Data is transmitted on one pair of wires
                and received on a second pair of wires.  The tx line
                drivers are always enabled.

           485  RS-485 two-wire mode. Data is transmitted and received
                on the same pair of wires.

           486  RS-485 four-wire slave mode.  Data is transmitted on
                one pair of wires and received on a second pair of
                wires.  The tx line drivers are only active when data
                is being transmitted.

           487  RS-485 four-wire master mode.  Data is transmitted on
                one pair of wires and received on a second pair of
                wires.  The tx line drivers are always active.  This
                is Identical to RS-422 mode.

       For example, if ttyRP0 is to be RS-485 two-wire, ttyRP3 is to
       be 422, and the remaining ports to be RS-232, the following
       command line could be used:

          insmod ./rp2.ko port_modes=485232232422
                                     \_/\_/\_/\_/
                                      |  |  |  |
                           ttyRP0 ----+  |  |  |
                           ttyRP1--------+  |  |
                           ttyRP2-----------+  |
                           ttyRP3--------------+



LOW LATENCY MODE
----------------

In interrupt-driven mode, the default rx fifo trigger level is 256
bytes: when receiving a continuous stream of data, it will be received
by the application in 256-byte blocks.  However, if the low_latency
flag is set on the tty_device (e.g. by using the 'setserial' program),
then the receive fifo trigger level will be set to 1 byte.  In low
latency mode, every character will be received by the application as
it arrives.  Be careful when using low-latency mode on multile ports
at high baud rates (above 9600) -- the number of interrupts generated
may result in high CPU usage.
                    
The low-latency flag has no effect when the driver is run in polling
mode.


HIGH PORT SPEEDS
----------------

To achieve some of the higher speeds in polled mode, use either
interrupt-driven mode or a pollling frequency higher than the default
100Hz value.

Recommended polling frequencies for high baud rates:

        Baud Rate              Polling Frequncy
      ----f------------        ----------------
      115200 or lower                100  (default)
      230400 to 460800               200
          921600                     500



-- 
Grant Edwards               grant.b.edwards        Yow! It's NO USE ... I've
                                  at               gone to "CLUB MED"!!
                              gmail.com            

