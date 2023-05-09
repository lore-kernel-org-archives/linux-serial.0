Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78CDC77B7C
	for <linux-serial@archiver.kernel.org>; Tue,  9 May 2023 11:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235369AbjEILEJ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 9 May 2023 07:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235423AbjEILDq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 9 May 2023 07:03:46 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326484EDF
        for <linux-serial@vger.kernel.org>; Tue,  9 May 2023 04:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683630199; x=1715166199;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=VA/22SyPzp2AstVhiLxj37ea8Vo4USnN4pCOfMfpjIc=;
  b=m3QfaltwN6e9zxS03S0RQWh9v9E6IGEwMJl4WAjRjug361pak1J1pFKs
   GftSLTdC+WW+85TEK59XyndtoHjdASkU0C8UpI4j4IT9fQb38ZRVFyoiv
   lducapXkHCcc6YyUzfLifKMMVbBaUpwAvS1LTl/vEvKvwe2E8kgQuwWe9
   YSyR2qM6wTwAi0g/HAGfHYC4vC1irB0HB2g60pNHNg56Gi6gOyTlMxqhO
   QdYDCUD7IKEt1ZfAmKXO7CmYe4C+mN96rT3m/N8tiUtNrejt3qIAs+PtV
   cLuqSEVhcJr7koDGxb9MmmTC6jgGg18PLNoCrFZy/cnJPN4Vl1dJLqCJ2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="339121342"
X-IronPort-AV: E=Sophos;i="5.99,261,1677571200"; 
   d="scan'208";a="339121342"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 04:03:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="788486377"
X-IronPort-AV: E=Sophos;i="5.99,261,1677571200"; 
   d="scan'208";a="788486377"
Received: from mbrdon-mobl.ger.corp.intel.com ([10.251.219.121])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 04:03:04 -0700
Date:   Tue, 9 May 2023 14:03:02 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     qianfan <qianfanguijin@163.com>
cc:     linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: serial8250: can not change baudrate while the controller is
 busy
In-Reply-To: <eb286124-20b5-df7b-ac23-b54c07dc9a25@163.com>
Message-ID: <4985eab-fd94-5468-9f59-3af72726193@linux.intel.com>
References: <289bb78a-7509-1c5c-2923-a04ed3b6487d@163.com> <ab524eb-da1d-bf74-6d73-2defb7f7118@linux.intel.com> <d8693191-be31-b471-7ddc-b491daa48650@163.com> <20e0285b-47c8-2695-1be9-e5da981eef7c@linux.intel.com> <c66120b5-370a-778c-048d-a10ba04fe057@163.com>
 <e87414db-3482-c9f1-8212-3be1afb2c750@linux.intel.com> <eb286124-20b5-df7b-ac23-b54c07dc9a25@163.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-329311808-1683630185=:2036"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-329311808-1683630185=:2036
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 9 May 2023, qianfan wrote:
> 在 2023/5/8 21:34, Ilpo Järvinen 写道:
> > On Mon, 8 May 2023, qianfan wrote:
> > > 在 2023/5/8 18:17, Ilpo Järvinen 写道:
> > > > On Fri, 5 May 2023, qianfan wrote:
> > > > > 在 2023/4/14 20:10, Ilpo Järvinen 写道:
> > > > > > On Fri, 14 Apr 2023, qianfan wrote:
> > > > > > > My custom board is based on allwinner R40, the uart is compatibled
> > > > > > > with
> > > > > > > serial8250. Based on it's datasheet:
> > > > > > > 
> > > > > > > > When TX transmit data, or RX receives data, or TX FIFO is not
> > > > > > > > empty,
> > > > > > > > then
> > > > > > > the
> > > > > > > > BUSY flag bit can be set to 1 by hardware, which indicates the
> > > > > > > > UART
> > > > > > > > controller is busy.
> > > > > > > We cannot write LCR and DLL to update UART params such as baudrate
> > > > > > > and
> > > > > > > partity
> > > > > > > while the UART is busy, however `serial8250_do_set_termios` is a
> > > > > > > void
> > > > > > > function,
> > > > > > > the upper level always assume the uart params is updated.
> > > > > > > 
> > > > > > > The upper level `uart_set_termios` do noting if ktermios params is
> > > > > > > not
> > > > > > > changed,
> > > > > > > it will not update when the user space program running tcsetattr
> > > > > > > set a
> > > > > > > same
> > > > > > > baudrate again.
> > > > > > > 
> > > > > > > So we can not fix the baudrate when
> > > > > > > `serial8250_do_set_termios`
> > > > > > > failed.
> > > > > > > 
> > > > > > > Allwinner R40's datasheet provided a way for this case.
> > > > > > > 
> > > > > > > > CHCFG_AT_BUSY(configure at busy): Enable the bit, software can
> > > > > > > > also
> > > > > > > > set
> > > > > > > > UART
> > > > > > > > controller when UART is busy, such as the LCR, DLH, DLL
> > > > > > > > register.
> > > > > > > > CHANGE_UPDATE(change update): If CHCFG_AT_BUSY is enabled, and
> > > > > > > > CHANGE_UPDATE
> > > > > > > > is written to 1, the configuration of UART controller can be
> > > > > > > > updated.
> > > > > > > > After completed update, the bit is cleared to 0 automatically.
> > > > > > > I can't know this feature is expanded by allwinner, or it is a
> > > > > > > common
> > > > > > > functiton
> > > > > > > of serial8250. Perhaps the serial8250 driver need this.
> > > > > > tcsetattr() can be given a flag which enforces TX empty condition
> > > > > > before
> > > > > > core calls into the lower layer HW set_termios function. Would that
> > > > > > be
> > > > > > enough to solve the case you're interested in?
> > > > > > 
> > > > > > Obviously, nothing can prevent Rx from occuring as it's not under
> > > > > > local
> > > > > > UART's control (e.g. a busy flag check would still be racy). But
> > > > > > does
> > > > > > writing those registers actually break something or just corrupts
> > > > > > the
> > > > > > character under Tx/Rx (which can be handled by flushing)?
> > > > > Hi:
> > > > > 
> > > > > I speed long times to create a common solution for this problem.
> > > > > 
> > > > > (I had create two commit, the first one add some sysfs debug interface
> > > > > and the second one try solve this problem. So the next following patch
> > > > > has only patch-2. Let's we discuess this solution and I will send all
> > > > > patches if it is good.)
> > > > Thanks a lot, it's much easier to discuss now with something concrete at
> > > > hand.
> > > > 
> > > > > Allwinner introduce some bits in HALT_TX register which can change
> > > > > baudrate while the serial is busy. But that is not a common feature
> > > > > of dw-uart. Rockchip's uart is also based on dw-uart and they doesn't
> > > > > has such feature.
> > > > > 
> > > > > The loopback is a common feature of 16450/16550 serial, so we can set
> > > > > loopback mode to cut down the external serial line to force the serial
> > > > > to idle.
> > > > > 
> > > > > Next is the second patch:
> > > > > 
> > > > >   From 171e981c3695e3efcc76a2c4f0d0937d366d6e2a Mon Sep 17 00:00:00
> > > > > 2001
> > > > > From: qianfan Zhao <qianfanguijin@163.com>
> > > > > Date: Fri, 5 May 2023 08:46:50 +0800
> > > > > Subject: [PATCH] drivers: serial: 8250_dw: Make uart idle before set
> > > > > baudrate
> > > > > 
> > > > > Some registers which control the baudrate such as DLL, DLM can not
> > > > > write while the uart is busy. So set the controller to loopback mode
> > > > > and clear fifos to force idle before change baudrate.
> > > > > 
> > > > > Signed-off-by: qianfan Zhao <qianfanguijin@163.com>

> > > And the total waiting time is not a const value so we need polling.
> > It's not constant, agreed. But your comment states that it's at most one
> > frame worth of time so that should be the worst-case waiting time. Once
> > the UART starts to do things like temporary switch to loopback and/or
> > reinit/clearing FIFO, it doesn't seem that harmful to wait slightly
> > longer for the worst-case frame time, so essentially you'd only need this
> > (+ comment):
> > 
> > 	p->serial_out(p, UART_MCR, up->mcr | UART_MCR_LOOP);
> > 	dw8250_force_idle(p);
> > 	ndelay(p->frame_time);
> > 	p->serial_out(p, UART_LCR, up->lcr | UART_LCR_DLAB);
> > 
> > If you insist, ndelay() could be replaced by:
> > 	ret = read_poll_timeout_atomic(p->serial_in, usr, !(usr &
> > DW_UART_USR_BUSY),
> > 				       1, DIV_ROUND_UP(p->frame_time,
> > NSEC_PER_USEC), false,
> > 				       p, d->usr_reg);
> > 
> > You also don't explain why force_idle() is needed inside to loop, why
> > doing it once before the loop is not enough? I can see the need for that
> > in loop for dw8250_check_lcr() because it doesn't enable loopback, but
> > here, so why?
> Under my test, this code will not work:
> 
> p->serial_out(p, UART_MCR, up->mcr | UART_MCR_LOOP);
> dw8250_force_idle(p);
> /* waiting until not busy... */
> 
> Current byte maybe not finished when we set UART_MCR_LOOP and reset fifo,
> dw-uart will continue receive even if LOOP bit is set. After this byte
> is finished it will push data to rx fifo and remark BUSY flag again.
> That's why I leave dw8250_force_idle inside to loop.

It's a bit odd because BUSY should indicate a character is being received 
(asserted around middle of the start bit according to the databook), not 
that it was pushed to FIFO. Is it trying to indicate BUSY due to rxing 
another character but then the hypothesis that enabling loopback takes at 
most 1 frame would be false.

To understand better what's going on here during debugging, it might be 
useful the check DR in LSR in the case when the BUSY is still held to 
exclude data-in-RBR condition which is another condition that could 
assert BUSY. Since the FIFO is being toggled off/on, there's window of 
time when BUSY could be held due to something arriving into RBR.

IMHO, it would be nice if the FIFO reset turns out to be entirely 
unnecessary for enforcing not-busy because of that very window of 
receiving something into RBR. A character in RBR would need to be handled 
by an extra read from UART_RX which is what dw8250_force_idle() actually 
does, it looked earlier pretty magic to me but now realizing this race 
window w/o FIFO, maybe that's the explanation. If FIFO reset is not 
necessary, it would take away the need to understand how instanteneous 
toggling UART_FCR_ENABLE_FIFO is wrt. arriving character.

> Or maybe we should make dw8250_force_idle after ndelay such as:
> 
> p->serial_out(p, UART_MCR, up->mcr | UART_MCR_LOOP);
> ndelay(p->frame_time);
> dw8250_force_idle(p);
> 
> But that requires a test to see if it works.

Is Tx side empty during your test or can it interfere too here? (Just 
thinking out loud, you probably considered that yourself).

> > I started to wonder whether dw8250_check_lcr() should also temporarily
> > switch to loopback mode to ensure the UART becomes idle. Some common macro
> > could be created which wraps the idle forcing for both use cases +
> > restoring LCR & MCR. That is, dw8250_force_idle() + little bit extra ->
> > __dw8250_idle_enter() and __dw8250_idle_exit() that are called by the
> > macro.

> > It might also make sense to add delayed error reporting for the failures.
> > The error printing can safely happen only after releasing port's lock.
> Yes, this is really useful.

I checked it briefly yesterday and only the break_ctl would need to be 
wrapped besides set_divisor and set_termios. In any case, it should be 
done in a separate patch but definitely looked doable.

-- 
 i.

--8323329-329311808-1683630185=:2036--
