Received: from mail.tkos.co.il (guitar.tkos.co.il [84.110.109.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6B135975;
	Mon, 22 Dec 2025 05:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.110.109.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766382604; cv=none; b=qYnHn7cjvqVflcB26zpq53gy4h1Qtc1oED5CXMeG6OeFVdHrinVfIsBxtLRdN8e6ShtS+TMK5ihHywoXLH9GEM3yvPhBXsCHAtEg/JDmHxJv0NFNeTfnNOLsNc/+2VdbAAggJMA0Mt6X7LIpZ+yXENawrpXNJGesBJOztv+nVAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766382604; c=relaxed/simple;
	bh=I2mkLsR9R8yTlZ2vB9UNyIEZQCNZVBLCZLhYW9lMQ5Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uzAltXko+OYe1UTT1HsQpm0tfv0Tl5exNPn4fGDTMD2RBZmVmp8g/ZmM45OJP2esR+Bul3AbZzxCStnN1AmY24fQc4ZMrKSneS5Rvkta8xtSGSJbU6Y1vNVfl3TyWp4coL1UxuV8GjJzDiqTiqJ5a+ZJ1gp4W3IvuyyWzw/PD5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il; spf=pass smtp.mailfrom=tkos.co.il; dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b=VD0kIW9b; arc=none smtp.client-ip=84.110.109.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b="VD0kIW9b"
Received: from localhost (unknown [10.0.8.3])
	by mail.tkos.co.il (Postfix) with ESMTP id 9A1BC44064C;
	Mon, 22 Dec 2025 07:39:12 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1766381952;
	bh=I2mkLsR9R8yTlZ2vB9UNyIEZQCNZVBLCZLhYW9lMQ5Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=VD0kIW9bMDzR1OMZfs9Goe09MTNKkIU7dnzcp4vobqu8OiZNHQ/iMj+K3yxL+GMiu
	 Bpnx6BUduJxcLvZZSRNR9JNQgvENQNCY+WSdEaLPpkEUCbD9CDbKNcD+fd2pFdGFhG
	 6lmx7iUql3OOZaa07CD9E90yyq+4KIvgKdvbcvspf4ovshofwwmB0UL79YyuXZoSjv
	 bPmPMyOnq64bUao+pCUqw/r4LDmaHu/GbaW46PM04M8TssPQeCtpNzWDe0weAsHdoJ
	 KGIGk2aNpp43cOdnnMBDbeKp/eKKkuXXEO5JUc0J08HRzbm8NC8D+M7nYCwLPQAp1h
	 Q3EW7yhhTOYFg==
From: Baruch Siach <baruch@tkos.co.il>
To: Junrui Luo <moonafterrain@outlook.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,  Jiri Slaby
 <jirislaby@kernel.org>,  linux-kernel@vger.kernel.org,
  linux-serial@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
  Yuhao Jiang <danisjiang@gmail.com>
Subject: Re: [PATCH] serial: digicolor: fix use-after-free on driver unbind
In-Reply-To: <SYBPR01MB7881327BF7F679E76A7315DEAFB4A@SYBPR01MB7881.ausprd01.prod.outlook.com>
	(Junrui Luo's message of "Mon, 22 Dec 2025 12:55:02 +0800")
References: <SYBPR01MB7881327BF7F679E76A7315DEAFB4A@SYBPR01MB7881.ausprd01.prod.outlook.com>
User-Agent: mu4e 1.12.13; emacs 30.2
Date: Mon, 22 Dec 2025 07:41:46 +0200
Message-ID: <871pkndqed.fsf@tarshish>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Junrui,

On Mon, Dec 22 2025, Junrui Luo wrote:
> The digicolor_uart_console_write() function accesses the global
> digicolor_ports[] array to retrieve the uart port pointer, which
> can lead to a use-after-free if the console write occurs after
> the port has been removed via unbind.
>
> digicolor_uart_remove() leaves a dangling pointer in the array.
>
> Fix by clearing the array entry in digicolor_uart_remove() and
> adding a NULL check in digicolor_uart_console_write().

Thanks for the patch.

Is this .write/.remove callbacks race actually possible? Can you refer
me to similar fixes in other drivers?

> Reported-by: Yuhao Jiang <danisjiang@gmail.com>

Where can I find this report?

Thanks,
baruch

> Reported-by: Junrui Luo <moonafterrain@outlook.com>
> Fixes: 5930cb3511df ("serial: driver for Conexant Digicolor USART")
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
> ---
>  drivers/tty/serial/digicolor-usart.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/tty/serial/digicolor-usart.c b/drivers/tty/serial/digicolor-usart.c
> index d2482df5cb9b..5861be2072c4 100644
> --- a/drivers/tty/serial/digicolor-usart.c
> +++ b/drivers/tty/serial/digicolor-usart.c
> @@ -397,6 +397,9 @@ static void digicolor_uart_console_write(struct console *co, const char *c,
>  	unsigned long flags;
>  	int locked = 1;
>  
> +	if (!port)
> +		return;
> +
>  	if (oops_in_progress)
>  		locked = uart_port_trylock_irqsave(port, &flags);
>  	else
> @@ -508,6 +511,7 @@ static void digicolor_uart_remove(struct platform_device *pdev)
>  	struct uart_port *port = platform_get_drvdata(pdev);
>  
>  	uart_remove_one_port(&digicolor_uart, port);
> +	digicolor_ports[port->line] = NULL;
>  }
>  
>  static const struct of_device_id digicolor_uart_dt_ids[] = {
>
> ---
> base-commit: ea1013c1539270e372fc99854bc6e4d94eaeff66
> change-id: 20251222-fixes-74e6b26513d1
>
> Best regards,

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
