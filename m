Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B471C433EF
	for <linux-serial@archiver.kernel.org>; Tue, 19 Apr 2022 08:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244208AbiDSINc (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 19 Apr 2022 04:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243633AbiDSINb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 19 Apr 2022 04:13:31 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A0FFD33
        for <linux-serial@vger.kernel.org>; Tue, 19 Apr 2022 01:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650355850; x=1681891850;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=DCN/GHGN9CkmKZvKc162Xr/o0vJ1d9xKLMks3ioPA/Y=;
  b=k/gJESlbS9/mrh4LwSxnLkj4eefqGB+1W2ZHeSIPF9HUk2IumDm4fern
   jU+ZQz4cw2lRToCENHmO9Tt4BdiQcRZ0G8DfqrZdzkkqrUHdZYiGKKdl1
   qeshRrBpa/crq9DmOC6qCZMBljRb6cBfeTQUkcxgeAvhTu7OYn8zXqNmj
   ZqMweG8RTaJyTxXoalxUZed0PeDIP7WLxjCMSm0abgmh2Vi+3/3fGNLQq
   gdkyINjcGmVypyn4bQdTKXxjcDTgygEekusFIjYSaiBUdarQskTRqoKoo
   mMxY0AMvrntbZnHKkYkPDmzQuNdSAz57E9WfGM9gF2LPg+S3cVVmQkfZi
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="350157217"
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="350157217"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 01:10:13 -0700
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="575981615"
Received: from gfsierra-mobl1.ger.corp.intel.com ([10.252.54.20])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 01:10:02 -0700
Date:   Tue, 19 Apr 2022 11:09:56 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        linux-serial <linux-serial@vger.kernel.org>,
        Eric Tremblay <etremblay@distech-controls.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lukas Wunner <lukas.wunner@intel.com>, kernel@pengutronix.de,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: Re: [PATCH v3 1/3] serial: 8250: Handle UART without interrupt on
 TEMT using em485
In-Reply-To: <174a96fe-8953-6533-34d7-26c15b8f140@linux.intel.com>
Message-ID: <893fcf29-20da-2a4-5951-d956472f85f@linux.intel.com>
References: <20220330104642.229507-1-u.kleine-koenig@pengutronix.de> <20220330104642.229507-2-u.kleine-koenig@pengutronix.de> <1d6c31d-d194-9e6a-ddf9-5f29af829f3@linux.intel.com> <20220330142119.ejjlxbsnkp36nwy7@pengutronix.de>
 <174a96fe-8953-6533-34d7-26c15b8f140@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-423164400-1650355122=:1612"
Content-ID: <73443cd2-cd7b-a1f6-9b7b-219fd472ad6a@linux.intel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-423164400-1650355122=:1612
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <d71f6236-a681-ee96-8322-afff931f4c7@linux.intel.com>

Hi Greg,

This change now appears in your tty-next tree. As you seem to have missed 
there is an obvious problem with it, I'm asking which direction I should 
take to fix it.

My RS485 patchset requires frame timing information also for other 
purpose besides notemt and it seems some other drivers (and even serial 
core itself) seem to care about frame time so I was aiming to make it 
available more generally rather than per-purpose like it is now.

Should I just submit a patch which makes the div 64-bit fixing this change 
or should I pursue the alternative approach that is part of my RS485 
patchset (patches 1-2) that generalizes availability of the frame timing 
information and effectively reverts the addition of the extra notemt timer 
added by this change?


On Thu, 31 Mar 2022, Ilpo Järvinen wrote:
> On Wed, 30 Mar 2022, Uwe Kleine-König wrote:
> > On Wed, Mar 30, 2022 at 02:20:01PM +0300, Ilpo Järvinen wrote:
> > > On Wed, 30 Mar 2022, Uwe Kleine-König wrote:
> > > > From: Eric Tremblay <etremblay@distech-controls.com>
> > > > 
> > > > Introduce the UART_CAP_NOTEMT capability. The capability indicates that
> > > > the UART doesn't have an interrupt available on TEMT.
> > > > 
> > > > In the case where the device does not support it, we calculate the
> > > > maximum time it could take for the transmitter to empty the
> > > > shift register. When we get in the situation where we get the
> > > > THRE interrupt, we check if the TEMT bit is set. If it's not, we start
> > > > the a timer and recall __stop_tx() after the delay.
> > > > 
> > > > The transmit sequence is a bit modified when the capability is set. The
> > > > new timer is used between the last interrupt(THRE) and a potential
> > > > stop_tx timer.
> > > 
> > > As a general note on this patch, I've also made a version of this patch 
> > > which I intended to send among my dw rs485 v2 patchset once the merge 
> > > window is over. I believe my approach is cleaner than this one. It is 
> > > based on your suggestion on simply taking advantage of stop_tx_timer.
> > > In addition, I added frame_time into uart_port which removes the need
> > > for drivers to calculate the timing per usecase themselves (I believe 
> > > frame_time could replace the timeout in uart_port entirely).
> > >
> > > > Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> > > > [moved to use added UART_CAP_TEMT]
> > > > Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> > > > [moved to use added UART_CAP_NOTEMT, improve timeout]
> > > > Signed-off-by: Eric Tremblay <etremblay@distech-controls.com>
> > > > [rebased to v5.17, making use of tty_get_frame_size]
> > > > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > > > ---
> > > >  drivers/tty/serial/8250/8250.h      |  1 +
> > > >  drivers/tty/serial/8250/8250_port.c | 76 ++++++++++++++++++++++++++++-
> > > >  include/linux/serial_8250.h         |  2 +
> > > >  3 files changed, 77 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
> > > > index db784ace25d8..39ffeb37786f 100644
> > > > --- a/drivers/tty/serial/8250/8250.h
> > > > +++ b/drivers/tty/serial/8250/8250.h
> > > > @@ -83,6 +83,7 @@ struct serial8250_config {
> > > >  #define UART_CAP_MINI	BIT(17)	/* Mini UART on BCM283X family lacks:
> > > >  					 * STOP PARITY EPAR SPAR WLEN5 WLEN6
> > > >  					 */
> > > > +#define UART_CAP_NOTEMT	BIT(18)	/* UART without interrupt on TEMT available */
> > > >  
> > > >  #define UART_BUG_QUOT	BIT(0)	/* UART has buggy quot LSB */
> > > >  #define UART_BUG_TXEN	BIT(1)	/* UART has buggy TX IIR status */
> > > > diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> > > > index 3b12bfc1ed67..0af13b4c76a0 100644
> > > > --- a/drivers/tty/serial/8250/8250_port.c
> > > > +++ b/drivers/tty/serial/8250/8250_port.c
> > > > @@ -563,8 +563,21 @@ static void serial8250_clear_fifos(struct uart_8250_port *p)
> > > >  	}
> > > >  }
> > > >  
> > > > +static inline void serial8250_em485_update_temt_delay(struct uart_8250_port *p,
> > > > +			unsigned int cflag, unsigned int baud)
> > > > +{
> > > > +	unsigned int bits;
> > > > +
> > > > +	if (!p->em485)
> > > > +		return;
> > > > +
> > > > +	bits = tty_get_frame_size(cflag);
> > > > +	p->em485->no_temt_delay = DIV_ROUND_UP(bits * NSEC_PER_SEC, baud);
> > > 
> > > This is guaranteed to overflow on some archs?
> > 
> > Hmm, indeed, even overflows for the usual bits=10. Strange it still
> > worked for me in my tests. Maybe the irq latency is big enough to
> > explain this.


-- 
 i.
--8323329-423164400-1650355122=:1612--
