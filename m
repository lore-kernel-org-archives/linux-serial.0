Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4BA47C107
	for <linux-serial@vger.kernel.org>; Fri,  9 Oct 2026 07:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791531158; cv=none; b=HxDndrfRia+Zm2zNz62IbOaneWWPAMgmMW/WETaVx5fsWPFqcsq/5VeF9chOWGoO/Jd9E/WgA6BwLa8TSYOmvoD8sgEjWTjw7RTPsvZQhhfgomHtwxM+XLFDi/V42+GiV5lycgm0a3+iBV0keDs9DNk1p7iyE7ey4dH38tbpDcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791531158; c=relaxed/simple;
	bh=uG2fvXOs8Q8N146YBhJ9OV5ZwJMu4rQIyRcslPNQR1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WOX4/xrlhf6ykYbRSsIJgwRMJfB4Pw78OpTcpwZVgw+I0V5u8SY8YT22BtqhCks0akZKALOQiukayyui+RecezPAjFeeNg9xv35xb2ArKcWH814bOwdO6Y3C/Eq1ckGTnrXqpe0/LMuu93j7QMKs8sh8COgqgzW7/z1m7oS6Bu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bNgIieMR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Wpth8HUx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bNgIieMR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Wpth8HUx"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6993HL2q4178487
	for <linux-serial@vger.kernel.org>; Fri, 9 Oct 2026 07:32:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	z6HnU0h/lQqsemsQrOUQLb2l3ikDGLSW9b4T05Vtskc=; b=bNgIieMR3fi4+lYi
	Zx5jKmnTvCcSO+VtGCiAvJeLaHv3Wesg5+QCK59mAi3P5jUdt5QZqqaypdKrdCcP
	FQzqIMsmc9qs/4x91JOCG+GxNn+pkIUh3EqZq7IZ6jGsFgUhhkiQDWGQz9dSnw9X
	a1nrnHBVaB6ZERt9g/Dixql6A2n9bbYxTJ/UrqFyD7DpL9ACzbuOlchbDsqKJ3Oe
	4avbPBaurH2bSxDrt+lcjIKi0kUvjKk6qAaQ64G2sPQfCb9J042iU2aAsE9UQ005
	nO5JP8U+AjOBJyPHR0Wd9W1GihBdJtA4SB61J1vXNoz5CgOYhk6TKRoGUvHAqV3V
	GN5yBg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fxrtg7v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Fri, 09 Oct 2026 07:32:36 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38f97b3f853so8097906a91.3
        for <linux-serial@vger.kernel.org>; Fri, 09 Oct 2026 00:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791531156; x=1792135956; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z6HnU0h/lQqsemsQrOUQLb2l3ikDGLSW9b4T05Vtskc=;
        b=Wpth8HUx+9H6jxSoOOJ8+zzcHsUKDPyNElMu3+l8cuqCQ+fpuBI6dNsM5VOQ1zLKwY
         MsKm9fWjvvZUUf8X4j2dewrSsUwf6Edvhqhb22czagvYAxFmykoAueAT8NKzGkBw3yl2
         yhorK7BcaBVwQt034JWtJLhuOQ4SUnJu6RldoZ+1VeSFaBpmT+CCe/UrbwziMb1wS4zr
         +lnawecHE4rqwSQxEgcavzeFY5Q0NGaGBpKbE8mLL0czb2Mw+mlLaNfI+6x4zyJqUGir
         oDyFssSrIepEJfZdDFLLewPMCp5mVJLxdtU5WOGQShh34gPsR/sAVby0Ily2zOFEpCaF
         1Pdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791531156; x=1792135956;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z6HnU0h/lQqsemsQrOUQLb2l3ikDGLSW9b4T05Vtskc=;
        b=Jvxeb9NbdZuB0qLx1I7zaGOgGAy/YlFV65tWqd/EuZEAf2Fr1cenXxLwaSyTlB2yLG
         50f4i2CHFvcTG0BG9d7xg/nl0dzaKT9VjrAn+jXFH49uVs9BRUJMCI39eOUkqYN/pmzt
         G3X9mlcokeYPU8TFgLTFaiSx35hDGHxo7hUVlfp+ndfz5P4UrkiqrzWRTGeNJBuG7duW
         6Gw9+mLwjPhAnfTXMpJNmOJg7GThIh87BqtQIrzZ87mtgRdlgGv3v89iQCLA4/3H3cNk
         8HTjNpGLG59SXnG9KVYHjVADvBH2xIjnfxzqfKQF6m/z/rgyTWmprWp5Y8oktQmcnIcB
         uArw==
X-Forwarded-Encrypted: i=1; AKwUvBxOoRJXxM7q1xuYB6x4nOHGY+3GX/KX2p9Y+uEJGpLoCJUU/C48l1H/MIPgdRVrt1DImxTgYdZakrze3no=@vger.kernel.org
X-Gm-Message-State: AFq9FYLnn/wAyD9060ZIVHGQIP/wedkTa2NLPIqws9Rr8m+onCLkD+PK
	tqOeg8WAEvjtku46vRBhUaBd6crnnCXVBjChn4je4WzUZ2BtdsQL4Zf+hI9fPMjdTsbKkb6s1qI
	qqzuxxXAgU3cti7Ubhy1tMs0XLgGu9Yk115IGxt/ro4VQwBeIQWJR24NLygElXNZkjhg=
X-Gm-Gg: AYBFou0sPLBkv7YFk4Slwn0rrfv+P7LU5tdjjpSk0sWcna5mZZxhJNW6nCKsOk2k3Tw
	Eip+fEtVA+NVTF1VAJBlGPK+26dqms3l0BTksrsdAiQBlz894XclpQsDLyZ/vEX3KTtPAge9H0J
	7jzsnNsGunKu8VkrVzaLtIYUDbxO9ouTGADvKTGeRVdafmSGzyMPZWX/PgIFqUxaCgKTHb/NX1S
	4BvEN98DXE5qqm8spmI8de03uHez2DIxbWlBBSNhPnoBw66czQVa1+gwNTBopAMi+q30jIFXzYN
	n6KO8vt9QrtkJZ6OqM5vogPTfaTT3zYBR8lia4CWnP8Hop7ucVq27bGbpTqoDho+mDmRsggfgvG
	1iI/mhvoiXIy3bv80KLi9xVvFVItk1KSl
X-Received: by 2002:a17:90b:268f:b0:3a8:59d3:5317 with SMTP id 98e67ed59e1d1-3ab3a778a55mr1089548a91.32.1791531156175;
        Fri, 09 Oct 2026 00:32:36 -0700 (PDT)
X-Received: by 2002:a17:90b:268f:b0:3a8:59d3:5317 with SMTP id 98e67ed59e1d1-3ab3a778a55mr1089530a91.32.1791531155710;
        Fri, 09 Oct 2026 00:32:35 -0700 (PDT)
Received: from [10.217.219.98] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab32c0f59bsm1435629a91.0.2026.10.09.00.32.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2026 00:32:34 -0700 (PDT)
Message-ID: <778f15ef-5052-479a-9b45-bc3821b205ae@oss.qualcomm.com>
Date: Fri, 9 Oct 2026 13:02:25 +0530
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] i2c: qcom-geni: Use common GENI resource
 initialization helper
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        konrad.dybcio@oss.qualcomm.com, Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: chandana.chiluveru@oss.qualcomm.com, arm-scmi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com>
 <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-8-091697dbeb02@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-8-091697dbeb02@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=E+1YNqdl c=1 sm=1 tr=0 ts=6ac89894 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=hk0YJ0Y5ifG0NBj8Rn8A:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: jgqDlks9C-lkwMxRoRJslHvbqrCHG40P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAyOSBTYWx0ZWRfXxxRFP7mjVTZ+
 4/urYv2jB4FWL7PaSuysjxBtr6bMTkrxnqrJio+hiMUdzOgz47mgtg69RKz5+F3kxlt4zE38uh9
 UeyTcrHZMNWbquMyvtMk7ty8dUsH8YCRbRKxjZLohW55QiqvxutMI9/p0cB9UbJOBJBfXdhy/qx
 3/rbyfOiv+3tUYsm9vCdWu1sak7JpDR7F/YCDH2/FyPu/Ub0ewUcPSsJtXzBHbaTjaMQJDue4Q3
 6c8ar1Smx27WmicX815a0SlJkGNEbz9X+IVZR8x8RQ6kDQCMHhttCaD4xBQJVrQYM5WltKPnkgZ
 /U5e8IK2/CJkCum7ta9YQ0Qr9KaOaOASawluUjro2uKmSQXXt6R0adjmkBVQjBj8o9CoLCS0fSb
 VlZC804SpFezP4eXqg7afg+qezk8WWiwYrR+BXzWUqGn24dVAa2k88qgQS9MF8lLRZuYU9rRjOk
 YkKk5+e0DIBy4mE1waw==
X-Proofpoint-ORIG-GUID: jgqDlks9C-lkwMxRoRJslHvbqrCHG40P
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAyOSBTYWx0ZWRfX04NHrggpdk8j
 Srf7vZUTpg4FcElFWlmfqBWzGwCRd9yUqEQZNuZDGlUgHwbgHDioMmFvrLSWygjhzDfehUZwYB8
 QHb4yNLH4aV+u67s5+wLis2rqloLmF8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_02,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090029



On 8/27/2026 11:29 PM, Praveen Talari wrote:
> The driver implements a custom resources_init() callback for clock
> frequency validation and bandwidth vote programming. Neither operation is
> required for resource initialization itself.
> 
> Move clock frequency validation to probe and program the ICC bandwidth vote
> from qcom_geni_i2c_conf(), where the bus frequency is configured. This
> allows the driver to use geni_se_resources_init() directly and removes the
> I2C-specific resource initialization wrapper.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---
Reviewed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
