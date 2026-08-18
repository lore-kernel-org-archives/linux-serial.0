Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9973659FB
	for <linux-serial@vger.kernel.org>; Tue, 18 Aug 2026 06:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787032971; cv=none; b=XRFOFaDBudKf9w0UKiWaWl1kHzjgbhjJ4LeIXbvESHQauLC7rO8S86PHl1ONI3Gmy9pHrD5QfwuAkBXn1mZDJQXR6PZ49r7trxsNj3m9bV7FRI0BM7hEbvxN1P1KKt2hNM/7MzQkBn628uitN8GVXmQXfDPdCSQ+OvSZLrY0/RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787032971; c=relaxed/simple;
	bh=wzX1nnf3m2Gv5x0im2s26nctIc5VlXhrTdMZfkyHW7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M4wKxn+rMlHtC/gYlpDoZ7zwoLHWUAuKDZh3+mHBYIIDlrZ7gT+8cQa3MDJlEmIAezN3HPcho+LRbg8IMuSq6jLpT512SdbSK4Wv4WcXuVu4diPgi9kr9sphpQHWX0+6ebmDr7R0AnOPlLq2p0U1svHOAsN4fPnZBqIsSa2uCgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=opauK5G3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Fcg4lktQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="opauK5G3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Fcg4lktQ"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67I33xfv3298927
	for <linux-serial@vger.kernel.org>; Tue, 18 Aug 2026 06:02:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wzX1nnf3m2Gv5x0im2s26nctIc5VlXhrTdMZfkyHW7s=; b=opauK5G3rd3DyUOR
	SVuWPNMFrZieOh2MFUoDgyo+f9WI95Bdv8+BrJpLokBxUWy1IeZcQUSDXFP2ZHSN
	bUef76k5xPMs0ayUlxdmMLkt4QigyM37oApHpcKEZCvua2WP0PfigTBaQNAiWdzJ
	V6RNyTgvDxHfsQSDZkTDERe1WLcSFPTpY7dkxWJYsKGVjc9IQoczfJ4ABn/vFZBW
	48BxcFEtX84Xis0Tl9K9AZ15FEA/m+W9w4R6JTvTLNJdllzb49A3cIkrsHhYvt1m
	lLKgNodhMgjgqFBZg9dziDnVvtoz2VJkB504LtNG/Ow9CNWGxEoI09q9ROvIpCqw
	R6bufQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4f5prp16-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Tue, 18 Aug 2026 06:02:48 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cc7e86e7c5so76707585ad.3
        for <linux-serial@vger.kernel.org>; Mon, 17 Aug 2026 23:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787032968; x=1787637768; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wzX1nnf3m2Gv5x0im2s26nctIc5VlXhrTdMZfkyHW7s=;
        b=Fcg4lktQPvSbqGAH5lQImkF3+qTZYcU7386MRCBZcrwJVEzO4mbStmDJ3Ouf/vbwjL
         3i+QIFf1DSLxrrMBO+izGJxUxsAUXj6tscYfzJDj3ER6EGn5rNdWklz66tT6D16qksIT
         3h+et7GAnLl7RTCcepIgzjT/lVNhrXfHrVIEeoXFWQ4baJpd69yS3Unol/0VNPXkZgvm
         f8/A+3uKZICoyAjipObesPZAaDtbU7PXC8JNqIa+Ge0A3OZCW1sjmCGIEantdh3P7A+z
         mhGEn8WJnQz3gyDd1nSxEP4bz0j82BiLnrGhhnjqAXk4T1irXPwY5TLgKOqo3xgYqaOi
         zykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787032968; x=1787637768;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wzX1nnf3m2Gv5x0im2s26nctIc5VlXhrTdMZfkyHW7s=;
        b=BmfPZ82IiHfBxXJaaOZfj+c2fCc0apgxvTVW7Xd3fv3BQs1Kt7CWR94GaZXXscrFaR
         5FWB8rxIgZqJgKolhNxt4Yrn0R7gU7DEUQkgmOFqfEyDqaLkqPexY0j2/U6pbdvsnnaf
         bXQMJCov3ZuLitGzxC4JRGlaWj6MhqbfIP/lZiLCWMAzcwi81sGcyHdP1R8Z5g11Mi5t
         6fSYiEYr1EQcku/Rw2wrbtVn4zYPRb6XkEVmpm0ow1wD8+sDbMrhAW08mhu26/bkkixG
         5NM6mc+a+0w56q+LxIW4u3aNhTWXfnZ2crexM2TSWV4lE39V2vNKlTz4EM3gngu5O00Z
         CR+A==
X-Forwarded-Encrypted: i=1; AHgh+RqhXCqrPUFb0XCDvZsjR837FGAjh9dd5F2I5Eao2dH0v1uUxajL4hcSLOMgftYPKcK0lCOd3Og3eTxmnh4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcXTQt9edMsITIpArCUmwJdYu9cRXL4k0oiRo23ioCLE5scj7p
	ATfX098OWgKB+R0vbGcw/eSjS+SKdUcZf6ZaZ5yNFF9ev2NwsVhrVx0plKytAWOL1RJloaBsyca
	zSNGTs55hyNG4PhTG9f2Se3/NR6dsGtbpFbK6DcGxerWmv2y8t/kbKwdI3/j7MQyIbFQ=
X-Gm-Gg: AR+sD12/6KqoqadxDZxsv6dOqJISsO0R2/Vl2olcpZsuiQY0CH0YPhOaqp5K0EkvV3j
	yLzRVEeXA/8ruMwhdGzyEo3ZOX1mQ69eGstFsk4RZBKPDMedVdaoraycMj8zAJpUNyytJJVmAnu
	ZftGGFnP5Wpq7V+XqMBBq2RUdE/OFngSIkWYFKnhQg4XlHFI7Z/hITkaxspkf7apgI5S9MrHM8b
	Z95fBBbRghHtHuYJPQpVjSwzgLI7n2di7BNDwglWzu9R+2tKDfnz4vN6GzY9gBO03f0mhM/VCbc
	3By4w18x8cXk6eIr5N4C9PVDXcBWmf1gHx+V94xM1e7R3DlM5EPw0zKNPXGCRW4BsfQcIkfQBqC
	wKoz8M3MCnFZ0yr3UR6hHcbY=
X-Received: by 2002:a17:902:d4c4:b0:2d1:1a18:4d0a with SMTP id d9443c01a7336-2d3b0874a8bmr293429655ad.9.1787032968380;
        Mon, 17 Aug 2026 23:02:48 -0700 (PDT)
X-Received: by 2002:a17:902:d4c4:b0:2d1:1a18:4d0a with SMTP id d9443c01a7336-2d3b0874a8bmr293428755ad.9.1787032967818;
        Mon, 17 Aug 2026 23:02:47 -0700 (PDT)
Received: from [10.239.97.207] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d5bb499e12sm13421565ad.8.2026.08.17.23.02.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 23:02:47 -0700 (PDT)
Message-ID: <066081a1-e644-4b01-86c5-e5ab908a7754@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 14:02:43 +0800
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
        cheng.jiang@oss.qualcomm.com
References: <20260817135526.386863-1-xin.chen2@oss.qualcomm.com>
 <2026081706-tricky-slicing-166f@gregkh>
 <2026081747-secret-partly-158a@gregkh>
From: Xin Chen <xin.chen2@oss.qualcomm.com>
In-Reply-To: <2026081747-secret-partly-158a@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=S+/pBosP c=1 sm=1 tr=0 ts=6a83f589 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=rJFLmW8hIwzoBhnFJRUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: TkOwX5H5I0f1VfHYI485wSkjsGyGB4HZ
X-Proofpoint-ORIG-GUID: TkOwX5H5I0f1VfHYI485wSkjsGyGB4HZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA0MyBTYWx0ZWRfX1/eXW+cupJav
 YrxnbRai+KzFT3XxKARymfYUU9P++7YeUEavQgE+XsmjEwPOyGJOreJZO1ZCE4JOgy/gLNoTFKd
 WVfMAcPyNeMSvE0cU0pFMJjHxHvkK6niDlj6hZv+/hhI5DbRSKfNes41XSHIAvtFDUkiCemLkYg
 xlPSuHAudlZflyVKFA3hTUbcsmYfG8IDufjpZWZAGvt91y4BNgnMnSCAqsODgWl9utazRMVsKtz
 gTzNmYApPNeUeN1wqm1pgMVaY7N8Lk0Vu7K6Ddgp5zlMvCRTRPknI4YoJR5hmKGF3cylxy5K0m6
 PxAoAwxcqr6JTogFBCIXGQLmLpfCgvTl56tRhrNv/3zWCBEWDyP+v+m4lJqlOOo34QC+2t3NaxT
 nJn3Wj7JkQ1NTX0xejw0gR5h2dZ3/IhBekx3m/i5pHnL8Z0GEeu4htldHLYbbJrJ09MRWdcZo93
 kBxwRZdU8LaeLmWW5PA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA0MyBTYWx0ZWRfX84QMWHepUE9L
 jqDz0laXveME3MV7W+JAqfxvtbPklztgtfEAwwvPsMQUoK0cMxb6hYfFLq1K064bqs2n3+6vUDC
 pKuaufQu71C71iXzouDhiQZXkB5mHSs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180043

On Mon, Aug 17, 2026, Greg KH wrote:
 > Also, you are papering over the real problem here.  If this one
 > allocation is failing, what keeps the next one from failing and then
 > the skb will not be able to be allocated?

The key difference is allocation size and allocator behavior.
vzalloc() always allocates page-by-page from the buddy order-0 free
list, so two back-to-back vzalloc() calls for ~10 KB each consume
~5 order-0 pages each, transiently depleting the order-0 free list.
kvzalloc() serves the same ~10 KB from the kmalloc-16384 slab, which
is backed by order-2 compound pages — a completely separate pool from
the order-0 pages that skb_clone(GFP_KERNEL) needs. So switching to
kvzalloc() eliminates the interference between n_tty_open() and
skb_clone().

 > Why is the system so out of memory in this slab that this is
 > happening?  What changed in the tty layer to cause this?  Or did it
 > happen elsewhere?

Nothing changed recently in the tty layer. vzalloc() has been used
here since commit ebec3f8f5271 ("n_tty: Access echo_* variables
carefully.", 2018), which replaced vmalloc() with vzalloc(). The
issue surfaces only when serdev_device_open() is called multiple times
in quick succession (as happens during BT UART transport init),
triggering multiple n_tty_open() calls back-to-back. Each vzalloc()
drains order-0 pages, and the window where skb_clone() fails is
narrow but reproducible under this specific pattern. It was found
during a BT enable-disable sanity test that repeatedly cycles BT on
and off, which consistently triggers the back-to-back n_tty_open()
calls that expose the issue.

 > And no cc: stable or Fixes: tag?

Both will be added in v2:

   Fixes: ebec3f8f5271 ("n_tty: Access echo_* variables carefully.")
   Cc: stable@vger.kernel.org

Thanks,
Xin Chen

