Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793961312;
	b=jMSmAdS+0hz0cOrngz6vr0QjTGuLL54KtwDVKw8ONaRbOJcf6DAMqPHcAJ9tp6C5TJ+O
	 K1IDoaY00J9I8us5zRkalmpWcqlIuFuIGItrUmOtXGxtJ3VgbDqV0HPoyfKJV7XpZr9LB
	 E0R9EoNtDBR1I5KEe5mFaoXch9Z/IKgwOuUy3m2uLSpg0qYPcluy7wtSsn5VApDrJGCdI
	 5B+P/H0q+x6fW9WXh2geVcuF7e++5eo+OMBi6K1ioh53u0VXx8TVsvotu+d0YCSOIp4Ac
	 ePjZpken4o0rXzasYNQ6VJmVPM+W4Lw6wTwi6E/Ou5NEAMEvchgwY9BhyUZtEWitktQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793961312;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 Content-Language:From:In-Reply-To:Content-Transfer-Encoding:
	 X-CMS-MailID:X-Msg-Generator:Content-Type:X-RootMTR:X-EPHeader:
	 X-CMS-RootMailID:References;
	bh=iHIRpsBrk5xyL/g4xRptAuMUZFHydbItCujSTfbpTwc=;
	b=UmQgjiWg+FPW/pq6ON4cfBgmeg+L2jmNs31+DBaySPMOF4ncNidP7dta9bk2RXF1WSI3
	 mL/QAdxXBLlVNDq9szwLLSy1qWhNJzEF4kWlzUvhVX+iB7cnxrEwcMzwyQnupiP2gjZjx
	 RFphZpNmWn8t5AXd7fCis4d4V8DmNxCs09UFdxrWs1KpnCTpy3tU4DvE2s0dpTPX/SirO
	 q85yzC5fPdhgPk5lWi1ZeHFq+F9euPuTL9LVl2tqVpdAtcsvSF1qkQTZiRsFl/ypeGVtx
	 FOD+EkBgqVOc1iJ5ZrCeTt959o2SCd/kYA2ycwUi++BloM7JsmUEKJ203Y8jn4RQIhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b="s1t/319T";
	arc=none smtp.remote-ip=210.118.77.11
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9435606A329
	for <linux-serial@vger.kernel.org>; Fri,  6 Nov 2026 10:35:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9435606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=s1t/319T
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20261106103502euoutp01c472063cd5fea3ce21e1b57175457ac4~lbky0m8h-0432004320euoutp01S
	for <linux-serial@vger.kernel.org>; Fri,  6 Nov 2026 10:35:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20261106103502euoutp01c472063cd5fea3ce21e1b57175457ac4~lbky0m8h-0432004320euoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1793961302;
	bh=iHIRpsBrk5xyL/g4xRptAuMUZFHydbItCujSTfbpTwc=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=s1t/319TN6+M32OjuD1p25EnzardJ6fNCvMQ+xzaBY/IK49DBP1fxnbR6lhATlBWZ
	 JkcaoHqaCkw7ewO1SOdH2MMylpD2AHqT1AIolQ4AK0wECXk0WHK3bZkOLuXhOIBwzU
	 xzgb1zRg1VFTqjp98TA/cn7+R2449h3h4USWUMI8=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20261106103501eucas1p273fadcaacfcdf3bcfeb089633e386618~lbkya6AKn2351423514eucas1p2J;
	Fri,  6 Nov 2026 10:35:01 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261106103501eusmtip291fc5a2055a28103ceea956f1076316a~lbkxq94mt1032110321eusmtip2g;
	Fri,  6 Nov 2026 10:35:01 +0000 (GMT)
Message-ID: <3947a409-0e97-4039-a145-12c04e1c380c@samsung.com>
Date: Fri, 6 Nov 2026 11:35:00 +0100
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 2/2] tty: serial: samsung: do not re-arm RX DMA once RX
 has been stopped
To: Samarth Narang <samarth.colleges@gmail.com>, Krzysztof Kozlowski
	<krzk@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, Greg
	Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
	<jirislaby@kernel.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>,
	linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20261031004217.3340610-3-samarth.colleges@gmail.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261106103501eucas1p273fadcaacfcdf3bcfeb089633e386618
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261031004238eucas1p1157df5d88fe44ef0585c93f9d1fd0555
X-EPHeader: CA
X-CMS-RootMailID: 20261031004238eucas1p1157df5d88fe44ef0585c93f9d1fd0555
References: <20261031004217.3340610-1-samarth.colleges@gmail.com>
	<CGME20261031004238eucas1p1157df5d88fe44ef0585c93f9d1fd0555@eucas1p1.samsung.com>
	<20261031004217.3340610-3-samarth.colleges@gmail.com>

On 31.10.2026 01:42, Samarth Narang wrote:
> s3c24xx_serial_rx_dma_complete() unconditionally submits a new RX
> descriptor after each completion, even when reception has been stopped
> or the port is shutting down. A completion racing with
> s3c24xx_serial_stop_rx() or shutdown may therefore restart DMA after the
> channel has been terminated, potentially allowing it to access the RX
> buffer after s3c24xx_serial_release_dma() has unmapped and freed it.
>
> Only re-arm RX DMA while rx_enabled is set, and clear the flag under the
> port lock during shutdown, since the hangup path can reach
> s3c64xx_serial_shutdown() without calling stop_rx(). Because the
> completion callback also holds the port lock, any descriptor submitted
> before rx_enabled is cleared will be covered by the subsequent channel
> termination.
>
> Fixes: b543c301c2c5 ("serial: samsung: add DMA support for RX")
> Link: https://lore.kernel.org/r/20261030162334.3000737-1-samarth.colleges@gmail.com
> Assisted-by: LLM
> Signed-off-by: Samarth Narang <samarth.colleges@gmail.com>


This one requires a bit more work. rx_enabled might be temporarily set to
 0 in s3c24xx_serial_rx_drain_fifo(), when uart_cons_flow_enabled()
returns true, what would result in stopping DMA at all after this patch.

The driver shutdown procedure requires much more checks and fixes, than
such single flag check.


> ---
>  drivers/tty/serial/samsung_tty.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> index 2f6c69bec..3f2346f4f 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -622,7 +622,8 @@ static void s3c24xx_serial_rx_dma_complete(void *args)
>  		tty_kref_put(tty);
>  	}
>  
> -	s3c64xx_start_rx_dma(ourport);
> +	if (ourport->rx_enabled)
> +		s3c64xx_start_rx_dma(ourport);
>  
>  	uart_port_unlock_irqrestore(port, flags);
>  }
> @@ -1165,10 +1166,13 @@ static void s3c24xx_serial_release_dma(struct s3c24xx_uart_port *p)
>  static void s3c64xx_serial_shutdown(struct uart_port *port)
>  {
>  	struct s3c24xx_uart_port *ourport = to_ourport(port);
> +	unsigned long flags;
>  
> +	uart_port_lock_irqsave(port, &flags);
>  	ourport->tx_enabled = 0;
>  	ourport->tx_mode = 0;
>  	ourport->rx_enabled = 0;
> +	uart_port_unlock_irqrestore(port, flags);
>  
>  	free_irq(port->irq, ourport);
>  

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

