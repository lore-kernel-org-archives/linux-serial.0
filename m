Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C43338BF62
	for <linux-serial@vger.kernel.org>; Thu, 27 Aug 2026 17:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787853584; cv=none; b=XwWgSzVwX6t4/51EIvLTpAX4JyZb/02FCeOVygW0ws9Y2uiurG2yn1Msri79Daf6ptVLcEDGemglwdq+SDbn40AxqUWtAD2zjfJkOxKyu4H87+bq7Bc1XcTgszGjK+Ra6FzjwDDjlgY7LmblgAmDkvEuoieMYAT87U2UniaKjZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787853584; c=relaxed/simple;
	bh=GuJ2IiTNAbocaQLtHQ5QQk1lc6LqRCoanYaY2qkKLA8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kG7ViB6UkApP5BSI7jFIxtrqiSSviowtBa09elHFmKDOHjKvsZyLwQ40MpZH2hyAbtN3i+VxdlbCMPTiYw/FVNLybMjOFsH5pkhRakIWMSW1c0P0w4XI/sEechK2EU86x73o9AGnWn/ueAkPvhav7bxoJGw7rVmK8n+N5oFkrVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bMxcVnYh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ggkCds9D; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bMxcVnYh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ggkCds9D"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RHXdCw553711
	for <linux-serial@vger.kernel.org>; Thu, 27 Aug 2026 17:59:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	d4/+pFI9X3x+m5kaMfH/DHqftGBwKmr5KIRwmuCGmb8=; b=bMxcVnYhfYd5fNEJ
	rjG+jRjG+rFtOUYWo+LAzlLiR6RK+WHe7LOHYhSaras3OG4qk9JcGO9wSJE5hMFz
	o9Pi/cBz13QNhoCkGlOwrxBAnLpqnaSHr86X8hbXklfdqPBoJOTYnevWJNCPTEgn
	G8jXN2Lg66YzXlQOBm5PYnma7vw0zSqzy7s7IFPM5K58NCHX0S8BnxfCh1eUTpqB
	girVzr+TzWRbg/fDnPb8A0AoYdkk8qiP/FwHM0/Wo3QzgNzGlLmvRbJgaxghydqK
	cVz3EHEatSVQll7TuHE6YEQJSvLTrdQBkwVMVQbvXr9n2rowYXVveM9RrawiXxnY
	W3pifA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gam6fhqdx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Thu, 27 Aug 2026 17:59:41 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e4758ab46so393137a91.0
        for <linux-serial@vger.kernel.org>; Thu, 27 Aug 2026 10:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787853580; x=1788458380; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d4/+pFI9X3x+m5kaMfH/DHqftGBwKmr5KIRwmuCGmb8=;
        b=ggkCds9DmsUuU69tDrqpGevoA2nMtfpgnzTNPCyeFBVfh7IgglOZK9fYl8P6GS+l/J
         3rZ+lsm0zmuFbdKBp37iEhN4Qh/H9mFkXYfpCZcHgSjfoYfBAuReYdufyTePXxNwHTxP
         i0gHmiYNmjg0zEIK3k918rRjrKczi1oibBIQ0/5xJJNlUEUta9dpIECPoYFpESyNso3X
         ILqqYeuXZ90bbAq3OzfwDnAH0STgUl6Xl1/RSHoSEqB9b9LBw1G7XE6f9nfxkd6oPMcT
         uvjZjqqqczETWdwWV7UVzd/K2BkpPDcxfapwq4GPkngXC8/e3+XUG1RXPMJFiq0UFc5e
         NxjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787853580; x=1788458380;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d4/+pFI9X3x+m5kaMfH/DHqftGBwKmr5KIRwmuCGmb8=;
        b=TO7b34yS9xRDMC4YH6Ivdb3KjrsjdH90YFJjzyfE1XEyOUBZiF1byfWE3KFaofQNF3
         9DLf7/z5McmQPDaI4cwDtddoiOdCH7cUFe7wRehhJyyjTLboHBsu0tz3pOu8OlqnwcUU
         AIdU+uKyBn86qfTKtVVD64f55YOWZuYDCTUBQJ19dEXUkWRH9YA4DNiVT6A132TQNzaH
         bCsQGqohov7yVREE6OMTD4IzcfeNnXmHaYJrQpwqq9AxRcPkMguLyyq1C2Qokl1ktyf0
         jcQJTXCkRSKHgjSQ6MBPPqBGnMdZtQvd40yatzAcw7IKfjRrUXJssEkbJrCV0B+W+vmO
         E8nQ==
X-Forwarded-Encrypted: i=1; AHgh+RosLYrZsZ8t5dqw6qT4Nl34JgTG+n43g+XoVsW6RA59eFA1u7sI+6hv3rSsJKWuE9pAvihJfZ4nwb/JPjM=@vger.kernel.org
X-Gm-Message-State: AFuF++nIgtmuk3hOz3fGnop/x/JibrZqN7QzEzD1dk1qaTflLdb7VrlM
	27QXEc9KkFLTcU0XxI80sQawjYWVtwRb4XedfrUqdG9TgiA2SOrwxMkeYbdSYe++gtKG9tbkuYw
	0pJ8Cs+vnx0y5S6h3ZUcw8NEyteS1Fqs/reEwmTY96E9C/rChczAFC/DR9j8o7TBdkkQ=
X-Gm-Gg: AR+sD113tbgyr4zxaNBYyevraY7l60tw2s6z67Edkxr+HU12PaTEMEc34lDYqMGNFEb
	IIj1zn9FA7nGht7zzc/zOklrA7aFHrHZOIogaFywoT16Tau401z+lM1atKEXP61VgnmWJPa8o77
	/rI6j/pdifJyhUCyWGK5CCvkSTUBpWImRAOiv2DcgQpbtu61XVePrnMZaGzB+F/ZXZi/r4+n9Tm
	cuD9rDr/XeeVOPbbCO3knXmyhoUyyew9qCvb0DyXp8xrPz87XyPM3Kdv2yiTfRvo8aKo70xiecY
	EU6pIm2N724ux8gD/ynD6RfftC8leYI0TMw5Jo0pQWlac1edAzQHVChbmjg6mLZXahqHI4DC+FE
	uUg1sSqRpdUMA+XyiCj1kR7TvTU38P8N94A==
X-Received: by 2002:a17:90a:dfcc:b0:380:f389:447b with SMTP id 98e67ed59e1d1-396d0fd3a24mr1900892a91.11.1787853580258;
        Thu, 27 Aug 2026 10:59:40 -0700 (PDT)
X-Received: by 2002:a17:90a:dfcc:b0:380:f389:447b with SMTP id 98e67ed59e1d1-396d0fd3a24mr1900802a91.11.1787853579715;
        Thu, 27 Aug 2026 10:59:39 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a905cf38sm27437523c88.12.2026.08.27.10.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 10:59:39 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 23:29:18 +0530
Subject: [PATCH v2 1/9] pmdomain: arm: Fix -EINVAL from
 scmi_pd_set_perf_state() on state 0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-1-091697dbeb02@oss.qualcomm.com>
References: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com>
In-Reply-To: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com>
To: konrad.dybcio@oss.qualcomm.com, Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: mukesh.savaliya@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-i2c@vger.kernel.org,
        Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787853566; l=1380;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=GuJ2IiTNAbocaQLtHQ5QQk1lc6LqRCoanYaY2qkKLA8=;
 b=uHr3/INLh9B6c1OSy+HkMvDYKMGogOjcbm6b+zN0jVzPu8xWpULGobB+nh9HS0n4stNuFMgOJ
 VBVVR+W8kmCB6yTAsu4IqWK8QP4Z1T4YLzVn1c50MlZWoGiWls+ogiQ
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE1MSBTYWx0ZWRfXwqfBGgXCwDmO
 oW+SGq8kzTktz3J0q8Spex7kvKLFSc6n5i+d986D6SiG1xYhynVQAJtvt8X+IfdhEIXvaUNQzqY
 WTIqsF5N1uh+vvLMgZ3OGigJskUuh50=
X-Proofpoint-GUID: LssnJ3yaPFyWSxgxFmbk-EM-W8ukpBzt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE1MSBTYWx0ZWRfX64L40xzKfsyk
 I9ohl7I5tHbqLqqgYYmGUNXMnrHnYtKbMiDx8FTwrVv6/gwpEGnf+1CsNAGahLfq+AWdKIJShMl
 EdvXmh84HvM9jd40ktxR/61ShTR2V9kyVPXAjocqdE+JOhQxbSirs3n/wRZmYv8sN4Bqo+KFNop
 terqCaPQChmAyELJvvdRONjLgmacbkcC6WfDP7bRaLC4qAq2WllPgnX2BRlthwsktYg0A5EpAiV
 aGwyiERdmB5aKI5HGxMBnuCTjeuU0LSCHzILKhfpvj6BXAjLFS0WXm8o6L4Sb7GvMiS14SjR5Yb
 lS7obEzX0zrQ6gH3p0gbda8kRHMALdKfMUwSynm9kgtxka41Kuf5vUD0PdFbrSkXGJOJ1zFI5rd
 +R5xRgslsTlabRniMW/1zaAAUYGQHkb/d0F8brmiq4qkxVMIWsUZDfCnu3Rs9g5rC03aSQh54xd
 Diy/k9PKPv8MezE8Yvg==
X-Authority-Analysis: v=2.4 cv=eIgjSnp1 c=1 sm=1 tr=0 ts=6a907b0d cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=sIx0R2CjXXeYvnaWutoA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: LssnJ3yaPFyWSxgxFmbk-EM-W8ukpBzt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_07,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270151

Currently, scmi_pd_set_perf_state() treats a performance state of 0 as
invalid and returns -EINVAL. As a result, devices attached to SCMI
performance domains can report failures when relinquishing their
performance vote.

The OPP framework use performance state 0 to indicate that no performance
vote is required. For example, dev_pm_opp_set_rate(dev, 0) is commonly
used (by firmware or linux)  when a device is runtime suspended.

A zero performance state does not require any SCMI performance request
to be sent. Treat it as a no-op and return success instead of reporting
an error.

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Reviewed-by: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/pmdomain/arm/scmi_perf_domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pmdomain/arm/scmi_perf_domain.c b/drivers/pmdomain/arm/scmi_perf_domain.c
index 3693423459c9..e390f902a444 100644
--- a/drivers/pmdomain/arm/scmi_perf_domain.c
+++ b/drivers/pmdomain/arm/scmi_perf_domain.c
@@ -33,7 +33,7 @@ scmi_pd_set_perf_state(struct generic_pm_domain *genpd, unsigned int state)
 		return 0;
 
 	if (!state)
-		return -EINVAL;
+		return 0;
 
 	ret = pd->perf_ops->level_set(pd->ph, pd->domain_id, state, false);
 	if (ret)

-- 
2.34.1

