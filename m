Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEA83793A5
	for <linux-serial@vger.kernel.org>; Tue,  1 Sep 2026 05:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788238821; cv=none; b=QrYjbovgtCVOle/ZuhP7e+07hBBTti1h3WwDmMPM2O0yQAxW6zxlvaE0H2dU4skA/XGYob9nGEeU1b240tsuSkBrMQVH7u4WA6IXI9spJKNXvcVo0x7Wy+sI/ILqiuEcGOQH65DLdMIt8FDZeZhNvd0p9v4X5wi56WT/oibaeyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788238821; c=relaxed/simple;
	bh=RGaH6Ns8soI1O6XvE/ZtT5mzvPxocISi7t1y2n7q3fU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H4LAh3Rn5zvyZ+5Hk4uzk8/DgyqpulQw8wJT7RiQzLYjRQWc8J53uGZx/OgmzeCCAp05FV7l2m8iVxGwPfv8Xyfyavp1PdfZ8FwgSqb6kd6o0+Q2IXTVs7jhE2W36GVi99IIH+fk5FMcIrRqtH5cRCtvNgtiibfeZHe55d5AmoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fxtJkaPI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gMyxyMGG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fxtJkaPI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gMyxyMGG"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68123KEV535416
	for <linux-serial@vger.kernel.org>; Tue, 1 Sep 2026 05:00:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7xzSqDWZbiKMOCqOSW/oG7o+6cCgnoR/9wLnm0Qyt/c=; b=fxtJkaPIF4IJ4iFm
	IdIHoouMNasbpw9sUgjgb9B67gzmXtYJZ/v/QExaiFyoeu5GbiP44CgQ20UJbDg9
	RLMBNKdBKCvHfQz4tOzwU/7wih3zQoo9YY4e2Aaj1dqX8vL4XZrqQBdm5JkjNl1o
	/Y8CAqELnpxUC4Ih8S3vmMuh1g3vP4FMKY16e1FlTOOjZ5zURb6W4pQdmo5X0nDB
	YAnsxggO/hvR3IAVgE2NLAUFqSYBGnd9qQZD0le46PecsGFDaxGwgoVVP14C8jZO
	x2/8+WeVuynzyz3/uy8DUl3ZfFeNc7C0tdMgm0GNVHzYilBxK6OMWWi5lQZ+m5Ip
	a36cow==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdnk8rm9s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Tue, 01 Sep 2026 05:00:18 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-396901263b6so6669993a91.2
        for <linux-serial@vger.kernel.org>; Mon, 31 Aug 2026 22:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788238818; x=1788843618; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7xzSqDWZbiKMOCqOSW/oG7o+6cCgnoR/9wLnm0Qyt/c=;
        b=gMyxyMGGstCHBqWRXvKsH8U0SQddHrWfO5v8AiXaXUoHpTChzneKkxYXRQJVeLBSvn
         6A1MvBbZioeyh7fzZUosmVe3GLzA0DHBHVhEWtYi+woUszbsqjzfXqkY2nIFCajXe0cD
         cmAAEba4G2HkeaRFBpqatQoON7CBVsPMjWm+PHGa5vcdWHIE9BJHayBW4eWQ5x699mGS
         0cHT3B6ZzpFQ9dRKNdiXhi5XUvoEdYRVLLXovhZ/Jo25m6tsiGfImiZby9AufWbYvO7w
         i4zDfMLJ5ooaBnI9xT0Rup00GJOsdpYnDHgFHdFgR8369bxHcU520vwgt7nYADRUB1d8
         AcaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788238818; x=1788843618;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7xzSqDWZbiKMOCqOSW/oG7o+6cCgnoR/9wLnm0Qyt/c=;
        b=XSORoFq51+EUXbwetBz7l1k7EFVdOzQasxfnMc1Udb1bpXW3gMgbgMj33w+ezXG65B
         LxnQXAZcQOTQd9GlqMYhsu4DVgOYjF3EVFiI6MVMoj9GNKKT/vE7EVIqciMVqwrPeCIg
         iGT1ZjYtXAwZE8ewRA0QoY0nRa/cpoLOVkIGAN3pV7p3y9W/497dq4MJsl+y3ZV/hpvO
         0LL06blE5MSRu5B50zP/RymZ0yijP40/a0YY5w9MWFQJTavb2wk+epeg6BAe4i6VFexA
         1FYU3KUhcPhDQgTpWY3qeUDaW0ItCw48jPOP3uZYMPAJYy6j2enhwCZn1MeEpj4G9opv
         mQAQ==
X-Forwarded-Encrypted: i=1; AKwUvBxCfD06sneFAByE4SMvcBFjnlvTTNSPSpEwnw/EdAR3LOiXR6MT6G5sD1XHtGP9zwBQ4cEwQi4DoAyUBnQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kOyqtzBpSnDQeimglFfrod2WSo0MkJxFMdNtTnZcMJmDsA36pr
	VIbM9eNshtmPeUB+UxpXTUmY/NS8ogNuP795611twpLI4x625O8YlW5Jqh10RbC+r+xYOZBdDde
	g80AjVKZdatMW6z2XKVBCFLXbV0zWIyTph8gSmOdajUOEiH/DLMQGrne2YVzniTqZsuA=
X-Gm-Gg: AYBFou3JGLH/64sh2X+rXOCHUWPGaPTD4HOXRzV5sse1W0BzbjU9OI77h7HYbPktxM1
	iEZnOmtFMk1QvyhFR+Xgtd9xKa2lCRS5U02aIA7J/53AJ0WkpKbx1SFRrP05oHEf1Z4qUtFazvj
	MUCBk6wHeAn2MXwFTWO5Ki1zdCBX8+3N7eOuuzjuzq0Y1lQHhkaR1p/urLC51LoQn7S/sxO7g1J
	FuSZ2+7yq+Pf8vO40QFB8ow+2W0utMKUXhTqHoyJHDbLXS1IQ9Rxyv0BE4D8Hfo3112Wghy0flK
	2J9ARuLfLt/ULPnQRZHStKMCJHEVun+JpiRj0VPreavocJ/bb4P55chcKmu8mK3Zy80E5RilOUn
	EAtKNg10dt+CCAqvaDchy6stZcL7W4hU=
X-Received: by 2002:a17:90b:52cc:b0:395:4de4:92be with SMTP id 98e67ed59e1d1-39907e0f90dmr7530363a91.13.1788238818155;
        Mon, 31 Aug 2026 22:00:18 -0700 (PDT)
X-Received: by 2002:a17:90b:52cc:b0:395:4de4:92be with SMTP id 98e67ed59e1d1-39907e0f90dmr7530078a91.13.1788238816632;
        Mon, 31 Aug 2026 22:00:16 -0700 (PDT)
Received: from [10.218.14.97] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f9e2a95sm33198925eec.23.2026.08.31.22.00.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 22:00:16 -0700 (PDT)
Message-ID: <b86a9319-9f25-41c1-894f-8c2222854446@oss.qualcomm.com>
Date: Tue, 1 Sep 2026 10:30:11 +0530
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] serial: qcom-geni: Fix port_ida handling for console
 and probe errors
To: Aniket RANDIVE <aniket.randive@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20260831-master-v2-1-0032ec7fd1ca@oss.qualcomm.com>
 <5bb31efb-3855-41e7-b011-1a5a94fee59f@oss.qualcomm.com>
 <5be318fd-5413-4d6e-a8c0-f1b1eb35393a@oss.qualcomm.com>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <5be318fd-5413-4d6e-a8c0-f1b1eb35393a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=f6p4wuyM c=1 sm=1 tr=0 ts=6a965be2 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=YIEZSTQrAp2OycWmQxQA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDA0MCBTYWx0ZWRfX6rQOAdcgbaIj
 kD9k80dkhIxxLlt9kxMHyx3UIikMjGtFak+vT1HohwBxbFMn6AztvTnDH7X8UHZnRf+is8peKOe
 HrphZYN67aYK17S5iIGNEpzey+WY3RRIXEu1z9Y3ZC/23egaGwNOPsBOF1Vy1H6Ni1IlnH8QZFj
 2SJYFhHkk+M0vsSplbtdU7b8zT47rKG3eayRe9tmDBdaW56ANcwFgwdm0K+I8KtLp9FKr7stpfl
 STKoQxHdpoNAONscjWitqC9EeIGpUwUFqrDkczXRs3OfXohwg2A+8aOUV5AIXs3HJJhLWcz4xTV
 u7n+pIrDc/Ts+0rmmtadfuPhOG4TgLrXfznDT68HHT44f9XJBYFQV95xfzPtrzlB6LaYeqi8hwX
 Dsa0iG19X9TvWMImHMnl3JVMitAGHNLwtOYmqwPj1+I6UxiRo8GTOEyAUxw48dAu8rg8IO8Lnzz
 s+KA74ctZDQtnaG7s4w==
X-Proofpoint-ORIG-GUID: 83grLXvk6wKKxvJyoJRHiS-bzDy3ZTph
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDA0MCBTYWx0ZWRfX9Wai/YyMiPZx
 y2Vs21YsZmZQzbDdfJanNKh8cLD28jMQHZI+pPFS3WkWFwndAykOg3xdxyZQn/5dhnlIN63bOON
 yNAdFanLyOxo64hJx0O4goQ7DjNfjPk=
X-Proofpoint-GUID: 83grLXvk6wKKxvJyoJRHiS-bzDy3ZTph
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_01,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609010040

Hi Aniket,

On 31-08-2026 21:29, Aniket RANDIVE wrote:
>
>
> On 8/31/2026 5:08 PM, Konrad Dybcio wrote:
>> On 8/31/26 1:12 PM, Aniket Randive wrote:
>>> The console port uses a fixed line number and is not allocated from
>>> port_ida. However, qcom_geni_serial_remove() unconditionally frees the
>>> line number for all ports, including the console port.
>>>
>>> Skip ida_free() for console ports so that only IDs allocated from
>>> port_ida are returned.
>>>
>>> Also release allocated IDs from the common probe error path. Currently,
>>> IDs are freed only on the wake-IRQ failure path, causing leaks when
>>> probe fails after a successful allocation. Move the ida_free() call to
>>> the common error path and guard it for console ports.
>>>
>>> Route resources_init() failures through the common error path so the
>>> allocated line number is released correctly.
>>>
>>> Allocate the port structure before calling ida_alloc_range() in
>>> get_port_from_line(). This prevents IDs from being left allocated when
>>> memory allocation fails.
>>>
>>> Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>
>>> ---
>>> Changes in v2:
>>> - Route port->dev_data->resources_init() failures through the common
>>> error path so allocated line numbers are not leaked.
>>
>> I asked GPT what it thinks again and this time it found that this
>> will cause a double calling of dev_pm_domain_detach_list(), which
>> will mess up the refcounting..
>>
>> I think the fix here is to drop the manual detaches since the common
>> helper uses a devres-managed version of attach.
>>
>
> Thanks for catching this.
>
> Looking closer, this appears to be a separate issue from the port_ida 
> fixes in this patch. The dev_pm_domain_detach_list() problem already 
> exists in the current error path and is not introduced by this change.
>
> Since this involves power-domain cleanup rather than port_ida 
> handling, I'd prefer to address it in a separate follow-up patch to 
> keep this fix focused and easier to review.
>
> Is it OK to keep this patch limited to the port_ida fixes and handle 
> the power-domain cleanup separately?
That should be separate patch.

For this patch.

Reviewed-by: Praveen Talari <praveen.talari@oss.qualcomm.com>

Thanks,

Praveen Talari
>
> Thanks,
> Aniket
>
>> Konrad
>
>
