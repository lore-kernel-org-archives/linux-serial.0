Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4373C10BD
	for <linux-serial@vger.kernel.org>; Wed, 19 Aug 2026 17:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787159596; cv=none; b=mroflALlfWj+Qrgd8N1aTlQ4Tyv6id7s6ipM1nj0BamxtsqfRolGjb+BPevCQ4K7k9Ax1B4uYD8/PPZbtu6Xb4PhRgWk8w3mnI3iMM20xTE906hIJeGPbiTQTjZNo75adSSuJfb0t4nBO4OsooWAMr42pI4Mb/OwnQr1mGbDP50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787159596; c=relaxed/simple;
	bh=Z90XMjj19ezM12K28AtL6SIr77GIYl4LGLPwkbrSqHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MpLpAbkkLGYtTU+8VaTnpLgnXDFWMlx3yV06OT1vx+ORjcCqqkRDcyqeK//j2cUkpSAQaIHYkWhdKlzSjoxmg87NIPTEqLQSFAgM8J6GIQcgV7uxSbxPZbVpglrS+zGIpmE228X2M1IN5PFzn3yTVlXMtMDSCelT+PLP4eyRwUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lHtmGhmt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Fip/lAcs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lHtmGhmt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Fip/lAcs"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JEbWsP1620528
	for <linux-serial@vger.kernel.org>; Wed, 19 Aug 2026 17:13:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ZO0qQBWN+bm/Xq+0wcCJywoU
	YOARekVlxPEPx5YksZk=; b=lHtmGhmtJjDPT53PpwZ66C6U1ryr7vwx1LkXnSJp
	oYKagEkOh9MDUwQV3mUtIxFstrjykfbvBQH2H8H1FOoN9H1AocJ/cAv6cQ3LrrRn
	jHZOXe5xU+XSMqHZzqGh+eq5XbuUxEIDyvMNFpSAmcCcdT5cQmxm5uy3oBVMpvEc
	XlMh4p3YU6CrgvdZR+BWkgftiOMbMFursNsSoqJJ2N/BI+8CEOjj7qKazt12RpFm
	XiirOjTnNiWEWoAbJlRki2Un8i6lrdOfLOfNydayNNulT7f5mQdRwuxjirDic+q6
	gbDnTtyjQV5HfZzxnglPOhMaosoBKC5Uoe/H/iwwDEWRkw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5e83rvsp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Wed, 19 Aug 2026 17:13:13 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-936aa34873bso117366885a.3
        for <linux-serial@vger.kernel.org>; Wed, 19 Aug 2026 10:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787159592; x=1787764392; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZO0qQBWN+bm/Xq+0wcCJywoUYOARekVlxPEPx5YksZk=;
        b=Fip/lAcsrZ8ilmMyblW9x7ZcQHgAi6g/Eru7FVg0L83RteIuqspzS8uK+On628AtI8
         JekqAvNEhdqXvcHPVdXRk4Mimx9gHOkRiBk1v7fLaAw3iC4bUiQCyAa47VeCgmpSDrxn
         qhGWFzPRdaOQ+m468LB/hjZ49wOTgId8Wfs/3r4iUcKs3XBxUYZ98t6ALiTeq5KqhVMR
         qMqCKdDKBQxMU6VPoOTdODhz1zrcEAW51mEfVCRdGPIAzuMtj6AuigXfoKpG6OdCaInf
         Ir+ykviEOYVG6Y5f0n92jfS7zk6QcHo3bMGaUeuuVmiA4zH/H4+b0UI75ysrfroKfM6T
         Gwfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787159592; x=1787764392;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZO0qQBWN+bm/Xq+0wcCJywoUYOARekVlxPEPx5YksZk=;
        b=eFjbsFPpLog1kvxrF6U/2+IH0c+utjRDLj5UO7LuFP7jX4P36s9nLXwpuw/kVkUtSi
         LfIbkR6dZcBCHM21rMv/qqxaFLqUFH5Y7SeQmGX54NzCYoD1rPPNoXnS1kMkliuXukbd
         DL+ke37eTrwKkwvuprs8y4QzYWgMiyn5X7il1k9PmTK58JDZpaKLrmDvRN78I/w8oOAv
         wj1fi3vz5/8C7D8uYqqs1BYOsG09Tu5Pzawl9ihJXNRr0vBLnnQ7NK0NeTntXePkaQJS
         SQrsV4oaOxLa0JLwDf8czXKsiGuU8rk3bWlwJe0wRwph245H+19FQ1aThRWCyg3Syl9R
         f1lA==
X-Forwarded-Encrypted: i=1; AHgh+RqEwZPK8UCgIQ1RRTZxbmIzBoPCFsKG+CZj2msivWLIlKwBKyokHKLHAZVn5VbHBtLHM9qdeuB6L9Qh4mA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaKFaNC5pcR1mWqW9WcAQoPgVm6SOuFNJINh22r6dKdfS7pKRw
	PiBRn5+2AXneYCaZnZVOUpIKByjrQl+KX74PFoj4p0ztE3m4+4W+vD2SBpNeixNU/QjWD61w9Ac
	wc4vqMWkjWncbbO/ms2O40drKoNLunx0MyvsIUjhe+ZAnHP9IYNw4aKY7+ZvOmDdciq8=
X-Gm-Gg: AR+sD10q+aTcndtWmqhW++tmxKHYiIbhy6CAJdPQuv9a40YegGoYzEB4JN+U6vp5Wp1
	g8g7ffoUA+TygtwCtuw6jA0g4DnEolWFa4XvspX92O0mwzEQ8BE3JUIpDzb4+G7t5hdQ78rtmHc
	EzuwyHdqyTuGtDUAreDjSlU7OdoKrSDD2goE6q+bMdNATFYjQ8Bwf1SecgbsBPjEcZ0CKV0rLPZ
	LkqJT4RsTbSp69UFIkLi3y5CkEboK80aekAShbOaLt9UGybhIuKgZedY2QhLT/WaTaaHw8NOJjM
	1i8yKeSQcTDr94MykWIQBPT1WXIM/5r5iRQTE7wSQiIoMEKSE73QZlkYlQTN92ZfD0T66oovFby
	MyGVcZwfnxxTQkaA=
X-Received: by 2002:a05:620a:2810:b0:936:cae5:8b38 with SMTP id af79cd13be357-9371e25434cmr642947485a.10.1787159592376;
        Wed, 19 Aug 2026 10:13:12 -0700 (PDT)
X-Received: by 2002:a05:620a:2810:b0:936:cae5:8b38 with SMTP id af79cd13be357-9371e25434cmr642939885a.10.1787159591748;
        Wed, 19 Aug 2026 10:13:11 -0700 (PDT)
Received: from oss.qualcomm.com ([188.27.161.240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499a9dffa59sm95601825e9.3.2026.08.19.10.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 10:13:10 -0700 (PDT)
Date: Wed, 19 Aug 2026 20:13:09 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Praveen Talari <praveen.talari@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH] serial: qcom-geni: keep registered console runtime active
Message-ID: <ao4dvbqk3lbjwrw4qgiwjljyi2oe7nzcx5ooqx5whukiyvet75@6kemkkgoonvi>
References: <20260819-topic-geni_console_poweredoff-v1-1-7f7bb3aad8da@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819-topic-geni_console_poweredoff-v1-1-7f7bb3aad8da@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEzMyBTYWx0ZWRfXxh2wRwZDp45W
 KqjrgqZ9ebnlla0OQge9IkHi1IjtLMbvojX6/gvPr7KBYFHRZzNJcWCL6OpHDWSNIP80GSb9ms6
 ETcF77w6RIWw4Xxsqg7EQWm4Q+mnKnI=
X-Proofpoint-GUID: KLRGCWZZ0rUd7RzmbywO7lxlm5U7-bBR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEzMyBTYWx0ZWRfX1jMZw9ZPGhHJ
 9McXYOsXZZUKBvmsI8mWK9kSEk6pqP5imoexpqYqJzDRzA3sd7HTcFS6mg4zTFr7cYYl2W2jRrL
 fevo4RtcIKdIpmlbO9tf9Uu5PFig6tw8upLckJKPVfK/0dxNdiU9TickGQVVTD+Vu0IbFrod6vg
 18fXrFtPQviRpnulsouwFf0sr1WYEvXRanKeYnGOmtX+5ccMstXkjzXRYgA9I7jIaE7+GgDqYyX
 FcLNxAcXdyFTDNVG1bgC1lOeqYU2JHzLxRc8PsTGxxuj+m2bnCBKJYGvJYnP9LFF+OeUSFruf3t
 jV0sY/HXoPlnpqiwLtdl3TUw0Y3VTC1h7TEPbX9SKZXv6gtffofPM+lTIvF8slQX73qsyw1W+D8
 T4m6HIHdqbW25dIPy8zadNLxWQP/8Q53GgrgX94JObN1yjT1uDImjl5Jkxm3cZaj/q+zc38yG57
 ZeqqdwqI2mAb4XtWtUQ==
X-Authority-Analysis: v=2.4 cv=cvmrVV4i c=1 sm=1 tr=0 ts=6a85e429 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=wUpz7uCjLrEXi01cjX+DLw==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=mVIPQ0GnqOHn-2xBG8YA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: KLRGCWZZ0rUd7RzmbywO7lxlm5U7-bBR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_04,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0 clxscore=1011
 priorityscore=1501 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190133

On 26-08-19 18:46:47, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Commit aee1f94dab13 ("serial: qcom-geni: remove .pm callback, use
> runtime PM in startup/shutdown") moved runtime PM references from the
> serial-core PM callback to the port startup and shutdown callbacks.
> 
> The serial core used to leave the console port powered after
> registration, but after the callback was removed the temporary probe
> reference is always released. Console writes are not tied to an open TTY
> and can run from contexts which cannot resume the device, so a
> runtime-suspended console can stall. This was observed on a Qualcomm
> X1E80100 CRD device, as the boot console became flakey across boots.
> 
> Acquire a runtime PM reference when the console is set up and release it
> through the console exit callback. This keeps the device active only
> while the console is registered and balances the reference when the
> console is disabled or re-enabled through sysfs.
> 
> Fixes: aee1f94dab13 ("serial: qcom-geni: remove .pm callback, use runtime PM in startup/shutdown")
> Assisted-by: LLM
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
