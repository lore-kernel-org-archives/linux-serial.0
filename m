Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE4F39E6F5
	for <linux-serial@vger.kernel.org>; Fri, 15 May 2026 09:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778837359; cv=none; b=An+sr9NPhKFot2hBKPv4tl8GpQjhITittDQSWnQg9CwQibEzv/Lg7Sn/FYcbrtxRRgXVX9Rej2qmcKFYdQNyxmiZqtNNreg9Inh2Iw1I2uZ74U+OxbZreRHAjUDf7d0rhH+eBwkyt5QchkankJHDcMBJB0o6s65d+IW8DoCE4OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778837359; c=relaxed/simple;
	bh=v+pupytczKAjPJGodDLVEr1rO2j5I2ZpqEZPCdYnJ8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qiBWY7dnHGRTYwX714zpvwQ7gdvkTh0eSJMyTzaKe+ZkshSdvZR02/iUfcry3pkN6qyg270uNMmWzbAIcZYyXDg6iBCJLglpi7ECIBowMG+sFk5F7w2pxdDK5GuEtzPWySeUyY9cV6nixbjVO0n1YvKWo/+bIEEFAuf4GRoNhFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ax00u2zJ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ax00u2zJ"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48a7fe4f40bso102503025e9.0
        for <linux-serial@vger.kernel.org>; Fri, 15 May 2026 02:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778837356; x=1779442156; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v+pupytczKAjPJGodDLVEr1rO2j5I2ZpqEZPCdYnJ8c=;
        b=Ax00u2zJfOWhpd5bb+/hdVew9ViKdCrtQSJPeKXOAGlUZ2pqI9o9k6N5lVdaaIi7TU
         W1zdDCe8ndoTqFV3ckv74DUW26LDO3fnDv/o1VOa3Uiml8Z8oebED7WQ8dKRYlhzKprD
         QaSvUzHHXkIJaDlSOsJTVKYM9Yj0d3cQa8iclJJiAPJuFGJ3pYXmroIYeXEupHbjBxHI
         vlC9SugWfw/kutEYAi8qgFEkcTyMdbhDasC5LTbzGrRbKWnNB7Eq6uFyptiHaIfXLRQc
         k5s2Pe2Ph5R6cCbJOxuTqNNa5gPZRIiRTSAYzSZsulaNLnBar41MbF2hrgSPa/muFxMX
         Oayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778837356; x=1779442156;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v+pupytczKAjPJGodDLVEr1rO2j5I2ZpqEZPCdYnJ8c=;
        b=mr5eN2PVHcQXxfSHwAdlAaZ33BaMkpDlwVD+rinBBoWsNBDcG/qaSsG/3rz4gZWnU0
         Oh4HSVLkqbTMOz8rjLYUpHm+Vd72OSq8Zj7RHJcWKFOB/E3f1Bfi5QoJYqN2wqkzgvw0
         bJ58urzjo2AbX+GooZ+1GMXQEap58fzAv8LuMJZePJjYLaaUNDbjZVoAmQdHaW5JnG6g
         /b2CvrvHgAZR8sWkrnJQ8OCBB2RrVzKbstIxml1Vrx8yIB1kKJwG7C6hE1IOyPgvujxl
         5+PyB5Evjf0SXbnCSHJ96MkXkALwd91fX4S2ergn76dOes1UKgywGTR9Z2hsazrlgQo5
         XJfA==
X-Forwarded-Encrypted: i=1; AFNElJ+Z7PYEonQAUwBAtPKFnzQ9R1xaZN0lkivyiV/Rn8HVZvNDSoAtNxaUOyyhvDwu4ufD4+4lgxR8xKl1/1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSTQUp9clZq/PIshh/uMOurbQztNo8cXM15gegGqV3CPpCPYMe
	z3ewhmf1piQL+deXC0T1WfOD++cSy9hSF0HO2UFo+ZiEvF4mUoXuyKeyksfAn7NaI7Q=
X-Gm-Gg: Acq92OF+m0GZAePxqcPgPYAs3p8ft/DdRrO47NfF3fWyADuwu3j4o0A3ovLGsAK6zD9
	YafrttUPKJagrbdK3q39dTHBV26ZvOYnEpOav51LRWRBE0t23KdfO6bsbfCM42hMRYSMzft7cPs
	SlKCzrveEhHt9J1Tq6vilYsgG5J5hQ8rg2LVkwpSbsc2OnpW8iLN6lrprmgDR3dQZlva3oeq/+l
	xm21zNM36PQaTKQ7EOLaTZJN+dYOi1uY9GGHI0/xpxkFE2GEiaENqzw4oF0rIu2hFu5J2bIxXje
	PpOlMqJDiApNoYTDl+crJiSKAKPXuItUPlIfOIN5WVDNuSPplXYh55Askpp5OQMVLUmFKLaA/s7
	c/BMMckxogEU7FMY4pPIL4x5qAfklb1Sc0kP6t6y8BsiQ3sWccaRc8krYYXYS1J5TOoKJt7A7vM
	g7Bp4G8BPa7MQs4OB6QZurci3yM3lNMpIp
X-Received: by 2002:a05:600c:4455:b0:48e:8dec:19ad with SMTP id 5b1f17b1804b1-48fe60ea94emr41434695e9.12.1778837356485;
        Fri, 15 May 2026 02:29:16 -0700 (PDT)
Received: from [10.11.12.109] ([79.115.63.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe66544sm9672215e9.23.2026.05.15.02.29.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 02:29:16 -0700 (PDT)
Message-ID: <f15efac1-0df0-467b-8d75-18383d284be2@linaro.org>
Date: Fri, 15 May 2026 12:29:11 +0300
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH tty v4 2/6] serial: Replace driver usage of UPF_CONS_FLOW
To: Krzysztof Kozlowski <krzk@kernel.org>,
 John Ogness <john.ogness@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
 linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Thomas Fourier <fourier.thomas@gmail.com>, Kees Cook <kees@kernel.org>,
 linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, sparclinux@vger.kernel.org,
 Peter Griffin <peter.griffin@linaro.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Alexey Klimov <alexey.klimov@linaro.org>
References: <20260506121606.5805-1-john.ogness@linutronix.de>
 <20260506121606.5805-3-john.ogness@linutronix.de>
 <87lddvy2dl.fsf@jogness.linutronix.de>
 <1a5abd2e-e9ab-4a48-94c2-5e082f57adde@kernel.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <1a5abd2e-e9ab-4a48-94c2-5e082f57adde@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/13/26 10:50 PM, Krzysztof Kozlowski wrote:
> Cc-ing also a few Linaro folks
> which are using this platform and might be able to help us here.

I think that will be me as I worked with the serial.
I'm a little bit busy right now, but I'm adding this to my todo
list in case no else is taking care about it before I get to it.

Cheers,
ta
