Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EE63E5580
	for <linux-serial@vger.kernel.org>; Mon, 31 Aug 2026 11:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788176319; cv=none; b=m4azhRC9sVH56KISYEaRig8L3Yg1vOfeHaSuACsNNJq5sBEEKD27Cd0nxQzPdrvhRrDtlmOd70Rmqv309Px4yFPeCIivxgJXkafsa38NYvduI0EQ7W33bu6mo4r3JMPJTOfGANtmuLOM5r0pxvsfbhgtkxSPvm4UJqMxqYrZ1Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788176319; c=relaxed/simple;
	bh=bI6pqxmvXsoz1GpoGopgL4gc7IEL9Fvc8zk5dX4p0o4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YF/8tTJXlXA63AY7TvL4edDDinXbvCy5HedYCfcfs5fHVH2Pf1YhYeGOUSMimrcAjSO3o2+1pVBM5JVkmTH6BadZhYUjXslpLhP8NGtCPUXbAJdkXxW1etdfcp7AJm/e763dDZlRQBgkw2tKTx+rrg6uLlRRhX+RUyfX4qDipc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ipr/5N7S; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gmDNU1SJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ipr/5N7S";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gmDNU1SJ"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VBAVVC3358403
	for <linux-serial@vger.kernel.org>; Mon, 31 Aug 2026 11:38:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jsPV/3bKARA8qESe4FwN4opNWzg76gRAUiSgjeBLCOI=; b=Ipr/5N7S7NeaU8Qo
	e8vKAlwZcHYLgeIuop9bTGgmfOIUC3IOGUFzvYMQb+vmlAxt6RXmZamrx0BlFE24
	KtwxYSTKdZK1R8G2N1zZZxwrYoJ2oPO6L0YiMqxxhEhoxiC5/Xfd6b9FPLxOdoAo
	gjjaKxdYrk0z/+Xe+Y/E6BznC4L6zmqnxvLCcNpMBIcj5eEUYOwospceaNcajcsD
	J14PwCw6eQEsqT5JCSuI9UXWpyRFsZdiLRHZUU0b5dBblw4oaDdwohNyvIK17CFe
	Y3udyAsQBHOWmOrVhOFP05IUv7oZSu9iFArB/ZNpC8JKpoT0v02i48+DR9+M8k38
	Iv1aiQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gcv7waeme-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Mon, 31 Aug 2026 11:38:36 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-9310484c005so49771885a.3
        for <linux-serial@vger.kernel.org>; Mon, 31 Aug 2026 04:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788176316; x=1788781116; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jsPV/3bKARA8qESe4FwN4opNWzg76gRAUiSgjeBLCOI=;
        b=gmDNU1SJ0vic7EKl6v8qK84nrRNv66kQyw1zXCQzMnaz823SALVxZLkpub0o6tj6VT
         MO8jr56ogxBlmI/HTR+jB+mMT+oE0hS/ZryKhswpsTBX1/M6TdlioXyZLjfeE4BPcDf/
         5oYPIo9Ui9pdPuy7BPEdv9ANuhHrkCY3feg+a2IFacUF6l5aXPo1TU/Ojcbx69OGEvIK
         MbDYQojQ+HKOPc7dPVnOp7XLWnxkD5s2x3puH4dwD4nZzDmMaaBdVYDptAVeych2TwZn
         /ExD3tCCzWcVj1shv1svutQ7b8xDhskn29TT8p9sA49jGy5Ayuc/03TtNV1SxKXTCo/L
         qZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788176316; x=1788781116;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jsPV/3bKARA8qESe4FwN4opNWzg76gRAUiSgjeBLCOI=;
        b=Egt4t37Fe2DRXROXg2aTpIgFBu5kK0+1PzDL2frCrEi6aVGM/rRyPy8D1iQNomkvSL
         pHaknaybIpbPZw2XqUIXuLxNbhT6dLfdWs7k9wBWa/CiGCsRF1jgjVhU64tCx9dBTZuA
         7j0Z1vtv89KJs4hVMtoKpaf0a0h1jVx1wGLDWGcMupZduzOzT0IygzTWOYFFGn7WexzR
         qevWmQfeuEsoMb8iYdCgui6yzfRzdNNBoq1XWyjT2E2z9ExGr1EIW58qj38EPz0tvzkC
         Sk+7vnv/IhepbEIxtuJNJ0FqJ78qDm4kHo31aFcwgeUCHLKQUY/BdDQVfxt4FHsfJqcQ
         S27g==
X-Forwarded-Encrypted: i=1; AHgh+Rq+0uAqxoMKRSoLWYlnOw4Ck7ALxzjUEhULkaatupRUnbz0F8LmNsqZIKq2JA339qZqcj+kPBuYy9Uxlk4=@vger.kernel.org
X-Gm-Message-State: AFuF++kjS7nE+Sl/iDH7PZZDNXhRhavWFjDihrM7BGs2sDPnBfwRwfu4
	+KIzUx8eR2Qnavv+87o2cM6VlqX73gBHnNVpxaA8hOPK4qMcuRaoZMU1JolWnbFtWIkxM4OrDez
	uztkzBPvy6ENogCd8rIEFXOvHeAK1B5ANLORo6tGvyneMySR6d+t6hJr0sp9uZGNYtE0=
X-Gm-Gg: AR+sD12K8DEkXbv6iHa4kR3M157mfkCtoOhhXSG5ede+0Pw+iislSVhpMnIxrNzWJig
	lC15tmrMvjWcK9x2vDqoyP7wzvnEDUV47yoDjiXLs3DOs9oi72TeLOQvbN2cpZwyZa3m2KzQfoZ
	VNRzRpz0WZxc0RKRiJiQsMAiCDavDWfHSANSBOf7SNDtpj81rCmC+s/SRM2YDbnlRQd8l9HDUaM
	EQ6wgVv8rdgrU1ejkNwyt3TCQ5JsNijGPpdGGpf7Ui4mjZA0u/SnDSY+At7KakzKB7VaHmJLAsv
	fXSXu1m1MzgdBo1+Ufb3Ujz+3er2LiSJX+AeSnb3e1UCQUQwFGY2RayEFgEbhGMK5spYgoKy+20
	Z9UUqUneTMyAoE7BC1PD00w==
X-Received: by 2002:a05:620a:3183:b0:939:2880:21e6 with SMTP id af79cd13be357-93928802232mr860870985a.5.1788176315781;
        Mon, 31 Aug 2026 04:38:35 -0700 (PDT)
X-Received: by 2002:a05:620a:3183:b0:939:2880:21e6 with SMTP id af79cd13be357-93928802232mr860867385a.5.1788176315284;
        Mon, 31 Aug 2026 04:38:35 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25ab254f49sm57028066b.10.2026.08.31.04.38.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 04:38:34 -0700 (PDT)
Message-ID: <5bb31efb-3855-41e7-b011-1a5a94fee59f@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 13:38:32 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] serial: qcom-geni: Fix port_ida handling for console
 and probe errors
To: Aniket Randive <aniket.randive@oss.qualcomm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20260831-master-v2-1-0032ec7fd1ca@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260831-master-v2-1-0032ec7fd1ca@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=E9f9Y6dl c=1 sm=1 tr=0 ts=6a9567bc cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=SusbOXjRFks2-79YJ0gA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEwMCBTYWx0ZWRfX/v+1ermJe+HZ
 N+rPiq9p2IC8dfrFrO5EBSTQRGKW3pr6JvMeTkUjlQD/bsFDCrBLby4Gqa3vRa4ng4qf5mCHpUf
 0mIZAicCmMA1QZVlRgyHex6qGk3pAQM=
X-Proofpoint-ORIG-GUID: 2ezMoHv3UaQ94c5VNgrDHMWLsEAkiQEP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEwMCBTYWx0ZWRfX6zXN4ZEfGg5z
 7qi5KXK7ltigN0DEWBwNAjlRrnL4jQXB8ihdbg5FzJLQeJtbTlXouHx5NXhf7FMFmPSDPPbOBAr
 RaqwajowSp3qVrTSSNvYcYINFC1DNA/DpRl+OD8tVxJJeBCVFQWla0Mj36R3EvZ1efdTf5OxC6Q
 ue0kKgtlItyOX3V+7z2aLqcGplU7dnz0DPAeiAJNxMemGMqfuOQzBAZXn388bmshLYWVpE+NZDT
 Rjek4QGSGJNcVk3CEQYjv6UFaziY6+UqdEp+A4HaePb8R/ei/Ea1/qGg3b6rH2a9Cme4mcSXRJ1
 BR6FiQBHwyYgvFhM2U1ChJDikxlC9Hspa6WdUCUWjmRmqE6y4lnT8pME1NNDxDndoJNg/1TP/NR
 u/z6jNTGSx9qEAVUayPx4dOLhWf51cb8kWyerHYGddmbyMyF4YBk1cPFrI3G6+Q7SsSrEVIXLzk
 bJy3AAy1LXoLtGlsHBQ==
X-Proofpoint-GUID: 2ezMoHv3UaQ94c5VNgrDHMWLsEAkiQEP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310100

On 8/31/26 1:12 PM, Aniket Randive wrote:
> The console port uses a fixed line number and is not allocated from
> port_ida. However, qcom_geni_serial_remove() unconditionally frees the
> line number for all ports, including the console port.
> 
> Skip ida_free() for console ports so that only IDs allocated from
> port_ida are returned.
> 
> Also release allocated IDs from the common probe error path. Currently,
> IDs are freed only on the wake-IRQ failure path, causing leaks when
> probe fails after a successful allocation. Move the ida_free() call to
> the common error path and guard it for console ports.
> 
> Route resources_init() failures through the common error path so the
> allocated line number is released correctly.
> 
> Allocate the port structure before calling ida_alloc_range() in
> get_port_from_line(). This prevents IDs from being left allocated when
> memory allocation fails.
> 
> Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>
> ---
> Changes in v2:
> - Route port->dev_data->resources_init() failures through the common
> error path so allocated line numbers are not leaked.

I asked GPT what it thinks again and this time it found that this
will cause a double calling of dev_pm_domain_detach_list(), which
will mess up the refcounting..

I think the fix here is to drop the manual detaches since the common
helper uses a devres-managed version of attach.

Konrad
