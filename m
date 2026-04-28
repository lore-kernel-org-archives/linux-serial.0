Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A400038423B
	for <linux-serial@vger.kernel.org>; Tue, 28 Apr 2026 09:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777368518; cv=none; b=nnx5F5S3TNsnm+jX2KIfcOV8F32sTxEGLnJJGSJVnWm7t3TSM/K0Iu+WOVLatm+5lFWcrmvekYTD/K98ElJMcW5OcjIwu/qOylYDuE86oCYIKLfLGKn8+yLrgcWLO0llFh4aUBu/aWKEvaz6ErFsoB823xp8NdNB5ob62iOBwHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777368518; c=relaxed/simple;
	bh=oesX8bfLDzpNm/1KbSy/2QzqQU8rVLugkFjCxjd8+ig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dzY0ZPqxoA0cwwdXALcsTMDKLBzzfOK595l9xJ0LbAWO8L2NO2fIoy0rZjMEwZWmBnw07VDknxCYqzEPxLo1KiJ3idRNLEU+qMgfH89gqnNwSTY0jZVuCscft2IyHpw78vynLn9r4V+LPdK5W/VBkVa8UpoteUY8ayId0UstXr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lRkrsxc+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J1w8iN2J; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lRkrsxc+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J1w8iN2J"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S3oReT2006206
	for <linux-serial@vger.kernel.org>; Tue, 28 Apr 2026 09:28:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kFva+OMsaG3w+BC4sr7PkwTKOhEzasA6SoH0B+QAP1A=; b=lRkrsxc+VGDM7DaW
	Z2MVI3auE2dxhH8gA3vpKqI5Qo+KOsSYjPI8ECB9+hRGEmYE9tgjnzM9TF/4Hj/L
	MVLaChNGUcLJcCUGdy3fIgwbsFmzQ7jT2UrBnmxAtNVVcyZrwHQWzOB2CRP9q6td
	/TJ1M2hRaaqDCoFsUdcBRyDOahayKDKPC3+zjJllw4LiCZeTL3rNrReyZZQsLANF
	Tlgi42nGrLuJ1bzXaf7+BK2BfckcZVbnzLvruCdRAfbvzlUCbuGiH8MVOzcb+4mA
	7nPqESWtkg0kPQghB+uKTb9xplelhpoKZCl0H50G7/lvSAHGQRqD6oX5rlMRlUjy
	tmz+uQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt7gkmdde-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Tue, 28 Apr 2026 09:28:35 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50d8c183c2eso105328331cf.0
        for <linux-serial@vger.kernel.org>; Tue, 28 Apr 2026 02:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777368515; x=1777973315; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kFva+OMsaG3w+BC4sr7PkwTKOhEzasA6SoH0B+QAP1A=;
        b=J1w8iN2Jp8eE+X095DQYtmhX34hn3KMN1N4DHB/iX2KkRfsADOj0mC6df+q354N5zr
         5Np3NPfxsUn1f6efYWHBAlNvsokuMWrcFPvOXT9faT/V++SYVGnHVENHWdUDIWm4Gv+p
         NWIctjiJhfRq9gyEiPweEQ47UYVFqhY1F8HfyE8qa4xPFC+sQUkTDOpxlVTRU6eaLW8d
         L4SBHFpb8EJ0ULsMEK7rz2LZAkjfQghs4yNREA/Lr/wr66srqKqC6DdFSwTm4XfyxGPV
         1sY9iv7cmopeHGBdW9h//w9+4s7ZG2dgOwX5z9HkxS3k+jNcYYk2ofXABphkG2EQyF2Y
         FcxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777368515; x=1777973315;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kFva+OMsaG3w+BC4sr7PkwTKOhEzasA6SoH0B+QAP1A=;
        b=F0lojlm8hRGyYWV6QCe3zDVDtH3GtsJURvaA4Y7YlhbRNUui4GdZrDYVDe+Z9ape8t
         afyW8MsiwyKIlki+z/2Ytx6g3O68oOOfTTtGrh0TwJXtYga5OLW1ReW9Gb39ZaVLY7zW
         5jTUuRYos2C2FEIkp7Mm5qJrGzFAUpHCyYcEyD/gCxlvRZKtoOmT/UAIWWyBkcN3FLRH
         0QlAGIxdju1KnDlGbhTvois7vteAvWMeWw00vn+5y88KhglYwOtG8feUv4yrH3PNb+9+
         +KWldspgmvrTodyTH7tA43Xmca3EPEH14H7xUPBle/pqzgq2oP8Q5o286KVtWwZM0iNR
         dMcA==
X-Forwarded-Encrypted: i=1; AFNElJ+Wpu1NnDmVaYCugd+nLKJqSFr3lAeQunXNbo60QqBdxDrE9yuU4tyJ54h1JNM3HiCvtRHm9Kg13O8p3aM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm1BrSl5v4SxAQTe9ubkRAd9AMHbn47I7B86xoa4eJGbHAji68
	3MPZFZJ1vO3tLN+HeDSKbxrG9FCSvGgK0/vW133Yq0WdijS2uXUY5ZCs9W1lKFVL8UlvmbnIbtk
	YeRNcbotAMESlneTNMjK+pl7L3kRFlzkHOX78F4A8Y9dVcImkRkocX5fEP899QTkgiUs=
X-Gm-Gg: AeBDiesNkHt4bec1q2YP2Z58wNZSb1iS/F/jRzQPOP0ARwjLzzLlWd2i9PPPZkFmBrK
	k3fY4cAQ9Ijw7TGey877HLu7NzGRGE8iaNW3X0Sw9Z+qsv7g5+PD0M3LOgqsRxsasK54iIesmbd
	4784yDTJ6jnP25sQiac6X0HSZfy1hXvtYvRHKgNlGzxB1FOlITnpBgBKL8jMgzkqZz/mmdV8A7r
	xaXr26cZh5F4Z8JQMnB8YhjNpiJkb2QEAlWUv6CEUiSg/+CCjDk91csQWxsTlGy5U92l2DxB13O
	/U2FXBsKNrEZuywYelTvR4vKlOQ+ArbpRz86I3LqVHD1oXi1+AYqZhjsNXR7FjW8DX/J2bbgeZ5
	0o22jhW/4L/wrxdUe8Z9WLTvu6J00J+IeIWrG4u+2g70o3EmaJO05SMzNe2gDur+0gE6S1GEcp0
	8H38d6EQwErZfKsA==
X-Received: by 2002:a05:620a:708d:b0:8ed:d6df:c768 with SMTP id af79cd13be357-8f7b6478d8bmr234689885a.7.1777368514881;
        Tue, 28 Apr 2026 02:28:34 -0700 (PDT)
X-Received: by 2002:a05:620a:708d:b0:8ed:d6df:c768 with SMTP id af79cd13be357-8f7b6478d8bmr234687585a.7.1777368514369;
        Tue, 28 Apr 2026 02:28:34 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-679b67d5eb1sm509465a12.10.2026.04.28.02.28.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 02:28:33 -0700 (PDT)
Message-ID: <a408c569-dca9-4f49-bbd6-59caa6921515@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 11:28:31 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] serial: qcom-geni: fix UART_RX_PAR_EN bit position
To: prasanna.s@oss.qualcomm.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        Doug Anderson <dianders@google.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, stable@vger.kernel.org
References: <20260428-serial-bit-correct-v1-1-9131ad5b97d8@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260428-serial-bit-correct-v1-1-9131ad5b97d8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: kgEj-c9VhVDK_91dbiOjTby9SRVff06O
X-Proofpoint-ORIG-GUID: kgEj-c9VhVDK_91dbiOjTby9SRVff06O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDA4MiBTYWx0ZWRfX3U+leT57Kclt
 AJtHsh4R6iJGp2R7cMvVd12mI+A2fBh0gv1Cojh87PDunyKWTliUYTvaAW/1eKpadM88yy1LtXL
 1Bl1Vf34nKcLQkmKcvSRhCyF6Axnyt5aBQXvplqHRaikQqSurJs6O2dWAIsjpS0rMqZCPfT2Q5h
 Yy2V9BryCXIiT1xHxYd8rN30udNof9jjBkIVY1uU9jbXRiF67NqYS4yVZq0zrdOyAHwfz0Lx1/5
 XlsbUbV7VL8CfzPWyDUp0VE/pnni1iZUbwgCJfm/bB86At6mfFnD4SeI/npeLPr8vEeLwQyP/t0
 z4ch+9SpGVVTBCk2yfhXFEzYyQxe9Z/5qj9hc5uXmVBYtPmKvqhBHmp3c9S4Oau1taN+v42BOab
 eguS30WBkKST+cMker9maSx03okmVeW/FKrz9yp5kzxDzh3tVAuOje5yOQmExRkQygW0LveqQ2s
 jFDxtvLFFCW5aXQszMw==
X-Authority-Analysis: v=2.4 cv=bJsm5v+Z c=1 sm=1 tr=0 ts=69f07dc3 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=BX9ZcpzAl-p6V8_k-9oA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 suspectscore=0 malwarescore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280082

On 4/28/26 6:26 AM, Prasanna S via B4 Relay wrote:
> From: Prasanna S <prasanna.s@oss.qualcomm.com>
> 
> UART_RX_PAR_EN is incorrectly defined as bit 3, which triggers false
> framing errors (S_GP_IRQ_1_EN) and causes received data to be dropped
> when parity is enabled and the parity bit is 0.
> 
> Define UART_RX_PAR_EN as bit 4 of the SE_UART_RX_TRANS_CFG register, as
> specified in the reference manual.
> 
> Fixes: c4f528795d1a ("tty: serial: msm_geni_serial: Add serial driver support for GENI based QUP")
> Cc: stable@vger.kernel.org
> Signed-off-by: Prasanna S <prasanna.s@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
