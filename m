Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324B41B9B43
	for <linux-serial@vger.kernel.org>; Wed,  7 Aug 2024 10:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723027783; cv=none; b=MqWo9IKqAaztVz9MBuk8ifKbIj2ovGb7Wh/0CH1VFJ1ScmQ1xqjOXAxDju0H+J+pZ0o7Qm0piIwH7fgtoUJNJnGmA06uprJttHKPAeZPC2hO53Ya8M76xFbF+tZB9J/NHiTi9neKN5C0Wvgtf4nDJeDPa0ke5n9dMR72WnywTPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723027783; c=relaxed/simple;
	bh=Yyfk8X7hQAsUD9G+4fe4CzUE4boCyIRsCV8/4Z21Gnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LjJBxVXznYX9rmIMFHoyoD+Gx5kUv1P+nH7K3wCzK7XQDf3CW7H0gqwHzk0o6odYUKvoY9I6ihSdjeb8ZMZUrf5di5GwSNEKWe54JKWZ0w0M4+mS55mDPiw4K0oEfe7BypzDMG+ma9m0Ci0uhHqYeD7ebN8f/ffXt29jI4BsxgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xosc+3ok; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xosc+3ok"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5a10835487fso2621889a12.1
        for <linux-serial@vger.kernel.org>; Wed, 07 Aug 2024 03:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723027779; x=1723632579; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yyfk8X7hQAsUD9G+4fe4CzUE4boCyIRsCV8/4Z21Gnc=;
        b=xosc+3okh0nio5SOFOISjCL6L7mHRsHPMLR5GEcud3OhGiH0TBD3t/QDW5SlQn/tFD
         JoOgOubnH/gFWcl60NMzvSRHnCGb4H6L2Umcnep8QNBI/qDu5pb8AbwOFmcYwn69czI3
         bEEq9X8i2NM/mEBaVN0OLgaref7U8EygNDp36qiUAeygbAetf/j1KGFtOJCFfESWoaaq
         BMmMRNnzHP1FmkvodI768ZcJcfN6TiFe6KhpuHmq5ZIMPI1ZQjUeZl92yM2duAs2TPQm
         txrHSmyiHWlkcUtz/X/xepgVr0EDu6H+rGNkH+HuQauhbT5LXXoTqFNHK2b97cJMPx5N
         1W6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723027779; x=1723632579;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yyfk8X7hQAsUD9G+4fe4CzUE4boCyIRsCV8/4Z21Gnc=;
        b=eTEC34VWAW5l9SYoYi4lCTh2/pshBnU74TyuBKDeFKBytyj+lxh0sptUfI/wf9KTSi
         HuPZKxoVDzsS0m1Pu3q4vVYFA/o3Nq+q3aQ/G60YLAZpgZGEMppbmudMKBDoE4LavbUi
         jgxC6d5nFOgwk8rHwWVWnY/DDI/hIeBbwMRAna2Kc2YUQWkZrYGgO4yPXWZI6vMgVM2X
         es6YUd5nTazryXO5dZ7VxcomsdQxvruGoPPhv74gFKNZlHouGf3xdAG8Ikd2wWEjE4Q4
         fkBLliYLyQABZQf5H2f7nGFQkRVPu8tJUjal5SaciM/MqrcsZxF+KuKyyHoZfrxK1EPb
         yrQA==
X-Forwarded-Encrypted: i=1; AJvYcCVAuDWzPyMJ272SikZ4avKWjeSRAn8R2dkyMmV47Ngz11gTtOr40ipvn4+e1rrFl9Tsl1bxLOsvo1aYmIBJSBINDf1UvQlhRdrsOgna
X-Gm-Message-State: AOJu0YycR0pW+ayJqhNMzV+eWhNQS6fmPjnRvAY1rczCWEKcJkAZG4ZR
	JvmMRbtgpY5Ki1AkH/0046r7LRuvQIxg5UzrUJ5s5ds+YB5CifV0vwiM8lhRAUY=
X-Google-Smtp-Source: AGHT+IHSY0bmLDfSGhbBtnMDOvhC7FSiF7eS5TVjfR9u4hhBM5eeMK2YDYd/3F4hcgHZfhOFJjWUHA==
X-Received: by 2002:a17:906:6a09:b0:a7a:bae8:f2a1 with SMTP id a640c23a62f3a-a7dc50a2f0fmr1328523566b.42.1723027779415;
        Wed, 07 Aug 2024 03:49:39 -0700 (PDT)
Received: from [192.168.0.157] ([79.115.63.215])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9c0cc4fsm633411866b.77.2024.08.07.03.49.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 03:49:38 -0700 (PDT)
Message-ID: <2e639150-5c7e-4ef4-b54e-b25b10fc9313@linaro.org>
Date: Wed, 7 Aug 2024 11:49:26 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tty: serial: samsung_tty: drop unused argument to irq
 handlers
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar
 <alim.akhtar@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>,
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20240806-samsung-tty-cleanup-v1-0-a68d3abf31fe@linaro.org>
 <20240806-samsung-tty-cleanup-v1-1-a68d3abf31fe@linaro.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240806-samsung-tty-cleanup-v1-1-a68d3abf31fe@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
