Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22E1184;
	Tue, 25 Jun 2024 00:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719274616; cv=none; b=M+CfFZYPfFW9lpplhH96uNLFLSdY+4hq+aZv71Os8K+7/FIe7wRvUS+LtNW1508GHKYIOIzGmulivWsW0BGsb6ojGaSr4YI786kjoUKJ4FtXJmTlkA6DHmmTMb29ZNteqLHyYwDYIWjQ9mblCWi8VkeqOeGziJEKvkKWz0rlEtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719274616; c=relaxed/simple;
	bh=YrHjmskoSDhVJcXEIqH2WB58kyPIz/2ktO3XAPa8PPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GeWQr0BIZAj9mjpX2boxdY4WWZfMaYL0Ml2vefXkyYP9Y4VzRzDjpJSVegyuYSls57kdpfUbbq4fxCABoZaPY1wF4OBuHPCrYgyexWBEb0Y2XDDuVRCp+XLT3M8DD9CUEXKgb7u+evvHC55/4kVLqYmPBIJFd927xEcgMy2fkt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VuSL3EIs; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VuSL3EIs"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-717f17d7c63so2351736a12.0;
        Mon, 24 Jun 2024 17:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719274614; x=1719879414; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZPulY/FFLXx2qRuEGoIYRBxFDaCi/EahkPsQ00jC1wI=;
        b=VuSL3EIsypVcbc6CWmGLFxYuscKk8VeWNcyPzWWKGTNyAyeBUcqJSqtseSrH7JMWvV
         y7dX8g/9cz3/hoM68kiSdSvaJCQB97VnQqi4KZ/Wy3hxF5tlM5bz4K5L0fUgT9Xks9RL
         iCtGLyxIcuqjlS0eVvvqjYFQDrEnuBJyA0yDDbuhcKUTh3VoKOnL1Uab3MFNDnZYBk7k
         XskrSRcEMCi7AmpJaxEt37aWh8CLOMnQoDxJGj/aRkZSnTB8s9ptRk61r632MoCRcr8f
         awLl1hmBmLIygiVxZXLoiDKdn561L2LKS9J0lPhae4sZ31uAkrgi/YUZLZm6EcJh4B8H
         diYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719274614; x=1719879414;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZPulY/FFLXx2qRuEGoIYRBxFDaCi/EahkPsQ00jC1wI=;
        b=sOu08nT+3bVmw4EHk+56R3m18rziCYrCFqplMgAhVkXTTSIN1lIFlw8TYXT/5dxkPs
         2KApHhVG7zTFkcBj2ejZHCAgJCNC4b/vlXGwojMlA95mmdtDP/VWcGrqnoQ7oCmJSG9i
         /afJtxcgr3gVkQVPD+20j9FskABYxp+1BQFZ4b9bYKuVxcn9QgKlBY39foXzfnYYz2Mn
         OhKbtvN9bCQ/qJTpFG9ujL0bQ5bZbOuIy66E75L+IdWRbM8HU/eoVAXN5VfH2/1qlDdr
         Cyirndl//IHWRsTBuiLgxPXJn+Cy9dZvYAzu1RCcoSXKkBqGoGb0dUaAJHhCzZku6O6m
         DO3g==
X-Forwarded-Encrypted: i=1; AJvYcCUFThWbT8bfW9AFcS+Lj+G6nsnMxQ9lyfCn7udQqu1W6U5Dgxvy3+0aAtri/FugiBIWRewtWsYFRxCqby3JRpCYKEEJZnOyJeKCwdmX9MRzcxK+AgaE0yGss0haNOAC6UfS6ZsNarYLRrW8
X-Gm-Message-State: AOJu0YxY25qib19Ns7dqBU8fqnr236gzKLNb0+uF27MEUcYpjq9ZefB1
	bRlauqlJosLNRApuZ7tmsnQjF+ven2Jb1jVXl47npCgCUs0heAnC
X-Google-Smtp-Source: AGHT+IF9BMSkE/ux+AVW7JbiLQQPv8C6XRkzWf+ZclsqfrnQ8j5lIAMEMb2kreKQKUdDeFUgLD0t0g==
X-Received: by 2002:a05:6a20:af19:b0:1b1:ed95:c9b1 with SMTP id adf61e73a8af0-1bcf7fc2cc4mr4822661637.40.1719274614054;
        Mon, 24 Jun 2024 17:16:54 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3205e8sm68609215ad.68.2024.06.24.17.16.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 17:16:53 -0700 (PDT)
Message-ID: <2ea41efa-2160-446f-9fb0-0df0ffdeab05@gmail.com>
Date: Tue, 25 Jun 2024 08:16:50 +0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tty: serial: ma35d1: Add a NULL check for of_node
To: Greg KH <gregkh@linuxfoundation.org>
Cc: dan.carpenter@linaro.org, jirislaby@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, Jacky Huang <ychuang3@nuvoton.com>
References: <20240614054554.80-1-ychuang570808@gmail.com>
 <2024062404-avoid-grieving-a3fa@gregkh>
Content-Language: en-US
From: Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <2024062404-avoid-grieving-a3fa@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Greg,


On 2024/6/24 下午 09:37, Greg KH wrote:
> On Fri, Jun 14, 2024 at 05:45:54AM +0000, Jacky Huang wrote:
>> From: Jacky Huang <ychuang3@nuvoton.com>
>>
>> The pdev->dev.of_node can be NULL if the "serial" node is absent.
>> Add a NULL check to return an error in such cases.
>>
>> Fixes: 930cbf92db01 ("tty: serial: Add Nuvoton ma35d1 serial driver support")
>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> You forgot a "Reported-by:" line as Dan did report this to you.
>
>> ---
>>   drivers/tty/serial/ma35d1_serial.c | 13 +++++++------
>>   1 file changed, 7 insertions(+), 6 deletions(-)
> Also, no info as to what changed from v1 :(
>
> thanks,
>
> greg k-h

I got it. I will add the "Reported-by:" line and version info to the v3 
patch.


Best Regards,
Jacky Huang

