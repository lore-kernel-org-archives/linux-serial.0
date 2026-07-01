Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B3D481FDF
	for <linux-serial@vger.kernel.org>; Wed,  1 Jul 2026 15:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782919063; cv=none; b=nHPr+7boMuuEvbssBYpNTRsqQrHK4Up5aKkEjJZqIAn4WBZzms7j9onRYGyNni6OaJZ++c1uES3jCdHHO1/OP5BobcyFaE+K7s4DuHKsDWE406hDc3hrBpjSSW4bRKvlnL8/4A1M+kjIzOr95zzVAVBzgrm+VTd4K1gGSZ5jXIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782919063; c=relaxed/simple;
	bh=by58mvU1Sfixgvz9hF5W5LYNik9UGMcTUhzX33TMKjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AOubD2SdFUyuPpt9zYmSsqzKyhQF6QPEWp8KskAq34y/GWqk3P0YZAfr+BxvGD6Azx1tZGvA/WOhGUBGSdeP/w4h6Kiyuqd9SpEsT7ocYJ02mPND19aXc9Ua2ExdRuyYCiQ6k0sGe7zIAoNUc5Rz0J2gq7RGm6VCvEY0gppsu8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HQCscZHD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=An5TBxXS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HQCscZHD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="An5TBxXS"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661A8pGw683696
	for <linux-serial@vger.kernel.org>; Wed, 1 Jul 2026 15:17:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eL8RzYtzz14uHHHZjdkg5Lcy+jo9dJN907wPOrw5Phw=; b=HQCscZHDsrpvDfg3
	G0oD3d+Ry7j7w8ED7pDiRilXkTsnDxmcTuW1qRZDjPvFq4cQC7zKwehaXFAELj4D
	uHylXxH4GSes/yvWOKkQDiXVkT1Fo00dDiXjd5+RY/T5JSzCdBPXgWqlh6pkpxw2
	RmCYoS6EmNPNShJtFtYh43JoJMOIZJ3l+19oh4AwBl0H3LthATxUfcl6dRLET5L3
	p8SxIF2VUfDEl1S+tkPv6RTHUW68VsptxNyCH2JmokTcP6rBDxF5DmkxW6AlUdFS
	+xY3/BJeW7HGhoF2KmU+Nr9H0gPrfKlHA4fLigvyMcUU9vtKfOhp6pd7mnUdh2j6
	rtZDnA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4jtqmwt8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Wed, 01 Jul 2026 15:17:39 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-846f50381a6so567880b3a.0
        for <linux-serial@vger.kernel.org>; Wed, 01 Jul 2026 08:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782919059; x=1783523859; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eL8RzYtzz14uHHHZjdkg5Lcy+jo9dJN907wPOrw5Phw=;
        b=An5TBxXSIJ9Y9+BlrlzK4OcL0mEUSTQNh6B94jfY066QgAQ1BlKtI3nLTVZ7/CFyfE
         xXxcYeK7x5d7CHLK//ut81xzVQMLDCOtXtt8GWzwZIAvNyPfd2DgVBS/RSKgPeNfxjOy
         Uv72JKWCQOax+Rg28bNnZYkqOn6dOuvvUEr/xmW4ACkrew332T4YFNAZZIKrNBiT3S7B
         jo61qOFaIhKA/wb16JHXFYhx0CmYInIzQ5caQynpKINMJDf4ChyjmTU5eAfMLCFe0i4x
         NuBiRBMH/kuyTWZd/QfJS6hTJYBKd4b/rrPgVPhe7nHG2Z0thniNuFst6T2MVwqB8GAA
         We2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782919059; x=1783523859;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eL8RzYtzz14uHHHZjdkg5Lcy+jo9dJN907wPOrw5Phw=;
        b=aPMvABzp9l8gDq47n7DgCXy8Zc9SDk/PvcBdr0sNEsxi1ljhxzWuf+GdcVYKT/CTWX
         uxE1SFXgTQLmNdpR20WTq0kIYmSqR9O93TwwFGZrSuhaG7NLwyEOCGiw7W2DRnj74Nb0
         LY86uUiT/YZrbrkTi6woucl9RLX1woT327yOStSpQMZrg7GND5/9Vxd92g/sRqKhadI9
         zmjQ332tzYaChMRvnwX+7/B9uI0pOrAHFuNAJVhDvuDKbBisXVWMBIWz7NTE7LOlovZA
         1+oI2Msv3W208AyUgAyylFnPYMMZmSX/TQnFEe7nPgkgkIoezoV69LSmzBaqnWQRGUY7
         q5JQ==
X-Forwarded-Encrypted: i=1; AHgh+RoUTx2BwyddM3RPQC7S0XSsRkSgJy0rQov90VrMHOgkJyA7i29MIUqv+Ia2RCIP3kbTiZOuS5A6K1IRYsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzratHmZKpucwcKPy6qhwDzZf42gbm8o0vUAAhXYE+p7mVjXtdN
	vKJhTGfja7BAVxEjJdl5AUPk58un7GtiHW2rnPKCoZ9zUAHuCCoG/Zr027hOF08UiAWe95eAYFX
	bJJ8ta8G4Yzcv0/uhuYej1QRBfB0RIH7OStt8rcrMfhhXh5WDGKeJubt2Xqt+/5xZxPg=
X-Gm-Gg: AfdE7clGy8tn1XUcBi8CvQwVPcnVr9wvZnLnVLwsznbzt9j23B2P0JEkI1R9QaXWVek
	N+t8XqPhVMHin1pBmdUp+MiLE10DUc7iTsXJyfjss/bJ/87YCEYfLIkmqd3uIxY2p/SxQyyuyk8
	rpqY30l4VSUpt04zrKhj5fZ8PCVI+8vSMl6lRzdR+7n2WuMRQBRLhKg6EKV7rxjnW6awtDo6k28
	CCKYVnlkXrmxYBgEjRasalLucbATWq7oRL7nqW6Eh22t/HWuNtF97eLENOwaVEUJsE4WCauvBeX
	TuH7LGPyoLafzRF6KQUQutS+NAGejnVDuFFJAAcJILcW+rWZRNdBmgsMv4yDGNOJjpuanlHemis
	rasQGdNOjUmSqJlZpFdlyYs6rEaGAwK1DC+eRC9pQ1JkyGQ==
X-Received: by 2002:a05:6a00:4f95:b0:847:7128:ecf6 with SMTP id d2e1a72fcca58-847c512d7b4mr991677b3a.40.1782919059351;
        Wed, 01 Jul 2026 08:17:39 -0700 (PDT)
X-Received: by 2002:a05:6a00:4f95:b0:847:7128:ecf6 with SMTP id d2e1a72fcca58-847c512d7b4mr991654b3a.40.1782919058882;
        Wed, 01 Jul 2026 08:17:38 -0700 (PDT)
Received: from [192.168.1.8] ([106.222.232.144])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847a039f2afsm4262001b3a.53.2026.07.01.08.17.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 08:17:38 -0700 (PDT)
Message-ID: <73243e36-175c-4fe3-a448-b30eef9c44ee@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 20:47:32 +0530
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: qcom-geni: add force suspend/resume to system
 sleep callbacks
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, bjorn.andersson@oss.qualcomm.com,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20260701-add_force_suspend_resume_to_system_sleep_callbacks-v1-1-38c9a721a462@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260701-add_force_suspend_resume_to_system_sleep_callbacks-v1-1-38c9a721a462@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: zTISybya3ATvva09wQg0bwXHibenn46E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE2MSBTYWx0ZWRfXykVu0/5AhrBq
 Mmo3DmK5/TRyeksLTncqiRr5zAfhVNoDpCOgIq2UbDt3+OmnjPL5KdpdWeE80FJNENdDh2hYZ6w
 wIdAYVctzvtxXhKJ0gImeIfkS6p3H65v8YEsztkfQOAMj7Q1SEa3jrxtuoBdqOYfE4+kes3empm
 q/+I27yAtmxWb2L1n/TmvSMjF7ktqduANIOiOsaDMcWm4cSb3UJ44pBTz7Li/suTC0/LkrJo3p3
 i9hGTSTFnN28jq8pU1C3uG0jQKgmNtqK1FzA2SG00rnp1dvywd7B/TJcr0+dQk35fwd6/PIqjfo
 Ux8CR7pYukFGy3yzuv0cVs+1+pd4WRXGAcLFqRCFQYTnqZw5/rbqUosu4qogofR0xEabtYB9F3e
 6X/CxKqfqLwK36SEYJ+5zAuXYqIrSG/mhTjjVG7uaa0+XRwMUvXHTn2ubgyQX7ezNB2tO7Clvb3
 1kAnU2V0EHek7AvJVmQ==
X-Proofpoint-GUID: zTISybya3ATvva09wQg0bwXHibenn46E
X-Authority-Analysis: v=2.4 cv=LIZWhpW9 c=1 sm=1 tr=0 ts=6a452f94 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=1q2F+KrbvUZPNaeG7DbW0w==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=WaUktqV4Tl373BT39uoA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE2MSBTYWx0ZWRfX/cgl6LPl5m1a
 NFAcFlf5r3KrGXhbY+bOfwlReUSB6hS/4Kcq2H/YNlBk20VcG85xoRa1XTeoKuuB4qBpaeGTeh7
 AsStAZoCMxGk8hy7rD37Hq0qF6l1vxI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 clxscore=1011 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607010161



On 7/1/2026 11:27 AM, Praveen Talari wrote:
> During system sleep the hardware resources (clocks, interconnect) are
> not gated because the runtime-suspend callback is never invoked from
> the system sleep path.  This prevents the platform from reaching its
> lowest idle state.
> 
> The system sleep callbacks qcom_geni_serial_suspend() and
> qcom_geni_serial_resume() rely solely on uart_suspend_port() /
> uart_resume_port() to manage power.  uart_suspend_port() drives the
> UART PM state machine to UART_PM_STATE_OFF, which in turn calls
> pm_runtime_put_sync() and eventually the runtime-suspend callback.
> However, if the runtime-PM usage count is still elevated at the time
> of system sleep (e.g. the port is held active by an open file
> descriptor), the runtime-suspend callback is never invoked and the
> hardware resources (clocks, interconnect) remain enabled across
> suspend, preventing the platform from reaching its lowest idle state.
> 
> Fix this by calling pm_runtime_force_suspend() at the end of
> qcom_geni_serial_suspend() so that the runtime-suspend callback is
> always executed regardless of the usage count, and by calling
> pm_runtime_force_resume() at the start of qcom_geni_serial_resume()
> to restore those resources before uart_resume_port() re-opens the
> port.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---
[...]
> @@ -1963,7 +1964,19 @@ static int qcom_geni_serial_suspend(struct device *dev)
>   		geni_icc_set_tag(&port->se, QCOM_ICC_TAG_ACTIVE_ONLY);
>   		geni_icc_set_bw(&port->se);
>   	}
> -	return uart_suspend_port(private_data->drv, uport);
> +
> +	ret = uart_suspend_port(private_data->drv, uport);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * When no_console_suspend is set the console must remain active
> +	 * across system sleep, so skip the force suspend path.
> +	 */
> +	if (uart_console(uport) && !uport->suspended)
> +		return 0;
Rather use console_suspend_enabled and take action to go force suspend.
Here, it sounds opposite, if port is resumed, you don't go to suspend 
within suspend function.
> +
> +	return pm_runtime_force_suspend(dev);
Is this really required ? if  uart_suspend_port() successful, what will 
happen with this ?

>   }
>   
[...]


