Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A873BE627
	for <linux-serial@vger.kernel.org>; Thu, 19 Mar 2026 10:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773915579; cv=none; b=HcZuvpwzmNlbWXuxKuCvcHaTN+6273dTVOuW5Ocf27SjB6SZYTaIXQBmcQtkkQyZcRUDZkunncX4CoioHdUMpfkBQyS4OTbeiCsLIesCkLfZ1lKJ5cza7IjJqhwdASgCpGvNngtX/u/J3BU/78fDdz+Gn6DlXhbvOJ6Z2m0MgWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773915579; c=relaxed/simple;
	bh=ukykM17ynda0tSNsJoGRIO5G++N/U9yeZUlDGTGWX2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oIdEa5cq30XsQjGB2an/BaYrIG/mTJsHOuBYijS2I7YZ76yOeAodiN3nxxa2sD8ur/uplbp8mTCScgRBJ+puMc+wF56u02ZfcAmjsoVNzjlM+1syqYDz3w0aPf2U2ddY3eMuaqa/gjTIcDekpUSI+rAP95Avy+z6VH6hau6RuxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oEkRwvdJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ERCM1gEc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oEkRwvdJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ERCM1gEc"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62J73vvi1898563
	for <linux-serial@vger.kernel.org>; Thu, 19 Mar 2026 10:19:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aLHZwIDtv8ewF5rx26EvXB64u7e8seD0rj6DZNBLKzI=; b=oEkRwvdJmyYBSpsr
	8YtY7Lp7ag+NLFUqNpLhe3gW8rekrr8gH2Nuw5OAdMTuV2MIr15FJcuvVhvJyGq9
	eHEkvWrAbhZ3g+K11L+ZicYNjA5+vteNyPTWf/v2YYiXJKOImG8Xuv9lvV33jKtB
	1FRQT9LC6RUYc4ezOYMZlqDbPfjziKa1Q1DNlemlhAVh4F+KjQOXzZR7a0ui4JAw
	I+6DTZ1HE6qsJhi1tIrWOL9skrXat2tb2SrzYX1KCJGztIovTPIw/2q/+YY3VaJ4
	+AWiiXipI7qj49rJj3Y0gKp547UQkIOcnhul3NBQHEjP3HzIoqbSUql4iOR9NaF6
	Al+Afg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cyyhgb1ut-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Thu, 19 Mar 2026 10:19:36 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-89c4f6c45a7so5617366d6.1
        for <linux-serial@vger.kernel.org>; Thu, 19 Mar 2026 03:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773915575; x=1774520375; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aLHZwIDtv8ewF5rx26EvXB64u7e8seD0rj6DZNBLKzI=;
        b=ERCM1gEcbc8J37FyscMhe/0tk2LbTVdtWlXzlpNEiUdTM/V5z1RLL+5qJfC4g8R+B7
         jWwXI7VY3Ag494VeV9YRs3y5XQX6pRrJYgW4xVUdFKyRseIRbeYqeCUZRKPtluz96xb5
         w/aO0TXyn9BX5mWwp/rW+92CQPwcIC9ytAE44bLyEkSLD8FdH63jpZGejpYOoccm0Ywp
         LMk4yQP1YHfcSSzEpfSx0VReZmDTkTbHO5rrtzVFG8E6AT/2StdkZM7eMS5aObWfYkB8
         7KPTWTGWAkUsA8nV6gYQW0jWsZpCkj33Ft7eL1/S7xEXYdwUpBQFaOA1WetUwy+1OKZn
         ho4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773915575; x=1774520375;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aLHZwIDtv8ewF5rx26EvXB64u7e8seD0rj6DZNBLKzI=;
        b=g/q4n7AQTerZpDT3tDgb9ebb1e7r9QbwtmZvA9Z6D4iNmXVRa8CLb1Gm72VT5KfksY
         InS4u+PQKo5z3VlUWJ3MC7nxk5u37TTChf25MkOjODEuisSFzPXsYpriGdcx/NoaYacK
         YwQybgUq+5sID1qE3J18dbRLARDEiRlcMu+VFs+BppqIKAoxxiThDUmNj9FSqUpHGk5v
         TlNzRsTqAejdRulZeumTId64dIMiicDAlcWbpXYUFC9n36+X+bKVZSkG0Yj4q7ABklM4
         zbapEnwtVLS8x4utKmd6roXhwhWw1BhL7nyFlVspYhL6SZXGpXRUEpmkL89MPvUU5Mh7
         +Tmg==
X-Forwarded-Encrypted: i=1; AJvYcCUGn9+Dh5U5GX+NldMGkllQMecHToxbF+Fvb1qPTCo+Fj9ImsQArDld5XoSyAoDGPo95tzJ76vQnYrlTm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyigknOVSljFFWakJqpOD38kWos7xcqbCAX2OxKHxuIoGXA3g7/
	kf7/PRfM2z8LuUbIejlt1jaL7aWYWWdcPpM1wcXt1gklKZYizn8pP76izGrWWES6i6grdUnI8kb
	rOE8c81Voh/xuwZmvwyJ8nxomBYDk7J6hNwVd8v5U5LQkMAua3NgjXccNFow93jwmF+8=
X-Gm-Gg: ATEYQzw9VtoI5klhuYTDDrLz2kSZ72D1ucYGHt7IttjwN2KI9wJV2yX+DTPS0iCsqL0
	TbMEiJs/feoH8Z4wi9t6s8zKkoMuNhWwjvZWL9tQbtrodRPnJn9M6tRQuN71nfbmaAP01XysXgh
	OvepPBMyW/P9+c/JSt8IpKqvtl3653JCF60UZaLq0Z8DTq1iHjC6t4qyCxNOnNG1BE/kkgYJ+5b
	AV1xIk0yLjVscbIpw+nYnsLJAUJtrOzS71/OesR3I8FJxHVe1ZzqzeaSoBfFD5c2HYIKCO/7CV9
	ZiyPfhMAYT7RoA36OhHSon5ZuJUFBpnERO6YiX41/ZN33RUUYRYYTtcIT85s4X9/+MAG4tiWVCF
	cbjes39grSdwNXxe8MYo1BS/1vR6lND9DZeViMCia2jieGB6uCrK0pljZC1cjQtcIchVZnDu3g9
	mcHug=
X-Received: by 2002:ad4:5949:0:b0:89a:4f20:c1b0 with SMTP id 6a1803df08f44-89c6b499f93mr79607996d6.1.1773915575318;
        Thu, 19 Mar 2026 03:19:35 -0700 (PDT)
X-Received: by 2002:ad4:5949:0:b0:89a:4f20:c1b0 with SMTP id 6a1803df08f44-89c6b499f93mr79607716d6.1.1773915574838;
        Thu, 19 Mar 2026 03:19:34 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b97f142b8efsm443372966b.17.2026.03.19.03.19.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2026 03:19:34 -0700 (PDT)
Message-ID: <1f0e47e2-67d1-4761-9a36-ddac062480f1@oss.qualcomm.com>
Date: Thu, 19 Mar 2026 11:19:32 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: qcom-geni: drop stray newline format specifier
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20260319-drop_stray_n-v1-1-37fb619538bb@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260319-drop_stray_n-v1-1-37fb619538bb@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDA4MiBTYWx0ZWRfXwNYu/jUfNhlV
 H8ibdspSP8ZZGgA1T26OcmvvPLiMxD7O5bU9lC+WVUIbd7UU0Ica5BnhGWFFMqo2d835q9sN6Z8
 XITvCHaWSprFLUjvVMRir02eXnAriTVbHrjCO+byol/VfeOJNAdftopJp9aqS+0yzgSSO7YfXfr
 UUTqwG8mqQBYB2JDDhixDRmRtwimPyTDmAV30vDl+FT6aciYi6xUl0emP2+RZuIelTCxk2meqHT
 BNyihOdFTQMKYvT0DTgC8s5ouQIucGW3O9CGpdrCEsP8HKgkLoGNoAM3NKZUMk3TaqGcUrdExpQ
 w/sRAni7g6Z4rsqff4Ov2MrXOTizbS+/hSRzIBatLNLMWLAyz1CtFnU1X514zBnXTzFk2uH2HDS
 RcD0OpBDc7V1S/aX96G2dvGyXlrTY9TgDKGYzvQbOvTVmhCwR7tH+GsCZpMnkDCJGVvc5iI4pzm
 b0vACZkFgUMGZwtOdXg==
X-Proofpoint-ORIG-GUID: yytyO7H_xJ6ts1kabJ3-uqJsQ5CG8wWP
X-Authority-Analysis: v=2.4 cv=IbSKmGqa c=1 sm=1 tr=0 ts=69bbcdb8 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=WhcIUqnqjzBuv6diJSIA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: yytyO7H_xJ6ts1kabJ3-uqJsQ5CG8wWP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 clxscore=1015 adultscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603190082

On 3/19/26 10:48 AM, Kathiravan Thirumoorthy wrote:
> Drop the newline character from the middle of the printk message.
> This avoids breaking the message into two lines unnecessarily.
> 
> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
