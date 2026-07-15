Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F43238D52
	for <linux-serial@vger.kernel.org>; Wed, 15 Jul 2026 04:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784089525; cv=none; b=J78oEs9CbQXYgiBhDk0xGLVBmBa/74zASd7VgE1hyXlao4s3j5MZIdyVgMIWmK5zRv4XdRJLE3XQSrgsPGRdzRmh9fX+aVKVG+th53LvcFmEyYb5s0uuZZA3jQAjYI5pCKiAskSYGvTSyw7z74MX4pCR5RLipMqUlUEuB+YpFiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784089525; c=relaxed/simple;
	bh=DK2lOKmkmWR2CQud66y0FWcRMt7euIuPOROOhOmh7Vc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QPeZ+KBveFMwaGSWTyN2gnUjBj3EbgOUKyyzQKRDEOIAUpcEsLiFgVK6m6BflH2AU+8u/B2YimzTtKhWEW6M42y9AOO+UgN8yBZYWRce/hnrAACHy1p2oXuKBVJgQChiW/dx0qfcexZp7SN9gYekbhEwcoUF88p93HzApC5zv5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BchjMjTv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YoL6ZzV0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BchjMjTv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YoL6ZzV0"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66F3lIlf2555538
	for <linux-serial@vger.kernel.org>; Wed, 15 Jul 2026 04:25:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=tRaNZNMXJf/14vw29Ycozr
	FMxfr+Nd1FrDA0PxR+bh8=; b=BchjMjTvWkueAjvljgfJsa6oQ5dqmsp6702ak9
	iR5SvcxwgiV1GapHnPMxFte/vIR6Q8Tf7fGV4VLLdEDxgQ1zanZe3VZViSlxFnAe
	zTn/xn1uU3TDEnMKtjun4WH1zjJmV3jWErJAxrnYwvP9jiSVEkVCMV4c1v8JiZ5y
	bo0d71ji/6p6XiKBjuKGZaSx8A1rhtOTTUCPXlarJJzl1k2+7DrEuuFv8olJ13Na
	inpKjmmlIKe/QDFw6OqwHzNVSR6UpIV/5YIazLpPN5b9yerKnyfUKYdbBwQWQ+dL
	L0U+FdQwO5y6f3EhGZyKByQVy29nEGWuqnkjQncoUmekzxIQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fds9kswck-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Wed, 15 Jul 2026 04:25:22 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38dbe39ce62so2153760a91.0
        for <linux-serial@vger.kernel.org>; Tue, 14 Jul 2026 21:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784089522; x=1784694322; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tRaNZNMXJf/14vw29YcozrFMxfr+Nd1FrDA0PxR+bh8=;
        b=YoL6ZzV0hnLlcWTaLlYRiAVn/FrIaAZNp62xxTUsbaoTKaYmAp5gfn2vet8ZIu73Q0
         CFdllw3HsKaeqsLwn9u0v2s+tibIwSwklah1pA3W4Y/0HLdX3ueqH8ejv7X+oeHvMkMA
         InWguDVbS2/2sRaO5lXwZ7xfJXChhahoTdxNjCdBCQIClEBI71q5O3f9EYTbu2LzHVSu
         OcnXbrL/hiKfHuJiB9vfszIoWCvuRN8DHu5issiortLiNx7ia40Oxxg+LaoKhDKpihZy
         EyU84rkdA7snCTvaG+KiOWIqAKycG3WmZuXhILIvGMV4pPI6Z2eT85gikfQHsepp4DvD
         H7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784089522; x=1784694322;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tRaNZNMXJf/14vw29YcozrFMxfr+Nd1FrDA0PxR+bh8=;
        b=V9k74BTp79EcZbl8LVlgs2oNiIHyucHVCVUT5zV3foo+/cJ0e28ivZW665MNZjHPFX
         HhPmn38sUz0AMHoe0hqcj78SMTxf8gV9jsmoaOzio+FNMBrqRoO6PTgvptlLBoZyygqy
         ZGdk3IbD9MaULWTaFYm+zoA2lQsLuuxTXnGrPVMxJ2Vgi+0SeKMSyKNWBDeSBw5yBV+I
         w5DLThcdqGDkHO6uI7tj/mF4nZV3YGFrXIaNoXgbN87HuRoLrCHKh3sE0ryJpccMN9sR
         8ixiJAnkiUVrOByd9dt4CJCCHnmk+YuqN8JD9betn5dHrX0yz3Q1HoJpcldMLI0O1KeJ
         v7ow==
X-Forwarded-Encrypted: i=1; AHgh+RqSlgfNNtRoDIMBHXMSry73QxmBJ5iJiCNbNTb4WwLkofrxPavVtWLHcMU63FkgXf2keMl03FsiMepx+C4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyR0vI3/I6gJn5XB8Ufnv6xF3uJGHNzMCaDIIb/n0TFGOr++8d
	GHupoGm6DQ3br2R57UBs8vCAwl+PFEwpoTrdIMkf27OFkFehJxn0v340w71WUNuUpvsfGMb0ajz
	q46Rgr0xXyyjrQLv5LSY1zUH08cj1lRVyS1KQIKLhy376yEQFYL+S8Oj+2Ud4BFVZvdw=
X-Gm-Gg: AfdE7cnpmXG3jsXZr963mPoGurvFS3ammcuVMnI4dL6rlPflJEqt+NxRRaw+FcE+K7K
	Cnxsm1+z9Q2CpcdZfuKs574U293G0jDxsjy8fRsihaEzzy2eLLVc46XAp+cQIQY1gK5m0cWe8Zv
	WIIoBdt6HfgeZ6LzBeDlkB2ELGleCf6EYNoX2M+z+VuzkAaaxkTL8011qlOVs6nSVWaXdf2FgTG
	qwCLpF4IbD3Z4UmuZylW8NGff20tA5CAKhfSrvoyB0MeVFtbga4gvSlJWoNJ9VWPiHDD3F92BC5
	WeuBZTXAGeVvKqGtOwQ4BGWnL+X6IwVesJ3e0vFP7xidxIAZceUrrRVUe6fy4jfQv4gCw340R68
	izfOFWqQfaTjjrZcpUb7VQ8lDmVp03BGcwLmWPTS6p5Vx
X-Received: by 2002:a17:90b:3807:b0:36d:b12b:f57d with SMTP id 98e67ed59e1d1-38d15364aefmr20723219a91.12.1784089521981;
        Tue, 14 Jul 2026 21:25:21 -0700 (PDT)
X-Received: by 2002:a17:90b:3807:b0:36d:b12b:f57d with SMTP id 98e67ed59e1d1-38d15364aefmr20723197a91.12.1784089521431;
        Tue, 14 Jul 2026 21:25:21 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311935fd091sm62395491eec.24.2026.07.14.21.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 21:25:21 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Subject: [PATCH 0/2] serial: qcom_geni: Quiesce UART transfers during panic
 and shutdown
Date: Wed, 15 Jul 2026 09:55:13 +0530
Message-Id: <20260715-add_shutdown_and_panic_notifier_serial-v1-0-23e3787c7109@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKkLV2oC/yXNQQrCMBBA0auUWVtII0bwKiJhnEzsiExKklah9
 O6muvyb91conIULXLoVMi9SJGmL4dABjagP7iW0BmusM+fh1GMIvoxzDemtHjX4CVXIa6oShbP
 fPXz11jlHZJGOJkLDpsxRPr/R9fbvMt+fTHXXYdu+w3zMwIoAAAA=
X-Change-ID: 20260715-add_shutdown_and_panic_notifier_serial-2666cc2ac30f
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, bjorn.andersson@oss.qualcomm.com,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784089517; l=1500;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=DK2lOKmkmWR2CQud66y0FWcRMt7euIuPOROOhOmh7Vc=;
 b=xcx2mXat0Tb9oV1CpimXOPHklo9Nm9FAkAT2vVQ7y7on4zf2sOsM3b9zmyshJeSfl8byGKM0j
 VHdibhX2obaCKMs1pavKe8Gy4eKr8vwvAWdL2owbvAU16IRymsL7bfJ
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Authority-Analysis: v=2.4 cv=Q63iJY2a c=1 sm=1 tr=0 ts=6a570bb2 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=gli0oG45nIT5P0-av28A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: 21CaC2cB39vTEo-yk6Y3aP6uheCN4YJ2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDAzNiBTYWx0ZWRfX33CZfZFhH2/n
 K2busjAGii/coJbU51S58jRWgFpTikSzcqk6OKTpl4bM684OQQRM6Yeu6Uej2pFnfsRovIt2HvJ
 PqUrzBJRjiuaqxgcqmBnYwKiaGXIW5w=
X-Proofpoint-GUID: 21CaC2cB39vTEo-yk6Y3aP6uheCN4YJ2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDAzNiBTYWx0ZWRfX4tx7PKSxzV3X
 OUVYVubwLITkyBZoP2gC3kVdeWp7jxVYHtf/J4kylqmUKrq7WEw6cOAxs09ODuoqUCBw8OCXIik
 d2GSNczaR1h2w6ti1FYskZDkxffI8bnxudbXIWMwCZSX3DZr2aXuCfGQDGBaR8sBmRWHx3INxRK
 vYHdqdbuEZsCnnoJzT3r1ZzuGpMy7rwW2g7nOMl/DkumMYXP09KO08yrDri0l1nxyKwu41fAxzb
 pdqzDwbKZudTLfRyKPshc662AflZMy54U+XzlDIjGFuMet+lTnXHVkr05M3FYVxG1t6YZ+gEvSE
 k8dNaboKOLEaSEz7PT5OHO8ZYduQ/IStL4WXQ0/p20Hl1CDPg/YCcP0MNJ6UdzWhv1brCEW2RCE
 PlM0qT6MUl4lt2TkovRyDfyp7+XeAuOyCxx1ZW5GzTL3lS1D7k99EYBMTmmAsuRriYvBTvs4tuK
 GWlt6BB7Uh2eMnS/rVg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0
 phishscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150036

Active UART DMA transfers can persist beyond VM shutdown or panic
scenarios, allowing the DMA engine to continue accessing IOVAs that have
already been invalidated during memory teardown. On VM-based platforms,
this can result in SMMU context faults and leave the GENI Serial Engine
in an undefined state. In panic scenarios, pending transfers may also
interfere with reliable panic console output.

This series addresses these issues by ensuring ongoing UART TX/RX
activity is stopped during both shutdown and panic flows.

Patch 1 adds a shutdown callback to quiesce the hardware during reboot
or VM shutdown, bringing the UART hardware to an idle state before reset
and preventing SMMU faults caused by DMA accesses after VM teardown.

Patch 2 adds a panic notifier to stop TX/RX activity during kernel
panic, preventing further DMA transactions and ensuring panic console
handling is not impacted by stuck transfers.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
Praveen Talari (2):
      serial: qcom_geni: Add shutdown callback to quiesce hardware on reboot
      serial: qcom_geni: Add panic notifier to stop UART on panic

 drivers/tty/serial/qcom_geni_serial.c | 36 +++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)
---
base-commit: cc2b5f627e8ccbae1188ef2d8be3e451d7f933a5
change-id: 20260715-add_shutdown_and_panic_notifier_serial-2666cc2ac30f

Best regards,
--  
Praveen Talari <praveen.talari@oss.qualcomm.com>

