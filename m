Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3F13A1E60
	for <linux-serial@vger.kernel.org>; Sun, 21 Dec 2025 09:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766307647; cv=none; b=S/Zx9ubcrorQjVfpEX6pDVm2F5PdrOaQOkfujqAYWd/JdAWff5mMc00IsEnCu7aZafaAsqlvPxob3rvPYwNB95VE+nmAnITqXnUOmpD/70Qx6iUsLUspgwaZp4Amb4MrRwFrFtQKX8rjLMz3MbKsB7XXW5VN5/qyWos7Yf1lPyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766307647; c=relaxed/simple;
	bh=+0Nv2wI3DiXUcSV4xKCrx9lOQA795u7kTtqXWvUP5oQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SY94bTdAHaAWNB6XkVEqUQN30PQIeVvXJoeZCNJk1fJClcUcwr3tLSaLez7LNwoSHrQ8FOl56SzMnYmMoMShDEdWjfH9fmIpsBFD787ztmdH8SzFZ0+yTwVd8d/j+snACehzV0pZRgp1LcKjUk99dFg3ktyB+p3cKu+oDXvo0zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=InQEHk+H; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InQEHk+H"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4775e891b5eso12152595e9.2
        for <linux-serial@vger.kernel.org>; Sun, 21 Dec 2025 01:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766307644; x=1766912444; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h3S8czxSor8XQNUU2s0HC3e5epodbCaCAh0QG90hxSE=;
        b=InQEHk+Hv1p2mzRDh8w67ibUYLDrqwgdtwyd6Cymrcco8aXH8nV+i/St06Q1b4J77s
         Wj56PzKt1RVnLinKX/7Q2Bt9dzQGeBNkAmisAYPWUVMBii8CWr00l/hO57GbYvckF0c0
         M+UJhvvHeUf1ZaLiLvKPy3keUkcKjrKngiomrpGjxB1x+DEvA2dau8h30QGCyeOEnqyF
         IJ8SQF+Q4t5N+0LEMXTe14HTPERiOmg9mqYGLnxCrOQBK3yR3us43+INondISAN7aQe1
         O1Oh2HsWcAP09hyds3mNYoJSpM/ER3z3EKqIRcD2VDKDwwX+7AzLIh72/Pr5KizHVbXw
         VYqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766307644; x=1766912444;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h3S8czxSor8XQNUU2s0HC3e5epodbCaCAh0QG90hxSE=;
        b=d2FCC4Fh86Qv/38iG6+nPOnZwW97WIrhq7X1RpebFOWOs2Crs42Ve7iDWC22dGY4S/
         xdI4LZOf4jrinOEal9AnE9WxOrMI7yQyaxwfuhNNj/ASaHPGH+exkavNju3iapVE2Zku
         OC2NwPPqcjTPnNY2wh0xjTWSIdQDYSdlh+mQFlnxRBspe3debsXDt7gLuF6kjkd4C66n
         cCSBL4qUxfWAwW3s/rPBh92kRgQskr0Gmpz/4KcVbuWqU3+LP5kFGHD9MGg4u8fUCBXO
         S5xVu4/I1xoy6P5+p5O0FIrgLo8QHtdF2l8CvEMkncMvuqSCcHkVKIp1iaObUCpPtbqD
         YCLA==
X-Forwarded-Encrypted: i=1; AJvYcCX+53sdBpFvAXLow9ivLTkPuYuAHVVZlEzYs5wUsKpV6OegFzmYga/dYeqg8IL9QuXf8SDGpNDyJ9aN4nw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjrl8I6uX0IjSeL7WGclqpBsFZCHNPCzOl3botEvhogU11HVkl
	ttK+vt6xSZnAk6tBIhz6r659N3RM1hKmPPRazX5lerkv+Ehi4WW/o9nF
X-Gm-Gg: AY/fxX7RfnziIJmP3MwDMvzHBUZWjRh3AnXmZv4ABdhlUEHb78CofeTr5rjMAWLf8eW
	FbHQwt9ubOvqrY44qe0lwg9JxsQxw03PRqnwoc0V7xeNWoCxQ/aWtOBJ9jGvfPSnqcSZK8DZYJZ
	BEc17UcSHQJ+sK+ReGeYS1M0a4/1e6r2Sm/IqqaK/pzKE1gVOiHZfqlitAqnfNlA6nNYZwvb6Xp
	M+q+MIz/Yl/Pt4WyA0GiL4ttharC3wEvHE5PYHcDPN8zOb6eoel/JosOH9/W/+JwoGiodhSiIlT
	9f3BhK2D80HJ+BeEUnPfL4wQnhujJozyUJKZ7M29qiaY2qWXDW5/wWNZ1lwVBQf+gDMXnXNNcdg
	6XvCrOckHNHGfCvV2qt+fJsnlpfIXqMMeLrFA62gjuu4pLS3A4WBo6jvAIV/Oe2qTLxoC3DEYRl
	j1zUAnBIrst6wazUzOEQ==
X-Google-Smtp-Source: AGHT+IFpPlLWVbyaeoTjG8dVRRPTdnPD4Iq0RsSBY2log2TabaY6AsmefqAIGfDlSxyN3iOoFQmRWQ==
X-Received: by 2002:a05:600c:3148:b0:479:3a86:dc1e with SMTP id 5b1f17b1804b1-47d1958e459mr74379985e9.36.1766307643700;
        Sun, 21 Dec 2025 01:00:43 -0800 (PST)
Received: from [192.168.0.100] ([188.27.130.80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be3a7b687sm76565395e9.6.2025.12.21.01.00.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Dec 2025 01:00:41 -0800 (PST)
Message-ID: <1ab9287b-bab4-48de-a6fc-88b5f0797e6c@gmail.com>
Date: Sun, 21 Dec 2025 10:59:52 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] serial: core: Fix serial device initialization
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Jiri Slaby <jirislaby@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20251219152813.1893982-1-alexander.stein@ew.tq-group.com>
 <2025122151-petition-joylessly-bdc5@gregkh>
From: Cosmin Tanislav <demonsingur@gmail.com>
Content-Language: en-US
In-Reply-To: <2025122151-petition-joylessly-bdc5@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/21/25 10:40 AM, Greg Kroah-Hartman wrote:
> On Fri, Dec 19, 2025 at 04:28:12PM +0100, Alexander Stein wrote:
>> During restoring sysfs fwnode information the information of_node_reused
>> was dropped. This was previously set by device_set_of_node_from_dev().
>> Add it back manually
>>
>> Fixes: 24ec03cc5512 ("serial: core: Restore sysfs fwnode information")
>> Suggested-by: Cosmin Tanislav <demonsingur@gmail.com>
>> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
>> ---
>>   drivers/tty/serial/serial_base_bus.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/tty/serial/serial_base_bus.c b/drivers/tty/serial/serial_base_bus.c
>> index 8e891984cdc0d..1e1ad28d83fcf 100644
>> --- a/drivers/tty/serial/serial_base_bus.c
>> +++ b/drivers/tty/serial/serial_base_bus.c
>> @@ -74,6 +74,7 @@ static int serial_base_device_init(struct uart_port *port,
>>   	dev->parent = parent_dev;
>>   	dev->bus = &serial_base_bus_type;
>>   	dev->release = release;
>> +	dev->of_node_reused = true;
>>   
>>   	device_set_node(dev, fwnode_handle_get(dev_fwnode(parent_dev)));
>>   
>> -- 
>> 2.43.0
>>
>>
> 
> Can I get some confirmation from people that this resolves the issue, or
> should I just revert the original problem commit instead and wait for a
> tested new version?
> 

Hi Greg. I confirmed that this fixes the issue before I suggested the
fix. :D

> thanks,
> 
> greg k-h

