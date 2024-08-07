Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053CD1BDA84
	for <linux-serial@vger.kernel.org>; Wed,  7 Aug 2024 10:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723027796; cv=none; b=ne4k/0cni0XkUVsdzShckrUbd7hdMfK9RvM1wRC0NgdmOSN8JofK67dNweqCYgU9uQTDj96rJKHKqelLDIfGbwnJI0s/hWHqT5pSc6NlqD0SBSZiGqed5rB9fVh0Lb2QivdVjoJS6iJSa6Rc7ogRybxlF8Wz5p0yV9DmBV+QsOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723027796; c=relaxed/simple;
	bh=Yyfk8X7hQAsUD9G+4fe4CzUE4boCyIRsCV8/4Z21Gnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bI1mATenPyK/+rS1VQtu2057cBYOlipv7M27v+ZDb3oQnqgNnUxr6cyVLhUiHnTPwIgjw0SKGzt18GuPfI0eYdCWbGzm10sG2bveWRHh3ZbgIhx6Q3bQUg+uMlP8lljVQnV5cqDVOXMM31AD/GmWQo+ckidFCLKXVIQIEIv7qMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wWfDEtyM; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wWfDEtyM"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5a1337cfbb5so2202005a12.3
        for <linux-serial@vger.kernel.org>; Wed, 07 Aug 2024 03:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723027793; x=1723632593; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yyfk8X7hQAsUD9G+4fe4CzUE4boCyIRsCV8/4Z21Gnc=;
        b=wWfDEtyM/beeCPTbINvS4LR/qV0buUOnoBe/Qe95we9QrBT9LxnKyy9LB3UAi6Nm1q
         rq9uQq3q8TafQo6UAUJX2twF5mqjs5vuW2rb/w5YX6kZKJdwJLjPknZmC+rav6Lq2g2T
         Cz4eiZVXy1PCEjH8D07J2R7wCK1Z3c/w1LwEnVjlVvAZahXo0rRF+nb+7FIa5ifgvvMP
         sk8KoQKLwByVMUMAhu4crfSHGDoT3LIP9egLDkUKCCUv0F7ajeXjNq2MqLqTCNBpLJqr
         iZ7yEWOEYiJvVzk0l449gHdSwJGx1qf1qx6sMhyvaeMQ+8VlhDKw9DGzXOe0SOLvfPBC
         0Oig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723027793; x=1723632593;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yyfk8X7hQAsUD9G+4fe4CzUE4boCyIRsCV8/4Z21Gnc=;
        b=BtvbSe0/D28XOE9jIfh3niwbfiPaBAEPmhS9pHTZ87FMuqU2+r5swVbO1bL99LNVE4
         nktRv5jaWmno7FAR+TtqfhCDDN4r6enlLkfXIn2p2fdP6Vzp+ReRLiCB70JXhcHWMC/7
         gkb2oaiYg+rjg5ePyON7K/uaKhpODirRVgRFiu0q3SvQNoAtXR+fFQUqKsIQ/xIHhgBe
         o+4zPt6WFiUeNuDGId2CUqI9hR9GPcKOoq6gxl82LNaJ4XYXJBiYqhApnM381c1KJCTi
         4CGl3/6y0tXbaZ7hkYTcRjA+Excb8SQIBJ4dAPcj6VR05vMSRwuqkgwXbug/kxq/VN8F
         9KCw==
X-Forwarded-Encrypted: i=1; AJvYcCVJNXZo+LEHx56MOm2yiSES1LLWf6GW3Ws4+qD2OxtE8My1gThbhPCDRdoJNANA3RvRf0pMKYDOMRYpRG+/K8TvhGiHW9Q8f7F5s+Uu
X-Gm-Message-State: AOJu0YyZS/6MmlUkvN02kQ7XMV2++y/kZlcCEEnoE6Ng/SzUwFHAXTBv
	lXs9PZ1Tb0GYKSDY4FZwuih3CSo0gclWGZfo2Ukg2PkogPxbsq3iYTIkEqU8C7s=
X-Google-Smtp-Source: AGHT+IGNiGCq3xQ9xD/+A6JIjYRH2TLuxM8b00m6SfTS7ooJvqyRwtUE/xU52X3j9tq8YE70TwQltQ==
X-Received: by 2002:aa7:cc90:0:b0:5a1:a36a:58ba with SMTP id 4fb4d7f45d1cf-5b7f40a92d6mr13263700a12.20.1723027793303;
        Wed, 07 Aug 2024 03:49:53 -0700 (PDT)
Received: from [192.168.0.157] ([79.115.63.215])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b839716490sm6940820a12.5.2024.08.07.03.49.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 03:49:52 -0700 (PDT)
Message-ID: <7e18004d-e721-4223-a0b8-1f7453cc99cd@linaro.org>
Date: Wed, 7 Aug 2024 11:49:51 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tty: serial: samsung_tty: cast the interrupt's void
 *id just once
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar
 <alim.akhtar@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>,
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20240806-samsung-tty-cleanup-v1-0-a68d3abf31fe@linaro.org>
 <20240806-samsung-tty-cleanup-v1-2-a68d3abf31fe@linaro.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240806-samsung-tty-cleanup-v1-2-a68d3abf31fe@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
