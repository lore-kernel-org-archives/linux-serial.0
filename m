Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41022DCF71
	for <linux-serial@vger.kernel.org>; Thu, 22 Jan 2026 17:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769101934; cv=none; b=f/8T2UlGW3DnGAA0pbcnA+x8ffIuhwy8MnhiNjHRQ25HnA7YW5yQkIaLCknuyIQe40gexllAazpZXv0kz2gnFrpr42TmAPaBGbMbo7BeNZ1MmPHe5TSxrTJ7Jlas5oa98Q8IJw/qm3Xhgc7sjzMt6+s5j61+lMnGfHC7GH8QXh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769101934; c=relaxed/simple;
	bh=uZ1SGlCxl1R4gFzNS2I0EgnNLQXTj+DNqllFC8dcKIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rBxWKin4bjcZb4XZjxusRkRPAS/dLS+hnCSHoX/au4u1D5/u5gQJOTykc3KOYpDAqfAwT4KxXYUNNyC+0tBr9OaJVGpFr5Duzp5k8e2avP2dkVLIVLjRF55ckaaSOlILHgshfv5Y8LLmDPDT64YWPzkVauonqrXvmVRtMAeARLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YytJqkTS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aXwMPHJB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YytJqkTS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aXwMPHJB"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60MG4nKw2582572
	for <linux-serial@vger.kernel.org>; Thu, 22 Jan 2026 17:12:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uZ1SGlCxl1R4gFzNS2I0EgnNLQXTj+DNqllFC8dcKIs=; b=YytJqkTSGqYzvgkE
	ni/n1UNsn7EvI5JbsZxZIJUErXqKfTFtASUWBKN+EClTDHjnr/b2+CnAp40rJJUV
	mYyj/clI80NHMyxb1zaq8e8l0IcE2UlRp/YKv78tjNixbO8U2xOyKAGj3TxeD6va
	X8KGdjJsgn46pUx5iXse5gf9qAv6gaJ71nIC8cyuTMl7kF2V+fXQbGEprhQfTZkJ
	l5jU9sYC5XCFzTbl00zrlOx5qvqWSAed9eH2JaMyUsZIwaQ73vIpiHH3DWb7UeKx
	GTojB36/77tseqapGWJq3kL1I7GR6Za6VHjCtx4K1fdCUsdpr3nPVUfdBB/R4zIS
	J3R2jw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4buq3g8auu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Thu, 22 Jan 2026 17:12:03 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c5e166fb75so286433285a.0
        for <linux-serial@vger.kernel.org>; Thu, 22 Jan 2026 09:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769101922; x=1769706722; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uZ1SGlCxl1R4gFzNS2I0EgnNLQXTj+DNqllFC8dcKIs=;
        b=aXwMPHJB6D+AqJpufroJ4IZu9Oyn/O1zjOApfNr5NVUpYsCk4oen+zZLN2FJ5k7u2u
         ejW2vsWPbec24FsBp27gVaxkW3xvJVLi6HpsKtpsSesj1KTPs+vLs3mlzKGxr1wj/lU2
         +xZvvKEQuNmATvEXvL8FiysItIrVIC9jQsxAGMv4Y0bnf4XH1MrLcXBgQgkIV4S7ZHUI
         3a4HL/tchWZKYdWPkJyXLodTUTycb6LB6F8Gi+JURS0NPwiPnbA+4smNQRbB+4BkGP0X
         OCsaOL6kToU7wbZckR5tEZ63uVQctXI2hQ5mKDz+7AG3yVVbQNXuuRnKd/K3Cg0QyIJY
         +WDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769101922; x=1769706722;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZ1SGlCxl1R4gFzNS2I0EgnNLQXTj+DNqllFC8dcKIs=;
        b=RYvV0EnIotH2DnnmEWUwtX2y2AXa17vu1bqlPnX2czSfDhhrilFcqd9ynHK+iS3l6H
         cDifiNu+nEBCU3/Q3m5FV+QWhwfd20TkpnSpeAfxvJmnefTl2EQbH8AZHWv4aHYy8zwC
         x/HmxRC4SS+Gti24aljMr5Py45YYRPZzisnLEhWz58y95zaxBOLyiNjxLwzVPjk5w4lE
         YB7pEt0bo0lGfe+FUOCRLTClRv1HhwdQVk4FQKe/hLCE+6QAyQeMa+ctSraQqUAy+0fz
         g7yVJSFSdHtVcuAMgeU3PBrSsbq4XePoDtZqk8F3VHUw3+MlYBGTA7OLzyGIFls1cWOc
         Iu2w==
X-Forwarded-Encrypted: i=1; AJvYcCX+67h/phVzF3jU+uA8uEtlqQlxYQatO8TbqfKDCyqyBg0QXLaov3XaBoK5JhwGV0g5hZ3eNH8cENYBLqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNv3f/9U2XqMrsqFoTp94p+eqOiDRZc6vfrykaChoNTkmZXLpQ
	+7SFekPiqzyrP60VTznyH37CcEtsUY5MwHMzzjmr8ALzxZA3Bbsdk50TNpweBpAQt6ZFuI3rBTg
	t+dNWijHDmDpoaF9Edyh7TsGNMXfrpQndHfK6zfdV1Jp41+L/qKuJkTDotBCaIVHnyiA=
X-Gm-Gg: AZuq6aINvcfA2Q8IUwffm0xG554a41XWA3VkS5QwYGh5H575sdr+vxUiShNXtN+SUm3
	NDbfSFgbPzbBrYoLdreIhuqSj7jLZd+2yMjZa9C8/+z4q7axJWnMBWjLbgvosBR1OWBK0g8UU0K
	NBp7fsJMuyDPsZr6PyW0e5jNQF7WQPZ0obamNc+9MjCvAwsflPAuq55ln5J+vWOJM3yPvXisnK1
	ckSDah8Uehy/qn9mH0fy4TeNM4F43YWgfxjeiYOO9m/xyohRlQoEE8/hTD59hGDtPycF0E3xdmz
	jg8IFU4aVNYWQIPLnw5CfQyrg7pZTveo5hChoC1Qegof1ip8KKsFx3Vn/VYFPtGy7PL1JKTMVd+
	/InxOwAT+wK1iby5oatXFepuxdu1erW4GC4WmDw==
X-Received: by 2002:a05:620a:29d6:b0:8b2:dabe:de32 with SMTP id af79cd13be357-8c6e2e19376mr17705585a.42.1769101922213;
        Thu, 22 Jan 2026 09:12:02 -0800 (PST)
X-Received: by 2002:a05:620a:29d6:b0:8b2:dabe:de32 with SMTP id af79cd13be357-8c6e2e19376mr17701385a.42.1769101921744;
        Thu, 22 Jan 2026 09:12:01 -0800 (PST)
Received: from [192.168.1.29] ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804704b4e6sm81577885e9.7.2026.01.22.09.12.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 09:12:01 -0800 (PST)
Message-ID: <d86ad878-a125-41c9-a0a3-bc24c926ba55@oss.qualcomm.com>
Date: Thu, 22 Jan 2026 18:11:59 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: Fix not set tty->port race condition
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260122170031.433724-2-krzysztof.kozlowski@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@oss.qualcomm.com; keydata=
 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
 cwzYbmi/Et7T2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <20260122170031.433724-2-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=I9Johdgg c=1 sm=1 tr=0 ts=69725a63 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iGW4CxhK6uMy43gILDQA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDEzMCBTYWx0ZWRfX+s9C3kdoEsDv
 nXDAAlPy7/IqeL1ZCUaVzhUEcIijU9fFNbHcKN6lSXOtHjMIZWpB2WfpEDRB8Hv0dTlUX8oV/9q
 AB2FQm8ZnJvFaiCzZXWfAxuc1mbY9SHCW3w7FJmjXcfdIPzqXYi8shF0rK/sXxmXLbB1aSJ7qhf
 kMYnmR8NQJaWnqSCICvGU96pf7uPXaa2SzvjEFTU3SUtaE3IsEsEYCK3AwPOVK+SxUpGAON7/1R
 I8TWuiiUnP1WLuO3MpXeZ4jijeUl4wIBG+Y3NuV8ewNLXrHbG2ndAzmojRAV4xprtQRLHdhDkjC
 QZ8CkXwaOsmQZatvow2DZonEuKrytaTq2AA8f9TmIb6sjxlJ7NSSeia4aCLzjZAstXGwICEZD2p
 5zTYegjnoTEXe0L5E+6DQu+77H70I5/iRQMETuWiwbP9ZvpHbXCiTFxHfK5c4Z1p5Rdf7ftJxl3
 bdx97ZqzTtJQFVEOHfA==
X-Proofpoint-GUID: atRI3U8MYXwAdu4UIBmpCxPM6Djl9vGZ
X-Proofpoint-ORIG-GUID: atRI3U8MYXwAdu4UIBmpCxPM6Djl9vGZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_03,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601220130

On 22/01/2026 18:00, Krzysztof Kozlowski wrote:
> Revert commit bfc467db60b7 ("serial: remove redundant
> tty_port_link_device()") because the tty_port_link_device() is not

And grumpy side note because I was looking at this for more than a day
blaming my new hardware:

I really wish commits (e.g. bfc467db60b7) calling something redundant
had that much of message written why something is redundant as the
commit (fb2b90014d78) which introduced that part of code.

If someone wrote one page of text why foo is needed, we should write not
less why it is not needed :)

Best regards,
Krzysztof
