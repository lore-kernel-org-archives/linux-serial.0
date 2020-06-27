Return-Path: <SRS0=J/Eu=AI=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F8DC433E0
	for <linux-serial@archiver.kernel.org>; Sat, 27 Jun 2020 11:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D766221582
	for <linux-serial@archiver.kernel.org>; Sat, 27 Jun 2020 11:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593258324;
	bh=KKtO74a/jiHzJ2ZTgy2saRbDMlVzEuBOfZi51+4Yzjw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=R4cGshxGHYWcGzcZC5q4CHTx34XH9KpXqA7XEm224lT1sdXdd99njBjLFxGR/gXdm
	 7/jg+uQ86ctEVqbTbJ00mdWdIWfTB6XfWY0rI1L8Br3VCp6rkTzxLjj7XRdE/cLtNJ
	 Oqqg0bZxzMtpVmlhLxoELTICt7XrXiRQv0EtWBdk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbgF0LpY (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 27 Jun 2020 07:45:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:58042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgF0LpY (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 27 Jun 2020 07:45:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53DF521548;
        Sat, 27 Jun 2020 11:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593258323;
        bh=KKtO74a/jiHzJ2ZTgy2saRbDMlVzEuBOfZi51+4Yzjw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2lQaXAkRjjR3rWosNBO/5vYVQqNuEDR4O+Ssx7xJt9pDYVVhhkWe4gkcDICc2U65d
         18UnmpyketYDAz3qaeOGYYg4nuPWXj88s1G9qZ5EjgmIo4O/F/HRL/qcKtHP3Im3wl
         CT0bHaRLF8n5DnYFxpz9n7zW1zVWyjlz/fKC/Pw0=
Date:   Sat, 27 Jun 2020 13:45:17 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-serial@vger.kernel.org
Subject: Re: [PATCH v1] serial: core: make static analyzer happy about locks
Message-ID: <20200627114517.GB1645692@kroah.com>
References: <20200602144739.85566-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602144739.85566-1-andriy.shevchenko@linux.intel.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jun 02, 2020 at 05:47:39PM +0300, Andy Shevchenko wrote:
> Static analyzer can not see balanced locking if the lock is acquired and
> released conditionally.

What static analyzer can not handle #defines like this?

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

Really?  I'll wait to see that happen, as it is, the macro should be
just fine, your patch made things more complex.

We don't write more complex code, if we can help it, just for an unnamed
tool :)

thanks,

greg k-h
