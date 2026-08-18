Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C5C37B02A
	for <linux-serial@vger.kernel.org>; Tue, 18 Aug 2026 07:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787037809; cv=none; b=ZuVV+yjnMjrWkNofhqsfEAAwsxUMaRqVp5X1SQYMytnc6mvq0pzoLeUh0d08OFMaNQiF8qa6OdOFobq5NwViXIwswkNp154w0RhaY/5lHYvkcZDucglfLaBQiyxXBeqIS3XRdOBhnDP9DxBEvooUVRnPmpSgXc0xkIFa/X4N1Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787037809; c=relaxed/simple;
	bh=Qml224tHKA8pz6kM6bxIVffaV1GkYgFiaokw4YNBcMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tHnoaSB6C8VN8CXgDQZyCSlopVH1bl4dnYoRDHB0iTbT7htiAnbUZjvKWzSaZ4vmSRxVazsqjDuWvFmQUE3vvl7CUh59CKKu+eMiAe2b+ltgfJymtPlYS5rsPvGOouN3N+yNsdu9cq10WHsjyMBK6DRPDLZyOFpEOhL5fThG37k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DNf2B88j; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=axtm2+lO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DNf2B88j";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="axtm2+lO"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67I7EBa1932380
	for <linux-serial@vger.kernel.org>; Tue, 18 Aug 2026 07:23:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Qml224tHKA8pz6kM6bxIVffaV1GkYgFiaokw4YNBcMA=; b=DNf2B88jZaakr7VU
	jYZn2hisSZSEExDZXc9G2lZX+A8xGtPgjALNSIU0avy7MWMBGnilYd9f9PWjgf3c
	Nmsj9D4sktc5BJDEeZjsZXe0Jlp/b5sBHY4ZD3HKGLs+zfJDrd7DJNQ0REu4jtBV
	q5RaHVxAmiK0FFKntHbBvYtGBoiEjjK29oDoHmWlzPlePYCzhI5XHysuS1ow2Nab
	FcYtTWDJHkKBcdUY/7g8SgVxwi7GgJP5TmYtawyEy5fM/Qi7exn4j3reIR8vEaDz
	EedVt60t7G5FyUceZ1WUU26s+3BjF5UiQpeTFs8X5IrJsUyp28i96QY1k/QwJlR6
	r4JC1w==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4fvp0tw9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Tue, 18 Aug 2026 07:23:26 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3823dcc1647so6290568a91.3
        for <linux-serial@vger.kernel.org>; Tue, 18 Aug 2026 00:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787037806; x=1787642606; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Qml224tHKA8pz6kM6bxIVffaV1GkYgFiaokw4YNBcMA=;
        b=axtm2+lO4kRkVzclyJeMz6w+JS17G52V01YeDrgqWA0KRZU4oFeCW+P3jVdtARQpOW
         hpeZmRDskWFVJgAavATZHkZNw4DF0Ulj/vD9lCSc9X0YhDp0C+5r3qR+S31aCrkkmVuJ
         CuoFCk74DpuvtumkcG+O1ZCpbV0FkOCgrAUrzu1H+WfhPmFi23dVKrzD+vYk9UvKVlD3
         g02wO1197kvIERuHMlE5oztlCzF4zdQqY8nTUzYj4rvTGiR8bZ900EyTBFICFxOCmNu7
         6YLJ9cNsuFgnR2AolXCUQ/VOeYutXB1Bbbbuv2HJZ5vc4h17fwvi2fKxnXFepgvGG3Oh
         A1RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787037806; x=1787642606;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qml224tHKA8pz6kM6bxIVffaV1GkYgFiaokw4YNBcMA=;
        b=sitxiELQCZPprowNjiys3FErIb8ETew/VEh4kZKenoGrcWCEWu4d+XgcbfRLjRsATP
         g23BXUauiaJBJOna7Xy83ywGuQazfFdbk8fphsyK/d5HF8uTkVYQ2l0HUfD6IDsWkIbU
         cp1E1fJPi5g+IEiS24bSvq4kzfunJkGelK7x59UP39FxLuDEM+qpZlk4YR36ktuTkDh2
         5+pk7cTJ/9/rZfsP5D3ja32ZVsO0+ePBpX+iW+SxVx6c8Gnvcp3vpYMo2vaWG0WrOZjN
         j4fKEdGArQAXYdGyuFyHSSpy50Gt2JdwwX6TCMasDQE4ikllabuxqJdJ7gztgonIcoj3
         1cKw==
X-Forwarded-Encrypted: i=1; AHgh+Ro0B7Plei3sG41T9S2xCdsS7rOfltZDl5ISjrEqKCNgVQyeyHV2tjOC3wFn4MG2Y9BiYtwyWPtsIrgXOCU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyln++exHN1kqvaxSsD3DEKWXhOsGmbjigsxDEIWAQClj5jpE9L
	gGeKH1XndzhA853Znydxt/95QRIJT0rkxaj5QKqigE8d0oicnZ5WtoUq26zZ8qdnR5EjTsMI1wc
	1IgaVcpcLwvE1rOI9eOOvPSI0uOGG+qHSWLSfH4eBIRULG9OiYBboSLQxKUVffMtTesI=
X-Gm-Gg: AR+sD13VW9n2t3jazO3DSBZFofSHOWtoTOCyVJZtTDnpZ4q9T5mNMvd1bEojuj8KwTq
	t2EAH4exnqjRljcovk0rv5TDSV80m2sShiE5LrSkHqCDX2H6sqpAdX5sMBz88nqnpoQuR3ILmC0
	7CTZ4UUIiMjXPOVjLziEroYm3s4s9kOSoUHB0weKJepEWikcVZrWmZh+7ztFbcLg4pC2bSPOw9q
	bksDQw9pAT0YYChi9o7RsUBSuxT8GieQaOGaSgdRIU95Xg4PMsKOkgtggQJVk4iiB8Rr88NdAL6
	f6vi/So8Rle8iGOpnG+v7t86bBPW8S8jEO6ad+/BUq1hfHN5xYuCuvwTedhCtkjxViuKnuNcpa2
	FkOsD9bsh8Iok/ExyzvWZY2c=
X-Received: by 2002:a17:90b:524b:b0:37f:bfa2:1887 with SMTP id 98e67ed59e1d1-3933cb3f7d3mr34521481a91.8.1787037805970;
        Tue, 18 Aug 2026 00:23:25 -0700 (PDT)
X-Received: by 2002:a17:90b:524b:b0:37f:bfa2:1887 with SMTP id 98e67ed59e1d1-3933cb3f7d3mr34521438a91.8.1787037805386;
        Tue, 18 Aug 2026 00:23:25 -0700 (PDT)
Received: from [10.239.97.207] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39339d00eafsm6844315a91.1.2026.08.18.00.23.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 00:23:25 -0700 (PDT)
Message-ID: <53126b4a-09a9-443b-bfb5-e7285494aa7a@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 15:23:20 +0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tty: n_tty: use kvzalloc/kvfree for line discipline
 data
To: Jiri Slaby <jirislaby@kernel.org>, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        stable@vger.kernel.org, liulzhao@qti.qualcomm.com,
        cheng.jiang@oss.qualcomm.com, cxin@qti.qualcomm.com
References: <20260817135526.386863-1-xin.chen2@oss.qualcomm.com>
 <20260818070324.136726-1-xin.chen2@oss.qualcomm.com>
 <2e072c67-9d42-409a-8c24-82e88dd01418@kernel.org>
From: Xin Chen <xin.chen2@oss.qualcomm.com>
In-Reply-To: <2e072c67-9d42-409a-8c24-82e88dd01418@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 00de-S7VHK4WPKwx0LYzBofZEMMCgRYO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA1MiBTYWx0ZWRfX1N/5cTJvzWDs
 Z1pgZcTwv1OEKayFaJa3qj4g3yxy77gWGza2gJnyMy33uKaaGRa/3P6FUvBM6BmQnoepLU6hMQn
 gnvAfx/5djKe/oNxhVD6KefEEuodqvW2JgClBZQHFK3NhXzPkYmqXuxmi0n75JK0q9j/T8iU8me
 zCXgvnljzs00AfRoQQMfsFUlCrHcn32PXJNizsD7VOu/XdlZdujQ5OQNblhv+mU2cvLYjL/g+6L
 r2wNSInnMfKxvHPWjV5bjnTevONL+liYtNDMMDc9w8KxxV8F6dSUngHbhijYqHcYkPJBEK59/GN
 QKmSKwQo+jN9NZY8WyKcEVU6cIXdX+y8F96l5q0myoRSBLTnfvSsuYrIqdSyYun13nR6YpcHNqc
 MPQIDyqV3xnvtuKz+BFa4UrFPV8PPdUGNUR2TEWMXvmAIzy2ch4n9PAqo2AmBzmP/yzx9XEZDr0
 hixxiOYiZUY6Les+nVA==
X-Authority-Analysis: v=2.4 cv=K/IS2SWI c=1 sm=1 tr=0 ts=6a84086e cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=tjhzb4fLYD-Z8NmU190A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA1MiBTYWx0ZWRfXzAufpFDg8i87
 +ETqZLYSZtmuaHohMIkLlP3xA1G0+5WF9ZclihdjesrYREZMJnb+Lp9AMKabAM2diNaq7HzVs40
 5ZG7McjrQ81MFbJRpFYLF9gy7Xs2xdM=
X-Proofpoint-GUID: 00de-S7VHK4WPKwx0LYzBofZEMMCgRYO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180052

On Tue, Aug 18, 2026, Jiri Slaby wrote:
 > Switching from order-0 to order-2? If you ran out of vmspace on some
 > 32bit platform, perhaps. But you apparently did not. So all this
 > feels odd.

To clarify: the concern is not vmalloc address space exhaustion.
The issue is that vzalloc() allocates order-0 pages from the buddy
allocator via the bulk allocation path (alloc_pages_bulk_noprof),
which uses ALLOC_WMARK_LOW and does not perform direct reclaim.
When two back-to-back vzalloc() calls drain enough order-0 pages
to push the zone below the low watermark, a subsequent
skb_clone(GFP_KERNEL) in hci_send_cmd_sync() fails silently,
leaving hdev->req_skb NULL and causing BT enable to time out with
-ETIMEDOUT.

kvzalloc_obj() serves the ~10 KB n_tty_data from the kmalloc-16384
slab, which is backed by order-2 compound pages — a separate pool
that does not deplete the order-0 free list that skb_clone() depends
on.  The commit message could have been clearer on this point; I will
improve it in the next version.

Thanks,
Xin Chen
