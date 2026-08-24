Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6703515D9
	for <linux-serial@vger.kernel.org>; Mon, 24 Aug 2026 14:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787583506; cv=none; b=BTJuEvBgU+OeJQt16qL26V+WTmwzTtENPhyW79GOdNYKcXRq54gckmItXD3AN9yk0JRfJkbBg80+C88s9Y4BI9ES6z45GVzOsaT9huC5neubiOpit4ai0T56mZ7AH5PvfDGXQG9xcN0ex10jy6uUZJSwKqbBvq9CitX77oEs9kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787583506; c=relaxed/simple;
	bh=sV7LRWxxlIj9O5J0NrZ/m+X+w/pYcNHRDRmxMkRNZp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tvese/2FwE1ORHJTaAuTTX9kfsdR1EPrQ+RLwiYwTckF+GnSdaeoLnJatpq1u8TM0C6g+HfvBiP/d7lRIX7uZdKgKZ3PpDjEfhwuRDcbEKH/k/mUIZjXXHr1P3YnFpkklcrpvCePdORpQSuB0KaRAWcZj/5e9lxjC4mED17/xdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hhYN+khC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XGAOayD3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hhYN+khC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XGAOayD3"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OCuxi31880532
	for <linux-serial@vger.kernel.org>; Mon, 24 Aug 2026 14:58:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7yMYGRsSAF5SF9le8WlaBTBssyzRoC8qWApQAK5q9q0=; b=hhYN+khCexrhNx7F
	hcjOxeBDx6yzO9fGZ2FoohKEcthI95fq4Qfj/0meUoSBcsYJQ8kdxKUoOMPAcgQp
	tkh8rhNwNMplykSjFvQ3CjvhnCyosVt/rHHmJfL7rApeP1bdrikr5jJi/N8NZUIc
	iAZb5/SocjoG1uIKO6q1M1lgfcp9ItNFV2F2MZE9nbXWvRBqwz0QJSnZ4cEv+zjs
	RhrHR1nNozoUOVlYXvcI92TzJBqLWt2W8ogBbLl6SGUMPLzX3FkEWSrZ8EsA2IdO
	BdQ8np/5F1WammAerUy6VS87ItnPfp0mvD7QbqDWDA0tbvdVwKdDYFgcMf96Zme1
	e9LH2A==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8huf1tyf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Mon, 24 Aug 2026 14:58:23 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c9e97b626so6320571cf.1
        for <linux-serial@vger.kernel.org>; Mon, 24 Aug 2026 07:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787583503; x=1788188303; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7yMYGRsSAF5SF9le8WlaBTBssyzRoC8qWApQAK5q9q0=;
        b=XGAOayD32RmGqN9lsYGe2/H7Em5eu5roo8cna8WrAgs9Tkt36sWXUFMUZ4rqg2UjG1
         JU6dfQoWc+G8prjFmapRFt3Hl8mV25nfe1uapfdcRcfW7Q6zIaKRusQoOv1KZ8jAsqGB
         q+xjYADNay+fw6VgCZDsZ/2dUWLqM6EiVlDzMvYvsJGgpGdBzvGKECjonSWYZYIHG5qa
         7ojWysWK0hLID6b/iCvC3uHCVPF4sti5XzElJdPBU7MEtxQu02I+6M2slBUAgkLIM5hZ
         w+x3K1EHBYtK39RpGfwkqiqivOr+0Fk72FQJCxGRKgndMdwRBA5n9sXpMkMGKG28wKtr
         pdzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787583503; x=1788188303;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7yMYGRsSAF5SF9le8WlaBTBssyzRoC8qWApQAK5q9q0=;
        b=Ep3cMxGGj7c3cQJPSZ/xO8sPSGa6PbnWNBisjzdjwozmNfzmUwdwmTuFsaa7rnK4bA
         SVI6Q32WLMdiIdmRlCbr6LPxpNZ2cvH954zuQDdHss+5zXSqO4fEF4nrF5OiN/CXD3g/
         gRB08Czm3sEL4lN0De/PqvJ8I14z/8Qt4rZbDW7FgaLRLEuQPiabEaWRs2JwmFQqgrPS
         0MRVYclkyKu8qSQOEXQgAKxd8Z5JpuoDhLapf3pWKe0Q53gz8ADNVd6kUB6ib1nUAOGh
         TBetwo57mNNDWmXf9X9pD1eNgHMdnNidoLcBWMmghsvZNCSI5A3vlQ2bfRs+nihNWEjN
         78QQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro1JtV3wAH18kVN3YBVmR5TuLVIV2aj4acR9jNM28VIpcIGFzXxkn3ZhIvK49/iVxmotEr6LTcrt1QLBXs=@vger.kernel.org
X-Gm-Message-State: AFuF++nMUxUcnoosvqlJglopJrPYrd+ihKEJZRL3OXLh3NfzkplyXlye
	j4vR3C4/iDNFFMnvJxvdN5soHTR22LVUmzNGwLgHQoOc66nCD5qVoWQwh3yAXJ73pBc2GKX73tr
	0knlOV4LHXrP6BWBSzVCecBWeIw6Wp6rKURLlvLv4jH1GI8SjidV+zgNYA1JIGkbsVGk=
X-Gm-Gg: AR+sD10WCicHOMnBznIxVB/UNFWonX7i9EEiM4IM5ImY7DNs7zO0tQ+jyaQnEMQeAU5
	wLvKgwDTvyT7nbj6h7moPCrvSzV4Tg1RzY1e/r6UvS1itAcVLgFy33L5+yoTxem6o2F8b2Y5768
	tGFmNeyCTLQlxrYnkbStOIo5fT8Di6h0CwQXx9bX9sE46glahOVBCo1daLkF5L23JwPvItR8fA+
	5JlCoAbK01T6x/rBA43/fvLYzkQPQlAnihCcSghVPv4ihQiK+SojPccQ0L526gV+8yy5Zb10brC
	yi9TOXm8V+fKsyX/piJShT5XpjiW0AH+c5aiL5ZpBVPlJygkgl+OcYBwwXXWDQniM1hUpTE4tmq
	d4XRFoYwvCCa2q/ztOPXt38Rw
X-Received: by 2002:a05:622a:34e:b0:52b:4ec6:52c1 with SMTP id d75a77b69052e-52df59fbd50mr211834231cf.3.1787583503263;
        Mon, 24 Aug 2026 07:58:23 -0700 (PDT)
X-Received: by 2002:a05:622a:34e:b0:52b:4ec6:52c1 with SMTP id d75a77b69052e-52df59fbd50mr211833791cf.3.1787583502825;
        Mon, 24 Aug 2026 07:58:22 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249629a901sm1453437466b.25.2026.08.24.07.58.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 07:58:21 -0700 (PDT)
Message-ID: <5d2504be-0691-4174-9d98-7759205718cd@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 16:58:18 +0200
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
        Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: mukesh.savaliya@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-i2c@vger.kernel.org
References: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-0-61171ab1cdce@oss.qualcomm.com>
 <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-3-61171ab1cdce@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-3-61171ab1cdce@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEyNiBTYWx0ZWRfX31zrVpdY06uz
 fW6bVgbE8EidI0+FasMNoG1HvcdSIiLqbXPJNvaCKC0I/LVQHH7SxxEdz9iB8xHHN1Qptb88dma
 BLwzEz7Cm+oLN0/tu12/dIuNhzEqDKc=
X-Authority-Analysis: v=2.4 cv=Wac8rUhX c=1 sm=1 tr=0 ts=6a8c5c0f cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=ieDA_EM_2LYBYmKFcIMA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: 72dJlu8CXqLz4YkIMFasJa7pVnf6stMZ
X-Proofpoint-GUID: 72dJlu8CXqLz4YkIMFasJa7pVnf6stMZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEyNiBTYWx0ZWRfX4i3x19ZRddvV
 EDdIpmYqKQ9gf2KM60n9RSjF1+SzhJLoVrccZSQUiMJohSWw1wQTakSU1nab4AsIq2vnuHk/NjE
 kyKFbaSDVukihfJCDj68a+klocPqdJMk9QB6yaxiCa2A3Sye4QEIPzA5bAAm0KChVOnsGw2h8Sz
 OTNGOOPVOLcW6J9Y62HwOUniHDE2MapRFr0/1lAr5zIiANiWy2wg5XJtd0S8nxaBOmXkckxuOIr
 gxPZt5lntyC9PFIZCog7cAdDZa4C6QUD6VxRQV+mVlUlzn86VcY5XHzg6UmzBvbJiCUq9Wdhmqb
 jNMkBK9UjEMTy5DxlC6iTeuY3qz3YX1NRlLvCNPHinM24Sj5tzsZecYOeoCGCB6gY5QQdgq4tM0
 o8pxnp5UIhsi6qWqAz/sQhrczNtloM1GVMFbJKqx++jdGnjTcnIHGBavJJhFWLZ3pu3QyzUKM74
 N+mzV+g12Pds9pYuRrA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240126

On 8/4/26 9:57 PM, Praveen Talari wrote:
> GENI protocol drivers need a common way to scale the SE source clock
> through the OPP framework. However, the device that owns the OPP table
> differs depending on how the SE resources are managed. For Linux clock
> managed platforms, the OPP table is associated with the SE device,
> whereas on firmware-managed platforms it is associated with the
> performance power-domain device. This requires protocol drivers to be
> aware of the underlying resource management model when requesting
> frequency changes.

[...]

> +/**
> + * geni_se_set_rate() - Set the SE source clock rate via the OPP framework.
> + * @se: Pointer to the struct geni_se instance.
> + * @freq: The source clock frequency to set.
> + *
> + * Applies the given frequency through dev_pm_opp_set_rate(), targeting the
> + * perf domain device when the SE has power domains attached (firmware
> + * managed path), or se->dev otherwise (Linux clock managed path).
> + *
> + * Return: 0 on success, or a negative error code on failure.
> + */
> +int geni_se_set_rate(struct geni_se *se, unsigned long freq)
> +{
> +	struct device *perf_dev = se->dev;
> +
> +	if (se->pd_list && se->pd_list->pd_devs[DOMAIN_IDX_PERF])

The latter will always be true if the former is

Konrad

> +		perf_dev = se->pd_list->pd_devs[DOMAIN_IDX_PERF];
> +
> +	return se->has_opp ? dev_pm_opp_set_rate(perf_dev, freq) : 0;
