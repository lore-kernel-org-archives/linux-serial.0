Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792998409;
	b=xdjBDUv5FQpsB+C1PcG28BO6D9SVZgVSu6EQWZR3jSqQjYiP1msVzwRX42yNDxzk4JFy
	 b/NmNskh0KU/u+9XAEOMkJhDhU+bQ3ZJ1sAlKEyoj8q4RmzpLYg7+vFhIW2jhVfXV9QMY
	 wPJ2A+vaVtpvWnTI2pG93sQjR7sWY6Ei1aqaa9dnLeXBrWDsjpnSRWzyz1AdDUFybzL2e
	 t3hJeK+WvPu3qtEBjgBsDZ/142g+CaGu0NqKKquSTxE3iBWGJDCT4PX24WztIcI5Q0V2F
	 8f67ji/uF2+AgyCEZphpGcQ+pMUGMW2/Coo6UW/a+UqGbBdoIspffOSsLb75grnLU7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792998409;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=LACHu7oKfmE41jF5sp+MfYyJU/SxFmiy1at/NlNWtfU=;
	b=1/RuVN4VCtinrT9tzUd4JuqfSZag7hj4XTOYfKLWYXumO0e9CNZe+CFdJ/B0hrLMsA8b
	 1SZ6E/01ZTQhOFq/V/EjGlNZt3oy6/RC7wJ/k8sRMVCn6zWIo4LVFPKHgB/OnykBDd9US
	 xmQBNW+dRdQYjQvS0M2LZlKxHx9sMKIGtG0EN71stSFbggZUzO6gM6cgWjuPF0bquUYGu
	 TyrguVV23AL0Zvhh+7hJzgavcoV6ig7moz+7iKSvrU6UUvVIIJXkR0419B15f3vZQOiM3
	 VYuTwU25O2IEQ1o/mKm84AWVFYMdNA8NYMSLSydpNJ1xmlEByVE3T/CUowXD8vlpdEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LPUVN+oy;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FZVJGxMo;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9B0606A31D
	for <linux-serial@vger.kernel.org>; Mon, 26 Oct 2026 07:06:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D9B0606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LPUVN+oy;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FZVJGxMo
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q4b1Ex2806329
	for <linux-serial@vger.kernel.org>; Mon, 26 Oct 2026 07:06:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LACHu7oKfmE41jF5sp+MfYyJU/SxFmiy1at/NlNWtfU=; b=LPUVN+oypp41UgYo
	YKB5MUPrcJn4wIXAteNamG2ccCJykFAFgLk79bcBlPFU20WT9AKuKq06fI3FQH8n
	yudGHlKf+G2TrEoGRU1RFXb9IWFJaxd19Wg0uIgytNgKq2Ui5bnFwiF5e+t9pwHi
	OftpA82p68kRtbADY3FzUu4nTpXXq339prUwoUZOTJfLkDhbCZ83+mvsjJdDJymi
	wtjkiL+Xv28eq+dHFgZhX2OwLmJl8tdWrtuENsMHWCR0pBtH8Mforp+o0LEe/XMc
	8JtUKlebd56U/R9ztCMKcFHPwk1JcA//iyFkC2GtiCXVxkRLb/oefHf6DNhoHFBL
	LHzkjw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgm8xn9bx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Mon, 26 Oct 2026 07:06:48 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2e8ba4757baso29315545ad.0
        for <linux-serial@vger.kernel.org>; Mon, 26 Oct 2026 00:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792998407; x=1793603207; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LACHu7oKfmE41jF5sp+MfYyJU/SxFmiy1at/NlNWtfU=;
        b=FZVJGxMo9la8WYPubjksKYk3S7fJ9KkEW3gAeRRLRxINlXC/Twhfr8wulzBxFbpLsB
         y3F0lv+gXhZsjtJgCEHukXz/lGO9w5WuazGUQyG0YpJzAl/S3vQUV9FcXJgb5SOJzSpz
         G/+RmMcExo6Nw0w0lg830j7Pvu8Qpaz33f5fevo4JgSb9FG9FbuN3/RxLvdLOer6C+WY
         mYVuCYyorLOiOnLgwQE5TZIVN7SJCFFiHVmmDutiB1DcJ1rlH2DVGjrJY1jfsgSYbeX0
         gPbsWvorQ9xNL1w35cudgkJIuijv/6070/RT4LBYp/4ocMvBVDLHj6DuDJPA+lnNtiIy
         9d2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792998407; x=1793603207;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LACHu7oKfmE41jF5sp+MfYyJU/SxFmiy1at/NlNWtfU=;
        b=r+sbU0qGY7M8CT4OOWmK2LzZ898YK7ziwWvlMGz0CWEVSoEvPQ8reAzJbpZsf7yZz2
         iE2CR3QUvw/07apRMp0OIB/z37coYkwdwuBCYMZpuUuga+C5fUIjMx1eRN0npwxKgMJn
         uh4ETFTkQxOEa4Xukm61o0oO4wk/1kLsuXy27Iu/xMAHsPvDneOUjWtT3JYMzaasp3Z1
         NdmNNJBWo5Rr34yKWwkyF6Y8G+VzXpGfd3xoeK9UU7xtndcS8fn6OTAyP/0YvaDnWhEO
         enh5uWs4vLUJKvb5PqquJ17lgLB8uGYYvPELGL3wHQtxHCXmJ5sWf/X37PxXhov+mmnI
         oHtQ==
X-Forwarded-Encrypted: i=1; AKwUvBzsUDBXOBp9yym8cgq2HijRFpG+1memCo/VytOxaU5db8M0jC7ss6r5CMapay+7T4OMzNb+ElC6NJ4bcoY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJUQFOZ78+zL2U55+Qn2JFNjl1RWYJ43y8LDUwe/fl8ZFfg8D83
	hR9k+VuFEVLQIyLcAfRegL/+JrSQA/9dOah9Bsfsv2ZKP8Cs6zTbDvOOsdjzX4TLU4XtjePLcnM
	s6E+pwQhQ/Qyx6JznHGq/HlyU7FBmy0MRlG91oee65qN5aUA7c0hG1T5ZmEbX1zXEDDA=
X-Gm-Gg: AYBFou0PnlRBea4sZDEuaP2SsuzuVxxaOW0YOsvYLdwjF3QqWuvAp4WVwO/qsWV7T1/
	jsyEx/954D/1vm8k7gXsB9F+2wx18XIoX10zKCXnD4mRn9MgxWnWW5pN1a8KKvv+wAOTR9hP2Zv
	/h2wjaO18Vs2ORMvsTK15U/vwbkf9gDengocFQtmifaQu1JNhVuiO0PAlZQbAxeOvD7gI1ixtOd
	1NCH6Qsa/ZEBTNcYp41QfZD/IFJCl65vhT+yBOoDQflCQ6MZuZPccWpN38RellMzvfa+fxz5wYf
	7Jng6x5U/kMSjkyjF7e2xwKIeAKXh9VKOG/o3VNX1f6rnsBFATdFCAath33NJhDb4uT11UZZTQP
	kUSi1H9FDPvsVJE0odHEBtwbmhJfWhQ==
X-Received: by 2002:a17:90a:e7c8:b0:3ad:77fd:c3d8 with SMTP id 98e67ed59e1d1-3ade9a3644dmr5600085a91.1.1792998407061;
        Mon, 26 Oct 2026 00:06:47 -0700 (PDT)
X-Received: by 2002:a17:90a:e7c8:b0:3ad:77fd:c3d8 with SMTP id 98e67ed59e1d1-3ade9a3644dmr5600067a91.1.1792998406269;
        Mon, 26 Oct 2026 00:06:46 -0700 (PDT)
Received: from [10.218.14.97] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebb0718esm6949365a91.11.2026.10.26.00.06.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 00:06:45 -0700 (PDT)
Message-ID: <57158d21-44ca-4776-8fcf-313d583b340a@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 12:36:41 +0530
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: qcom-geni: Add tracepoints for SE reg dump
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc: chandana.chiluveru@oss.qualcomm.com, mukesh.savaliya@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20261019-add-tracepoints-for-se-reg-dump-uart-v1-1-1fb47b1605b9@oss.qualcomm.com>
 <2876c850-e2d0-4ee4-9d8f-50710c371a49@oss.qualcomm.com>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <2876c850-e2d0-4ee4-9d8f-50710c371a49@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: juQy2r3fvrA2R1ZrPdt94jLAYtbeHykg
X-Authority-Analysis: v=2.4 cv=Ra0FmFtv c=1 sm=1 tr=0 ts=6adefc08 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=zCML_R-7N-o1qndpGR8A:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAyOCBTYWx0ZWRfX66Zzhb9nymb+
 QLFt3RuO6/w0XDvS7x6nW+2Z6U27V1cdjMlvXwmWzH5XBF2+2voi7S4q9prs5l3NpsB0aPprz+B
 BFjyKrHFEvDF7JcyCqKz80z7v4n8+Eo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAyOCBTYWx0ZWRfX4xcT0H4EloCU
 jSZm9YoNdZTA6NP129lnK0qw/Pfqxvi5xaLiNvReQJr0t9lNxWBDLkSSMXV9cbhv6oPnBvAM9Kr
 Ntel6GdmmECjoeRBwwvwmC9Pswegk6WD7gkS5OJMSyi7V3jFB8QW78Z1Ro19fDkWWCmnIo3p8m5
 d8o+Q66PxANfB97SiDqo5BvRfEWVphyVChyKgIB/etNN60uzBiZYhy3DEPKKMInwJ3q/UHTLW0v
 AJcIOW9LI90I9Nbfo/TXAtbsc9prflUcP5zOgykM6PZSccf9ZQ4Nk6JrGgg0JCIAYNmuMt8Irw6
 KJWl0YELcs9h6Yg+kiPPRQtIwBn+HsNgHxxM4hkgQ2aI7QNAoJ1F7F7DtA1DPxERS+tAgTeXkBO
 iRlUKIV3oEW6vNDXzAwqxzyr5u2XxEaFMu2/iN5hKYFNlHOSDPkAGVgmGpm8tF3eB40iL8eR9MX
 GEO0DiQA5qjcmc+KsHw==
X-Proofpoint-ORIG-GUID: juQy2r3fvrA2R1ZrPdt94jLAYtbeHykg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260028

Hi Konrad,

On 23-10-2026 17:32, Konrad Dybcio wrote:
> On 10/19/26 5:32 AM, Praveen Talari wrote:
>> The GENI serial driver reports various transfer failures such as
>> M_CMD abort/cancel timeouts, DMA TX/RX FSM reset timeouts, RX FIFO
>> write errors, illegal command interrupts, and DMA parity errors.
>> However, diagnosing the root cause of these failures is difficult as
>> the hardware state is not captured when the error occurs.
>>
>> Add trace_geni_se_regs() calls at critical serial error handling paths
>> to automatically capture GENI serial engine debug registers when
>> failures are detected. This includes:
>>
>> - M_CMD abort/cancel timeout
>> - DMA TX/RX FSM reset timeout
>> - Unexpected zero-byte RX DMA completion
>> - RX FIFO write error and illegal command interrupt status
>> - RX DMA parity error
>>
>> Dumping the SE debug registers at the time of failure provides
>> additional hardware context and significantly improves post-mortem
>> analysis of serial transfer issues without affecting normal
>> operation.
>>
>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
>> ---
> The commit message should mention the additional logging changes
> too
Sure, will update in next patch.
>
> [...]
>
>> -	if (WARN_ON(m_irq_status & M_ILLEGAL_CMD_EN))
>> +	if (m_irq_status & M_ILLEGAL_CMD_EN) {
> if (WARN_ON(m_irq...))
Sure, will update in next patch.
>
> Konrad
>
>> +		trace_geni_se_regs(&port->se);
>> +		WARN_ON(1);
>>   		goto handle_rx;
>> +	}
>>   
>>   	if (dma) {
>>   		if (dma_tx_status & TX_DMA_DONE) {
>> @@ -1270,6 +1285,7 @@ static irqreturn_t qcom_geni_serial_isr(int isr, void *dev)
>>   			if (dma_rx_status & RX_DMA_PARITY_ERR) {
>>   				uport->icount.parity++;
>>   				drop_rx = true;
>> +				trace_geni_se_regs(&port->se);
>>   			}
>>   
>>   			if (dma_rx_status & RX_DMA_BREAK)
>>
>> ---
>> base-commit: 2efb7a11f1aa4d2dc285fe2680cca22cb9f72f64
>> change-id: 20260927-add-tracepoints-for-se-reg-dump-uart-30d93639447a
>>
>> Best regards,
>> --
>> Praveen Talari <praveen.talari@oss.qualcomm.com>
