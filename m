Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5087E2B9A5;
	Tue,  2 Jul 2024 04:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719893075; cv=none; b=tSpmNCX4GYUHd7dooblQdWAIKrsWc94IrxdcIxvA1IxrN3orolmOUyeQdXjjBMFtugUcHb6JyJytx28u3ZkQqF/EE8RD3IDIZY3GjoBPxW0C3NosXkU8fo3+rwLW6VaXMm9LikDE8c5B9GcfYCcvtJZMCWTPw6EUpTEJsIuP5n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719893075; c=relaxed/simple;
	bh=PjOPq/KxgdAbmyXPSE1+iFm7bMKb7JfGCfUQymEbRzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TobYRM3PRCXtUiABGxLqIDkDg67lmjSuA4aQwMpphxZUVMHqaa73dSEunOOM3AOJ7zNIakjq9ARHjseCoVl54qq9XM7oul4GOe8Nzz2A0HMSmblEkMyFSNjU1thsISZ7ixE+Dr/adEHK/Xb2kBvwHHC0P0Ia/LupGx8NPCkW+as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=gm0RF4Hw; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="gm0RF4Hw"
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 4FD458871C;
	Tue,  2 Jul 2024 06:04:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1719893071;
	bh=cwSotBxejvSMra+ZSFbi6qdkr/Lg5NoHvKxFGJcRHsI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gm0RF4Hwm96KgeUnZYKga3luMPjM9fU6FNUrgRHyiCbQvqIwN9WURROOA9/h895nm
	 uIaYXfxEtfG0kuRsrQ2H7HvFHKkAuEEzCIyIrfHY+i227reZJLY+f5khvj3PfRgOrb
	 DNUteB3Ensk0eYWbU7rO7oxfr9ztyHi/fmpIPsyII7UTuLNmOAlS6FP6GYd0IXn6er
	 XnQ0BrPxSaHNK5KehgdoECI/y4zBN/gFve33Hc29YOagHOQzDzvWlChu0Z7rgjdzvt
	 YFjo6ecqEX3BDeiDlVNZiuznFP4k3i/okKXGY6mKx5SONwR+ANTiDWTu6GMJN8XgKG
	 h1hSJc4Lo6llw==
Message-ID: <d36485a2-7cce-44be-b70f-54b00d671861@denx.de>
Date: Tue, 2 Jul 2024 06:02:41 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] serial: imx: ensure RTS signal is not left active
 after shutdown
To: Fabio Estevam <festevam@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
References: <20240625184206.508837-1-linux@rasmusvillemoes.dk>
 <CAOMZO5AejtxU4hTMWa8PK9duXYAKUGzGm_mmeLuEW=tRk7GSCQ@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAOMZO5AejtxU4hTMWa8PK9duXYAKUGzGm_mmeLuEW=tRk7GSCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 6/25/24 10:39 PM, Fabio Estevam wrote:
> [Adding Christoph and Marek]
> 
> On Tue, Jun 25, 2024 at 3:42 PM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
>>
>> If a process is killed while writing to a /dev/ttymxc* device in RS485
>> mode, we observe that the RTS signal is left high, thus making it
>> impossible for other devices to transmit anything.
>>
>> Moreover, the ->tx_state variable is left in state SEND, which means
>> that when one next opens the device and configures baud rate etc., the
>> initialization code in imx_uart_set_termios dutifully ensures the RTS
>> pin is pulled down, but since ->tx_state is already SEND, the logic in
>> imx_uart_start_tx() does not in fact pull the pin high before
>> transmitting, so nothing actually gets on the wire on the other side
>> of the transceiver. Only when that transmission is allowed to complete
>> is the state machine then back in a consistent state.
>>
>> This is completely reproducible by doing something as simple as
>>
>>    seq 10000 > /dev/ttymxc0
>>
>> and hitting ctrl-C, and watching with a logic analyzer.
>>
>> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>> ---
>> v2: Use dev_warn() instead of dev_WARN_ONCE().
>>
>> v1: https://lore.kernel.org/lkml/20240524121246.1896651-1-linux@rasmusvillemoes.dk/
>>
>> A screen dump from a logic analyzer can be seen at:
>>
>>    https://ibb.co/xCcP7Jy
>>
>> This is on an imx8mp board, with /dev/ttymxc0 and /dev/ttymxc2 both
>> configured for rs485 and connected to each other. I'm writing to
>> /dev/ttymxc2. This demonstrates both bugs; that RTS is left high when
>> a write is interrupted, and that a subsequent write actually fails to
>> have RTS high while TX'ing.
>>
>> I'm not sure what commit to name as a Fixes:. This certainly happens
>> on 6.6 and onwards, but I assume the problem exists since the tx_state
>> machine was introduced in cb1a60923609 (serial: imx: implement rts
>> delaying for rs485), and possibly even before that.

Wow, thank you for the detailed analysis of the issue.

Reviewed-by: Marek Vasut <marex@denx.de>
