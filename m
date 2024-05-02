Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB02242AB6;
	Thu,  2 May 2024 20:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714680199; cv=none; b=S1DmzeMGVMROydnCUceWXVxaOd6/p9qe3OIMoMHhoGtiUIGKHvOfN27Ta5Vbj824ZixUeyJIQidscrTHSLR16LsG9AX4LO4kAUYWIz6kImRiANvH5tdyGo9pFACWKqlfYXPrsWOMMvWirti4R9oDQEkGzJXLggQD0BrugCG3eAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714680199; c=relaxed/simple;
	bh=6YLZEFxdlozaEkc0K+3LqgLnle1uJd/YFh+MvQe6AT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jkj1bmcbsMEa8AbegSU3QPs3ydEJmpbReRpS6uvHr/da1lBm0P6XLvV9m89BHNhTJwMtoQT1yY4dCBwfWfBXL8VL5kiMCbKqQdE1FRE36BmfaPPTAFJq1m4oI+wiY5WDLO4QHZ+wLMdIf5XnmTXFElrT6bn4fF9vEvfa0Dg6YtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QjBdtL/R; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjBdtL/R"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-34d0aa589a4so3151085f8f.1;
        Thu, 02 May 2024 13:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714680196; x=1715284996; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ty4y9UaSZutHk0lTDp9JMqFvQRvM0CuepcMs5txo9ww=;
        b=QjBdtL/R5dtkv0WBJkuRKHeZo2v/zJzLROGeeK8gsFL9gQGYvVdsMexE9rplWs0IUO
         i1i4W5rOnZPisoGuVx6IfWiQmIU5MUnNqCfbJbT4A/cvF8dDC1YkSDQ/s2dSjlzOiL3x
         LwrOKVwDAGElBiW27vrQ2PUY2kih1OrmIBOHInEHhzTRmHzBBR8PJTdglcktn53fhmPI
         Ay/NdCzb6ma8tSw+qd/wrWRXc0DO/JUSaEm7fYESs8BEm59DN4D0LiZn59K3nxnOt1SG
         lg0RITl0WmfIHLkv/NI29oR5tIplm66PwMljvCr4rfGJeos+pGTIf1Bi7QyDdq0XC0yL
         rJiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714680196; x=1715284996;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ty4y9UaSZutHk0lTDp9JMqFvQRvM0CuepcMs5txo9ww=;
        b=RXDBAwM16GxNJVnHIYyjgBTfSt2JYKXKTIzrO0K8mx8xVX1JaAjfakcAFX7EqIsUc7
         jsFM6TtqqnpCRiyleJClofj7kNOpnN3Fk5fl4Gzx1sBnOVOrqRCg5qxSDBCt7dBg2vQc
         gZsXQ/phfLJINswhYttHAmQbj/9VRT333khwFq/r+bWKwdNcyAPtid1227b7qK428ZEd
         dnLz6GxbvJYUe8oiFBPa33GVNTnuDAhPukYITOvcLc2N+NzdZhXOjG5GCzwRV8/kCDs6
         MqIp3eQ5gkpMiND9mTEfJGrYqteiAHacZ9oGr4LwjT+VT9fxGqUb/2N69q1uXSEWCdDb
         oTog==
X-Forwarded-Encrypted: i=1; AJvYcCV0aDKJpQtJTPkfY0U25vtDG0ud2oO/f27JXASfzGpBUiMCyDLrW/TgGJ9I16WMfDdQAplIxiD0YwzwWj+jXlGV2LNPa5UaMskkkpf7NUOkvUa4K+0R/Z85XlbSqiNhoU7Cc+2o278CpZD1v1n4+qWgZw==
X-Gm-Message-State: AOJu0Yxt1YOiHbn15J06E8pMupRqkOcpor7XJ3+3JswZpiIZ9IO+jnm0
	fKImWt8DtIel60YQZXexfzIxIumuOcOpi+WEquOr6zOh6rzRahzj
X-Google-Smtp-Source: AGHT+IHYvDuwk2m6/66ovln2UsXsnApArQ6lkWQx5q0Nf0guwlbXSqpVSlVyrpNQ30cf1zTHxr+axA==
X-Received: by 2002:a5d:4525:0:b0:34d:a902:279a with SMTP id j5-20020a5d4525000000b0034da902279amr687639wra.62.1714680195918;
        Thu, 02 May 2024 13:03:15 -0700 (PDT)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id j14-20020a5d452e000000b0034dae1488ccsm1994245wra.53.2024.05.02.13.03.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 13:03:15 -0700 (PDT)
Message-ID: <259aca16-6875-43d9-96a1-6b2e35688ea6@gmail.com>
Date: Thu, 2 May 2024 22:03:14 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] Defer probing of SAM if serdev device is not
 ready
To: Hans de Goede <hdegoede@redhat.com>, Weifeng Liu
 <weifeng.liu.z@gmail.com>, platform-driver-x86@vger.kernel.org,
 linux-serial@vger.kernel.org
References: <20240502040255.655957-2-weifeng.liu.z@gmail.com>
 <b08a6155-0701-403a-9c33-b1e24fd99e42@redhat.com>
Content-Language: en-US
From: Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <b08a6155-0701-403a-9c33-b1e24fd99e42@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 5/2/24 10:38 AM, Hans de Goede wrote:
> Hi Weifeng,
> 
> On 5/2/24 6:02 AM, Weifeng Liu wrote:
>> Greetings,
>>
>> This series is intended to remedy a race condition where surface
>> aggregator module (SAM) which is a serdev driver could fail to probe if
>> the underlying UART port is not ready to open.  In such circumstance,
>> invoking serdev_device_open() gets errno -ENXIO, leading to failure in
>> probing of SAM.  However, if the probe is retried in a short delay,
>> serdev_device_open() would work as expected and everything just goes
>> fine.  As a workaround, adding the serial driver (8250_dw) into
>> initramfs or building it into the kernel image significantly mitigates
>> the likelihood of encountering this race condition, as in this way the
>> serial device would be initialized much earlier than probing of SAM.
>>
>> However, IMO we should reliably avoid this sort of race condition.  A
>> good way is returning -EPROBE_DEFER when serdev_device_open returns
>> -ENXIO so that the kernel will be able to retry the probing later.  This
>> is what the first patch tries to do.
>>
>> Though this solution might be a good enough solution for this specific
>> issue, I am wondering why this kind of race condition could ever happen,
>> i.e., why a serdes device could be not ready yet at the moment the
>> serdev driver gets called and tries to bind it.  And even if this is an
>> expected behavior how serdev driver works, I do feel it a little bit
>> weird that we need to identify serdev_device_open() returning -ENXIO as
>> non-fatal error and thus return -EPROBE_DEFER manually in such case, as
>> I don't see this sort of behavior in other serdev driver.  Maximilian
>> and Hans suggested discussing the root cause of the race condition here.
>> I will be grateful if you could provide some reasoning and insights on
>> this.
> 
> Ack, I have no objection against the changes and if Maximilian is ok with
> it I can merge these right away as an interim fix, but I would really
> like to know why the serdev core / tty code is registering a serdev
> device for a serial port before it is ready to have serdev_device_open()
> called on it. To me it seems that the root cause is in somewhere in
> the 8250_dw code or the serdev core code.

I'm fine with this being merged as an interim fix once Andy's comments
have been addressed. Weifeng, in that case you can then also add

Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>

However, I too would like to see this fixed properly on the serdev side.

> Resources sometimes not being ready is sometimes which drivers generally
> speaking need to handle, but in this case the resource which is not
> ready is the device the driver is binding to, so it seems that
> the device is registered too soon.
> 
> If someone familiar with the serial / serdev code can provide some
> insight here that would be great.

I will be away for the remainder of the month starting end of next week,
but I could try to look into this after that, provided no one else did by
then.

Best regards,
Max
