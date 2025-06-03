Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C911517A2EA
	for <linux-serial@vger.kernel.org>; Tue,  3 Jun 2025 14:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748961666; cv=none; b=XzPrrrSMvY+y4EGxcW1JC4K3WKipcC3Srmocr3vEx6L0FsIBy40tuA2NIxryeOGhAU6Iwou6Iu2FISCvG2iK++pGVy4OGvZmdfH1lJBkBOVk4Exe/4ocqOKxki7gEG0RdCJnhM+9YTn41ENuABELpJj3ldDr+MaEiCUVorVongw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748961666; c=relaxed/simple;
	bh=oDFEQ8/8ZMa1R4I35TT2WULoCOjgL6PNxmpPuk8RuJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sKb0sZy6aR84YukC+SS9kepdDidHu8VjA1+IYBdHHO0o0fqzJ6tAuK/9DGxpWaikE+yEAEVo97lNG6dYfV96aCnrkJbbBNnDq7VNZbxx984Hal9Do4N6neMJ8cGWrYqeg0JrYr4sBLwXYy6K1MxdglVGynriCG3/0x14U1Lg1vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ODIUIMPY; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ODIUIMPY"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a365a6804eso4291149f8f.3
        for <linux-serial@vger.kernel.org>; Tue, 03 Jun 2025 07:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748961663; x=1749566463; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vLKl+eBINJD8nDmTWsnka77ju1HlxtzNFzg0Kr2clF8=;
        b=ODIUIMPYF76ySXpWH+fZ7E2KAeuH5tKb4VzG79gwPKyPVR4Ct+fwfvcR51KTdTBoAT
         yjJNYWn7lDM+Ar/Bb1YF9DDx8p/KJlsiONVZUl5XLlSH8pIG3s2exPWvLgXRMbEFaNcs
         y5JGMWwB31vDb/D2m4fBeAgKqDro+SDt4WcJEYiwC+O0mSPOq5ItvayEAFEhfj1PA1Xh
         ELTsoLFiXt6tmu3dsZ+8JSfE89iRGcrnD3fe4+TF6/IjsGuv4hxs+BC+LqA7pp1atEXZ
         MK8RRoc72x5NNc7o+UsC7PhRt9wTFm1o7emQa/6i4E0a4XK1mpbPAonLslmcz6ujkEsk
         DrjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748961663; x=1749566463;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vLKl+eBINJD8nDmTWsnka77ju1HlxtzNFzg0Kr2clF8=;
        b=JuH6iqproYEaW1xOImZeAg4efuPNUinqv/UmEVr4BMffsyJ5PWa4E31FfoBSSkB9rp
         kLOckmbsj5vpzr8Lz2eapBPodgN+qSCOsjuqAMPDvyXVceA+pR4qR0fQcCineMWJdl/b
         oJR0AxqORqzfpwF2zs5GKOBeWsGfGv8allswEKhnLy+7PgsIa7Uq2jUqN2yd8mxBSg8W
         AOXhOMFiuRdA3KAGdt2+AFTOexPQ1c9jCeZXUvb290cCfKXneu2IMfGulWA6cnKN1tRk
         5m2bf1iM1wd2uFYRtFHSIjBRE1labsh4w5dYcOwNAgx2VCd+A4RtuToI2o+M51sipy1C
         ad9g==
X-Forwarded-Encrypted: i=1; AJvYcCUTnVXMGuKrR6Gz1tT8EAinVY5hnZ/3bLyc6f+9jBb2AjiBnpCHkXCOggNVbKeneJxXphjcF3fHWiWshYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVusuzDsLAH9WaYjn0RdOz+WxEapXs1l7IZqAH1OBbxcZSNhDa
	+yvSVBKOkRnFaM5X//KQXVqxyj44of86lZbVtsKw5sQI4SEA2oOoUMXp3W3l/8tZw7o=
X-Gm-Gg: ASbGncv/XA4Ygh5uVEO6Z4VqF3bGXCi+jFBwGiGJyElABlifc8GMe2e7mje7rwdxe+9
	NRJ2QNpQt3lG2lfOCB/pnq2YwSnKRQfdRM2DlRqx9M3QN9Etq7eUiP3QM5wD29mFl8sli25I1xi
	/FdFRMP6jbxDFx0FdnHkpUXBxN7z/14XIptn8skou2FlhbTESYnCVYkF9ss1PaojwVU7F8ZibIg
	8SoX5ZZl4O6rcW9Y/eZbV4Wi9i+FGE/GjIVZezKUyobtHt/DOKugPH5MzQNIWvIjs06pE3oc04q
	A2dJd+6gWkJL3HAnUqyIVXfr5UmlXh9STO4Jgo3YlUCEI+vR+WF1nG1N9vYg5yeUNfOX2QVlbkP
	bhrwEVL6T7U88K+Dg
X-Google-Smtp-Source: AGHT+IHwJlidHh+57XeiKH4dEGZm0pFiX1LA59KNB9wSamUPD0lMua3IgRZDkuiH/mUBKnzOBl6REg==
X-Received: by 2002:a5d:584e:0:b0:3a4:f519:9997 with SMTP id ffacd0b85a97d-3a4f7a3dd10mr14815287f8f.9.1748961663156;
        Tue, 03 Jun 2025 07:41:03 -0700 (PDT)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f009fdbasm18145340f8f.85.2025.06.03.07.41.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 07:41:02 -0700 (PDT)
Message-ID: <47d19ad8-37ad-462f-8cb3-d39c29008709@linaro.org>
Date: Tue, 3 Jun 2025 15:41:01 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/8] serial: qcom-geni: move clock-rate logic to
 separate function
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
 <VkNsXqYDdmwW9dutwc76Dv8ks2pvgcUwpf1UREJXhbXDQRaobVZL8m0hLz6rsOG-v6CjyAW3vHbuKMiPc9kN_Q==@protonmail.internalid>
 <20250506180232.1299-7-quic_ptalari@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20250506180232.1299-7-quic_ptalari@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/05/2025 19:02, Praveen Talari wrote:
> -			"Couldn't find suitable clock rate for %u\n",
> +			"Couldn't find suitable clock rate for %lu\n",
>   			baud * sampling_rate);
> -		return;
> +		return -EINVAL;
>   	}
> 
> -	dev_dbg(port->se.dev, "desired_rate = %u, clk_rate = %lu, clk_div = %u\n",
> -			baud * sampling_rate, clk_rate, clk_div);
> +	dev_dbg(port->se.dev, "desired_rate = %lu, clk_rate = %lu, clk_div = %u\n",
> +		baud * sampling_rate, clk_rate, clk_div);

Separate this stuff out.

Your code should match the commit log. If you want to convert %u to %lu 
make a patch to do that, even if it seems trivial, it is better to make 
granular submissions.

---
bod
