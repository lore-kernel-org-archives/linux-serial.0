Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792672093;
	b=3Zuto78a2fmLKfu367xhNGHSfAyhuSpLbeaq8KJBbOhfGdKvwOOe0FGiSNeXIC/R7JGb
	 GLLb5HOxlPoh61JAbPqA5pRXhgoWL+xDGu4r/+Dkp4N5sZIcKyzS2feD9pcEPHxUJ4d1i
	 aiyL8HXY207cgpR3yMJHyrrgrJMzOtxLzCFUBJY32LyrsAQz7fegTA94c4b1CYQKGk00Q
	 Go15F7/Ri7uCd2mzqaoFnzLI9bXgszk9OzJIxL2IGEEiEoQO325iUgB8Wr7MjrT41A95P
	 vbBMHOo7w1yGJ5clu7YtELIBM1oHE7JbS7HRHfQsX3QkCMzE3HvXrKMswNlbo1oSGyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792672093;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=ffhVe/j6yRlCzr2Q00fG+yNfZLrhxessWH3dfhlXdzY=;
	b=WMm9XkL1J/+JdnGuWkdipcwCZ6h2U6eSw62ZbAGUJzNBecmb+oAI/TZZSeqGa8wE/DOo
	 ONlRKyCvrEAbNUHsUEY7vbSQBtVxEl7ROO7X1v5+H2mbJZkWuM4kV11UuY8w0fDNcGyHP
	 fn8H5+AA8QOeF6a5AlAtbaQTQNqLWBHF4UFTylcFJSrPACp9hHzspOfWR/XSynCLH4FJY
	 uch2YP6DH40tbXmOLa65DXcL25vrncv0QHm6tRzvx8M1/48Ho63k9SbNEMfFY5jcHVrI5
	 6hn7DK6wCpXNMGYtkO4ySaOtPkhU11gQJiBqz+kXBv3QPn5oz+EU6HmS/3aNZrfuLAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Qk7LeKmg;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="YDDvB//5";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7ED606A322
	for <linux-serial@vger.kernel.org>; Thu, 22 Oct 2026 12:28:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD7ED606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Qk7LeKmg;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YDDvB//5
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69M9xwU53478867
	for <linux-serial@vger.kernel.org>; Thu, 22 Oct 2026 12:28:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ffhVe/j6yRlCzr2Q00fG+yNfZLrhxessWH3dfhlXdzY=; b=Qk7LeKmgKfl8ASss
	r/S31nkFb5YhbcmUSm5td/BECe5v1/SgAUKL+3yoqW/lRibA20tcdz8GOCTejfBg
	SJnhc6mDE3oLYQ7nfvuFZ8AOxYLsPwr0r1E38ln8TXP18dG+8EWHGPBJlKfBr3fE
	VcGF4BIJOrqH5FDylxqT4Lq/KDCj1IJpqJhG5yfK7/MIdqpE/fgqBrq9Q/nILTw1
	IzY44rprRytmIoIGq05urfI+V3wtpeFQtS4HFrD3I/HhyzSUlG0u+Vhxnhui2rLv
	qbPfovCQT1cJYHYgXzKW0O4anTJTXMj/jGOLvJ/icvRKkqNw4umV6qAIrYgHlM58
	W+/f+w==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93a38ut-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Thu, 22 Oct 2026 12:28:11 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-82322894f5aso1222992a34.1
        for <linux-serial@vger.kernel.org>; Thu, 22 Oct 2026 05:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792672091; x=1793276891; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ffhVe/j6yRlCzr2Q00fG+yNfZLrhxessWH3dfhlXdzY=;
        b=YDDvB//5wUrrsMjA+YOjITn6gFH07RI8ByXRGm5tbEi/x3FTKojCVivuRWJ8C5RsGE
         hpAN++kQIO2OzyiQI61LcvkrklJLzwQhpZe0FPXz+0w977W+VaOzM0xrifW2TDcLrySu
         ntOAlduDV/IVdjKapF8Sr0LDsRgzDICMUTekO0VJsHXE2UjAySxZ6INfhIbHZwZsf/y9
         otgi6zR74w7vRYgkYAy4l2d3R4CCVY9tNUrFutkieB20d0VTUXkEcX85/XMgBYH/YwCi
         7ePqJ+8bn2e1Jp2AVdwBRmo2ZNnqF/m/kfZDxOIoGZ6cgr79hzVrAZCvEoZwSqBKuQnl
         Dt6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792672091; x=1793276891;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ffhVe/j6yRlCzr2Q00fG+yNfZLrhxessWH3dfhlXdzY=;
        b=Qcr+oufDehiRACgF6EbxoNahF9yjVbRUXPWRMEOA0IZSTOAeECtFBG6QXMH+ijJxws
         qf6c1O2FSLfMROXw0pge3kl25SywjMQwt5zQPna9mk2ZABxU6SVQKcX5/gMfpYez4gkX
         d1cufqeItCsdNHGZY2jp1qqCRW6/9HfDLVI6Umz15/Ib+Zt53i0RmksAzhyhIFT0T1up
         F2BJ6O7gEJ6ykl8tRawzDpLsp3QVif4Ny4wcMPT/46pceFrsmbJ7tKmCaGrLNTH6abaH
         vKinnD5pQzoLKF2/1kqqnoPxW09W+GaX5DO5tWlp0aEEy14duV2SybIZK2tCFyv1Nk18
         fveg==
X-Forwarded-Encrypted: i=1; AKwUvBxeiVHQ1GxvuzQkLkEsByhyBZHF0rWgTKXrCrum421k8A9dwzGIprY5SYPyN0/7pWcLlwKZ4h7BUOXmXwI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ6y6qpVWScI8VsrsC9UmLMJxJZKNyudWpgQyFJl/JMmls71UqT
	BVIsDpsZdoTUhQuTf8sYxW0ZlBTnDiPD81EZf8Lu1EV25sQF2hRVig2wX+73X9kJqluCpqNOOG9
	u9fTUUBkMC9AJVjt/2OTUBAc64yYZY5eJT2pOnzLdqmRO2oGh+zkRhGxMZrg2B4Ek1Xo=
X-Gm-Gg: AYBFou0nJO2S2YUnNWlM0Y5UVIab7brhbzMgVuO3GJb249z7etWcwsOmDh64EzmonRK
	TOiZ8P21VpErAFGQMtMaxU2evdTUxoININFscYVz5/jbSG8+GnB+WpoUPh28GROp3ngDO8lZEio
	KjI/t23QR2xRnpp2S3FmfJ54fQtV1Qxs1wwKklDIGiQNpkz39RUx0zk+WGaJkO/wNnQ8L/sEwM7
	XdVuTKV25BPAYb2HNR8lGG8iiqEJxfr6/gATzrFsP/TqXBaxSF1StcfvXo1IAP6NxXh0ID71lqL
	rkwY4p1rGLXlHUyV2yap31ceebgsriGzzBVVmLhaxQhpOeursauXQOY6r/wjL4NWvUFdc814gxo
	+zXTtL3yC4bMaFyI4OgbGIpkE1MJLNCjK
X-Received: by 2002:a05:6830:6f88:b0:7f9:555:1def with SMTP id 46e09a7af769-84e30c31e32mr1258629a34.11.1792672091192;
        Thu, 22 Oct 2026 05:28:11 -0700 (PDT)
X-Received: by 2002:a05:6830:6f88:b0:7f9:555:1def with SMTP id 46e09a7af769-84e30c31e32mr1258609a34.11.1792672090792;
        Thu, 22 Oct 2026 05:28:10 -0700 (PDT)
Received: from [10.217.219.98] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-84cbcdd9d82sm4892517a34.10.2026.10.22.05.28.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 05:28:10 -0700 (PDT)
Message-ID: <d6a3a783-c6ec-4f93-83ee-ce30848917d0@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 17:58:00 +0530
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
Subject: Re: [PATCH v3 6/8] i2c: qcom-geni: Vote for SE clock rate using OPP
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
References: <20261015-derive_clk_perf_tbl_from_perf_domain_opp_table-v3-0-5da1096243c9@oss.qualcomm.com>
 <20261015-derive_clk_perf_tbl_from_perf_domain_opp_table-v3-6-5da1096243c9@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20261015-derive_clk_perf_tbl_from_perf_domain_opp_table-v3-6-5da1096243c9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA0OSBTYWx0ZWRfX9w/azAJyG28E
 53HsqybTfqdK5GIcRMxYNmBqNv3J9rxruYXjbBaTHDwpL2ob2YUHwURn9dxonR2CVAI9kh7c/AF
 uaUrJ5IdzHE2Go79yOWR4IOnz3KIo4xAe+Fexshs5/uqQz2S6LbZ0jAGnlv4mibpqT0QVNo7uYD
 tXmHFtEeolJzT8IedTGi5ANnAdbkZYW9b6lZ+MmYT7o/XGVY6r9jWAV9YgJAapTrEpE/ZWGmweK
 LP8TdTGNLYIjiuFZwD964RJ84nF+V17iLRQ0lS3DZ6eiZoOyo5lkDtsxDSwFPBbmdyZXA19Fd+E
 Yf4DBvIGVlrJGW/la4ij09miMJSszTgaDAFqSXYydgxNbaqAJHPE5gs7Wk4ePlmqMyQFDNe0s7M
 JBfk+GjI3wZ118LzTISq4sQidqIWQdE7ChDjnGa9ku7OsnB87rusSLJXJMoDVXQ/gDhE9W6iNSs
 XoqqzBm7FkQiL7GokTQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA0OSBTYWx0ZWRfX0dxQgnxgrWAJ
 EyuUA+OZnq+bfhi6SxHmTQ6wCZ2SW3VnJhhIbvi/knHjrzLmTsSmXD49oy5lCZ0/sYC/+i211Jh
 0Fvw3QTsYus0Wrpzc/3JhHuF031JFsM=
X-Proofpoint-GUID: oQTvcK5zIvLmU9A8dZ9Zw_t1naWDjAP_
X-Authority-Analysis: v=2.4 cv=NaFzRGD4 c=1 sm=1 tr=0 ts=6ada015b cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=gi_f2RLh3HdMVU9WvNgA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=Z1Yy7GAxqfX1iEi80vsk:22
X-Proofpoint-ORIG-GUID: oQTvcK5zIvLmU9A8dZ9Zw_t1naWDjAP_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 phishscore=0 priorityscore=1501 adultscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220049



On 10/15/2026 6:28 PM, Praveen Talari wrote:
> The GENI I2C driver selects a source clock based on the requested bus
> frequency and programs the corresponding clock selector. However, it
> does not request the selected source clock rate when OPP-based clock
> scaling is used.
> 
> Store the matched source clock frequency and vote for it through
> dev_pm_opp_set_rate() before programming the clock selector. Also remove
> and restore the vote during runtime suspend and resume.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---
Reviewed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
