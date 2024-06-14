Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73075146D60;
	Fri, 14 Jun 2024 09:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718357930; cv=none; b=CARVsPWt0iXfv7Ux+EY/sonJg6+K+r9OS7MuhKVHuFajCymaf5xmzGYTxYDp+tbdq5g6H8h2THbiEsSLoh8DLSkp2Va1uLYeywv4TSsWtNj2H2ujrszqn1kot4XjISMYRVB72wMPD1Tg1PQ2C3cmRvGIZ3fKyjDiKeysw5GiHiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718357930; c=relaxed/simple;
	bh=kW+SCAQawYl8bZMtdCDZoUjYRzo1vwUwV0SeNPSeCSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZN5ESiE72h9Iq7jdkXgwLcR/Tohq3EjULAj0992bwU5d0r+xpf6/EMX1r/Guh9FYFNL+DpTv+KjYMeU1fZ5VYea6NaUgGueVNwcX0FpgFbAT15Fmv41fzUja+CKFXk1mLsDQSPoSEPM5gqKUMS4DXzyXgs3uaiICgs/n7fPBjgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=PFpSLKrJ; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PFpSLKrJ"
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45E9cGDA028195;
	Fri, 14 Jun 2024 04:38:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718357896;
	bh=+NFx58AC1+71lCRJDZfMbX16MlBwFV95gQE5TWMIO4Q=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=PFpSLKrJELc6ngh9c31BMZPkzItAmQU/yGRdFI0BrL9B5R52McQnNTkKvICmf2lTY
	 NVWFOjRShlhjanbrzF+WWOO37xHRBu7LEzhl/fb2MoSG1td2KqXaIkmT4QixJm8M6S
	 c4JOQSBztuqwXcupkcaIda2IKNlUZlhiLPGcqyvw=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45E9cGfa019267
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 14 Jun 2024 04:38:16 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 14
 Jun 2024 04:38:15 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 14 Jun 2024 04:38:15 -0500
Received: from [172.24.18.200] (lt5cd2489kgj.dhcp.ti.com [172.24.18.200])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45E9cCJh106972;
	Fri, 14 Jun 2024 04:38:12 -0500
Message-ID: <ee080b5d-49eb-4c5e-8076-76b1928dc5e0@ti.com>
Date: Fri, 14 Jun 2024 15:08:11 +0530
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: 8250_omap: Implementation of Errata i2310
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <vigneshr@ti.com>, <nm@ti.com>, Tony Lindgren <tony@atomide.com>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby
	<jirislaby@kernel.org>, <ronald.wahl@raritan.com>,
        <thomas.richard@bootlin.com>, <tglx@linutronix.de>,
        LKML
	<linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>
References: <20240614061314.290840-1-u-kumar1@ti.com>
 <9ed7e96a-c538-aac1-5b52-b7b1d72bb6a0@linux.intel.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <9ed7e96a-c538-aac1-5b52-b7b1d72bb6a0@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


On 6/14/2024 1:58 PM, Ilpo Järvinen wrote:
> On Fri, 14 Jun 2024, Udit Kumar wrote:
>
>> As per Errata i2310[0], Erroneous timeout can be triggered,
>> if this Erroneous interrupt is not cleared then it may leads
>> to strom of interrupts, therefore apply Errata i2310 solution.
>>
>> [0] https://www.ti.com/lit/pdf/sprz536 page 23
>>
>> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
>> ---
>>   drivers/tty/serial/8250/8250_omap.c | 25 ++++++++++++++++++++-----
>>   1 file changed, 20 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
>> index 170639d12b2a..38eb639f78d3 100644
>> --- a/drivers/tty/serial/8250/8250_omap.c
>> +++ b/drivers/tty/serial/8250/8250_omap.c
>> @@ -115,6 +115,10 @@
>>   /* RX FIFO occupancy indicator */
>>   #define UART_OMAP_RX_LVL		0x19
>>   
>> +/* Timeout Low and High */
>> +#define UART_OMAP_TO_L                 0x26
>> +#define UART_OMAP_TO_H                 0x27
>> +
>>   /*
>>    * Copy of the genpd flags for the console.
>>    * Only used if console suspend is disabled
>> @@ -663,13 +667,24 @@ static irqreturn_t omap8250_irq(int irq, void *dev_id)
>>   
>>   	/*
>>   	 * On K3 SoCs, it is observed that RX TIMEOUT is signalled after
>> -	 * FIFO has been drained, in which case a dummy read of RX FIFO
>> -	 * is required to clear RX TIMEOUT condition.
>> +	 * FIFO has been drained or erroneously.
>> +	 * So apply solution of Errata i2310 as mentioned in
>> +	 * https://www.ti.com/lit/pdf/sprz536
>>   	 */
>>   	if (priv->habit & UART_RX_TIMEOUT_QUIRK &&
>> -	    (iir & UART_IIR_RX_TIMEOUT) == UART_IIR_RX_TIMEOUT &&
>> -	    serial_port_in(port, UART_OMAP_RX_LVL) == 0) {
>> -		serial_port_in(port, UART_RX);
>> +		(iir & UART_IIR_RX_TIMEOUT) == UART_IIR_RX_TIMEOUT) {
>> +		unsigned char efr2, timeout_h, timeout_l;
>> +
>> +		efr2 = serial_in(up, UART_OMAP_EFR2);
>> +		timeout_h = serial_in(up, UART_OMAP_TO_H);
>> +		timeout_l = serial_in(up, UART_OMAP_TO_L);
>> +		serial_out(up, UART_OMAP_TO_H, 0xFF);
>> +		serial_out(up, UART_OMAP_TO_L, 0xFF);
>> +		serial_out(up, UART_OMAP_EFR2, 0x1);
> Eh, this doesn't match the workaround in the errata???
>
> Also, don't use literals but name the bits with defines (for the correct
> bit there's probably a pre-existing define but it's not named as good as
> it could be, I'd say it should be named as
> UART_OMAP_EFR2_TIMEOUT_PERIODIC).


Thanks, will address in v2.


>
>> +		serial_in(up, UART_IIR);
>> +		serial_out(up, UART_OMAP_EFR2, efr2);
>> +		serial_out(up, UART_OMAP_TO_H, timeout_h);
>> +		serial_out(up, UART_OMAP_TO_L, timeout_l);
