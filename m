Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4808C31F99A
	for <linux-serial@vger.kernel.org>; Thu,  8 Oct 2026 19:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791488743; cv=none; b=BpZ5r8MlynN1soPDlZFQQYKjVWa8a9kWahlCd4xqgmBKNwrw3KXQBczgWOI1pRmVJXKJ2HacOtZN/uDlD/oZ94ipBBMbecE843RYbEggoCCw00JIdTkxH5jKcKwe+UhwhLKjWGfmk7W5wqoiA2mAi/xxGakqaxAQmZh0THYPo7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791488743; c=relaxed/simple;
	bh=SiXKJG2PO/AmoGF7S8/huQmSfsdK7b1//FbyQBx6Qu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pDMcpjSawlomRL+f+xNnAfolQ1R3D9bvYZ6RcyHRMywpm1+4Tp7rmb7IWxjn1MqP9P30fS23P6UboaueBeiQsJHr43/i81FRU7lpnZwUblRYk1Gi1o+5e5A+boS6/rZ5x11y58neW5eTxJCWCrQHw0nMowCMMOuVbBedhtyUhos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jfD1vmY5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Do7lx9PT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jfD1vmY5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Do7lx9PT"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 698HVsho3197680
	for <linux-serial@vger.kernel.org>; Thu, 8 Oct 2026 19:45:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jb2QYRx23fNHLxJQ4komYZKPnagAt7gtPXM7krNr7DE=; b=jfD1vmY56ONHOBmP
	X6r+b5uQuumr4j3GXxzT9masxHagH4dB/UtE8UKFF4Hb2CWaW/ZPEhdj3fB8YDEJ
	hXuEhvOqYSux4hKQaCGyFrjimPTax5zA5XG0whEo91qQw3xC4vm6wM2HYLstMZmy
	R+lELEbP8pufCors9y3dVEdJwXoOGgkuo7soUvdSa3pQ+34r92oR3rZpyFyOTaA5
	Wj98cnRktpmBxBwaI1pmAhYD06mnoEg+ZxgMeqNDG8K80gHSiPRvazv1NszL9Xm7
	TbA6+WSZ4Hj0HlGxNAxiEgONywIMp/d00DYwMDx9zHSzbAXHluwYzUYv+W9wgFhh
	nvhdRA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fmqrfnp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Thu, 08 Oct 2026 19:45:40 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-351788121cfso4633215eec.0
        for <linux-serial@vger.kernel.org>; Thu, 08 Oct 2026 12:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791488739; x=1792093539; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jb2QYRx23fNHLxJQ4komYZKPnagAt7gtPXM7krNr7DE=;
        b=Do7lx9PT4eQMy1r6P3P0rq/ybRyrXn1pbwOjztFBZrrjtkK8BnPIlztsDG4udQt4oD
         +zDvjsGNICCIuXXHSkV/DrX9a9hwRXpXBcBnlKDkbwnCrZsJkos6TQxU8o8nonQsT86z
         L7yx94SMN47yvXnow2jHw4zPEZakiXDlD7UhxU3S4dfJInodmEFvvdlww5xBg7AAekT6
         U6isEJ2ZldAWWNCJBFzuZGWKKyJqCDmaJP6BpqqiX/7m2K60R3TI6ZEJvVmtoiyXyjlv
         36fXho401oMUJZ0vD61K9PaPojQIG5PVw2kA/Bwf4hzpu0D8UF40LSXEjlYl7epu1LEk
         33Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791488739; x=1792093539;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jb2QYRx23fNHLxJQ4komYZKPnagAt7gtPXM7krNr7DE=;
        b=0ZkkD4eATENf+v9N/CpEwBsZ3I5KOvgUc96CquLM9Bp0Z1J/dqFyyaOTyfjzPnSqva
         2hutcZv0J+nrZvEGlc47AxadtYO72wPyIDNyle5rFY2tpzhaZmOpHT6WpJYhaIU005fP
         23pY9IeOj0baOZMyveOOcSgpysL2kTKvXKwbLSRpfoD6Pytyja3Fg3hb2m308f68el19
         QJ4KgPgRzP7nunrnOHFZwWpQhytdwRPhuoP/8cBWAW+1IJWkXKHnzNcbF4lOpaMUnkCF
         Q5rrKDHFxRnxR2MQjRwUy+Yup9FWFi95Aa4qRgBUiuW4/ilXaeXX11mWViWYAoaWza/8
         4AUg==
X-Forwarded-Encrypted: i=1; AKwUvBxmRMfHQuAV9sdjKYEhpV/jxna536w0l28shaKRDZnfBcJeFvmP3E6GkUUSB17VOfPcR2blU5vvFREsXlI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKRpj048iDlyN+sWiLpLGLCnJprsMHB3AX4/3BtC3m0qekkYyiJ
	VUs5uAymTf9pfPdOeRa7CpZbSK/Qgpnn8LHGBrleGDRPUvjuAOSCjeQjk5juZ5nZhXJnVP6+VyL
	79/JgudZWvInoIjc4z8ojJhIaCbI0ypm+PsxXrHGBlB7Ds7Eood3qce63hHVLw/EfvcI=
X-Gm-Gg: AYBFou2Bu4RYmANKVJuWVjTKc7mVU+zJL7WO7rjr5x+IqcDdPb5lT5GiRpIJDIY5kFv
	+UnjNamhPq0KjxwUdv8YBFyONHmUL2NkR1+iIqtFb/Doesw40GCnT52CAvQ0BdcXnNoKwnA8nRI
	rTeUO+gOtdvPeOzRNE6OowtQVsKyBvcNZC+LWlx3PvVph4TfJ4/V55yM6tOwJLYSl9N3VjtM84S
	Tco0Lx7dshAQ8whWKRJu+H/khcgVBJFA9VahGJMtGm6rjS3M/Exz789fPlcZ+nrQ9YAPbivNtYK
	JQMe8h8TUSB8vMeBFTO4lWFFctVB1gPoxLMV0ZapArAGXFMINQ3Gx83Sx+Rehul5dwhDlqMOWVp
	eRTRAUbXK3NSo0Ew1w3+pH/vLNPRhl7e/DA==
X-Received: by 2002:a05:7301:5414:b0:352:2e10:10c3 with SMTP id 5a478bee46e88-3535f43829cmr468312eec.36.1791488738894;
        Thu, 08 Oct 2026 12:45:38 -0700 (PDT)
X-Received: by 2002:a05:7301:5414:b0:352:2e10:10c3 with SMTP id 5a478bee46e88-3535f43829cmr468256eec.36.1791488738093;
        Thu, 08 Oct 2026 12:45:38 -0700 (PDT)
Received: from [192.168.1.2] ([106.222.229.121])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca1b556sm277985eec.9.2026.10.08.12.45.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2026 12:45:37 -0700 (PDT)
Message-ID: <dbc848a0-c963-4715-a3c1-7c669142d28d@oss.qualcomm.com>
Date: Fri, 9 Oct 2026 01:15:29 +0530
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/9] spi: qcom-geni: Use geni_se_set_rate() for setting
 source clock frequency
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
 <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-6-091697dbeb02@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-6-091697dbeb02@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA3OCBTYWx0ZWRfX9cpAdWNch6Uv
 fz4z9/iQ1IwEZi5mLeOB3Xi11gj9rxqlLNyMk1aJmU+VMPJSb+oHcvxvI+Sdur2n2hC4cWQzLl/
 Tkgtk1dD2HzIzUdEEzyRrxB/LAHS97k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA3OCBTYWx0ZWRfX9xSEaL3QZWm7
 JTYqcrKNRMNs1hIjC2Cfp2QBC6J/kawfFkEAkuZgWFWtGqVgvYaXALTtUw2j/A2aSRjeot+rgqI
 7aiKc/trFXazfXAxJ3UHbHtQq7MYywbmzblVE397VdBsXr1xLBVg2l/VKN4cxwXhDlcxR5iMsJJ
 CZkn5PSyMa76bCE6zweKAdTVyOIFkiA/liS5SA90NDPpHJJqor88MLSvUAez88uMSQVtbKRwT4M
 agK06TRFsRMKEIlIBTrS8iJollPpNUGR7eIMK3OvpqllPNh87yxbdxWMOp7lNM8vj6swunyqaVZ
 teyOYVkdM9Z27pzvReWTn8ZvTTOFOo7gZqz1YOHVNi9POY5x32XyKFZCpiDqpNPUWMuSL6bYZnX
 mcYmT3g8fZgCAGldfPylVLzBR0O48jma4Nke+iR3TUfzQ3njw8YOB2jT15CTevrj5tFWndcg7uY
 6UCRBIdGnfyI4UovnRg==
X-Proofpoint-GUID: wD2O3qz7QXTCvkrQW5Q_oXD2GRwmjwmE
X-Proofpoint-ORIG-GUID: wD2O3qz7QXTCvkrQW5Q_oXD2GRwmjwmE
X-Authority-Analysis: v=2.4 cv=IqCL47/g c=1 sm=1 tr=0 ts=6ac7f2e4 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=soJen2uxB0ky/kNk6TDY8g==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ld924GHQG9e8gPgwT3gA:9 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_06,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610080078



On 8/27/2026 11:29 PM, Praveen Talari wrote:
> On the SA8255P platform there is no Linux clock handler for the SE
> source clock, so the driver has no way to look up the source clock
> index and divider needed to fill the GSI CONFIG0 TRE for a requested
> transfer frequency. To work around this, firmware instead exposes the
> SE HW supported source clock frequencies as OPPs on the perf domain
> device.
> 
> geni_se_domain_attach() now populates clk_perf_tbl from
> the performance-domain OPP table, allowing firmware-managed
> platforms to use geni_se_clk_freq_match().
> 
> Use geni_se_set_rate() instead of dev_pm_opp_set_rate()
> so clock programming is handled centrally by the GENI core,
> independent of the underlying clock-control mechanism.
> 
> Acked-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---
Reviewed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>

