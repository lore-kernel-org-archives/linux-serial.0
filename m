Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792756962;
	b=lCqAurowJ4at2zPsipru28hwcpIb7hX7xij4KYaGiq62qMtevC+3SVVsnYR6f5pS7ZHi
	 6fd62fqaHgv8qxwwV1LRYkTECbZUAM/DH27AvPbqHh6EyzQ3/Ygxq1UOslqnDaVlENfks
	 NQNOZ5FALu5lzMPxgy7QNzzMiY1PIoHEU8S/FfNmW853qPqh2Eaop2DY+tde43QBMsb6N
	 vS+1lMyKc/GXO9wapR8fERzOkEdVNEHsqXFhQ9sBRBJcjp/gm96aj0W2sKNr5vJutTwWj
	 TWIncTvmGlifY6DkNelZZL0Yiri9j6x7HvP3xWlXV+4lZnyGqtP1AHP7ckdOK0AdSpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792756962;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=2k2Fv+H33Z3TanT3edb6+47JQf2jhy0HXLtLEKD802U=;
	b=SEvv+GULW1mOfk59eB8rk7DeQclQ1tL5GUr74hid39YT/jh19IqKqydgAnAJfCUjJDnv
	 ii/NBZRoqH2ypW1Zh8dNM/B0aFqKldJB2a5rGSAl8FZrd5xDyclOkIMYxcIWzj4GaG/Z7
	 dxLyz1c6QUhcpwAN4XzOUDqd9ERKwr9/+tM58BUAOzfHElGX8nG0BJ5aF94240DKPjVHT
	 I8ykMZQgzFCaAakxMi1Iz7I1AvDX9DBAy8dK7P5AMBP0TXbkGHyu145uloTm8o+vHgv0i
	 ELCuDbyOO9C/o7psLvcnwQgP2QdjK/GJ/9G8+Y3jdJx1FiIzzWpF94JPEQ0fxKIRsuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cFiPWEYo;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=T1Deq+dD;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025EF606A31A
	for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 12:02:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 025EF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cFiPWEYo;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=T1Deq+dD
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NAAbAH980705
	for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 12:02:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2k2Fv+H33Z3TanT3edb6+47JQf2jhy0HXLtLEKD802U=; b=cFiPWEYonrun0GpX
	ScNCldeFJV5UovpEwTdadde8u4QHE3+T9TV3DTJFss1BEqSLvNszdqaU7BR7V+PP
	o7rd1nyUWDSpCeiIFncS/tE4NzUNSOEzS+yjQ+vIN0ShmGbeepekdTTkm4x6yILv
	tUb7y0RCqJFT9pL5+32YmmsN2++PCfgcOJ7ZCncQYQddpJRgO5+h2B+lKL0FLufR
	rM7Mc3rkgNJwiNFpW6/LJk1UzLyQn7FyLGzf3VolG75HYUWd7K0VL+Ns/ZvYINK+
	oj9dJMlN/0k4vI9rws3cjKwoqloj+eT4Q6Di2uA+LMDJA/htdS3JrUGodDA9ai/Z
	E5Bx5A==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfsmau0mm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 12:02:41 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-81b5451da7cso402016a34.3
        for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 05:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792756960; x=1793361760; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2k2Fv+H33Z3TanT3edb6+47JQf2jhy0HXLtLEKD802U=;
        b=T1Deq+dD8foWHVU3tVWlMDpiWkFSxyLsm3F5VJQ5zmOBpbu3LOXUZV8EwlF911+K6+
         1vYABSfa4ZenCepsBekOCTBn+QldTqj2hJlWvG9AMo+NnYChkQW48law3DFueJaRNIf1
         jRwB0zR0iYMO81jsny7agFV7hlB9Tg6QSY7dKGdaZ9F8F4vforQjKlQ7ofzj16adYiaD
         P+cGWmxFYI3eMHuWMXCxmM1C3jdFknmlIOYHoTcZvkPT+ne5m2di91ALd0X5k3Z1/9q7
         xNcUnZcuhQr01EL1dRPAT+H2449PMPfPhADIAcRsPNL3xF0tMjgvigf0vOXqiz1HW8WK
         Q0YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792756960; x=1793361760;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2k2Fv+H33Z3TanT3edb6+47JQf2jhy0HXLtLEKD802U=;
        b=HkzHY9XearXcZZ+fhYLGWM5ic8KH+qHOmg0GFBjqHOiBGZzscc9Yw/3tLl5iNZNPqe
         Ia4V5bTS2t0bf9NALWYFiQHUkJmF/Sp89XKdE9jRYLuj4ZqN90iETfHi58x+hKgHA6ON
         lVhoCYT3J/Lt2uibVawEesgQzvY1GJRszc7ZSSS6oUjO6+0Ef0uR09yt52g4EhIQ9SFi
         nhsfrODcbmBueC9s7GZOfnGYW3kBecph1mzNObTGZOWVfkczawaVhriTDmkIfRFIWYXw
         1ZiwKHLPDqJ1eabAUMuKSz2iZVDYj7BNEylm/6zGHOXKspMVvLBg61fsoZ/Zd/1iyX6g
         khoQ==
X-Forwarded-Encrypted: i=1; AKwUvBzSVaNkk4y6kAO9CE8yyyiK7r64O0Ycz123WVFx9f3ui6nZQaBRPayfPJQ+sYSGXbhji733JsP1sZNOZJ4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLCm5889wKgCLuEy+6gZWoPb/kCs/eP14s/KZ0fTauB14ooalvH
	bJoGfp7Jfx5KMlfIjxjgaq5sh0vBufWpE/G4/POZaE7BY8GA56cTKiQEIWDMrR9ANfjUav+U4PN
	MzW5TAjEWVYr/BiPYqjmev187SbVwgZyqRPXsJIEV7nY4mx/dXGNji3OWgeDRr64Nxm0=
X-Gm-Gg: AYBFou1THmDvxH75raUlj7oq6hGKbXP4aIiUq6iIa1T3Camr1retxxsyJW7jS7zjvz7
	J+rgirQUEhkOP7m9HtDF8HOny7+5XqYkHROyR+yOfS/cxNgYqINWSHIRzUGJSpcvu48m9uXV7Wu
	vm7gqzT9rYTbBtqtVLidOjHHiiMr3Ujz0tDt6mqyZywykAnImMQX0u0My3gq3qhFdY0hgwtboYo
	v9iUyCB9AqHqobnM0r4XBOphoW83dELlLQekOo4bBmU1OnY5MwWhae93i0KYpPXSwGy4FA0A4ZI
	o3Pk1bArrBLTRGG4rpH+SFyfXR+r+EawiSi5y7STfwa9ZzU7Ec0rhSfex8s8VuraR2yTiz2GrhR
	ary3PGSkXpbDLEJT3L+q79w==
X-Received: by 2002:a05:6820:c3c9:b0:6d8:cdc8:4217 with SMTP id 006d021491bc7-70b889762b0mr1530299eaf.1.1792756960416;
        Fri, 23 Oct 2026 05:02:40 -0700 (PDT)
X-Received: by 2002:a05:6820:c3c9:b0:6d8:cdc8:4217 with SMTP id 006d021491bc7-70b889762b0mr1530261eaf.1.1792756959999;
        Fri, 23 Oct 2026 05:02:39 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46a5c4dcd1sm95221066b.21.2026.10.23.05.02.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2026 05:02:39 -0700 (PDT)
Message-ID: <2876c850-e2d0-4ee4-9d8f-50710c371a49@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 14:02:36 +0200
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
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc: chandana.chiluveru@oss.qualcomm.com, mukesh.savaliya@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20261019-add-tracepoints-for-se-reg-dump-uart-v1-1-1fb47b1605b9@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261019-add-tracepoints-for-se-reg-dump-uart-v1-1-1fb47b1605b9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=V7LoQuni c=1 sm=1 tr=0 ts=6adb4ce1 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=SW_1XP4-vD_1iUIoWgwA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA0NiBTYWx0ZWRfXwlQXqXPgFAE2
 HAh5k4S1blUdNMO55RgfZp3FIU9bC1H3ZCPulIS+VltMcrq6OsLRCYj8XchFr46a0qGjhbOAEAP
 /VA2rR/wyo+QAncURYI8Aj4ttdoG7Gk=
X-Proofpoint-GUID: vjPsj8BbOChIEHFyBug960E3iAbRWvbN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA0NiBTYWx0ZWRfXzHZpFj9HkCeg
 g0jAUvLclfcz5URLOGHQHDlVAh6/a4cqlLycRx6QDMpEykKnyHLiQdElCwVJHdUsAxTin1F5LQ2
 XXRLQwY0U179DnmpM7zP1RVbwKELRrx1wfcoFZGQwsagjZqj+c8oxAJkGI5f1j580c6Z6fSul10
 MPNkH+5S4xXanj0od1SqK4koP0st+IkPirxWNWjGlmhzp3uG6vkphVH4QBorfoxhouU6/FFFk1g
 ME1+xwp7dI5WiEHrwtjtfU9PQ5l15rxeAnh94WCijp3tGLJQ6jEns4dRTGTocbtteHO5yesYqoN
 /kcmADl46UTrE8jCjCGNoT3b/xNelI1lDFLfPe+m6CMJX4Yyy4VPCCei54A/ZszOfl9Ry5Fatv6
 Mnjbsj5AFFMDUChr2FkU/Ob40j9n4WUNAQW9UnA+wLbH8UYHFjJK26HxIXjQIRW5CTYWkw/4R2V
 MNnJXcsxyRuC3JN3yCQ==
X-Proofpoint-ORIG-GUID: vjPsj8BbOChIEHFyBug960E3iAbRWvbN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230046

On 10/19/26 5:32 AM, Praveen Talari wrote:
> The GENI serial driver reports various transfer failures such as
> M_CMD abort/cancel timeouts, DMA TX/RX FSM reset timeouts, RX FIFO
> write errors, illegal command interrupts, and DMA parity errors.
> However, diagnosing the root cause of these failures is difficult as
> the hardware state is not captured when the error occurs.
> 
> Add trace_geni_se_regs() calls at critical serial error handling paths
> to automatically capture GENI serial engine debug registers when
> failures are detected. This includes:
> 
> - M_CMD abort/cancel timeout
> - DMA TX/RX FSM reset timeout
> - Unexpected zero-byte RX DMA completion
> - RX FIFO write error and illegal command interrupt status
> - RX DMA parity error
> 
> Dumping the SE debug registers at the time of failure provides
> additional hardware context and significantly improves post-mortem
> analysis of serial transfer issues without affecting normal
> operation.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---

The commit message should mention the additional logging changes
too

[...]

> -	if (WARN_ON(m_irq_status & M_ILLEGAL_CMD_EN))
> +	if (m_irq_status & M_ILLEGAL_CMD_EN) {

if (WARN_ON(m_irq...))

Konrad

> +		trace_geni_se_regs(&port->se);
> +		WARN_ON(1);
>  		goto handle_rx;
> +	}
>  
>  	if (dma) {
>  		if (dma_tx_status & TX_DMA_DONE) {
> @@ -1270,6 +1285,7 @@ static irqreturn_t qcom_geni_serial_isr(int isr, void *dev)
>  			if (dma_rx_status & RX_DMA_PARITY_ERR) {
>  				uport->icount.parity++;
>  				drop_rx = true;
> +				trace_geni_se_regs(&port->se);
>  			}
>  
>  			if (dma_rx_status & RX_DMA_BREAK)
> 
> ---
> base-commit: 2efb7a11f1aa4d2dc285fe2680cca22cb9f72f64
> change-id: 20260927-add-tracepoints-for-se-reg-dump-uart-30d93639447a
> 
> Best regards,
> --  
> Praveen Talari <praveen.talari@oss.qualcomm.com>
