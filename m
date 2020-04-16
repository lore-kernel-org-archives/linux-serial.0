Return-Path: <SRS0=wizI=6A=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5ADC2BB55
	for <linux-serial@archiver.kernel.org>; Thu, 16 Apr 2020 14:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37A6F20732
	for <linux-serial@archiver.kernel.org>; Thu, 16 Apr 2020 14:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587045794;
	bh=zbL0A8afOYEvdEVbqQo3xydp13RhWQj9s/P/zr+aQNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=i34L7Qn2z2u0lYb6v4jZ+ZfNnboWAj3UmNwiq8Tj5xaLHjROgTZCqFZT+DKSjGyE0
	 wB4GwJiy2qAMNomSzxD1k2TLC+MSUe4qHpPGyoqmKAjJf/tczc4Yo5jv2LxPnEbJsh
	 9QFJUZ52gfgBAOpXHDqaZDMfilhHEolDEa7l5rAs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730789AbgDPODI (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:03:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:50630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2633481AbgDPOCz (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 16 Apr 2020 10:02:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFA9722250;
        Thu, 16 Apr 2020 14:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587045775;
        bh=zbL0A8afOYEvdEVbqQo3xydp13RhWQj9s/P/zr+aQNs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0xeOsGUiZnA/j4Ccbn5JNZspM5sNoEks9lsD2WrADpzK0aYtzYuydh+2EWBXl/clf
         AUwxou8rj/tOHzZyM0kxAE/54TYvI06Vr4Y0BUzL0PQyuon4uv7q1Csf8TbKZi2A0R
         xgo6tIp+HVKlLoJKoX4gDLdMt16j8FuOH/y5k0rM=
Date:   Thu, 16 Apr 2020 15:58:36 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     linux-kernel@vger.kernel.org, boqun.feng@gmail.com,
        Jiri Slaby <jslaby@suse.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Subject: Re: [PATCH 7/7] tty: serial_core: Add missing annotation for
 _unlock_and_check_sysrq()
Message-ID: <20200416135836.GB1295013@kroah.com>
References: <0/7>
 <20200331204643.11262-1-jbi.octave@gmail.com>
 <20200331204643.11262-8-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331204643.11262-8-jbi.octave@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Mar 31, 2020 at 09:46:43PM +0100, Jules Irenge wrote:
> Sparse reports a warning at _unlock_and_check_sysrq()
> 
> warning: context imbalance in uart_unlock_and_check_sysrq()
> 	- unexpected unlock
> 
> The root cause is the missing annotation at _unlock_and_check_sysrq()
> Add the missing __releases(&port->lock) annotation.
> 
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> ---
>  drivers/tty/serial/serial_core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 76e506ee335c..32f93f03efce 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -3121,6 +3121,7 @@ int uart_prepare_sysrq_char(struct uart_port *port, unsigned int ch)
>  EXPORT_SYMBOL_GPL(uart_prepare_sysrq_char);
>  
>  void uart_unlock_and_check_sysrq(struct uart_port *port, unsigned long irqflags)
> +	__releases(&port->lock)
>  {
>  	int sysrq_ch;
>  
> -- 
> 2.24.1
> 

This is already in the tree, are you sure you are not working from an
older one?

greg k-h
