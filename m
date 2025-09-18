Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E46C23BF9C
	for <linux-serial@vger.kernel.org>; Thu, 18 Sep 2025 03:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758167764; cv=none; b=JE2RAKJzEMa7CL1TYt8h3aApx5I1eZ+EqsUStH73W3pjgeVGTOQeFUBHboBfPVdDnFfXbSHPhd2PAtA+IH5XBB0L63+Uw40XcmH558dmlZIy3r/Dhlr9iTtjxcsohfcbTjcWAdQNSmemSLyJ1KU2g7Yc2HyQOLETbHV5jGpcUAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758167764; c=relaxed/simple;
	bh=CkhYshgCl2KU7HmPUDrBkaUy/oLRIyiOgdxz9omSVB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d8m6pScY3wqHZVBW5HoY0BZm2gb+mFFvfEzM4+rziIa9RsoStdzdwVxEqMGbo+NttVXxYCks3PYeCaSw7k+r+1OzgSRwtKp6B6YCc7sas2842ZsSi25NCF+t6rjcyWjRQ8lvZ4S0Aza4GdYeZWxhpSKwLPJCEr6nuYV9SZHRPqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bhAB/6RQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bhAB/6RQ"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I3V9kN010769
	for <linux-serial@vger.kernel.org>; Thu, 18 Sep 2025 03:56:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+Fxa1cerSNF4zeWZMShDjw5WL2sJeXA2U30jnp3Uor8=; b=bhAB/6RQAe8RaVSS
	v/LvLcGIUaR231QOhk/OK0b7dFDgVYCExk2LPypmHa2G4BI4QKGk/5Z72BdVywzE
	xa2c2FGFi4iCQvw0n76Ur02laHxUl9jTQR3i68PRwAiytrdI0o2sZuphmwpfnK/V
	zeB4BaIoGAmOB49+Y4BwzcHP6XAyPCdD6sSDphsV1zVrBIfQsDB+1URGi9kKRwad
	PROq0+m6Qlsd6+Bgu8rQj0A/VsV5EnZdUCc01cXoTZ1mAMkD/dwGIV48+Y6OLvQc
	Sp4LepmaOd5hVaJ2ZMRhBCu/s5QHkbmC9YRYlL31Fspr6sefcQ8EMhd/wwRVObyi
	cTqCxQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxxvtaf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Thu, 18 Sep 2025 03:56:00 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-265b1c650a0so5422915ad.1
        for <linux-serial@vger.kernel.org>; Wed, 17 Sep 2025 20:56:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758167760; x=1758772560;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Fxa1cerSNF4zeWZMShDjw5WL2sJeXA2U30jnp3Uor8=;
        b=e46C3yMVNHO/FuQb5pyROhotRg6pwL6VlwS6uXyHRIH4ixa2O1NwBCKX2/w4rzvpHX
         XZDYF1u3qECuiD//bJ32VpXJUngj06yKxUbXhIGJSsE+XSsOMeAqLZw0iCV8NuaCBcx4
         ccwzQStdlmRTYMZ7GyY67CSiXDouKx70BkpkIztejB7MWUkWftNjSDBA2QEll5LTVjhK
         nKH4za6x5IXMUHhNiUxD5kWMq0DEc2BBl79VcfyPwKPQ1OyeXafeJtPFrII4BkmghyYz
         fFFIkKXyXSsDsi1QU51SNP7V3XYrWkgYdGQw2ByJlIaVs/yo6kgcwWLXIENCygoftjLQ
         kAzA==
X-Forwarded-Encrypted: i=1; AJvYcCV1DxZrYDC2SGjvKfd3trh0hX+sp9QvLaH/zN2G68lz0BrWSjubmLl3bgJTP6fs+BbF1ZSZDF2DlEp+Myo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNlJWMPYlSlqLFq188fqDtsdS7bBbtVoVQV4JC7ESSp+OYMhMT
	F9RMcZT84ShrJRn3obiSopfx3fQ6QKAOUxqwkGdn55OW+1YZiiuT98GkVLbes0p0pM2ZVIR3Jkt
	fkxX6/2oAOx+anYzVB94VPZNwCaTxY2QtDZWfucrIW+6yUZrPD3CmsyJmLLJ1k01YHbQ=
X-Gm-Gg: ASbGncs/FmPmJ+wrJS7AZENpaIWIp0cYFo70/dUVYsASJY8XgAvlj7WuSSUTxBYIVs7
	9cakvSUgU8L2cq0U+8iJlfxI0y+AYgKKKQhC8GTw5zQE22SWPBF7v9lduaugbUhBeUD/ih2jRmk
	W7RdpQvu7VYKjo38W+2pfSBYCyb/uBz8sz25GHwYAykxDfclb//8n4TY7M5kFNGiVzJGjmPcQnE
	yBArMJheKrhtPXlzmPghFZ7EZ74OGvtI3ivGuZniaWNu4mxAZjRFsH17HyvjA4CDlO5EPEAIJEq
	qMp1hz5cjfMrGuDGdh6CGJYym9mE9XH/RHWm1mu8l6euJ2+hJgnNLtl+jCiXnJJoEIu88FNC
X-Received: by 2002:a17:903:2350:b0:25c:ae94:f49e with SMTP id d9443c01a7336-268137ee3e8mr53353385ad.37.1758167759818;
        Wed, 17 Sep 2025 20:55:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUQIsj/bvrGJKX2t8jqtl7qhNRFzVuedqKZIiWt2E4pbwp4s0RwP4y+TkO5jslvFAE+Up5Ew==
X-Received: by 2002:a17:903:2350:b0:25c:ae94:f49e with SMTP id d9443c01a7336-268137ee3e8mr53352995ad.37.1758167759201;
        Wed, 17 Sep 2025 20:55:59 -0700 (PDT)
Received: from [10.218.32.171] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980329745sm10566025ad.121.2025.09.17.20.55.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 20:55:58 -0700 (PDT)
Message-ID: <8e2781ae-34d2-4009-bf8c-56aa1bb6fe85@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 09:25:53 +0530
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] serial: qcom_geni: Fix pinctrl deadlock on runtime
 resume
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Praveen Talari <quic_ptalari@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, alexey.klimov@linaro.org,
        jorge.ramirez@oss.qualcomm.com, dmitry.baryshkov@oss.qualcomm.com,
        andersson@kernel.org
Cc: psodagud@quicinc.com, djaggi@quicinc.com, quic_msavaliy@quicinc.com,
        quic_vtanuku@quicinc.com, quic_arandive@quicinc.com,
        quic_shazhuss@quicinc.com, quic_cchiluve@quicinc.com
References: <20250917185102.3763398-1-praveen.talari@oss.qualcomm.com>
 <dab18f70-4017-4c06-92c1-91cfd2229540@kernel.org>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <dab18f70-4017-4c06-92c1-91cfd2229540@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXwUfh2C9JK5KJ
 KDyHpy0nsi4ftnj5ZE6ws4NJYH5q20uVVQYOr2TNVGv5h6JLB2KNeRZ2hekSNsm/VpTD8JNwIZI
 lbE3WzV89uCtwxlz0fg6GvrGdG5QyxDbDIe+gm4fjew+sJ1aR3MkDHs0y1i5gmvRFDGrsNPzeRc
 N5YJP8AdXn91nsOAbqrMIfiVndShpjI8z8WcrQk9lWewJwpOZe4o9wzJjx4jwvmK3JnFiO0J1pT
 VnGPpWKCHkm9QdcIr4JrkWr4X3CQl1IP9m5xGF/SUej5y6GbDcvECtfHn8PIJgfz4qIz013QaNL
 1ZfpSJnB6vnFfg0wr/3BWY3Y5bph7hrnf0JJuhUkrUMXDyRhL8JqK+E1+YdTAchXio4oXI/M7js
 KGjPN+uN
X-Proofpoint-ORIG-GUID: Bsu9VULsD-zIXFqlVOm9KbgjkqYBYMRP
X-Authority-Analysis: v=2.4 cv=KJZaDEFo c=1 sm=1 tr=0 ts=68cb82d0 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=cBlBuNp7yuU5UAWV944A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: Bsu9VULsD-zIXFqlVOm9KbgjkqYBYMRP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 adultscore=0 impostorscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202

Hi Krzysztof,

On 9/18/2025 5:28 AM, Krzysztof Kozlowski wrote:
> On 18/09/2025 03:51, Praveen Talari wrote:
>> A stall was observed in disable_irq() during
>> pinctrl_pm_select_default_state(), triggered by wakeup IRQ being active
>> while the UART port was not yet active. This led to a hang in
>> __synchronize_irq(), as shown in the following trace:
>>
>> Call trace:
>>      __switch_to+0xe0/0x120
>>      __schedule+0x39c/0x978
>>      schedule+0x5c/0xf8
>>      __synchronize_irq+0x88/0xb4
>>      disable_irq+0x3c/0x4c
>>      msm_pinmux_set_mux+0x508/0x644
>>      pinmux_enable_setting+0x190/0x2dc
>>      pinctrl_commit_state+0x13c/0x208
>>      pinctrl_pm_select_default_state+0x4c/0xa4
>>      geni_se_resources_on+0xe8/0x154
>>      qcom_geni_serial_runtime_resume+0x4c/0x88
>>      pm_generic_runtime_resume+0x2c/0x44
>>      __genpd_runtime_resume+0x30/0x80
>>      genpd_runtime_resume+0x114/0x29c
>>      __rpm_callback+0x48/0x1d8
>>      rpm_callback+0x6c/0x78
>>      rpm_resume+0x530/0x750
>>      __pm_runtime_resume+0x50/0x94
>>      handle_threaded_wake_irq+0x30/0x94
>>      irq_thread_fn+0x2c/0xa8
>>      irq_thread+0x160/0x248
>>      kthread+0x110/0x114
>>      ret_from_fork+0x10/0x20
>>
>> To fix this, wakeup IRQ setup is moved from probe to UART startup,
>> ensuring it is only configured when the port is active. Correspondingly,
>> the wakeup IRQ is cleared during shutdown. This avoids premature IRQ
>> disable during pinctrl setup and prevents the observed stall. The probe
>> and remove pathsare simplified by removing redundant wakeup IRQ handling.
>>
>> Fixes: 1afa70632c39 ("serial: qcom-geni: Enable PM runtime for serial driver")
>> Reported-by: Alexey Klimov <alexey.klimov@linaro.org>
>> Closes: https://lore.kernel.org/all/DC0D53ZTNOBU.E8LSD5E5Z8TX@linaro.org/
>> Tested-by: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
> 
> Where did you receive this tag for this patch exactly?

Since Jorge was involved in validating the change, I’ve added him under 
the Tested-by tag.

Please correct me if I’m not supposed to add this tag myself.

Thanks,
Praveen Talari

> 
> Best regards,
> Krzysztof
