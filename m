Return-Path: <SRS0=2C4M=7Z=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50FA1C433E0
	for <linux-serial@archiver.kernel.org>; Fri, 12 Jun 2020 17:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33B6120836
	for <linux-serial@archiver.kernel.org>; Fri, 12 Jun 2020 17:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbgFLRIO (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 12 Jun 2020 13:08:14 -0400
Received: from muru.com ([72.249.23.125]:57770 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbgFLRIO (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 12 Jun 2020 13:08:14 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 0008080CC;
        Fri, 12 Jun 2020 17:09:05 +0000 (UTC)
Date:   Fri, 12 Jun 2020 10:08:11 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v1] serial: core: make static analyzer happy about locks
Message-ID: <20200612170811.GU37466@atomide.com>
References: <20200602144739.85566-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602144739.85566-1-andriy.shevchenko@linux.intel.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

* Andy Shevchenko <andriy.shevchenko@linux.intel.com> [691231 23:00]:
> Static analyzer can not see balanced locking if the lock is acquired and
> released conditionally.
> 
>  context imbalance in 'uart_stop' - unexpected unlock
>  context imbalance in 'uart_start' - different lock contexts for basic block
>  context imbalance in 'uart_port_startup' - different lock contexts for basic block
>  context imbalance in 'uart_shutdown' - different lock contexts for basic block
>  context imbalance in 'uart_put_char' - different lock contexts for basic block
>  context imbalance in 'uart_write' - different lock contexts for basic block
>  context imbalance in 'uart_write_room' - different lock contexts for basic block
>  context imbalance in 'uart_chars_in_buffer' - different lock contexts for basic block
>  context imbalance in 'uart_flush_buffer' - different lock contexts for basic block
> 
> Get rid of macros and implement their functionality in place. This will also
> help to enable runtime PM in cleaner way later on.

Nice, yeah this is needed to make PM runtime handling generic for serial_core.c.
Patch works for me for my PM tests:

Reviewed-by: Tony Lindgren <tony@atomide.com>
Tested-by: Tony Lindgren <tony@atomide.com>
