Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0F6C3DA7A
	for <linux-serial@archiver.kernel.org>; Fri,  6 Jan 2023 10:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjAFK42 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 6 Jan 2023 05:56:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjAFK40 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 6 Jan 2023 05:56:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351DF6B5B4
        for <linux-serial@vger.kernel.org>; Fri,  6 Jan 2023 02:56:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C797261D7F
        for <linux-serial@vger.kernel.org>; Fri,  6 Jan 2023 10:56:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DEDBC433D2;
        Fri,  6 Jan 2023 10:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673002584;
        bh=nbW5XajoK2QVAl0EVdOaNOkV2Y1wIBpQ9zgctDUR4Qw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gJ/A9EFgN6C5ZcWvpw+6eYLSOs5onyQmxZhit8VHS7NHySUkhhUuOm3V73dloz+/w
         vKhy3Hlg7nYn+OcBm+PqfrAS4KpLS6Ti2c8KHoFwKb1PcCtIZC8O6ECMz+uGnwXv8l
         gNWrdIa+T4G7fsmXqQiSv+rKcn0+tuq1b8VWvnPdAP0Wu2RGzhhj0LvL8Mv3yjfXpw
         aBS3/DS86W08XqhlgMK6n7mqxfAUdGQTPCpPXAmm3MHg3RD2f7A4ReO9/CEHCkMHWc
         jgGr2SJ6Jgdv5UEYjTDCCNMxEVHwJRgOQE/qWmGH1SrLV7BASJue+wUtUNUaAVZzAc
         FmO72MEp0bUBQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pDkP0-0001c3-ME; Fri, 06 Jan 2023 11:56:47 +0100
Date:   Fri, 6 Jan 2023 11:56:46 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Marek Vasut <marex@denx.de>
Cc:     linux-serial@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Erwan Le Ray <erwan.leray@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Caron <valentin.caron@foss.st.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v3] serial: stm32: Merge hard IRQ and threaded IRQ
 handling into single IRQ handler
Message-ID: <Y7f+birb2KpTygxI@hovoldconsulting.com>
References: <20221216115338.7150-1-marex@denx.de>
 <Y6sHr5kuxUoahlzJ@hovoldconsulting.com>
 <a66988fd-af44-63cd-e962-47ffa6205a6a@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a66988fd-af44-63cd-e962-47ffa6205a6a@denx.de>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jan 05, 2023 at 09:46:57PM +0100, Marek Vasut wrote:
> On 12/27/22 15:56, Johan Hovold wrote:
> 
> [...]
> 
> >> @@ -793,27 +794,13 @@ static irqreturn_t stm32_usart_interrupt(int irq, void *ptr)
> >>   	}
> >>   
> >>   	if ((sr & USART_SR_TXE) && !(stm32_port->tx_ch)) {
> >> -		spin_lock(&port->lock);
> >> +		spin_lock_irqsave(&port->lock, flags);
> >>   		stm32_usart_transmit_chars(port);
> >> -		spin_unlock(&port->lock);
> >> +		spin_unlock_irqrestore(&port->lock, flags);
> > 
> > This is not needed as the handler runs with interrupts disabled.
> 
> On SMP system, another thread on another core can call 
> stm32_usart_transmit_chars() . I don't think removing the locking is 
> correct ?

I didn't say that you should remove the locking, which is very much
needed. There's just no need to disable interrupts in a (non-threaded)
interrupt handler as that has already been done by IRQ core (and, yes,
that is also the case with forced threading).

Johan
