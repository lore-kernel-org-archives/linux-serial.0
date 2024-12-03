Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6751F8927
	for <linux-serial@vger.kernel.org>; Tue,  3 Dec 2024 16:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733244583; cv=none; b=I/B7ydu20vkTzxIxKBLztU+vv4tj44H4W7+lZpMY/itvoIf8pDWs5hC17GsK9X6ZIOT7fOt4qqh4XcLo3JOKeYv4gfSLPMZK6KuvwROwK7XFjymQmBFAJULccyut+ifxoQEFZp2uCl1uUHOJO3hu7iNuoeoDr9xXqy5LvuTzOJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733244583; c=relaxed/simple;
	bh=rP8WCl9KXwWdYzRKyzkCki01UNdVN/Fpb3/lyUZgLZI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=VAhsnen8/bynINOOrCNm5HFY5f3vrAAFnhcvAF00y4viABIlGqToXugEUdJRXgkyvRY0fmfxFNfkqBLv9b8SXKEgDgH1DzBjUBm97keW5gH+0g416pVUugDUeN6vqevhR6ZIY4ppt0Zoh/dUoEyaWgwQzuRoWkrrIZjYRqs+Lac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Ach9vGgf; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Ach9vGgf"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-434a90fed23so48706495e9.1
        for <linux-serial@vger.kernel.org>; Tue, 03 Dec 2024 08:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733244578; x=1733849378; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q4VmWrSSj/7zXUbh+NYZqbK4S1QOexkNE0xeEkErR8w=;
        b=Ach9vGgf/u6uxfR6dU2XDHlUC8GI+QM96hayjxlKOTD7SJvuzQgGp6zfP0Cf1gO1Dt
         gny5FfOITvm9sd1j1RN60Vn/mmvQcgboLXJXp/C8hGYrn63mT1eDsdwVLAVLpsCF9i2Q
         56hcK00o6/AX4JdwnrzZ3p9Pzw5lIl18ByuOyyA+h+yO7Cbm3OX325V3ZN1euVa429xu
         vZmCrx7oClF9yZ/Hd1878GBCOFvRZ/8Wuz4Di+/iwObHAXwj11mZ8sUvRofr86kdO+kV
         uKIhVMCCsY+OF4/TeETKT1ZY0OZx7KfqadALAPwkagEtSUPBnSZs5nOPK4f+1RoBZadB
         uQxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733244578; x=1733849378;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4VmWrSSj/7zXUbh+NYZqbK4S1QOexkNE0xeEkErR8w=;
        b=pwfXL9kCnQd4GMO+Mp7dnIBvN1LTqn+6uRi0hbRJhQFvluUlyPi/k8Z6u5aMH8zmxh
         SkB2gB+N1jpzASoj6ySCbaFwbZiP685HxsTs5mj1zvt0mgVhaPVQ9KPQx5t/X6c6NASt
         2GwnE/VoZ+k48yJACh9ROxH8PtPy6ry8siKuf8gW0IzVHeuBus2LDw2uwKrjQvzPlCq3
         dCPoAWZLfBtM/PWHPquVqbUQoX95T7xdgRfmw1JR9pvQlnO8GJuqFhWdyMhYpCdCsLg1
         bhT4xemkbX4KwKC4hy+yjvEd5JAd1pfd0g3rwPXKdSypknloOzzd6HtY6sq3TUxtqzON
         C8Kw==
X-Gm-Message-State: AOJu0YzFpyfKukdwPZCiAn/QImllFigUYByIr/MX5cG90qShT8u54X4S
	ZDXZzbyEor2ITU56ayCLC+cZ7MAIj2ozLBpfZgFTdWlYgjDsYYWccHDT73uQ6GQ=
X-Gm-Gg: ASbGncs63HFZ/fp2bQYUUhX8/Fi3vlozH/ieyw9EthnVtMvK81lgOIgE5nVocBSMDvL
	WNQBE+7loexEjkmTuyBXsN6IFCojfTJf6ANj0TobtdoEzf5r14KLWxySu4ZtW+vegO/UC+/gotN
	z+CovDET419KbjtV9bXWjtv5/LuZamIl13pBd9MYvXigTdxBJOuhAVKTe5HcB2Kfrw7NxPZd+No
	jxpNQcrvGllEQY9cf06zw6WAqjjNekFnqC44sQ+5JatL41j5Iqy4EBq7gw=
X-Google-Smtp-Source: AGHT+IF8xk5YUKpQ2WS30TSsE/BDo+SYDlLam0pZbOL1ZMMuaAzGwoSuG1kxkRYwJbZKPJNXTkGqJg==
X-Received: by 2002:a05:600c:3108:b0:434:a27c:b864 with SMTP id 5b1f17b1804b1-434d0a1cf53mr25519705e9.33.1733244578277;
        Tue, 03 Dec 2024 08:49:38 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0f70d91sm192897255e9.39.2024.12.03.08.49.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 08:49:37 -0800 (PST)
Message-ID: <1eebe854-9e33-43d8-b3be-abaa5b71cd18@tuxon.dev>
Date: Tue, 3 Dec 2024 18:49:36 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: sh-sci: Use plain struct copy in
 early_console_setup()
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-sh@vger.kernel.org
References: <e097e5c11afe5bd4c01135779c9a40e707ef6374.1733243287.git.geert+renesas@glider.be>
 <b71bb27e-003f-4b5d-8654-c7639b105e29@tuxon.dev>
In-Reply-To: <b71bb27e-003f-4b5d-8654-c7639b105e29@tuxon.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 03.12.2024 18:45, Claudiu Beznea wrote:
> Hi, Geert,
> 
> On 03.12.2024 18:30, Geert Uytterhoeven wrote:
>> Using memcpy() prevents the compiler from doing any checking on the
>> types of the passed pointer parameters.  Copy the structure using struct
>> assignment instead, to increase type-safety.
>>
>> No change in generated code on all relevant architectures
>> (arm/arm64/riscv/sh).
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Not sure, do you think it should carry a fixes tag?
> 
>> ---
>>  drivers/tty/serial/sh-sci.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
>> index df523c7444230836..1ed13ce2c2952547 100644
>> --- a/drivers/tty/serial/sh-sci.c
>> +++ b/drivers/tty/serial/sh-sci.c
>> @@ -3542,7 +3542,7 @@ static int __init early_console_setup(struct earlycon_device *device,
>>  		return -ENODEV;
>>  
>>  	device->port.type = type;
>> -	memcpy(&sci_ports[0].port, &device->port, sizeof(struct uart_port));
>> +	sci_ports[0].port = device->port;
> 
> I'm currently preparing my fixes around this code. I think I should rebase

s/I think/I'm not sure if/g

> on top of your patch :)
> 
> 
> Thank you,
> Claudiu
> 
>>  	port_cfg.type = type;
>>  	sci_ports[0].cfg = &port_cfg;
>>  	sci_ports[0].params = sci_probe_regmap(&port_cfg);
