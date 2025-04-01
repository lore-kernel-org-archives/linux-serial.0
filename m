Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595A41EA7E6;
	Tue,  1 Apr 2025 08:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743497457; cv=none; b=c8E2DlsZsyMik3ZTWeoWGbwCo1WAWy/5pfOYEolteakRBJxYT+QfStgaui7o9HOnLlwJ8WhkRdnXUztx9xYgbnijmiqXmkxeT90qBR1aXcS2eHxFHliCMpdkb5gz+GSTBGDCSmPoGPdKtock+vjbbW6Bk869rTQEYWJFecjdarM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743497457; c=relaxed/simple;
	bh=Db1bHZtzv4KjEARyOqrFkHQPVMXwtN1hjwMiMRt+b6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rxYS4rVDSYLIa8Tt8cKIKOKpALtXSXQRc5cvcqnMLTeHqmPgIse+QzVjru9rbs8lXgvfi9bstN3S1CzWEIo3S+jJZEOFGwPeArqbKXAje/dBacC8nfADmXayorE13N1Pf57gPl6SO6mEeDzqme18FgBlRtPu7EIhL+vb4gPqkHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gjQn697a; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gjQn697a"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5318KxN0008580;
	Tue, 1 Apr 2025 08:50:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vatynH2ityQ3qOXKNGXwXruNv0fPqV72MsyUx0aezyA=; b=gjQn697axmrqrtNK
	Gqu9kFbL0whgnXzr3qxZQzBEJmZSUTjJX2ZTBss8Dfb2HtAFFt6B2lKzvrKdz+8N
	6s8O0nKCz0BBtfAC+3b3gVr1V1w5hXEAZQUcikOeNpQcoCorSV5kcXjEDQlZrpbs
	jaB2EzG2GXANbXoOmcRBtSKg651VuMZ4qHurZRE2Xo9RppVSEFtmyw8bpTGtQNsI
	IEC7e6w9ALbScpqEpkkTIR80oltJ9zQuxA/jDltepHH5b93PusTGf6sNaKID9A7F
	9Bqzcv30TADWwJ+/iqfFF+qxZCTKMqmDNx0mOTxNWHcDqL1mNdW4f6bdtSaXLgeE
	271fog==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45r1xnhr08-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Apr 2025 08:50:47 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5318oeuD032043
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 1 Apr 2025 08:50:40 GMT
Received: from [10.218.13.83] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 1 Apr 2025
 01:50:38 -0700
Message-ID: <d5166661-3e51-46c9-b675-e0ec973ea5a7@quicinc.com>
Date: Tue, 1 Apr 2025 14:20:35 +0530
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: lantiq: Remove unnecessary print function
 dev_err()
To: Chen Ni <nichen@iscas.ac.cn>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>, <u.kleine-koenig@baylibre.com>
CC: <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>
References: <20250401080337.2187400-1-nichen@iscas.ac.cn>
Content-Language: en-US
From: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
In-Reply-To: <20250401080337.2187400-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NT9D7_tplwphbgiKOkGaXEElMJYElMdx
X-Proofpoint-ORIG-GUID: NT9D7_tplwphbgiKOkGaXEElMJYElMdx
X-Authority-Analysis: v=2.4 cv=Qv1e3Uyd c=1 sm=1 tr=0 ts=67eba8e8 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=Xs6LVA4tq6cmMylQgHQA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-01_03,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxscore=0 impostorscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504010057



On 4/1/2025 1:33 PM, Chen Ni wrote:
> Function dev_err() is redundant because platform_get_irq()
> already prints an error.
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
Acked-by: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
> ---
>   drivers/tty/serial/lantiq.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
> index 58a3ab030d67..62cd9e0bb377 100644
> --- a/drivers/tty/serial/lantiq.c
> +++ b/drivers/tty/serial/lantiq.c
> @@ -773,10 +773,8 @@ static int fetch_irq_intel(struct device *dev, struct ltq_uart_port *ltq_port)
>   	int ret;
>   
>   	ret = platform_get_irq(to_platform_device(dev), 0);
> -	if (ret < 0) {
> -		dev_err(dev, "failed to fetch IRQ for serial port\n");
> +	if (ret < 0)
>   		return ret;
> -	}
>   	ltq_port->common_irq = ret;
>   	port->irq = ret;
>   

