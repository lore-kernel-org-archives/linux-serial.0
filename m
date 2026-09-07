Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473981940B0
	for <linux-serial@vger.kernel.org>; Mon,  7 Sep 2026 04:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788755831; cv=none; b=T92HJn8mr/x74HHY1i/sTAkiHdJs0tTy1428Ct63x04rTXMkQLsPq+XYcqZp2O0d/Y15nrlgwrCbF3TQyTpAQbD9CpQ++YO0GhXa1U5cLnF9NAPmLOeqY3a54JzM9IzlpeNXLFRAt0Jx9TsoEfiCGhPbevDfHPqd0EG1ABtnWl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788755831; c=relaxed/simple;
	bh=2+n5fGs3tabIyURWa5XXiB9R/FEEX7QdcfDfhiFcxck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U6vGymcoYa3mJd8kFWHnV0mEoMu9ghQxhDUcpC5XOlkoYHMNbjUr4vNRXgR8uQvrAqOtwzkcHF89qibJNzBtiUAaCLe6l3aO79w2OrsuuvfcMg6mzZGwIxkno5DzWweSTskDCS12NZ9jMa8vtXXVe4Yy8ysT56ySiOVBjiBpBDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=on1EM+zR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VjFyQv11; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="on1EM+zR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VjFyQv11"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6873lMXN3455043
	for <linux-serial@vger.kernel.org>; Mon, 7 Sep 2026 04:37:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zNvvm20dPKR7DWghQAb3b0At3rnqrH5dbI5V0wZ4eLI=; b=on1EM+zRLJFnZ1SQ
	mbWkV8yafx1AROhK5tAeSmoBIeyn/dsLnGRz2gOHcpaHjYgTXE5NkvwPtca+92az
	xp72Sd3JY8eHx4E1yQwJWWNPjcRpvjkQW1uc171nkhB/zx+nw+F7W/9AcESRTuE/
	YcRMIZg6QeTU16ipZvIR+LXiuyGFq0zlHFIiBKn5uCAP3GwVMUOaI8K32P1ob62D
	641l/Vb38iaAKP+N9yllAp1eKz+pChGBtex5k0d/aVR7JZtqwXjRFDjPzwItQ81P
	+mNmiVjmrsdfK8+GyvD9EnpIQn8XXVpzU3QmG75fnsL12GzY4SKBWmESeFCnPugG
	5rZheQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ggany4yky-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Mon, 07 Sep 2026 04:37:08 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2db3b126c9fso18335745ad.0
        for <linux-serial@vger.kernel.org>; Sun, 06 Sep 2026 21:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788755827; x=1789360627; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zNvvm20dPKR7DWghQAb3b0At3rnqrH5dbI5V0wZ4eLI=;
        b=VjFyQv11NFbXTddRa64r8lf/wyn9JB4lop/r6VGqoH5GDHC5TPQ+kgsc/FIVcY3Y2i
         sOEU4042APneLiMLJ8O2lHnCER+0vF4h5V0p9YdQPVDfz10XKlOYsbGErn1+kjSPLj0e
         OOSpyUB2RStP0ZC2mZgq0fb6fFMLaFyg9WNvXtIbACDFxn+FqFc31XaIo/TMHZe5tCP/
         yPB2biAD0VEilbQ4w6P1N7EcTcnIpT121LJBVrbbN5N+yFl4carSIF3/vlV8SAZcy64M
         KHpN3cUKr0V2CrqGQmENf4r3Bwh2fpK4UF6IclOe0NySijpkYp2N38u/XPyvWMmbeozQ
         +/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788755827; x=1789360627;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zNvvm20dPKR7DWghQAb3b0At3rnqrH5dbI5V0wZ4eLI=;
        b=UajjW7CcCE94izjo++z56ZYkNhx/5m6k3EvlCK8FWPEuXgFp46h+FynI7UoaFhbwdQ
         4cu+FHQSXB0ZE4be9DkbNl8jfIwJGfHCD8PQngW35d9WCNIN1bcPVJwtJJLdKp35sN73
         FHg+4VYycTfhgC8Old1ZoU7zsdNSKSJQgNTBLWlNGwfK8RxakuuYkN+gU2rFXh2SEONv
         SIaG+lB2A6hIO7UOEDCWShFHA6l7GxLRMCwmjSY6EgzXc2aj4ogXrpf+6d5uZW1+HiaS
         6HAZFqhTr1p/OTjDXvOFPAWFAgU0c/Xx8T4+FAqets5Cl9ZnlAIkhm5Lk2zmTfKSs5Sk
         CipA==
X-Forwarded-Encrypted: i=1; AKwUvBy83YdfG1fW5jcOD0UOGhvidWqEljQY+V4mQ/gR/9fMQkQ8zEKpKg2BN5nPIn1KadjCLk2/uiBhEGC/5yc=@vger.kernel.org
X-Gm-Message-State: AFuF++mKnicmJ7fBfn18xMSbvj0wbbDHzKdfGGSAXdGzhNaO+lb3JZAk
	tqSg4Jpmz2JfVyfOYpDo7XjI8kAkIscKBPhI9KqgB+KFYoeVY2K+g5jWfop59Y5iqMKjdTtSIYN
	KtmHOf9g8Ef2EJjq24RcpmlyNlf3lrQRnqNIu4QJ3ObPIwHC/2vPRw8RlFWphMWYK9CGxsj26pa
	E=
X-Gm-Gg: AYBFou0I+jhhSZ7u6RfwxETseDzy5p1k+qASLXyVeo6qK7TsfAD2PLM79B0CZrpErQd
	iq/8OYfyo0IsPzX+Mrvo/mle92VJLnBwO+1p9NG7GUThBZXHfjmoqlcpLWQhD1T3twPtMZxeNn5
	KElKC2IBXDTZcCQoC5hYy72Rnr8p0tS09ywL22UH+FpBJU1T/LvGlLHu+h5oFSACe3pHMEIew8c
	blTnCW9Owrkb/8xxloAKEwfliQeEtqtzWIqJoq1k3FPmdxWcqQmvOId+MN54gZkC2EPa7IyhqeO
	3hH3JZDK0WbZxJ8H3DHmFSZquITy+LMO+zUn0Hwj1hxaO6z8uZOe9S+5NVb1OS1KKoSdvrAbDe3
	YOX8VQduceiTUJwgm7I9d7zzJ46zABbLwJA==
X-Received: by 2002:a17:903:1844:b0:2da:ef81:37e7 with SMTP id d9443c01a7336-2db126b1bcfmr332012445ad.21.1788755827067;
        Sun, 06 Sep 2026 21:37:07 -0700 (PDT)
X-Received: by 2002:a17:903:1844:b0:2da:ef81:37e7 with SMTP id d9443c01a7336-2db126b1bcfmr332011875ad.21.1788755826600;
        Sun, 06 Sep 2026 21:37:06 -0700 (PDT)
Received: from [10.217.218.252] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33517b57ac8sm14256187eec.28.2026.09.06.21.37.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Sep 2026 21:37:06 -0700 (PDT)
Message-ID: <39973fa7-fa96-47e1-acf5-1ae27a5b28dc@oss.qualcomm.com>
Date: Mon, 7 Sep 2026 10:07:01 +0530
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty: serial: qcom_geni: don't ida_free() the console port
 line
To: Neil Armstrong <neil.armstrong@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Viken Dadhaniya <quic_vdadhani@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20260904-topic-sm8x50-upstream-tty-serial-geni-fix-ida-free-v1-1-02e18c31aeba@linaro.org>
Content-Language: en-US
From: Aniket RANDIVE <aniket.randive@oss.qualcomm.com>
In-Reply-To: <20260904-topic-sm8x50-upstream-tty-serial-geni-fix-ida-free-v1-1-02e18c31aeba@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=X45i7mTe c=1 sm=1 tr=0 ts=6a9e3f74 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=mRzOu2RZjW8rS5LHIWkA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: DlsAmcw6Hi1jYGfosRhuWjGMioSLyLEP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDA0NiBTYWx0ZWRfXyAn8LYAWM4eR
 yIuRSWC4q63jTtmTkaIeSL3v9fRe2+o/j2qjQNRJobzBLTn5aY7DmEADCj8cDGzch0mht/sd1Jb
 bTGOraSoiNuxpY+UicvZV35SSTbW0AEPxolDd27TbTG4arnlHTN6/mgg/zY002feMePMIeBIzne
 O15BmGS9dVslyAwh0Dgo2kq/BPEzuVo8UoLs7V0zPeO4TvyvZeKHPkGcPhd5Fm+mVQn53IglRUt
 BZA0d8NRz5wr0qd+Lc/KCXAZh/HDWuz591VpeBwl2+fMo4OqlpTvs/9gT4VEOUz2+scY05OECwD
 9Nypz6U+8liglaMcEVciFJJi8gWp8QAdl3fUVlbEKsT7kG09FR5CerHo5WzOUrLg86ED3JAelaS
 J00Pf1pi1O4iiGCT+UIVoE3YNZzuHJ+nbK31a0q15d6ObeTz1XBaQhc+ciWTakKPCDrIIyELsF2
 jukpdO4LV/epNsRj5cA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDA0NiBTYWx0ZWRfX4IeBuMKylppI
 8X4Ttx54pzyA4VakXjZy9/q+Ox5r7UyEyc2BGjhr/HL5uzDRzzfpo9fy07JFfy3sTdW8y/29i61
 j/dxWbcgerXVTy4X1R2hDkiC/ALmuO4=
X-Proofpoint-GUID: DlsAmcw6Hi1jYGfosRhuWjGMioSLyLEP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_01,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1015 adultscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070046

Hi Neil,

This appears to be already fixed by:

commit ("serial: qcom-geni: Fix port_ida handling for console and probe 
errors")

which also fixes additional port_ida leak paths.

On 9/4/2026 12:39 PM, Neil Armstrong wrote:
> The console port (qcom_geni_console_port) is a static instance whose
> uport.line is hardcoded to 0 and is never allocated from port_ida.
> Only the non-console path in get_port_from_line() calls ida_alloc_range().
> 
> Fix the qcom_geni_serial_remove() and the matching probe() error path
> so unbinding the console device doesn't hit:
> 
>    WARNING: ida_free called for id=0 which is not allocated
>    <snip>
>    qcom_geni_serial_remove+0x58/0x80
> 
> Fixes: a53be6945f51 ("serial: qcom-geni: Remove alias dependency from qcom serial driver")
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   drivers/tty/serial/qcom_geni_serial.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 3633723acef8..bdbdfd7dfaac 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -1979,7 +1979,8 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
>   						port->wakeup_irq);
>   		if (ret) {
>   			device_init_wakeup(&pdev->dev, false);
> -			ida_free(&port_ida, uport->line);
> +			if (!uart_console(uport))
> +				ida_free(&port_ida, uport->line);
>   			goto error;
>   		}
>   	}
> @@ -2024,7 +2025,8 @@ static void qcom_geni_serial_remove(struct platform_device *pdev)
>   	irq_work_sync(&port->tx_kick);
>   	dev_pm_clear_wake_irq(&pdev->dev);
>   	device_init_wakeup(&pdev->dev, false);
> -	ida_free(&port_ida, uport->line);
> +	if (!uart_console(uport))
> +		ida_free(&port_ida, uport->line);
>   	uart_remove_one_port(drv, &port->uport);
>   
>   	if (port->rx_dma_addr) {
> 
> ---
> base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
> change-id: 20260904-topic-sm8x50-upstream-tty-serial-geni-fix-ida-free-4a199c25fd84
> 
> Best regards,
> --
> Neil Armstrong <neil.armstrong@linaro.org>
> 
> 

