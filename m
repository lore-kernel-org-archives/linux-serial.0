Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C291D799C;
	Tue,  5 Nov 2024 13:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730812208; cv=none; b=BgjcwZ/P+7NUZHdfAX0XVIUnzESuZDlirdyQMHJFpc4GCK7VwIz2Gh2krrdHht4qMFm5KyO0GzItCylMIoqe35Q2szg5+Aq9NZ0ySTPYQEDWspswAyF1qvruNlfKTzUKsXisoECJNwcABliBgpz7Itm6nNgMqXICiot54Jzcbvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730812208; c=relaxed/simple;
	bh=+8XOSTNhPBKGPhUJrgTNS1ia9qggP1F2QNA4IObcVJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GT9iLdi2gXwGihFyvmDnbPkbGvBFocbjjulv5Yv2iouBJqoNThrJpqTA638bmKNiehXadRM7Y14vi2W/PRPKdDrr2uvOC+dYj8UVXHnRFzOUyMsIR0JiR88IghF5muh3Q5GelQ7ibK9npMxwdE1fsLD9oRUs2PJuHqcPDNYL+LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Xu8Fuyz0; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Xu8Fuyz0"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4CD9A240003;
	Tue,  5 Nov 2024 13:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730812203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dAWzS0LPoX0leakY4JsHrMBVnGBVUcCyJRfz777KU5w=;
	b=Xu8Fuyz0zX6v2NsrBoblzmLGLziQHwMLe3FP2p1gjdIVo7K7W8wrWqkOB3ZLOboaOGoLh3
	XBhkexYXuR3m/er1JWdULmDIL8fzKIEZ6WywmjqOflhoW80/yShDYHsYXgv8ZQXTB/Mo4w
	M4czZ11xb/2drdo7DWg4/NHNfVx+LLDgAMzlzOrUWnZZscHbkT+zBj6E6OCiVieIiuO0DB
	JK0WSZ2A1BUnMwnyYxiEyfiwRbbAE+8wZGUE9NrDWVRF1VdaAcKauMYh5b/tvuAZQGXBFs
	0MR+1/lWBljod9wSHgXLHFza5Rc9t4w0ynzwzuAKBuTnsX81UlHBDnhX0oNCtA==
Message-ID: <94726cb7-7cd5-48cf-b158-a66e6b279058@bootlin.com>
Date: Tue, 5 Nov 2024 14:10:02 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Typo: Fix typo in atmel_serial.c
To: Hari.PrasathGE@microchip.com, cvam0000@gmail.com
Cc: alexandre.belloni@bootlin.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 claudiu.beznea@tuxon.dev, jirislaby@kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20241024172300.968015-1-cvam0000@gmail.com>
 <5933bb3c-3b1e-4579-88c6-b9bbbed93a4f@microchip.com>
Content-Language: en-US, fr
From: Richard GENOUD <richard.genoud@bootlin.com>
Organization: Bootlin
In-Reply-To: <5933bb3c-3b1e-4579-88c6-b9bbbed93a4f@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: richard.genoud@bootlin.com

Le 05/11/2024 à 13:18, Hari.PrasathGE@microchip.com a écrit :
> Hi,
> 
> On 10/24/24 10:53 PM, Shivam Chaudhary wrote:
>> [You don't often get email from cvam0000@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> Corrected minor typo in atmel_serial.c
>> - Fixed "retreives" to "retrieves"
>>
> 
> Pls fix the subject line. Refer to the previous commits from the git log
> of the same file. Also,the commit message should be in imperative mood.
> Send a v2 with the above comments addressed. Some useful links below:
> 
> https://kernelnewbies.org/FirstKernelPatch
> https://kernelnewbies.org/PatchPhilosophy

And for this kind of patches, I think it should go through the 
kernel-janitors ML.

Regards,
Richard
> 
> Regards,
> Hari
> 
>> Signed-off-by: Shivam Chaudhary <cvam0000@gmail.com>
>> ---
>>    drivers/tty/serial/atmel_serial.c | 2 +-
>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
>> index 09b246c9e389..bb1978db6939 100644
>> --- a/drivers/tty/serial/atmel_serial.c
>> +++ b/drivers/tty/serial/atmel_serial.c
>> @@ -1166,7 +1166,7 @@ static void atmel_rx_from_dma(struct uart_port *port)
>>                   port->icount.rx += count;
>>           }
>>
>> -       /* USART retreives ownership of RX DMA buffer */
>> +       /* USART retrieves ownership of RX DMA buffer */
>>           dma_sync_single_for_device(port->dev, atmel_port->rx_phys,
>>                                      ATMEL_SERIAL_RX_SIZE, DMA_FROM_DEVICE);
>>
>> --
>> 2.34.1
>>
>>

