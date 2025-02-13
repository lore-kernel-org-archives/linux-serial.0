Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190B72080D2
	for <linux-serial@vger.kernel.org>; Thu, 13 Feb 2025 07:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739431227; cv=none; b=iuc9/cA4xxZXsm51FgLIvVDlQLn0FX3U2f3EDHGzfAhGEn3zJFp1Ts1gCKSCJhNQjCR187PFn6CHWm/ZKYYckq7+fh6mEUaRyndcc0PRvLnld0c9X4c964Fo89Mp2ip8NsBjUB0kLM7uczMVtLxxWzxUPSYuer6dDbGQS3m8cHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739431227; c=relaxed/simple;
	bh=kUlydEpuFrGUrydFPT1DYlM8hxRj3C3viQCBSEEaXH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=buk5YW4un2MObQFB06NLpsqoBbzQwOmalR48/REu6ZNTFIiWwSjnycSCe5ovdZ/tOHAcTdpC8B+kougk5kD2YNaOrN4PwGjRumikzNUdU+ctCeAV4vnSbgKZvooGf8CPbak90RxUu6Gie/vBW9agxY0m1t41XjaKS14qKjM4YiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Nr6PcTii; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nr6PcTii"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5debbced002so1070049a12.1
        for <linux-serial@vger.kernel.org>; Wed, 12 Feb 2025 23:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739431224; x=1740036024; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kUlydEpuFrGUrydFPT1DYlM8hxRj3C3viQCBSEEaXH0=;
        b=Nr6PcTiiRkAnY7LZWY3BD7ITa0OAQ63nPuWz8zsBbFTLOPUNrsIkYqvF8X8k1HYn5B
         s69fmWAKB0t19xG6FosNmmz0VdH9/ZQodTieQOqpwyL3OVp0MA2V22E3Q+P92iT/t+HO
         gkvf3Xkun79sCueZhRPPUsKCCIfK8ly7iTKpBGiCiaqt1dDoo3SLLoAWh78N7SSUBgN5
         LYO7BaVph6XbiwvB9u5Mu/pImu8QHLCU9jSsjM3deK4yqEWC7g2tTVfmh9FpANWHwDbh
         ZHbrnF6TnHXgpd1wOSvH+j3QSxTmxIIfm3qCclLVh9IdxDTE4ilDlRucH0ZUBka1oAPh
         roYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739431224; x=1740036024;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kUlydEpuFrGUrydFPT1DYlM8hxRj3C3viQCBSEEaXH0=;
        b=NfTODTuK8FTkZ3VRno+kvsflZ/WK/4MB1YDZLdkg4ShFqZF+PpL988gob+x3Ik7Tm7
         oJ1saB0Ofut7xQbcEfzETbz1wW3VaG3zUERomNTFHkGUzrvaP5UiYgNtj3TuDJBX8HVZ
         7aB/yRFXwgoSyJI+kJrZW2QgKdm0iomldosMxtUt0Ui8YVmB3a5X1B3DxjXm5Lgn6Pzw
         +i3Ndt4Xr0rlu6lIGyWI7LDC4fexODGr7gpsAiRNNgKox9fsv6fjLseP6+H5IrOQcyQ0
         SChmGuPsx26O05nDt4UnAQO2QXiHhtuqIqqfyYRkaUmlwGrAHaxn9RZ+Zi/E2HS87g75
         poJw==
X-Forwarded-Encrypted: i=1; AJvYcCUsTOL6pPPn0VLJ7lzambHSflUzMlU65V/8N4WBnFlCVVXgo+QPewwzG67PRxLqVTV6f6jOUwPAoRcExxc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx6U0zlu/k+tR7GK9s/Yf4AnJebd+mMTIKTfgSAIOC6P1/uzFi
	94XFHkHgZMty76uKER1029abo57mAJ4FZpcJNVRdAuGO82cGPwlx+WdBAuMMKNE=
X-Gm-Gg: ASbGncsLfYqKWdWl2b2LydWUXzLtVErNK+KToPq6wyzrb8MZcBoNZr+xsx75x1DL061
	piMGbFTPvFkqa+boTrBA0eQTy85QgCp/2ySYCHjV2lv/w7LvOq745N1kzrtebNnkgLl3JJJCtNI
	Alw+wr0Qv0+oc0qsMmChkUU1BRd0vwQZJNbD1H38gYu1S2nXRASod4BrFjEi2zuNyGwmXqg8mla
	a+0PNVpdW902vb34i+m/lbF/d5vYnbwV5xZ8OufYTNqAhW7+zsHlDdsWMHMn8uTvYGvAIRNEgpL
	ffwcmtbWkGBnciqTrbUHzvsq
X-Google-Smtp-Source: AGHT+IGhPxIg59b6w0WCU7iMGOfAb73XGY1LMG+4SX9yxgvaUCg2qqNEqVjigzMYlqAJgEcHDBCS0w==
X-Received: by 2002:a05:6402:458c:b0:5dc:abe4:9d8d with SMTP id 4fb4d7f45d1cf-5decba62fcdmr1363256a12.9.1739431224388;
        Wed, 12 Feb 2025 23:20:24 -0800 (PST)
Received: from [192.168.0.14] ([79.115.63.124])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1c4687sm674664a12.22.2025.02.12.23.20.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 23:20:23 -0800 (PST)
Message-ID: <fc341dbf-3add-4728-9ec5-7291ad3bcbe9@linaro.org>
Date: Thu, 13 Feb 2025 07:20:22 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] dt-bindings: serial: samsung: add Exynos990
 compatible
To: Denzeel Oliva <wachiturroxd150@gmail.com>, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, alim.akhtar@samsung.com, semen.protsenko@linaro.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org
References: <20250212234034.284-1-wachiturroxd150@gmail.com>
 <20250212234034.284-3-wachiturroxd150@gmail.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20250212234034.284-3-wachiturroxd150@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/12/25 11:40 PM, Denzeel Oliva wrote:
> Add samsung,exynos990-uart compatible. It falls back to
> samsung,exynos8895-uart since FIFO size is defined in DT.

doesn't the 32 bit register restriction apply to uart as it applies to
SPI? If so, you shall probably fallback to gs101.
