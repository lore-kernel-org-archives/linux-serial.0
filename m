Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4669BC4332F
	for <linux-serial@archiver.kernel.org>; Fri, 16 Dec 2022 16:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbiLPQmT (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 16 Dec 2022 11:42:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbiLPQlh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 16 Dec 2022 11:41:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F12110C6
        for <linux-serial@vger.kernel.org>; Fri, 16 Dec 2022 08:40:41 -0800 (PST)
Date:   Fri, 16 Dec 2022 17:40:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1671208840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GNKZeVQcAry86nfstfFYY4Z8ojpA3AomPqxbJOmxBDg=;
        b=eh8MXYUWR+oKOoE5r9tRvwuj5hKNma90ywt/qLGa5VdqA0Uius83PDmGSAFt5Ydviv6sHm
        qF+37jbkaWlGNuhSNCZw3ur1HENDEGwWqe40pcSa5u4DU+zE/vJYzNGz+OEvEVbKB+yi8t
        UB4f7w6fsHLoXCXrxQvYoSYH71x20DpOLht6HBW3pjVj+2Y7QybIdx7eYeNyRUWt7LFMMo
        O0CiWNVKxFmEF2OI4ozOKQXgokm/5OaPOa264zGZTUkrwfJrgJhwoiNY5iy8BHC8J4OyIa
        U1dKuu9waprIr58JZVBhYZyf7ghv4Kyfdpl1i34C49rL8dVukdQaWMfO40IrtQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1671208840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GNKZeVQcAry86nfstfFYY4Z8ojpA3AomPqxbJOmxBDg=;
        b=yo6rtLibK+yvf2hbcAF29KBl6BJ96+We2rAs6GtzQ6KMCKVaB4ou8atTaZOV5/Bxs8SRc7
        LKJs5UtOptmh04DA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Marek Vasut <marex@denx.de>
Cc:     linux-serial@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Erwan Le Ray <erwan.leray@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Caron <valentin.caron@foss.st.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2] serial: stm32: Merge hard IRQ and threaded IRQ
 handling into single IRQ handler
Message-ID: <Y5yfhkO4NAdxrxf6@linutronix.de>
References: <20221216021504.457699-1-marex@denx.de>
 <Y5wljLfx4bj1R9kl@linutronix.de>
 <7eba06d4-4ea1-0a15-2bb0-a1837f342a34@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7eba06d4-4ea1-0a15-2bb0-a1837f342a34@denx.de>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2022-12-16 12:52:43 [+0100], Marek Vasut wrote:
> > Also it might be worth checking if the DMA mode makes any sense if the
> > FIFO is so small.
> 
> If you want to push a lot of data through the UART without refilling the
> small FIFO all the time and getting a lot of IRQs, that's where the DMA
> comes in. Maybe I misunderstood this comment ?

I have no idea how this works in detail. However: if you FIFO which is
16 bytes deep then filling it means 16 writes and so one interrupt every
16 bytes. If the DMA engine is the "average slave dma support" then it
gets programmed to fill 16 bytes and then issues an interrupt again. The
"lucky" case if you can program say 512 bytes (or so) and the DMA
engines itself is able to fill the FIFO 32 times without involving the
CPU. The last case is clear win.

If you have the 16 bytes-DMA case then you would have to check what is
cheaper: programming the DMA engine for 16 bytes or stuffing it directly
into the FIFO.
If the DMA engine supports the larger case say 512 and refills the FIFO
on its own, then using it makes sense. However this makes usually sense
for larger transfers. Having a console on it usually leads to more
overhead because you receive usually say two bytes a second (unless you
are a fast typer). Sending depends on the usecase and the peak is
usually during boot. People doing BT via UART usually want to use DMA
because of the insane amount of data, that is pumped.

Sebastian
