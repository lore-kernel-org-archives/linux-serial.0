Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC4823ED5B
	for <linux-serial@vger.kernel.org>; Wed, 17 Jun 2026 12:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781697682; cv=none; b=OOhcs/hp598bMaTPNLTogSFtPJye7cwRdIIuhJs+pktegvdCay/JpQodn7mPqIzz9zhr59eLQZvCi3b5gOmP9Pq70U9l/3G2G0nXiCJ8yTmwPllyKejS+hJSC5sKVStu4BCPnQj7Ye0DO8PfcK+kFqqj7X61GwvU46u7l5tPYnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781697682; c=relaxed/simple;
	bh=V8Rd5Kazt6RdByTHvi7A5NlbN3QZmnMAaXNMTi48UsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U4ar58gDcTToKvF/dRqXEEXCnPyjScA4+vNeKxum/aefs1AKuBdP+xt57loJqx3pfjM81EBP461Cgmlx5E4pCSsVX3IAl9Ja35iD8r5rFBvTe5b6bcRGBrZtRZ9/HewD5XsLpKf4q57/JVfhfFGiGfUB11YT2Z1HB6uwcBJDl9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EH+SM2L7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=alHDbJZR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EH+SM2L7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="alHDbJZR"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65H8UU9s3273551
	for <linux-serial@vger.kernel.org>; Wed, 17 Jun 2026 12:01:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HWFTmDf2Lo/JzFBvBuJ3jnJkAJN1DvKDic5JBbNRhM0=; b=EH+SM2L75T+96RT+
	y0NQDXIs79wQiFOhqnzBkBH+Nx8QNbD+PmpEx8agPEq8WFm70yh9kJnUg4Tn61zK
	nYS6xKdHKbeJECIOKm8/ccuSCPujrmCsGqtDEBVf5NVmworWjuWuOgdILCvo7d1t
	GR7uh930JJz4DbSJPWluarzhqplAYjFgWcRMBRnj6t9zK2m+9KRFM6PV8qVNCvrm
	Z0BETuOq/VsVdJuDPRGelW5SujHolHZaXitUMhNK/+eauwaebHmYBDhA1OWuF/aM
	JGCcI5o0MrOvsXrZer+H6QquISpDDIoo88M/hmHDjdrTP1ddVWAF7OICGn8CJJoi
	pLgFBQ==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4euefbu010-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Wed, 17 Jun 2026 12:01:18 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7e748b9a930so7401987a34.3
        for <linux-serial@vger.kernel.org>; Wed, 17 Jun 2026 05:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781697678; x=1782302478; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HWFTmDf2Lo/JzFBvBuJ3jnJkAJN1DvKDic5JBbNRhM0=;
        b=alHDbJZRUDfGbWuBWGFkxh0gTH6QG82wg78uUTZ70RXKoV0QexuSR/QFohsE11ulB/
         9Axmc0Bw9YuOlLGOe4Zx/kXzRYpmk9buWyNe2FnLnsgG3HjOJ/lTdMhzabiicZnhDHBd
         lA+jxDdSwNmFm5c7wkQf98UJVuq8n8PM4wgGjloVcv0o0lqFROIYLrPf/efqzkzn8m11
         0xdCAuRZV1+AGj1NENtLVy04oUH0KjpDZhZywVvm3wUg8RdoZ8NmG/5HJbb3XboBKrd+
         +dMYpRv3y9fjB1Knsf/oDrbx0Tf5VluPxmsycCKNyQGi66usTblTsbBknvrcqgQeoLUT
         cgVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781697678; x=1782302478;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HWFTmDf2Lo/JzFBvBuJ3jnJkAJN1DvKDic5JBbNRhM0=;
        b=HFa+NPa0RTDkQcXc35Agc17etffw3VLb3cGleQqfWDLy2mYz3Qge0RcC9AaOxYtzXL
         lSEZnZtJ21VeYmB9o2cCIaRsLnNnaC0CmRgchEt0bJUNUYHyIxjnAG2U5g4gDNEDHm5s
         joCIHl9Uy4N0ZjdXPXk9X/TFxca6urLVsa9VVwuDIrDfni94E3Snxe1Oe8Tlm/AXhNz+
         2oXNmxnCiIvHaWlR2DVRgRTeqnJixNa136oPCdN4oUpEgTCPhKQe7+WFBfKcYMFm89yd
         IAjc7K1m0iUA25fOZwJxkCalYOTwrUtsnCgafY7WG84Pvfvrp7rWIPB5xu6SFzyy1sR8
         jTeA==
X-Forwarded-Encrypted: i=1; AFNElJ/nf3++OYSMmKxG0+aZsRsgnq8LrrlhfT4pPgb2qLfh08trpwQstAFEU7YjG0UFgAevmHXj44FEvO1vuQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxJ03MfKdavSRf2GENI+TR/SCmpXm+/sC4Keys/ykgG0bhZEbW
	1IMaDMYF0fYRfdW1zlzGBpYCuOadE6I2sUVpKml+W3Vh5CZCbHR7C5JQZVQ/6UKJFZdXSg1hnz8
	lIk5yLj8BVvF67FsjJtNHHzEE99IZysCNXAYVJ0CPXTW68OCKJSPONDrAgGVAIU+NFso=
X-Gm-Gg: Acq92OGlqO5HOVEnSyT0LJWQ/nQsTQRZqamRW+O7dShcXj13/lDwd87vgjGP73ZKL0c
	ekQLOWVUghRuA7wuA8yMK1Bm8syTBak3AkBR9rqEPKhIO3wesg1Dq8iTBzm3X7vSqCP7QMrRjdy
	t3ntRPiveJoyOIqIERZqFPeUIEecCNl8U0BcWCIVgUkSRc3XNFOjD85RMv8r8rHuCAc3P5LSfnp
	fp/AGK7RbWaOsAj9LiuwPnv8YlTEjDeN2o9vsGJbaat9mg/J4ZiRw62kNUHK7uRp9NRm84lUA3c
	zvQmTC+BPla9Vs1He1XPcqkIzMAgbqE6KAyeyX7+Rsf8WBFXEUtSC6+3y1AuF0EEF5vh9zQZuPW
	YKfrLy6vEtE43fELuPnUyCYycfbvsXMXlc3as2ki/LUo3CpO9C6765IcNAIb3vA==
X-Received: by 2002:a05:6830:d11:b0:7e7:c1d:bf5b with SMTP id 46e09a7af769-7e90c99b2a8mr2639152a34.24.1781697677778;
        Wed, 17 Jun 2026 05:01:17 -0700 (PDT)
X-Received: by 2002:a05:6830:d11:b0:7e7:c1d:bf5b with SMTP id 46e09a7af769-7e90c99b2a8mr2639081a34.24.1781697677143;
        Wed, 17 Jun 2026 05:01:17 -0700 (PDT)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26f309sm48890784f8f.14.2026.06.17.05.01.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 05:01:16 -0700 (PDT)
Message-ID: <d6fdd40f-6696-44bd-9df4-dbd65f8dc84e@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 14:01:15 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] serial: sb1250-duart: Switch to spinlock
 protection for shared resource
Content-Language: en-US
To: "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc: Elena Reshetova <elena.reshetova@intel.com>,
        David Windsor <dwindsor@gmail.com>, Kees Cook <kees@kernel.org>,
        Hans Liljestrand <ishkamiel@gmail.com>, linux-mips@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <alpine.DEB.2.21.2605241602220.1450@angie.orcam.me.uk>
 <alpine.DEB.2.21.2605241630370.1450@angie.orcam.me.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <alpine.DEB.2.21.2605241630370.1450@angie.orcam.me.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Yb235tTv_Ln_-qu3hY4JS_Nvz2JQ5Q-R
X-Authority-Analysis: v=2.4 cv=IeC3n2qa c=1 sm=1 tr=0 ts=6a328c8e cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=BcPKCTjPAAAA:8 a=EUspDBNiAAAA:8 a=EbunRdXsnukT5RqbSTkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Z1Yy7GAxqfX1iEi80vsk:22 a=MNXww67FyIVnWKX2fotq:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDExNCBTYWx0ZWRfX8SJF4eM4eOsd
 J5OFvvktJrN7gYTWZGEhU3U+cDCpdYYgk+QwFMrJQPL2hioiSwdkcDBHmH9qWP9eBDCFJQ/bK/A
 UKJDpcEcl0NOUPyB7TjLGa2CES9ZpRk=
X-Proofpoint-ORIG-GUID: Yb235tTv_Ln_-qu3hY4JS_Nvz2JQ5Q-R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDExNCBTYWx0ZWRfX50FXR1hDGZUh
 vVD19T+HaS96Mo6HgXPanNR0kDhZB0urqmCsgJtDHCRSIZIyYhPmYEnTRoJjawKli31NJS1a7hS
 wJF52hGyh732buo9rQJ8YVn7H80yQY6IfV3rdLDYK/LHjpC6DrBd9M4wOaxrjB9cg8ZMKcCLT5N
 1P6t8rz+TEUTANQma/MIWxfpZUd+YkeY18rhAL1QOOkikM2YEvKLeWZa8sujLvTxbncZObnhxYy
 Tm7V/K+B+JwXF3IbJrWqQOFOm30vp8aXV9/TXdncmFpxt0Mx3hrfVjNxfhOjYTDgIQ49xpC4gGo
 WiyLR74N3AjUTfWFvx5y5eIDyzLM9BZ3T7Gjl/QnRYpECv/6yAmNG3iMkYypmgHuEVW60JnGhYD
 3NM0cwRRCu/OpwZYb+cPOnuhwcde3qSuUGMw4+Ejg6xyM0b1CEtQUCY23O6nD3j41tbtFIiGTrO
 ahutDe7jJ9/N5Aouy5Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 adultscore=0 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170114

On 25/5/26 01:12, Maciej W. Rozycki wrote:
> The control register block is shared between DUART channels and so its
> resource has to be requested by the first channel claimed and released
> by the last one dropped.
> 
> It is currently handled with an atomic counter, which however does not
> protect against a situation where request_mem_region() has failed, but
> another CPU has seen the map guard nonzero and refrained from calling
> this function for another channel where it should have (and likely also
> fail).  This parallel execution scenario can in principle be arranged
> via the TIOCSSERIAL ioctl.
> 
> Switch to using an ordinary counter then and spinlock protection for the
> counter updates along with the corresponding resource request/release
> calls, so that the case described above is covered.
> 
> Fixes: b45d52797432 ("sb1250-duart.c: SB1250 DUART serial support")
> Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
> ---
> New change in v2.
> ---
>   drivers/tty/serial/sb1250-duart.c |   28 ++++++++++++++++++----------
>   1 file changed, 18 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
