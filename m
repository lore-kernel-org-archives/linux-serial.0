Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8082345CA5
	for <linux-serial@vger.kernel.org>; Wed,  7 Jan 2026 17:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767807703; cv=none; b=nlJxB+5AfEcHkHbxHxmfwIfK62sLLiYAiQZuEwXw94/4dMwa4Pj5ts5zbc6JnHdvNd2weIinyq7TdifB0Fy2mtBG6+Md4gxtEEeX8C0KA5KMkK+m1f0L6dSQtDHN8GPYIH6qTgYwoWvt1dtEwYLQYSNrr22plmD6UdUVIi2l1d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767807703; c=relaxed/simple;
	bh=9zm53oJuJfigZnpOBS/4ml2mKUfCwG7A3zXbFrJmy2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uL9vS3zIFTjY9c7Z6Q8gf5YLk1vLkxNfy3E+dCMZtQcPfGy5mB59ovDNYiTT3m7xxnMDLHNmnH6NQGKPDa5HLSz57KM1AY91SoMkrsCLS+8uFJyDT9O5QaqBsn1v3U3cIe/nxk0AQqHxCSYl6QiOHN1qE9q3Q2Nh36nM0FHwPHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KDvfY5f0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GHRlv/2h; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KDvfY5f0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GHRlv/2h"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 607CsSrD2239474
	for <linux-serial@vger.kernel.org>; Wed, 7 Jan 2026 17:41:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=gCSiaaYZr44uVtLZHtn7mx3G
	JMbLWlae9f6wk/SlcTw=; b=KDvfY5f0HPpE+qBsE7hrP8pFnGKwzMiawxL4M840
	1Oq4k+uD0jGg9uiZmqG+oIbRl00G5wJ7OjY5lDRtaNr8EHVjp5bnkCPAGnvxFA0e
	aMS18ltE7Sz8IRc1dbSorVsrTcX/3MNzhbSn8Ti4N6+LNv1llbhjOh3B++dhG8J/
	u49uSmfP/FmNVZLQQ+vPaOhvlK9b6Vb+Uh4HH4KkM160shMf8o/kam5h1eEwzUOu
	SOx32SoNUCfc+gdEEx54hEgktKiOsHaokpdOAOI+VJMO+xBNOFdpq/h3AqMrpaWP
	DZOxFnr1N5/Gm0M98RYYKH1uk1E53DlPXn8g1HAbpu0CLw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bhqwg0xry-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Wed, 07 Jan 2026 17:41:33 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8b2e2342803so606983385a.3
        for <linux-serial@vger.kernel.org>; Wed, 07 Jan 2026 09:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767807692; x=1768412492; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gCSiaaYZr44uVtLZHtn7mx3GJMbLWlae9f6wk/SlcTw=;
        b=GHRlv/2h7qOp/WgUgUkUZ/wp1UR5Mhbrq4d5lR33/0n6g9eenGopyJAWirzEPuxNpP
         5nM3TVYFClQwn01TscFE3+2J7eE91sTaBxquAI/Li1jBlw/6pLTvo5ZB+oc7uQEZRic1
         VGA3pqb/+mSrRFQhUwqvF8FPy0w8s67zFdDRV3foS1fBklB2LCxShv1kEzFp4Z43vvQz
         C/nHS55k5+b55GSbylsq8rwZJMD+BBexl2VYHNBNh0FabhhKoBSPlg0bqIChSvgaIDAj
         lP2aLSw3cm6Wdo2+S7/u6knOmOlOhq0Vr5cox3rHefuRS3iPebKhtvebKiAdG2cad85m
         v+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767807692; x=1768412492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gCSiaaYZr44uVtLZHtn7mx3GJMbLWlae9f6wk/SlcTw=;
        b=Q8Xt9pCPS1G6Iab1J+R3hF38SrkVH1G/dWm3xfmGQbMKAaUFMcJTVQGldEeVMSzMm8
         SshWnPja+wL5AJTOxq0F0W+b7rDO+SZqZ785LpXeJsZJuV9qY1EynfMlA13X2NcUHrW/
         ZEcf5++YTj78hIrWgYS8tI0iXB23+KsybuSZz/KjNNbUAodoLiavi617o1zRIStkqver
         cOK9xJB+7afnWXQIUBnOUkhJQ9wgGsEhcSF5iNO758x4wZdE1tfIN+K0/fLZZ2ooYzVN
         kBioYVPntqTZBNeFb2CNAPg/QUH1Agjl4Oi/vvJkG53y9s7d2V7so4LVKSe2dniEOJ78
         6g0w==
X-Forwarded-Encrypted: i=1; AJvYcCUjcnrLYpX15ZR1MGwghDVzvexYkGmsNPmsiU6eyIdVl6PRjRmBsvpBqaByGzEWBjJjPTtHoKeZzlZsjAc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4H5JvHGSzTyaWiVWc7wQHEM4UaOkg6FNDT/wCHrUB6Pt4bq2j
	X2+QxIqJhFFf494yFhLg3d81fFC8EyvDxFeIjZ8OcDaP7Syr7kd1pyhsJHFpx3p6zDyoCNC4Fwr
	+cMCxibf6GqAUUWacQE2D8W87BAqJlMlMzfJw46hhg+5GlRd/OPVt4oLPd55THzd9/CE=
X-Gm-Gg: AY/fxX6lbhSeMJyeD8PVUngF+EjiOQmSaZLbfmHI9cP17rmcmEexRjOStmzrRU9Gqf3
	GJ3UyCZKJkWqDno/JK8jbJ/S8Xf/Qx73fw8bil3IKN47rStKIELQYAXorbHSkf5fiMQ5BSFlK4x
	lzYG7Ooq1PQ3aWa29eoIBbYlFY0oc7Rhp9FUqOxZ1UlJIwEv59DUncg4lmCGopR2x7udK9VUYZf
	DqBY4IjBJVvIDB44admmX+TXhYZ4xEI5ksxBEgU+79SxURljkA35KpWRQkG2fpotFPtp9Aw88bH
	UvIgyz670ybmk3DA/Elx1hwy2k8+Gq4Ii9l1aGP2wahGQhwj0sUR8dNAL0xsaOyw4Sf/ilYN0do
	xvBYsKqZ1jRf11uOKVD3Mc5OwFBGuag2C+BLZFxAUReu7+o0A8eCvAEiqouUS7E0wp6lSbN1Skf
	t9sA5M5rDOnl1CrSAujY7M4f8=
X-Received: by 2002:a05:620a:2587:b0:8b2:e179:feb7 with SMTP id af79cd13be357-8c3893dc97dmr425597685a.49.1767807692395;
        Wed, 07 Jan 2026 09:41:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5DbBwg4cg7yHnQ8iiyG6HDvceRhJ486t+2eQxhSrem6igvf1a3Sb860tgDQZLXQKJZQIDOA==
X-Received: by 2002:a05:620a:2587:b0:8b2:e179:feb7 with SMTP id af79cd13be357-8c3893dc97dmr425593985a.49.1767807691933;
        Wed, 07 Jan 2026 09:41:31 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b65d68203sm1458483e87.69.2026.01.07.09.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 09:41:31 -0800 (PST)
Date: Wed, 7 Jan 2026 19:41:28 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        bryan.odonoghue@linaro.org, andersson@kernel.org, psodagud@quicinc.com,
        djaggi@quicinc.com, quic_msavaliy@quicinc.com,
        quic_vtanuku@quicinc.com, quic_arandive@quicinc.com,
        quic_shazhuss@quicinc.com, quic_cchiluve@quicinc.com
Subject: Re: [PATCH v2] serial: qcom_geni: Fix BT failure regression on RB2
 platform
Message-ID: <kgt7t2el7rpbdxrwhdsfnte6ja4pt3aruhbw6xb5hnehvyxxym@2pvcy76dyvwd>
References: <20260107162610.1582626-1-praveen.talari@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107162610.1582626-1-praveen.talari@oss.qualcomm.com>
X-Proofpoint-GUID: 3w5Feq_mN53IdU6zs_FbKnCGSHA5DCOf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDE0MCBTYWx0ZWRfX7P8rTlKcBOsb
 ZsRCWW2xQVxzuo8mym0LXzZ7x3minh1zvPnuT3x50PA+j9wxxsUobFvulICMlrFip4lw/pUiFiS
 E6y50gdMjSdhFqUFkVyotrqPgaoGPpbwCwUwah4EzWBjiv9WlT1PDDasoQoSSeG/YiLUFh2a0UA
 etW3L+XHIM6a+G54b29977qEZYWmz1bFfieF1it3bDeTNRhetI8awyXwyZsZkY9I1N8cBo7CILY
 MVnM/PwHC+oJK7B/TkctNeM1g4nWhkCNPZtZI7E++1gU8VVGtLhXCPIFf/ocRkhzWsR8Qg91Mte
 olqd5An8nUYBACcpIqAd4S8Z4x/bdw/iM5o2J1c3p1Bg2HA09JuyiX6wIiw5wRJh6ltaF1F4bwq
 w4ibEGIlpfGayagE+wAPAaDLS4NX4WWbuSkkdCBjSr3tlPLI5yeW7Dx54NX1vvG+sSrn8wjImK7
 PT+BVZTx03Sho2/Umfw==
X-Authority-Analysis: v=2.4 cv=Pa7yRyhd c=1 sm=1 tr=0 ts=695e9acd cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=orhsill4HOkje53iiW8A:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: 3w5Feq_mN53IdU6zs_FbKnCGSHA5DCOf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_03,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601070140

On Wed, Jan 07, 2026 at 09:56:10PM +0530, Praveen Talari wrote:
> Commit 10904d725f6e ("serial: qcom-geni: Enable PM runtime for serial
> driver") caused BT init to fail during bootup on the RB2 platform,
> preventing proper BT initialization. However, BT works correctly after
> bootup completes.
> 
> The issue occurs when runtime PM is enabled and uart_add_one_port() is
> called before wakeup IRQ setup. The uart_add_one_port() call activates
> the device through runtime PM, which configures GPIOs to the "qup_x"
> pinmux function during runtime resume. When wakeup IRQ registration
> happens afterward using dev_pm_set_dedicated_wake_irq(), these GPIOs
> are reset back to the "gpio" pinmux function, which impacts the RX GPIO
> and leads to Bluetooth failures.
> 
> Fix this by ensuring wakeup IRQ setup is completed before calling
> uart_add_one_port() to prevent the pinmux function conflict.
> 
> Tested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Reported-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Closes: https://lore.kernel.org/all/20251110101043.2108414-4-praveen.talari@oss.qualcomm.com/
> Fixes: 10904d725f6e ("serial: qcom-geni: Enable PM runtime for serial driver")

The order of tags is odd. How can it be tested before being reported?
I'd suggest the following order:
- Fixes
- Reported-by
- Closes
- Tested-by
- Reviewed-by

> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---
> v1 -> v2
> - Updated commit text.
> - Added Tested-by in commit text
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 

With the tag order fixed:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry
