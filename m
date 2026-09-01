Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A2647209E
	for <linux-serial@vger.kernel.org>; Tue,  1 Sep 2026 09:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788256628; cv=none; b=BPHPyi2Olr7WwgEJO+962WbFwAOLzfBtKgXlGEwB5N87bvx0+8AW6ztBqbSsygtsfth7iw/ULQCpWai1T5UH0RSe5lZ8R6xHvk6bXlLHdXo8IKcxyawglPhRDlRoQJNqnqFMfaR2I3vM/mHDKNDm6g+6SToD/5vE5uXSdbkaF+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788256628; c=relaxed/simple;
	bh=iT3he++A8kxWgbBGKxwXXDOge7lE5zpc2ZmxC+hzKG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sljf1DFrwaYQKVSOiujfTCoz2lsNjNNdIGNr3DEfJpRTd6tm6pELCUczNU1lq9j/hNBr/Xi06ghDgu7wQGQyzGQh5h6lRDxWIlDb3045ZavAEKEWkIRUbVBrSaid4kV01Z/nDJNhKZtY38d9xzJ7iidyXb1WJOP7pbhwOzf7rSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GyhlwtMw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cT+5WxGv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GyhlwtMw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cT+5WxGv"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68179Krj1335435
	for <linux-serial@vger.kernel.org>; Tue, 1 Sep 2026 09:57:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	riNd+k06dt8Od8kRfBQfHabMphaZU5P9P6lFEw+XKfU=; b=GyhlwtMwNdBOEM/a
	BhEVSNxZjkjMP8mQ0gWv2XaNECMYycdZfYoWbDxZMkurbAwquFlLXATHw9zeTo/H
	ez2IaJofj4kyy/+VBadRH8x3mJ4fDERIysqDm7xPFkA6pchjMjgeftWCLjDvjOKg
	iRjeH9kVhy8ozNjpLMrjki5hLxb4mug+PihJwOXDAlMXG8KFYzZ3RHsMiiunkfcZ
	Y+zUMTSScBpQcwrNKSAX+ekLcrImRMoQsgvDrP0D0a1y8Q/RerPLtAm4o3CYshBp
	jcn6sbYm45Lt0J6Nq4rS7xEvd03E26/IKCVK02Jydyji3u3dEcYBoZTmWIXKDWqF
	grI/1Q==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdjtx2hdn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Tue, 01 Sep 2026 09:57:06 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-90ce11fbd36so4295616d6.0
        for <linux-serial@vger.kernel.org>; Tue, 01 Sep 2026 02:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788256626; x=1788861426; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=riNd+k06dt8Od8kRfBQfHabMphaZU5P9P6lFEw+XKfU=;
        b=cT+5WxGvqP35HXx9GUSwB3oF52OGoBmeuTg83PgrAbmExnlHxXpKkKbXub/5eHbZAX
         oxeeSHJlRzaC0M+6LcjBWQIA0bxQvzqQvkuD0Zn2Z0zYlx5KMpNlwIZ2GAHiHpHtuBN9
         Oj70pZUr2W+7hmMHTbtfi33B+9fjxxI4r0xiDncTpMf+QIAVBmGRsl3jd7yj5kgjdXyo
         nxXqd9Nk2Te8e5UbBFMIaxskkNbz5rU6OOvgtP/OKjkDsNw6S0JeBxxLjrq0Fqwfclxh
         BTcSMeJthHZQf2G/iN65Vkr/Mh8K7I71COhdbV7PXTBdaUPDOnhPe1C7vQaOo0KKG/QT
         JVfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788256626; x=1788861426;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=riNd+k06dt8Od8kRfBQfHabMphaZU5P9P6lFEw+XKfU=;
        b=dmwTKp1dQinCs/aynTXEz2rY7X3DgHearDRKDqove16HPBd9MU3QFUonGnbNPiiAqY
         in0EAhO0q6QmhCFNzDMRQNKwREyYB8PCfuO9eHo7CEirdMql9nEYNRoKRoUeRY0wNHvE
         MNq9P3p2pZgYA7JkhZZRwarKZYrSTvteGeSZK/nDMS7NSXQTZyk+GKU70u0mgWs4HeoC
         m9HgGMLvQ1hKHrXsuXBQf4Xc1f2r6ZlVKviIQutmM09P2AjuH5ZEEy/aTULsNVX2IUGH
         V+g9igK+ReOFNd1MdC7+a7YP361PnjzHOlbwrvuJBqzLlBVyDl+ngi5snBesdLBf0QHy
         Tcwg==
X-Forwarded-Encrypted: i=1; AHgh+RrYW3MMCAG56JA96xot/voBTsNullu9XSWumymOAazJtTLx2MuQlYU4tsd7+1xrBkEoXIDxy6ZnzHL6OiY=@vger.kernel.org
X-Gm-Message-State: AFuF++mSJLh7xb5DmYJ9m/rc6Np+yV2Bs5OIpTb9ysBmWHXnodwlUAgt
	aqjRM8QHvEOi+L5pwsKm1s6BwuJ8hMzLTCQBoNAcr+Y4cxPIvaYL1fBHD6cuwW0ESDEBO/4Y0R0
	iWLCpm38bOPv7GxKQw5OlXHgLlS07iAhmVpnsUYtDHSVoal/MTuXJjFu0dMF1oFkUzGezgSQdJM
	Y=
X-Gm-Gg: AR+sD13kbQ7N2PN2DB/df3HwVGwT40kRD132Mlc5u7XjW7+c0oOi4ofj9woKjKhk+mx
	gvniZs9qVAVbX96J0830nlF2tMbdeDfj1jZ+zKfMz2GytFYKDig+T0JBzmXOoXJIwsgzL3Nbjo+
	4oZXce6AxxGPOOU6VoBxd/paVb1mj85/iuCMRxPp4rl1jicl93/BktdOFK0KNzbcNqeYPuAE2OE
	XeRwRMY90Q9yD8wGW3VoKR2Zinp7oIwVqY2ZO7dLltz1p+qUSAkZylkAdLjn/gnHaJw71+syG2P
	Ug9ecOIpywgoReDZwZfA1vUJ6H1/3LiNtxRf4Vgu6obsFo3OQtiEPCDKSexTt5nwitXNOTDMS62
	DSVykn+3AedCpzgpYZLjXPA==
X-Received: by 2002:ac8:59cb:0:b0:50f:a53b:9d5 with SMTP id d75a77b69052e-52fb93d5f6cmr255606381cf.2.1788256625616;
        Tue, 01 Sep 2026 02:57:05 -0700 (PDT)
X-Received: by 2002:ac8:59cb:0:b0:50f:a53b:9d5 with SMTP id d75a77b69052e-52fb93d5f6cmr255606101cf.2.1788256625177;
        Tue, 01 Sep 2026 02:57:05 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a670b25d7bsm426703a12.25.2026.09.01.02.57.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 02:57:04 -0700 (PDT)
Message-ID: <1383bc62-fcc6-4d5d-a4e3-b2b6ebadc0b1@oss.qualcomm.com>
Date: Tue, 1 Sep 2026 11:57:02 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] serial: qcom-geni: Fix port_ida handling for console
 and probe errors
To: Aniket RANDIVE <aniket.randive@oss.qualcomm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20260831-master-v2-1-0032ec7fd1ca@oss.qualcomm.com>
 <5bb31efb-3855-41e7-b011-1a5a94fee59f@oss.qualcomm.com>
 <5be318fd-5413-4d6e-a8c0-f1b1eb35393a@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <5be318fd-5413-4d6e-a8c0-f1b1eb35393a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=K78S2SWI c=1 sm=1 tr=0 ts=6a96a172 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=qbdvrbZ-FacRNNmyY2IA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDA4OCBTYWx0ZWRfX9F9adjijIiyw
 Sj4RZHck7Q3zS7uBQzncyIfkbWighAS1PBBz9lyxqJC8joOMQZc4UtfqmFUH03xAOtdFO9R0d+s
 vgBVDIQ9rX9FYrrHq5J5iUJLbxJi1lE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDA4OCBTYWx0ZWRfX3XsGlgXGvcZR
 S2tJK/SCFKkQ+sq0cU9GMyUxyJ2qvMlM4z1V5diiOJlpocQz+77rf8XX1CH6ZsvidrbWg752epW
 v3XDiRDCTSv09s+GHcZ5REnL5DDxXb/ygVJZIex2aYjgL//6mK8G3A6WQ77px55JGQfBzCNeKzE
 R3yOtoQ2mJ0smNER4ZqF6oWFY8paarEYDuklyYX/+WmrRQbREDR8RKNZxpMEA8jXTfHlFP5wD7L
 RblSKMqNyIbt5zRmqiw/YeAm1spPZfWeqgSzwU/q17wvQSPayCHqLMiOiT/3udyNu7wA8vaDul7
 THJGdqCnsQw9Q+gvWOR1qslqjV7W2xNwyEO1hfaZq6G41IQI06L40fm/woGSkv5apHF1YYACCl+
 gOXEK3W61KKuOtmsy5SL7bK0nmJEbQWTD8AXudHixjUkXvWumhFfvef0MuwAYRpaFsvfot44Inq
 2nRS65dQynqxdxOaaUw==
X-Proofpoint-GUID: qNmTM2DPI23-pEoZD_8-2AtkuhHKLX5I
X-Proofpoint-ORIG-GUID: qNmTM2DPI23-pEoZD_8-2AtkuhHKLX5I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_02,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 bulkscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609010088

On 8/31/26 5:59 PM, Aniket RANDIVE wrote:
> 
> 
> On 8/31/2026 5:08 PM, Konrad Dybcio wrote:
>> On 8/31/26 1:12 PM, Aniket Randive wrote:
>>> The console port uses a fixed line number and is not allocated from
>>> port_ida. However, qcom_geni_serial_remove() unconditionally frees the
>>> line number for all ports, including the console port.

[...]

> Thanks for catching this.
> 
> Looking closer, this appears to be a separate issue from the port_ida fixes in this patch. The dev_pm_domain_detach_list() problem already exists in the current error path and is not introduced by this change.
> 
> Since this involves power-domain cleanup rather than port_ida handling, I'd prefer to address it in a separate follow-up patch to keep this fix focused and easier to review.
> 
> Is it OK to keep this patch limited to the port_ida fixes and handle the power-domain cleanup separately?

Yes

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
