Return-Path: <SRS0=pW61=AQ=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B85C433DF
	for <linux-serial@archiver.kernel.org>; Sun,  5 Jul 2020 15:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E8922075D
	for <linux-serial@archiver.kernel.org>; Sun,  5 Jul 2020 15:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593964272;
	bh=GVTPIN6JeTVm195DQhouXcw+0S8XftGG71U+IRzWY3g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=YWa3pxJBF2kaOPS8U0fodwC+cPalDb8gRWZnsC4bsgOMRo4MFU4xwytl1+1MknUWJ
	 p6iliyvbQL7DpKIbJ3q7hWqDrzYvJmT2Rsa9SNO+ra9Vo6I2nkghuAev5fwHp0iC3Q
	 8xZrFSJYa9Lc96UrNgIjya511JRKhOhk+5qypR1I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgGEPvL (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 5 Jul 2020 11:51:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:60674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726996AbgGEPvL (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 5 Jul 2020 11:51:11 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEB3E20737;
        Sun,  5 Jul 2020 15:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593964270;
        bh=GVTPIN6JeTVm195DQhouXcw+0S8XftGG71U+IRzWY3g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rwvtZgKBEQBs/g6m3PcAfOavB3ld744BQerauqmeOJSWmRbKD2iRvBxSznb6fo8KJ
         nXfbCyxvnczNg7EUs4hloVmuKDxtnHXJS17p8GHvaxIlGvYl5NEyEVvDQgpR4h0g4n
         5b6G06pJgnTsXM+7fURanMxS4938wPcFRN/xTxe0=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1js6v7-009Cdi-8i; Sun, 05 Jul 2020 16:51:09 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 05 Jul 2020 16:51:09 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-team@android.com
Subject: Re: [PATCH] tty: serial: meson_uart: Init port lock early
In-Reply-To: <20200705112222.GO3703480@smile.fi.intel.com>
References: <20200705092736.1030598-1-maz@kernel.org>
 <CAHp75VfFNO=oqHX9EeNdVgcQUfu7RBr6SDTWi3XF4gSQNjqzUw@mail.gmail.com>
 <66dcb907f3b9c5413cebe14e0bec00a4@kernel.org>
 <20200705112222.GO3703480@smile.fi.intel.com>
User-Agent: Roundcube Webmail/1.4.5
Message-ID: <e307450f24a767e08358acfe0d87ca74@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: andy.shevchenko@gmail.com, gregkh@linuxfoundation.org, khilman@baylibre.com, linux-serial@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2020-07-05 12:22, Andy Shevchenko wrote:
> On Sun, Jul 05, 2020 at 11:28:56AM +0100, Marc Zyngier wrote:
>> On 2020-07-05 11:07, Andy Shevchenko wrote:
>> > On Sun, Jul 5, 2020 at 12:32 PM Marc Zyngier <maz@kernel.org> wrote:
>> > >
>> > > The meson UART driver triggers a lockdep splat at boot time, due
>> > > to the new expectation that the driver has to initialize the
>> > > per-port spinlock itself.
>> > >
>> > > It remains unclear why a double initialization of the port
>> > > spinlock is a desirable outcome, but in the meantime let's
>> > > fix the splat.
>> > >
>> >
>> > Thanks!
>> >
>> > Can you test patch from [1] if it helps and doesn't break anything in
>> > your case?
>> >
>> > [1]:
>> > https://lore.kernel.org/linux-serial/20200217114016.49856-1-andriy.shevchenko@linux.intel.com/T/#m9255e2a7474b160e66c7060fca5323ca3df49cfd
>> 
>> On its own, this patch doesn't seem to cure the issue (and it
>> adds a compile-time warning due to unused flags).
> 
> Ah, sorry, I didn't compile it.
> And after second though I think we simple need to initialise spin lock 
> there.
> Can you try below (compile-tested only):
> 
> From ed4c882e7dc3fdfcea706ada0678c060c36163b3 Mon Sep 17 00:00:00 2001
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Date: Sat, 4 Jul 2020 19:30:39 +0300
> Subject: [PATCH 1/1] serial: core: Initialise spin lock before use in
>  uart_configure_port()
> 
> In case of the port to be used as a console we must initialise
> a spin lock before use.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/tty/serial/serial_core.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/tty/serial/serial_core.c 
> b/drivers/tty/serial/serial_core.c
> index 3cc183acf7ba..a81b4900eb60 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -2371,6 +2371,13 @@ uart_configure_port(struct uart_driver *drv,
> struct uart_state *state,
>  		/* Power up port for set_mctrl() */
>  		uart_change_pm(state, UART_PM_STATE_ON);
> 
> +		/*
> +		 * If this driver supports console, and it hasn't been
> +		 * successfully registered yet, initialise spin lock for it.
> +		 */
> +		if (port->cons && !(port->cons->flags & CON_ENABLED))
> +			spin_lock_init(&port->lock);
> +
>  		/*
>  		 * Ensure that the modem control lines are de-activated.
>  		 * keep the DTR setting that is set in uart_set_options()
> --
> 2.27.0
> 
> 
> 
>> Or did you mean to test it in complement of my patch?
> 
> No, the idea to avoid "fixing" driver as you rightfully noticed a
> double init issue.

This certainly keeps lockdep quiet on my system. You probably want
to set the lockdep class whilst you're at it (keeping that code
common with uart_port_spin_lock_init).

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
