Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D062FE571
	for <linux-serial@vger.kernel.org>; Wed,  7 Jan 2026 09:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767777863; cv=none; b=VsYwlBnjG9aVsqKSaccYcUDVvoqooIecnYsrX5ZrD2ON1vqJa3Ldhz7eZvuCubVqUl4x4ir9h1C6VpTUeKun9ng7PVx9FLxJ7L76hPJbsMo/kLhx0fjE+wRx5ZGVgw8MVZDuo/6LPxK9NmBfkP0Bggpvtb9j+5fCl1Ent+Z4IfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767777863; c=relaxed/simple;
	bh=is3JvHvh26LfzW4x4xGy/g08AaliKKVtZ3JcDZvfYgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TB1+rslY2siOMk0bFBbH321dgz6ldhWbDI3AHrCjhN+wL+ZzfmFbnyBq5/rFvQa0zjvFFuvBLK8Y+if07g6eQa7EBWJfMuMUikDykPruZN019UC/S5NvMhCOVIra1HSKLYvFn23YChbdwOU+eJ5tbzi9x/tyvI1Y5AyWxPgyl0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DhxoX0E5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D+YqgyjB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DhxoX0E5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D+YqgyjB"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6077DbYc1473735
	for <linux-serial@vger.kernel.org>; Wed, 7 Jan 2026 09:24:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tCQ7E64aGkZQWKEuQyakZA3qgIImGoTLX07wyb3IoS4=; b=DhxoX0E5S6BoCeN2
	pymR036FmoTmtv8J7KPAfx2SLdzQnMTIcGG4ejWdEEeEMbUjjIjrX0/7wz3O6d5P
	inbHBbk1plsSmsaQP/qy4XHehUIpLr2yFSIZ/mxL6ehfojLSmqZcUklbTC6/Eody
	mcC1hvMivRXeCKOyN6FjHmlqzp5QBa92ESOQjthp09wdmMc3qUobGfb1UpnHZtIi
	pxpGiH2+B3cGVLcy+vsa0sbXF0P3DhXHrYFiaNbYWYBGbAhiGxIwc8RyGzLnKhuQ
	9qxEp0gCgBmoPrKckdY78EoGe53xUxrE5GxHeIXrL5Fh/UOTAfX0FzvRik4zgFKG
	Zubstw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bhayhssub-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Wed, 07 Jan 2026 09:24:20 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34c314af2d4so1586678a91.3
        for <linux-serial@vger.kernel.org>; Wed, 07 Jan 2026 01:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767777860; x=1768382660; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tCQ7E64aGkZQWKEuQyakZA3qgIImGoTLX07wyb3IoS4=;
        b=D+YqgyjBr9Ysoq9gx01cUs/Gc2kf14/alew3STbk4Uz1y8AT4f0eXPyEsar5i9+TDm
         rrU6z5OUKjjrNNptgmJIA5HMpFXvrqYbuisYY9kLKK5GmCjzZ3N8dZKvv0WAQ0qRQWMh
         kqgmO5uFvMusU6mQz3XEMrEgHAwSpk8QXpcF39HtSbyoWrrGLi3nff/cqYKLWy+yWcWG
         EAQT8SHjkDSQ3YBALrAK4wx9MM5w5oStrLhVSBvYovn6DNEJ0t/jtcLYnpZ/UfuAOT1j
         /utQXqPxMDBeOyiCXciusJnrDQejJY+Cf8V2TZSeVtbhogADq/wtVTjOEkRnUh1bbEdb
         +/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767777860; x=1768382660;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tCQ7E64aGkZQWKEuQyakZA3qgIImGoTLX07wyb3IoS4=;
        b=vlEr8bWFBogovSUJ27TDJENCblU5cl9S6YmqG18S63bs7qiwo8OscKa3W4k8B6gaAZ
         sJkyp6rA4czgFufCsQ0fSQZ7znUyg3kWCP/u1CSLwE/EhSNUJwtK0Nqonb8lv0m5rf2K
         +a3JDiP4Dni7iEoKJSLMZw6Mv6NFzfDw1tp2tKIYt5iM2KRI6gJzZJfpD+tiFJw2MX5P
         9ASbSNlutLcqOZgMOjGypbx1twjSG2QyLSYYL3UpV8+TIN5UTsP6trDGcqGhaYDuMc4U
         H+9Fsh2funyJ1MJ1NC2ZHTkLJ4lclvrDLfrmANAApVKeXS5p51gl16G77smBsb5RTaJa
         KkxA==
X-Forwarded-Encrypted: i=1; AJvYcCU37XWaReq54tQh5QEMun0iq68YPIKdapz8+L1kAX7a2KlFqpH5m2DSk47WFYkAb1Ohu6s57OqEFtiMOJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYHg2MzAUnXTjYMbD2bgbhz6KV/ls6hGRRIsW3FYFrvD5sx/8D
	iC3rPepKP4NUO/KRO4NpsaGc7wy+4jaGuc46tAVUG4E4kD6oJD+3zh7zFQKss66SzUcIaenJAQ+
	hUWUSuHey84qgXkUz2X6ZL2+joKmM4xhFDhT7+YDrXAYlvJl+iBnA2EMNYHzhAwAG1mQ=
X-Gm-Gg: AY/fxX4Rn7Tow+7t0oQsAJ8gov9o8qJR3BbuD5I/CgRjnv3efX5eZhesHZFmpTV3ldC
	BCyUwDUBF/LkI9Foh1rN+VODoT4Lec552ySEZsBurdqnuJ8Qchsq3HYL6JYqwI7oXWPdhxn8Db5
	ECRkji7nOy4SM3b1+Sim0YhjdLCE+bMuyMHQLlz4FlDEykeQt4k8L6LrRuAyXl2IjtKrjtT0nMd
	xuqU9CbJEbhfvp46uJDAAfUa2d42mOSPi6bUm4/cKDMq2umF4nH3F2glRAUK6XgorLDO+s1OGoX
	HPdHYh5upYSknTwBcY3SSbHEy5JW8TE5X6z9zwzS/RQBygCI7cGyXcZjnip4qpgrtv51mmZiHHH
	YfjtJDuoIu/UMnUEz938VGkgmEfn9gi0N8HetcN41eA==
X-Received: by 2002:a17:90b:35c1:b0:340:9cf1:54d0 with SMTP id 98e67ed59e1d1-34f68c339a8mr1522633a91.1.1767777860058;
        Wed, 07 Jan 2026 01:24:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE6SQk53WozcRJr7IdsTTFzEHcdXz6UUnKRx8vIFFDYVnO8Tze3frQxP2XgomFS9jRlb056Cw==
X-Received: by 2002:a17:90b:35c1:b0:340:9cf1:54d0 with SMTP id 98e67ed59e1d1-34f68c339a8mr1522604a91.1.1767777859477;
        Wed, 07 Jan 2026 01:24:19 -0800 (PST)
Received: from [10.218.32.171] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f6b09f5basm506459a91.3.2026.01.07.01.24.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 01:24:19 -0800 (PST)
Message-ID: <36d8fb98-562a-43dc-8b47-b4f6d29475f1@oss.qualcomm.com>
Date: Wed, 7 Jan 2026 14:54:13 +0530
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
 <be79091d-3b2d-41bd-9303-2c8a64dde9c4@oss.qualcomm.com>
 <CAO9ioeW=7z=LchdOOfdtujCGJ5Yb3BxeLA_w=ktYQjgpyv2RaQ@mail.gmail.com>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <CAO9ioeW=7z=LchdOOfdtujCGJ5Yb3BxeLA_w=ktYQjgpyv2RaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDA3NSBTYWx0ZWRfXwrs5KqCiuYnL
 nVbd1+YFGgtU7Brwj6mxWfHpXJl+eS2wQY/SRQ7NOig5y0zBJzMG3wMMoYYpWd4Xgw70TwA7lZZ
 gL8QOuhCaOTEWMAUl2/yZk++VROOhpCgKbo4Uk37rWTB5x/iOMaQhV7v50jKtxm3ytlk1erITUO
 f3cam9bYX5BaF+7tFbaMe1ebj0bM0JROe/mkLkeAzq4WV5oBkncxh2Kt+QyK3qQUv1n+X7s1SUh
 zc7TxNGaj0mQXbK1Yc9xfLLlyMTvPTAU+fg4EXivK269JpD387N8mdCE30NCMFvO7HD9hQcVKJ+
 C6mcmgWbWVVVlbFU0X9LMotDnu6BJTOBlRtMWuPv9FtS7H/0VWAWASOm+yr5gYZLcwQ6t5uE7S5
 4N0AdDnO1Uj0oQMVowZi8h/9++/4VlyP3il27/AIggPbEdLRYJf/wIbDc2hZ2HOSbMTpeq87V5E
 7fOUxbG6AmVQxnpnTUg==
X-Authority-Analysis: v=2.4 cv=VI7QXtPX c=1 sm=1 tr=0 ts=695e2644 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=agy9Euk4f6zF618OgdMA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: jr3CpzRZggc3PH2Xdv-MO6bgGCyqIEkI
X-Proofpoint-ORIG-GUID: jr3CpzRZggc3PH2Xdv-MO6bgGCyqIEkI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_03,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601070075

Hi

On 1/7/2026 12:52 PM, Dmitry Baryshkov wrote:
> On Wed, 7 Jan 2026 at 09:06, Praveen Talari
> <praveen.talari@oss.qualcomm.com> wrote:
>>
>> Hi Dmistry,
>>
>> On 1/7/2026 12:24 PM, Dmitry Baryshkov wrote:
>>> On Wed, 7 Jan 2026 at 08:48, Praveen Talari
>>> <praveen.talari@oss.qualcomm.com> wrote:
>>>>
>>>> A regression in linux-next causes Bluetooth functionality to fail during
>>>
>>> linux-next is an ephemeral thing. Please reference the exact commit.
>>>
>>>> bootup on the RB2 platform, preventing proper BT initialization. However,
>>>> BT works correctly after bootup completes.
>>>>
>>>> The issue occurs when runtime PM is enabled and uart_add_one_port() is
>>>> called before wakeup IRQ setup. The uart_add_one_port() call activates the
>>>> device through runtime PM, which configures GPIOs to their default state.
>>>> When wakeup IRQ registration happens afterward, it conflicts with these
>>>> GPIO settings, causing state corruption that breaks Bluetooth
>>>> functionality.
>>>
>>> How does it "conflict with GPIO settings", what is "state corruption"?
>>
>> I mean the issue occurs because the GPIO state is being altered during
>> the wakeup source registration process..
> 
> Altered how?

During the runtime resume of devices, GPIOs are configured to QUP mode. 
However, when registering the wakeup IRQ using 
dev_pm_set_dedicated_wake_irq(), these GPIOs are reset back to FUNC 
mode, which impacts the RX GPIO and leads to Bluetooth failures

Thanks,
Praveen
> 
>>
>> Thanks,
>> Praveen Talari
>>>
>>>
>>>>
>>>> Fix this by moving runtime PM enablement and uart_add_one_port() after
>>>> wakeup IRQ registration, ensuring proper initialization order.
>>>>
>>>> Reported-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>>>> Closes:
>>>> https://lore.kernel.org/all/20251110101043.2108414-4-praveen.talari@oss.qualcomm.com/
>>>> Fixes: 10904d725f6e ("serial: qcom-geni: Enable PM runtime for serial driver")
>>>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
>>>> ---
>>>>    drivers/tty/serial/qcom_geni_serial.c | 12 ++++++------
>>>>    1 file changed, 6 insertions(+), 6 deletions(-)
>>>>
>>>
>>> Tested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>>>
>>>
>>
> 
> 

