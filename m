Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793833472;
	b=XuNZnjsL/0VE23decOmiWPFffotT8XebJbFZ3FKd6LHRwYryOlp9/IA5pCXOSvGS+cwy
	 Cj4XhzlpZ9ybE5TiMlUdsFv2sVdlt/llqVHcp1hn8HmFZNZuAeEwTt+ZgYRn04oFeFY00
	 9b6VTVdekC4pG5Hv2nf2PMU/+yrS0ik9Qnzxv3XPV75XeDq/fA07YSuR5UkC3g4otxGXp
	 NQpF1HG7Wo0gEfe2HRF2Re6yOdzHQY646OD8OoRkYJdFAx0IyhpXrSAVzUAEne36gsU/7
	 up8D5YFUqaun1FRc2hX9YE68OgSRh719ql61bzsXUn4rv0FXnDAcBfTftjEbfKXQY0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793833472;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=tftf03A44iydkYI0lYrITsfjxfNR2F/pHqEC2bTsuUA=;
	b=M0umpdVbvzVnKCsXtZuziON2FYDsvFN3T+LJr94+PlC/p7FEPvyS3ZXIjBHH55TS2JEo
	 nSzaIkZy23n1wP5+3lSCGzKfMtku6VWXvOC5pPe9+e0m1rCkCcA3zcGUEOBFDbIHOP7sm
	 8vciBLqWeE6JGCNeEX7DF7CCY174j4EL5ULyQi2vgvaAnV08OghBmohT3+o2pp0Q3HNR0
	 +etf6LSWGRrDKY9Qnk8E2w8GlVRBs3Xkvi52L73l0VwqSzF5LfEE3id9FBQmpvVWLE0Qq
	 eI2djydwCv5aM/UGkZYJczZMGkMRmoEdHdu/pr2kZx0p0K1NTnTER1nnL9WoafZVmmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kRPHO7VA;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fHqH8Xl1;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF409606A330
	for <linux-serial@vger.kernel.org>; Wed,  4 Nov 2026 23:04:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF409606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kRPHO7VA;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fHqH8Xl1
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4LilKN1292213
	for <linux-serial@vger.kernel.org>; Wed, 4 Nov 2026 23:04:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tftf03A44iydkYI0lYrITsfjxfNR2F/pHqEC2bTsuUA=; b=kRPHO7VAcopwMvqM
	fN0mfVSAzHB5Ty/3A64i/jHQ1SNbytGq+QbeebZ7ODgu4u8YRSAP1bVSHf51cZT8
	ih6vHMagKjXNQDZHzsm3O+K2Dqm1Jgce8gMhr6W2sjpa1CsyXlD+vJHZCT9Vyhxp
	vKjr0tOqyFHbpl1Oab5noPAS7K6fH1b+ockO13+dIaNKnmHuUBPDYk1sYMfYitZP
	naqiajKPlqO+uU4WREwF97ls01X+ELjouKmqp1ExIpj9862HQJ3wPA95mTwyiSgJ
	PDShJlAje5MbtCntcGnwFz+aWzHUcDAfTk2ZadJISv5GwvxyvFlmY0UWvR7wwCQL
	5lBY9Q==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr163kert-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Wed, 04 Nov 2026 23:04:31 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-7cc06b9ca9eso337595137.0
        for <linux-serial@vger.kernel.org>; Wed, 04 Nov 2026 15:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793833470; x=1794438270; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tftf03A44iydkYI0lYrITsfjxfNR2F/pHqEC2bTsuUA=;
        b=fHqH8Xl1RNs/j0g2ThSKcRYvlCUiby8vpie4tSjgjFERUE3gIvnSwkc80yu8qaCirQ
         cfx8b4FPk+7yRrW/yGv1Oew6mjmcie7BovRMS83tqjS0VilqKeZXNe133i4zA0ZynNRK
         pu8iBm0JApKiJEwQFtH2tXZIpuuiICXuQjnVQs+5cpZtKPqmAwMbHLs97tD9ZsHNESkE
         piSCY4eqmwCz6gkZTBYN46trfEZ9ABa8PyJi7niuW2Yo5Wd2apS4sktFsE9aZoigN6Jx
         dV/OMKPTT7+5uxpiSgtockHBzI/Xk3Bdp9kUYz+mHyaB7IyQdMhOLwuR9ZyAm0xXhmbK
         MCrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793833470; x=1794438270;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tftf03A44iydkYI0lYrITsfjxfNR2F/pHqEC2bTsuUA=;
        b=DJ19simVcP1reLyUe4cn/qQAVBUGey5SfwNleohUFGuO6/YpOGsOF1VpqYDrZrax8d
         ErH6V33e3qBprJdRmlJwvz5k6uDBI+/KiQL+yOhQNiKac+1gILgZjIq/krj3uP/xehRB
         TGXkZcNcc31Yyo9NNxdoh9AX+9x7R6Jz5pV7/1QdDqF3UMTVqExBi/ioVTx3d9z+zTRW
         TqBXkzkeUQ67GblbRHtYtGaqbiqOCSOutgTMA1eq5x1lTBFnJSmYToXVpYKmXWrRxp0q
         FoHM+kfkJLy/Fo2GHBFq7HJNzIQmNjOGzM65Cg6/zoVOrnHEdU78jlQ6tj5Q2ZsjzMJE
         P4cg==
X-Forwarded-Encrypted: i=1; AKwUvBxahqT4N8PfEGb/aas+PiqBqui0uRg3HcSmQMtyUKSdyFxj5MmKBmwtfxSc0At8l73zuYCZNBPuHqnQ55M=@vger.kernel.org
X-Gm-Message-State: APuU4Z8uvicQVYBY0Cx/ZIviCcnpHT3d1mbp66UTwwXp+Y5qZXQE6woI
	db2LLRcOQ32LD+4UOjVoYMMQzqzVHnZT5ywwuoAEPlpc3U7DlPfKsEGIKL+usL7Co1EtoA65L7l
	9jyG7c9aTk22eDC99msSqHVKqmkYZ9rSUVwH5eGu3zScspyesXpTBCVSg8q8C7Jhgp7KmexOtCG
	A=
X-Gm-Gg: AYBFou0eg8h0cdOX2VliMFnejHaGYLqZgToZVkR0KcqyQaBDxn1yPjdJ96oUVL+mPwM
	/UqrdHIcnTSA4n50Jn4thP4aapJFVek7mgpPO/Du+wEJxXvpkhgjLq5t8PpZzQ2kEcsuORbGawS
	Tun3Z5QuTT97Qd7iLSyMRgVBjEkwQxHF7goiO5lAusSVo28LzKZi3srr86f+c2il6j0CXHNegFW
	Se0YRJBBVbmc7J/2SEEZ1C8UbbQaH61vPHeCbHDBzsSz09kFxF9CE46ZkyQbrV58yz0cOWG5KcZ
	Kx3IgnRJPDAyY8olcyNP+4s7+pDHUMBXEgEsLunWSCnhdD4IKq2QUyqCamdJvMajyxmX0NtiKDN
	iADWlj4qUAQ1A1KWTbhohXw22JtIjH8v5AJSdJIVQ5Rh8Q+zy/mWhlGQ2YUKuE7GGJ4Clo/FUmQ
	==
X-Received: by 2002:a05:6102:3706:b0:7c3:9b0c:a75 with SMTP id ada2fe7eead31-7d0725ceb28mr6081019137.12.1793833469994;
        Wed, 04 Nov 2026 15:04:29 -0800 (PST)
X-Received: by 2002:a05:6102:3706:b0:7c3:9b0c:a75 with SMTP id ada2fe7eead31-7d0725ceb28mr6080979137.12.1793833469448;
        Wed, 04 Nov 2026 15:04:29 -0800 (PST)
Received: from [192.168.1.110] ([178.197.218.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fed552afcsm6267878f8f.41.2026.11.04.15.04.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 15:04:27 -0800 (PST)
Message-ID: <3b390b39-c27b-4b62-aa49-5b1bb56c3cfb@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 00:04:25 +0100
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] tty: serial: pch_uart: replace chan->device->dev
 with dmaengine_get_provider_device()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Frank.Li@oss.nxp.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        John Ogness <john.ogness@linutronix.de>,
        "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
        Zhaoyang Yu <2426767509@qq.com>, Haoxiang Li <haoxiang_li2024@163.com>,
        "open list:TTY LAYER AND SERIAL DRIVERS" <linux-kernel@vger.kernel.org>,
        "open list:TTY LAYER AND SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        imx@lists.linux.dev
References: <20261104145211.3209669-1-Frank.Li@oss.nxp.com>
 <auuaYxoZm2T25cU5@ashevche-desk.local>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <auuaYxoZm2T25cU5@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 6bcP9j_tpkf75qWdPRv96ddt834v4WjC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA5MCBTYWx0ZWRfX29rP+yfWeXXq
 1FQ1QznjUxUxX3iU5D8W1EhfzOt5BMxtNXsUIuyRZjVDRhMXa1sFOVCPbHvTAqgJZAL1oxCwNxF
 5jn/GtXpDAfSdUz65IZdf0sFxzdz4Zc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA5MCBTYWx0ZWRfXz4TobDrlri1x
 aZ6ThIluW+h1vITkstf6fJ9Ec2nAl4Gitm4C9ld/eV41ZlF0L27jxU0O0vAWVt00ZKhH50k6pOs
 Ny7dpU+MAK+3kfXbvw9aQLoZy5BU328WDV5DpyxqWvRXuG7AOPjuGXXvcvL9/CejHmI5gQ/nLg9
 Me52wBSP8EON7wO620RBibtFh2JxHLhxC735y7fKyuRQYhw2saR9InZhs7XoWZnoyvSbxgjeh9G
 qJy2cXDDswVjjq73GbFVzDuhh+KF2e/zvC/UcH7W6m8qu2nQ9RkmCEuHv9P/FGsxxHqfjRtIRh/
 R3f4yqamhNmLuKP9uqcyfMzruWFICBlHzfMT+wE1sVj28mwwZGZMcTMwGu1dz+jOs8qXcKyU2GY
 6gF8LUy/UkQjaChxQ4lVQhX4j8jojdouqRZtkiv/C/EbAZsM/5uJ+Un6EaWsFsAVSKoEBblX/Qf
 3uLVRAPlqAXzh3wD+zQ==
X-Proofpoint-GUID: 6bcP9j_tpkf75qWdPRv96ddt834v4WjC
X-Authority-Analysis: v=2.4 cv=O5OsLx9W c=1 sm=1 tr=0 ts=6aebb9ff cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=uyPgTw0bjBTS2cVxpiNm5w==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=8AirrxEcAAAA:8 a=09QxJ2vAxbTnJTa0ltsA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=crWF4MFLhNY0qMRaF8an:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1011 impostorscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040090

On 04/11/2026 21:49, Andy Shevchenko wrote:
> On Wed, Nov 04, 2026 at 09:52:06AM -0500, Frank.Li@oss.nxp.com wrote:
>>
>> Use the dmaengine_get_provider_device() API instead of directly
>> accessing chan->device->dev to get the DMA provider device.
>>
>> No functional change. Prepare make to struct dma_device private to the DMA
>> engine.
> 
> Krzysztof, this patch was a split from the bundle by a reviewer request (not me
> FWIW), and author obeyed. So, you can do the same in cases when you got something
> you want to review independently on other content which most likely is a noise
> (to you).

Do you propose that I read all patches and complain that partial reviews
should be split? How does this proposal solve my complain that:
1. Incomplete/partial reviews will be marked as full review of the commit.
2. People get same credit even if they intentionally did not read 95% of
the patch as the people who read 100% of the patch.

Best regards,
Krzysztof
