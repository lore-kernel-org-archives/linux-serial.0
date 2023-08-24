Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8C4C6FA8F
	for <linux-serial@archiver.kernel.org>; Thu, 24 Aug 2023 12:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236089AbjHXMOV (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 24 Aug 2023 08:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236224AbjHXMNy (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 24 Aug 2023 08:13:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB5C10EF
        for <linux-serial@vger.kernel.org>; Thu, 24 Aug 2023 05:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692879232; x=1724415232;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=2EpBlxc4NiMvGerNOhhl49VSOk2xeEeGO+SoB1+ihmM=;
  b=bTLIPJyom12Qii17ItItYNK/AF9oRPyrT0TELVsNJHl0WP+zMm3eACX0
   8Lpt9GWY+pFyX5ap7adnTLamsQZaKzuatjJkj74PFc+d7dR9MeoW2TRqm
   bcyv3jfp1Xrw9Fwtmk2W8/as58vvFrE/msUSQB/vivkEXlPbd6rouOCIT
   DNPfpNW61rsOZWvHxijiPsspz4E6S4NHY/26+HZqwnaMVYMLNK23ur+n4
   cjSg7pK/raQcyTemyXr4QXMoj9GRkl20aPt7HxmtGYtss5pMliwbriXeS
   8FGLMWW6KLyx4AQlqG7v3XzmS1XBhjud7qlW/91EK1JMBjeT/7dDLKC3m
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="374387298"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="374387298"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 05:13:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="851481628"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="851481628"
Received: from abedekar-mobl1.ger.corp.intel.com ([10.251.213.29])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 05:13:50 -0700
Date:   Thu, 24 Aug 2023 15:13:48 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Dan Raymond <draymond@foxvalley.net>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH] tty/serial: create debugfs interface for UART register
 tracing
In-Reply-To: <9d0ff4b7-2584-6003-a213-6de11f6513fa@foxvalley.net>
Message-ID: <7d437f22-277-de25-6296-97483fb81792@linux.intel.com>
References: <68ad2521-f902-b0d3-16d6-4d2a36ac656e@foxvalley.net> <9c63a3a-2720-4e2b-5155-eb6e36aef257@linux.intel.com> <9d0ff4b7-2584-6003-a213-6de11f6513fa@foxvalley.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-924049425-1692879231=:1766"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-924049425-1692879231=:1766
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 24 Aug 2023, Dan Raymond wrote:
> On 8/23/2023 2:30 AM, Ilpo Järvinen wrote:
> 
> > Thanks, looks useful (although it might have challenge in tracing hw
> > during early init).
> 
> I suppose there would need to be a mechanism to enable tracing by default
> (kernel cmd line?)  Is the UART driver even used very early in the boot
> process?

I mainly meant the time when the driver is initialized, when moving from 
univ8250 -> the actual 8250 driver for the particular HW. It's one of the 
points of interest.

I don't know if the tracing side has something more "standard" for this 
already and since you're looking to that already, it's good to take 
notice if there's something.

> > > +struct reg_event {
> > > +	uint32_t  cycle_lo;  /* CPU cycle count (lower 32-bits) */
> > > +	uint16_t  cycle_hi;  /* CPU cycle count (upper 16-bits) */
> > > +	uint8_t   access;    /* write flag + register number */
> > > +	uint8_t   data;      /* register data */
> > Some HW-specific registers are larger than 8 bits.
> 
> Not for 8250/16550?

Some drivers for 8250 variants have such registers. Not that they're 
common so it's perhaps not a big deal.

> Currently this feature only supports those and it also
> relies on the TSC which is an x86 thing.

I wonder why you have to rely on that. Why e.g. ktime_get_boottime() is 
not enough for this usecase?

> > > +		ptr = uart_debug->line + uart_debug->offset;
> > > +		len = strlen(ptr);
> > Why you need to calculate length? Shouldn't queue_remove() be able to return
> > this information?
> 
> Yes, we can return the string length from queue_remove() but we still need to
> call strlen() to accommodate all code paths.  The user might call read() with
> a very small buffer and that requires us to advance ptr past the beginning of
> the string on subsequent calls.

I still find it hard to believe you could not keep track of it all 
without strlen(), snprintf() returns the number of chars it wrote to 
uart_debug->line so it should be that length - uart_debug->offset?

> > > +	static uint64_t cpu_freq;  /* cycles per second */
> > > +	uint32_t h, m, s, us;
> > > +
> > > +	if (cpu_freq == 0)
> > > +		cpu_freq = arch_freq_get_on_cpu(0) * 1000ULL;
> > > +
> > > +	s = div64_u64_rem(cpu_cycles, cpu_freq, &cpu_cycles);
> > > +	us = div64_u64(cpu_cycles * 1000 * 1000 + 500 * 1000, cpu_freq);
> > > +
> > > +	m = s / 60; s = s % 60;
> > > +	h = m / 60; m = m % 60;
> > > +
> > > +	snprintf(buf, size, "%02d:%02d:%02d.%06u", h, m, s, us);
> > seconds.us is enough. If some additional formatting is to happen, it
> > should be done in userspace.
> 
> I can see your point.  If the user does want to reformat this it will be
> easier to start with the format you suggested.  Is this a general rule for
> kernel space?

I don't know if there's a rule. But having had to parse those :: inputs 
way too many times in the past, I have very little love for that format 
being forced on user ;-).

> > > +static noinline void queue_free(struct uart_port *port, bool force)
> > > +{
> > > +	struct uart_debug *uart_debug = port->private_data;
> > > +	struct reg_queue *queue = &uart_debug->register_queue;
> > > +
> > > +	if (force || queue->read_idx == queue->write_idx) {
> > Why cannot the only place where force=true just reset the indexes before
> > making the call so no force parameter is required? ...I think there's a
> > bug anyway with the indexes not getting properly reset in that case.
> 
> Only the queue_xxx() functions read or write the queue structure.  The indices
> are reset below when we memset() the entire structure to 0.

Ah, I see.

> > > +		vfree(queue->buf);
> > > +		memset(queue, 0, sizeof(*queue));
> > > +	}
> > > ...
> > > +	} else if (num_events) {
> > > +		reg = event.access & 0x07;
> > > +		sym = event.access & 0x08 ? out_regs[reg] : in_regs[reg];
> > Some uarts have registers beyond 0x07 so this doesn't seem enough.
> > It would be nice if the driver could provide alternative set of names for
> > the registers.
> 
> I'll have to look into how difficult it would be to support other UARTs
> besides 8250/16550.
>
> > > +/*
> > > + *  Create the debugfs interface.  This should be called during port
> > > registration after
> > > + *  port->name, port->serial_in, and port->serial_out have been
> > > initialized.
> > > We are
> > > + *  using port->private_data to store a pointer to our data structure.
> > > That
> > > field appears
> > > + *  to be otherwise unused.  If this is wrong we will need to create a
> > > new
> > > field.
> > > + */
> > > +void uart_debug_create(struct uart_port *port)
> > > +{
> > > +	struct uart_debug *uart_debug;
> > > +	struct dentry *dir;
> > > +
> > > +	uart_debug = port->private_data = kzalloc(sizeof(struct uart_debug),
> > > GFP_KERNEL);
> > How about the drivers which use port->private_data?
> 
> It didn't look like this field was used.  Was I wrong about this?

~/linux/uart/drivers/tty/serial/8250$ git grep 'private_data =' | wc -l
20

There are multiple 8250 variant drivers using it.

Some also come with additional registers so it's all relevant also in 
serial/8250/ domain.


-- 
 i.

--8323329-924049425-1692879231=:1766--
