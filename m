Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F47638C42E
	for <linux-serial@vger.kernel.org>; Tue, 26 May 2026 20:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779828652; cv=none; b=OjwkiC7GJeC7GvJuap2vYSIp4gF2vZoUKrnfcQM4m3X15+u+k07sxQ0KowfPmN4m8UpMNal3jrDmLMQtoHCFpAH34kcEk50ADxx4UX2mzgvwQ7r7WCVP5u++DkYLJP9tUJZELRlhR868WCI9F7owrMWcVqOhwQuwPm52ga0icjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779828652; c=relaxed/simple;
	bh=kFuLkAx/RroeJRQp/2SMjNt8IgUShjhBxbQAUNpK5WQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YJIu3mjhs7z2HLBvmIbGo2Jq5oD8Yi/LiBwO/ZIri87ULN6M7xdKtLUB/2Th1hrLEdjnLIW1r1aZWTkUN39mOyDuI2xZAb17+RH9VIdNAcc5Q03WtihTlY1VQ9FtXETKB7FuhsPaFU8JypFdrvjNpA03V+yMoMiNP3HcVcu7C60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=DPh376UQ; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="DPh376UQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1779828638; x=1780433438; i=wahrenst@gmx.net;
	bh=HJbySKicbgceo9Bty0jQa0ru4LHAM/agStxZBIV1FME=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=DPh376UQE7SVGS1PU1+HP3ch/ggniABIT9geXJCJYaUvbD2MpPd6ahe5pUsNQX9E
	 rCyUlo3vuq2CXP9nZut8XqnYani5J4WsDFwLF5TvDqZjdK67uCgY15JeDTSrP9I0s
	 hYNSwviJv1VQbhnUkZPNspWhtDK7aaXvCECz039oFCDjnJ/uFkXTQiIjLpDlq7Jya
	 PJTaCaKPtK3zsrIvW/k8nKZF9wkWRxhEYWKSbkEDMbvM/F7QixB7STyLIHS1EXjqX
	 jCgGbLO3Tfu48EIfCAxnGpBx/5hg4PVd9caIXrU93sr9VbiMV3R+dk1da6aAmytHy
	 PHuhEbuxUdVcIbXRZA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M4s0t-1wQb1N1eUh-008SiQ; Tue, 26
 May 2026 22:50:38 +0200
Message-ID: <2008febf-0eb6-4956-bd38-644c196bfaf0@gmx.net>
Date: Tue, 26 May 2026 22:50:37 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT] tty: serial: fsl_lpuart: Add register dump
To: Sherry Sun <sherry.sun@nxp.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Ingo Molnar <mingo@kernel.org>, Frank Li <frank.li@nxp.com>,
 "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
References: <20260526140113.50372-1-wahrenst@gmx.net>
 <VI0PR04MB1211492AAE8858FD14187E922920B2@VI0PR04MB12114.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
Autocrypt: addr=wahrenst@gmx.net; keydata=
 xjMEZ1dOJBYJKwYBBAHaRw8BAQdA7H2MMG3q8FV7kAPko5vOAeaa4UA1I0hMgga1j5iYTTvN
 IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5uZXQ+wo8EExYIADcWIQT3FXg+ApsOhPDN
 NNFuwvLLwiAwigUCZ1dOJAUJB4TOAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEG7C8svCIDCK
 JQ4BAP4Y9uuHAxbAhHSQf6UZ+hl5BDznsZVBJvH8cZe2dSZ6AQCNgoc1Lxw1tvPscuC1Jd1C
 TZomrGfQI47OiiJ3vGktBc44BGdXTiQSCisGAQQBl1UBBQEBB0B5M0B2E2XxySUQhU6emMYx
 f5QR/BrEK0hs3bLT6Hb9WgMBCAfCfgQYFggAJhYhBPcVeD4Cmw6E8M000W7C8svCIDCKBQJn
 V04kBQkHhM4AAhsMAAoJEG7C8svCIDCKJxoA/i+kqD5bphZEucrJHw77ujnOQbiKY2rLb0pE
 aHMQoiECAQDVbj827W1Yai/0XEABIr8Ci6a+/qZ8Vz6MZzL5GJosAA==
In-Reply-To: <VI0PR04MB1211492AAE8858FD14187E922920B2@VI0PR04MB12114.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:jKkD+5LQO3GBkO6duZVPhscJMOXFN3WEnXshNwPPotFaSRq9yHI
 QLz1TjxtjDg+X6pBd3iGAp+9VHJ/u+KecGiGij/BXow/yzJ4hKiTNPHdVr5nxMHgCjzpvl5
 VxuAbML83bAYqaeQ5j+QWuKRlYJDzbF43lb+hmTpwDxIqO99kGFYkbk8HP2S3u1QHNDmhzn
 bZn48Z/4VMhMTjpCCMsGQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:peatfHGz4mo=;/3v+pxnwMLdcIRVAyQ4MUWpdPuQ
 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
 FDKi+7WakXVBILC0LaH+lSPe87tjgGV74TCz502

Hi Sherry,

Am 26.05.26 um 17:21 schrieb Sherry Sun:
>> Subject: [PATCH RFT] tty: serial: fsl_lpuart: Add register dump
>>
>> Dumping the registers from userspace for debug purposes isn't trivial,
>> because runtime PM can gate the required clocks and any read access to
>> these registers would result in a lockup.
>>
>> So implement a register dump via debugfs, which deals with the runtime PM.
> No need, you can disable runtime pm from user space before dump the registers.
> For example: echo on > /sys/bus/platform/devices/29860000.serial/power/control
so "comfort" wouldn't be an argument for this change?
I'm asking, because this isn't the first driver with a regdump via debugfs.

Best regards
>
> Best Regards
> Sherry
>> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
>> ---
>>
>> Hi, I only have access to a board (i.MX93) with 32 bit registers, so it would be
>> great if someone could test it for 8 bit registers.
>>
>> Thanks
>>
>>   drivers/tty/serial/fsl_lpuart.c | 69 +++++++++++++++++++++++++++++++++
>>   1 file changed, 69 insertions(+)
>>
>> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c index
>> 1bd7ec9c81ea..7e4b3e59414a 100644
>> --- a/drivers/tty/serial/fsl_lpuart.c
>> +++ b/drivers/tty/serial/fsl_lpuart.c
>> @@ -10,6 +10,7 @@
>>   #include <linux/circ_buf.h>
>>   #include <linux/clk.h>
>>   #include <linux/console.h>
>> +#include <linux/debugfs.h>
>>   #include <linux/delay.h>
>>   #include <linux/dma-mapping.h>
>>   #include <linux/dmaengine.h>
>> @@ -23,6 +24,7 @@
>>   #include <linux/pinctrl/consumer.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/pm_runtime.h>
>> +#include <linux/seq_file.h>
>>   #include <linux/serial_core.h>
>>   #include <linux/slab.h>
>>   #include <linux/tty_flip.h>
>> @@ -291,6 +293,8 @@ struct lpuart_port {
>>   	bool			is_cs7; /* Set to true when character size is 7
>> */
>>   					/* and the parity is enabled
>> 	*/
>>   	bool			dma_idle_int;
>> +
>> +	struct dentry		*debugfs_dir;
>>   };
>>
>>   struct lpuart_soc_data {
>> @@ -1031,6 +1035,7 @@ static void lpuart32_rxint(struct lpuart_port *sport)
>>   	}
>>
>>   out:
>> +
>>   	uart_unlock_and_check_sysrq(&sport->port);
>>
>>   	tty_flip_buffer_push(port);
>> @@ -2860,6 +2865,67 @@ static int lpuart_global_reset(struct lpuart_port
>> *sport)
>>   	return 0;
>>   }
>>
>> +#ifdef CONFIG_DEBUG_FS
>> +
>> +#define dump_register_hex(_seq, _reg, _sport) \ seq_printf((_seq),
>> +"%-12s: 0x%02x\n", #_reg, readb((_sport)->port.membase + (_reg)))
>> +
>> +#define dump_register32_hex(_seq, _reg, _sport) \ seq_printf((_seq),
>> +"%-12s: 0x%08x\n", #_reg, lpuart32_read(&(_sport)->port, _reg))
>> +
>> +static int regs_show(struct seq_file *s, void *p) {
>> +	struct lpuart_port *sport = s->private;
>> +
>> +	pm_runtime_get_sync(sport->port.dev);
>> +
>> +	if (lpuart_is_32(sport)) {
>> +		dump_register32_hex(s, UARTBAUD, sport);
>> +		dump_register32_hex(s, UARTSTAT, sport);
>> +		dump_register32_hex(s, UARTCTRL, sport);
>> +		dump_register32_hex(s, UARTMATCH, sport);
>> +		dump_register32_hex(s, UARTMODIR, sport);
>> +		dump_register32_hex(s, UARTFIFO, sport);
>> +		dump_register32_hex(s, UARTWATER, sport);
>> +	} else {
>> +		dump_register_hex(s, UARTBDH, sport);
>> +		dump_register_hex(s, UARTBDL, sport);
>> +		dump_register_hex(s, UARTCR1, sport);
>> +		dump_register_hex(s, UARTCR2, sport);
>> +		dump_register_hex(s, UARTSR1, sport);
>> +		dump_register_hex(s, UARTCR3, sport);
>> +		dump_register_hex(s, UARTDR, sport);
>> +		dump_register_hex(s, UARTCR4, sport);
>> +		dump_register_hex(s, UARTCR5, sport);
>> +		dump_register_hex(s, UARTMODEM, sport);
>> +		dump_register_hex(s, UARTPFIFO, sport);
>> +		dump_register_hex(s, UARTCFIFO, sport);
>> +		dump_register_hex(s, UARTSFIFO, sport);
>> +		dump_register_hex(s, UARTTWFIFO, sport);
>> +		dump_register_hex(s, UARTTCFIFO, sport);
>> +		dump_register_hex(s, UARTRWFIFO, sport);
>> +	}
>> +
>> +	pm_runtime_mark_last_busy(sport->port.dev);
>> +	pm_runtime_put_autosuspend(sport->port.dev);
>> +
>> +	return 0;
>> +}
>> +
>> +DEFINE_SHOW_ATTRIBUTE(regs);
>> +
>> +static void lpuart_init_debugfs(struct lpuart_port *sport) {
>> +	sport->debugfs_dir = debugfs_create_dir(dev_name(sport-
>>> port.dev),
>> +						NULL);
>> +
>> +	debugfs_create_file("regs", 0400, sport->debugfs_dir, sport,
>> +&regs_fops); }
>> +
>> +#else
>> +static inline void lpuart_init_debugfs(struct lpuart_port *sport) {}
>> +#endif
>> +
>>   static int lpuart_probe(struct platform_device *pdev)  {
>>   	const struct lpuart_soc_data *sdata =
>> of_device_get_match_data(&pdev->dev);
>> @@ -2969,6 +3035,8 @@ static int lpuart_probe(struct platform_device
>> *pdev)
>>   	if (ret)
>>   		goto failed_irq_request;
>>
>> +	lpuart_init_debugfs(sport);
>> +
>>   	return 0;
>>
>>   failed_irq_request:
>> @@ -2987,6 +3055,7 @@ static void lpuart_remove(struct platform_device
>> *pdev)  {
>>   	struct lpuart_port *sport = platform_get_drvdata(pdev);
>>
>> +	debugfs_remove_recursive(sport->debugfs_dir);
>>   	uart_remove_one_port(&lpuart_reg, &sport->port);
>>
>>   	lpuart_disable_clks(sport);
>> --
>> 2.43.0

