Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792602257;
	b=Um/SqlAsv2sLcUVl2/HNKJBzzB2Q4/GmoQxOzDDTPymkJe93GPEViX7nyPFipJzyODQ6
	 ZDBF81Cz1D7SzcJjIMb35AoIF/oq9UmyS6e/rtIRDVbRkKs59z7RmlKEkTefS436Un0zV
	 tAgbcELGB1pD7xvPEcEcRu0h2hr5ry4msTr9m6ysRnMU/PbOcXYxYEEitBw/XsoEhKPPW
	 FOfjM3V23OTSjtdkudxA9UDgawhIvxxKLzdWnM2mXgusnYFHDo7ZeIrtBMUbFYTeztmCH
	 aG8dtoIOjf8byhw9sTNmQbzqGeBkowY7Bsy8oUz0bc6LRdkHxuodIly62dSu9D+ZZHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792602257;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=Jz1PsVKfLByVoOLZveZuQnHIhjOghHzTozlXRwWyQFY=;
	b=m4FfAmIcHzOwcUhxuJrEp9MD3S0WXwAEwlIFUBXsjVIPBWB/3DAtWbugoKO8Lu6eOnWI
	 q6WBvQS5VzYlvA58vfzis7qthDtDmoKCNGnQMgCPTW7Qq4r3uqM2zKBCsAfLYPXep73xr
	 VU/ZhF/C/ferIUa3LbHFoZUI1wyghgOZbiIdWw3PQPvJC0eD+O0+gA9Hrf2fAhKmhbV8A
	 YNsdyDGcoz13m7K4nlKsHWMiqFYyUNxc0SSo+1HITcMOmPVgR63mLhYzcCE+ifs+BnZwH
	 CH7ZEe16TqCb8X2dpUt8CVVWFkWTVLMTa8s9POOfOodSbmeJKSurOgf+hmImI4As2Xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XhTlCR7v;
	arc=none smtp.remote-ip=209.85.217.41
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B876606A320
	for <linux-serial@vger.kernel.org>; Wed, 21 Oct 2026 17:04:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B876606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XhTlCR7v
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-7907f01e487so301510137.2
        for <linux-serial@vger.kernel.org>; Wed, 21 Oct 2026 10:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792602256; x=1793207056; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Jz1PsVKfLByVoOLZveZuQnHIhjOghHzTozlXRwWyQFY=;
        b=XhTlCR7vSdYc6xYIXY+4YWo5PctxS/eg+nF0tTI68R0wVdyxDVGBrzKBf/vP34pSvJ
         XAznc7rukb2wtB1NqGIS5vQeaCB9MBnXyvKRfs83ldM1IPeXlB79qnKE6vXs3lHq95u+
         ogvPuri41Rl7agULw8/F7KE8DKjinlMy2SkfjdDfTwRNcxWRaoptKoTfhw692uooupYf
         HyD6hwViiseOQyCZWc8633SnsTVBIYggx/vZpkyCnhr6pmhXkmCNT85aqgpnLHEz6cRZ
         Q8nKtiMcg7X/Eu9Xtswr36jVhpGiPY3wkZz7dmRtvVd/clbcMzf2UcmXk+ZgzlfO2ekM
         ucAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792602256; x=1793207056;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jz1PsVKfLByVoOLZveZuQnHIhjOghHzTozlXRwWyQFY=;
        b=ONXR4ss66BE2sMPi8YnWkj8ZEiW1bwKBelFlOFapMvffa0pDnHLg4geMTjxcWL49D1
         uR+/FvbNEXVhpefjNx6mf5GukGTEcIRM1cQtUcPjZXhsd742FgLn3bsGGgC8gEFLGyan
         9cRrDXlb/T5SPp+e3nFcbXUpyCvmvfXyy9Ci0hGGfuTgVG/ZyZ7ATRnfqHgTpMES302Q
         efwFnQC30WQAWbQi6Sr2hXBuA1b0hd+b/Rp31kARjGV0JiRuuSzJXxhBfad4T3APLDGh
         HOv1+waSLKr+W4JsnzG/mxzSCOezjihdMJVypTuJBrgVhs5CTfgiGT3R3iXLabYdafeB
         hoOg==
X-Gm-Message-State: AFq9FYLQEZ5STnh2LqsXdNZY5dmTGFc2gE40R/rxhlVToruf5J54LKtz
	Eeashi3HOj4kkIXB4BLu/8rfznBuFG73aTsSwzE6qC398kfdV/vJXmoG
X-Gm-Gg: AYBFou3GdWSeKoHZxELlnkMCnDhmtRZOOaj/N8UeY3ZhfxDmmFcEOL3DXolcm10zPUl
	kEGba/hvcb8QEvc6lQXQx/X++hsP0T1XEJfJZV4ZJpZnRpMdUM/r34ldPxGEWHZ+YdcDg1qyH0q
	Gw7u9Ii4GCm89BZI8LO5MP7DohGM5P6kVI3P0CwmB86900tNwc9OGjbm2wggMu0OSc5OKcLwtNl
	K+00yFjYyhPytB6rKHNBfltCfVLb0yedtL+yo6YFbzLsuPywSz510TZz6ZWAcdfg22xuqNbWJ6i
	eUQ6dkXUihBbAS53IKQPKbqpgAN81hhqBCBZX8tKQ3TYx/tLNljlD6GzzVig/eeNb7LIXMzhH53
	qR8JaDz4LNHnXPVqlD2LmbjSF1MzLxsC1Cq1GPpuBV2fnz7PwcECtgrXlaq/ICG/8977RqqQlid
	ilRjIc13UAG3lmljaZH7FvnJR5snWKREcrBdzEZTXZ9mrv+JdTB0RgLdZD0irk7LF8WvGd5k2s+
	3b7wmZfTQ5YMJ3fb5mA5+1AMznkOdapsxEKk9vycUQsZBDVGp7xMZzGOzA35VwGgrjhY7zg1cmz
	ZEpyO1s22fJ57NN54cGBoS3HiPoXZPszPO+prs1uBXU4XMwgaVUj+6QOY1m5n7g=
X-Received: by 2002:a05:6102:149e:b0:7cc:9d46:f091 with SMTP id ada2fe7eead31-7cc9d470bbamr602076137.24.1792602256305;
        Wed, 21 Oct 2026 10:04:16 -0700 (PDT)
Received: from MaquinaLab.. ([179.179.238.247])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7cc924348c4sm3367159137.11.2026.10.21.10.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 10:04:15 -0700 (PDT)
From: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-serial@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	Andre Przywara <andre.przywara@arm.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Enzo Adriano <enzo.adriano.code@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/4] serial: 8250_dw: Keep the BUSY-safe divisor hook when DLF is present
Date: Wed, 21 Oct 2026 14:04:03 -0300
Message-ID: <20261021170403.2052449-1-vinicius.eduardo.pedrosa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <atjqZPuAbHDdaexv@ashevche-desk.local>
References: <cover.1792439398.git.vinicius.eduardo.pedrosa@gmail.com> <cc358c2be6b0b4ea0323e4f694a581ffb667112d.1792439398.git.vinicius.eduardo.pedrosa@gmail.com> <20261020104753.28703-1-vinicius.eduardo.pedrosa@gmail.com> <athe0QikG2mzCAtd@ashevche-desk.local> <20261021100049.16504-1-vinicius.eduardo.pedrosa@gmail.com> <atjB-BnXclL3FcUm@ashevche-desk.local> <20261021153732.1978410-1-vinicius.eduardo.pedrosa@gmail.com> <atjqZPuAbHDdaexv@ashevche-desk.local>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Andy,

On Wed, 21 Oct 2026, Andy Shevchenko wrote:

> No, just pass that as a 'bool autoconf' to it, and assign those callbacks
> there, while calling dw8250_setup_port() unconditionally from _probe().

I think the autoconf approach works for Octeon as long as everything
dw8250_setup_port() probes today stays under it, including the RS485
detection and UART_CAP_NOTEMT, not just DLF/CPR. With autoconf=false it
would only install the common divisor setter.

> I think it would be less flexible, also it will add an additional branch
> (actually two) each time the set_divisor is called (not that it's critical
> but just wanted to mentioned that).

The idle callbacks have to come from the drivers, since the
dw8250_idle_*() functions are static in 8250_dw.c. Stubs for LPSS are
fine with me.

> I dunno, I prefer just a longer solution, but I don't know how big this issue
> is that we need to backport in that way (and not taking the whole series as a
> fix).

On the severity: the IER restore comes from a7b9ce39fbe4. On the A733 I
saw hardware IER left at 0 and the console stop taking TX/RX
interrupts. I haven't tested this on hardware with a real DLF.

Given that, how about keeping the small fix as patch 1 with the stable
tag, and putting the refactoring after it in the same series? That would
keep the fix independently backportable if needed, while mainline would
still end up with the structure you proposed.

> I have Intel Galileo board that uses 8250_lpss.

The Galileo should be useful for checking the LPSS path.

Thanks,
Vinicius
