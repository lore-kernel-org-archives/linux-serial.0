Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF6B1F55F8;
	Fri, 29 Aug 2025 09:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756460987; cv=none; b=eCojfoJ2a7BU7UhSUTEljfxMievVbEKUYo9Rh3MDBbjchqIgcGn8ooKwNwuTMVemWhdN0boBXudUu7gKzY4ePe2PuwKbWELzLjcRk6s2dzCgGfo5CC3t72T5Uf0AhdUTpnIwk6ETeg64GVovkzV1CbZIZQ1I4+aPWWEcZa0IAow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756460987; c=relaxed/simple;
	bh=lhmgsrMwvf4liprYG7Ei9+IHq5tb6vM1vmnJcwja0zk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f0V/UdRTlwtv/otKUjmUcA2JKhYHjTEvTXVWK2K0ug5Hyrdq+vv8TKmnPegfLQ28d6wYLSymNHE7g/lUWpW7mFnj8HsOMqIH/lEXgjW1dHpfh1Gg3u2Iq/ocE0KZCx+KfXqquPDjbubC6GjGjK8yUxKsHMZ9YdFh0n6UH0n5ze0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TcIhqyoz; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcIhqyoz"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-afcb7a16441so272136766b.2;
        Fri, 29 Aug 2025 02:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756460984; x=1757065784; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VPJPzyaAcsYZFWXE+rcGpPO401ZzV1EMLAoIATRnKEA=;
        b=TcIhqyozKhAVVrtexEqMvMaGpeR3I42SsHEoU4Dc0yCmnhWoCmqBNCbtr9GWv1LrmC
         IqVLZf1kAjF5a4xYwifk7XkQpvj3u7pxUDYkOrJw0JbV4j5nl5XO16bff3wQqpvL6HZ8
         G/6ki996SVWG3Yeb4psOBtI7YaZR4zmpPr8T2+phDpPolpZqTg9b9GpZH65wC0RO/3lm
         +24VITfCVD2Z036Gjzc3zG5/IHqeFgAPhvCJGlWccSpJhj0w59RwTTnwaHMMFJcx1Ul4
         032qZ6QXwmoxV/EiXH6IXUHMD1ah4Z3QhO5jF//YkMhdAcisAYtiN5C1dkw2rBzvS2zk
         taOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756460984; x=1757065784;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VPJPzyaAcsYZFWXE+rcGpPO401ZzV1EMLAoIATRnKEA=;
        b=hplEzW4dH74kdJA4YfCZD6YJVvSO0NqoIfK5EEWd/0tNLHxpAaNpYeLnqtKO1g32Ty
         +mIjnNekDBSeLc82so/KEP6JCNRL/aQkBWUXiWXHWkNRgbrzMMtMYLaOjux3YEn6qpeW
         +Vq/JBFAzZUIogyAv50gsziudOR6nOrzevbwEhyPDA3pNFfognlPQ75CU2I4qlT9RoUY
         PymyxBPqV//rZzALk6UrmeWTARL3+uKFV8bxRvIGpDzHdpqUYPLc0KkI/cgr+T5r6ysT
         86MqqUttQDvkif32Wi2b6AmZ2JQX4CSODTUbFnVs2gdbdBUSxFo+VS3ib+WDOi7cdzz0
         14qg==
X-Forwarded-Encrypted: i=1; AJvYcCUzT3feplecT7wpey5f+bB/1//iFNqAeFFlocznsVo1aJ1G7gzoyi5tSqnVlfZZBfuxcqojEq3O3GmUnP4=@vger.kernel.org, AJvYcCXhfJbtqwt0+VqthlT1f6r7B5ABciwvoQS0uJCyqf0S3RDJI/8kB16Bmum78QVgsWa8Lm2ntYRPYpAHpyOs@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn+dcsdHnDSKt2leanm5U58d8pG5vLUQS8tDXbrv499PIRKVNn
	xPPBdEYqE8mdkxrp4V7K+SZRDHYAeLex3C23unOVzk06Q8VvnlJGDA86
X-Gm-Gg: ASbGncuDO6cG4E6jZ2z1z36pXMM98p9m9AATJIN91lwCyVbi346oWkb/Kj1tsiY9Adg
	1nC3U8jrSubr/233xAfADjB8FfIOcTwuOWBm7pbFYXPzA6DV9CklcrSPvu16qH54SZEWJanNosI
	pFeK9rVOsN5Yt3BgJ18twqvM9WI/rn04/GF2npUTMtj6vpqJYbnabWJG1RsGJE29tv0r+vYXyzg
	oHVsoWhOuAUd9mlk/1OWNnB8Jf9hf7Jt7rqNx0fCaBluzRUYRs1WLcYOJW4qkusQDDvcRfdiyMs
	hfjutNp/QNRefmM6ESEv6YMl1Gv7xcslz6EMDZ2tyijPBg7qgDY3Irc/E5zTF9AIkFadlI+14FC
	3mHjMrrBshaJL16h8blvqxFo6sUiyeAiHrE4dVVF2C+2pfMWtpZkYJYfBolE9eX89OXLJdgFn6R
	OmaehstdRlb4H7THU0z00DFfiruonDt2R/sbDsqbKHNJaCEUdDJAYBHvzwCg14D4J/3fQ=
X-Google-Smtp-Source: AGHT+IEDMhih4Y4IAmtD5j+HuRhLKlot2jYM8x0+gNx9CP/3JwypnSwKt2NXE/pRy82v+m7s4s5Zsw==
X-Received: by 2002:a17:907:97cb:b0:afd:d9e3:953f with SMTP id a640c23a62f3a-afe296b14edmr2617784666b.63.1756460983696;
        Fri, 29 Aug 2025 02:49:43 -0700 (PDT)
Received: from ?IPV6:2a02:908:1b0:afe0:17ac:1440:166f:150c? ([2a02:908:1b0:afe0:17ac:1440:166f:150c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aff07de1612sm91296666b.105.2025.08.29.02.49.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 02:49:43 -0700 (PDT)
Message-ID: <27562003-b129-4dea-818c-2e81176f842b@gmail.com>
Date: Fri, 29 Aug 2025 11:49:41 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: 8250_of: replace kzalloc with devm_kzalloc
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jirislaby@kernel.org, andriy.shevchenko@linux.intel.com,
 elder@riscstar.com, benjamin.larsson@genexis.eu,
 u.kleine-koenig@baylibre.com, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
References: <20250827231105.126378-1-osama.abdelkader@gmail.com>
 <2025082817-laborious-provoke-2ac0@gregkh>
Content-Language: en-US
From: Osama Abdelkader <osama.abdelkader@gmail.com>
In-Reply-To: <2025082817-laborious-provoke-2ac0@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 8/28/25 7:51 AM, Greg KH wrote:
> On Thu, Aug 28, 2025 at 01:11:05AM +0200, Osama Abdelkader wrote:
>> Use devm_kzalloc for automatic memory cleanup.
> Why?
>
> I do not see a good reason here as to how this makes anything better
> overall?  How was it tested?
>
> thanks,
>
> greg k-h

Hi Greg,

Thanks for the feedback, the change to devm_kzalloc ensures the allocated
memory is tied to the device's lifetime. This removed the need for explicit
kfree() calls in the remove path and avoids potential leaks in probe error 
paths. It also aligns the driver with others in the 8250 subsystem which 
already use devm-managed resources.

For testing, I built the kernel and booted it on QEMU riscv with of_serial
enabled. The driver probed successfully and the serial console worked as
expected, also tested unbinding/rebinding the driver via sysfs to confirm
no leaks or errors occur.

Thanks,
Osama

