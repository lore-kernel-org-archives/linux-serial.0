Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A28238C10
	for <linux-serial@vger.kernel.org>; Tue,  3 Jun 2025 14:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748960971; cv=none; b=h30v32Y2jTkKMiv3B9DqueS90Q6srAzikQM41EbJuh0sea71yyRc9yEoyO+z0dZGzsL09LWMgNXoEqosspaKKRbD3RC+SBjIdhV/gKBf5QMbKZrV+2F2OvvglyFK1oEew4CoNsEYqmr1OYl+sKGtoCRncPw+O5QmcZC0SlgS2xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748960971; c=relaxed/simple;
	bh=w3qJbbLFKIlr8IPpz61OWbLhA8Ojb0Iq6R/Q/kcUNfE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=PNRlTXmWqPExwtCMEJCMvNuHGOMkYiAiessMyAystKse1SiYRPjCEQJznE3dY/aKss96d4si3BqtanH9nvN6JYE0ayiupV0AYUUUbzhGTcA2/T4opo/pj9q22T/L9MUsWxxGcTMOJ9FzrtGVhH77r7VQuzU6t6VBrwDhCCspbzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qhS66DSC; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qhS66DSC"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-442eb5d143eso57742255e9.0
        for <linux-serial@vger.kernel.org>; Tue, 03 Jun 2025 07:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748960967; x=1749565767; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w3qJbbLFKIlr8IPpz61OWbLhA8Ojb0Iq6R/Q/kcUNfE=;
        b=qhS66DSCblxDHQ/+6QqutjtGeROiPt1Qf1X5jnY1DME/xSClLc33q6/h5Le1W62QKz
         8cRcdBI4fwk/r8I1t1pk9SXPXXUUdtPvHtJ3ehvmfiG0PGfcidXORezs9oK2zlgHSjFO
         jOquDR2LLAleUGz9JBJOQ6H8jcA7QzoEox5OZmZk1nd8+qkTGgRbYp52/mfVztfwYc+7
         meesWt5V2ymyalyk0604nRSa/8otRweAF5kfGhzPAYu+ZZ/RnXT45MgGaowK1xgeVROT
         VsS/CQqDOiVte2PEUfLCyr4SpZYA214l9jNyQfb+6LArGXhLL5OSh9c/Wb72AI0vVvgh
         6dQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748960967; x=1749565767;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w3qJbbLFKIlr8IPpz61OWbLhA8Ojb0Iq6R/Q/kcUNfE=;
        b=J4QG2tU0sd4COFgK5v8n63oQyamARz3mBXpbwSOj1460Ar79jtYogf7QBzkJbQMXjj
         1mIhQyAH6YRVj2MM4Px8nVNL6ZP+PMzazPF2qZcSWgs4U/F16cniY0ojSEBF2njgP4iV
         UaADpvsFYPv3FOepJBBIVntJZXvkwr7si7TZAWV+ZNrATrVJnTue1XcB8P2Y/M6e6/qJ
         dIGnX0ArQo8v2b+ZcyFmJbf9cMUgo4m0la/T5eGW5NKfxw9vmGXq48GuqQARhrirFSDP
         Q+DfduhJyKgQE0Tgqyw0nIfnaVFb1zCrx+wCKTrdoa/TkFE6RXXiuk6g6SFMNwF5e07v
         4LXA==
X-Forwarded-Encrypted: i=1; AJvYcCUdkrFozXcg5UCwfkvxwVFwHqsa9fX7jWBP+pJyb6q8ixv7VQ8w1hpxsbJwmyQXLjrZV4PWCDlwX90LxQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMYXkhbBFOGOFxwAOSrTWd35mkjUJlCP8TC8tDbBWENn0Kb47M
	jNMZEyt9UBbcEK1sjrBtLr8eGMY9sg4fEIlZhJyUqgO8rX2ekMd7I1CwmATiQEuJg1s=
X-Gm-Gg: ASbGnct5hvMPA3sABpJKKgFFXfMmqQBEqlZTQGmsXLyoV9F6ZlZSGF2RZLXWSrouZBl
	h70279DRB8gWQ3M8D/0JK+D4u2b60ytH8hvc2s4FEWNeaO/MlYXezFdqHzpLBvrgK/C4ZN59KIU
	yziQ99mXAsggpC/CaLCiAoWIv5QJV46/xGTXkQDY97OFLQDQOIoKR4BEp/2wlTmzqoNwQdx1E4S
	aYB1dXXwf/zBvc82ZsVj41aEwUSVjCPWooc5vRrNdyxmk/cfSzmuMcsIoGoOSLDTRJC8+P8L3OC
	QRzHakPA9JZBCS/C0eY6budhzgvrSQK2te5bvlZCqJFs1JDa9XlCqjXD4slBFUZn5oVPn3zQ5LL
	xxp2CmJcBk3tvwoWh
X-Google-Smtp-Source: AGHT+IGBJA6javCrcGvDz9kgjIx0gKy0MSn3MwVpuFlPN9NEjpfetf/hiQAdNxpchZl7GR3GtryIaA==
X-Received: by 2002:a05:600c:3b9f:b0:43c:fe85:e4ba with SMTP id 5b1f17b1804b1-4511edc208amr131076915e9.15.1748960967166;
        Tue, 03 Jun 2025 07:29:27 -0700 (PDT)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7fb8990sm168262475e9.32.2025.06.03.07.29.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 07:29:26 -0700 (PDT)
Message-ID: <afe41159-00e4-45d1-857f-0a68f6fc6c8e@linaro.org>
Date: Tue, 3 Jun 2025 15:29:25 +0100
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
References: <20250506180232.1299-1-quic_ptalari@quicinc.com>
 <vTOsjvsB7oSpu2Oe8i1ufoz5C2Hy3EtfDnfBsLag2p-s63J0BLdqbLn44Hds17WR12JGfo7sd52k7uHaXlTTeQ==@protonmail.internalid>
 <20250506180232.1299-6-quic_ptalari@quicinc.com>
 <f912588b-fb54-4257-a4d8-db58e93b8378@linaro.org>
Content-Language: en-US
In-Reply-To: <f912588b-fb54-4257-a4d8-db58e93b8378@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/06/2025 15:28, Bryan O'Donoghue wrote:
>> 2.17.1
>>
>>
> Assuming you address my points.

[sic]

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
