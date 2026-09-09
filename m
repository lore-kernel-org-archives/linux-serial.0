Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C97733C198
	for <linux-serial@vger.kernel.org>; Wed,  9 Sep 2026 11:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954304; cv=none; b=FUL5YSlRUaSuvALbcWm/iLAoKVOwWA4BSGAhbVFgo6mwjtvEoABTioyFjxjfCIyMEwjeme3l9M8q4MaTTZSd/cISOxhmYi5P+g6X4UMfCrko/juAwnZ67lMyOTrhsqqB3m9nAQLJccY0ry7WioGKerw7JGZiJWUn5/balHm6IpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954304; c=relaxed/simple;
	bh=fjyTOfB64lQGaBKja0eGbqH0Am4ca6YXe+AJ+f3iVuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iGtp1e3hPe+UCqI1ecEEwHYh7ryTj2kNF/kb/9jiEDT2npfHzbHinC5mn762XxcPIE+z7dgN0+NoTeM4S6UBPCowo3NZWdw8asGVTr1fAZqBfYQ9WlDTI+gJD57v3CW0FLkP7yC/JSwFyaAGqPZhmk6LvKugry82HFCy8vMBo9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GSMhLKQ2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eyIgOsjG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GSMhLKQ2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eyIgOsjG"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689BUDvq1843101
	for <linux-serial@vger.kernel.org>; Wed, 9 Sep 2026 11:45:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	h26Vcuumsflho0hjqNnrhPlw320bUX1zGixu1CPR/fg=; b=GSMhLKQ2z+TgfBPM
	BV1SYwW/baUNi9LrgfIRcXm9xCdYWBmUGz324rl28gj/TvxhA430Qwjf/eGRdbfS
	Mmjv6d8jBDIgwDE5CrVfgmDKv08uN+aubu9X6d0GZLu8hs4XXtMepI874SnC2EAV
	ejN47m9y3RQaFKUhkn/onY1Ey13A37Wcy+Gz1QogPpInFC0sA5kSS+TO3/7uQkYi
	076TcC3rvZ/In13Y81monBKDQQIPvO8D6y/zxqSoEAEpos/oniHqXGPLtF5N6sHy
	GrfjV5CpJ3nHLG0jwEyDsrlmw7R4vpilJAjIOVIultNhkLsVYLWegejlpUBF6GIz
	vMw7CA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjxqja2cw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Wed, 09 Sep 2026 11:45:01 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-930bd2bfc45so76483785a.1
        for <linux-serial@vger.kernel.org>; Wed, 09 Sep 2026 04:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788954301; x=1789559101; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h26Vcuumsflho0hjqNnrhPlw320bUX1zGixu1CPR/fg=;
        b=eyIgOsjG84Cl6CB/w5pA59O69Z4kQQwN8dg3NBQlY29a/BpTdXQkms5vBYpJ79Gpoi
         qZ+6jbRl1txhpUf7jCwE1wuDiXDixxN9QyuZqC8YLfg2aZPEAEAoiURhvIR81CP5gXSB
         n76x9FwTVQdaKZYcgd9c7SHsqKAuH3kXpijbFfZTOS7vMgoaRI2GKrTHBjdC/86N5Ea9
         mavx0b5wnuTQ5l1UAj6mb2D0++B6t1e3HmAp4gbhEVXZnAZFbfPGq19UPgSS+a99QVIP
         SNhOICwmNOZuAj+GlMcQpbSGcUZyBcvR9uwG4VhRnjcqZXqB2R0VUw6HiVmY2aXv9+GK
         4EIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788954301; x=1789559101;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h26Vcuumsflho0hjqNnrhPlw320bUX1zGixu1CPR/fg=;
        b=JOGmShzA5gmJm9BDdn52S11ja7k1Hz2EwLpUhX2uKOVAycPieJcoDv/N/gtW0MVpoG
         rgx4Ugz5OubFluEpCqfwtRH9dgMF7lYIgEU1PNh6X6TMUMEV2ewae03TjxLteXBAds2z
         K9GmQTQVUMVSd8QyJuRYvTLwqC5oBYTxFS4mAA6lx3UFdF5kvhnEsEqGfqxYmEykfa1X
         YbXRMqy6XYWOMrPFyqbq93isucR3fg6VklBxlNEl3HCzGdkE6FOXiA8Rka90yQ0bKCnh
         XQJuxuwFzyZs3slQSi/uSEyQlFSn/L2cpudD/FXeGwVlMvlj8CeUV8dnXXzX+sjUuAIi
         NMEw==
X-Forwarded-Encrypted: i=1; AKwUvBxc/0HxR4a0msZu4r7lyOWWqsPAURac+GmwCvsqokd9vi0sMIT5i41N6+XUvJUFEb3hTlS9Ktam/oEIKBM=@vger.kernel.org
X-Gm-Message-State: AFuF++n16FVGYPdZTcwBL1L53d7bTwTEq9qJgU7M1p7P6aDcoe33aQGx
	rTx5z1BaQRG1MDB6Mev0aIoUz2LcVZD+uH5Igj2onT/s69gdsjokmgnCeg5lAMNF+nDtSgY+Kw8
	1xJHe32L5gm+bijFlEUPd4Li8Vk9iFsycU121DNMc/4padufKeswIvIbeQMG57bOlcpM=
X-Gm-Gg: AYBFou3pL+sBUPACJYCJfeqPzJTI2nmAE1iahJvzbwI1eNgvUY/zJ+Xni/bbpwg1oTV
	lu54+1rFeXCjMfuD5FRWmPgitMsatn3pUhWNm0uszsINTPIVJEz6+KwI2gIO2NtYTPdat7W4tKF
	EHMQu5+9/lShhF/hODwzVmGxC50qgybj5O7hEibVZ4kF4OxK81xyB/ZsH0znufN2seAWq73/9Mn
	H1j/iGoyw5qcopz5XyRDTBiXAgoLvPo67Ul79tIiE81l5pGaJPtgR6SjYd7vL04/m8/Ia8rvDo5
	AQapagBT8lr5/+mk53j1V0lrWYCcNb7LOYcvDaVC8jAaFHM2NLYnKmu3JwB5rZz85yMDwDAMPB2
	Lkv2Pnihv7zFRVMYwnwGCSw==
X-Received: by 2002:a05:620a:628e:b0:939:8b89:5076 with SMTP id af79cd13be357-939916c18a0mr2556576585a.1.1788954300976;
        Wed, 09 Sep 2026 04:45:00 -0700 (PDT)
X-Received: by 2002:a05:620a:628e:b0:939:8b89:5076 with SMTP id af79cd13be357-939916c18a0mr2556534085a.1.1788954295769;
        Wed, 09 Sep 2026 04:44:55 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a839344fe8sm2101393a12.5.2026.09.09.04.44.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 04:44:54 -0700 (PDT)
Message-ID: <80467f6f-7a0b-4ff9-998c-192c297c4b4e@oss.qualcomm.com>
Date: Wed, 9 Sep 2026 13:44:52 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tty: serial: qcom_geni_serial: Keep console RX
 functional after deep idle
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Akash Asthana <akashast@codeaurora.org>,
        Matthias Kaehlcke
 <mka@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc: mukesh.savaliya@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20260909-correct-icc-bandwidth-vote-constants-v1-0-fbebf6b3c341@oss.qualcomm.com>
 <20260909-correct-icc-bandwidth-vote-constants-v1-2-fbebf6b3c341@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260909-correct-icc-bandwidth-vote-constants-v1-2-fbebf6b3c341@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: S4fp0ZDYCQKifkyDEsWPHtrQbNacgNWK
X-Proofpoint-GUID: S4fp0ZDYCQKifkyDEsWPHtrQbNacgNWK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDEzMSBTYWx0ZWRfX1xae0+BXmFTs
 Rhd1hFbEc0hZlwydW7kVwDD4GQzHb/R33iaoT11mTVcFHGdKk2pJVl/E6hsXkgl1Sh++kZ1fOXZ
 q5HS2Pp7Bd33tl9L55nnzdObWqxcXhsI9uaWOiNnOXxDpxj0YJCiHgSjKHfQrTpEe1s9uJsJTV7
 2N5zmZaq+uzZqpk6VE072yT0LHqUuh2HiXhnXDaQNBs3d6jKsJ6+nJpxDbLA1e/yGhuhzVQZQ/n
 wIqgNzzpm15NctNGUwUyT4v3WJq7MnsmODzBZGRWGahoVr1m0eo6+491diT5ZD3uUGAnoeX98P/
 g6I0DmStL46uVgEzZhQn5gDcRJOmAiuTcWYNea5tJ8ZCOK5M2OQGIDrAEL29NIlOu4sa9S7AvyR
 T8hP621ToCZOkUZd42oGKC3hIhcxSoOnaZR/yvG3heBHOrTzsPlheRjnKITvZoJI/D+9AGAYCFD
 NNePJ2uUbhXp/Bi2/OQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDEzMSBTYWx0ZWRfX2YQ5WAiuNN/K
 jK4IJ1LO4ehw6IYOEunydRdgBLoTnQ5mG/TDx2HrmIRQ1atqJloYWHjCkjYYIbcAqWTnqAQPNcz
 ysxi4rc6zl5fnZ+TE5o/gKOckPai38I=
X-Authority-Analysis: v=2.4 cv=f/p4wuyM c=1 sm=1 tr=0 ts=6aa146be cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=xozMsgXYk9iqUyCLfgEA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090131

On 9/8/26 9:05 PM, Viken Dadhaniya wrote:
> At baud rates up to 115200, the serial console uses only a 1 kBps keepalive
> vote for the GENI_TO_CORE ("qup-core") ICC path. This vote keeps the path
> active but does not request a QUP Core 2X clock rate.
> 
> When the CPU enters a deeper idle state, the missing Core clock vote can
> leave the console RX path unresponsive.
> 
> Use the 19.2 MHz Core 2X vote at low baud rates, while retaining the 50 MHz
> vote at higher baud rates, so that console RX remains functional after deep
> idle transitions.
> 
> Fixes: 7cf563b2c846 ("tty: serial: qcom_geni_serial: Add interconnect support")
> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 3633723acef8..b4b4724f1c5b 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -1482,9 +1482,8 @@ static int geni_serial_set_rate(struct geni_se *se, unsigned long baud)
>  	 * Bump up BW vote on CPU and CORE path as driver supports FIFO mode
>  	 * only.
>  	 */
> -	avg_bw_core = (baud > 115200) ? Bps_to_icc(CORE_2X_50_MHZ)
> -						: GENI_DEFAULT_BW;
> -	port->se.icc_paths[GENI_TO_CORE].avg_bw = avg_bw_core;
> +	avg_bw_core = (baud > 115200) ? CORE_2X_50_MHZ : CORE_2X_19_2_MHZ;

Downstream selects this based on whether the UART is a console, but
I believe baud rate is much more likely to be a good discriminant
here

FWIW you can remove the parentheses

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
