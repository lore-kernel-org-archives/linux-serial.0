Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24531DDD9
	for <linux-serial@vger.kernel.org>; Thu, 18 Jan 2024 15:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705590060; cv=none; b=Y7cu5OlIZYCf2HYUKW59R4mn9uhVDWvWyAFgJ5dMsziEcAwkhB81AsDSGj/q2zVbbM6xcCHjD9QjI8zJ3Pkr0O7caE8pv2gFkTQaX2+gM9ZrKMVqK103ZSjzuZmnt9eNyLKo+EDjXHCxpa6kvJWV1nyDnLqzGkPBKLNJu2GKoQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705590060; c=relaxed/simple;
	bh=6rHuHZVInsJG2lEzJY4lEK+ocHb9GkGwP1h4qWp+XFI=;
	h=DKIM-Signature:Received:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding:X-SA-Exim-Connect-IP:X-SA-Exim-Mail-From:
	 X-Spam-Checker-Version:X-Spam-Level:X-Spam-Report:X-Spam-Status:
	 Subject:X-SA-Exim-Version:X-SA-Exim-Scanned; b=ojTTV0Al92Y6rcuZ3+O6sL6yOhszYFDAnKdcvciOsWrqXM2V+OrI/g3mEfbwvN9wMFdtQMid+i5CzPtczsen+HhFLojavaez1o5YxlFv12zfvt4Jpvb6kd6oMNcSiqI5Ts/p6CDLdgQKbBk0IvLFtPyEqgwLLgSMMwTKJRTJv+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=ymtBj7H7; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="ymtBj7H7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=oIasUBN4lV6VWChw5fNJuOaqs+4Z5ywxZ211LhMgxjc=; b=ymtBj7H7Qk1H51yZvIey9JETXk
	XGeRho/P3j153eBT8kBJazV/aVM90F9ehtSyHNdWjXABAADOjnrtkrtbaIMwwYwXcy3XfQehTL8RN
	FVb43naqqierwoSS850uhyqcR8LArY0F4/XUNIq1l/i2FApaq/hmhme8H9PcFphHGSeA=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:57218 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rQTsw-0002Ts-BV; Thu, 18 Jan 2024 10:00:51 -0500
Date: Thu, 18 Jan 2024 10:00:49 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: <linux-serial@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Crescent CY Hsieh
 <crescentcy.hsieh@moxa.com>, Jiri Slaby <jirislaby@kernel.org>, Lukas
 Wunner <lukas@wunner.de>, Lino Sanfilippo <l.sanfilippo@kunbus.com>
Message-Id: <20240118100049.0e17d2d8808df7905ff45d71@hugovil.com>
In-Reply-To: <20240118124350.3772-1-cniedermaier@dh-electronics.com>
References: <20240118124350.3772-1-cniedermaier@dh-electronics.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
	* -1.7 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [PATCH] tty: serial: Fix bit order in RS485 flag definitions
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Thu, 18 Jan 2024 13:43:50 +0100
Christoph Niedermaier <cniedermaier@dh-electronics.com> wrote:

> Since the commit 93f3350c46fa ("RS485: fix inconsistencies in the
> meaning of some variables"), the definition for bit 3 has been removed.
> But with the switch to bit shift marcos in commit 76ac8e29855b ("tty:

marcos -> macros

Hugo Villeneuve

> serial: Cleanup the bit shift with macro"), this gap wasn't preserved.
> To avoid a break in user/kernel api of the system skip bit 3 again and
> add a placeholder comment.
> 
> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> ---
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> To: linux-serial@vger.kernel.org
> To: linux-arm-kernel@lists.infradead.org
> ---
>  include/uapi/linux/serial.h | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/include/uapi/linux/serial.h b/include/uapi/linux/serial.h
> index 9086367db043..de9b4733607e 100644
> --- a/include/uapi/linux/serial.h
> +++ b/include/uapi/linux/serial.h
> @@ -145,12 +145,13 @@ struct serial_rs485 {
>  #define SER_RS485_ENABLED		_BITUL(0)
>  #define SER_RS485_RTS_ON_SEND		_BITUL(1)
>  #define SER_RS485_RTS_AFTER_SEND	_BITUL(2)
> -#define SER_RS485_RX_DURING_TX		_BITUL(3)
> -#define SER_RS485_TERMINATE_BUS		_BITUL(4)
> -#define SER_RS485_ADDRB			_BITUL(5)
> -#define SER_RS485_ADDR_RECV		_BITUL(6)
> -#define SER_RS485_ADDR_DEST		_BITUL(7)
> -#define SER_RS485_MODE_RS422		_BITUL(8)
> +/* Placeholder for bit 3: SER_RS485_RTS_BEFORE_SEND, which isn't used anymore */
> +#define SER_RS485_RX_DURING_TX		_BITUL(4)
> +#define SER_RS485_TERMINATE_BUS		_BITUL(5)
> +#define SER_RS485_ADDRB			_BITUL(6)
> +#define SER_RS485_ADDR_RECV		_BITUL(7)
> +#define SER_RS485_ADDR_DEST		_BITUL(8)
> +#define SER_RS485_MODE_RS422		_BITUL(9)
>  
>  	__u32	delay_rts_before_send;
>  	__u32	delay_rts_after_send;
> -- 
> 2.11.0
> 
> 
