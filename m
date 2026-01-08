Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135C121FF30
	for <linux-serial@vger.kernel.org>; Thu,  8 Jan 2026 03:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767843778; cv=none; b=CIPSGHwcYguZsAvAVdKvPYjK2XIyKjYYN/L8+FQBV622QBDZla7WvKVqO2EKT3e8oLarx1w921Xy1irIeVXuTwKNLw1RhG7vWcyD8/tCIVs2ZZZQaf3270P8TDRmufLqd1SUdoN3RUvqe5tYqruppycQA5lE50en+ZTQ9TFDlUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767843778; c=relaxed/simple;
	bh=NctJ8MPpll2bE+ZY5Z5JQ7iUEuw5Cp2KDSNIagPzCBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V6Wuf1YEMugpn2A0yC4Ifh6pirBVSLXx805ZYoKN8OvlohA5Ap8KgzETVvMuqtfl5cPYHN3xKz5L+Ax4LaLgk6TlwXwUx/As1z07g9+W2kanII9jks/nNFDe/tzp0AQx2ZnGUB2eDr94mHAGN99ipg2f4j+pTmOgzK38KjLN/O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pykfSlC/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=h+EDlvbV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pykfSlC/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h+EDlvbV"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 607I1DZE218380
	for <linux-serial@vger.kernel.org>; Thu, 8 Jan 2026 03:42:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sU2Sk/joZdHWNbXOxz+NFQy9EA44nouEcmpGbgOYYBs=; b=pykfSlC/H0UqZGKC
	fwjQeUPoASsEXdEnuc0fifWNiQFr58KCxJlM9LZIRXzCXsGjDc3L6kxjZ9ggyvyG
	msyuA6lAcgkA5Hk3cAjK5jvdyq9uYjjIK2DcLlIEfcd9kngOQk8A7aFAAtRUzLGq
	7LZjZfU9AIehJVg2/tiA1O6mSmgQ9srpeoNKsaU17OZAgJjDPUfB58yCQIZzL8pe
	2gq0837HevwIjmHwK39cqW8/ww0ayMPM69MhRSmFzIQCc23aD+1wAQc5XcVVoTPa
	UfL4mUt26GWjmBYHb169dvmapcRsNmxApZEaWST9VVZO7BxmwOqD44XTH6MRUx/z
	eZ3FHA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bhn80b504-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Thu, 08 Jan 2026 03:42:56 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7aa148105a2so2358055b3a.1
        for <linux-serial@vger.kernel.org>; Wed, 07 Jan 2026 19:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767843775; x=1768448575; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sU2Sk/joZdHWNbXOxz+NFQy9EA44nouEcmpGbgOYYBs=;
        b=h+EDlvbVKbUH+Jm8Dgu+6/L6PmKqwPm19/01XAaDNid90Jt7XpyhgwTECGh/3TbpPA
         EQhIepv6oY9gV69prqpEVmffhhOq3xhL81ThXKF82FptAwy8I1X31La8js+P2sr+iHHg
         08SJf9dEuM6w86SvVgINd57zaLCTKcuP+1VedaH9yes9FnNmZKvpGD30iaIWyfJ0bRup
         RsWeklZ3IOBgaN3ELMNorelTdWvrItIEZ1j1Gg5787Ly/fnC8k70bcGAi3nIXYTBamxo
         YVf3qzozzg2YRd+2WX4BMdUF94wtQvDymPDNnsqs+GQCBadjijxvEG5PRYA6/hAagUci
         iWKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767843775; x=1768448575;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sU2Sk/joZdHWNbXOxz+NFQy9EA44nouEcmpGbgOYYBs=;
        b=wnFu4u0LtyGKflcz3ijGtqK3PhDBlDZpCEtnuGNCgJrflCf1sbqJFybN3M6ZkDPgEt
         NeVIbtrRsjkR4hvOg82m7tedu87ojra7of720Hf6pAmLNlWW96c2heaPFFtxJE1cY505
         ZIRaobCG2PZMCmFETJRxBHhRxf4g9mpSoeqnXx7CkxV3e9zBDGiq8hR2tLEUBJ6pvFJb
         SGnEvKrWFCqwVl2Wk/BKgMFOMAmCfMiQuSagb/J3lDVpZVSY6FWQ9n6+w5T9kIToNcVz
         +q0fhRWIJpEm9bTmNVSKfrND+xDMvQR8+gD6akkGo97ZxtK/YQ/Z5O0uuaIKxo//Ffba
         tuLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHAeH9Fr/Mf0obZ+SmoSZcAQRV33j7ZSsg1XN3Zy410cmQPNjq5NIpTdymwDCdcsOjSVxsS5bR0pLYpfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaYp45DtXq7q5pN4lbgEGdDcURnKERykWnjgTupPY1IhvHQ5zc
	O2BY2E+YfyqWzM//Sauato/an9Yg6g6LR9+gYgESG4RVVfPKst96iVZK65jj5vQsxvc0/isWqCj
	eV6xHQXAqa+VmlrB8iccNd0FTy8gIl9Qe34etfXNcQz+EqnTdldMHLg4PhdstFAzB6mI=
X-Gm-Gg: AY/fxX4nuWLVEWVwgcpdRjDFzUVyL7OqickZ3/Qmr/VcsWVs18FjZC15ISfvpiAJwNF
	9aRa4P1Uq1Xz4oQiUoH5EKZ5T+bz8bG0NeybgszVXzoatmnFQW7U50/CfIzRKBhAtTSIUJ5mwKO
	hB3LGLV+JGBcr+Qw5bNAe45K2DfASPbsK7G0j32Dmg1SDCzqTW7RMSUQbv7zXZ2Bh26diGdh9Yn
	kkLO1muvxtzPyDWy/cVhGadVLxqcGu2ycTqCCGzUT81Ya1NIxh2hQau8rjpOJu+U4RsZJ7Sbaxq
	Wu/DM3jwqpaZfBxWVW8xhYIYchVM6qXfNPG9SE0waiKeHA5IHPzhhsca7mWBWu+t/XkUoeF92vA
	FQwmKs5gzx8tCovoZtNcNJiX3T+w4Jt5bOXRInS7q
X-Received: by 2002:aa7:9e0c:0:b0:81c:96b7:7fb6 with SMTP id d2e1a72fcca58-81c96b79317mr1202684b3a.35.1767843775543;
        Wed, 07 Jan 2026 19:42:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5UcW7dtR5CuRWrHBzONACXx8SFxOD4Rlopg1hIDigD6UL/526+Xs2slaNmtNS8CMz0wiGnA==
X-Received: by 2002:aa7:9e0c:0:b0:81c:96b7:7fb6 with SMTP id d2e1a72fcca58-81c96b79317mr1202664b3a.35.1767843774883;
        Wed, 07 Jan 2026 19:42:54 -0800 (PST)
Received: from [192.168.1.2] ([49.204.107.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c5de655bsm6175281b3a.60.2026.01.07.19.42.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 19:42:54 -0800 (PST)
Message-ID: <59be6427-1163-407e-9cfb-61fa258010e7@oss.qualcomm.com>
Date: Thu, 8 Jan 2026 09:12:49 +0530
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] serial: qcom_geni: Fix BT failure regression on RB2
 platform
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        bryan.odonoghue@linaro.org, andersson@kernel.org, psodagud@quicinc.com,
        djaggi@quicinc.com, quic_msavaliy@quicinc.com,
        quic_vtanuku@quicinc.com, quic_arandive@quicinc.com,
        quic_shazhuss@quicinc.com, quic_cchiluve@quicinc.com
References: <20260107162610.1582626-1-praveen.talari@oss.qualcomm.com>
 <kgt7t2el7rpbdxrwhdsfnte6ja4pt3aruhbw6xb5hnehvyxxym@2pvcy76dyvwd>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <kgt7t2el7rpbdxrwhdsfnte6ja4pt3aruhbw6xb5hnehvyxxym@2pvcy76dyvwd>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=OtJCCi/t c=1 sm=1 tr=0 ts=695f27c0 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=+gEgXnvjvgnLECGlQBulyQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=WXs9VOiMqbt5e-qogh8A:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: OcdVQo3ZrAjDIPFZodWDNSidJ97RXnSo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDAyMyBTYWx0ZWRfX1w+9pLI10jkK
 OTxTP1ZeD9a+gbhtdYC1RalJebTCMkcPV9HDV/KrrGX1dgrr7zazbPKm8A7aIzFCLPFM1tEbZQC
 FUhalBLj6NtSVPYJkNPoDFh6frzMhdaiqCZN042c56wlqpVcLHyiCV/9YUCfVZ+ofKKVn+QdGOh
 /FYaAxAYICE1OTJnLAImZ4pAiY7Okqj8jZINEVqZQVA6rIXVPCIkomzQVUed04qqDfV+dp8R7RI
 hcEFU0iC8+HWhxGzmYu/wB2bGP773+s6TsVk9CeOCvxUZduXdPuBDGCXq6BB9od7mip3jHTkCkV
 TgWn07yOxAz04k7Lg1d0gOpSC5jI4CMDpCuXyxERAGPSLyZa1zHmRIHhjleIrquIR1BaurCfYAc
 9B68Q9SKLRMIledhFwadHylUPuvjiXBsFWJIbcPLEAD4W0VZuDikw+0PPtCAU6nA8dxCzKy9/Fr
 8OTxROnx+400RmSeNxw==
X-Proofpoint-ORIG-GUID: OcdVQo3ZrAjDIPFZodWDNSidJ97RXnSo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_05,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601080023

Hi Dmistry,

Thank you for your inputs.

On 1/7/2026 11:11 PM, Dmitry Baryshkov wrote:
> On Wed, Jan 07, 2026 at 09:56:10PM +0530, Praveen Talari wrote:
>> Commit 10904d725f6e ("serial: qcom-geni: Enable PM runtime for serial
>> driver") caused BT init to fail during bootup on the RB2 platform,
>> preventing proper BT initialization. However, BT works correctly after
>> bootup completes.
>>
>> The issue occurs when runtime PM is enabled and uart_add_one_port() is
>> called before wakeup IRQ setup. The uart_add_one_port() call activates
>> the device through runtime PM, which configures GPIOs to the "qup_x"
>> pinmux function during runtime resume. When wakeup IRQ registration
>> happens afterward using dev_pm_set_dedicated_wake_irq(), these GPIOs
>> are reset back to the "gpio" pinmux function, which impacts the RX GPIO
>> and leads to Bluetooth failures.
>>
>> Fix this by ensuring wakeup IRQ setup is completed before calling
>> uart_add_one_port() to prevent the pinmux function conflict.
>>
>> Tested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>> Reported-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>> Closes: https://lore.kernel.org/all/20251110101043.2108414-4-praveen.talari@oss.qualcomm.com/
>> Fixes: 10904d725f6e ("serial: qcom-geni: Enable PM runtime for serial driver")
> 
> The order of tags is odd. How can it be tested before being reported?
> I'd suggest the following order:
> - Fixes
> - Reported-by
> - Closes
> - Tested-by
> - Reviewed-by

Thank you for your inputs. Will do it in next patch.

Thanks,
Praveen Talari
> 
>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
>> ---
>> v1 -> v2
>> - Updated commit text.
>> - Added Tested-by in commit text
>> ---
>>   drivers/tty/serial/qcom_geni_serial.c | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
> 
> With the tag order fixed:
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> 

