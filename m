Return-Path: <SRS0=pW61=AQ=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C75CC433E0
	for <linux-serial@archiver.kernel.org>; Sun,  5 Jul 2020 11:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00C832073E
	for <linux-serial@archiver.kernel.org>; Sun,  5 Jul 2020 11:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgGELWY (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 5 Jul 2020 07:22:24 -0400
Received: from mga12.intel.com ([192.55.52.136]:5810 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbgGELWY (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 5 Jul 2020 07:22:24 -0400
IronPort-SDR: Fr9/Hh/f27CA0FiQphjXSHSi9ij4ELykWDuPannUyNZVjcilOKbD3okeBFpJEvH0x1Qi2mKjw/
 983XSuSkUjzg==
X-IronPort-AV: E=McAfee;i="6000,8403,9672"; a="126903218"
X-IronPort-AV: E=Sophos;i="5.75,314,1589266800"; 
   d="scan'208";a="126903218"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2020 04:22:23 -0700
IronPort-SDR: T+eWFcBHP4OcUpfVbhbMXRb2QAq2qO5CtAgSKyoebURqx0EUJ5ecbJ/n4rMlT0LE01cYz0ZGzN
 YZ1kq+E43NLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,314,1589266800"; 
   d="scan'208";a="456381298"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005.jf.intel.com with ESMTP; 05 Jul 2020 04:22:21 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1js2j0-0007gG-M7; Sun, 05 Jul 2020 14:22:22 +0300
Date:   Sun, 5 Jul 2020 14:22:22 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-team@android.com
Subject: Re: [PATCH] tty: serial: meson_uart: Init port lock early
Message-ID: <20200705112222.GO3703480@smile.fi.intel.com>
References: <20200705092736.1030598-1-maz@kernel.org>
 <CAHp75VfFNO=oqHX9EeNdVgcQUfu7RBr6SDTWi3XF4gSQNjqzUw@mail.gmail.com>
 <66dcb907f3b9c5413cebe14e0bec00a4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66dcb907f3b9c5413cebe14e0bec00a4@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, Jul 05, 2020 at 11:28:56AM +0100, Marc Zyngier wrote:
> On 2020-07-05 11:07, Andy Shevchenko wrote:
> > On Sun, Jul 5, 2020 at 12:32 PM Marc Zyngier <maz@kernel.org> wrote:
> > > 
> > > The meson UART driver triggers a lockdep splat at boot time, due
> > > to the new expectation that the driver has to initialize the
> > > per-port spinlock itself.
> > > 
> > > It remains unclear why a double initialization of the port
> > > spinlock is a desirable outcome, but in the meantime let's
> > > fix the splat.
> > > 
> > 
> > Thanks!
> > 
> > Can you test patch from [1] if it helps and doesn't break anything in
> > your case?
> > 
> > [1]:
> > https://lore.kernel.org/linux-serial/20200217114016.49856-1-andriy.shevchenko@linux.intel.com/T/#m9255e2a7474b160e66c7060fca5323ca3df49cfd
> 
> On its own, this patch doesn't seem to cure the issue (and it
> adds a compile-time warning due to unused flags).

Ah, sorry, I didn't compile it.
And after second though I think we simple need to initialise spin lock there.
Can you try below (compile-tested only):

From ed4c882e7dc3fdfcea706ada0678c060c36163b3 Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Sat, 4 Jul 2020 19:30:39 +0300
Subject: [PATCH 1/1] serial: core: Initialise spin lock before use in
 uart_configure_port()

In case of the port to be used as a console we must initialise
a spin lock before use.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/serial_core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 3cc183acf7ba..a81b4900eb60 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2371,6 +2371,13 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
 		/* Power up port for set_mctrl() */
 		uart_change_pm(state, UART_PM_STATE_ON);
 
+		/*
+		 * If this driver supports console, and it hasn't been
+		 * successfully registered yet, initialise spin lock for it.
+		 */
+		if (port->cons && !(port->cons->flags & CON_ENABLED))
+			spin_lock_init(&port->lock);
+
 		/*
 		 * Ensure that the modem control lines are de-activated.
 		 * keep the DTR setting that is set in uart_set_options()
-- 
2.27.0



> Or did you mean to test it in complement of my patch?

No, the idea to avoid "fixing" driver as you rightfully noticed a double init issue.

-- 
With Best Regards,
Andy Shevchenko


