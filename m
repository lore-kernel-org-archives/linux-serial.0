Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E00306494
	for <linux-serial@vger.kernel.org>; Fri,  7 Nov 2025 07:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762498964; cv=none; b=scdw+kgzzHUg/2Et4WK0O3tymqf4IHHCfvGnqHPcEIThTpxzZHCkcry+186JK0vFcUPgu/dskVEjycAjFjA18hKM1aeIYsQ6qi+MP2d/EaAlGuc9J35Fl9qAdDLy+odBO5CT1kDir97mNUCHsFu97RLZfGdLLl62W8dnauZtLb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762498964; c=relaxed/simple;
	bh=Mw/pXZ7za+eKJsqqAM6wfgduCWcgqx7q3H8QVz4l2H0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O6RuCfUqRy6PdwShRHlb9yDoNDgzJK8uRwYDN/Df5L43Q48I3EBDWVAa4lkR9ZuIeNAB0EdAjcsebG2gaZV4n94C49fn7ghOtOj5eYxXYvqFa7QtX+eUz1cTtcq59/0MoJL2YdwcUA74X3mUb/FbIs3vx2eewkRWFG1xioXBK3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Y6SPEswh; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Y6SPEswh"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b70fb7b531cso75127866b.2
        for <linux-serial@vger.kernel.org>; Thu, 06 Nov 2025 23:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762498960; x=1763103760; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HK0zc+zHUz2Ja/vHfOXPe90XCxh5ZbPuEODlLo0Ne5g=;
        b=Y6SPEswhzMWGfcrTM4CMrj0CIWV2Rp9hS1EsjLdfOON0g5UAOrM5tN7Q5Wt6ccOwz0
         S4zizgpqXlVWNznNPESPRGIiPyVUR2ZZy9hm80k4f2Y+EZJAf79k9SoSj/LT7V8zPiDY
         Eo7hkt2BP2TmiqO9E8r321IHFbXi9JTSYL0lj+/Dg4k0yV28754M49fYLOryhOxFONgx
         oXuwuEUECiHgWzHswm3jZCuLAeL0NpiFHhYGoCEEbYJsjMaKwJ2SiQZeyKOSeec4dPyC
         njUWgPToLFTDf2DhqrR+fzKWWEIPLewst9glA5uCOZE6bLySJu/UUN9u4WkxHQouHpAR
         z4cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762498960; x=1763103760;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HK0zc+zHUz2Ja/vHfOXPe90XCxh5ZbPuEODlLo0Ne5g=;
        b=TZzlZnb4h5ST5W1OG2VU74bEyybEVW484dfy/x+88Xx7S/FYIraMjOqNGhKJ9em3L9
         EIsUYmtei5BrxtIoUOZ4rJV2ZYQ33bVcI5R+Qb7dW8AuGydL9lIjcvhnqifUV/NGVpN/
         9YkDRW415hPop7dJqA+5uv/oZ7myMqSxRB5nPGaE3SZwU88W0ns4kgb4kMYCDT3KUjVJ
         Blsc8bdhZZ9jjAFHx1KMDT/KgRJSDafYAH8H/mf8ak8ko6ckadyYPILgX/sAkWf5NGfw
         Po/zgddHx7SFWvRsvgX9FMDkdDOaNQa2FjALEEChGqiI0V9qz77AG0UZgvqqwZnr2Bsk
         I/fg==
X-Gm-Message-State: AOJu0Yw7XZgPLjFRzKml6qaqQwbeBq0QZLypitRJc21zNPchTbfwZ4Y+
	GimJA3mSLr7IKt/4AWK8Pl6SD+mUaN9SbzPLVSe9cOvf69///WIkX7DKyAW1CxYWzw==
X-Gm-Gg: ASbGncvc3A2+/2eO2oH6I32Go5TU9Jsp7NNIDS7UCmsOzosY0jWWD7R1C2ib9SPUte2
	d39zq7mV8KWMUUunNuTFoaR7yk81sVFf0996rkvdPWbIY2myD02m0sO6It/5wTKiK/x7eS21Br8
	II6yQo01DVZZkIcsJEy5gHSH94HE+Y/2IQUPkLZ+1i6BLyJ71XFQ9STxpoEFm2s1P5h28WYHkjq
	dnqMaC/ZCVnRHg0CyEdA0T0U+GDINOIUfRL9i6B7HrBpemPZZ5dwqGev8Q2s6jML0DxpkDsVlR8
	7UXnL9/ROdKzyfoDq+NoE/YCJhNmvo+k3aBEsGFyGeFkCqjcmN8GevKVxV8gbndqK5VsuwRHx0f
	JCvXN8em841kXrBE6PuzrppK31D4UecUPi6MRuqNHTHri4gkS5CfCrbKn3fU6NHvfWT2PiuFD7y
	IG039nyn2TugzZQsER7ORTkb8WKgDFT9Ia0tHkTm2y4c+cKt64L8d0UMLfbXyh7BxC/Nisi3A=
X-Google-Smtp-Source: AGHT+IH1OqzaDKdQzy8WiFk9OTJ/Yq83YxpFgmhCNQFUxkq7Nz/+Nrm5G7ewU3G/jDyji6GRBY8Axw==
X-Received: by 2002:a17:907:9716:b0:b70:af3d:e97b with SMTP id a640c23a62f3a-b72c0929079mr213373066b.17.1762498960389;
        Thu, 06 Nov 2025 23:02:40 -0800 (PST)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de. [37.24.206.209])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f862cbesm3402097a12.31.2025.11.06.23.02.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 23:02:40 -0800 (PST)
Message-ID: <1293765e-3db0-42f0-9796-3ca9d87b2c08@suse.com>
Date: Fri, 7 Nov 2025 08:02:39 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: your change "serial: 8250: move RSA functions to 8250_rsa.c"
To: Jiri Slaby <jirislaby@kernel.org>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <9515bd4c-4bb6-4535-818c-283e69feb0a7@suse.com>
 <90dac630-9b2f-4532-944a-eab7cf754caa@kernel.org>
Content-Language: en-US
From: Jan Beulich <jbeulich@suse.com>
Autocrypt: addr=jbeulich@suse.com; keydata=
 xsDiBFk3nEQRBADAEaSw6zC/EJkiwGPXbWtPxl2xCdSoeepS07jW8UgcHNurfHvUzogEq5xk
 hu507c3BarVjyWCJOylMNR98Yd8VqD9UfmX0Hb8/BrA+Hl6/DB/eqGptrf4BSRwcZQM32aZK
 7Pj2XbGWIUrZrd70x1eAP9QE3P79Y2oLrsCgbZJfEwCgvz9JjGmQqQkRiTVzlZVCJYcyGGsD
 /0tbFCzD2h20ahe8rC1gbb3K3qk+LpBtvjBu1RY9drYk0NymiGbJWZgab6t1jM7sk2vuf0Py
 O9Hf9XBmK0uE9IgMaiCpc32XV9oASz6UJebwkX+zF2jG5I1BfnO9g7KlotcA/v5ClMjgo6Gl
 MDY4HxoSRu3i1cqqSDtVlt+AOVBJBACrZcnHAUSuCXBPy0jOlBhxPqRWv6ND4c9PH1xjQ3NP
 nxJuMBS8rnNg22uyfAgmBKNLpLgAGVRMZGaGoJObGf72s6TeIqKJo/LtggAS9qAUiuKVnygo
 3wjfkS9A3DRO+SpU7JqWdsveeIQyeyEJ/8PTowmSQLakF+3fote9ybzd880fSmFuIEJldWxp
 Y2ggPGpiZXVsaWNoQHN1c2UuY29tPsJgBBMRAgAgBQJZN5xEAhsDBgsJCAcDAgQVAggDBBYC
 AwECHgECF4AACgkQoDSui/t3IH4J+wCfQ5jHdEjCRHj23O/5ttg9r9OIruwAn3103WUITZee
 e7Sbg12UgcQ5lv7SzsFNBFk3nEQQCACCuTjCjFOUdi5Nm244F+78kLghRcin/awv+IrTcIWF
 hUpSs1Y91iQQ7KItirz5uwCPlwejSJDQJLIS+QtJHaXDXeV6NI0Uef1hP20+y8qydDiVkv6l
 IreXjTb7DvksRgJNvCkWtYnlS3mYvQ9NzS9PhyALWbXnH6sIJd2O9lKS1Mrfq+y0IXCP10eS
 FFGg+Av3IQeFatkJAyju0PPthyTqxSI4lZYuJVPknzgaeuJv/2NccrPvmeDg6Coe7ZIeQ8Yj
 t0ARxu2xytAkkLCel1Lz1WLmwLstV30g80nkgZf/wr+/BXJW/oIvRlonUkxv+IbBM3dX2OV8
 AmRv1ySWPTP7AAMFB/9PQK/VtlNUJvg8GXj9ootzrteGfVZVVT4XBJkfwBcpC/XcPzldjv+3
 HYudvpdNK3lLujXeA5fLOH+Z/G9WBc5pFVSMocI71I8bT8lIAzreg0WvkWg5V2WZsUMlnDL9
 mpwIGFhlbM3gfDMs7MPMu8YQRFVdUvtSpaAs8OFfGQ0ia3LGZcjA6Ik2+xcqscEJzNH+qh8V
 m5jjp28yZgaqTaRbg3M/+MTbMpicpZuqF4rnB0AQD12/3BNWDR6bmh+EkYSMcEIpQmBM51qM
 EKYTQGybRCjpnKHGOxG0rfFY1085mBDZCH5Kx0cl0HVJuQKC+dV2ZY5AqjcKwAxpE75MLFkr
 wkkEGBECAAkFAlk3nEQCGwwACgkQoDSui/t3IH7nnwCfcJWUDUFKdCsBH/E5d+0ZnMQi+G0A
 nAuWpQkjM1ASeQwSHEeAWPgskBQL
In-Reply-To: <90dac630-9b2f-4532-944a-eab7cf754caa@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07.11.2025 07:23, Jiri Slaby wrote:
> On 21. 10. 25, 8:22, Jan Beulich wrote:
>> in this change you moved code from 8250_base to 8250. The latter has always
>> had a dependency on the former. Now the former has gained a dependency on
>> the latter, i.e. a circular dependency was introduced. Maybe modern module
>> loading tools can handle that; on the first (older) system I tried they
>> can't, and I had to resort to setting SERIAL_8250_RSA=n as a workaround.
>>
>> One related question that came to mind: Seeing that both drivers are built
>> depending on the SERIAL_8250 setting, why are they separate modules anyway?
> 
> Thanks,
> 
> could you give a try to:
> https://lore.kernel.org/all/ddfbc4bf-658f-3eda-5b4f-f111ecd932f5@linux.intel.com/
> 
> (It moves rsa from 8250 into 8250_base.)

That'll certainly do, I don't think it actually needs trying. The broader question
remains though: Why are there two "core" modules in the first place?

Jan
