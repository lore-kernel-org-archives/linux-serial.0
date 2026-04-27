Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304513B19BA
	for <linux-serial@vger.kernel.org>; Mon, 27 Apr 2026 09:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777281533; cv=none; b=JRW4+jNNEmr6marDj9zdUg8hWm/mDOsta1kPe05uy60MP20VY1aqO0+3kZMjxhvrd7Xz8tKUkeAiIYhxz7j3mMwpsBXDb+Bkf2hOHwhg7G/qRgxFmRQgUJm9UCAQHoU05CFzjbPoU7s+OnQoKW5vbQguWRJsirr2mzSynRPS/4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777281533; c=relaxed/simple;
	bh=iaihpzmQLJaEJXDgYPIIeQD9PzsxKMVKLHW33rYRxrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HEIFg13nWr0YiVhHxSqNHL8uhIH53YqyyeuopntoNeWSUZ0LNfUh9v+G3Z26TqicGVwP6+IFPTROZFwDuriBzsjne0bkCQzHF2aLtRSajWkoA+PE27abUZPKCQv22oEGK5z9/CU+/rphRqJwzHwfadP9hK0V5wpMSxo8MngIsRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OXivKJ4X; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PDj4a3Lq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OXivKJ4X";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PDj4a3Lq"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63R8TLab4054899
	for <linux-serial@vger.kernel.org>; Mon, 27 Apr 2026 09:18:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Z+NhQmVODRKthYAjn4FjHgsGJoSWaHBLQ4E9hxLiPbk=; b=OXivKJ4XkkXaxrPd
	NCq9XPIVlvABrqfc8xHO+CvO98Pr+FwOfAPHhGhfTQpdjbo2EctfkKDwr1UmSjZ1
	GBnQ8LHQEbBxIJ5Pe7vD0VKQDZh/u4umFuMNsXFxC16G1oKvJjqShWGQDhisG8e1
	zVCtpCdbDleuT1WcUc5Vd/s8bOC5ctfnr1kiSFE6wuj0cg+aWWqV4XtDPOm470kD
	OyDsU0q4fsLCI601eluPgGDyhl3IxlD+n7a3UjVkrTlZBF0hcIf8akNkR9oWBYHc
	VlDva07vjAsrBEJmXMlFc214tNPjlHB5VC3kB1zm7tmW+rAeP78MkJum6iDwiRHH
	NdvP7Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4drnkxden1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Mon, 27 Apr 2026 09:18:49 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-358f058973fso11979879a91.1
        for <linux-serial@vger.kernel.org>; Mon, 27 Apr 2026 02:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777281529; x=1777886329; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z+NhQmVODRKthYAjn4FjHgsGJoSWaHBLQ4E9hxLiPbk=;
        b=PDj4a3LqDwoXUXCwQAfP5HM+Vqwl2laKaJ/JLB6FzHLYOlfpy6QDSNvSsm/miOk6HL
         Zj5XbDAP+Weu0wErnex8BafpX3l9d5eZfMRJJInGzgfi8b1EZlRIFmwptFHLTFlSnfii
         0GhSMmr0tlVd2l6o33YoJSh7nHcGhCmaJFe/W8YGKh9fr0a8QpgwI+i/dSx29B6Xy+Ok
         BVs7oS1Sp1AoC7brF4ttY7Vd0ygX8Cc9ffMV2EB7xuENY/nT+3zCFGRGH032u8GfWUtC
         AnYnvnwXnEeJgdM+sVsFuCgX74OZsMPhlfhpYud4RrtPY19YyOEEfC5bSt7V9iJ689ns
         W1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777281529; x=1777886329;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z+NhQmVODRKthYAjn4FjHgsGJoSWaHBLQ4E9hxLiPbk=;
        b=op8mccsIPgsHrC623XTo//SvayawuhUFJsTGop9crkeEU6UPgqqeDfXMb0fu14WLmL
         LBqaiLpXoSq1iCQp55H6No5y6m9CsuHwKzjEghhXgT/dhgjjZ49Lya/8TBqgrBJUIENT
         RzuZ30XYs/ZhvhBfkbUt/H7WqVFy/NK/RWRajxNXt2W30G3mcmYV++du4ibPk6G9ee24
         6mX5Jf8wOLp4b2rL//0S5YHj8icNRsMqsSP1FwIk+PTYz3z0Ux6kGMIhKRJ1dLYw+UoG
         AZz4Y9R9adPzWhTx/Zgm8Kuc2qa5Iio1IQqhMKAwVbOXRVbveM/ICSTee9SdfSEMMcf1
         NINw==
X-Forwarded-Encrypted: i=1; AFNElJ/adDvOg4yBs1vLncrFsW4iGRCVSnitwwsvi6Na9JRUr6+BJF/L/Id7ug3/6mBi6MZrnwYlfR0Int3ZiL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcWYiy2nn0BLFmZa0zPNY6xnqlGiNd6Danob97zfoM4UFT6/pF
	UV8Cv9S+SiNauOuqa1ioTtTqIrGIifzeFSAef2h69MEvgjqRL22FTdfXlZWMRhJV7u7lgKxCa/E
	ojcmZeMogQEhRPwULsfxaYi9N18C1Dwf5dMaEGder41wW3iVTN/ctN4YtDY3dHdnJdHw=
X-Gm-Gg: AeBDieuIpZECqrD4WMJLui4s938Y90d2Fk8xJJD35pnKsi01OSImncRSV5cXehpWrMS
	4kiWn0Ld3SLkQqtIVh5e4qjZWoN6UeqqfWQjm9myGsApdaimdoyE3JuECdtS6Go9APW+HsJWZrR
	r2h0yQylf80Yaklec4o2VI99agxUohZVEnYJF52kQ1yVV3kgkcQRSXLNOxKoC5lGDh8+zheeeiF
	/ezsonl4v+F3S389GUt7YMTMZ3lvAKrGApu9lqAAJOlFKqHoBpBxk6L2IfI77vVxZKAzj+akdqb
	e2epWfrWnmuiB7onrb6U4Q2m/ZgoBPnZXE1Iu5je7qsdvN3Uwdbhit/YMobO0J0MyDUrjLcaWsj
	PY4OtiAkmMRn8eOdya6hN2z8ftsUtfZql4y24oH6syVx6UPm82cOwkuAT9PxcNf8=
X-Received: by 2002:a17:90b:37cb:b0:35f:d56d:1c45 with SMTP id 98e67ed59e1d1-3614041bc7cmr38625193a91.12.1777281528903;
        Mon, 27 Apr 2026 02:18:48 -0700 (PDT)
X-Received: by 2002:a17:90b:37cb:b0:35f:d56d:1c45 with SMTP id 98e67ed59e1d1-3614041bc7cmr38625158a91.12.1777281528337;
        Mon, 27 Apr 2026 02:18:48 -0700 (PDT)
Received: from [10.218.14.97] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3613f56ecbesm11810292a91.0.2026.04.27.02.18.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 02:18:47 -0700 (PDT)
Message-ID: <fcba4863-2e09-4326-ba39-b60ec8788420@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 14:48:42 +0530
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] serial: qcom-geni: Avoid probing debug console UART
 without console support
To: Aniket Randive <aniket.randive@oss.qualcomm.com>,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, anup.kulkarni@oss.qualcomm.com,
        dmitry.baryshkov@oss.qualcomm.com, viken.dadhaniya@oss.qualcomm.com
References: <20260413072501.263871-1-aniket.randive@oss.qualcomm.com>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <20260413072501.263871-1-aniket.randive@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: iZgRfHr4re9gSWT9E7gVBeM9vYGraH5a
X-Proofpoint-ORIG-GUID: iZgRfHr4re9gSWT9E7gVBeM9vYGraH5a
X-Authority-Analysis: v=2.4 cv=TuPWQjXh c=1 sm=1 tr=0 ts=69ef29f9 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=8N2UbNoKPs7AJDuX-gEA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDA5OCBTYWx0ZWRfX3GRqQS+EL89T
 jBpuoG3bEr+zNaSS14qJXzuXBpqRe9m7bBa61Jc0wuh8Ze6MhCnHI8vzms9yHANAdXuAjufMNfE
 OUYCGljrqrGQyjDTakxe+Fv8r0gN+ElFrxaNfflxmCFjrVd7EMrQSI7eB6ibyNmmbcGRyFQlRXq
 aSLWC910mGENLJGsl1bI5cHxEyDgX2HnYZHZ2YUfHjp6XUD3eLTaM3A75RCRQwctBonz0/YhyOV
 PagXrSzMUGSPdaB/uIAZOu9UVt7dIe2sNL+u+jXa06AhxCDq5T3xwHaUMzctz8ozFEuULBX0V2T
 uo6sKjGVtIpK8SSSIUpbY+uIGVeGOx08AvYkTwkG6lFjvYpOJ6vkuLitPyTkugJ9WpJcyAdHfFl
 1VSbYXR35HhXzSUpMYV/Mg3IIqCcgpez0t1UEdEKBpWrEKjn3NKLnF3UYb9h+Kwt8ZxqXAQgiRn
 RgSEek2C4+qU4maUJTQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 impostorscore=0 clxscore=1011 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270098


On 13-04-2026 12:55, Aniket Randive wrote:
> When CONFIG_SERIAL_QCOM_GENI_CONSOLE is disabled, the driver still
> advertises the debug UART compatible strings ("qcom,geni-debug-uart"
> and "qcom,sa8255p-geni-debug-uart") in its of_match table. This lets the
> driver match and probe console UART DT nodes even though console
> support is not built. As a result, the console port is never registered
> with the UART core and uart_add_one_port() fails with -EINVAL.
>
> Fix this by only including the debug UART compatible entries in the
> match table when CONFIG_SERIAL_QCOM_GENI_CONSOLE is enabled, preventing
> the driver from probing console UART nodes when console support is
> absent.
>
> Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>
> ---
>   drivers/tty/serial/qcom_geni_serial.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 9854bb2406e3..b756e0c07c16 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -2039,6 +2039,7 @@ static const struct dev_pm_ops qcom_geni_serial_pm_ops = {
>   };
>   
>   static const struct of_device_id qcom_geni_serial_match_table[] = {
> +#if IS_ENABLED(CONFIG_SERIAL_QCOM_GENI_CONSOLE)
>   	{
>   		.compatible = "qcom,geni-debug-uart",
>   		.data = &qcom_geni_console_data,
> @@ -2047,6 +2048,7 @@ static const struct of_device_id qcom_geni_serial_match_table[] = {
>   		.compatible = "qcom,sa8255p-geni-debug-uart",
>   		.data = &sa8255p_qcom_geni_console_data,
>   	},
> +#endif
>   	{
>   		.compatible = "qcom,geni-uart",
>   		.data = &qcom_geni_uart_data,
Reviewed-by: Praveen Talari <praveen.talari@oss.qualcomm.com>

Thanks,
Praveen Talari
