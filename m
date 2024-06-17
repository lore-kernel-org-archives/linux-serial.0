Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E534917E900
	for <linux-serial@vger.kernel.org>; Mon, 17 Jun 2024 18:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718650388; cv=none; b=bCqhlH1ipeDVY6HOagXMjq1QxH3Iz5EguozoVZkZXaOaPY8keSeld+7Kyx7ItWKfjaAsheWEKBqFeTMzIOvjusPsnIjgeA44A6//A/yznYw3Mk2GCYRmw1zxk01C+E55tadkdx3tA+xdYktsI3Nex/7MRFcBeBI68pEQwhMnvQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718650388; c=relaxed/simple;
	bh=K9KjBKCkpXLAqOUVTwlZWowQdOkv1eWRfWuRpNdDdC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YQAWVO5fNBj2iOyA9dCxIfvei74y7upiKTpbwA3aT0Sli8kacEzYl4L79sKSaoGYsb7z72sOTov2jdRrfCdU0w9h+pRNj5P5YrMaCSesSaIp+uge+XzxapUf5IS5u6f240nVqOWfvsJtBMljJdeQb0tE73SfVnZHYMORwTrvPFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=adwwQhkU; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="adwwQhkU"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52c7f7fdd24so5943098e87.1
        for <linux-serial@vger.kernel.org>; Mon, 17 Jun 2024 11:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718650385; x=1719255185; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MWy7ZuXKNt2Ozc+a401wysn7JDFxJ4mbR0Kx2EK+fP0=;
        b=adwwQhkUT9dibSw8WUspUawD54qOfBWo96bBCEI7559GbXPD74Kvd5JXSEe8VreSkp
         y6z6DNdPkwQfaJ3zaQa4BTWfN2lq/u7rU2SK77AbQfIL+p06CcgiiqS0EakfDlv47xVq
         CjLcK4xWw5SdYmYln47YNo2BaVadWx7bWBwDKZfkNQZOpofNv4eygYWQAiw1FN8BuPFt
         WGenlCkKhvMUcNF9RVq7e6pPnNqM0+00SSdQXOaDLblEn7mvJGj9tU43imBebP3C9Plc
         Xkl+FGdbWfna2Js8UbVYt4OxFZ/kKT5KBXA0WnHjjrXaueRotmURX/H6xuDAfoB0bAAy
         58Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718650385; x=1719255185;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MWy7ZuXKNt2Ozc+a401wysn7JDFxJ4mbR0Kx2EK+fP0=;
        b=gUXnVrBSKYjx6wbE1JFIhq0ts2v4X4c1jw8xDzz5yqf179jjUnw9mVtNqKCzBUoPl7
         /oBn/yP01vZifJAnve5YzDz8dMpgkdvbEMeJZDVN9N3YWM5CGqhGpaDI9UL6nbyd/bLO
         onzTV9GeZs57hM9r4hr254LsQSaE1ZMiHnovYKep3MnG420DYXe+I9D+HqHNlJaXWaPb
         KzQ98WMyZ25WPabv9p2dt0Jtd6/bCBmK2AXJ308NprOlgdalWYuW9BcWJEIDhecoVJmS
         5D8xPVm4hw6Hy7bkj3LKeYPWDQlHwyskrGzY0vIjMwaUwP/j5cemMI9sPmElEmXvYHL4
         M/0w==
X-Forwarded-Encrypted: i=1; AJvYcCWdSPnaZc+SzhuXZsq++46K4Acb07iLO7vxjnvHzTMkc7UlOCFixL3TyociWp1Sj0AFNlwj8ocpaMnbAHGfb3nWXuUwrZb4sU0Tm/0E
X-Gm-Message-State: AOJu0YzfAGKrKASmIZCSwg+/qP5/HjBK1k05OrH3ZutoJJb2spMyRNrU
	vuHsXB0/X8ntAQjX0QXShgSxv6nNjN+Z1GsqfRFe+NnEY5eT+pWPUXSH4fyIvdw=
X-Google-Smtp-Source: AGHT+IEWLFZZ0jt8SRhky/z9Jh7PVDX3/2EZDQYZkcA5mbEYl1CnAWhQD/l67EYmxT3DLAleDU3ugg==
X-Received: by 2002:ac2:43d6:0:b0:52c:a9c2:d363 with SMTP id 2adb3069b0e04-52ca9c316abmr5936135e87.10.1718650385024;
        Mon, 17 Jun 2024 11:53:05 -0700 (PDT)
Received: from ?IPV6:2a00:f41:cb2:a9df:9f88:17b:c7e7:fa59? ([2a00:f41:cb2:a9df:9f88:17b:c7e7:fa59])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca2825b43sm1301472e87.12.2024.06.17.11.53.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 11:53:04 -0700 (PDT)
Message-ID: <c45cc12e-40e2-4a1b-8055-b3e956ba2a24@linaro.org>
Date: Mon, 17 Jun 2024 20:53:01 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/8] serial: qcom-geni: Introduce
 qcom_geni_serial_poll_bitfield()
To: Douglas Anderson <dianders@chromium.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>
Cc: Yicong Yang <yangyicong@hisilicon.com>, Tony Lindgren <tony@atomide.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Johan Hovold <johan+linaro@kernel.org>,
 John Ogness <john.ogness@linutronix.de>, linux-arm-msm@vger.kernel.org,
 Bjorn Andersson <andersson@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Stephen Boyd <swboyd@chromium.org>, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Rob Herring <robh@kernel.org>,
 Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
References: <20240610222515.3023730-1-dianders@chromium.org>
 <20240610152420.v4.5.Ic6411eab8d9d37acc451705f583fb535cd6dadb2@changeid>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240610152420.v4.5.Ic6411eab8d9d37acc451705f583fb535cd6dadb2@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/11/24 00:24, Douglas Anderson wrote:
> With a small modification the qcom_geni_serial_poll_bit() function
> could be used to poll more than just a single bit. Let's generalize
> it. We'll make the qcom_geni_serial_poll_bit() into just a wrapper of
> the general function.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
