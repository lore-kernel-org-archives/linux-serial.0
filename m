Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D30A1848;
	Fri, 31 May 2024 15:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.23.86.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717168380; cv=none; b=tNSu7mFHU8iGZSChNgsD3S/r5nv+uelEBsBXlEpiRgDrPzqXa3yg8+4PZDgBAN/yn6l2Hl0J7GykSlyVHiOEzy8YbJc40+kZGvSn3lmPedduTtZ3ryWD7hEF+/btKC3RcAc2tnCI7nQ95nr5U6JYHHqMEhRGqolDjtJzxakbXeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717168380; c=relaxed/simple;
	bh=/iWDpVJw1GK4gVih8nweVgtydmcqAVcnqRMEQTtTvtg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L/vHNU60R6fUSndVGxxwOgs23z/oTP1OOu+vQERaqkrBNygqrnkqBoiwSYZSeP277VqOZR4R/dwTCxWN1cfJln+EjCvIA6q82ZggciZnvNaktlZXq55zqpDPE0HBbJ+5ZnHsKRdYS1P6nqCie9JmGfkWAEEy7xypjzBmbs1BCZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zonque.org; spf=pass smtp.mailfrom=zonque.org; arc=none smtp.client-ip=46.23.86.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zonque.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zonque.org
Received: from [192.168.178.57] (pd95efb9d.dip0.t-ipconnect.de [217.94.251.157])
	by mail.bugwerft.de (Postfix) with ESMTPSA id 47BE12806FF;
	Fri, 31 May 2024 15:12:56 +0000 (UTC)
Message-ID: <bc4d9470-340c-4559-b56f-7cce89c45d0b@zonque.org>
Date: Fri, 31 May 2024 17:12:55 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: sc16is7xx: set driver name
To: Greg KH <gregkh@linuxfoundation.org>
Cc: hvilleneuve@dimonoff.com, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240531101959.181457-1-daniel@zonque.org>
 <2024053127-custody-bankable-817d@gregkh>
Content-Language: en-US
From: Daniel Mack <daniel@zonque.org>
In-Reply-To: <2024053127-custody-bankable-817d@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/31/24 12:27, Greg KH wrote:
> On Fri, May 31, 2024 at 12:19:59PM +0200, Daniel Mack wrote:
>> Set the drv_name field of the driver struct so that the tty core
>> registers a procfs entry for it. This is useful for debugging.
>>
>> Signed-off-by: Daniel Mack <daniel@zonque.org>
>> ---
>>  drivers/tty/serial/sc16is7xx.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
>> index bf0065d1c8e9..308edbacda7b 100644
>> --- a/drivers/tty/serial/sc16is7xx.c
>> +++ b/drivers/tty/serial/sc16is7xx.c
>> @@ -351,6 +351,7 @@ static struct uart_driver sc16is7xx_uart = {
>>  	.owner		= THIS_MODULE,
>>  	.driver_name    = SC16IS7XX_NAME,
>>  	.dev_name	= "ttySC",
>> +	.driver_name	= SC16IS7XX_NAME,
> 
> Are you sure this patch is correct?  Look 2 lines up :)
> 

Oh, Hugo did that already. Sorry for the noise.


Daniel

