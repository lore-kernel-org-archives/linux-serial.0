Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CE73B47C4
	for <linux-serial@vger.kernel.org>; Mon, 31 Aug 2026 07:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788161297; cv=none; b=UA4ih46CeYTnK7tnqY1Bl1e4ZyC7OnI/AdFIZZOyrDum5uhx1uEH6saAbpcN/1O1lvVXLKsgKLWFdb66vZSPNhWHYG17qGYBOuV150HMFwjVaY308IbYP7j4K+Sb0t8XWqtxLpLlHBRDtmF57RWe8BmRUkvKTyOEYuIifsVqI/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788161297; c=relaxed/simple;
	bh=Conlgr4Jj+Rf23wPK+rlJYqiMx5qO0VUoIAd/YrvSHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H3i1uCLzmxO9EbRVCPJs/1Y+B5ETf6MTmMtRnsJ3gIET2q9afvmZQQtu8n+8JpQ2hH69/kjQdglnfcVIeOH8rjluPsjYDMXWWNzR4mTeZ3LgeDWj0O9fFqDzvNzf4aqwDyJYJ4z+8i1VeQvJUMiK1h0FmIloQRa/rVbG6rs0ebQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=picNtWO/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cpIM+9rz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="picNtWO/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cpIM+9rz"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V52T4F1445279
	for <linux-serial@vger.kernel.org>; Mon, 31 Aug 2026 07:28:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Jstrj3U0d113gfNlzGFGnlJ5/DtEAJkVT3MaC5FsOBw=; b=picNtWO/ASScH6rQ
	srFBNNgX5zLpnQ6gwD4fjeG0l9S+JuuwXvCdEerJaMwzZ6NoKLCEQOQ2OXc29tG1
	Dl/ck1MYeVKVcjnSxdkX6LA0NseTDdRaqFuVXDTYMj5HJOYZY/OUlpht+zg7rVgl
	M9uQ6J+NcjQtTal6RXBwY83b+zkwCry75YS7VA4hy1X/9NYlbg2q7qmpLN3ugbJ7
	ziixTmAsnqAnxNrsqe8c+3u/0M7DaV4eGDcd1pM4RnLlWKTV9FfBM9hmUEscQgI2
	gekw2PMgrrixZO8CTC54kbroUbXA6topdWO7xwihJ0I4m7MzTfgZt4Ye5jVymFBH
	UXCTEg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbrkgw0my-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Mon, 31 Aug 2026 07:28:14 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-52fa40fed05so6328261cf.2
        for <linux-serial@vger.kernel.org>; Mon, 31 Aug 2026 00:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788161293; x=1788766093; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jstrj3U0d113gfNlzGFGnlJ5/DtEAJkVT3MaC5FsOBw=;
        b=cpIM+9rzdE20z4H5+bd7ooTyB3vldjZdjxD6lwUHADRJZdDY1QzVrdNRpeYuEBNs81
         SEpzv293XM6Guo0CQHIC/IYj3ZuI6GYbCB2Q7N8NXrzlR0Z14xkke48m2o68dM+A0+IK
         v6n6FLIzy1Nz7UJ9ij0pdJIe+6Y8Kz+bRr4eEdF0+fyH6P6mOJVKckFvwSUOBSC6Leg3
         ndXMwv2d7798/VlJ0oulXuztOiPuc9r0WqMmzXvh0EF71BkIC8SMZY4WOYjzC/w7HB+m
         Hs8fjtjHuIv3fbFuDQSfDVNHtdYUV/XazJmA2EkVPz+aDifVNnJoXzyvcH5jNZ6jxy0W
         fAmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788161293; x=1788766093;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jstrj3U0d113gfNlzGFGnlJ5/DtEAJkVT3MaC5FsOBw=;
        b=AVT9qQ/rL6T3AbAjHYXGo3kLIaI2lWQzDD2ObxCC4d2NqsO4Ugnf8TRzERC7t0HDfu
         WeOOtreOtGdf6zkjMxbvj9+mCFpUJjEFdyuCo+SHRfwf39nnMiYHz42R+hPGIz2hwC6p
         Gx8BGF99g+p4byKI3EHHdwp2Asy8e2jO5yBJCzZHjGZCc1kzZ1f36FjyATVLKLxtEEMz
         g3vp/xYhjoA6gNkIjy8qKrMQGzp/EzcNVhAFAnm2CA9GEbaU13vmVQOYTgaFgAkgCXSj
         bhUrlr9YL3fC09whlyhmegZ1b3/cIwhUezW8Ot9xMwBgDjEGFXlFV+MCO5uh/6IsZsD5
         AKFw==
X-Forwarded-Encrypted: i=1; AHgh+Rr1hF19nOLK+Yp6zVNMslL8Hd52IQYrvpH1AFVP8ozdOhF+k0KDkQV0pKAfBVbybk61n0/YE/8dt1wSVHE=@vger.kernel.org
X-Gm-Message-State: AFuF++k3OO8HtUJjpwLTqzZg8E1D3zyDKwpEVo1jgkyhP0Ut1XD5rzjU
	DdDT73BK8TKw4+jMRCABt9rvpZXoHlcpvIk1n6Z3i/5/Rd1rnAMUjQMfwUSsBVi+pdXzg7gjYVc
	65eQ8GjMCLO5GwjpH7N3jlPnybD3lkRzUVauS/nKvNa/ueEX8zLOYM2EhmpNjalpm9RA=
X-Gm-Gg: AR+sD10qU57fehBfvC0wUPYzJ0fviXtj4Og1WH8yQ/VxYJfXT4cZSW0spb20k0LAitC
	RNGg1YwiXbNJc8IgPUk4Mdp0qEQGpyCKeh3uB2IuBfoVopDua78j6py+gJHSYLrFCOu9V50vd9l
	j0RLChKyUAFPozgXQa9mPDKLqc/a0n+DxeVyXo71XWj/w7GdLmwy1B8JIco0+osCMERWkWFlszB
	m/utmUk2mcVgFH3E6dgegQeeBhDbHXniUnxJizW1abE18HcdXU3aHCeJnEbeLig4hLTFU7e7fBd
	G1GtYA5wH6+BVvaUo9Ec7ci9vsIrP8CXAFsDzFT9Q7rooQ5FjYuFdrh9+2v914txAE8tmViJi1N
	LE1vTeUx+TCZ6KgVezt9g8g==
X-Received: by 2002:a05:620a:8018:b0:92e:9cb3:3f67 with SMTP id af79cd13be357-9392875e6b1mr812919285a.2.1788161293254;
        Mon, 31 Aug 2026 00:28:13 -0700 (PDT)
X-Received: by 2002:a05:620a:8018:b0:92e:9cb3:3f67 with SMTP id af79cd13be357-9392875e6b1mr812917785a.2.1788161292806;
        Mon, 31 Aug 2026 00:28:12 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a611c7720asm2883859a12.30.2026.08.31.00.28.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 00:28:12 -0700 (PDT)
Message-ID: <e16478f8-6b56-4e7f-b4fc-7c434045ec96@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 09:28:10 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] serial: qcom-geni: Fix port_ida handling for console
 and probe errors
To: Aniket Randive <aniket.randive@oss.qualcomm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20260828-master-v1-1-1f8afa5f82c2@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260828-master-v1-1-1f8afa5f82c2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA2MyBTYWx0ZWRfXwfVADAlKA/kK
 8TlZUo5cxzASRRziCUoiQ6Ld6gqPkf/lxwXUQo7PIPu9l+GHk5fqiJVcUhDPC0CpXRBbVGUDDJD
 BJqgom9SM3DnDp9TQi8kOX3a2WZe1M7qaQJy11tl3sTYjfiQOq48gRbbnnubgbWn/jJzzM1oQ1r
 jqPXp4zKw6uwOL6HsjsIgpItzqSHYB6DYT5J40Rd3gDwS9zILJn0TKFomH0ywgOfr0ZzTLdxedU
 LOx5SiKKXASSwDeOF/IQGjyviVAIUaznAVJ75NLLIQCN8zxk/Y4aEJlD7ffEREEBp3SSOF2Qr+a
 6uyzy1+vQDinAaaEKis9/z9kyV8JfSR0sBsLlGyriZnpX5Gd7dpIH+FfNTaV/zvrTMWQLdbYyLx
 7l9p1diYOsG/93t/2ADyV0f1+Dm3D3hLpchisvt0k4Agp1+WztkP9DW4LmvUGI6kxEgqxc0RGIZ
 mdAwqOTQ2qj1blzvJFA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA2MyBTYWx0ZWRfX/ZX8QIC1Fhth
 MPCHIoq7yqrE284bVekZGwjXMMNwb1vn0i/NvXlWBzkxV60LUd3Dqt9OV4Hl0/LoDv+fWwFDWv8
 G0EEWx4OfSrCob1nvT8nahMDJ9xDKeg=
X-Proofpoint-ORIG-GUID: XEs0Fsr27cVvPn-aXiF1qjEFqDwvCb7C
X-Authority-Analysis: v=2.4 cv=Cr6PtH4D c=1 sm=1 tr=0 ts=6a952d0e cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=SusbOXjRFks2-79YJ0gA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: XEs0Fsr27cVvPn-aXiF1qjEFqDwvCb7C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310063

On 8/28/26 1:14 PM, Aniket Randive wrote:
> The console port uses a fixed line number and is not allocated from
> port_ida. However, qcom_geni_serial_remove() unconditionally frees the
> line number for all ports, including the console port.
> 
> Skip ida_free() for console ports so that only IDs allocated from
> port_ida are returned.
> 
> Also release allocated IDs from the common probe error path. Currently,
> IDs are freed only on the wake-IRQ failure path, causing leaks when
> probe fails after a successful allocation. Move the ida_free() call to
> the common error path and guard it for console ports.
> 
> Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 3633723acef8..3bfe597d2c83 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -1979,7 +1979,6 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
>  						port->wakeup_irq);
>  		if (ret) {
>  			device_init_wakeup(&pdev->dev, false);
> -			ida_free(&port_ida, uport->line);
>  			goto error;
>  		}
>  	}

GPT suggested that the failure of

ret = port->dev_data->resources_init(&port->se);

should also be updated to have a 'goto error' rather than a direct
return


also that in get_port_from_line(), reordering the devm_kzalloc before
ida_alloc_range() would prevent another leak

Konrad
