Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A63635BDC2
	for <linux-serial@vger.kernel.org>; Tue, 18 Aug 2026 03:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787023882; cv=none; b=hZow7gXGA5P+aN4FETo84VPaIIWALILKvqyMlN9U6hQe+hU74XoZfzd8rIUom1TVIXIJ4FOoYXJ0aD242X/vmTaK54i4IUcqOtT1uXzjMVHM1wBX84kWz2xz4/VF1mhl1spfBNx2UhD3b5diwHbopkBlQi7VoS2LBKyx2PYhi6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787023882; c=relaxed/simple;
	bh=Z3oxHxcTFL5ZtU4TflVlgGNV5nFevMrhFGK6bXSJbkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DdWDYQc5THs2sKPDnrl596YfkMVkN3OZHcyvxgcs53s8S4yyeGzdKjsZuSFROoMQ7YZOW5s0RfhQe01to04crp6h7XDhU6zwkFiYGWM/AADQELkaRdHT/pT2hlUIKLD3pdyptHDBS1OWjf7HfX87GSP0xK/R2tezvn4mjaeGsBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WxE8fowl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XMht2s2M; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WxE8fowl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XMht2s2M"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HLkTFO398605
	for <linux-serial@vger.kernel.org>; Tue, 18 Aug 2026 03:31:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Z3oxHxcTFL5ZtU4TflVlgGNV5nFevMrhFGK6bXSJbkI=; b=WxE8fowl1MucME53
	JfxgfPPtls9KeI83UnUZ9/zfLyrlAGz8+9clyv6w+xA9MbhCLkRCNwLwV529VzDz
	Uzq+7b4SyIUNuQLNF8jfGe8r9EH/kozFrFHsz9YqxvT+Dop5Ch21zCim0rLImLnP
	8zOQwpeltnoR7cKia+AtiyEUg+Dkf1PfElkdKjt1EJt6pPpwvLi0V9KE5uogBlhV
	1VLMnpTT/fHXSqNFxeYa+zlUACV619Mw6LY12KxOE9uM55mzbPzQIp4diha4w37t
	t66fXW3VGPbmjMJzo/hH5WyGlBgacZ5nGvJz8US9TGwifXxCn5MufuztevwovFZR
	T/yaZw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3y7kv570-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Tue, 18 Aug 2026 03:31:20 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cfe48ca1efso56653605ad.0
        for <linux-serial@vger.kernel.org>; Mon, 17 Aug 2026 20:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787023879; x=1787628679; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Z3oxHxcTFL5ZtU4TflVlgGNV5nFevMrhFGK6bXSJbkI=;
        b=XMht2s2MTWJkwLmkepxalz9mYLAJT0Y/JszcpbCiJV6A2D7Tb8nZdcC7VfyxjRdrc1
         WzNVd2Ip7YvD4ViXV6M7FDIPeovtU2RRzrWDi3gv/v1zfhbtfPVN0rQ95uIcqp1UrL4n
         +DBaHwMX3BGt+/AqRW4/asmTLDpKhrlxgpbtprgXQb9Se21F+vWs7gY9K6UACBWrd0vw
         MRCn8PFsIGJ7kZ4XRBjoljpDUQ1u77Z9E52/cWjQzf2eQWAd49ts1dyWbTIhmtQK12zj
         tCm1z6YCF5YOKH2xenJSqIW3sJq0xuRl5Axvy5pQsHBdsAmlK8/ibBqXFTBY8pNUivY4
         6Geg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787023879; x=1787628679;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z3oxHxcTFL5ZtU4TflVlgGNV5nFevMrhFGK6bXSJbkI=;
        b=daOizGAt3ohxAGj0CGpzEaQnWF0DYu0rXvGd+yjztIOs9xfxjDdSoyrWvA+VHhHaHg
         gru3JjU0H9iHTHP0sh8xi2DvEq3n0qOTqN+kp7ZLqdGbr1FZf1kb9b+m1IA0mVJdUv0Q
         kDElfrnLiZ4MWSjzYQGyWS67FAAwYpJJVV7L0CtdIstbmbdGNWswe+28dW+UJROXiT2D
         0wzMuHJds6u0QAjVaTXxp5sGTbclESeA/YhKNuwFaE8tGkNWf8qKaTE4bLWcpuC+NFSM
         NFyZl+/5WRtyCHjy4uw8fiWXcdhcjx2jphcxMWDmJXbCgCOb1exm4FcXucpI93t9qBUX
         HtZA==
X-Forwarded-Encrypted: i=1; AHgh+RpL/qYpalOnTgNVWumzO8mdDawmUhqhWBs+ADdH9rnGkfB0STVUZ9q6vaPUpqV0OZUEU/g1HV4f9XD/IcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YymPmehZVihl3LfzmXBNSk5Vtw1UP6ClAQ4XEYZk5bWUKwPoOCI
	UoBuEzsM2usnZIGKcbrOZ4Rf7dtU3h6h2u7Tl79+jNikvZ65UK4CIFyNC7MRnXHd+WGxvyQjTE8
	Vfw1u3pwIugwOjlocLKYjujrzQ5FA59NSN+K9pOfXbdu10Src6QT9X2X4g9ORHKnLtI0=
X-Gm-Gg: AR+sD13oiAUPhg9R7ji35sqFjGTq3gUaTk2PIprjG1K5cY7DZvfHIYMI74+gkX557j3
	QTPXhKbn7ix71PD9W7PbFyHZLIl+1YvWJc3PRTAiWqgu/4wJ9gvXoR2Wwijfpgl5NRrm6DZ+v57
	pyfYz/YQzGOGbKg9upn1kBefsVcklHpkTa1ij16RG0gQmW55qMCZueEJar3u40dTQx+9vfLftS3
	KscZUCrzs9zP7fSkqZns/JrSQcSK5sL3puGUWBYrNgYqp4Ld8DS+yqrLfgtk8nb0wXiJhHXklmE
	p8ZoGJUtph7qkIXm2JRkTftXJBgG8UC5raIKo2JTByKxWCG8rnQDMcjnPudqzK/SG/0KFOMF2WX
	RHFTECwYSd9iBbV2xzesEZc4=
X-Received: by 2002:a17:902:fd8f:b0:2cc:d6de:d597 with SMTP id d9443c01a7336-2d3b086d3f8mr330636015ad.7.1787023879445;
        Mon, 17 Aug 2026 20:31:19 -0700 (PDT)
X-Received: by 2002:a17:902:fd8f:b0:2cc:d6de:d597 with SMTP id d9443c01a7336-2d3b086d3f8mr330635415ad.7.1787023879042;
        Mon, 17 Aug 2026 20:31:19 -0700 (PDT)
Received: from [10.239.97.207] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d5c1e5506asm9210625ad.43.2026.08.17.20.31.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 20:31:18 -0700 (PDT)
Message-ID: <d2aa3572-e3f3-44c1-816e-a95bbbc77abb@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 11:31:14 +0800
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
From: Xin Chen <xin.chen2@oss.qualcomm.com>
In-Reply-To: <2026081706-tricky-slicing-166f@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: HFVWunxoIpU7JSGHgWbWwb9EcfE3eEMo
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDAyNCBTYWx0ZWRfXy5htf9Spnu8K
 gBiMc216IFOTopZX2Vg69bCumVGfKp20Zn+Mb/BENuuc1KRRz3kAajcsBgdnJpYZ6y2vZwApv3p
 yiQYvQp0PbFF6n7XkFjXD2xqNNqEBrs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDAyNCBTYWx0ZWRfX985sjNHN17aT
 2bWzuanjSugiRxOjslUVvdWkX4lrohr5305i/09m7UO7uX8+QuH9beGZv+tDDzxnHELFIa1uX75
 0+6c+ntSfCyy4XBCuXDj+eDxTjrMF42zJjHSUfOs3vJZ6GfhhoLpyqMW8EB5acMxJaFP6IxYMID
 oQHGtS7kghIZFzu/xnJZ4pWy7n/Hdt8phZcQVvxGi1IHPFHJmPiqi0TUOI72nUccCf0BInhSpXo
 d1vCsnbgmy1/lpLWy32ULnU1+dqgdkAVqcSdY4cg8KwIt5lseLFG1YWFhwHcrmT+N3AKu/4dYtg
 CjJTOzemLmkE0Eq2QK1xF1G6i31g/B+RewnWhoTcLb/IbHdRoHrO1Hvsp2uflKcdvfH9sDRYQTG
 XICdgdwBwIvUlcoWCYp8eOOcgvEpj7Ln/+RSEyFcCVupbrdvV3imSyfWprC3u3xMsjrgQSBf4+X
 YkiXkAKdawj5/bGXZdg==
X-Authority-Analysis: v=2.4 cv=HYEkiCE8 c=1 sm=1 tr=0 ts=6a83d208 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=70wutVrNsAcyFLlXve8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: HFVWunxoIpU7JSGHgWbWwb9EcfE3eEMo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0 malwarescore=0
 spamscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180024

On Mon, Aug 17, 2026, Greg KH wrote:
 > So you run out of memory?  That feels wrong.

Not a full OOM — just a transient exhaustion of order-0 pages caused
by repeated vzalloc() calls each draining the buddy order-0 free list.
The system recovers quickly, but the damage is already done by then.

 > Why not just use a specific slab for this one structure if it is so
 > important that it never run out?

kvzalloc() already achieves that: it tries kmalloc() first, which
serves the ~10 KB n_tty_data from the kmalloc-16384 slab (an order-2
compound page), leaving the order-0 free list intact. A dedicated slab
would add complexity without further benefit.

 > Why was this using vzalloc() in the first place if it could fail?

Historically, ~10 KB was considered too large for kmalloc(), so
vzalloc() was used. kvzalloc() is the natural modern replacement: it
tries kmalloc() first and falls back to vmalloc() only on failure,
which is strictly better.

 > And if it does fail, doesn't everything work properly, you just need
 > to handle that failure in userspace correctly, right?

Even if the error were surfaced correctly to userspace, there is
nothing useful it can do. The actual failure here is that skb_clone()
in hci_send_cmd_sync() silently fails due to the depleted order-0
free list, leaving hdev->req_skb NULL. The firmware reply arrives and
is processed, but hci_req_cmd_complete() cannot find the completion
callback, so the waiter times out with -ETIMEDOUT. From userspace's
perspective this looks like a hardware or firmware timeout, not a
memory issue. Even if userspace retried BT enable, it would trigger
serdev_device_open() again, which calls n_tty_open() again, which
calls vzalloc() again — further draining the order-0 free list and
making recovery harder. The root fix is to stop consuming order-0
pages unnecessarily in the first place, which is exactly what
switching to kvzalloc() achieves.

Thanks,
Xin Chen
