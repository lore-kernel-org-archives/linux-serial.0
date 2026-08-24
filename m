Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC2F4078E9
	for <linux-serial@vger.kernel.org>; Mon, 24 Aug 2026 11:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787569668; cv=none; b=jj71P6De6eV9zoFwMnCdrLv36TqN6VTKvfBHgIwzanRvKz+pqXsg73sAiAW6HqnP25Cke6XILEbFdhJ1l1a5DwEAYdDdAuS+A6EDtHqv3qs6MXgMLuk+n2xyrEotQjB82L+NrhJqRrfqUVf8Eo2bEyvA4aXIzeWoo9FlyxZNHSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787569668; c=relaxed/simple;
	bh=OSns+uTIs22s3YlcDW6QPFVIFw1QF1ErNeeSa5lcm1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dOTLilTPvPUi1QHXmdL42arXGH++bNhfOR5eTwUGNilbrW9OweVmzjFgq7hvS7jkdvQcT4cMlq5KKulFT6tZCyVEKtfxcbd+UjOC/fsqRECtWgyDtXikwW8XFz+3kD/M1vJ4LMS0elZ4ZhSRiD4J0SCChC+hApNwKJlxtYk7XQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ojum985C; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LBYo7+e1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ojum985C";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LBYo7+e1"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67O992n61377917
	for <linux-serial@vger.kernel.org>; Mon, 24 Aug 2026 11:07:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jRpGpu4L7njGKrZAm4LPVjfYmC7MPX8emmTGwksOl+Y=; b=ojum985CHaucqlo3
	csKOLbyg3UklvxJSS2AUhhWHKKTk5umUiaArXncU5E6Wd5hyUg88tL+lWSoj8Eyn
	KcqqBo8LpnUOqOmCWH3sBqvhX0zNZhR/Oum1DDFtstGKJWoD+UiluJzPf/jjB0PP
	BvTNqvFhGBhK2xszeFaqu/hJcplAyVt3VqRNKNE/xR6OfL0+ogwFjGretAJVRvOW
	wrf6sNoQxW2tF467JKk+uR/y7ArtojnURrqSigiDroxhv2eQNjATjdyC3YlJ3OX6
	/WFrN99pfWYB6NL9JOLHfHhWtc6xrZTcd0qtc6DtkiczJuBb/z363+ITm13aIhq+
	nNROAg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8huf0van-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Mon, 24 Aug 2026 11:07:46 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8487ed7f7beso3320958b3a.0
        for <linux-serial@vger.kernel.org>; Mon, 24 Aug 2026 04:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787569665; x=1788174465; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jRpGpu4L7njGKrZAm4LPVjfYmC7MPX8emmTGwksOl+Y=;
        b=LBYo7+e1T/JwmD5drW1ExyMgUi6lpbBe/wlQkTsa3qipx4Z5VU76BIAZwb0Js3tjIO
         nmIEQ9QiujweRPFlfnliOg/GZE8EqbTB5UGS11FfKca0QFSK9uTh1XSZnrutjq7IbYU6
         Elem6DMz8uQWRWpmiusBCM9EyTUMLzLI8eIUliR3cmm4Oi+xkZoV1KzGP7ADDcm6SAkn
         26uGD1wV5bPn4jbKw0k8lwfi/ydpiJkHcTOEcEvcB7Stf6bM0fBp+NRItXJD0Vt8CmM8
         2lVgwdFPWrshci5My0eGGIZLv0+qxVO6p+VwClROJz9HIzdYXBabW93+/1iKT1P1v1YD
         B/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787569665; x=1788174465;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jRpGpu4L7njGKrZAm4LPVjfYmC7MPX8emmTGwksOl+Y=;
        b=N7+UeS4/I7UJacJCYu6mbWftCv1YhxldyXJYzfqe8EbJYoFrBF/SfZMN62wrO6iQSK
         kBsREyIvlH+3uGG/sdOqeiEnabYp8R+mZIp+k7YVsX6ukVx2+gS5UQjjBTwKu4/lWI2B
         dXA5gW+u6vcMMY4f2Q1w0+228J1Yx1hJLvvHSrG+5LGf1dkLrdjPz3QnsKQY1frl1wBT
         S66Jl1dm+F7SDDz/n5ji+QCULbUiAKd9fOe1n19+BVUVrE7UFQRIPn+xgAIqHXvviuu8
         EihhjUDPTqdI7NK6eUnxXZafjPJ0fjb474pwhz8A5XRhfKkJVCrd/EtWD6/6pKSxmhaW
         JBPA==
X-Forwarded-Encrypted: i=1; AHgh+RopJ9sq/TivlV8pobaO+BDiGrTVH5fM+HvNhCjb3Jp3CcgXeOmJfNPfhD4siZbh7mQDEMLQH75/a77x5Rw=@vger.kernel.org
X-Gm-Message-State: AFuF++mCSAn5Ooi6L8qhcISpllUgsKHZK1sQgyewhmMLI4waQgT7I1GF
	zNgeooiAt/IeP9eB7WakLdBB4LwQyqqXCvguc+nEjsto1lTzvzqwWFU0fi99KyU1GoDBAtEnqTm
	q3YL2RerMF5x8WJ7VB2l9rmrkqyfVCPizcoQnVQ94hOyWvYIDLZ3AiVQuY+yrzUzb4dA=
X-Gm-Gg: AR+sD12QQIkfXcsI7Tad1gGmSwhvxnpakDaptDnn6DtOw6k9YO+haSIi5lGiEAeIgKV
	xVUPFjkqqTYRsluDRbvPkCTiB4Nj47fbb9gjcAmsecMDOKNfN8AUuyAed1ZknGFGCxuXq4+2DY7
	kbo78atrS9THsiRrzSM3pnYQ1KwtcZ/j8j1uPdOKCus1KF9rer6/O4366HIAXrHRyHnr3yXC5Qx
	YBlr/qBXHuTUVknHRTghp3G4xUH4J2Jr47vLbBof9AKW2Tsd7mMwiAuBSAmDoRiBgCx9dJtH6kw
	ds08sKb7sEPtYAm+JncPV30mS7vAd2iYCYvA3n4/O1/mOTwHoBCnqr/nf1Kry9nfvz8RnaWubXG
	YCKsHzJe/ky4PZT+kIA+u/fSQeFNNDrSNadE=
X-Received: by 2002:a05:6a00:4145:b0:847:9315:fb8b with SMTP id d2e1a72fcca58-851f9a9f0bamr43921527b3a.6.1787569665320;
        Mon, 24 Aug 2026 04:07:45 -0700 (PDT)
X-Received: by 2002:a05:6a00:4145:b0:847:9315:fb8b with SMTP id d2e1a72fcca58-851f9a9f0bamr43921428b3a.6.1787569664916;
        Mon, 24 Aug 2026 04:07:44 -0700 (PDT)
Received: from [10.217.218.158] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8520eed88f8sm1864508b3a.10.2026.08.24.04.07.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 04:07:44 -0700 (PDT)
Message-ID: <a165c890-16d6-4d64-ba59-fe14435e0a7e@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 16:37:37 +0530
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] soc: qcom: geni-se: Add helper to set SE clock rate
 via OPP
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
References: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-0-61171ab1cdce@oss.qualcomm.com>
 <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-3-61171ab1cdce@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-3-61171ab1cdce@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA5MyBTYWx0ZWRfX4IrY/GObjtoi
 tDtCbD+ATuVtZUmO+HzKJhrfeUwBJtvLl6dnby2vIO9lrarhL/wnABZpB4g9jGqGisxR81jfyde
 YxRJbEZYoxD7PSuxzLNyhlqKpCpeDUY=
X-Authority-Analysis: v=2.4 cv=Wac8rUhX c=1 sm=1 tr=0 ts=6a8c2602 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=9aiwZt7zaXvVnErAyWsA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: 60sfgkUf-yY7TEmqedDWnuwHEWPTDQoH
X-Proofpoint-GUID: 60sfgkUf-yY7TEmqedDWnuwHEWPTDQoH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA5MyBTYWx0ZWRfX3oJvfGa96G3t
 fEIM+GZkVzZ/OzhlSR9+6FCujUY2s3evZ21Xj4+D0m1yfjSOCvW9Um3olNUWKghZxdJ+Wfc1p7Z
 BzGJ0MkGmMtpY0O854gxy9HoRX38h3tShGbR01GpmiBB5Ili/QyelP5DNv5sGbSN5vqDQ+uLAog
 3trjV8luSA18cZ7nw229KA3ymP1cKxdW2ETlOrfO3/vTiibPcCaAAkKe6Elvs7GQy2MdRuqFkrn
 +3BSENT11/9p9k8cIrfl4mFngBr1zT+ORYdZXFfSQKuGEz2/tok3jvZKM+872zc4PERDmAyM0DZ
 B33s9itoTJIM/7wEYBnNIcAgLFFjYJmkmeAM8LGPlR3occY7Sx2FvrT1z8qIKSqKc3abNChDf4K
 qTM+j7O+qK7D6OubHm8OPuyrzpQhAWvOU9f8rgkEYAKRGrH8LMexM0BVR8LsVjMrGIaqI6qX5VS
 8D0orVPq9/sORq7zEcQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240093



On 8/5/2026 1:27 AM, Praveen Talari wrote:
> GENI protocol drivers need a common way to scale the SE source clock
> through the OPP framework. However, the device that owns the OPP table
> differs depending on how the SE resources are managed. For Linux clock
> managed platforms, the OPP table is associated with the SE device,
> whereas on firmware-managed platforms it is associated with the
> performance power-domain device. This requires protocol drivers to be
> aware of the underlying resource management model when requesting
> frequency changes.
> 
> Introduce geni_se_set_rate(), a common helper that abstracts this
> difference and applies the requested frequency through the appropriate
> device. The helper automatically selects the performance-domain device
> when power domains are attached and falls back to the SE device
> otherwise.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---
Acked-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
