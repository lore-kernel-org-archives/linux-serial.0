Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8877364F;
	Wed, 12 Jun 2024 00:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718153040; cv=none; b=cYPrRxVH9WFlTKo9AaZKISCTOQQyRMveCmOXOLDP7l4OXpnifZqmZslg7VrxE7DSvo7MADx6bpU2rAHjgOiiDHHuW6YF2NYi+/x6TXix1LtxOFi/AwKRxrZ1Fk0cUwU+B2feWka3a/wKPsN9pv97Le1PJcUMim6dJz7xF4kreMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718153040; c=relaxed/simple;
	bh=b9mo09yNzGoE/7R3RSYrjl4NabCxMXQrrMwm9TWQX0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e6Qp4uGnk2LtSTQaVWBkgXcOsLjIQvIoPR5MHZ6tR8+pAoh/Ue979/UfSScBarmtdg5pFN0xVcJo5LJAPB1fBIuhQocODOxPGgv1n1xhaYMqWDKG7ym0rb+WPiVlO5ONtNpl48ref1hTBsCOo7IJ7i8t+/WkMQ0F+5W2utsYWIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zeu1wSQx; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zeu1wSQx"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6f96f8489feso2428405a34.0;
        Tue, 11 Jun 2024 17:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718153037; x=1718757837; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5NTY7O9vlYiJDnsoEIMvSsij28gjoEQl+bA1Z5C+Mlg=;
        b=Zeu1wSQxYbmLL6zsVamzpj5+yPFDw07sZETHo5a9Hb/zgGxMBjmxaA4+4ovQxxp+Qy
         X0uK19zEGNW8xH8fbctU1TgilLoyxiWczlTM3O6oDj/wGm39Kdjcv7y4/4w2GfYGdtLY
         /Zn4vAHzndftqAC6RfjU9taU1ISL/0Lw7ELDdvOauEllNAvPv4dZTFGRVS8nFtltFKj0
         wubcFPrqhk/YVYPy5aCpPEBV2pv5Oy8o0kOQN6qif244Sw+FLYN6lR3Twollz26zPsgo
         /i3fd0UdnrMpzO5TSeTo2XjZsFMiHGn0pHoR5GL0XWmh+Q56tjSybnWcKgRxl4ii/eN5
         aPKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718153037; x=1718757837;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5NTY7O9vlYiJDnsoEIMvSsij28gjoEQl+bA1Z5C+Mlg=;
        b=D87zXIVw8t1XioVu0KE1YDvs86V4HuH0Yg0Bvptoe3x0nhKEc7S6ediigihtE2lFnn
         u+suuFPc3+/ANLT6yH3SsQAcnmzUxumbT6ARAziOvcPoDz0Ik+kLfRfVLlXh1NSI2Prn
         MpXThiB8eIsrdZ+QWFb1NhcZk/T8KbqC8BTB4HZs+StDAdYvTZFcwWOySSjIr6q1Aovu
         1fMR+xwEKO0a2Yw1cwsjsNdysDkhMjUBRUhPwURbrpi20VB19DcvrNpry/cUTEq9L90O
         jyvYZ22YUE2//brdoxxsbW46ndSetWOgFpUjfqP/cMGJ0ey2Yj1J6IyHxIg3zbqD79NI
         dZeA==
X-Forwarded-Encrypted: i=1; AJvYcCWH7t1o8771zdfmLLBl8lzNWMdFqMUTQ0I4+5RPtatFtJSQeLKXDhIT1kd2wAx66Y9hnf/aNJQtIU5SWz2fp5Ul31jpHAp2jD4t39Xx1z88PFRxBwhc65lWed1OL2N7zOjTfVnAFZj+SrGo
X-Gm-Message-State: AOJu0YyX9ni0R6fqrryQiJ07UMyWaLKl1il8WY1RIzKcw0IPITkUkjB4
	t+YGpqc0y/NB0sfiaYoUvONuKG39XArfq5uvarNU/IdA3yuU+yk9
X-Google-Smtp-Source: AGHT+IHiQCKVYLK92Z9lWkx2GmQLTJkXl3ttzKo2rRRld+zTQSoZDg5YxwhqKOzQdSXlyDhZJj/k6w==
X-Received: by 2002:a05:6871:286:b0:250:8970:499d with SMTP id 586e51a60fabf-25514bfd7b0mr482657fac.3.1718153037424;
        Tue, 11 Jun 2024 17:43:57 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7042d87b216sm6103901b3a.11.2024.06.11.17.43.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 17:43:56 -0700 (PDT)
Message-ID: <73d2167a-84ee-40a4-a68d-ba25229ff8ce@gmail.com>
Date: Wed, 12 Jun 2024 08:43:54 +0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty: serial: ma35d1: Add a NULL check for of_node
To: Greg KH <gregkh@linuxfoundation.org>
Cc: dan.carpenter@linaro.org, jirislaby@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, Jacky Huang <ychuang3@nuvoton.com>
References: <20240611092251.159149-1-ychuang570808@gmail.com>
 <2024061118-sycamore-leggings-05a9@gregkh>
Content-Language: en-US
From: Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <2024061118-sycamore-leggings-05a9@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Greg,


On 2024/6/11 下午 07:11, Greg KH wrote:
> On Tue, Jun 11, 2024 at 09:22:51AM +0000, Jacky Huang wrote:
>> From: Jacky Huang <ychuang3@nuvoton.com>
>>
>> The pdev->dev.of_node can be NULL if the "serial" node is absent.
>> Add a NULL check to return an error in such cases.
>>
>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
>> ---
>>   drivers/tty/serial/ma35d1_serial.c | 13 +++++++------
>>   1 file changed, 7 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/tty/serial/ma35d1_serial.c b/drivers/tty/serial/ma35d1_serial.c
>> index 19f0a305cc43..3b4206e815fe 100644
>> --- a/drivers/tty/serial/ma35d1_serial.c
>> +++ b/drivers/tty/serial/ma35d1_serial.c
>> @@ -688,12 +688,13 @@ static int ma35d1serial_probe(struct platform_device *pdev)
>>   	struct uart_ma35d1_port *up;
>>   	int ret = 0;
>>   
>> -	if (pdev->dev.of_node) {
>> -		ret = of_alias_get_id(pdev->dev.of_node, "serial");
>> -		if (ret < 0) {
>> -			dev_err(&pdev->dev, "failed to get alias/pdev id, errno %d\n", ret);
>> -			return ret;
>> -		}
>> +	if (!pdev->dev.of_node)
>> +		return -ENODEV;
>> +
>> +	ret = of_alias_get_id(pdev->dev.of_node, "serial");
>> +	if (ret < 0) {
>> +		dev_err(&pdev->dev, "failed to get alias/pdev id, errno %d\n", ret);
>> +		return ret;
>>   	}
>>   	up = &ma35d1serial_ports[ret];
>>   	up->port.line = ret;
> What commit id does this fix?
>
> thanks,
>
> greg k-h

This patch fix the in tree ma35d1 serial driver.
The last commit for ma35d1_serial.c is 
'6b64f8e360c00f180cffa1806095cdd2abc55b16'.


Best Regards,
Jacky Huang



