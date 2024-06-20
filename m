Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B551AC781;
	Thu, 20 Jun 2024 17:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718902889; cv=none; b=WWZzNINBPw0cmi/9+n3NDv2B3PW7NPaDkJKGL7/EZw1+oaTjMDn0+S8+LNO6JGdURudWr/Avo5HhAu3cfzCbMJLr0xtQLw7IT1+VMJ3y3KXIYOvr2TBqeOJhc5gu17lhtK9GakjFTnQRAZSsJ3Dj8IhE8LSKEgaZyUAQj+AkxHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718902889; c=relaxed/simple;
	bh=+siB3vMlJ1jUpFPr6m8d0KBcSZgmmDz1yAEf6df5jXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HQW00sQ03cwVnQN9B47ECbL1kxUhX9azWZBusDcNHac5GAKytoVFjbYNoQ0xFcPj9EQ9PonSA353ZUjmXdhs3ZRhmq3plFirW5G2IIJ3t5IDiX/zQAzhiuWmUZufBdXWWq9hLJhmeQ9AYln3wO2TRykOBxZG6xQNr6xAIgfG85c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=none smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=BCQYGzj9; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yoseli.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="BCQYGzj9"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7F435240004;
	Thu, 20 Jun 2024 17:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1718902885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UzLTcv1ZRsswBhs9NuHDXBtkvew/o5IUEOxtUsA9i1w=;
	b=BCQYGzj9vJNaLoxUKG3cyKIqg+4XKg2iezV/Tex0R5FwQf+8q0aVx0dIooRhZZFUwM77fe
	RCmK+Jk3QnbRKMwD9FdACQXL+WLTqhNvNxIrMmEvR+Y367tkjWnxVyOv6cjYuRPoSHTAMW
	RQQUtpeDbhh4b1pqaOmQ9026To11tDJTLB6d7U4WdtlPKz/KleEGWDjvOYltfH+1a3CEHb
	gTdB78Fpi7uZ4lQDXomuKnDOvBCSz/sGcwps456Ou0KBqYT7MaikORhYAZKteOE/WQDOt3
	ow6OigFRk3Z7mRK3BwVR03uFxyk2CfJEzRxhaszpkXn7qu79eEwt/y+K1T3NwQ==
Message-ID: <3ca5778e-75fa-4f8c-9bd1-daf5ce4574b9@yoseli.org>
Date: Thu, 20 Jun 2024 19:01:25 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty: mcf: MCF54418 has 10 UARTS
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-m68k@lists.linux-m68k.org
References: <20240620-upstream-uart-v1-1-a9d0d95fb19e@yoseli.org>
 <2024062006-squeezing-traffic-cecb@gregkh>
Content-Language: en-US
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
In-Reply-To: <2024062006-squeezing-traffic-cecb@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: jeanmichel.hautbois@yoseli.org

Hi Greg,

On 20/06/2024 18:58, Greg Kroah-Hartman wrote:
> On Thu, Jun 20, 2024 at 06:29:59PM +0200, Jean-Michel Hautbois wrote:
>> Most of the colfires have up to 5 UARTs but MCF54418 has up-to 10 !
>> Change the maximum value authorized.
>>
>> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
>> ---
>>   drivers/tty/serial/mcf.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/mcf.c b/drivers/tty/serial/mcf.c
>> index b0604d6da025..58858dd352c5 100644
>> --- a/drivers/tty/serial/mcf.c
>> +++ b/drivers/tty/serial/mcf.c
>> @@ -462,7 +462,7 @@ static const struct uart_ops mcf_uart_ops = {
>>   	.verify_port	= mcf_verify_port,
>>   };
>>   
>> -static struct mcf_uart mcf_ports[4];
>> +static struct mcf_uart mcf_ports[10];
> 
> What commit id does this fix?

Sorry about that !
Fixes: 2545cf6e94b4 (m68knommu: allow 4 coldfire serial ports, 2010-03-18)

> 
> thanks,
> 
> greg k-h
