Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183C83DD85A
	for <linux-serial@vger.kernel.org>; Tue, 25 Aug 2026 08:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787645974; cv=none; b=RFYOHsz6+MLSMrnxXYW6ifDEulEPTfmtsFnq/Wt6vzPS7sQ2jxUbmN3R01D+hf56Ps9/T2YjqQxUtmwwU8bsM1RiyjpkDvMwMif5gdrmAydzC5BUOoZqCETmlZnRKKxK1PtMtYiH5ICTw8SpkzVM1CasEKl8CCTs57FO5b/BWZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787645974; c=relaxed/simple;
	bh=Ot8jIiii0wOPLXsN9OFHxPtvh5gzgjm6lZFKpTOJH6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XkzuIYaHXu4EkmE4YWznvVI1vduBHPWdEv+PgwHUEOzX+fYxo5snftNcvVLP6/ncI0g9iDCNTDzWpMz7rWiIA1hysK9Z6QTsITzXf4U4pWr9Ft6FRluvnF4RsmtTAEylQ9K3CGqSiWEPk8Gq3fpgAB1j+ohMW6R4Hum+2KNCryc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j7Rc8kjB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Wr80EMqi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j7Rc8kjB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Wr80EMqi"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67P88DKu1934800
	for <linux-serial@vger.kernel.org>; Tue, 25 Aug 2026 08:19:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GT1LG3ESk4pX1L2+pv91ZrHz4OSnmnqI6wnpsuldA4I=; b=j7Rc8kjBAo5ttSFF
	a4Zv3pZeYdtIKXkG4JHEeDDKnKiKSSQj0wg7tyKNUIJu5LQSLwEGxOSxXslnk8PG
	h8ZLEiADGwfzm+T6fx6SqN4DEgTv/gr8h0+zJqklIrULq1JmTRJbkQkMbD3q2hhm
	malZb9VMsaNEC7RTMvZqtOh4so2ExbdzcQvGKOqhlUKbED0Y4Ka/b4bjedduCxI1
	csCE7XF3ccE/bAjDrVtzDfW2f/vSyGlUY3bwabmuG2leAIQjpQptjdpNGF3vKr5X
	KcfRz0oQlAUjRSZdqEsAvCdV2gKDwx7WQiLP6rfJAiiInS52/O7VW0qT2+F8ajEP
	RS1nMA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g92jqs4jd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Tue, 25 Aug 2026 08:19:32 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8487ed7f7beso4514152b3a.0
        for <linux-serial@vger.kernel.org>; Tue, 25 Aug 2026 01:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787645972; x=1788250772; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GT1LG3ESk4pX1L2+pv91ZrHz4OSnmnqI6wnpsuldA4I=;
        b=Wr80EMqiW3KcyFAwopQGGYjYZuix0275KGRnvwM6gWpOXfiDCC2EqpFMeCcTRaPiEi
         luMDvAvmnOVHXVzyNbi9UjXkh1IRSPvakx2dWdEurxtPjsjSu78KGeSmQB28KCvxfyjW
         gIfTEm0fI3FloMxu/0MK+YZRgG3DhHEXF242IG93bIZ8E1CJIZY2ww8G3s3+Fa+oW5nW
         RTvhj/0wEkLil00SHq+/e2NkhWlBo83OPGZLvuzljXBMMwWkJCb9xemGwWTIF8oz0xqO
         zoNYW3UKDhfWqMhYQQYugiiROBRVHGPybtKesOARMY70Yirn/IZrRrxdBikT/2Q5RieT
         z49Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787645972; x=1788250772;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GT1LG3ESk4pX1L2+pv91ZrHz4OSnmnqI6wnpsuldA4I=;
        b=cHW/Q8MrIZgpt02pCvQFAQaWRLJJDwhD6It19Pq7F4h+hFQa7txFnW88D5JGv/4zsY
         csa1Rvro65nsvv1Sz09LIsuJy1B0yB7Lz+a3BNQfWA2kdSKn9WhG1xiaOY563xulJng/
         etq0oN2OBEV4wUK412LgrvXwoLcnhqHsN5VW17b11Yg8NMzvKupi8sSyVw8A/hkJbRhD
         0sNXffGCvCNvZBXIXP+tU1wUv/CLMHynffS0VCEb5XVtds9/o8fWT/CyLhhoW6wK2Iuz
         H4lhx8pW+DacgjcjWFFUX4irpxlChN3jglJYLUq+Ux4tF/eLeb0CItOVtdDQJ/Sy1Fl1
         UtxA==
X-Forwarded-Encrypted: i=1; AHgh+Roft4txEPZqJOW5HGjXvPcYCkSjmJ05RSkPhVP20LH9cxf8ZQ9RESD0gcAOQWEE8kMG8I+02W7vNKyAC88=@vger.kernel.org
X-Gm-Message-State: AFuF++lY8Q9dVHikpyr5tKn1XkPbdkAKmdL9POPlFiwbBeMKsYfV+1Pn
	o9+dEft/R/7TMVp789PxnYQwrbhfop3Tm+C5RTBcy+jm7heiiiK/AsebRzOd83rE3DBEg59IVIC
	tpPlrMH+l5ZQUW5AnREbG9bZORHGKrvTd1gFHa9bliyXxJqPpgVKihEMpAMFCDs4r/rM=
X-Gm-Gg: AR+sD12qM2NdsMl0J83teLmyruePxgunRV3Tx4dz6CUS7oRhnf8Zmg9/1rMykclI/oV
	sv7k/HlcrO/ZEBBpcHQFhauJjbqavo6Rt47Big5IJEopOv2SX3loCsT2Dsn1/nM2J9fm0FWG/1G
	w6ptd/DxcRQzjmKz+EsllRdlO1TUkDO1wQdOJkufb0l/2hur+RL2z3m9ZPtIRKcoKOp3/J2oARU
	pW/zStpjdq3yUXAix0cW42WiM+Vg1R9HhlvBJmeCnGyWjwSqiQ2XOt9/YJO2c1wHMeW0q+vB7pE
	MySghxL5Vhe5laQZtAjkQR/w1srNGcYxsiy3IKzDtCgNm0tnF+dSICBbYFP7m1JdHLx741dfjpP
	fEiEwsdABcBXYmNZzEeua3rdJnpYofrs=
X-Received: by 2002:a05:6a00:1ca8:b0:84c:1cd2:142b with SMTP id d2e1a72fcca58-8523c8f0862mr9113637b3a.9.1787645971596;
        Tue, 25 Aug 2026 01:19:31 -0700 (PDT)
X-Received: by 2002:a05:6a00:1ca8:b0:84c:1cd2:142b with SMTP id d2e1a72fcca58-8523c8f0862mr9113505b3a.9.1787645970964;
        Tue, 25 Aug 2026 01:19:30 -0700 (PDT)
Received: from [10.218.14.97] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8520f161701sm2725924b3a.53.2026.08.25.01.19.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 01:19:30 -0700 (PDT)
Message-ID: <956ad5fd-7710-4731-9796-b03dc21cb2a4@oss.qualcomm.com>
Date: Tue, 25 Aug 2026 13:49:23 +0530
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] i2c: qcom-geni: Use geni_se_set_rate() for setting
 source clock frequency
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
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
 <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-7-61171ab1cdce@oss.qualcomm.com>
 <aca6afe7-4659-4359-b5c8-e19390a07f8a@oss.qualcomm.com>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <aca6afe7-4659-4359-b5c8-e19390a07f8a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: yzIWaIrybjJG5E-1WnvhLN1pG1LXohag
X-Proofpoint-ORIG-GUID: yzIWaIrybjJG5E-1WnvhLN1pG1LXohag
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDA3MCBTYWx0ZWRfXx3mVbVIdMgtz
 9rFnTFh287tUZaoy6VOOC4JCWNXfIjB1BHIMO06/Z1Kzf/6DVlQl+FnZZyzSfHW7invp+b/lP3R
 eP6vXCkdPGd6CUuyOFoV1ycy+FoJ7dY9PJY/NTdYdGOtlEvrf3H8HFP36F9m5//3yfxKB76wEzq
 QQEtAKOimbzRrKhwIuYqHLMK3fKfK1qOhc7TQQ9ogqKXBZOOt1r8uA0K2TEbv/Py5ri/1qcOZtf
 lzD4u24UB+mca0cvDvuBYNgAwdGwJLE+pWhrNmqDmy+FmhcfHzmgFTKNvOTQNNy3C1PL0sJZJ2e
 q7/nSbxCJDC/qvsYemeemh5X1gvSTaHfFn28Lcn4slRBuJRXklmpOokX7bU7VhREQ/9JPcj099T
 4hYoeB9Gl+7+gMu2A1E1HhI1Ig0/Q7Ppo+FSSpAmi9A4hpKGgI3zmSnlRxJ+sCOZIHtw+14umV5
 CeynT938nRY04ILSd2Q==
X-Authority-Analysis: v=2.4 cv=JJULdcKb c=1 sm=1 tr=0 ts=6a8d5014 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=QDFqMEhmg62cRBsMz60A:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDA3MCBTYWx0ZWRfX/uazIJdhHqds
 i34zQoX0JToRPBaQoyJe6CmV8fXwztFzBlsw8BzxBTTqJ3XnGPYrBJDaqW3lw9+XlZXFop62l2J
 8BMXba51BsAPzz2SkqxJEd7Yb093vhc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250070

Hi Konrad,

Thank you for review.

On 24-08-2026 20:36, Konrad Dybcio wrote:
> On 8/4/26 9:57 PM, Praveen Talari wrote:
>> On the SA8255P platform there is no Linux clock handler for the SE source
>> clock; resources are instead managed by firmware via a genpd performance
>> domain. The I2C driver therefore relies on geni_se_set_rate() to apply the
>> fixed 19.2 MHz source clock frequency expected by the SCL divider and
>> counter values programmed by qcom_geni_i2c_conf().
> [...]
>
>> @@ -233,6 +233,10 @@ static int qcom_geni_i2c_conf(struct geni_se *se, unsigned long freq)
>>   				 itr->clk_div, itr->t_high_cnt,
>>   				 itr->t_low_cnt, itr->t_cycle_cnt);
>>   
>> +	ret = geni_se_set_rate(&gi2c->se, 19200000);
>> +	if (ret)
>> +		return ret;
> This wasn't here before and the commit message only says something to the

Yes, it was not there earlier. I have added because of Fast-mode Plus (1 
MHz)

cannot achieve the required timings with the default 19.2 MHz source clock.

A higher source frequency (for example, 32.5 MHz or 37.5 MHz) is required,

along with the associated voltage/performance vote.


Thanks,

Praveen Talari


> amount of "it's necessary" - what's the difference?
>
> Konrad
