Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1057343D63;
	Wed, 19 Aug 2026 12:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787141762; cv=none; b=Z9lwnNn6WrvCwu5iU4LstEkya59zDRsIdOmqAqRXBWA1yGhU9BJpn3B+kFGZ6I9yqZXgzdJ3METsEOt/9VPwCWJdkGSg1bQ8Q4GtK7MsitYaQe0EMfG4UiFEkdiS3TkX1arrqguY85OVBgUCS5WySTpzhRYlxvktBOozog07moA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787141762; c=relaxed/simple;
	bh=t/0Oydr6ttRgy3Tiy39WxJexHr3TySmIOp4Lp/VS53Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ebxeK7LicCh2voQ7u+61ZNMY4zsOZOC6Z/iEgzzVFBGWXPfYTi55PsvbTWF+pGro1gkoY6hcFl2ZYxbwigb/Aqw/hHK53Be9XHhcypYKi5tohh800fUYtR5hFkRbVeacPaMy8jE7YRupDOcvTL1Xk+6bNSYWlNJurcZkAr2JpiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b89dd65e9bc711f19a56ed5b684f684d-20260819
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:417d8e06-034d-4744-862f-8ef272b87ace,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:47fcd1d5dde46670a3fdac7fb8f547ef,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0|15|52,EDM
	:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b89dd65e9bc711f19a56ed5b684f684d-20260819
X-User: lilinmao@kylinos.cn
Received: from [10.0.2.15] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 183993364; Wed, 19 Aug 2026 20:15:52 +0800
Message-ID: <d4915b7c-9a46-45b1-8b0f-e746772d1e54@kylinos.cn>
Date: Wed, 19 Aug 2026 20:15:48 +0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] serial: 8250_mxpcie: take the line settings from the
 new termios
To: Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260818093918.3190686-1-lilinmao@kylinos.cn>
 <20260818093918.3190686-4-lilinmao@kylinos.cn>
 <aoV-xi0uPEf62-U1@moxa-KabyLake-H>
From: Linmao Li <lilinmao@kylinos.cn>
In-Reply-To: <aoV-xi0uPEf62-U1@moxa-KabyLake-H>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/8/19 18:00, Crescent Hsieh 写道:
> On Tue, Aug 18, 2026 at 05:39:18PM +0800, Linmao Li wrote:
>> mxpcie8250_set_termios() reads the line settings out of
>> port->state->port.tty, which is only set once the port has been opened.
>>
>> uart_set_options() builds a termios of its own and calls ->set_termios()
>> with no tty behind it, so using such a board as the console
>> (console=ttyS<n>) dereferences a NULL tty during console setup, as does
>> attaching kgdboc to it and resuming a suspended console from
>> uart_resume_port().
>>
>> Read the settings from the termios the serial core passes in instead.
>> It holds the same values on the normal path - uart_change_line_settings()
>> passes &tty->termios - and it is what serial8250_do_set_termios() right
>> above already uses.
>>
>> Fixes: 55edf8511f47 ("serial: 8250_mxpcie: enable automatic RTS/CTS flow control")
>> Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
> Hi,
>
> I tested this by configuring kgdboc on a CP-168EL-A. Thanks for the fix.
Thank you for testing it.  May I add your Tested-by to v2?
>
>> ---
>>   drivers/tty/serial/8250/8250_mxpcie.c | 19 ++++++++++---------
>>   1 file changed, 10 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
>> index ddd02d5622ec4..eba59f1724b78 100644
>> --- a/drivers/tty/serial/8250/8250_mxpcie.c
>> +++ b/drivers/tty/serial/8250/8250_mxpcie.c
>> @@ -217,8 +217,7 @@ static void mxpcie8250_set_termios(struct uart_port *port,
>>   				   const struct ktermios *old)
>>   {
>>   	struct uart_8250_port *up = up_to_u8250p(port);
>> -	struct tty_struct *tty = port->state->port.tty;
>> -	unsigned int cflag = tty->termios.c_cflag;
>> +	unsigned int cflag = new->c_cflag;
> Nit: Since cflag is used only once, while c_iflag and c_cc are
> accessed directly through new below, could we drop the local variable
> and use new->c_cflag directly for consistency?

Yes, that reads better.  v2 drops the local and uses new->c_cflag.


Thanks,
Linmao

>
>>   	u8 efr, val;
>>   
>>   	serial8250_do_set_termios(port, new, old);
>> @@ -233,18 +232,20 @@ static void mxpcie8250_set_termios(struct uart_port *port,
>>   		up->port.status |= (UPSTAT_AUTORTS | UPSTAT_AUTOCTS);
>>   	}
>>   	/* Set on-chip software flow control character */
>> -	serial_out(up, MOXA_PUART_XON1, START_CHAR(tty));
>> -	serial_out(up, MOXA_PUART_XON2, START_CHAR(tty));
>> -	serial_out(up, MOXA_PUART_XOFF1, STOP_CHAR(tty));
>> -	serial_out(up, MOXA_PUART_XOFF2, STOP_CHAR(tty));
>> +	serial_out(up, MOXA_PUART_XON1, new->c_cc[VSTART]);
>> +	serial_out(up, MOXA_PUART_XON2, new->c_cc[VSTART]);
>> +	serial_out(up, MOXA_PUART_XOFF1, new->c_cc[VSTOP]);
>> +	serial_out(up, MOXA_PUART_XOFF2, new->c_cc[VSTOP]);
>>   
>> -	val = I_IXON(tty) ? MOXA_PUART_EFR_RX_FLOW_XON1_XOFF1 : MOXA_PUART_EFR_RX_FLOW_DISABLED;
>> +	val = (new->c_iflag & IXON) ? MOXA_PUART_EFR_RX_FLOW_XON1_XOFF1 :
>> +				      MOXA_PUART_EFR_RX_FLOW_DISABLED;
>>   	FIELD_MODIFY(MOXA_PUART_EFR_RX_FLOW_MASK, &efr, val);
>>   
>> -	val = I_IXOFF(tty) ? MOXA_PUART_EFR_TX_FLOW_XON1_XOFF1 : MOXA_PUART_EFR_TX_FLOW_DISABLED;
>> +	val = (new->c_iflag & IXOFF) ? MOXA_PUART_EFR_TX_FLOW_XON1_XOFF1 :
>> +				       MOXA_PUART_EFR_TX_FLOW_DISABLED;
>>   	FIELD_MODIFY(MOXA_PUART_EFR_TX_FLOW_MASK, &efr, val);
>>   
>> -	if (I_IXOFF(tty))
>> +	if (new->c_iflag & IXOFF)
>>   		up->port.status |= UPSTAT_AUTOXOFF;
>>   
>>   	serial_out(up, MOXA_PUART_EFR, efr);
>> -- 
>> 2.25.1
>>
> ---
> Thanks,
> Crescent Hsieh
