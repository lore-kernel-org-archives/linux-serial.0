Return-Path: <SRS0=J/Eu=AI=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10F3C433E0
	for <linux-serial@archiver.kernel.org>; Sat, 27 Jun 2020 11:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDC4021789
	for <linux-serial@archiver.kernel.org>; Sat, 27 Jun 2020 11:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593258211;
	bh=luIbcfQ9AtgqmqpM9hXBQ4Dyo3o9hQW+jfI/EipCS8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mcg2zaiED+ipLU/HT1jSRUVeUq5+4c+Se1zMgT0zx5bnkLlQzJ4CENmD/nEKctnaE
	 OWSbbJKTzIycW2ws2TCoWD5N1d7C4g31mGg2mVFnWE2NfyUhnrX6dtGmAcZ9ELAvkK
	 1qmRLu6ivk3ypZAKXV8Nmtxk99MBnJSll3sA4l3Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgF0Lnb (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 27 Jun 2020 07:43:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:57546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725980AbgF0Lnb (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 27 Jun 2020 07:43:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00E1F2168B;
        Sat, 27 Jun 2020 11:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593258210;
        bh=luIbcfQ9AtgqmqpM9hXBQ4Dyo3o9hQW+jfI/EipCS8E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZUyy6/58KAgvEA0zYlPzS9GLC+9nsuaVuYjq5jCEbel/yq9PCRgeqHqk+VgiI6sDE
         bImsDyg9wdH8sceZAU8jyaPJufZ4Lml3H12NJwzsDwLJyoo7yWYiGrIEr0rdPBVQyA
         GCtRYSlyLCrMy7KlZJ0A1waDDjIsl5b1IBxpwzkw=
Date:   Sat, 27 Jun 2020 13:43:23 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Xiyu Yang <xiyuyang19@fudan.edu.cn>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanxzhang@fudan.edu.cn,
        kjlu@umn.edu, Xin Tan <tanxin.ctf@gmail.com>
Subject: Re: [PATCH] tty: serial_core: Fix uart_state refcnt leak when the
 port startup
Message-ID: <20200627114323.GA1645692@kroah.com>
References: <1592052738-95202-1-git-send-email-xiyuyang19@fudan.edu.cn>
 <20200624093407.GB1751086@kroah.com>
 <954840f0-2078-fe0f-1e52-d985a4997564@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <954840f0-2078-fe0f-1e52-d985a4997564@kernel.org>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jun 24, 2020 at 11:42:59AM +0200, Jiri Slaby wrote:
> On 24. 06. 20, 11:34, Greg Kroah-Hartman wrote:
> > On Sat, Jun 13, 2020 at 08:52:18PM +0800, Xiyu Yang wrote:
> >> uart_port_startup() invokes uart_port_lock(), which returns a reference
> >> of the uart_port object if increases the refcount of the uart_state
> >> object successfully or returns NULL if fails.
> >>
> >> However, uart_port_startup() don't take the return value of
> >> uart_port_lock() as the new uart_port object to "uport" and use the old
> >> "uport" instead to balance refcount in uart_port_unlock(), which may
> >> cause a redundant decrement of refcount occurred when the new "uport"
> >> equals to NULL and then cause a potential memory leak.
> >>
> >> Fix this issue by update the "uport" object to the return value of
> >> uart_port_lock() when invoking uart_port_lock().
> >>
> >> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> >> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
> >> ---
> >>  drivers/tty/serial/serial_core.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> >> index 57840cf90388..968fd619aec0 100644
> >> --- a/drivers/tty/serial/serial_core.c
> >> +++ b/drivers/tty/serial/serial_core.c
> >> @@ -205,7 +205,7 @@ static int uart_port_startup(struct tty_struct *tty, struct uart_state *state,
> >>  	if (!page)
> >>  		return -ENOMEM;
> >>  
> >> -	uart_port_lock(state, flags);
> >> +	uport = uart_port_lock(state, flags);
> > 
> > How is this a different pointer than you originally had?
> 
> Was this patch sent twice? As I had very same questions on the other
> one, but never received a feedback:
> https://lore.kernel.org/linux-serial/bf6c1e7b-3dc6-aba6-955a-fee351a6d800@suse.com/
> 
> 
> Oh, wait: this is uart_port_startup, I commented on the uart_shutdown
> one. But whatever, I would scratch both of them.

Yeah, you are right, dropping them both now, thanks.

greg k-h
