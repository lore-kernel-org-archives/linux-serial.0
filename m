Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DFC17548
	for <linux-serial@vger.kernel.org>; Tue,  3 Jun 2025 14:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748961994; cv=none; b=fHzmBnao5tnAIwk1j2MeFoY7MLrg4KwT9P7dZU0aWnG+qC7Fl3WCgpejS1hoGoLIOgDdOex4UZbKcaI0pOSqNSmZ3rvJKUsXibjXxKVg8CwfQ3nO5ZZbFdrS6wSJHfnbQ65InPLvnB6xbKDr5D3yo9zCghYwovO41wjF7lqO/Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748961994; c=relaxed/simple;
	bh=SRrmvMmAfQ84Yeq4WzNWtCU8EkhCciiw6kJXyYDeUl4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=TJqI8qA+nOa4ZvrMWrpLtJFPOq5Eohchdo2S0yRiYHzx9+jnkbXjRK7Vbnwg7hmSl71dvv3UiAd51LWviHPLCAGjS4RM6w9G2VpsZpEGGS52q3oEMLmkYo6xbwrfjSOZIBFEOTRR6i6NRFvXCt6PJYXzkfryCcBVSC1sWwfgEP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cf0rRyWh; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cf0rRyWh"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-451d6ade159so23670725e9.1
        for <linux-serial@vger.kernel.org>; Tue, 03 Jun 2025 07:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748961991; x=1749566791; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :reply-to:cc:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZrRmbG4/N2m6vRayn9TmhHXB4wgb2uEtyKQ9Mx3XTkw=;
        b=cf0rRyWh7K7Pl+yc5MBiK8yhGgdhzximhrDHXfLgWxEOVKaqS7b1+e38sNqLbj5j24
         8XI86AJ5k+lj4YU9ry1h4X8/+/YWQWt/mTka2sQnSrlbfiv5cxH4NiexRbPl44s3/Wjk
         eiVSWq08ZHVTIYs/nzFS5VYcX/ob+1vW172H4yrAlW0eTyDxosar8UEY+4xuBm99LeXO
         TBMc9+4iJAvJLoNHOe7UuzVmEPJI7KfFfMCx2TeZxaXtKv/oSJdMqCfbtfSdaYRJrLJZ
         klQdSIaNSK8vSJiGHhurwqC3jFiIhcSsM3BJSzVEsFZwNwfCP1VmrvdHf5nY39bk5oxh
         r5mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748961991; x=1749566791;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :reply-to:cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrRmbG4/N2m6vRayn9TmhHXB4wgb2uEtyKQ9Mx3XTkw=;
        b=cNgZS24OzKNBnMgk1WyVa6myqspct2ixs3ySs35tYwt8mrYD0LtK5PDDAnrf1phcvZ
         7qCYnpYj/eTHx/Cml7U7hz/oCLEsLedxNg/PhOAy3hzjeoXek31Gp+SA7lM1FSd0yrC0
         V1B5z6f4oq9/yr8dFRM2xViuEIy86A/UMEpcAmaxqgOZcx8sPZdmQTdrnJnmMinzJw41
         2f9yIbJLlmC1lsF+oShnkOQBNTFWPnjdEWm6bqAqsSGmiT4gfeUl8R2c+c7SW8gNhkFb
         o4kwNJzScyKkvnHuOrClt+gl3T5dCkDopDbqhxPVnVuIqJIdVNtIV+CyY0+eJDEIi+rg
         DicA==
X-Forwarded-Encrypted: i=1; AJvYcCU9q/RX6MGfDrKrygZqVPovOoLMRAoImjuNmFe/Ar1OyQRwg+KjiCCoxPV+jXXVvlx7KfeoAqgmqL9wkkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqahFXhepkpp5u9ldlnt+put+MxnUE1XmuUJoxNGtBkjfI+Mvw
	enu4LUCv1w3erFWdJ4UJvHdWKfrzqg93qSsnkwOlqg8pTCRX2vEPZZRow2Sm34fmD+8=
X-Gm-Gg: ASbGncsgDcembRGWW+KAYKqRMCzZWeafdZIpyhdAdsNr+8rk0HjaUVkZtWQnefwI41o
	S10/SAoXho47TB47f2HZVb7s3yyP6dtv4WAZGyGAXWqgjJLG0VBuX99CHTlgc7+OUZncEWV1Ail
	+NRh+GWUDtiwMALWDoLcrs0WAguOLeoD4NU7B9ZTVnZoFfqOsiYU0OyfMNyUADvGauZXjXD8lhY
	nIPqbhUFI4SDHWLDH6TYMqMk8BALkmZiXdVlNLn/+uGZzoNnlujRfHzkvoktVipgAvCzI7Aw0rA
	Gs2QSwXEe5jgypJgjjnXmd0Qa//UMH8VqPa3VQL/rn0GLn4zViqfZERs8YFAvzXcsAv12mExeLh
	JeVcCefKGbfNhVECQ
X-Google-Smtp-Source: AGHT+IEwDI4aK9ArKoZhrl7cMJOHsOARjxSQuD4nPo7SSj+7IEGKJEEdNhEZIdVtyzFuUtgXO7lmtg==
X-Received: by 2002:a5d:588d:0:b0:3a4:eecf:99af with SMTP id ffacd0b85a97d-3a4fe398ff8mr10830056f8f.44.1748961991228;
        Tue, 03 Jun 2025 07:46:31 -0700 (PDT)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe5b8besm18722647f8f.16.2025.06.03.07.46.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 07:46:30 -0700 (PDT)
Message-ID: <6b7ca51a-241a-49fc-8aac-da5af96b5e10@linaro.org>
Date: Tue, 3 Jun 2025 15:46:29 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/8] serial: qcom-geni: move resource control logic to
 separate functions
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To: Praveen Talari <quic_ptalari@quicinc.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: psodagud@quicinc.com, djaggi@quicinc.com, quic_msavaliy@quicinc.com,
 quic_vtanuku@quicinc.com, quic_arandive@quicinc.com,
 quic_mnaresh@quicinc.com, quic_shazhuss@quicinc.com
Reply-To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
References: <20250506180232.1299-1-quic_ptalari@quicinc.com>
 <vTOsjvsB7oSpu2Oe8i1ufoz5C2Hy3EtfDnfBsLag2p-s63J0BLdqbLn44Hds17WR12JGfo7sd52k7uHaXlTTeQ==@protonmail.internalid>
 <20250506180232.1299-6-quic_ptalari@quicinc.com>
 <f912588b-fb54-4257-a4d8-db58e93b8378@linaro.org>
 <y41ikVJ5uSSaGZHmqsvTm9akz3EUUT7X6dTPrfSuIYqGmMdlEfPRWqPA630jmsEzwC-6JSgYRPobg4e933PgxA==@protonmail.internalid>
 <afe41159-00e4-45d1-857f-0a68f6fc6c8e@linaro.org>
Content-Language: en-US
In-Reply-To: <afe41159-00e4-45d1-857f-0a68f6fc6c8e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/06/2025 15:29, Bryan O'Donoghue wrote:
> On 03/06/2025 15:28, Bryan O'Donoghue wrote:
>>> 2.17.1
>>>
>>>
>> Assuming you address my points.
> 
> [sic]
> 
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> 

Oh please fix this in the next version

checkpatch.pl --strict mypatch.patch

CHECK: Alignment should match open parenthesis
#92: FILE: drivers/tty/serial/qcom_geni_serial.c:1675:
+	else if (new_state == UART_PM_STATE_OFF &&
+			old_state == UART_PM_STATE_ON)

total: 0 errors, 0 warnings, 1 checks, 71 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
       mechanically convert to the typical style using --fix or 
--fix-inplace.

0005-serial-qcom-geni-move-resource-control-logic-to-sepa.patch has 
style problems, please review.

---
bod
