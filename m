Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D155C7EE23
	for <linux-serial@archiver.kernel.org>; Mon,  8 May 2023 10:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234383AbjEHKSG (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 8 May 2023 06:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234389AbjEHKR5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 8 May 2023 06:17:57 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B103293C
        for <linux-serial@vger.kernel.org>; Mon,  8 May 2023 03:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683541073; x=1715077073;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=ygs8MBik6s8+wTzItngKBycyoGApwBfkNsRqc5baKUA=;
  b=VTcGhQ+S98jHmPz4EB1zg/0g8P3cEH1UtQT59b+GFKX5BNgH9SN7/gv/
   2bqwMytMRbiK5h0UXGN0cu5dNbiiLWc1rarn8/f9xw+2c38oztIahV5Y1
   qpSE09cgrgG85M+o9uGmDHrMEs0pcoEQ++QbUZNTEXhxkizdSU0ptKFxW
   6ibyK6zLmd8X1BIy4UmDAiBp1Cm4JS3SvRNqbx1MjgEmj3OGgDyKpXG2+
   oNqxsv48/XuwRnk5JwbwuG3oo/XjbZuL9dryWUM+9Zy5sXpf0fdrPKMld
   Wzmp9UqE6k74Prw7c+rv+BEbwmYsjLpeFxRQ1JFuZVkU84ZKxWUSkvtEA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="347074032"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="347074032"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 03:17:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="698476348"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="698476348"
Received: from cciobanu-mobl1.ger.corp.intel.com ([10.249.37.159])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 03:17:50 -0700
Date:   Mon, 8 May 2023 13:17:48 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     qianfan <qianfanguijin@163.com>
cc:     linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: serial8250: can not change baudrate while the controller is
 busy
In-Reply-To: <d8693191-be31-b471-7ddc-b491daa48650@163.com>
Message-ID: <20e0285b-47c8-2695-1be9-e5da981eef7c@linux.intel.com>
References: <289bb78a-7509-1c5c-2923-a04ed3b6487d@163.com> <ab524eb-da1d-bf74-6d73-2defb7f7118@linux.intel.com> <d8693191-be31-b471-7ddc-b491daa48650@163.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-946493732-1683286400=:1947"
Content-ID: <3137c8bd-11c7-55a7-7dd8-b51b88f3d1d7@linux.intel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-946493732-1683286400=:1947
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <7d4d82a5-af-e080-c6e0-c795d77cf18@linux.intel.com>

On Fri, 5 May 2023, qianfan wrote:
> 在 2023/4/14 20:10, Ilpo Järvinen 写道:
> > On Fri, 14 Apr 2023, qianfan wrote:
> > > 
> > > My custom board is based on allwinner R40, the uart is compatibled with
> > > serial8250. Based on it's datasheet:
> > > 
> > > > When TX transmit data, or RX receives data, or TX FIFO is not empty,
> > > > then
> > > the
> > > > BUSY flag bit can be set to 1 by hardware, which indicates the UART
> > > > controller is busy.
> > > We cannot write LCR and DLL to update UART params such as baudrate and
> > > partity
> > > while the UART is busy, however `serial8250_do_set_termios` is a void
> > > function,
> > > the upper level always assume the uart params is updated.
> > > 
> > > The upper level `uart_set_termios` do noting if ktermios params is not
> > > changed,
> > > it will not update when the user space program running tcsetattr set a
> > > same
> > > baudrate again.
> > > 
> > > So we can not fix the baudrate when
> > > `serial8250_do_set_termios`
> > > failed.
> > > 
> > > Allwinner R40's datasheet provided a way for this case.
> > > 
> > > > CHCFG_AT_BUSY(configure at busy): Enable the bit, software can also set
> > > > UART
> > > > controller when UART is busy, such as the LCR, DLH, DLL register.
> > > > CHANGE_UPDATE(change update): If CHCFG_AT_BUSY is enabled, and
> > > > CHANGE_UPDATE
> > > > is written to 1, the configuration of UART controller can be updated.
> > > > After completed update, the bit is cleared to 0 automatically.
> > > I can't know this feature is expanded by allwinner, or it is a common
> > > functiton
> > > of serial8250. Perhaps the serial8250 driver need this.
> > tcsetattr() can be given a flag which enforces TX empty condition before
> > core calls into the lower layer HW set_termios function. Would that be
> > enough to solve the case you're interested in?
> > 
> > Obviously, nothing can prevent Rx from occuring as it's not under local
> > UART's control (e.g. a busy flag check would still be racy). But does
> > writing those registers actually break something or just corrupts the
> > character under Tx/Rx (which can be handled by flushing)?
> Hi:
> 
> I speed long times to create a common solution for this problem.
> 
> (I had create two commit, the first one add some sysfs debug interface
> and the second one try solve this problem. So the next following patch
> has only patch-2. Let's we discuess this solution and I will send all
> patches if it is good.)

Thanks a lot, it's much easier to discuss now with something concrete at 
hand.

> Allwinner introduce some bits in HALT_TX register which can change
> baudrate while the serial is busy. But that is not a common feature
> of dw-uart. Rockchip's uart is also based on dw-uart and they doesn't
> has such feature.
> 
> The loopback is a common feature of 16450/16550 serial, so we can set
> loopback mode to cut down the external serial line to force the serial
> to idle.
> 
> Next is the second patch:
> 
> From 171e981c3695e3efcc76a2c4f0d0937d366d6e2a Mon Sep 17 00:00:00 2001
> From: qianfan Zhao <qianfanguijin@163.com>
> Date: Fri, 5 May 2023 08:46:50 +0800
> Subject: [PATCH] drivers: serial: 8250_dw: Make uart idle before set baudrate
> 
> Some registers which control the baudrate such as DLL, DLM can not
> write while the uart is busy. So set the controller to loopback mode
> and clear fifos to force idle before change baudrate.
> 
> Signed-off-by: qianfan Zhao <qianfanguijin@163.com>
> ---
>  drivers/tty/serial/8250/8250_dw.c | 57 ++++++++++++++++++++++++++++++-
>  1 file changed, 56 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_dw.c
> b/drivers/tty/serial/8250/8250_dw.c
> index 3dca344ca19c..4eaa4d05a43e 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -35,6 +35,7 @@
>  #define DW_UART_USR    0x1f /* UART Status Register */
> 
>  /* DesignWare specific register fields */
> +#define DW_UART_USR_BUSY        BIT(0)
>  #define DW_UART_MCR_SIRE        BIT(6)
> 
>  struct dw8250_data {
> @@ -43,6 +44,8 @@ struct dw8250_data {
>      u8            usr_reg;
>      int            msr_mask_on;
>      int            msr_mask_off;
> +    u8            dll;
> +    u8            dlm;

In general, there's something wrong with the formatting of your patch, 
something corrupted tabs. You should fix that before doing any official 
submission.

>      struct clk        *clk;
>      struct clk        *pclk;
>      struct notifier_block    clk_notifier;
> @@ -52,7 +55,9 @@ struct dw8250_data {
>      unsigned int        skip_autocfg:1;
>      unsigned int        uart_16550_compatible:1;
> 
> +    unsigned int        last_loopback_waiting_time;
>      unsigned long        iir_busy_count;
> +    unsigned long        lcr_busy_count;
>  };
> 
>  static inline struct dw8250_data *to_dw8250_data(struct dw8250_port_data
> *data)
> @@ -93,6 +98,7 @@ static void dw8250_force_idle(struct uart_port *p)
> 
>  static void dw8250_check_lcr(struct uart_port *p, int value)
>  {
> +    struct dw8250_data *d = to_dw8250_data(p->private_data);
>      void __iomem *offset = p->membase + (UART_LCR << p->regshift);
>      int tries = 1000;
> 
> @@ -121,6 +127,7 @@ static void dw8250_check_lcr(struct uart_port *p, int
> value)
>       * FIXME: this deadlocks if port->lock is already held
>       * dev_err(p->dev, "Couldn't set LCR to %d\n", value);
>       */
> +    d->lcr_busy_count++;
>  }
> 
>  /* Returns once the transmitter is empty or we run out of retries */
> @@ -360,6 +367,46 @@ static void dw8250_set_termios(struct uart_port *p,
> struct ktermios *termios,
>      serial8250_do_set_termios(p, termios, old);
>  }
> 
> +static void dw8250_set_divisor(struct uart_port *p, unsigned int baud,
> +                   unsigned int quot, unsigned int quot_frac)
> +{
> +    struct uart_8250_port *up = up_to_u8250p(p);
> +    struct dw8250_data *d = to_dw8250_data(p->private_data);
> +    unsigned int usr;
> +    int retries;
> +
> +    /*
> +     * LCR, DLL, DLM registers can not write while the uart is busy,

According to DW databook, this is not entirely true. The databook 
explicitly states that if BUSY is not configured 
(UART_16550_COMPATIBLE=YES), those are always writable. And I know for 
sure that there are devices on the field do not come with BUSY.
Thus, it looks something that should be decided based on BUSY 
availability.

I had one time a patch which generalized uart_16550_compatible to 
struct dw8250_port_data but in the end I didn't need it.

> +     * set uart to loopback mode, clear fifos to force idle.
> +     * The loopback mode doesn't take effect immediately, it will waiting
> +     * current byte received done, the lower baudrate the longer waiting
> +     * time.
> +     */
> +    p->serial_out(p, UART_MCR, up->mcr | UART_MCR_LOOP);
> +    for (retries = 0; retries < 10000; retries++) {
> +        dw8250_force_idle(p);
> +
> +        usr = p->serial_in(p, d->usr_reg);
> +        if (!(usr & DW_UART_USR_BUSY))
> +            break;
> +        udelay(1);
> +    }

This loop is overkill, ndelay(p->frame_time) is all you need to wait for
the maximum time a single frame needs.

> +    d->last_loopback_waiting_time = retries;
> +
> +    p->serial_out(p, UART_LCR, up->lcr | UART_LCR_DLAB);
> +    if (p->serial_in(p, UART_LCR) & UART_LCR_DLAB) {

Can this still fail? Why?

> +        d->dll = quot & 0xff;
> +        d->dlm = (quot >> 8) & 0xff;
> +
> +        p->serial_out(p, UART_DLL, d->dll);
> +        p->serial_out(p, UART_DLM, d->dlm);

serial_dl_write()

> +        p->serial_out(p, UART_LCR, up->lcr);
> +    }
> +
> +    p->serial_out(p, UART_MCR, up->mcr);
> +}
> +

-- 
 i.
--8323329-946493732-1683286400=:1947--
