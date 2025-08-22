Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1AE263F22;
	Fri, 22 Aug 2025 08:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755850231; cv=none; b=bG1lPCG3+aQ9RMtiVDfEOSRq3418WefLI/nsh6qXKD5KZUU18fCdvhZHbEq0FQ2zhgpgeIRaC+0/3smn9UV3jRGeupxJYICiVOqsDgF23GTfpxmPoEJFhmeUQs4P7F9cjNr7HPiHiUy/j4sEHebXO5YvIPq4ZKzD+Atf85EZTG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755850231; c=relaxed/simple;
	bh=xl+fsy/4SIB5/G2VQC4Z0kCPy4tzudJCgawpnVdUiq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ibT8NLM9qDu5CBUReF+oKbHbdQhhcsQVrqeS02HumbEiySEFcDx1j5+seoBMS0vbwrmR/KXtCKMT515SSl5Z3NyJD3NHyjPiEN5bYEhmxqYruQcGEM1vTrukjbQWMa6e1xM5caBJKI4sUFqkxv/HoqsQohfD4Hc/JLOcxBV8LyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yk1fK0Op; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yk1fK0Op"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-61c21e50168so455158a12.3;
        Fri, 22 Aug 2025 01:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755850228; x=1756455028; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xl+fsy/4SIB5/G2VQC4Z0kCPy4tzudJCgawpnVdUiq4=;
        b=Yk1fK0OpaVJO/Zqi61husiFPrGdwvV+4aZcmtU/uXDebwIksuLPNPC0DAR4Hm9+HOL
         Kteb7xK/b3BXpPS9vnjBg9WDf/yUOMONeLdCwBedIsZBWhxTD1CkkMwJxtUhMcDNEXe0
         ZRDl4ZMYyejP6Eio0IPj/yn5JiL3cZlICik4WFonoAO5ipumyaVSCka5EyDuZdVkxy6i
         YO/nXugG4yHph5FIxVmqtVHftxqT/ujF+nUmx1KyIglrYA4gYtHG+/gFKUFETlmsea9p
         KGzpKHCGAV51gP5y08s3SjFJbnmlNN7ghOsAMrtR9qiJ2j29a9Ltorb+xmMPp/Cb3vrt
         IJBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755850228; x=1756455028;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xl+fsy/4SIB5/G2VQC4Z0kCPy4tzudJCgawpnVdUiq4=;
        b=EEfolVYGfSybWnlbG4r+gZaSH7+7iiOcsGYnmLyVXo8ZN5RbvvSILLjnWH5jQ+mecB
         vkFS/UHcC6kYxg4CxLOR/JPweCrcIyW+V4WGpFMUbY1hmjPKquBZ+6ArWoGHd88niZGP
         t9JJ84OKBQOM5sWOjEHIFqNu1OFlwBbusyJGnh93PdGIYmT8Z26q4L/VQroVYS1oqcq/
         5pLc8PhqrIQl0NJLL1bGaHOt/0wL8/c5rfOrhHOP1NuQlOOZlOexJiz+2BMt3HfJk2nZ
         z/YwdRSN3HjNuhE5ag00kTYfGkF3YF8SmxO3Cff+VWLu5ocVI92AiG3pZpXtkcM1Uwow
         3m/w==
X-Forwarded-Encrypted: i=1; AJvYcCVh2MB1y07D4a+VXx/67rYEtDh0ws8bIrqymfZEveMaIb+vs/+iwfWCFKTxMx/JM+vKY99lG49msrU2Vr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEgiyij7pC3SYqbIzS7m4mKwBoJutaQFOUymsiF1jUOBzggMzZ
	kUItAPfYy+rVeM8dGXNEIQEMLJzv12OTMm/X/C/PP3e9x80lX9IpBe6S
X-Gm-Gg: ASbGncv+9+S5rPsiZOfNzSHtB2uyMngCbsO0yjIp7dgxf390tAVP4h2QIGScp3mDcTq
	pae5L6AmL9nGLe0DfH9I4jOJakZ1gIwE/Azs4qVt1BYe+3PFVe+2tHZpTGFfJXKGt5KQcq10l00
	qdUc0mGvd+5757C2YWtft1WHFcIWb8TDk2VjLR4oihBOnfyBQbTDjm+wqjZUeC7qRVY3kQgTXTa
	VD16WyO68R4MK775tzqYVsPi0Zl9qyiHYg526UKq637qZc1Wsv8SIz7bHrjipJa7ino5Ri8nrsW
	eI1AxN2LzIMlqRpa8Ip2o2sDDadtEc9FOmX+mod1+zHEEiW/p6fHrBhfOhjLFx8PFLNVPElVeLJ
	9SOGOPukS271hRHSgJXevIQTVwh63w2ix1tEdhEoGrAgL1nU5DjOHqvR32Yp+KpimvoLWzVfVi2
	MmxKdkJMi7pud7hZ9DR68SfXsLRC2UB+gbbqiqyl1PhBe6+8oSaZGNHknV
X-Google-Smtp-Source: AGHT+IHQw667QvfGf29y37h7kMKuCZz4wFgEWsXftySFT+pgVBaHd/nXfqu99jzPZKdN0SwP5q1CRw==
X-Received: by 2002:a17:906:c145:b0:afd:eb4f:d5ce with SMTP id a640c23a62f3a-afe29743499mr182045266b.62.1755850227808;
        Fri, 22 Aug 2025 01:10:27 -0700 (PDT)
Received: from ?IPV6:2a02:908:1b0:afe0:dad8:d30e:64b4:faff? ([2a02:908:1b0:afe0:dad8:d30e:64b4:faff])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded4c9313sm557433566b.81.2025.08.22.01.10.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 01:10:27 -0700 (PDT)
Message-ID: <93c32ea4-e7f0-4bdc-a21e-ba2b695183f1@gmail.com>
Date: Fri, 22 Aug 2025 10:10:26 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: 8250_core: fix coding style issues
To: Jiri Slaby <jirislaby@kernel.org>, gregkh@linuxfoundation.org,
 ilpo.jarvinen@linux.intel.com, mingo@kernel.org, john.ogness@linutronix.de,
 tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20250821175856.22957-1-osama.abdelkader@gmail.com>
 <ac753910-ff9f-42d6-aaad-74ccecfef681@kernel.org>
Content-Language: en-US
From: Osama Abdelkader <osama.abdelkader@gmail.com>
In-Reply-To: <ac753910-ff9f-42d6-aaad-74ccecfef681@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 8/22/25 6:30 AM, Jiri Slaby wrote:
> On 21. 08. 25, 19:58, Osama Abdelkader wrote:
>> Fix a few coding style issues in 8250_core.c:
>>
>> - Remove redundant NULL initialization of a global pointer
>> - Add missing blank line after a variable declaration
>>
>> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
>> ---
>>   drivers/tty/serial/8250/8250_core.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
>> index feb920c5b2e8..0d1d2eed2a5c 100644
>> --- a/drivers/tty/serial/8250/8250_core.c
>> +++ b/drivers/tty/serial/8250/8250_core.c
>> @@ -307,7 +307,7 @@ static void univ8250_release_irq(struct uart_8250_port *up)
>>           serial_unlink_irq_chain(up);
>>   }
>>   -const struct uart_ops *univ8250_port_base_ops = NULL;
>> +const struct uart_ops *univ8250_port_base_ops;
>>   struct uart_ops univ8250_port_ops;
>>     static const struct uart_8250_ops univ8250_driver_ops = {
>> @@ -773,6 +773,7 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
>>        */
>>       if (!has_acpi_companion(uart->port.dev)) {
>>           struct mctrl_gpios *gpios = mctrl_gpio_init(&uart->port, 0);
>> +
>>           if (IS_ERR(gpios)) {
>
> NACK to this one. It's a declaration with an initializer and the 'if' checks its value.
Thanks for the review, I'm going to send v2.
>
>>               ret = PTR_ERR(gpios);
>>               goto err;
>
>
