Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DACA3B7742
	for <linux-serial@vger.kernel.org>; Mon, 31 Aug 2026 10:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788173520; cv=none; b=JEsHwao7wcjbrBGjx+Z+raHSb7CkqN8yAqM6PEklhJ/bhLPlDthVKPs/jZqBWM/nuEGJ5wzfPx0dSDENIsGP2RkbqV3/IBGaWISUHpp5ctNGYgE3Rm9qvj4K52PDS0iGdJKSErhJI3WCD6G0awCTjrYDtAEEsXDB/FJh6bNdQco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788173520; c=relaxed/simple;
	bh=qk39u6giMz5HCixucodfTQ/SWhISR98GQnSlcZHqQw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OMKGMUIldG9bsOocUDdpGTZeeB8p4NykhR4xlXGZQ47UwLvidyamBTmTmpR6gjPCMIFh+WMfuI5NDg4l8thAdZn3TS5t0bYleaGpwep0RdHXn3HmVpyuLKH3QHpEOKQSpeGfmlk8VNLXbxPKXaC6HU2QMonMgHP41cdA4IPLtoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VERNy5uo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XIC8ZlJs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VERNy5uo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XIC8ZlJs"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V7xdoP2924457
	for <linux-serial@vger.kernel.org>; Mon, 31 Aug 2026 10:51:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kAN6CqVnAIqBWFw6JFSsaxau/8huoJf3sBdP1IluoIk=; b=VERNy5uoMOKvCQTb
	lBGSB4LgmPef3BnexlKohkidoWuvD18FZxmP2GY/shC8heASZSIe4GfsWTjUcwSC
	0SZ7wA1idBUM1InXb+SUDpD88ZReJXbw0PjOkbE4yiSPHkOX3DRoB6cccHBzk525
	HsJtkXgGj7xgJMrN9nyhyBQ0WIcRjp5JYTbFAIK9AyrSQsyj1QRga19dtF+y3ObA
	aI6EUT6cjrTcHNdque3yMGx0jiEwLkoI3ypr3eIj5kdRCPHxSG+r5pA1tdtz2i9C
	BxuJHxFeUaoHdsGIgiKyQ03Q/JEH9FQ0JPvYgxrFxJ46UyhbOBKVr+t7rOTBe52x
	360hcA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gcv7wa9sk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Mon, 31 Aug 2026 10:51:57 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-398dc3d8f0aso1669685a91.0
        for <linux-serial@vger.kernel.org>; Mon, 31 Aug 2026 03:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788173516; x=1788778316; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kAN6CqVnAIqBWFw6JFSsaxau/8huoJf3sBdP1IluoIk=;
        b=XIC8ZlJsO2jZHaH0HfSdWJ+dpYe3bFshn0S2P+mD0mzAfRj4A4H+T3AbVawvfyn/x8
         plmFmj8Mesvo1goNlasXgFKn4bywCegMjdMKcb46LLLgAibiezM9xKwTnMYrVjxAEvAu
         mAs6Vgusmi0y0F9Tbq/BXjaQ/kqz6qfeO/7J8ZDx2lgdPHrXIjoY0ribcfOJqB60uMs6
         JgoTLU/7EuguXMEv+ZzK6qvbexEf2rZkZ4Bt5WlUBZNFQQi5YVO6s0aE3jBBawflUfH2
         XeyRj64oMkOFs5gDmzvSOF6OtzD4cIXL5MWLAOE9iLZ9Ky9mTQ0eL2rrJ+0MiH8JGFt5
         ZfXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788173516; x=1788778316;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kAN6CqVnAIqBWFw6JFSsaxau/8huoJf3sBdP1IluoIk=;
        b=DCIrd8tbUdUAqBvHewKGPH5bVQTHBGqBew8PXt+G3toh45sT/krMEJI/ieuETX1b7b
         q65pP+HkEm4GESIKMsdYQhu9USWjwzWq7GxO/QT6jAUaA0rJTYliWdRE2KJuhiENRcaH
         dYkfxz3OW11IzEZc41IVLXAUnNiIwP811m4oRVhB3F0EdqT6V7f8hCN7qhDt+W/AyS/1
         Enk8ZpveMLx4cioo3V51fmTolFN4BY2cA84x+a0FQysC4cenQEmWpy0wx+XdnKrkiucQ
         PxmSsX1wd9xZGW1NB+LmZHLlel6Uw5C04X5u9Fweth42GzRQVoxoVckBWpWcmympbaHN
         CyRA==
X-Forwarded-Encrypted: i=1; AKwUvBz/0FqTrxR5sZ5v+bvmYCezZjar4j7hdqFtZaXgK/L2syoj/M4I0QYZiHevtEO3qTOqXVPylv/7m9ljSkk=@vger.kernel.org
X-Gm-Message-State: AFuF++mcdLayRg5IbpmprcQ6cprp9ZyFNuYTilIop6CbRKVdE4HvcQlX
	ZKH4XQhrLPULihwSUOQlsle2DJ95eRlThR3Tkpohun+MF/EnHUg4FxP4v82zINKoKqSL9/JjmlE
	YV56qhVdMgTNIK19kCfbRCEWzARJyJ+ZioNSDGjAl18SseSU3C73m5ODP5n6MF5gqXVE=
X-Gm-Gg: AYBFou2AHbTuwziovHQN5iLEQlt+eP6zX1OiNOXyJl+ogEg7hLgtOIlDqYbmYwG6Ytn
	RAOsTr3FcaHXEysclq1xUIifQppq+9ogb/wakcpiX8mCtY0dYRisAd7UVe/HEfmGsmUmmmWl42A
	UrKfN6yqUOXHai8n0UY34/REPBEq47slmTbPG0hu7mC/koD2ThsG8Qxgz8jtyacaf9lkZtHIx8u
	Y12q5XOXB/Fgd5i0JE7y+jnx5F3uz+U2f2me3zP/kREbIPT7LCijubeTyZEslyPMf/oJ+8igzfX
	Z+bwA9h1CQY0+fdTbaaQ9DUyfXKPPbWqHz5E8E/jzQe5wrfV6g698C8zjfhd+hZepFygF5/gxZL
	jaKioChPTTcJ2D3IQHsCU+kRllSrBqxFLkg==
X-Received: by 2002:a17:90b:3889:b0:398:c8f3:d076 with SMTP id 98e67ed59e1d1-398da8d5422mr6442417a91.31.1788173516034;
        Mon, 31 Aug 2026 03:51:56 -0700 (PDT)
X-Received: by 2002:a17:90b:3889:b0:398:c8f3:d076 with SMTP id 98e67ed59e1d1-398da8d5422mr6442374a91.31.1788173515514;
        Mon, 31 Aug 2026 03:51:55 -0700 (PDT)
Received: from [10.217.218.252] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32b49c867f5sm15177273eec.2.2026.08.31.03.51.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 03:51:53 -0700 (PDT)
Message-ID: <2aaa53bf-54d5-48a7-b4d7-8aced3d93726@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 16:21:48 +0530
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] serial: qcom-geni: Fix port_ida handling for console
 and probe errors
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20260828-master-v1-1-1f8afa5f82c2@oss.qualcomm.com>
 <e16478f8-6b56-4e7f-b4fc-7c434045ec96@oss.qualcomm.com>
Content-Language: en-US
From: Aniket RANDIVE <aniket.randive@oss.qualcomm.com>
In-Reply-To: <e16478f8-6b56-4e7f-b4fc-7c434045ec96@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=E9f9Y6dl c=1 sm=1 tr=0 ts=6a955ccd cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=jtoOUyuUrL730116TwsA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA5MyBTYWx0ZWRfXyRyttXmnN4Y3
 MMx7R/qsVnefFprCacv/kdSZYxinpIOJmtUzZvNjzWLVDZ9ZpBF0ESU3zOObnS3GbxVH9RcbVIL
 gxiNYM8rO+pFtYvNcV1JC1Zv5It/UaA=
X-Proofpoint-ORIG-GUID: lvmNoBDVZHH_MyU30NUlwvoWdaFSRGrm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA5MyBTYWx0ZWRfX3cuymRuXyaln
 N0GV3W44wTJNDMMfWCwgoSeq2bHbZfrfL6+8ttv794FFcPag5G+4Hfe1LUhEBold/QKTGCnt8Bk
 h7BJsq0DmpdAKJHhM/0TxQ+rr2w3JtsQYsmyGCxrXR5R+TFXTYVg0w6EGgD38JDcEfoCdIhe+Js
 J4AYqXvLnyqCI2FCAhQSXhg5tvkI+NLFc6cvuswbxg633mbonZFVvBBbpNRlXCOUWauU8Ta6AJx
 ZVkAa1lAE9UZ8n5/DV3K1IqQOOtP3hEWYyKjvghJ7kq6BV7M24V6VB5AF/xo0d0jcx69l0QCsaY
 1iwrZBhqzEIddyYxruiUDLp5sTJJ6sOGZl2fBXVwp9e6qncQpOBtNY1RQu6PPVXtJ5A8VjDhSwc
 OZni6/505jN5oiApRecufkMzsj/5sQTEI+bC89p+LlBkxJSbbXcX4IxI4vgE6ylhbX0sc4eWhN6
 gMjj17b3rZwrLpYtSPA==
X-Proofpoint-GUID: lvmNoBDVZHH_MyU30NUlwvoWdaFSRGrm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310093

Thanks Konrad for the review.

On 8/31/2026 12:58 PM, Konrad Dybcio wrote:
> On 8/28/26 1:14 PM, Aniket Randive wrote:
>> The console port uses a fixed line number and is not allocated from
>> port_ida. However, qcom_geni_serial_remove() unconditionally frees the
>> line number for all ports, including the console port.
>>
>> Skip ida_free() for console ports so that only IDs allocated from
>> port_ida are returned.
>>
>> Also release allocated IDs from the common probe error path. Currently,
>> IDs are freed only on the wake-IRQ failure path, causing leaks when
>> probe fails after a successful allocation. Move the ida_free() call to
>> the common error path and guard it for console ports.
>>
>> Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>
>> ---
>>   drivers/tty/serial/qcom_geni_serial.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
>> index 3633723acef8..3bfe597d2c83 100644
>> --- a/drivers/tty/serial/qcom_geni_serial.c
>> +++ b/drivers/tty/serial/qcom_geni_serial.c
>> @@ -1979,7 +1979,6 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
>>   						port->wakeup_irq);
>>   		if (ret) {
>>   			device_init_wakeup(&pdev->dev, false);
>> -			ida_free(&port_ida, uport->line);
>>   			goto error;
>>   		}
>>   	}
> 
> GPT suggested that the failure of
> 
> ret = port->dev_data->resources_init(&port->se);
> 
> should also be updated to have a 'goto error' rather than a direct
> return

Good catch. I will fix in next V2 patch. I will route through "error" 
now so it goes through the same ida_free() as every other failure path 
instead of skipping it.

> 
> 
> also that in get_port_from_line(), reordering the devm_kzalloc before
> ida_alloc_range() would prevent another leak

Agree. I will reorder it.

> 
> Konrad


