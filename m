Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A38C433B4
	for <linux-serial@archiver.kernel.org>; Fri, 16 Apr 2021 14:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B1E6611AE
	for <linux-serial@archiver.kernel.org>; Fri, 16 Apr 2021 14:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235553AbhDPOLT (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 16 Apr 2021 10:11:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:53740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243191AbhDPOLS (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 16 Apr 2021 10:11:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D1E0610FC;
        Fri, 16 Apr 2021 14:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618582253;
        bh=cAhCGbjsIcnQmKbjtlZBVSsWgb2a1Ru4th5RZmMnqJY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jJxMI97e4swiDq/Q+O4TnOuLTquXQr/xwgoXMeYgqD0WYahYOM5pJV6dADOhenoSe
         qLvcsbtQAXCucR7OuAZ0vPZlowsKzLf9DlRlkRT+/95LD0+VefU14DSNK4Jto9Ai+i
         kTsqsPhuaBHbJb9w1TLXFdqlnghz6GDxznamunOsek5//hphbWmsYq2XYuvCv9Wu9q
         MqHnKysiUO2fFSL5fg2C4LYei6d+0kJo0wrT48QlMV0Y5ksAb4m9Hm/PJK65b0hSds
         /As4l1ebVNBR8Akn7gX0LiOcEfFri1U/NpfZinY3hYORMi6MSI7+56TkSNYru21lYR
         H7l8KvOKz4V8A==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lXPBM-0006a1-UI; Fri, 16 Apr 2021 16:10:53 +0200
Date:   Fri, 16 Apr 2021 16:10:52 +0200
From:   Johan Hovold <johan@kernel.org>
To:     dillon.minfei@gmail.com
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        lkp@intel.com, gerald.baeza@foss.st.com, erwan.leray@foss.st.com,
        linux-serial@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kbuild-all@lists.01.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH v3] serial: stm32: optimize spin lock usage
Message-ID: <YHma7H3RoLyeH650@hovoldconsulting.com>
References: <1618567841-18546-1-git-send-email-dillon.minfei@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1618567841-18546-1-git-send-email-dillon.minfei@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Apr 16, 2021 at 06:10:41PM +0800, dillon.minfei@gmail.com wrote:
> From: dillon min <dillon.minfei@gmail.com>
> 
> This patch aims to fix two potential bug:
> - no lock to protect uart register in this case
> 
>   stm32_usart_threaded_interrupt()
>      spin_lock(&port->lock);
>      ...
>      stm32_usart_receive_chars()
>        uart_handle_sysrq_char();
>        sysrq_function();
>        printk();
>          stm32_usart_console_write();
>            locked = 0; //since port->sysrq is not zero,
>                          no lock to protect forward register
>                          access.
> 
> - if add spin_trylock_irqsave() to protect uart register for sysrq = 1 case,
>   that might got recursive locking under UP.
>   So, use uart_prepare_sysrq_char(), uart_unlock_and_check_sysrq()
>   move sysrq handler position to irq/thread_d handler, just record
>   sysrq_ch in stm32_usart_receive_chars() by uart_prepare_sysrq_char()
>   delay the sysrq process to next interrupt handler.
> 
>   new flow:
> 
>   stm32_usart_threaded_interrupt()/stm32_usart_interrupt()
>   spin_lock_irqsave(&port->lock);
>   ...
>   uart_unlock_and_check_sysrq();
>      spin_unlock_irqrestore();
>      handle_sysrq(sysrq_ch);
>   stm32_usart_threaded_interrupt()//stm32_usart_interrupt() return
> 
> Cc: Johan Hovold <johan@kernel.org>
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Gerald Baeza <gerald.baeza@foss.st.com>
> Cc: Erwan Le Ray <erwan.leray@foss.st.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: dillon min <dillon.minfei@gmail.com>
> ---
> v3: add uart_prepare_sysrq_char(), uart_unlock_and_check_sysrq() to move
>     sysrq handler inside interrupt routinei to avoid recursive locking,
>     according to Johan Hovold suggestion, thanks.
> 
>  drivers/tty/serial/stm32-usart.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
> index b3675cf25a69..981f50ec784e 100644
> --- a/drivers/tty/serial/stm32-usart.c
> +++ b/drivers/tty/serial/stm32-usart.c
> @@ -271,7 +271,7 @@ static void stm32_usart_receive_chars(struct uart_port *port, bool threaded)
>  			}
>  		}
>  
> -		if (uart_handle_sysrq_char(port, c))
> +		if (uart_prepare_sysrq_char(port, c))
>  			continue;
>  		uart_insert_char(port, sr, USART_SR_ORE, c, flag);
>  	}
> @@ -457,9 +457,10 @@ static irqreturn_t stm32_usart_interrupt(int irq, void *ptr)
>  	struct uart_port *port = ptr;
>  	struct stm32_port *stm32_port = to_stm32_port(port);
>  	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
> +	unsigned long flags;
>  	u32 sr;
>  
> -	spin_lock(&port->lock);
> +	spin_lock_irqsave(&port->lock, flags);
>  
>  	sr = readl_relaxed(port->membase + ofs->isr);
>  
> @@ -477,7 +478,7 @@ static irqreturn_t stm32_usart_interrupt(int irq, void *ptr)
>  	if ((sr & USART_SR_TXE) && !(stm32_port->tx_ch))
>  		stm32_usart_transmit_chars(port);
>  
> -	spin_unlock(&port->lock);
> +	uart_unlock_and_check_sysrq(port, flags);
>  
>  	if (stm32_port->rx_ch)
>  		return IRQ_WAKE_THREAD;
> @@ -489,13 +490,14 @@ static irqreturn_t stm32_usart_threaded_interrupt(int irq, void *ptr)
>  {
>  	struct uart_port *port = ptr;
>  	struct stm32_port *stm32_port = to_stm32_port(port);
> +	unsigned long flags;
>  
> -	spin_lock(&port->lock);
> +	spin_lock_irqsave(&port->lock, flags);

This essentially turns the threaded handler into a non-threaded one,
which is a bad idea.

>  	if (stm32_port->rx_ch)
>  		stm32_usart_receive_chars(port, true);
>  
> -	spin_unlock(&port->lock);
> +	uart_unlock_and_check_sysrq(port, flags);
>  
>  	return IRQ_HANDLED;
>  }

You also didn't base this patch on tty-next, which has a number of
updates to this driver. Before noting that myself, I had fixed a couple
of deadlocks in this driver which turned out to have been incidentally
fixed by an unrelated path in -next.

I'll be posting a series that should fix up all of this.

Johan
