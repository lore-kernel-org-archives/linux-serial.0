Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0311CF8B;
	Fri, 18 Apr 2025 04:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744951181; cv=none; b=ql6QWZBhTM7sDKcHje6LMIjbpSABUhEGIYfRHPPT2JUWAJbxyZ6Pild0VcsANKW0/VePox8O74WEXEPulNF7t0xAQU8QuDU5gxrMsfquqZRikcO/KYQrdE18UjmZXRDdH/sbb1/rnEVXPNQ/Dn1iepaluL4iNjkpSHed5opF0Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744951181; c=relaxed/simple;
	bh=FAoXh9ez3iZ85lXmddTCFxArAZx+ReJmPUU023Q3qTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NwsiDtW5rDLhQiNYHB0K9RZ+goa7Nppt7pNsD4KzjKMh2L40khcPZI72PXxSviqtv5J3B2iltPIfECPVaDFrcpqYz4k8JpchBjUABAUFdH6BoHICCLAUhLEiOsReK8KbpO4vmKaKGpSSci/sGWG7sWAxx0aYaWv9vMrISKc9HCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XCyPslxy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XCyPslxy"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53I2knvU008161;
	Fri, 18 Apr 2025 04:39:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6DD5+d6JuFdfyDvwuu37UUhvIuod+Xl8zRmRg7WbWEg=; b=XCyPslxyeHbctEw9
	OUErl358aJ9di+R/u9h1yDFDUXtO5CHh5jLe8esyHJqNncQIIp9HdQsgvUKKtwkA
	GJ7uJALTyNOppMKBdu7CmrAzaqcmJls7fDYQnss5IimEJOMXeqWN8Iw5Uii333ZX
	F3H+fUdSyJa9dB3mMGkURSgxpXrzxues3GfhydNox+q6ULchnPexg3uEMcCzfSJV
	NjqUsk7yq45/NtwZW2N33/4v12TQpHKvNxHkTLUWdUgeD2xymNnlmdHg2kxsaqcy
	JjQcb6928vZCg5dBThOlo6pteN/x2GVAXMwiQpHgcDKRGStC5y1QjDC55qldHAJT
	ySqelg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ygxk8uka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 04:39:01 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53I4d1TS023281
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 04:39:01 GMT
Received: from [10.217.219.207] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 17 Apr
 2025 21:38:47 -0700
Message-ID: <9541b625-c2da-4e32-bc72-e8593a4e02de@quicinc.com>
Date: Fri, 18 Apr 2025 10:08:44 +0530
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: serial: cdsn,uart: Add optional reset
 property
To: Manikanta Guntupalli <manikanta.guntupalli@amd.com>, <git@amd.com>,
        <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <michal.simek@amd.com>, <p.zabel@pengutronix.de>,
        <laurent.pinchart@ideasonboard.com>, <radhey.shyam.pandey@amd.com>,
        <parth.gajjar@amd.com>, <u.kleine-koenig@pengutronix.de>,
        <tglx@linutronix.de>, <julien.malik@unseenlabs.fr>,
        <ruanjinjie@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC: <srinivas.goud@amd.com>, <shubhrajyoti.datta@amd.com>,
        <manion05gk@gmail.com>
References: <20240419120531.3775919-1-manikanta.guntupalli@amd.com>
 <20240419120531.3775919-2-manikanta.guntupalli@amd.com>
Content-Language: en-US
From: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
In-Reply-To: <20240419120531.3775919-2-manikanta.guntupalli@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=WecMa1hX c=1 sm=1 tr=0 ts=6801d765 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=zd2uoN0lAAAA:8 a=jT1n35VJyowIQWFnuysA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: i-I6zZAHVni2nzEZZRg7QJzT_8NUqaxB
X-Proofpoint-ORIG-GUID: i-I6zZAHVni2nzEZZRg7QJzT_8NUqaxB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-18_01,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 adultscore=0 clxscore=1011 lowpriorityscore=0 phishscore=0 mlxscore=0
 impostorscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504180032



On 4/19/2024 5:35 PM, Manikanta Guntupalli wrote:
> Add optional reset device-tree property to the uartps controller.
what exactly is uartps ? i Couldn't get from google too.
> 
> Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
> ---
>   Documentation/devicetree/bindings/serial/cdns,uart.yaml | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/cdns,uart.yaml b/Documentation/devicetree/bindings/serial/cdns,uart.yaml
> index 2129247d7c81..d7f047b0bf24 100644
> --- a/Documentation/devicetree/bindings/serial/cdns,uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/cdns,uart.yaml
> @@ -46,6 +46,9 @@ properties:
>     power-domains:
>       maxItems: 1
>   
> +  resets:
> +    maxItems: 1
> +
>   required:
>     - compatible
>     - reg

