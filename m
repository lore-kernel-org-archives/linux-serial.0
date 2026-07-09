Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D791DFDAF
	for <linux-serial@vger.kernel.org>; Thu,  9 Jul 2026 12:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783601169; cv=none; b=L4y56VHUR1NI5PDBrw9h3WwJYSsxXXajr0NyjLHbtoibKo9oudeynPxcmv7sibmwR49VR8jBcgIAg+RvgoC8cTX2k1ZDjrI2w/KgYYkLQA5LS7jPdDufpkFkK1DwwNdmS9dzsx+owMHX0TYmBy17xchq8HIKsG8mOIgjPz5BrzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783601169; c=relaxed/simple;
	bh=/iG9LaEOOKZae4ol1OEca4VnoqsdZ/YxkgR30xJdOu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CpEBd+nIsbVm8IQsN2JRT1bYp6FlLPpHkGWNqO9WHnJMsjkYevl5bdvCwABBBgMiuw4VUijfrVYdYZzQ96e+Taffd6ue4RGlQCgJltHbXqkF9PPXbqz46NXTByHUSxrpAHJ+EJHKMesE3v2TrekywCwS4LxjG7Jti52cnnqqOV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L0/y0OAl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WNYNeNy0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L0/y0OAl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WNYNeNy0"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669BNDMn1628455
	for <linux-serial@vger.kernel.org>; Thu, 9 Jul 2026 12:46:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vhHFYSLcv+6lYQ28t2RolA7btajCBASXtU6eML3rNHg=; b=L0/y0OAl+AJJOS7f
	w1PWvdtiYchzvRoPPGZqJ5PC98dZZjGkwHWPnmyI6lPB4JZ+Ch5QzTuUsb8GAI3S
	uoOyMLGYwDBqyN8db+oziIhRKWnYKbKIYpB4Ugdo5K906W+JosP8C/9peN2Uic+6
	FrUTAqylERxjEUAC8DmesG62n6SDOCQ218Ur2HHgA0OdxxF/3QFMpg4n4HUH1DXo
	pW0BKIKVtQmUVYkWNrYqohMTHT1rT8KyUjqW+tA+tTm319j4f3QpsHe8QNaOfi/j
	80OoPdp1MGq2xuPTsx2olI93kDkLY+qvmWo8xaiC8KuMDkvJEPhRkOO05CRYVxZ5
	Amnd3w==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9urvupbp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Thu, 09 Jul 2026 12:46:02 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c9fe4c5eb39so1419357a12.1
        for <linux-serial@vger.kernel.org>; Thu, 09 Jul 2026 05:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783601162; x=1784205962; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vhHFYSLcv+6lYQ28t2RolA7btajCBASXtU6eML3rNHg=;
        b=WNYNeNy02E0dUknscEyLdj2ea2RVm6lv0wjI6LtGz+S4iXX6ld9vjxthxwSMaw2Yyp
         8LnDuNGHmvwUth2y3XYKfNcNCowtrn9nRnwyGCnM1/tXRGn7MUckFDORpwr/mn8lxigK
         YCleCeRc5B0H+AtwSOwBjzJRl+T+WrbI7kEF+FoyVpV0lp+ZR9O+gRR9tcY2KskM1wBB
         uNiARfXHsYUgwokR2LltuyAolUAjWRuKIT1oz5GYnrlRi2xMgtVnoyEyCOKJuNEzxAPZ
         2Qkg3RoBuczE7VZJTiKyGkoUwMj8nei6oThlFCmiq2SudPwDhup4ZU0UdrlHXDEzG+6P
         yPBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783601162; x=1784205962;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vhHFYSLcv+6lYQ28t2RolA7btajCBASXtU6eML3rNHg=;
        b=DGQXxjE72pdUYuW0KpWfpm92GT0ozL6rHLcBOEcD+ZtcjMS8+lQcWsPEbvEVh7lC66
         vyO4EwYCB5gE0oca0volFgNYZwK4RcYChoZYqMJq2rvAQY42p82NalNnY33RtdkEZ/n9
         sSkkKMh9b5SxWtzVOXsIlXo422ElAbWqGA/OJndxV5gM5SQP4ZvpaHIbe4B0dKR50mns
         6JyPeWbbJkXc2HSyPDb4hR9w4WFvCUgS+zw32boJ6gg3VIb9h5tuQzLNxP+HVCqTmTvS
         Ve6Ro0E6J2rcYLYhVoqFU9ku+YDGSZN6TA3e6yYXP3mGrWaMswwPkAX/JymCZvdvCEor
         hKoA==
X-Forwarded-Encrypted: i=1; AHgh+RoY4A5PN6ZlrSPJJjVPU5rrAVpryf/DTR9ox1kSl9LV+IUhbZ/XUrWRTD6yS/M/neJ2a+v7mdYu5NXD0aU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPHKviFsZU2BfwICmuqbKlkK0vTEXBXuaiGt/7BDms7EPHEh4E
	5zW25utFKfTp8lQ+kZHuf+f4ANfDH6B8RlTSeWfwwX38eS+DbBHragKlswXdCcf+2RCRYM9Rfez
	dkjDABW/h7KkU/uu6ugosHAfO9wBPPwRFuYBHMTQ/02+TMcVEGasVBg6LiwLxfQ6mstc=
X-Gm-Gg: AfdE7cn3kbRthIGk0oA1M865biqWjcpU30a0NO1iBr1sf63sB/SOgkJyXvuUpHm4oFR
	0aAgGKF25QxkfuA1jljT5KY3geGrKF3DhHZ5aRZl8H+x71Usl0MHgJeujGQ87w2S+D+nbX+9b+p
	FnWxHMN1A/Lli5iG0kaguAMMu2bbzeAqTgM/EckIDa3cxkfEYvqn3IEgS2QJ9EeLsJx757sDa7/
	fKur7UrJybM6dNulZaIM0fWpyY21IBPVskUVV/kpvnlOdz9NlvZGlyQ/D5/vWvUGuK6TAtLcSjH
	fYaH3SVA5HOiyL9hSgcWMjCD4C2bC3pZJxO+bvZ0rwtv7cvhq6U/5QLcknWURiFFVFC7Sea9RUU
	NO91XdNayIl5CysXPXRnATghbP1qiEZjjIG4wZPZRCIw=
X-Received: by 2002:a05:6a20:3ca3:b0:39f:acae:f12e with SMTP id adf61e73a8af0-3c0bced482bmr10459353637.22.1783601161847;
        Thu, 09 Jul 2026 05:46:01 -0700 (PDT)
X-Received: by 2002:a05:6a20:3ca3:b0:39f:acae:f12e with SMTP id adf61e73a8af0-3c0bced482bmr10459285637.22.1783601161268;
        Thu, 09 Jul 2026 05:46:01 -0700 (PDT)
Received: from [192.168.0.6] ([49.204.111.130])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174ac178dsm31739101eec.28.2026.07.09.05.45.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 05:46:00 -0700 (PDT)
Message-ID: <bc3afb69-bcf0-4a73-a9df-4321c32707ea@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 18:15:48 +0530
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] tty: serial: propagate errors from uart_ops.pm
 callback
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Richard Genoud <richard.genoud@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Peter Griffin <peter.griffin@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Peter Korsgaard <jacmet@sunsite.dk>,
        Michal Simek <michal.simek@amd.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        bjorn.andersson@oss.qualcomm.com,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, linux-omap@vger.kernel.org,
        linux-mips@vger.kernel.org,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com
References: <20260709-add_return_check_for_uart_change_pm-v1-0-e85c6ffa8ec4@oss.qualcomm.com>
 <9320a573-ebf8-459b-a313-3a8b73a6180b@kernel.org>
 <5eecf3a0-b608-4057-b400-236f6952b380@oss.qualcomm.com>
 <ak906CqHYDooQTVu@ashevche-desk.local>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <ak906CqHYDooQTVu@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDEyMyBTYWx0ZWRfX1CKIzmPHUEz5
 6/o2V6DI0Ful/IWOqhohmrGxvc4iiXqPQKMbNqG1xw/I665hQIBtgKV3LCGaNOTggEBvoCpK1LO
 o2mk9VbgE7GfO5BqCOfuZzp64kDldPw=
X-Proofpoint-GUID: yziV6bQ0D3HOgogv_bvsD7EZc3wNB-wk
X-Proofpoint-ORIG-GUID: yziV6bQ0D3HOgogv_bvsD7EZc3wNB-wk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDEyMyBTYWx0ZWRfX8/mkp35vrhw2
 lIfsE/E38ZIkVTG7IMrnKTtfzMYkBdqxWYGqIHJCkBcJEnP/TYotRi6drbDS3WCpr3dbbFW4ijZ
 40cjPn7dFt2b8qe7iG4L/noWz3gE8ZKixWpBNpJDJvAJWFjTdezcgPDLV1KdmzJhjKoiDO0J5nd
 VICmXYy2GMzqrPqUE31tWDPbHJzYhIqUqAGulOTfpHVEvgqhSzIfMENclyviJkHj42DGAjNoa6C
 VwOJwQmsjS4SE8GyXN2ErzOrE1ADDMr83bdAyrx97D0gKpKGVg4U6RCq/cWVV5EODWWPaotGM1m
 M7IRQN4ekmKKGTGvm+RR2k6Dq9oj/gsZiJF1x1LE2uZTFT3GwBwmcEcIROXOlEZjuwpujiime4K
 XKmB/UBEnE0qhiiZdaTX5fj1Lh4m2Gjvg+S1wQLhjKguVMz+5C08dBRsj+vRuldAQzbQ9jpgDbX
 AtiOaBGyH7FtMMom4HA==
X-Authority-Analysis: v=2.4 cv=H43rBeYi c=1 sm=1 tr=0 ts=6a4f980a cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=vz+FLylpEn3mlzyIWlmD3A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=2TZWhx8y46JuiruMumEA:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_02,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090123

Hi Andy

On 09-07-2026 15:46, Andy Shevchenko wrote:
> On Thu, Jul 09, 2026 at 02:22:17PM +0530, Praveen Talari wrote:
>> On 09-07-2026 12:23, Jiri Slaby wrote:
>>> On 09. 07. 26, 8:25, Praveen Talari wrote:
> ...
>
>>> OK, now I miss the rationale behind the patchset. Neither there is a
>>> possible code path to actually test this?
>> The rationale is that qcom_geni_serial_pm() calls
>> pm_runtime_resume_and_get() which can fail, but its return value is
>> currently discarded because the callback is void.
> So, you take the solution from a wrong end. Just get rid of .pm() in your driver.

Ok I agree. Now i can control resources via PM runtime APIs from 
startup(get_sync()) and shutdown(put_sync()) APIs right?

Thanks,

Praveen Talari

> With that, problem solved. Really, this series is a road to even more broken
> PM solutions.
>
