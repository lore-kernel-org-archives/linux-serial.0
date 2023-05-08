Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970E2C77B7F
	for <linux-serial@archiver.kernel.org>; Mon,  8 May 2023 13:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbjEHNeW (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 8 May 2023 09:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234213AbjEHNeV (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 8 May 2023 09:34:21 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8AE71A1F8
        for <linux-serial@vger.kernel.org>; Mon,  8 May 2023 06:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683552859; x=1715088859;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=wBbyxXsjhRirtEXFJQkc/PAj3T/XdkiwG/mizwuMDYI=;
  b=apqd0n77VFjFXUTsxpAEyfWhhTpoGrhHZiJQ3HA/NBEA0nhFESp018Zw
   sxTzWcIxsJ3r+VgLsPkmnrzJUtSk4lJPYSdUtPZJruEzfMzBAN8bd53B+
   E3aYR48vW15qzfREqb+KPNGOrJOxKMBTplngakbsf87jasUmfm4AMxhf5
   2yUblohfC25zjlT4vjj7NJ5AwVO1nYcqchREc91bo12ftY5Wj+PPocVNQ
   khy8WhRa+zOdAD9Qsrx+J/gxtaPIKVV3hM28RZrW8tmlmglc+jm9zr1ki
   w9JOUPb/RQTOxNxDdQxJsiQyS7cYPScSOdJkJmOUjF3lszKM7+TgU6S8r
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="435964542"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="435964542"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 06:34:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="872797777"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="872797777"
Received: from cciobanu-mobl1.ger.corp.intel.com ([10.249.37.159])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 06:34:17 -0700
Date:   Mon, 8 May 2023 16:34:14 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     qianfan <qianfanguijin@163.com>
cc:     linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: serial8250: can not change baudrate while the controller is
 busy
In-Reply-To: <c66120b5-370a-778c-048d-a10ba04fe057@163.com>
Message-ID: <e87414db-3482-c9f1-8212-3be1afb2c750@linux.intel.com>
References: <289bb78a-7509-1c5c-2923-a04ed3b6487d@163.com> <ab524eb-da1d-bf74-6d73-2defb7f7118@linux.intel.com> <d8693191-be31-b471-7ddc-b491daa48650@163.com> <20e0285b-47c8-2695-1be9-e5da981eef7c@linux.intel.com>
 <c66120b5-370a-778c-048d-a10ba04fe057@163.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1951147880-1683550315=:1790"
Content-ID: <b982ce83-6f78-ebf8-29ff-b76ce8ac9817@linux.intel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1951147880-1683550315=:1790
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <df5b2f86-3122-618a-de2d-64ac342029ed@linux.intel.com>

On Mon, 8 May 2023, qianfan wrote:
> 在 2023/5/8 18:17, Ilpo Järvinen 写道:
> > On Fri, 5 May 2023, qianfan wrote:
> > > 在 2023/4/14 20:10, Ilpo Järvinen 写道:
> > > > On Fri, 14 Apr 2023, qianfan wrote:
> > > > > My custom board is based on allwinner R40, the uart is compatibled
> > > > > with
> > > > > serial8250. Based on it's datasheet:
> > > > > 
> > > > > > When TX transmit data, or RX receives data, or TX FIFO is not empty,
> > > > > > then
> > > > > the
> > > > > > BUSY flag bit can be set to 1 by hardware, which indicates the UART
> > > > > > controller is busy.
> > > > > We cannot write LCR and DLL to update UART params such as baudrate and
> > > > > partity
> > > > > while the UART is busy, however `serial8250_do_set_termios` is a void
> > > > > function,
> > > > > the upper level always assume the uart params is updated.
> > > > > 
> > > > > The upper level `uart_set_termios` do noting if ktermios params is not
> > > > > changed,
> > > > > it will not update when the user space program running tcsetattr set a
> > > > > same
> > > > > baudrate again.
> > > > > 
> > > > > So we can not fix the baudrate when
> > > > > `serial8250_do_set_termios`
> > > > > failed.
> > > > > 
> > > > > Allwinner R40's datasheet provided a way for this case.
> > > > > 
> > > > > > CHCFG_AT_BUSY(configure at busy): Enable the bit, software can also
> > > > > > set
> > > > > > UART
> > > > > > controller when UART is busy, such as the LCR, DLH, DLL register.
> > > > > > CHANGE_UPDATE(change update): If CHCFG_AT_BUSY is enabled, and
> > > > > > CHANGE_UPDATE
> > > > > > is written to 1, the configuration of UART controller can be
> > > > > > updated.
> > > > > > After completed update, the bit is cleared to 0 automatically.
> > > > > I can't know this feature is expanded by allwinner, or it is a common
> > > > > functiton
> > > > > of serial8250. Perhaps the serial8250 driver need this.
> > > > tcsetattr() can be given a flag which enforces TX empty condition before
> > > > core calls into the lower layer HW set_termios function. Would that be
> > > > enough to solve the case you're interested in?
> > > > 
> > > > Obviously, nothing can prevent Rx from occuring as it's not under local
> > > > UART's control (e.g. a busy flag check would still be racy). But does
> > > > writing those registers actually break something or just corrupts the
> > > > character under Tx/Rx (which can be handled by flushing)?
> > > Hi:
> > > 
> > > I speed long times to create a common solution for this problem.
> > > 
> > > (I had create two commit, the first one add some sysfs debug interface
> > > and the second one try solve this problem. So the next following patch
> > > has only patch-2. Let's we discuess this solution and I will send all
> > > patches if it is good.)
> > Thanks a lot, it's much easier to discuss now with something concrete at
> > hand.
> > 
> > > Allwinner introduce some bits in HALT_TX register which can change
> > > baudrate while the serial is busy. But that is not a common feature
> > > of dw-uart. Rockchip's uart is also based on dw-uart and they doesn't
> > > has such feature.
> > > 
> > > The loopback is a common feature of 16450/16550 serial, so we can set
> > > loopback mode to cut down the external serial line to force the serial
> > > to idle.
> > > 
> > > Next is the second patch:
> > > 
> > >  From 171e981c3695e3efcc76a2c4f0d0937d366d6e2a Mon Sep 17 00:00:00 2001
> > > From: qianfan Zhao <qianfanguijin@163.com>
> > > Date: Fri, 5 May 2023 08:46:50 +0800
> > > Subject: [PATCH] drivers: serial: 8250_dw: Make uart idle before set
> > > baudrate
> > > 
> > > Some registers which control the baudrate such as DLL, DLM can not
> > > write while the uart is busy. So set the controller to loopback mode
> > > and clear fifos to force idle before change baudrate.
> > > 
> > > Signed-off-by: qianfan Zhao <qianfanguijin@163.com>
> > > ---

> > > @@ -360,6 +367,46 @@ static void dw8250_set_termios(struct uart_port *p,
> > > struct ktermios *termios,
> > >       serial8250_do_set_termios(p, termios, old);
> > >   }
> > > 
> > > +static void dw8250_set_divisor(struct uart_port *p, unsigned int baud,
> > > +                   unsigned int quot, unsigned int quot_frac)
> > > +{
> > > +    struct uart_8250_port *up = up_to_u8250p(p);
> > > +    struct dw8250_data *d = to_dw8250_data(p->private_data);
> > > +    unsigned int usr;
> > > +    int retries;
> > > +
> > > +    /*
> > > +     * LCR, DLL, DLM registers can not write while the uart is busy,
> > According to DW databook, this is not entirely true. The databook
> > explicitly states that if BUSY is not configured
> > (UART_16550_COMPATIBLE=YES), those are always writable. And I know for
> > sure that there are devices on the field do not come with BUSY.
> > Thus, it looks something that should be decided based on BUSY
> > availability.
> > 
> > I had one time a patch which generalized uart_16550_compatible to
> > struct dw8250_port_data but in the end I didn't need it.
>
> Or we should register dw8250_set_divisor callback only when
> !d->uart_16550_compatible
> in probe function, that is a easy way to handle this.

Yes, registering it based on the compatible might makes sense, but please 
see my comment below wrt. dw8250_check_lcr().

> > > +     * set uart to loopback mode, clear fifos to force idle.
> > > +     * The loopback mode doesn't take effect immediately, it will waiting
> > > +     * current byte received done, the lower baudrate the longer waiting
> > > +     * time.
> > > +     */
> > > +    p->serial_out(p, UART_MCR, up->mcr | UART_MCR_LOOP);
> > > +    for (retries = 0; retries < 10000; retries++) {
> > > +        dw8250_force_idle(p);
> > > +
> > > +        usr = p->serial_in(p, d->usr_reg);
> > > +        if (!(usr & DW_UART_USR_BUSY))
> > > +            break;
> > > +        udelay(1);
> > > +    }
> > This loop is overkill, ndelay(p->frame_time) is all you need to wait for
> > the maximum time a single frame needs.
> Sorry but I can not find the p->frame_time variable.

Then you're probably using some old kernel... Please base your work on 
tty repo's tty-next branch when working with serial upstream.

> And the total waiting time is not a const value so we need polling.

It's not constant, agreed. But your comment states that it's at most one 
frame worth of time so that should be the worst-case waiting time. Once 
the UART starts to do things like temporary switch to loopback and/or 
reinit/clearing FIFO, it doesn't seem that harmful to wait slightly 
longer for the worst-case frame time, so essentially you'd only need this 
(+ comment):

	p->serial_out(p, UART_MCR, up->mcr | UART_MCR_LOOP);
	dw8250_force_idle(p);
	ndelay(p->frame_time);
	p->serial_out(p, UART_LCR, up->lcr | UART_LCR_DLAB);

If you insist, ndelay() could be replaced by:
	ret = read_poll_timeout_atomic(p->serial_in, usr, !(usr & DW_UART_USR_BUSY),
				       1, DIV_ROUND_UP(p->frame_time, NSEC_PER_USEC), false,
				       p, d->usr_reg);

You also don't explain why force_idle() is needed inside to loop, why 
doing it once before the loop is not enough? I can see the need for that 
in loop for dw8250_check_lcr() because it doesn't enable loopback, but 
here, so why?

I started to wonder whether dw8250_check_lcr() should also temporarily 
switch to loopback mode to ensure the UART becomes idle. Some common macro 
could be created which wraps the idle forcing for both use cases + 
restoring LCR & MCR. That is, dw8250_force_idle() + little bit extra -> 
__dw8250_idle_enter() and __dw8250_idle_exit() that are called by the 
macro.

I also recall there was something with RS485 mode that it didn't do 
something with loopback but the wording in the databook seems rather 
vague.

> > > +    d->last_loopback_waiting_time = retries;
> > > +
> > > +    p->serial_out(p, UART_LCR, up->lcr | UART_LCR_DLAB);
> > > +    if (p->serial_in(p, UART_LCR) & UART_LCR_DLAB) {
> > Can this still fail? Why?
> If the waiting time is enough this should not fail.
> 
> But under my test before this patch, set UART_LCR register maybe failed 
> due to busy,

So your patch doesn't work or what are you saying? I see you're using 
"before this patch" but how is that relevant to the case with the patch
my question was about, I don't understand?

> if we write DLM without check DLAB bit, that will write data to UART_IER
> register,
> different baudrate will write different value, that will cause some interrupt
> disabled
> and cause strange problem.

Ah, I see. You should comment it then it's there just for safety purposes.


It might also make sense to add delayed error reporting for the failures. 
The error printing can safely happen only after releasing port's lock.


-- 
 i.
--8323329-1951147880-1683550315=:1790--
