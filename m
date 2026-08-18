Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B78377AAC
	for <linux-serial@vger.kernel.org>; Tue, 18 Aug 2026 03:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787022671; cv=none; b=HDDVjuUNPCi8ryjR0DrCggjisZSMYzR+S6OEMSw3Y0E2IeCwGii8legXwS99Uk7E+EpVXbdUv74stq8t/rVkJZJVBIxG+L6n2x6XJYstCgpCnigRzqHosSZwftq0pqS8Ij9uzIClTQ1TvzOI77KcSk7twjQqzQWBfvAzfAOC9mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787022671; c=relaxed/simple;
	bh=t81m6RtUnbW9ZXXIU+Lv8bA5P9pkYsHeKvjC27vSb2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OCgTcNQgP0Ng8NzhWEkk0kjE8WrqxLMCde2IfYV2F2gtJ91tEMbd+BnYsGPCuLCwhlJwAzjUPoMuZvgFlBbvl29hnFFnFG5TUV3HTHc+qbDtYxfIuc9aUv3zQJy/cM3cTQv9u3VJYVQ7gKCbYDk/8OE0838Xui3l08Mm4732ubg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MyK9gjcP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CRBVXJuk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MyK9gjcP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CRBVXJuk"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HLkm5j3566667
	for <linux-serial@vger.kernel.org>; Tue, 18 Aug 2026 03:11:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TRDJfBnc/t6leuJ4M9qAATPn1iC88dAfmLD8DYt8TCw=; b=MyK9gjcPyXMGOyga
	yxfxkJ+cd/BjJPLjr4lLHENY1G5eoHJCoeN4RcQW1NRWeZSUQE0RpuI2fkKc6lCQ
	9SgtQDUaFKbllhsHIVxdQq0hH+6H8CiXb0tVivAuRDMa5CawNQP4DwoqTfON6jMB
	o39s/NsKLpLviw5l7Pd/IFId+d7HsplpS3uJ3IIpaE4QJyt0aZWDokzhscImbYrb
	vaVYuxbblpDJzvprN6MvAtEaGW0Vf/8FTXpDkKjZqvSo2VX9diqak7LAMn2K/Nth
	4YPBWq79H5P7oqVasTYJrshzesdtTqQ04QAWJRsrPygHW6XJlzekTHZ7iWVL1oUS
	6fjYtg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g48q0sgrm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Tue, 18 Aug 2026 03:11:02 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cbedf6e8a42so5348298a12.1
        for <linux-serial@vger.kernel.org>; Mon, 17 Aug 2026 20:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787022662; x=1787627462; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TRDJfBnc/t6leuJ4M9qAATPn1iC88dAfmLD8DYt8TCw=;
        b=CRBVXJukkC4Uw4UAcpk2bz2GMe+e0N5myynv3X8XjCretl/Zci07qa5oNtmLjvgdzu
         1cXArjGHQOI3Vx/N3EGdANpV4bzQHW2z/ZM86o3dqtdNNNu5mI/lIgMo4+L7yH7c64ge
         CQ48ddqqyR/GfzGwR9H+ybgBg/5uE+KFe7FACln65CgJ3DP76p5OzQChspjvr9GMlFRJ
         DRvsIBj9ZiOlWnfehC937TMJ5yxMNKaUKx9unO24+gqeg65ZI6ZiNxGhOg/WnfZZF11y
         M0rMhy2quyI+A08uF5VxT9cwb9qVexZDaAbPMEiR/lXgak26i0Fi4unvWYMqkKANQQaU
         QIXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787022662; x=1787627462;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TRDJfBnc/t6leuJ4M9qAATPn1iC88dAfmLD8DYt8TCw=;
        b=k+4TRRA3knA5RW7ynEydEbVToYM+Y+d+jvwTzZCpzxOA9TQHdqNVcESnWR2Z38PUTR
         mu7x8C3BcTGhI2uThTf2X48DnJShgOTAXR3TF3UbwDja/skBC0AfnOFovC02U3reGHsP
         wFu0yl7l1CwAVatG5byubzsBII2JLCzcXoRxWwxt0ohNjtVxg74w7yGZZF1xKw5TAdMM
         3ih+wpMX2vt/FvHtcqdTUQ0NIM/yHxb/aPa0jZCG6ofv/e6CNpbZ0k58/M7sJPe/G4Pa
         SzVaNnYvkAVk9ef3WZQyrHPaTmunEQxnH2CCOAY60y1473dKH2AoZSeEG9AjwSfyGTLj
         sfgA==
X-Forwarded-Encrypted: i=1; AHgh+RrnFBDQZPbeesv3Nh+ge03w6nWoXWBj9d7F5uDfHym6nyAhwG5V6if44jA8/AcN7p8qyYTbRby+zAQsjOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMulTeI4CEr/9jwS68P0xlxPM014DNVHMQuonK5E0/4gSJn0wf
	auq/1Ldn7oghGpMVshZEYn1MuvQy7Qby0peObygQo11FuFbA7FmDSqLqVgOliz1/grjv/BLdvit
	n5tWlvGK2BGZKxn/VqMDkNmpZ/GBrBnW/h9G+PHenUaGoYeOs+DeWkhfTtz0Uly3jh98=
X-Gm-Gg: AR+sD10RV4G+cGjo0VRMzUuniUhwfoJPA0wka4/a3cZcMUkhKMemb+/VjfOb3rovAy9
	a15H+qB8Zrqnj+qla3JBZT3c7cdawM02hwT7u1wsoxWg8uVjr0QONgzCUAbRhs8/0uqVhc55oTv
	imqhrFJ3jfO8GF/exkJmEG+FKoQHZbJqos/tEuJZ24UgTzy2rSjK0Ly1iEFe8GH4t19uSojJogm
	XGeDRVWOJKuBf5tDqyqdGhME6jmQ5mMzscMQBySfpvNX0I3fEMSMu3egnWmKs6bgeNl+P9Sku8v
	Jra9iqm6WlnSWXn5MiqJZ8vWzii6cvS9Ks0eTeeI96Xa6m3zdsyL5+eONkUMiBZl/g2fr/FrAyZ
	4xlK5fAujnP5kZ6BrmpQRnJw=
X-Received: by 2002:a05:6a21:6e97:b0:3c3:bbe6:95c9 with SMTP id adf61e73a8af0-3ccda7cdfcdmr6695114637.16.1787022661791;
        Mon, 17 Aug 2026 20:11:01 -0700 (PDT)
X-Received: by 2002:a05:6a21:6e97:b0:3c3:bbe6:95c9 with SMTP id adf61e73a8af0-3ccda7cdfcdmr6695054637.16.1787022661365;
        Mon, 17 Aug 2026 20:11:01 -0700 (PDT)
Received: from [10.239.97.207] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc1469e2e5esm146188a12.5.2026.08.17.20.10.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 20:11:00 -0700 (PDT)
Message-ID: <03ebb6a0-2a3d-4260-afec-15e7e9925842@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 11:09:49 +0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] tty: n_tty: use kvzalloc/kvfree for line discipline
 data
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, liulzhao@qti.qualcomm.com,
        cheng.jiang@oss.qualcomm.com, cxin@qti.qualcomm.com
References: <20260817135526.386863-1-xin.chen2@oss.qualcomm.com>
 <2026081744-vision-coherent-8b62@gregkh>
From: Xin Chen <xin.chen2@oss.qualcomm.com>
In-Reply-To: <2026081744-vision-coherent-8b62@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDAyMSBTYWx0ZWRfXzqX6ymPApiXV
 70s5gvc3tXp4U4q/Sx9GRl3nt7SRN/u7/NrMww7jWiY/a9wRSXT3a1UZanuxxdKeWApSOLoCMfR
 lDT3Gd5m1W8CJWneo2J9jvlyMiFYQZk=
X-Authority-Analysis: v=2.4 cv=VuITxe2n c=1 sm=1 tr=0 ts=6a83cd46 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=Lk0QSWXuOjAvIrDGL4oA:9 a=QEXdDO2ut3YA:10 a=QYH75iMubAgA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: anNU97UYS3HEsuEPIT0QIRDEcpxO7E0p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDAyMSBTYWx0ZWRfX2/i7YIL9lxK9
 JQ00lg5KuxG0D/f+1p9Aqi0Umi/8oCinqTCufXUvh5IfRpvu6egPAIxT9SNGzW4+tZjB2IxoRi3
 yLKMZjeNaBa/+ImQleZ1AFJmg2dRTBwxMq85q9kxcz1cKonvp+qwXe9IyZuqLqTJyPIhoVYmGQv
 T0x8t1DF4/uELb7YMc9/EqDCHrNEKb/Uvi48rz/hBzNR03WlQkGR//f3+slNQlS10cTZTyCyDh7
 T4gZ1w03Cnfe3stdEfpWmQb9sLLNm7BqEFxFBqHt3fuLTqUkWpIYTxb90SE3/aSQdwp9rEHLwAk
 e2rzFHtt8Sjtx9U9uBv25joaWyUMSjnBVPIfGIGbzcfdVd6dA5o3U5IHIKMF8WVv6120Xt7ikW9
 or6HFqN1Xzy6Tt0knRQw1bgUgiqeGXxfAZ4T2Vn5VR7DezKp1GgfOEtw0nGxtsTLANaci2anPHL
 PYmmFCH83FmBJvZ5nIg==
X-Proofpoint-ORIG-GUID: anNU97UYS3HEsuEPIT0QIRDEcpxO7E0p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 clxscore=1015 spamscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180021


On 8/17/2026 10:14 PM, Greg KH wrote:
> What do you mean "target kernel"?  This is for 7.3-final, right?

Sorry for the confusion. This patch is based on linux-next 7.2.0-rc7,
targeting 7.2-final (or 7.3 if the merge window has already closed).
The wording "target kernel" was poor; what I meant is that
kvzalloc(sizeof(*ldata), GFP_KERNEL) is used intentionally to keep
this patch cleanly backportable to kernels older than v6.6 where
kvzalloc_obj() is not yet available.

Thanks,
Xin Chen

