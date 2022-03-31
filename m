Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB94C433F5
	for <linux-serial@archiver.kernel.org>; Thu, 31 Mar 2022 08:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbiCaIFM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 31 Mar 2022 04:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbiCaIFL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 31 Mar 2022 04:05:11 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B5E17AB8
        for <linux-serial@vger.kernel.org>; Thu, 31 Mar 2022 01:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648713803; x=1680249803;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=ByCYQ+Zqu2/oDERI5rSaqadtOZKot6lUcPFIdiKSH9s=;
  b=bqoJ+Gt17rOjRnajY5rfGVbfnAM5jyJSsLjcwVbPvTVGSwKyiThZjilt
   3FF6EGcwGel6dn+SjKrQTLsNTfpQw+vyU6SqERYa/jxu7N06x76FXhMB5
   iN5IKlQA/fkfBfNvQqSq9THeMEO6goBrbXenMjsermNZK9as8Nd5RwiG/
   5E0s8SAIOFuK+WZNp2/TqvFjfUhbr/qD7LpsMXFMwBRtTjOdgmopq5Kq+
   DgUvIm6A1naKltdi054KWqH5fp0u1VQyGkRNTMSk0CWVkRsrkJz43E8Tt
   z9J0nL4+lgyGAIEeVo/Vg/fXfPmpWZiA2uXpVQyOypOboUVd5e9NH+HoK
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="320444917"
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; 
   d="scan'208";a="320444917"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 01:03:22 -0700
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; 
   d="scan'208";a="566253904"
Received: from jdfellei-mobl.ger.corp.intel.com ([10.251.209.246])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 01:03:20 -0700
Date:   Thu, 31 Mar 2022 11:03:13 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
cc:     linux-serial <linux-serial@vger.kernel.org>,
        Eric Tremblay <etremblay@distech-controls.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lukas Wunner <lukas.wunner@intel.com>, kernel@pengutronix.de,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: Re: [PATCH v3 1/3] serial: 8250: Handle UART without interrupt on
 TEMT using em485
In-Reply-To: <20220330142119.ejjlxbsnkp36nwy7@pengutronix.de>
Message-ID: <174a96fe-8953-6533-34d7-26c15b8f140@linux.intel.com>
References: <20220330104642.229507-1-u.kleine-koenig@pengutronix.de> <20220330104642.229507-2-u.kleine-koenig@pengutronix.de> <1d6c31d-d194-9e6a-ddf9-5f29af829f3@linux.intel.com> <20220330142119.ejjlxbsnkp36nwy7@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1190511152-1648712412=:1898"
Content-ID: <9f395662-50a0-f84e-2a4c-b35d808b8342@linux.intel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1190511152-1648712412=:1898
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <903b33d1-8bd4-f2bb-3f96-23617cfd771b@linux.intel.com>

On Wed, 30 Mar 2022, Uwe Kleine-König wrote:

> On Wed, Mar 30, 2022 at 02:20:01PM +0300, Ilpo Järvinen wrote:
> > On Wed, 30 Mar 2022, Uwe Kleine-König wrote:
> > 
> > > From: Eric Tremblay <etremblay@distech-controls.com>
> > > 
> > > Introduce the UART_CAP_NOTEMT capability. The capability indicates that
> > > the UART doesn't have an interrupt available on TEMT.
> > > 
> > > In the case where the device does not support it, we calculate the
> > > maximum time it could take for the transmitter to empty the
> > > shift register. When we get in the situation where we get the
> > > THRE interrupt, we check if the TEMT bit is set. If it's not, we start
> > > the a timer and recall __stop_tx() after the delay.
> > > 
> > > The transmit sequence is a bit modified when the capability is set. The
> > > new timer is used between the last interrupt(THRE) and a potential
> > > stop_tx timer.
> > 
> > As a general note on this patch, I've also made a version of this patch 
> > which I intended to send among my dw rs485 v2 patchset once the merge 
> > window is over. I believe my approach is cleaner than this one. It is 
> > based on your suggestion on simply taking advantage of stop_tx_timer.
> > In addition, I added frame_time into uart_port which removes the need
> > for drivers to calculate the timing per usecase themselves (I believe 
> > frame_time could replace the timeout in uart_port entirely).
> 
> ok, if you Cc: me, I'm willing to test on my hardware platform.

I'll, although I put you as Suggested-by so I think git send-email would 
pick that up anyway.

> > > Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> > > [moved to use added UART_CAP_TEMT]
> > > Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> > > [moved to use added UART_CAP_NOTEMT, improve timeout]
> > > Signed-off-by: Eric Tremblay <etremblay@distech-controls.com>
> > > [rebased to v5.17, making use of tty_get_frame_size]
> > > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > > ---
> > >  drivers/tty/serial/8250/8250.h      |  1 +
> > >  drivers/tty/serial/8250/8250_port.c | 76 ++++++++++++++++++++++++++++-
> > >  include/linux/serial_8250.h         |  2 +
> > >  3 files changed, 77 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
> > > index db784ace25d8..39ffeb37786f 100644
> > > --- a/drivers/tty/serial/8250/8250.h
> > > +++ b/drivers/tty/serial/8250/8250.h
> > > @@ -83,6 +83,7 @@ struct serial8250_config {
> > >  #define UART_CAP_MINI	BIT(17)	/* Mini UART on BCM283X family lacks:
> > >  					 * STOP PARITY EPAR SPAR WLEN5 WLEN6
> > >  					 */
> > > +#define UART_CAP_NOTEMT	BIT(18)	/* UART without interrupt on TEMT available */
> > >  
> > >  #define UART_BUG_QUOT	BIT(0)	/* UART has buggy quot LSB */
> > >  #define UART_BUG_TXEN	BIT(1)	/* UART has buggy TX IIR status */
> > > diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> > > index 3b12bfc1ed67..0af13b4c76a0 100644
> > > --- a/drivers/tty/serial/8250/8250_port.c
> > > +++ b/drivers/tty/serial/8250/8250_port.c
> > > @@ -563,8 +563,21 @@ static void serial8250_clear_fifos(struct uart_8250_port *p)
> > >  	}
> > >  }
> > >  
> > > +static inline void serial8250_em485_update_temt_delay(struct uart_8250_port *p,
> > > +			unsigned int cflag, unsigned int baud)
> > > +{
> > > +	unsigned int bits;
> > > +
> > > +	if (!p->em485)
> > > +		return;
> > > +
> > > +	bits = tty_get_frame_size(cflag);
> > > +	p->em485->no_temt_delay = DIV_ROUND_UP(bits * NSEC_PER_SEC, baud);
> > 
> > This is guaranteed to overflow on some archs?
> 
> Hmm, indeed, even overflows for the usual bits=10. Strange it still
> worked for me in my tests. Maybe the irq latency is big enough to
> explain this.

Latency likely covers for most of it to begin with and it typically still 
has a non-zero delay. If TEMT is not yet set when the notemt timer 
expires, your code just keeps rearming the timer until the TEMT gets set.

And on 64-bit archs, NSEC_PER_SEC is long.

> > > +}
> > > +
> > >  static enum hrtimer_restart serial8250_em485_handle_start_tx(struct hrtimer *t);
> > >  static enum hrtimer_restart serial8250_em485_handle_stop_tx(struct hrtimer *t);
> > > +static enum hrtimer_restart serial8250_em485_handle_no_temt(struct hrtimer *t);
> > >  
> > >  void serial8250_clear_and_reinit_fifos(struct uart_8250_port *p)
> > >  {
> > > @@ -623,6 +636,16 @@ static int serial8250_em485_init(struct uart_8250_port *p)
> > >  		     HRTIMER_MODE_REL);
> > >  	hrtimer_init(&p->em485->start_tx_timer, CLOCK_MONOTONIC,
> > >  		     HRTIMER_MODE_REL);
> > > +
> > > +	if (p->capabilities & UART_CAP_NOTEMT) {
> > > +		struct tty_struct *tty = p->port.state->port.tty;
> > 
> > Is this safe (it was commented already by Jiri against one of Eric's 
> > patchsets)?
> 
> Oh, didn't see this comment. The problem is that the tty might be gone?

I don't claim any expertise on this, mostly just pointing to that old 
comment. After all, we're here inside tty's ioctl so I'm not sure if 
such a problem can occur (but there are init paths besides the ioctl 
one, I've not tried to check them).

In my approach it won't matter though because I made the frame_time
available so I've no need to get it from termios.

> > > +		serial8250_em485_update_temt_delay(p, tty->termios.c_cflag,
> > > +						   tty_get_baud_rate(tty));
> > > +		hrtimer_init(&p->em485->no_temt_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> > > +		p->em485->no_temt_timer.function = &serial8250_em485_handle_no_temt;
> > > +	}
> > > +
> > >  	p->em485->stop_tx_timer.function = &serial8250_em485_handle_stop_tx;
> > >  	p->em485->start_tx_timer.function = &serial8250_em485_handle_start_tx;
> > >  	p->em485->port = p;
> > > @@ -654,6 +677,7 @@ void serial8250_em485_destroy(struct uart_8250_port *p)
> > >  
> > >  	hrtimer_cancel(&p->em485->start_tx_timer);
> > >  	hrtimer_cancel(&p->em485->stop_tx_timer);
> > > +	hrtimer_cancel(&p->em485->no_temt_timer);
> > >  
> > >  	kfree(p->em485);
> > >  	p->em485 = NULL;
> > > @@ -1496,6 +1520,11 @@ static void start_hrtimer_ms(struct hrtimer *hrt, unsigned long msec)
> > >  	hrtimer_start(hrt, ms_to_ktime(msec), HRTIMER_MODE_REL);
> > >  }
> > >  
> > > +static void start_hrtimer_ns(struct hrtimer *hrt, unsigned long nsec)
> > > +{
> > > +	hrtimer_start(hrt, ns_to_ktime(nsec), HRTIMER_MODE_REL);
> > > +}
> > > +
> > >  static void __stop_tx_rs485(struct uart_8250_port *p)
> > >  {
> > >  	struct uart_8250_em485 *em485 = p->em485;
> > > @@ -1527,14 +1556,33 @@ static inline void __stop_tx(struct uart_8250_port *p)
> > >  
> > >  	if (em485) {
> > >  		unsigned char lsr = serial_in(p, UART_LSR);
> > > +
> > > +		p->lsr_saved_flags |= lsr & LSR_SAVE_FLAGS;
> > 
> > This change doesn't belong to this patch. It's an independent fix?
> 
> Yes, that leaked into this patch, IIRC there are a few more code
> locations that should update lsr_saved_flags.
> 
> > ...I'm not entirely sure it's fixing something though. After all, we're
> > talking about half-duplex here so it should not have those rx related 
> > flags that need to be saved?
> 
> There is SER_RS485_RX_DURING_TX ...

Ah, indeed. Somehow I always end up thinking this em485 RTS toggling
implies half-duplex.
 

-- 
 i.
--8323329-1190511152-1648712412=:1898--
