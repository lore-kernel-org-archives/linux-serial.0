Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E2545A286
	for <linux-serial@vger.kernel.org>; Wed,  7 Oct 2026 08:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791363102; cv=none; b=d0ONH7PHvzoe0totxjmrEqHMnXdPyn2yNargdZOM4TTRvDsLWCwkRauCvWPxtb3WyJnQ8K7MstMgjIuaGycMDplwsHsZCjAh5+TEyyoRsI82f5nepFsG8XxEqfOJ7/OM4yPDPDlWiO/rzrTQoGucLCbZ6hhp3qnRE5NDtOVxW/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791363102; c=relaxed/simple;
	bh=CiCPHoKbA7QwOLstlzHIyTwZHiWB29u57jr15U2ffdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z7Y7dI346tYCS8yvDzTijmhNcDa1xnEneD10Z92daZ7HUc+S5d7Fg+pmxZHNwtDCFu1JTo7QUm034m9idO7fKq1NWhpyJFm6RaXIDH6ySLN9TmQrUHyROfH5ikrLAMwNHyOEwRPLxamHrpf90ov/Hu8s3nGiQyOmVK6nwpClV/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U4OpEcQk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YfPNoujj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U4OpEcQk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YfPNoujj"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6977jbZ6119022
	for <linux-serial@vger.kernel.org>; Wed, 7 Oct 2026 08:51:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YRMO/BIFTS6t5KCadnTGwzkaBkcMRT2kVp1MYvn8vlI=; b=U4OpEcQkQIQ4z5ej
	X4PJJ8RUbYDn3oovYkwGFkhHWi6r5CyCyPlzQ/d05CTJCrQ6IKSAfCgYAA6rW5Jz
	giHiRMXWfsdCljgvOd4zpvdcxeU8JHTfljCgbK1WD0kNzZ+4giroSrHf6q3uXj3g
	yEApDeVOHzVf42ENaGHa1nIdV2GZ7zWB2FcQNdVi+BVEhhk/Yeu+bhE2chvvWspc
	k/uqDJtOeQTeQP7fqxW1foOGAbfVOCN6Con/wxoYOxxKrz0zs/dYC6gSwQKknrJW
	y33M3sgngOmOpox9KbL8Gv3+7NiE171C7tRE/1PSxnEDdT6ErsD/Y2oD/VtIo6YY
	94AQGQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5fc58pv2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Wed, 07 Oct 2026 08:51:40 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3a47a81e70bso4037716a91.0
        for <linux-serial@vger.kernel.org>; Wed, 07 Oct 2026 01:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791363100; x=1791967900; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YRMO/BIFTS6t5KCadnTGwzkaBkcMRT2kVp1MYvn8vlI=;
        b=YfPNoujjzYkqOobFz5aB1TDTBYPTrnIW8H+psjxkZreV/LyLZOl0EX31al7GwGCDFs
         UHS8YIYn3ag5ONpgmIrGWMvsSt5I7JB6Zws1QcWujpmRqaHVagdTuT0wuem3xf+Ak7/m
         OLo93p9xxWGOEfPa2g9F+7ehJq6NXNBltyhnYe4FzgsHFRek0xRHO3BIiFnmVawg2Xxb
         3CdRHlJdLUiYbmHqoShxwZ9ZIrglrH3ZfDMcRmkanc4rPwf2sXiNbNuStlDBsLEMlozd
         T+M25qsOCJ0YWpIe6TMCaQgCnMMqU4AhDDrKJ2So0kz5QhKtXXY5S+rOzUeGUALOZvYN
         plLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791363100; x=1791967900;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YRMO/BIFTS6t5KCadnTGwzkaBkcMRT2kVp1MYvn8vlI=;
        b=kBZxLV7Y6VUbd9ZhD95fjCI1qeCN6JeuPhkGyJ8ycwAQkmG3QYQLx6rxxdKOle2mDG
         9F9O0HaKkVrZRfWZZ0kP7aTPnoyjBoUdLQlO1zmfzbtGhbGtAfXGR9R2ycQnlFveD8DQ
         ttWAJKC+HD1/Xcu1ba4pWa2XajDpXAalGJMo+RnLs+bjG/2FqGa8kTVrdOMB7C9AC7hZ
         SJpgYhYwJO3fgtSbogJRrYcM2LMA7hKy4YiZ3vuhRaAXkI2Y2WcbltSK15P19TvdQ2v9
         JkwzLN7BAzGMWmJonC5MAKszMRXdSem/sIIEKEHU5DXWCcNFGz8fz8n2ZWhSn2ilDAmL
         Zekw==
X-Forwarded-Encrypted: i=1; AKwUvBx8BHB4VLfyJf9tLYuTkoJYsabFMpnUjg4ZPq+cH4zNv9zw/JxBVh+zBu791wCisNZdb8r4uvFmZobCrOA=@vger.kernel.org
X-Gm-Message-State: AFq9FYI6ajgMbQlTnykBfGfH3vept+16AUAPyW0nId9gUTv62UwBAT5m
	B2rwSHE6/OZ41oUqxZumslbta1qjucFiQMCZHAZXVZL66PNCuT+qdiOYals4DrVQRXiF5/DzkeK
	pOZ98ydvF50DkLnC9UoJn2Ax+KEmuY9gwy0DTQ+zePUiE+GOZ4UptJz20soNXqm4Yknk=
X-Gm-Gg: AYBFou2Usi+q2jLo7rdozzJ47tjxfA+q3+jijGEtvcWimJq47FWRSdeBtxd2P/Ark2b
	JqakU87HrXpcV0DyyTJ96sydAD8NrO1zwPTeCIa1Sga18hHiA+hX+fxaU1Uv7SJM8aU/bNFr3eE
	TLBbudTWf0xRAbqsgvIeMtqTo6XzTEUVFBxvtlI2CH+BFJUUwfpUVvDcDtS7jYBsbKQiEroEB6X
	4iTu5HMGJUHDI34iEPLhRGdK63BWsgtos6dGdMPAH3xpxRhvdN526DNnvVSjNcOJIo+CzdueMaN
	g5Mzpy4Tf6iQ/1zoBESo3VYwS+NH2E8iJ3mn100RUFxzvVW5EktkGstD8HFr8Lf48XWuOvxtFYD
	7E/pHIbORosXV2C5eT3ikcf5dxPHje33X
X-Received: by 2002:a17:90a:c883:b0:3a0:bf0a:c9da with SMTP id 98e67ed59e1d1-3a8a1bbf160mr1409060a91.47.1791363099914;
        Wed, 07 Oct 2026 01:51:39 -0700 (PDT)
X-Received: by 2002:a17:90a:c883:b0:3a0:bf0a:c9da with SMTP id 98e67ed59e1d1-3a8a1bbf160mr1409044a91.47.1791363099481;
        Wed, 07 Oct 2026 01:51:39 -0700 (PDT)
Received: from [10.217.219.98] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e60482cab0sm6760885ad.50.2026.10.07.01.51.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2026 01:51:39 -0700 (PDT)
Message-ID: <57f068a0-41fa-4986-8702-8fd3d6dc0976@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 14:21:31 +0530
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] soc: qcom: geni-se: Remove OPP rate reset from
 resource deactivation
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
 <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-4-091697dbeb02@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-4-091697dbeb02@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAzNSBTYWx0ZWRfX5xPWJ+hf75o4
 OzpSBc4KP9tC8uG89i8LbyRAPFlBPWOo8PtDldwvqlvCfjd3QfKB+PgOxiHcLeba+aCs1mQWUE4
 VP0Y88cUmauJndukmpryGuGBm0jZNmg=
X-Proofpoint-GUID: g0J6hYnVVVdlbb5t7SwUjFUjNdTehkXe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAzNSBTYWx0ZWRfX/0IyYwjsqH2k
 ZOVUfTjlX7hNfoxPi7jxkLecXL3GoA+nLNZZvlzpSOUYWIzgxqrjFRHUG4G0mGAw9LF2ZApdit/
 P+imjZ9R482buzBiA5AdT2RINe6GFyTJHkul9IqQQAFw7du0+EPSGvh2r0DLNCFHdtFNvSYL8O/
 P1HbJgnpg4ydjiyUaq3WQkhOfAwfQ5SyLJa/Yyd2VEAM89WAEpK9G1IzPx+2nVHTfZEIPelz+lD
 EoRR+08YUtJBzUnhod7CYI6sOzVWdNo9s98qN26S62excZzTiXDO9ugK0iLGeB2nR01YnLSOMvt
 HugrFKChS1ByLZWznH96i/peh/T3Y980uuatARal66tbCJ7b8ziePSbBnjEv8qxxVrhTAzi95pp
 nZo+nkP6l5jIR21OF3jYh4dEUFTw50VLEmM+6FmJpYR6RpoA5KXDHD3K6ephmEt77MjHYLUzkNF
 2ZN1Ia2ZE656jMPJtxg==
X-Proofpoint-ORIG-GUID: g0J6hYnVVVdlbb5t7SwUjFUjNdTehkXe
X-Authority-Analysis: v=2.4 cv=a6+lZkSF c=1 sm=1 tr=0 ts=6ac6081c cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=9QLVM3U_lBk_t3napV8A:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610070035



On 8/27/2026 11:29 PM, Praveen Talari wrote:
> Remove the dev_pm_opp_set_rate(se->dev, 0) call from
> geni_se_resources_deactivate().
> 
> OPP resource management should be controlled by the consumer driver.
> Additionally, clocks are already disabled by geni_se_clks_off(), making
> the OPP rate reset unnecessary during resource deactivation.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---
Reviewed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
