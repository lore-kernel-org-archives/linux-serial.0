Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CD7400DE9
	for <linux-serial@vger.kernel.org>; Mon, 24 Aug 2026 15:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787583917; cv=none; b=PDLhAGMMER3d+gbFdsnY4IifAHAw9x0YxUCmNUZHDUFCIPNvNfWMHxPP8FJOIIF/7thPmOohkgCXbJ1K8sibuvR6tK3uY1Ayo2U8JbByEsj7NkjjkYO/umveGfeY1QbEKuz/kJIjZ3gzPzKrkZ+B2KucBX47LHQMKldnq8ztCno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787583917; c=relaxed/simple;
	bh=sMTiCyj5+9y1S8LPjELQzmaV6VdDm+PrnVA/OmtExmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aIXe8kHsp5mjhSkJQmz4DIX0rttRnYsO6prQtBGauFw2y3R+RvtSp5/6AdyzhWbjwDQbg+q/fkf0U7kVKd3AIBZ/xPv9vjSFCOD/7IIIVk8Zg9laGYUXU17k8DvSD3NXNDTVXXVOdevCNyHhhtt3enlJ2t/0Kyv2XV05z+tcG90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WQo5YLjb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d+jSYmO1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WQo5YLjb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d+jSYmO1"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OCusRw2583528
	for <linux-serial@vger.kernel.org>; Mon, 24 Aug 2026 15:05:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fl6brSJe0+fFv2NIJ5+xIBCq87sP/RzIUmJGMjRks6w=; b=WQo5YLjbSEP3ewIO
	FMnI97R9N6YJk9la5QGqIYT9UtMW9cG3IztThXugYL8syL/mcdWFi3KFxSgCdjaF
	NkLRTtHpkTxdPxOVsJ6wRh5KWnwmV8Q6tYx9g7hU9iun2AHu9FUuupGaxrAofXXD
	/GF/hUsroSWgFe52OL4A3mT1UaQBcXzXWZxSNqkhyeWWVs7uPu7xcEcl1LB8fmc3
	4aiQt2ecuNu7nv0L8n+kJeQy9fyY6CtXUbB90tBVyXtBFiVvCaaMguqrYa1tZWHj
	EQ7BwG5HtkJkWBkauqMQhxQWuQQ64OzDKqN/1j4IC0f8XWyHBhC2WhixoOCUVi28
	DS81vA==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8hbtj266-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Mon, 24 Aug 2026 15:05:14 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-97c3746cd0bso52631241.0
        for <linux-serial@vger.kernel.org>; Mon, 24 Aug 2026 08:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787583913; x=1788188713; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fl6brSJe0+fFv2NIJ5+xIBCq87sP/RzIUmJGMjRks6w=;
        b=d+jSYmO1wezTJuLbkLV5k/f0PmfcOJkzDNblGiRBnR3sdukkgqH5aiBT9zF19PHMa5
         iQfsjPqnZm4bZb8hWxGNIVlMpkPnDBMcDopD3IW6+XrV61eW46H0Xrv4KOex2PbZEQuv
         tGAxNspgNJGaWE2hTXJY9eTeBnyxEVgOry5BpxBrua7t5rwCg/yag7SbeBJ4kXlmvPz1
         6I+gsY8WplClverml168O2xAXXe2n6GRrDbwxyRI87icpQrDWWY3BEqeuDRaWCEvJcbR
         AOMEb7i39Qid97j/1m4gT8J97BO/iOejDpEe0DdLAjAvqwaKIcJxnOo7ThyZgVaepnTi
         2cNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787583913; x=1788188713;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fl6brSJe0+fFv2NIJ5+xIBCq87sP/RzIUmJGMjRks6w=;
        b=X3ox9hEfUdv8gcWPvEzixnVMdJOTUy7JoO9/ALFCa2+HQ9lVk7mtXbYSpRkj+GCCAU
         Z5J5tzXycZs11MuX7NinvI4fJkmWBaJgs43D/+DUO5r4gi4wDsw2E3F40P2rd3bc5zLW
         8TwILwaI4mmaTxh/xBtOr6kXeTRrTud3czqRbLai+dA1X/PgSQFX5HSE5lOk7ddigFAl
         58xWm+vkWvfkKh0qCeWvKLO4G3DHUJIPnzVLRG6li4nXs9agKPeIy9OMthV+7MA39c9V
         6ev8q0SOBG/N0+vRL38b54Ca98XwvJxdUw5JT+CZkH/NI5j459M92y8VtWiLgjJ+cPPy
         Grww==
X-Forwarded-Encrypted: i=1; AHgh+Rpn+dFq38tIHNBD1EVPVewHctD5t6xRE75arUs9pOUzKr1e9Yah2g9LjIHgUMqGTZymwdG+WSNw0f5rCN4=@vger.kernel.org
X-Gm-Message-State: AFuF++nojy1bWwKTi96ArjSLuCzoQGv8JT4yKe7lZstTuti7Vc7gMJ55
	Oh8SXuOTFPiERq5GTcS81V6cYJ0qrjJGZFBp3hOzMOeouyR7frbN+kRjXBMJFvIz2j6/BVSZylV
	MDjX4BZ84Jc5XO3nRjaRxBb2/SP/U3z80hOd5eLYteXbOVJIbdTEWzhlTdTzw0aWdl5c=
X-Gm-Gg: AR+sD11EpkFrtdE4YSlG5uYdI5rVifkgfAl8ek4uurpCG3upqElMY3OPL4rgCrCPBBq
	R8uoAKIZhLLYP0ZiOLIrr95N7Dxuv8a4jULPVJEPqElghPsYx09JfS+XNj23VwBg7Kub4zWsxBP
	gd50Dx7YqiU2Py92LjfflkKraYA7GAQNc+pF/mgmNUbUbiqLtWg4aqEaD1Ez4EmhERRwjxEmNIr
	eJFXK4FhFDrdGJ7GDwDENzMJ2xwJIJsfTyyNwJJIrqtYJriThuuW2bZXz8VPmp0gRldoC9vNpXg
	Bw2qaWS1Z3nyOnYwkT4KjWVLSAhzT45g0P5dL/WuT34J2HEs8oko+ucjmez4nx0n8rRhmpmFaus
	VbU/tf6O3KnxSf830fi8vqMLN
X-Received: by 2002:a05:6122:849:b0:5c3:b339:7b19 with SMTP id 71dfb90a1353d-5c5ff3f5682mr2692089e0c.1.1787583913313;
        Mon, 24 Aug 2026 08:05:13 -0700 (PDT)
X-Received: by 2002:a05:6122:849:b0:5c3:b339:7b19 with SMTP id 71dfb90a1353d-5c5ff3f5682mr2692045e0c.1.1787583912801;
        Mon, 24 Aug 2026 08:05:12 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249685ab3csm1349197666b.49.2026.08.24.08.05.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 08:05:12 -0700 (PDT)
Message-ID: <4e0d636a-7975-4711-8070-6f71957b754e@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 17:05:09 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] serial: qcom-geni: Use geni_se_set_rate() for source
 clock configuration
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
 <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-4-61171ab1cdce@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-4-61171ab1cdce@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEyNiBTYWx0ZWRfXxls7gMI7JBB9
 Xov0XMWHonrTzJqjFZbUPBVVf0wvTkOEl3qtbkMtcj3twC/4yYIe2dGbwU703vSZT2JWCX1z1IC
 0jGtaVpJUgVgrS3IgPeVIrcbRvbSkEWAMrzIEl14HbUp81V0sEAqJ9mgd3N6X8JToYfQbdbNfqV
 8R7hOEB6Vvgy5MNci56J2BQr37P5ixYEyEMwjcbYKaqU1Z/4gyi6l6ZlYXOA1qNvwetrkdOGdFk
 woXvR0u3xKRNsOdPd5bolRv1gjY5HvKr7/iTm4Pv1f7Vfc1t46TH5lKkD6EDMu7vw/C+/uL6Buk
 qf59W/JIVyS+nHpPJV2Mzd+LgmgzXnCao/8jAm49tAP+78EAsBE8wx98qt/MvlVTRfMM7OR6Wxo
 MBiHwqam3eEdG14ty0wl2MuBKxbspDxKIT9xuuL6t/Nf0ydk2vlR7xGqpnHDzGeLvXb2Fn6d/tB
 xJ9OzGTFJk2618HnRSQ==
X-Authority-Analysis: v=2.4 cv=JL0LdcKb c=1 sm=1 tr=0 ts=6a8c5daa cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=LofuKaiTYX8IWbRp0b0A:9 a=QEXdDO2ut3YA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEyNiBTYWx0ZWRfXyGZwClaXTjcb
 F6q6BwE3s+kvJJgCtecoTeVlrZZ6l7hRaFzZlAArvhmaHmowlmncifh1Q1ZVYZmkRZJ9XhVqSH2
 kdycbWzhSO+y02BmkmffrQuSlsKNGk8=
X-Proofpoint-GUID: E3fLSjnev8b6xSxWjL7ItEfL0S95uWgN
X-Proofpoint-ORIG-GUID: E3fLSjnev8b6xSxWjL7ItEfL0S95uWgN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240126

On 8/4/26 9:57 PM, Praveen Talari wrote:
> The driver calls dev_pm_opp_set_rate() directly on uport->dev to apply
> the computed source clock frequency, and dispatches baud rate handling
> through a per-variant dev_data->set_rate() callback that either
> recalculates the clock divider (Linux clock managed path) or selects
> a performance level via geni_se_set_perf_level() (SA8255P firmware
> managed path).

[...]

> +	geni_se_set_rate(&port->se, 0);

This ends up calling dev_pm_opp_set_rate(0) [i see this is an existing
bug in geni_se_resources_deactivate()], which removes the power vote,
but does nothing to the clock (neither set_rate nor disable_unprepare),
which will crash the platform

Both of these calls (new and existing) should be removed. Clocks will
be disabled by geni_se_clks_off() in geni_se_resources_deactivate().

Then, we should do dev_pm_set_opp(se->dev, NULL) *after* they are off
to remove any trailing OPP resources (i.e. icc votes defined in the OPP
table in our case)

Konrad
