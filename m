Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6D33770C;
	Fri,  6 Sep 2024 02:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725588257; cv=none; b=u2RexSaaNdHRK8Ewr0Uwys4aWOQqu3dNv5fR+MGZux+ER8rKOtvePWornQZFuR7dWhYkcDaUwsq0TvwHvrUIE/KmnqbfynleefWl5nrbXXNkvv/kC22bp3I4LrSegFFl1brFYwiiUmPAr3HuRkrk3s5whbVWOhivSIU+j2OqYzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725588257; c=relaxed/simple;
	bh=awWWh4471neVltnSTgYwLXdEobLmgucoHFslH9P7yMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Hte1dSTx9geDTMVfzXSGBFrr+mY3LGfM3xekOAYb1/uUHYteR3jTKrf9eMfi7PT1np3+BwnjjoG6PVT9wjxwEbmruiIwj8wd2jMYGOA7al5Xymn2Fny8RGBJjd9IIApZ0F50eIpgWPsuNGKVcbrfaKkKoV3aRZ7ckA6yH3XiVrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4X0KK13pZsz1j8D6;
	Fri,  6 Sep 2024 10:03:49 +0800 (CST)
Received: from kwepemj200011.china.huawei.com (unknown [7.202.194.23])
	by mail.maildlp.com (Postfix) with ESMTPS id C346E1A0170;
	Fri,  6 Sep 2024 10:04:11 +0800 (CST)
Received: from [10.67.108.52] (10.67.108.52) by kwepemj200011.china.huawei.com
 (7.202.194.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 6 Sep
 2024 10:04:11 +0800
Message-ID: <e043ff91-773c-4f30-a709-5aa5f2215755@huawei.com>
Date: Fri, 6 Sep 2024 10:04:10 +0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] serial: 8250_aspeed_vuart: Enable module
 autoloading
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
CC: <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<gregkh@linuxfoundation.org>, <jirislaby@kernel.org>, <joel@jms.id.au>,
	<andrew@codeconstruct.com.au>, <andi.shyti@linux.intel.com>,
	<andriy.shevchenko@linux.intel.com>, <florian.fainelli@broadcom.com>,
	<tglx@linutronix.de>
References: <20240903131503.961178-1-liaochen4@huawei.com>
 <4nyenalsjnerwjwcuk5zwm52rptnc5jhjhz3yhsmo7qt3gffhs@qadnsjic7p24>
From: "liaochen (A)" <liaochen4@huawei.com>
In-Reply-To: <4nyenalsjnerwjwcuk5zwm52rptnc5jhjhz3yhsmo7qt3gffhs@qadnsjic7p24>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemj200011.china.huawei.com (7.202.194.23)

On 2024/9/3 23:49, Uwe Kleine-König wrote:
> Hello,
> 
> On Tue, Sep 03, 2024 at 01:15:03PM +0000, Liao Chen wrote:
>> Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded based
>> on the alias from of_device_id table.
>>
>> Signed-off-by: Liao Chen <liaochen4@huawei.com>
>> ---
>>   drivers/tty/serial/8250/8250_aspeed_vuart.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
>> index 53d8eee9b1c8..25c201cfb91e 100644
>> --- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
>> +++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
>> @@ -561,6 +561,7 @@ static const struct of_device_id aspeed_vuart_table[] = {
>>   	{ .compatible = "aspeed,ast2500-vuart" },
>>   	{ },
>>   };
>> +MODULE_DEVICE_TABLE(of, aspeed_vuart_table);
> 
> I wonder if you found this entry missing by code review, or if you have
> a machine with that UART and so you actually benefit.

I found it from code review. Since this device could be compiled as a 
module, I think it is better to add this entry.

Thanks,
Chen

> 
> Otherwise looks right to me.
> 
> Acked-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> 
> Best regards
> Uwe

