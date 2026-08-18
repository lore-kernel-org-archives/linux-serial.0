Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66A030C618
	for <linux-serial@vger.kernel.org>; Tue, 18 Aug 2026 06:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787035184; cv=none; b=jdmTRptf1G7dpB26BosQKSyzU0d81VCkecUSeQIhLKrC5/AiUTkSyYYfy4YbsQXCgcrVOGCzxcg+sanuPnd3YEg66+Lf2s4qbL0MFEHF7VqfvtnFxoG4sI5yKwd2eLtHkQe+IZ2MuGTZ4RBeGqD/otvHy6kxz/yItSl++TQ3d+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787035184; c=relaxed/simple;
	bh=s9l4mDPEH4t3IYZQoGYBXeULBj6e1vAAeVBjHlUHAzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q+wln4eMJI2aBO7ijZ9O+yYbQAH7eug9GvY4tcK10p+sW37Nmj7pDtXCmz5ixjEf7PMZOVN+y2b3fqgtlboJ9HPGX5fmbYshC3sH8afzEZXXFDu2mb1T0AmuerGM4mOlrxrlQqqERR/DzGxipidnX5P/1XueZfxceYqbVdVLhkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DxFhOxVk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=e2Y9dfcX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DxFhOxVk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e2Y9dfcX"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67I51AAp297845
	for <linux-serial@vger.kernel.org>; Tue, 18 Aug 2026 06:39:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s9l4mDPEH4t3IYZQoGYBXeULBj6e1vAAeVBjHlUHAzU=; b=DxFhOxVk0YabJkVv
	pae1l89uibT1ZZLpJ++qCTjPRPnU7FzRxIjsZJ1h4VGHp4zibS+IQNdhOFKGJTHe
	vpHLyhjgqPrkDjVIpa/sqjXf8YmEsLlJTGrAI/i6yRMJdv5Q5qmAMh8pt1H0XRV0
	rw0Vu5tv8CFpyJmOJrRbS0l+it2lvGcxPZsnOioA9d7E6LT8OGfX6vMk/fzge3jT
	h65gAlVlsWtOi20TV0U0ezhT/sCUY8YyU8qgUEy/q7SxmXNQ1BJcZa3GtpnfpULz
	5tZ8JOFLOgd/72QkquE/HWvX+RqrG7NmP6A+X8TCiEgfntsejTifufUw2N082q1l
	FuU63w==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4dcn1949-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Tue, 18 Aug 2026 06:39:41 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e5a616d07so4910215a91.2
        for <linux-serial@vger.kernel.org>; Mon, 17 Aug 2026 23:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787035181; x=1787639981; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=s9l4mDPEH4t3IYZQoGYBXeULBj6e1vAAeVBjHlUHAzU=;
        b=e2Y9dfcXvAiqosMwGvvfbf4lqzZl4ZHR0tSaAUE5XiHSQocHVoux/zIBrHn7pdSnLR
         3S6vPvXjhR3FJCm+pCXarGJtCZfeEBBp3RUGEbNq0GuL5xkVxtJdlO9Ws9GQ+4El8VG8
         8n7yyjNv3/H8+uwVhigorkI3QQy2DUU6IUgxplSpuINhF1aB+b8cBcKUcLGvytmbEmLg
         e7gsERki4yW76hqLZFmOH2wDzg9NtfukcArKuw1xXoE0dQ23gpHd5EwEvVMpXrJrmhH7
         nllnYeJWwLRu7eViqN9h3KKassYpAwGoPPb+iYLwaCz8Pu1FdDyOrHvNz/b0D6vo2mms
         waiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787035181; x=1787639981;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s9l4mDPEH4t3IYZQoGYBXeULBj6e1vAAeVBjHlUHAzU=;
        b=AZeyfVOWg8uK+4dZV6TaQv2en8Y1NA9Rj00CVPRn6RNFXA2gkpdQ9FJEXxkulgZiVy
         Y3UzBmninVKIqX+/DoIX3e+h5S4QECpzTWoYoTyShz7tLpJWQqy3h1jW/Uc0ec4mx5qf
         7TjZeRfIHyc4bQ6oSOU0mDRT41ISUVlYLYdxFfOJzjTg3OKh/dZRglrpfGxy6xx1pfXy
         j01vtGmnRkSi8y7NKyUsB/GfzC5598B0aC2ACMu9jEhoef/m0J85oPuQVcGdIY6IEvyA
         nG67XidMhTgX4JuMgL2ofY9rG7r8M3RhTtoEB2xeVCw0AlxuZ2L1IJ3rMTAOb2oEX8GZ
         reKA==
X-Forwarded-Encrypted: i=1; AHgh+RpdniwY0XmdYyeIOS1rQaecTTqYbPrpLo+6aCy/VhwR+9s/hl/Ak9gtsKXQMaW5nxUZopdRdVGnBrYvWCw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy09QPeY9/gH+y29u7G0jZsa/1jPCBk/kjRDdkHEcVsLCHOozSw
	uEKbzbTIEmRAFJz29lnnao/NgU3tFSdq18BrcsFiy49SDA0Vk0MI2S2KdBO5KggGiq+HzmjjFFd
	TUWXB0ARNFcgZ62O5wZ73y8r7atDnQ79n+p/25xdnIzg9o6jvwXykXbdV3t41U4ESZ5U=
X-Gm-Gg: AR+sD11biB6HnnRTLEMI48ZJrhg+mjO0Aeax7nVJrb3gXpJk3Zm1+ZWkXvgKLz19QAj
	GUQ7cP3NDdP0+5TppS5utyJkJ5gZFtAyQ2gf1di600L8yNA38S2ojf+giZeykoPY0vrrYCyKrRz
	qqBHErG47ZMsCbdghxt3BYpHXeZUXsibYYUEiMyjE2DizSiu5cYBwZ7HAQVylMxWkFgHFkxpsli
	gTvWDctsXaF/air6nXaWgJ3RNi3ZGcnxZl8vY5ltjcG9IbqUtBh27kWzW0ueKZhQtNWnbc8rJGb
	66nY4nKyPTwt30lwXvbAxI+nLcYQ10nJOxnbU0sASP9aFSk5o1sIAaz+DL3SA3SIODxFSJ1S7TU
	5uj7AEQz6nyG/cbTL3mNsEQ4=
X-Received: by 2002:a17:90b:3147:b0:38f:1a2e:6e56 with SMTP id 98e67ed59e1d1-3933b8825fdmr28351622a91.9.1787035181180;
        Mon, 17 Aug 2026 23:39:41 -0700 (PDT)
X-Received: by 2002:a17:90b:3147:b0:38f:1a2e:6e56 with SMTP id 98e67ed59e1d1-3933b8825fdmr28351580a91.9.1787035180701;
        Mon, 17 Aug 2026 23:39:40 -0700 (PDT)
Received: from [10.239.97.207] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d5c1e8dc12sm10649375ad.56.2026.08.17.23.39.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 23:39:40 -0700 (PDT)
Message-ID: <d81e6acb-2e88-4bad-bc49-5259e16d3cf1@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 14:39:36 +0800
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
 <2026081706-tricky-slicing-166f@gregkh>
 <d2aa3572-e3f3-44c1-816e-a95bbbc77abb@oss.qualcomm.com>
 <2026081841-relation-barn-304e@gregkh>
From: Xin Chen <xin.chen2@oss.qualcomm.com>
In-Reply-To: <2026081841-relation-barn-304e@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 6vwaDh2oMfQGc2y1m1pwkQKArCIwS-On
X-Authority-Analysis: v=2.4 cv=Gs5yPE1C c=1 sm=1 tr=0 ts=6a83fe2d cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=IRcymfdx-6Cw2LxaQ3QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: 6vwaDh2oMfQGc2y1m1pwkQKArCIwS-On
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA0OCBTYWx0ZWRfX9j2q0ye7cbki
 Cno/6BuFKip37l1nxm+G96J8rezM9yeB26U4YYDiqZ7BrgTgM9r4E7QqYIkTLov3sLPLyRqACyq
 DjITT1NMKVtdjV/zkZPBN9LILCk+3wLpQO37lpS5yqG9wpLWLsFQ8YKU6rLSSugkVGs7is/++uh
 DD2+kjC1dx3jj2TfaIk5vgBhgIwPCY4TXw0Wt19ebGgTC4t7uYhtdPDMopKSBtxnhRA5azEQX/+
 XDoYVSoBYXKdEWYAtmmxEgjZGqSyTxTPXCUz87BwxDIzr/IyaWmsatyxcvm8BK7ty1mpDrDDnj4
 AJsiMk1an66KhRxUCS9S0yHib5kkcT/fyYZiHARy575swwqE70E3VNw1VbWFbNfQpLHTS7E2dfN
 U6TkOBkqhGZcAavbCwcPTmd0pLE75SNoozWmzo4J89etda5VcNhaEiLKtTMHDSeYaV45+H5mUi2
 iz0UxzuLNdNSvJJ5pIw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA0OCBTYWx0ZWRfX4YIYVr80qjry
 8L9G8KKme22zWsMg36thEfe9yk4M20nksfsQzyt/ZS2e6xrkS8D/EID2Q3xyHzpfcaSgHi18/9z
 ou6F/NqnHTy9PQEkjbsOVO/b+8ikuug=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 phishscore=0 adultscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180048

On Mon, Aug 18, 2026, Greg KH wrote:
 > What specific "damage"?

The specific damage is that hci_send_cmd_sync() calls
skb_clone(hdev->sent_cmd, GFP_KERNEL) to set hdev->req_skb. If
that clone fails, hdev->req_skb stays NULL.  When the firmware reply
arrives, hci_req_cmd_complete() checks hdev->req_skb to find the
registered completion callback; finding NULL, it never calls
hci_cmd_sync_complete(), req_status stays HCI_REQ_PEND, and the
waiter in __hci_cmd_sync_sk() times out with -ETIMEDOUT.  The command
was sent and the firmware replied successfully — the damage is purely
that the completion path is broken.

 > But it's not consuming them "unnecessarily" as the memory is needed.
 > Why not fix the root problem here of having this be called so many
 > times that you are running out of memory?

The repeated calls are a normal consequence of the serdev open/close
retry logic in the BT transport layer; constraining that would require
changes in a different subsystem and would not address the underlying
fragility.  The real question is why skb_clone(GFP_KERNEL) fails at
all when the system is not truly OOM.

 > And why isn't memory being reclaimed properly if we do not have any
 > left in that free list?  The allocation can sleep, so it should be
 > always succeeding if the system isn't truly out of memory, as you
 > imply it is not.

This is the crux of the issue.  vzalloc() allocates order-0 pages
through vm_area_alloc_pages(), which takes the bulk allocation path
(alloc_pages_bulk_noprof) for order-0.  The bulk allocator uses
ALLOC_WMARK_LOW and does not perform direct reclaim — it is
intentionally a fast, non-sleeping path.  When the low watermark check
fails it falls through to goto failed, and vm_area_alloc_pages()
falls back to single-page alloc_pages() calls which can reclaim.
So vzalloc() itself can succeed even under pressure, but only after
consuming whatever order-0 pages were available via the bulk path first.

The problem is that skb_clone(GFP_KERNEL) in hci_send_cmd_sync()
is a single kmalloc-backed allocation.  It does not retry on failure
and has no reclaim loop of its own; if the zone is below the low
watermark at the moment it runs, it fails and returns NULL.  The window
is narrow but real: the bulk path in vzalloc() drains the PCP/buddy
order-0 lists below the low watermark; skb_clone() runs before
kswapd has had a chance to refill them; it fails silently.

Switching to kvzalloc_obj() serves the ~10 KB n_tty_data from the
kmalloc-16384 slab (an order-2 compound page), which does not touch
the order-0 free list at all, eliminating the pressure window entirely.

Thanks,
Xin Chen

