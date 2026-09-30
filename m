Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D5351B196
	for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 18:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790792696; cv=none; b=upMjozo15Aj+xOeW6wK24IK5ajKRsO54EMJWIrLtW/ebdP4JU7HtIUXx8dGZ67naSbv2pdQQ1qfxJ/NMCwCjJ3gSjV9cmz/k+bYtaw1hPsX7qCR+IPitIe942xLGxBnV/mhfHUpie1yWnxkPfQIg/SB0e4Lbm+VW+OC/Jl9gKYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790792696; c=relaxed/simple;
	bh=ICElK6aQFBdSCTULtqVsIyodqwPrG6s2WcbNhAeuJeY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JJ+XqQGjj8mMY09j9CszyCEbWHgzu5s1Fhd8KS6vjLfPorgYEnXYeqoVN+9hx6vcwm9dURRqVq7G0lOZzfveCrIOQ6J+PkiTWYq6V3t01c6/cm/KtzpSPSzf2pIwung+l2qAyY/ktA0bn4J1O8AuDtVKK8W1siLMneoJr02M6Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LoUqlqgP; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LoUqlqgP"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912e4b11so33955905e9.3
        for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 11:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790792692; x=1791397492; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0XBGmqxfrxVqVOxEW15bMiOP73Pw80qhVieRnncXB50=;
        b=LoUqlqgP8P/5XeLqKXPnpn/Bk0k4XfLcUeD7Vm2jeJtay50XxDe36o8dGdwn+1ypGa
         qZdayYVKg31oQn0FpTqnJUB3IlixASyCtgugzs1VWDow/bh2EPwg5ZQzVq+ds9nazqdy
         8CSNhtrj1Q5Mgc/zA6tTyoriek+DznaBFpfOENdTnCnumuCvCbZFrYsCgzIOUr2YHOEt
         nk5BBfe5sZdcHWCFmiR8TJvkS18FiqhRShukUh3Ez2foNFJu77373hkwJFTU57nZ1+C1
         0jgrQX+FXlbUyfLRG6pxpW/Kwk8OlNEudGVPCEk6IulmcVH1QvOxLj725L+ZPsLAq/tN
         hucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790792692; x=1791397492;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0XBGmqxfrxVqVOxEW15bMiOP73Pw80qhVieRnncXB50=;
        b=s0yFp21q1hCYdytl4FyiKxdAOAm90+TrTHZzzzwU7lol54mUnJlsCftN7u7qyZ24cO
         gYF1JgqfRcZIv723klGZLx+wODoW2vLB2MECoy1eUVceX2TV1MadxGxS6iESqgICI41p
         9RHtwsii0VRADoz+kh7JdWJBkdddEmMwDJ9k0gJSjvLp+tu+mpjjPrROO8zwGp+LtzlR
         f5caJ6FDcf1rtsyZgJO/Z94LjBeo6c1+yNtP3OEuz/3wrqLj4DVi3FgkqMmXRP2g9sE8
         9eSfi2tpNZp6ZCX+hWxqkV/eOzKzeGitT9e37gz9o0hBFj3f17iuJTu9aC4eXrWrgIGS
         3Rpg==
X-Forwarded-Encrypted: i=1; AKwUvBy2+VM6bcekAHtqniLO5tlaPlbkq03a0f4r3nlfxS9wHg46c9i4LY66Y8krtS68xWzuDibNv9xe8JivvAg=@vger.kernel.org
X-Gm-Message-State: AFuF++l3hj91mA/U95Ub5UdkrTgxqZgWL5Mnb7UhZZVCfEEk5de1bHZg
	Jinj7roU8lmPONqhDSj0S+bWlWjDe3SzC+kxg+phA4hkyLs2YiqvMWZV
X-Gm-Gg: AYBFou03St4SN/WaNE8ExLvhzQaGpVOgB/UP55X738ZkAtesw4P4VBHtfFLMu6EWYrI
	fa14FQ4kp8s6UG5+pUG/wAFzWxVmdd3EW1klD1YtSxTWIjqR78QuZVUhREhY6OfLT9g3JhazKKV
	Hq3PGlQRX7zSj6VGYxut7vPHF8OrdiqejPsKd43QaC3jSmSgavcLCMzSAFB2HMoJ7nKKkoY7i/m
	OVfWX5I2tS3GJBTElMpEXGysX3YiVOtgMDZ54wZOGdaXIhQalV6CAflmxyGn8atmr5k7XzCyiQW
	ig17NYEYC1lTJJmtD7jDEGgbdYmpcrO8T3lYaa4SW+L/prmlPRdrjROlDKvRnNn4TV7c76rQBgZ
	2ryTR/dNhjOYpi+A6CT7pIHK5+S0EeMkKXNFr2+iEUN7qV5bTekswuQP1DNktpN3ou9jfIs5yFh
	u1sJtMLeSk/xhErFBSdIOeLhLyCFBtth9MaiQtZp3C7T7smHjY4bc+ZN4grOdV1jb5TSxpW7/im
	4r//odWcq3s3IN7L//2qZ05REzMDzFK5VE=
X-Received: by 2002:a05:600c:45d3:b0:49f:cac3:c68a with SMTP id 5b1f17b1804b1-4a01affeca0mr34618245e9.31.1790792692369;
        Wed, 30 Sep 2026 11:24:52 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f91466asm1725335e9.4.2026.09.30.11.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 11:24:51 -0700 (PDT)
Date: Wed, 30 Sep 2026 19:24:45 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Paul Mbewe <paultyson.mbewe@ziehl-abegg.de>
Cc: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
 <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <hugo@hugovil.com>, <tobias.gannert@ziehl-abegg.de>,
 <joachim.knorr@ziehl-abegg.de>, <Maarten.Brock@sttls.nl>,
 <crescentcy.hsieh@moxa.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH v2 RESEND 1/2] serial: sc16is7xx: refill TX FIFO below
 trigger using fresh TXLVL
Message-ID: <20260930192445.1c43c6fa@pumpkin>
In-Reply-To: <20260930145628.566535-2-paultyson.mbewe@ziehl-abegg.de>
References: <20260930145628.566535-1-paultyson.mbewe@ziehl-abegg.de>
	<20260930145628.566535-2-paultyson.mbewe@ziehl-abegg.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Sep 2026 16:56:27 +0200
Paul Mbewe <paultyson.mbewe@ziehl-abegg.de> wrote:

> sc16is7xx_handle_tx() reads TXLVL once and sizes the hardware TX FIFO
> write from that value. TXLVL reports free space in the hardware TX FIFO.
> 
> On this SPI-backed path, hardirq/softirq activity, RT scheduling, and
> waiting for synchronous SPI transfers can delay the refill while the UART
> continues draining. The TXLVL value can therefore become stale before the
> hardware TX FIFO write completes.
> 
> One failing ftrace with the default 8-free-space trigger showed:
> 
>   tx_start       txlvl=9  txlvl_read_us=580
>   tx_pre_write   sent=9   pre_write_us=16
>   tx_segment     sent=9   seg_us=364
>   tx_post_write  txlvl_before=9 sent=9 txlvl_after=12 pending_after=29
>                  post_gap_us=12 post_txlvl_us=130
> 
> The driver read 9 free spaces and wrote 9 bytes to the hardware TX FIFO,
> but the post-write TXLVL read still reported 12 free spaces while 29 bytes
> remained queued in the xmit kfifo. Even allowing for the post-write read
> window, the hardware TX FIFO had not been filled below the 8-free-space
> trigger, so no new threshold crossing was expected.
> 
> The captured failing samples had the same pattern: data remained queued
> in the xmit kfifo while post-write TXLVL remained above the hardware
> trigger. The hardware TX FIFO then drained empty before another refill
> was requested, producing an unintended gap on the wire.
> 
> Fix this by re-reading TXLVL after each hardware TX FIFO write while data
> remains queued in the xmit kfifo. If TXLVL is still at or above the
> trigger, top up the hardware TX FIFO again. Stop when the xmit kfifo is
> empty or a TXLVL read confirms that hardware TX FIFO free space is
> strictly below the trigger.
> 
> Stopping when TXLVL was equal to the trigger still allowed TX gaps in the
> tested workload. Continuing until TXLVL was strictly below the trigger
> eliminated the observed gaps caused by stale-TXLVL under-fill.
> 
> Program the hardware TX trigger explicitly through TLR using the same
> constant as the refill-loop threshold. This prevents the software refill
> condition from diverging from the programmed hardware trigger.
> 
> Tested on SC16IS752 over 1 MHz SPI on an i.MX6ULL single-core
> PREEMPT_RT system, transmitting RS-485 at 115200 baud 8N1 under
> continuous Modbus RTU load.
> 
> Fixes: dfeae619d781 ("serial: sc16is7xx")
> Cc: stable@vger.kernel.org
> Reported-by: Tobias Gannert <tobias.gannert@ziehl-abegg.de>
> Link: https://lore.kernel.org/linux-serial/20260623112225.82386-3-paultyson.mbewe@ziehl-abegg.de/
> Signed-off-by: Paul Mbewe <paultyson.mbewe@ziehl-abegg.de>

Since I made him find the real bug...

Reviewed-by: David Laight <david.laight.linux@gmail.com>

> ---
> Changes in v2:
>   - New patch arising from review of v1 patch 2
>   - Added a fresh TXLVL read after each hardware TX FIFO write
>   - Continue refilling until TXLVL is strictly below the trigger
>   - Explicitly program the hardware trigger from the same constant used
>     by the refill loop
>   - Corrected the root cause from trigger-level margin to stale-TXLVL
>     under-fill
>   - Removed the max310x comparison
> 
>  drivers/tty/serial/sc16is7xx.c | 38 +++++++++++++++++++++++++++-------
>  1 file changed, 30 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> index fa7805d2cde2..1f7e98c2b570 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -216,6 +216,8 @@
>  #define SC16IS7XX_TLR_TX_TRIGGER(words)	((((words) / 4) & 0x0f) << 0)
>  #define SC16IS7XX_TLR_RX_TRIGGER(words)	((((words) / 4) & 0x0f) << 4)
>  
> +#define SC16IS7XX_TX_TRIGGER_LEVEL	8
> +
>  /* IOControl register bits (Only 75x/76x) */
>  #define SC16IS7XX_IOCONTROL_LATCH_BIT	BIT(0)   /* Enable input latching */
>  #define SC16IS7XX_IOCONTROL_MODEM_A_BIT	BIT(1)   /* Enable GPIO[7:4] as modem A pins */
> @@ -647,6 +649,21 @@ static void sc16is7xx_handle_rx(struct uart_port *port, unsigned int rxlen,
>  	tty_flip_buffer_push(&port->state->port);
>  }
>  
> +static unsigned int sc16is7xx_txlvl(struct uart_port *port)
> +{
> +	unsigned int txlvl;
> +
> +	txlvl = sc16is7xx_port_read(port, SC16IS7XX_TXLVL_REG);
> +	if (txlvl > SC16IS7XX_FIFO_SIZE) {
> +		dev_err_ratelimited(port->dev,
> +				    "chip reports %u free bytes in TX FIFO, but it only has %u\n",
> +				    txlvl, SC16IS7XX_FIFO_SIZE);
> +		return 0;
> +	}
> +
> +	return txlvl;
> +}
> +
>  static void sc16is7xx_handle_tx(struct uart_port *port)
>  {
>  	struct tty_port *tport = &port->state->port;
> @@ -668,13 +685,7 @@ static void sc16is7xx_handle_tx(struct uart_port *port)
>  	}
>  
>  	/* Limit to space available in TX FIFO */
> -	txlen = sc16is7xx_port_read(port, SC16IS7XX_TXLVL_REG);
> -	if (txlen > SC16IS7XX_FIFO_SIZE) {
> -		dev_err_ratelimited(port->dev,
> -			"chip reports %d free bytes in TX fifo, but it only has %d",
> -			txlen, SC16IS7XX_FIFO_SIZE);
> -		txlen = 0;
> -	}
> +	txlen = sc16is7xx_txlvl(port);
>  
>  	/* Handle circular buffer wrap-around by sending multiple segments */
>  	while (txlen > 0 && !kfifo_is_empty(&tport->xmit_fifo)) {
> @@ -687,7 +698,14 @@ static void sc16is7xx_handle_tx(struct uart_port *port)
>  
>  		sc16is7xx_fifo_write(port, tail, to_send);
>  		uart_xmit_advance(port, to_send);
> -		txlen -= to_send;
> +
> +		if (kfifo_is_empty(&tport->xmit_fifo))
> +			break;
> +
> +		/* Refill below the trigger to enable the next THRI crossing. */
> +		txlen = sc16is7xx_txlvl(port);
> +		if (txlen < SC16IS7XX_TX_TRIGGER_LEVEL)
> +			break;
>  	}
>  
>  	uart_port_lock_irqsave(port, &flags);
> @@ -1139,6 +1157,10 @@ static int sc16is7xx_startup(struct uart_port *port)
>  			     SC16IS7XX_TCR_RX_RESUME(24) |
>  			     SC16IS7XX_TCR_RX_HALT(48));
>  
> +	/* Sync hardware and software TX trigger levels */
> +	sc16is7xx_port_write(port, SC16IS7XX_TLR_REG,
> +			     SC16IS7XX_TLR_TX_TRIGGER(SC16IS7XX_TX_TRIGGER_LEVEL));
> +
>  	/* Disable TCR/TLR access */
>  	sc16is7xx_port_update(port, SC16IS7XX_MCR_REG, SC16IS7XX_MCR_TCRTLR_BIT, 0);
>  

