Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24632C352A1
	for <linux-serial@archiver.kernel.org>; Wed,  7 Dec 2022 17:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbiLGRzh (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 7 Dec 2022 12:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbiLGRzT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 7 Dec 2022 12:55:19 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D197614C
        for <linux-serial@vger.kernel.org>; Wed,  7 Dec 2022 09:54:34 -0800 (PST)
Date:   Wed, 7 Dec 2022 18:54:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670435672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0Qv+ToYWMo1dpqX5Z3uNmjhGCpXG5eWmQjyf4rytM80=;
        b=0PifV1sZ0qCan2d2TFr/K09Me1sEUHnW1V18jvWZRuJWu6RKyKQgqtKiRUs95CGDPxzH8W
        XleXwQ/Q2AjbruQvsGUhMaM98/Q+bzIGjSLE51j86xknnmTaOMgsh7M3M65GHa7yt9EneA
        M1p+fDJaG2CNf4Bp/szqKiqzx52bXM/fNhp8Jpzg7nVL5ZmcESinD61bvjRhBnkjLTFgDr
        M3s1eFpKcxWph1kB4WBoEaSqtcgTLHlOj0N6g6GGCYhNr+ER8FvGIMORMeIKWr+OBqyEA1
        HFX4S8uAuDrY1rZ/NX5gJDUsZbcSqgkfZ/1JXaa/QamWv5aXMRpNxDsOdNqn2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670435672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0Qv+ToYWMo1dpqX5Z3uNmjhGCpXG5eWmQjyf4rytM80=;
        b=/C2bNXvqXQTbAxGq877O2kXHJrvR7D0LEDcuLnYdhKumhWcIQUmmW4BbBGDq4+Ghtf+ytm
        c8af9oRvnvlcepBQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Marek Vasut <marex@denx.de>
Cc:     linux-serial@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Erwan Le Ray <erwan.leray@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean Philippe Romain <jean-philippe.romain@foss.st.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Caron <valentin.caron@foss.st.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, johan@kernel.org
Subject: Re: [PATCH] [RFC] serial: stm32: Move stm32_usart_transmit_chars()
 to interrupt thread
Message-ID: <Y5DTVqo/YC5friOo@linutronix.de>
References: <20221207013012.395585-1-marex@denx.de>
 <Y5BLvE/2RTJsUVms@linutronix.de>
 <d69c213f-c447-63ad-fbea-b77df11f503a@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d69c213f-c447-63ad-fbea-b77df11f503a@denx.de>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2022-12-07 17:55:42 [+0100], Marek Vasut wrote:
> 
> Is the suggestion therefore to completely remove the hard IRQ handler and
> move everything into the threaded IRQ handler ?

Commit
	3489187204eb7 ("serial: stm32: adding dma support")

added the threaded mode with DMA support. It didn't say _why_ this is
needed. So I would suggest to use request_irq() and merge the two
handler. The part where it ignores the IRQ handler in the
"stm32_port->throttled" case isn't nice since it returns IRQ_HANDLED
while doing nothing.

> Are there any drawbacks of doing that to a serial port driver ?
The threaded handler runs with disabled interrupts (due to irq-save
lock) so there shouldn't be any visible difference other than the thread
is gone. I'm not sure what the benefit here actually is.
With `threadirqs' and so on PREEMPT_RT the whole routine will be moved
in the thread (as it should).

Looking at drivers/tty/serial/, the stm32-usart is the only one
requesting threaded-interrupts with a primary handler. So I guess it was
not needed to begin with.

Sebastian
