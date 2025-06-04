Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6782B215179
	for <linux-serial@vger.kernel.org>; Wed,  4 Jun 2025 08:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749025442; cv=none; b=s/7oYxVORFa6FaRnDL0TfoeSJ9c814YCK0mqb24Y3UPYP+j9ICCLAhgyz3LVxOTUpwC3St6f/JVT3fzXA8KT9mBiFIlkIpkkXavIpH5nJyf45jen0S/VwujJ8O/oTM21Do6SvV90o+n+BWsbApf8sXP+zT9M17/NxRMuXk8PPi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749025442; c=relaxed/simple;
	bh=zNHoKAB5U9Qmrd5tzPO7HQ0l+s0XRB3gxF4oDsXEwt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lTaoRFEbKG0eTzqklUnGpOEz95WtYNp5cHGd/kFStgXIlwDxJhIpYSSjDxBtcqyjE6zr49+9AUBDagvd9dVv3L2kmMh6l2GQooYDH0yORbxJnRE1uP7/Fyl+BM6XLc4f4czvGPWx4bamp9FCnDmDd3q6g0O4pUvQiW4bJPeaVcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z2uPQTyG; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z2uPQTyG"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a367ec7840so4552222f8f.2
        for <linux-serial@vger.kernel.org>; Wed, 04 Jun 2025 01:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749025439; x=1749630239; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h7s6pfygUdaVGCn3GcQyk6cUhVydm03tR2O0SvKmYUM=;
        b=z2uPQTyG16uLb50UVAGXXsn/g1j2QQFVHuMXxl5viKNPbXRNArf6rY9f741Z9n/Ghu
         aEix6jWPfZwEJYgkC1wcdYxym2jUerr4Lq4bOxJuVtPElHVoK906lJXBVNNZLinExaOP
         LuE5DoViPzc+PTNAIlIlgr/oM3SMftD/z8uzV0rfeqYt8yET8R3Zt+/TNJ0jCuf8KQUE
         raRDGtQfIWGxFZBMqgBszOfRygVDi1r51NvkjAhwHRZFybwIXRAXFK8ERetVAnO6o+Rm
         1uLFdwX1R5/v7jIN+WHfqVegWaCpM54aXRRLWyg7k138EHUQDu5xUZ74nBUdW4dzpV9y
         9VQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749025439; x=1749630239;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h7s6pfygUdaVGCn3GcQyk6cUhVydm03tR2O0SvKmYUM=;
        b=HbeXdv13frgGGeeNyOynbDw74tO0piu1Uig94BXtqBEYm2v3ucwjpSW2RISSLZLWrB
         NSM3hE3IZPPzUZqhee+euGCmfzfEp/DCNaOj00MXODR/gul/4zxGaFxYBVNlIfijYW34
         jMxObF/1lvsl3eaWB1Vg2+heNKjCfZGCRQ11F5cVWbsW+JgH9RqQhlzGHFRLyoXFpNhL
         nmjxn7lqjnceThCIBFXSuscNcb6GGiIYSZidZckKs/FW0uPo9huX3zMZX3tLjxVHXwox
         guXQajUIXftWaVkj7yOzQ8rMiKtM2YJWUm1o2uIlBxdry1fVpS0aYZS9f+/CQKw+x0lv
         g0WA==
X-Forwarded-Encrypted: i=1; AJvYcCWnv2TYyw+9s5AUROIK6F3vD4bzXQ7lNG2qsdQ92woAjGcfo2jUxYQgs37kH4xL8J2XAz9eXx3ps9lAOHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLgzIUJrceJ0hCPqp1/nnODg68Kpy3BR8S5p7EbDl3KtLt5uYl
	yWB3bAmei0oa7yOTcxy+gDY13yFXqpZzH1yj6gIhA143M2J18Rbb0hqIlugfJi1CWk3ph5I4Dy4
	3ZTNv2i0=
X-Gm-Gg: ASbGncvFCp6lnrHwYXIbbi8FDZuDnKYr1lrR2CSyA+lC+fCdTemOn9af2a03AWppxNC
	33yN9NDP9/FGKjfOWV2lsRWKB9EqLSkpFLNqcS1EuYGz45+/nrIG6q/UymfM+/alnEQLeKqerhP
	uIviW2mS01195n/xa+0Z6ccC2omZGA+bHhVD47FsHaRPk3biOUQFp/nynh3qJIbm1SajtFHIw5H
	v8AamiN9KBTT9sYP5B5bxDVqX+F+uo1d4vME+UyH51j6MFUNGgY6rugW3qsOpsybj4/XDn7qkaW
	6UECju6L4YamOzO3AgmVlHwSgMsxqQlSkeAxza+j5vnjcxCTi0zoJpaWLsl/mbysfdx3GMdFWkr
	HDJJ8LM6HM14Oo0jWdKh9dxNioDM=
X-Google-Smtp-Source: AGHT+IGuDdROqzATGDzK/jjhYn6/52Bbjegw9C/PQ/dD8jHjdp0OUR+ym1KT/jZkS4osD3Mqe91lug==
X-Received: by 2002:a05:6000:40ca:b0:3a4:eec5:443d with SMTP id ffacd0b85a97d-3a51d961c87mr1297240f8f.29.1749025438742;
        Wed, 04 Jun 2025 01:23:58 -0700 (PDT)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe2b35dsm20745556f8f.0.2025.06.04.01.23.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jun 2025 01:23:58 -0700 (PDT)
Message-ID: <c751b9f0-836f-4151-9ad5-82cf4c282a2b@linaro.org>
Date: Wed, 4 Jun 2025 09:23:56 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/8] soc: qcom: geni-se: Enable QUPs on SA8255p
 Qualcomm platforms
To: Praveen Talari <quic_ptalari@quicinc.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
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
 <VgXAbpS__r4C24FLFz5nqCPgygil3nr3-oNHbL7bQxE0X1GnDStFaWlnts8iSxCeG6TCqa8mzIFqOysqIlWeJg==@protonmail.internalid>
 <20250506180232.1299-4-quic_ptalari@quicinc.com>
 <e6517c54-9163-48d1-80c2-4fd964dac349@linaro.org>
 <pQ70_lZWsA1PB1GdnrxpeWdiDKvQsWaSYURfGNHMENN7uqR7u-OFSZA04GvqAVOu2QiaAaRniqL0kpOznBajGA==@protonmail.internalid>
 <85ba8e7b-a1a5-4f70-9660-bb78e7169acc@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <85ba8e7b-a1a5-4f70-9660-bb78e7169acc@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/06/2025 08:28, Praveen Talari wrote:
> should i keep condition before assign num_clks to wrapper->num_clks as
> below right?
> 
> if(desc->num_clks > MAX_CLKS){
> {
>    	return dev_err_probe(dev, " to many clocks defined in descriptor:%u
> (max allowed: %u)\n", desc->num_clks, MAX_CLKS);
> }

Its up to you if you think this check is justified and/or necessary but, 
if you decide you want it then it should be an error if the specified 
size exceeds your defined MAX.

---
bod
