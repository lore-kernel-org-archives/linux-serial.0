Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B1036196C
	for <linux-serial@vger.kernel.org>; Tue,  1 Sep 2026 09:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788256439; cv=none; b=bZSE9GTGgzwLZ7/QryrMb2RusbA4ziv90ZGMBuYIVvtWRnMnyyrPVDsCsNjDjYJoeAuUWNKVRy6uMS3b5nXj5PJsqoatmOmPn8MzWHP6+EIHK3mKURGlHfBgoKT+SpK460yyfGyxU61PhQE3gtZ+4oIUJGcdkP6G900sXF3Yapo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788256439; c=relaxed/simple;
	bh=kgRDL9cVWy0iLA/oSuxde/FSuoSAnPFNKSuKeLhwR5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZBHF50Uv3sLG99rdWIOZyyYhEZJ5A5yQ4+zbPCCCNHOMK1d+zUt6w6TAUqw52U7BFZNENswGNXmjk9eXU4NNxbqHDxL852ydrEdhbvqtuWx/65KsYQeEHKdhCgc+cDGmdnX4/1oMacdIgJDiEKaiI2jobst6Ym88m5Rau8/ItsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CdTYzgca; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VzUfYS8J; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CdTYzgca";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VzUfYS8J"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68179O4k1282804
	for <linux-serial@vger.kernel.org>; Tue, 1 Sep 2026 09:53:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	A2bN8xEh3cDev+OdzW0UXVkB7nRlGhfeJFSfHXmMuuw=; b=CdTYzgca9HCsxvTv
	9YLigp10IGplNb6Af/RQOTVyE8ykDq6/K/p5MUOnpPNIF5S9NxiUKx8C1juVXyyD
	+DRPx5EAqXf+ookn9tLSKhMJvFBWq9kz2ajC3I6zzPbEcQswYgU1/wkqYriPSHgR
	JQqJeVFugFA6BdQgIn+rQ3E/bjbTGQvGc+6FNgZHy55iI9Ud4HXsx44No8IvK54H
	1IPZ9aGRLZZEGjp4TAGU7NzEcllqI0/c+v1c69QM/zANG7HljJsf1sL2UatNzYlf
	gQLWyv9R2CUJ2p4tVpTC5KF8bJKge1SnlGoosH6NAfufWnwS1pjjtlgmazPRb6hS
	oT6UuA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdndx9vqj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Tue, 01 Sep 2026 09:53:56 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38dc085b0a7so8680809a91.2
        for <linux-serial@vger.kernel.org>; Tue, 01 Sep 2026 02:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788256436; x=1788861236; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A2bN8xEh3cDev+OdzW0UXVkB7nRlGhfeJFSfHXmMuuw=;
        b=VzUfYS8JW7a/5KQqTOvWin5mudrcAKPj/AhvToIHZHcB3k96i6cU1n53vx80t25znc
         30gNoHMnoCD2c1RluSOJHKmCwi1ByJRczGTbeaEDGQ1337Mzn8f3QYbni+sE5q3uUXrU
         T1jQ/gNV8gLry4O9EY71fwZFO4V6EICyqzgr6mw/at+jRd+FHtPdJLwwp4v0KwADpBos
         A1n7+ujIRmlj3mDKnR4kPHReBQQZrFgey98KPN5chxyiK6qrSKsoTRWkezLQsesMoqxz
         1xrHP69I4uNNrJvATE4mIs2DmwJmTui63gERg0NeS0Z/rc07yuc/RIStWDQt76JsZ2TV
         w7NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788256436; x=1788861236;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A2bN8xEh3cDev+OdzW0UXVkB7nRlGhfeJFSfHXmMuuw=;
        b=D8/OQHWfjv5fsTtaEefJh2SmV+xwBaKssVTrlIaNjBhvHVhB7oaN7LW+H5PW0WtSRx
         KGvaaPPlmofUdPSfepNNUn7pSNuPhmi0ACOsgNiCIujWyitN8ThBBpkVJTSzFBaMuPvd
         IzKtDLMn3WD2VdRGngAeH26JBwXTBTZRrqeTI7VHrvFZSxaML9oaoM2Pg8HEvMl2ndwt
         gezk9fzt1eNgZJmH4hRGqioTjrraXMgaErDmNMx1I0C10mrssCX7KlurgzVyK5xs3cjv
         vozbkAb7/lAs9ax5aYT6cJcW0AQXlS7RbZ9Pdj1hRPiAFDQmGHh9sMsWPF5Depp0/N6b
         yIXg==
X-Forwarded-Encrypted: i=1; AKwUvBzL5bYZFp6ney9bdWnWvmgea16vqlZJ3s2Q3hg6MJXeKB5Z4f6y87ChTwn+2abI+UW/+cFSM+TtBmjdflE=@vger.kernel.org
X-Gm-Message-State: AFuF++kAgRK9tTTF4lpNA4sVCB9M1Pf6balSwBNN2HgYHsJCr1sOzEPy
	fISS5FwmI3pHF+C7fP1ViPmZkBgY/7u7GBnvq7KWxo4hTF1wccb7mDkApvD102B8k2PAoNHT9Mw
	0OzgLP+ncpZjJGsGIFY+DnxBohEFTW9vvhXTicLabPM5y5vUgW3yTLdZzVL6t0gfqceU=
X-Gm-Gg: AYBFou2ghGAdCPsyIcnMR3TkIOa5ZyTd2kpYA4OZ63yzGMBn4bytKae0yjal8Wf6WqR
	ofcBmzmoC8XZGNFTx3CM0dvMYI7n6qpZQpLQSyBDkKBaDD8DZAUFQgcHriA/jQtTxr7GF5ftGxw
	/CLuurnnmhsqddvIPm9z7YhBmWsQakIASx8fazt9Vt5eE0DGNorPjpwfAC1oJe73F+tLwBfYda3
	wESVDYLC3fpALZLIobn9Zvb4LM2fq8gFy62qwMVboCa+Rfyr5oaHcsXcaBNjAUi2vQvbojfsJY2
	bFB3spjS6VfNPt8Il/QvB2AlIvCZlU8FUMn4bojZURL2+A4HC9rFqMiaxoB6qEMDJ/i0rmlCLjL
	mSL4XDqjqSh8zSoOKFOKdag2XLMy25yo=
X-Received: by 2002:a17:90b:33ca:b0:38e:ad9d:1161 with SMTP id 98e67ed59e1d1-396d0a36c74mr46467400a91.0.1788256435758;
        Tue, 01 Sep 2026 02:53:55 -0700 (PDT)
X-Received: by 2002:a17:90b:33ca:b0:38e:ad9d:1161 with SMTP id 98e67ed59e1d1-396d0a36c74mr46467337a91.0.1788256435196;
        Tue, 01 Sep 2026 02:53:55 -0700 (PDT)
Received: from [10.218.14.97] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0bf8a13sm53854905c88.0.2026.09.01.02.53.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 02:53:54 -0700 (PDT)
Message-ID: <5f01f216-588e-4270-b949-2f4b11442f0f@oss.qualcomm.com>
Date: Tue, 1 Sep 2026 15:23:50 +0530
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] serial: qcom-geni: Avoid double-free of PM domain list
To: Aniket Randive <aniket.randive@oss.qualcomm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc: konrad.dybcio@oss.qualcomm.com, naresh.maramaina@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20260901-probe_cleanup_uart-v1-1-0bc2b00c970e@oss.qualcomm.com>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <20260901-probe_cleanup_uart-v1-1-0bc2b00c970e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: M36VYT1KGk_4mvIXHHyXWuliXtocTsEE
X-Proofpoint-ORIG-GUID: M36VYT1KGk_4mvIXHHyXWuliXtocTsEE
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDA4NyBTYWx0ZWRfXxL3OrVQQef/e
 0bA1F1ghbl5dXJ5NBzfgCcMbTFHo6trM3T6WFGbfZRxocYjB7RotLIBpxinETXOJYXMChv4IAhk
 DjGPxZjg9uAxMgysMPPvGZMs9S8DaL0=
X-Authority-Analysis: v=2.4 cv=U8eiy+ru c=1 sm=1 tr=0 ts=6a96a0b4 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=avww7BCoVOackQtynkMA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDA4NyBTYWx0ZWRfXzPWYA/xerG6H
 K6uIQ2NGmT150Fa4yaQeUE8ujQj0C7bxNh7xGF3IlHi/mwMStcli6Ygg3q59RgHnAh0XlbZ0PM8
 u+kEc3Zg5azDcQtzDYNeXX7dzAxExJ6C036CF+FO9vT36UY+WhRRmcTnmuro/us0HY38ubey3pX
 HSuAQKow2dq81HleZ55ZDAr19N986CHKpOlhMRcxGgpOXHYAB9L6nvxFjwVb0J+rEJevcW0okDo
 KsvaDtY8i0NCSsxaYGDDqAjPNAuL5dRVQ6sKjoBlCokgj6HZgMwm4ITjrZyCuEYOBB5TT3i5DoO
 1+tK/d9sccYdf6MhD+//x3rPdpYXQP29ntZk8YKPHpdg0LCZz21fr6YstAcFZABDbgGHRQEliRY
 IVQZ+FWyCDiibHZGC6NeIxdZ9x1L52MpWCXyfGp2I45aZ9/ViztmQBw6XjV6WrHjY38PGgM6K6k
 2P32RalAurxZszOjwBQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_02,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010087

Hi

On 01-09-2026 15:20, Aniket Randive wrote:
> The SA8255P UART variants attach PM domains through
> devm_pm_domain_attach_list(), which registers a devres cleanup action
> to detach and free the PM domain list automatically on probe failure
> or device removal.
>
> Remove the manual dev_pm_domain_detach_list() calls from the probe
> error path and remove callback. These calls can operate on memory
> that has already been freed by the devres-managed cleanup, resulting
> in a potential double-free. Also remove the unused pm_domain.h header.
>
> Suggested-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>
> ---
>   drivers/tty/serial/qcom_geni_serial.c | 4 ----
>   1 file changed, 4 deletions(-)
>
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 3633723acef8..fe961b206645 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -20,7 +20,6 @@
>   #include <linux/module.h>
>   #include <linux/of.h>
>   #include <linux/panic_notifier.h>
> -#include <linux/pm_domain.h>
>   #include <linux/pm_opp.h>
>   #include <linux/platform_device.h>
>   #include <linux/pm_runtime.h>
> @@ -2008,7 +2007,6 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
>   				 DMA_RX_BUF_SIZE, DMA_FROM_DEVICE);
>   		port->rx_dma_addr = 0;
>   	}
> -	dev_pm_domain_detach_list(port->se.pd_list);
>   	return ret;
>   }
>   
> @@ -2032,8 +2030,6 @@ static void qcom_geni_serial_remove(struct platform_device *pdev)
>   				 DMA_RX_BUF_SIZE, DMA_FROM_DEVICE);
>   		port->rx_dma_addr = 0;
>   	}
> -
> -	dev_pm_domain_detach_list(port->se.pd_list);
>   }
>   

Reviewed-by: Praveen Talari <praveen.talari@oss.qualcomm.com>

Thanks,

Praveen Talari

>   static int __maybe_unused qcom_geni_serial_runtime_suspend(struct device *dev)
>
> ---
> base-commit: 89c07d98716a13454ec3fd9f97689e812cc71bd4
> change-id: 20260901-probe_cleanup_uart-60bb7d0df5ae
>
> Best regards,
> --
> Aniket Randive <aniket.randive@oss.qualcomm.com>
>
