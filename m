Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820F829D276;
	Sun, 19 Oct 2025 13:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760880780; cv=none; b=bpiUHrnYTYzS1DpZp6XtF+u21Al/VabCbGkOVclPrE1Rn+uy04dXuijTIEWHNw5ENeOwU8aw5FKCLaStVAVaJ2cbo5NzGzTo36ROG+WVtnt4DmXNOuKwmMKYCZ31yDetK6ThKI60U96WnYwIpWNMn2QTPBlnCbwAVeggseBosJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760880780; c=relaxed/simple;
	bh=9rGeGaO3i4iqghUW1VLuL8RMFQvIYSGJljMZyipONo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zhbanv0Q5pVSvtDh5VZGzbZMQ205RuflXRFZQLP7rwd6wp8lpQntp9ZB1OrYbDzD+JG22TnqLUplWFVFQLyarPgLYLs7QjmFxXXfYvpJK/3luXRdFRvXFHurjTBRmFc0yXiITC6AuoE13bu6A84SLrfXQw/hyWX5J3pKrDBAJfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=SYpsxsyu; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="SYpsxsyu"
Received: from localhost (unknown [10.10.165.9])
	by mail.ispras.ru (Postfix) with UTF8SMTPSA id 9B43F4076720;
	Sun, 19 Oct 2025 13:32:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 9B43F4076720
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1760880766;
	bh=rAUp/zOPfZjDHenR5pCa5rJWpFDGvgMLJJymplML+FU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SYpsxsyudGv77Du/W+Aj376mvpJBH/DqSar/O5dKKUa5FzIf88vBgFfRnWO7WgxSY
	 jTaWC7WFny8AUjK7wSsX/TOco0l0oT+/A+L4DsBw+maYjY5j9fzasLNn9BGwlgVeCm
	 cA2RL4y5mgpuSu8Ww1FhhjQeF5K1eBMSDsRSOnyw=
Date: Sun, 19 Oct 2025 16:32:46 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Sergey Shtylyov <s.shtylyov@omp.ru>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, lvc-project@linuxtesting.org, 
	Eddie Huang <eddie.huang@mediatek.com>
Subject: Re: [PATCH v3] serial: 8250_mtk: correct max baud rate in
 set_termios() method
Message-ID: <20251019162744-e3ac865925bae161b0193e70-pchelkin@ispras>
References: <b238b17a-c22b-4bd8-87bd-2d924328a062@omp.ru>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b238b17a-c22b-4bd8-87bd-2d924328a062@omp.ru>

On Sat, 18. Oct 23:44, Sergey Shtylyov wrote:
> Commit 81bb549fdf14 ("serial: 8250_mtk: support big baud rate.") claimed
> the maximum supported baud rate to be 4 Mbps; of the Mediatek datasheets
> (I was able to get my hands on), only MT7987A datasheet did support this
> claim and MT7981B/88A datasheets disagreed, claiming just 3 Mbps maximum.
> However, this commit failed to enforce even the claimed maximum, passing
> port->uartclk to uart_get_baud_rate() for the maximum baud rate -- while
> the datasheets mention up to 52 MHz for the baud clock's frequency. This
> means that an integer overflow would happen (when multiplying the baud
> variable by 256) if a baud rate higher than 16777215 bps is passed via
> termios->c_ospeed (division by 0 will also happen when exactly 16777216
> bps is passed). Pass to uart_get_baud_rate() the documented maximum of
> 4 Mbps or port->uartclk (whichever happens to be lesser) -- this way,
> we can avoid both overflows and regression with the maximum baud rate...
> 
> Found by Linux Verification Center (linuxtesting.org) with the Svace static
> analysis tool.
> 
> Fixes: 81bb549fdf14 ("serial: 8250_mtk: support big baud rate.")
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

Tested-by: Fedor Pchelkin <pchelkin@ispras.ru>

on Banana Pi BPI-R4 with MediaTek MT7988A chipset.

Thanks!

> 
> ---
> This patch is against the tty-linus branch of Greg KH's 'tty.git' repo.
> 
> Changes in version #3:
> - updated the maximum baud rate to 4 Mbps;
> - rewrote the description again, adding more info on the MT798x datasheets
>   studied, on how the bug manifests iself, and on the solution.
> 
> Changes in version #2:
> - changed the approach to the problem (and hence rewrote the description);
> - removed "the" article from the subject for brevity.
> 
>  drivers/tty/serial/8250/8250_mtk.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: tty/drivers/tty/serial/8250/8250_mtk.c
> ===================================================================
> --- tty.orig/drivers/tty/serial/8250/8250_mtk.c
> +++ tty/drivers/tty/serial/8250/8250_mtk.c
> @@ -358,7 +358,7 @@ mtk8250_set_termios(struct uart_port *po
>  	 */
>  	baud = uart_get_baud_rate(port, termios, old,
>  				  port->uartclk / 16 / UART_DIV_MAX,
> -				  port->uartclk);
> +				  min(4000000U, port->uartclk));
>  
>  	if (baud < 115200) {
>  		serial_port_out(port, MTK_UART_HIGHS, 0x0);
