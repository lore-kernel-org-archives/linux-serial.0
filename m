Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DE5250BEC
	for <linux-serial@vger.kernel.org>; Wed,  7 Jan 2026 07:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767769574; cv=none; b=JrRwo01HVbLdaIgt/WP9JV+RIAcQVN5apJMzU050RdfL2q/7LHjTEJxt51FKDCvFMS8pAm+13pYERZMuNnRsJAhDg2/gzdNygzYihAPV2XLk8d58+Si9bz8Cj9Ha/83j7lsZxamaO7V43BtdzS1eryKSUb46f4s9cC53LZKfLjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767769574; c=relaxed/simple;
	bh=X7IK1sesTtYzClY1ixLsI6OmQf5TogfnXVJTCbBbS5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ukQUx/0h5yGrjzSyz8s1eSvDhhVx3AeJaaFHPNQwktuJECqVb2ASTTrsybhp1WChkDmNcetR7HLNCtD05pBiHxxwahi142VMnJsZGmWl2fb25ZcZFxWlHFrBOnH6hWYjXuk9Qr/51XCVVYPFy199jWWYCypdF5zkH5IyulyU2kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pHgIobsj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eoctcRIe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pHgIobsj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eoctcRIe"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60733Jjl3889122
	for <linux-serial@vger.kernel.org>; Wed, 7 Jan 2026 07:06:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Id51aJqXTKYJTvWTznSlyjWuzynH+IhaCX+ZUbGbYtg=; b=pHgIobsjy1idsIVJ
	vnij8VA1NYlqW2UPuHYeCZLQ2ouIPOd+ck/Eo81gHXYj6ikicubM/2jl4/MJRxTL
	edKPmtQS14LwoSB1xIH9B+FzR4PJvmta5rkSil0u5dvWVvq811ZXrvky9oCInl7n
	kznNcIUQ6zsqERba3LzCipRHmNBMnSgNQHNGk3wVb6/2GuSDUxM5PHbOI8PRYI6S
	QbbcAnw8GTOuI7HG2WYbLOjgPRs1ZrVWsCvyf80o4Ifb2LtBV5c7KLZxQwr0FG1I
	kzao7oezMhnJYIPbi1gQry5Qs935wmDQ+R8D8RsQPgyhBFXHv2zhkgK6dnfj4AGx
	9by3DA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bh6a0j9bq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Wed, 07 Jan 2026 07:06:11 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-bddf9ce4931so2200209a12.0
        for <linux-serial@vger.kernel.org>; Tue, 06 Jan 2026 23:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767769570; x=1768374370; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Id51aJqXTKYJTvWTznSlyjWuzynH+IhaCX+ZUbGbYtg=;
        b=eoctcRIeo2wYDAqake1xW6mJQwprqX/sfXG9dBDKNFV9tE8pwNdGLXNzAkX5kJQYCl
         KYyhQWHmZ1N2AKWqzcyPEA/fDxO/xJlbGp8ix2oKsYV/ot5nacLIkQQj868T5k20nPJy
         2Lh3YI2qCzc1xm0lYB7xdMPsfOkRo0e86fkx2YIwzgYNZaK20e/KDRtIY7VvJ51WG9+v
         FIk9BO4Oje+f6BELe4CE4oMK7MYRgk0PY2HCLurShiovJIE9m3I+fXDtLzdMWYDVVT5N
         CTn/WffmMoSFczlN36OfQ+0Unwtf1ZJ+uD7wegH6CE+FHqydL72/uGTdurPdOmYigLDg
         4NOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767769570; x=1768374370;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Id51aJqXTKYJTvWTznSlyjWuzynH+IhaCX+ZUbGbYtg=;
        b=aYnYSW96PxIXqCXqYqpXzmwnn6KazpC6/38BdrZj+F3jBzKKDBWwGjUk7QTsR3yXoW
         5BtU48mLAn0Svf0gk5fXOOC1DHdbfPMQiYx8S7DTjEe0mMiXeLozFRbUh2b71+JNxo0q
         q4TRZlzH54190TH3xOXiYoIplHpvz5DxBpcb1t89XpCa58dkIYgs27QNB5zv4FIt4wzb
         tTqM9wiYCS2hdFe69/I4KrypDjYNznLd3kkWbY9EgmLWSz7BEkzwv2qqw15BlF2KFUUR
         cuGiuSxE3FiyBMqo3JK6VYN9IwbLKzP2unYIdmKaKJ/E4M3RhsOYB6JWQPX5+aMT2xFb
         JX2w==
X-Forwarded-Encrypted: i=1; AJvYcCXY0tfSK5Yjvu9ZwES+au09+tKRE3z5WB3Ezj+IjtEwQeuo+BV/CmDWEowjufPb/f9wKQYjDb2xU9StcZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpHlnnbdXmMAheiYTXfW3yi9qn9ZElQ+eBR5KqoEL9gF34lfJE
	txmXb2XUwE1Wh9WSkB+CWxypFanIuNuF/gN+z5gOSKmds/zBuhTmYPUkbN/ALfeMXdk3r9acwlS
	WK0Eb2vhGimHQEOtzfwZrD1p/DteP+NG5bXfimcTTDYEka4IU7jzG2WzI8ItNwu4YTvU=
X-Gm-Gg: AY/fxX734WRNOsG7g5oO8CJbQv55a3y9gIu7vZQ7pxNGyfMRHGvJgIj//JWv3fgHH+3
	8Ry2m9CVJGozxerq/iwZrvV2FhzhHba7Gs23tVFB3TnWsQh9WfKtb8uQcf26k9DqW7J5lQWx87d
	1wHDvqAJ3YZH+KdCHlQxF0ZcyNLV4OI0Rr9vZcZmdruwK387YfpARmvjfzmKNy222QLWynch70t
	tleEBJjtjj2ilKZPSL7QodKFdJ/9l9WJFZVRJ1JXppM2WFHp6CflBkWFwXvashloBFlBnFhcmAE
	Lg//xcdy9G3t3RgmZ6CQT9xg/Bvy44o+892zG+LlR79MdyKCMhCkm9kelmC1mYWOxF4Ep/0TDDQ
	wLXwOZA4dEKskf6YsHyNuX/Kbb28rABDT0TNcgmLfIQ==
X-Received: by 2002:a05:6a20:6a05:b0:35d:3f07:ba34 with SMTP id adf61e73a8af0-3898f8f4860mr1473830637.31.1767769570036;
        Tue, 06 Jan 2026 23:06:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkK0TXEy469X4Lki1iNUimc7BNa27ftbZY5C46XH2Q4FBkpYXMwIFOrQN37CYLCqgeGesV2w==
X-Received: by 2002:a05:6a20:6a05:b0:35d:3f07:ba34 with SMTP id adf61e73a8af0-3898f8f4860mr1473799637.31.1767769569427;
        Tue, 06 Jan 2026 23:06:09 -0800 (PST)
Received: from [10.218.32.171] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cc8d2932bsm4332346a12.21.2026.01.06.23.06.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jan 2026 23:06:09 -0800 (PST)
Message-ID: <be79091d-3b2d-41bd-9303-2c8a64dde9c4@oss.qualcomm.com>
Date: Wed, 7 Jan 2026 12:36:03 +0530
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] serial: qcom_geni: Fix BT failure regression on RB2
 platform
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        bryan.odonoghue@linaro.org, andersson@kernel.org, psodagud@quicinc.com,
        djaggi@quicinc.com, quic_msavaliy@quicinc.com,
        quic_vtanuku@quicinc.com, quic_arandive@quicinc.com,
        quic_shazhuss@quicinc.com, quic_cchiluve@quicinc.com
References: <20260107064834.1006428-1-praveen.talari@oss.qualcomm.com>
 <CAO9ioeUsLwOs2RqGPcbeuOpHg4zuwwsstjJnTCH4-oRL=ss6kQ@mail.gmail.com>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <CAO9ioeUsLwOs2RqGPcbeuOpHg4zuwwsstjJnTCH4-oRL=ss6kQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: g9pYbrzrFF2g2E-8Tg9xRdvB4kidZ1hv
X-Proofpoint-GUID: g9pYbrzrFF2g2E-8Tg9xRdvB4kidZ1hv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDA1NiBTYWx0ZWRfX62KYiESH9Gc4
 V9wX4hz5tr86LwC9GyAUdegyFthkYVyHTqWisSCBylbLfOWDt7hjyCMlvrrQvTLPMteiF8nvg0G
 gz1IOgV0I5WTvKa8MGr6/wRvxhhSn4SP9ArGBDZHw51CBsZrSAVo8+PlkV2Mtq4E7bHTIXxQ34D
 E2q5AeL4ZrsC6y/Nr43ZndPL3caJKJU6LjR0SvL/CqyvhNP7WVOYw032HjcpZSsfRwMVQTMNCpw
 YiBbkyj4UxqWl3UDTFNqm9mj5ZGVeYfrhNzjxfWt5OVWOnoz+ZOkhn0/hbdade/avzBgrpXkvTH
 DE/HC8J7z332rDDNT9epRUVGqib6AXUQ9Df/596QLWsVf0MBD21Z49sFnzseMxLPJc/xC3FaqPR
 HRN+/3DZrVsztSU8Gr0C0FnWlXumkCpBzRW8I/rLggv3eGC+5FN/A04NDQKK2jJzRPfGVaRBrN+
 8xvwMRJQOdwKaUVmpAQ==
X-Authority-Analysis: v=2.4 cv=MtdfKmae c=1 sm=1 tr=0 ts=695e05e3 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=4yKbRbB3D-Nyn2zg6usA:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_03,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601070056

Hi Dmistry,

On 1/7/2026 12:24 PM, Dmitry Baryshkov wrote:
> On Wed, 7 Jan 2026 at 08:48, Praveen Talari
> <praveen.talari@oss.qualcomm.com> wrote:
>>
>> A regression in linux-next causes Bluetooth functionality to fail during
> 
> linux-next is an ephemeral thing. Please reference the exact commit.
> 
>> bootup on the RB2 platform, preventing proper BT initialization. However,
>> BT works correctly after bootup completes.
>>
>> The issue occurs when runtime PM is enabled and uart_add_one_port() is
>> called before wakeup IRQ setup. The uart_add_one_port() call activates the
>> device through runtime PM, which configures GPIOs to their default state.
>> When wakeup IRQ registration happens afterward, it conflicts with these
>> GPIO settings, causing state corruption that breaks Bluetooth
>> functionality.
> 
> How does it "conflict with GPIO settings", what is "state corruption"?

I mean the issue occurs because the GPIO state is being altered during 
the wakeup source registration process..

Thanks,
Praveen Talari
> 
> 
>>
>> Fix this by moving runtime PM enablement and uart_add_one_port() after
>> wakeup IRQ registration, ensuring proper initialization order.
>>
>> Reported-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>> Closes:
>> https://lore.kernel.org/all/20251110101043.2108414-4-praveen.talari@oss.qualcomm.com/
>> Fixes: 10904d725f6e ("serial: qcom-geni: Enable PM runtime for serial driver")
>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
>> ---
>>   drivers/tty/serial/qcom_geni_serial.c | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
> 
> Tested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> 
> 

