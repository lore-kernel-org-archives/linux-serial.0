Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6392B1E5B9D
	for <linux-serial@vger.kernel.org>; Sat,  3 May 2025 11:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746271247; cv=none; b=qqzr2xFXqzXGnveV+cUMcywLhB4BkK+bD0MuF+vQirfsEOSdXO74A/dCRtbMfh3nO4K6MAHV3E/n17k4fupXuO90CJ21rwUQT2nFoCFCFZ91V/0oo+YQm+BzTlcoiKA7vCHvVGocMUls60fhylkwE7ewedtPr9sl2zXKh516WI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746271247; c=relaxed/simple;
	bh=ZZwm4+3kqdZaoUrJVAZp3I6AuMg2MOE7m9ADXt1bIrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UhGSiGavA11SMG3aIB205ivl9/mO3BwkC/4pdIpGASNBSe0+ngUxugYaQZNz76PnPccLgq1OYBzIFzunWRaaZlbfIa1O1v7dNLZYAQF1DngdFvYlBU5QnpA4B/8OESBHmgh+QzrCRYBHUiI90qa3ottYSKHSkzHQWXCdo3uCmv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gAFPu/kV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gAFPu/kV"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5439KQxS030808
	for <linux-serial@vger.kernel.org>; Sat, 3 May 2025 11:20:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZZwm4+3kqdZaoUrJVAZp3I6AuMg2MOE7m9ADXt1bIrY=; b=gAFPu/kVSF7z2zpw
	JsmfR/Fl+CYVrdezpvlE9Fu9Thwz3L0nnxqf/tRBEO/Ponq0O360EE6/9Eyn2msj
	aN5xZI/IJvtfIQKnoT9wC++Yqfxw6cbxJ8EIqvKRLZhA3OmQFtOIqUDx3POo2wHO
	5SRfa6/5SeaagKEdvoKuOpBK3MVqirzm4OA6waCPv6MOnRz+xM9jBzGr/Xd8LvTT
	BTfNHC/Fmxm0sNv4L9QIcovlumy6c3UbVcNy0/0Pa4yd02Ol5XV3o9SHOzyU0xnV
	tXDGEPFAYJfPtV3jIOUp/cJrx/ikbgPWrmIy10uFoO3TSiHDr0D7s7qwquKrsUpW
	Jlf3gw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46dd3n0ckk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Sat, 03 May 2025 11:20:44 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e8f3c21043so6750516d6.1
        for <linux-serial@vger.kernel.org>; Sat, 03 May 2025 04:20:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746271244; x=1746876044;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZwm4+3kqdZaoUrJVAZp3I6AuMg2MOE7m9ADXt1bIrY=;
        b=nIaJOayT6aHAwTqJ3IEMhbF3R/G7JZhu0D5YSk1P4Ei1g7pzwZeuL7SYyLSENd1Foz
         Edj0JKd4Gk/EEOisgKiTEnx4DZ0faabsWWN55hDaLwBNUNNuG9ljouwwF1gvW7EmlxT5
         HyQHv0nedCjKjAUGCrfhVZmM/crx4CdFcoqAGZE45mDdEan/haPsSWubxDa9GLRw+BXB
         ODp9WG896zKFI65vn01MVjYQjj1RSXIQ0B3nP2RjT1bXX1fkgCKjOIiIc1gHODAGXr4r
         nJpEz8F24G3uzeE1M3I7jO+Tvf2pEw5uw52iO9ESMi94knoZLNmok8qwzhFvW7/L/1A2
         IBZg==
X-Forwarded-Encrypted: i=1; AJvYcCW6luu9XKNojGopM8bIQ8VmVjS38ZiWVPYNTwKI82DUITmspKOVHRXKuLh4D7MVUvafX0YITTbR7YUfMow=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR+ffJTifunTnGxc6lmCjB9KQGZfeHVVQBIqzQVRlJsYC8KIit
	x+ckQ1c7kjXPN+QrH+2uq8HWEi28xa0gLwGPwkE+zMtPlJvKhDlDhALKH/VkHWdFETarTkzYVq/
	z5gblw44DfzfBiRhrwiLkZkRnwVptF81Id5UerVHIu8qCBWy/np66/GIUCT1VfPIhDBT5P2Y=
X-Gm-Gg: ASbGncv/9ptB4ptazRx2nS+Yo2y+5nfOKD6qBveX3S0nFT86Jlb6LG9wPzODp6EDccw
	8WMbxJvlu7M4eIZXO7xC1UmqcVemZxTflIyp5Pi1DrGYxuttl5m/gyVW2UOlNWgdQKhUAGJj0wx
	B9jLHeqV0oe5gAyOA2TZ4GA9g4Z6OuPGmRYtFQ2wW3UKIe3LWJOWfJ/xXAyJ+XIDbf6Ci/AC9+6
	BEnZYOiI1UEweInLfD2HXnbjUF2UbjvPjcg98++aV4bW8H+GFHWCoAAhaF2tMYZg8HDNKgEl5b/
	MJ3pyhXEOlxHi8U8rp9BuitF6Q4ZW+IkS98vsmcJryQvvATHG79cnQ5ESS886DWFRx8=
X-Received: by 2002:a05:620a:190f:b0:7c5:687f:d79d with SMTP id af79cd13be357-7cad5b4a71cmr328843085a.8.1746271243771;
        Sat, 03 May 2025 04:20:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPb7K6LSDWBZT1Dho5YFFLrfHITP13o2fAlVZXPwohh1JHtEdiAWbk/ZWvd2Xrvglqu4P/0g==
X-Received: by 2002:a05:620a:190f:b0:7c5:687f:d79d with SMTP id af79cd13be357-7cad5b4a71cmr328839085a.8.1746271243159;
        Sat, 03 May 2025 04:20:43 -0700 (PDT)
Received: from [192.168.65.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad189540d6esm179999466b.185.2025.05.03.04.20.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 May 2025 04:20:42 -0700 (PDT)
Message-ID: <64268903-fec1-4418-95ac-665738435366@oss.qualcomm.com>
Date: Sat, 3 May 2025 13:20:39 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] Add support to load QUP SE firmware from
To: Viken Dadhaniya <quic_vdadhani@quicinc.com>, andi.shyti@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org, broonie@kernel.or,
        andersson@kernel.org, konradybcio@kernel.org, johan+linaro@kernel.org,
        dianders@chromium.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org
Cc: quic_msavaliy@quicinc.com, quic_anupkulk@quicinc.com
References: <20250503111029.3583807-1-quic_vdadhani@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250503111029.3583807-1-quic_vdadhani@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAzMDEwMSBTYWx0ZWRfX6fW1+g3D/4JH
 JYhTGgtxeF3Iq6O5mYoGaJBUZYWoAfoFavF7pKvDAXsCKB0Ux9Y4Q6UUhOfThyEvJvXJWIyxT05
 7obvAHwIEcvjrubtK4Gjy0GPvdJVCoLuxJASE6QjN4I2YTs3NzX7JJ3pg6wHyoFrdaOhd/u6XWf
 m3CbTwHP4TSdaqu/888ByOI8pilSHtI4poRiYlOvWLrIp0U4z7UKEKmQGnL8NsQZIgwvPlQu8cO
 j5LXKbS08swhBLSxX5FgJM9NMTDFYX/Dzvq2iH+VEv76VFR+HdbxrC/xSl/gID0MzkYiks5A0Dz
 xbptDvQudd5Gg+15jE9pX7jhJjQqR8jbHuIo/QRNdPDWIfRKNd3vlUaG2owSgv/m3UCw3NSZiDM
 SUJkqI3xX4IyYWAc5TsIYx7pkcfufQB6UoKFpM61JKj2I0uz4un0pR6QwZBAXgEJCTfQ0WbW
X-Proofpoint-GUID: zdiGoSTO1RScYVkd_ep5OhwW1s336cxl
X-Proofpoint-ORIG-GUID: zdiGoSTO1RScYVkd_ep5OhwW1s336cxl
X-Authority-Analysis: v=2.4 cv=UNDdHDfy c=1 sm=1 tr=0 ts=6815fc0c cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EGseXkZT_eIdJ_7nNB0A:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-03_05,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 adultscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 mlxscore=0 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505030101

On 5/3/25 1:10 PM, Viken Dadhaniya wrote:

You sent this series at 1:10 PM and replied to review comments on the
previous revision at 1:11 PM - please refrain from doing that, as
you're effectively stalling your submission because of lingering
unsolved problems that ultimately still need to be solved before
the patches are merged.

Konrad
