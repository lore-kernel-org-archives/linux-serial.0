Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057604B04B6
	for <linux-serial@vger.kernel.org>; Thu, 27 Aug 2026 17:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787853599; cv=none; b=l8hUl9qL4hpZNR5cpS5sL89Yc/LRKmDhXeIiWCTF9hVYKDHbffczTu8s1vRWkWV1+xftcKeHSiPzdV6uBXUNSoAUecnCKSMjxD6FWIoExCdMhEKJXc+efgsp8d2eV+qQya3zSAgqo+Sh4SRwO23/f7QfNPfggqKGhJ/tb374vGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787853599; c=relaxed/simple;
	bh=zHylj+HT+odz16Na0xE7+fHmSFeJfsDp+dwqk6ejkcI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D+voanAE/cZmNSVgm/jMIPzpJfSzUkAMTrFkzi7sKiKoNR0RCEWNVP+lSQ0cPXoZdUY+03RsDEaSsK1GnbFX+4d1lVAiwYOOt/7dXFLxadtB+3TrBzClFBoUTSPc+ifNcrxW9MDfyk7kVzASj1WQzy06nJ6kVFVphL1yjDjtYpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UAtJCKHa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gYPKTG2B; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UAtJCKHa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gYPKTG2B"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RHXaht4178238
	for <linux-serial@vger.kernel.org>; Thu, 27 Aug 2026 17:59:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8DOW3HbgGxcyvtK23icwnWTlfQLNr+HRAry9Zia2hG8=; b=UAtJCKHa6Dlsrkq8
	uWFqMs46OBjwNq6g9FnkPBpJl488R5DLKm++C0kjfwVtzxuNlxpaafcQ4VoaRrlS
	mA2d9H2gUf5Nmmvii1ZPx00Q/uDTBX/7plimlKWFBSD7hRZT0RnBRARzsGxx+NeA
	3phMoH8Eo5ANlDVCTuPAFi3giUTGE1hC0mrwT/OSb2+tu8QV1ZxJWroKmhd3nKNt
	hcgpn8nvFAp7iFiPCe2Aa2+PiwVCP4iygoaE5H+a/7pmD6AQg/HaCpxWl/hG4yr+
	E1r76PtkevP0+otO/ir6wSkkN/5nTBK98XFezGZXcF/pqh+uv5uJnuBWozQgDyJw
	MzSJnw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gaphw14te-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Thu, 27 Aug 2026 17:59:54 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-388cfc4848dso236972a91.3
        for <linux-serial@vger.kernel.org>; Thu, 27 Aug 2026 10:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787853593; x=1788458393; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8DOW3HbgGxcyvtK23icwnWTlfQLNr+HRAry9Zia2hG8=;
        b=gYPKTG2BSfWYTYDnvU8qj8pi60Y8IMubHFG4SJ9g1l0wkBhoh0+GKvGdLcr/C2/AKb
         m06hkbOzoRnZmqa9Z1pU5RVgjod475PbW50ehV+pi4cp3lGIlf4U1UmbwMBTR/He6eYm
         i+uXjUWp1AtgHmlWHgy1XInMK6myIyKWLL6Mt3BbMsG0oS/3dgvdNGX/PtB7R+mxKe/1
         nfFFZ7YJ7p0zTePIOWESjcUn2zHFpJiSryzhoZlD4o/VJPkb8GO5tDt4m+E4hJ0XQWkl
         SZm85RYypNQCBsAPav7Znrcj8z/JQNokh6xYAcqrADTbiGO5WEoqu76+k3h3WsrvzQiN
         xrTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787853593; x=1788458393;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8DOW3HbgGxcyvtK23icwnWTlfQLNr+HRAry9Zia2hG8=;
        b=LzqQ1Sv9kLGwWFn0QlJ9P6BCcibc7gphNU4sMnGR82e8kcxg/GrxyzoqvVFBan4cPC
         aAso9YewYZhkEPH68n8xzuzESAWeB/PQ/EhQw1lObclIc4VDB4RgtIo8+5q4sQtqTXNh
         aZwKfU3xSOGfOlsUrZlkl1MAaCVSl72EFmJuP/tYAwscuWgFEICY60WtXlghMprq3owc
         dis9zYfXUTxuxrvlWXRObvr1EfSsMNlQ/VjBgAwwxo3H4k4tmla6Uw+sjSsn+1JWp/As
         xQrZVWhwlQ98kIs7eS63FjcEfEQe1pJRo7MtT+iBAe4mzEpRsdvOrtjLWK0R3Ygmeu/H
         GQng==
X-Forwarded-Encrypted: i=1; AHgh+RpuxInwgIIHA912TURz8P6nMqJzdBGEc/MQ5DUskMbaAunedIjh6k0ZZuTwr17UsmmDEPKbSJ4lqbkkgyU=@vger.kernel.org
X-Gm-Message-State: AFuF++njaL1NUeCAgt0ZTH2sxWbc92jhrdOvzuXfbTwAGIecIZLV7EUE
	Hcz3jG8QkoLn8vTBEeSGnS40BHIHqITgT2uOUrsQvvjfsvKR0hhXlyckIlote8wnupAIN8LP7pP
	G3unVRG4Hti1xQO9n0Enpiqv64PirK0b8INafAM5Zs9MRh88y7QZR3vklax+AwMZUhIY=
X-Gm-Gg: AR+sD13syoJarWnSmS8RuvDRfkFew8fshv0I3Dad16f8beXPSJje/uMDSEaP6jWJE41
	xVfoZx52VOwLNduM+9BCpXwCB4ZpBZNk6//SkS9fj2vllZ3UhjemGsdmh2kFaXsCcpHyL0Wx86v
	OMg/gizn2C3sW6wqdRZWhah5FqC4pzxDw9EhgSSHPNebr+r4ripYr97bJpk7LZZFii4FeFiFVJx
	2KdoXPP8XDjWltQfPET5gf6r6Nr4ldjdTKVEKEfYKPKqMD9RASgaPcemqmTtPDASaUziM4sJFX0
	3mDYIcb0xsSZlo7/SCZJ5YMyhTrpBStphcm1MYDC/gH+QgDSfoqzir+U2bwuUs5OTW4OfRiFwOa
	ku2EzUcnaiBXNyGMDup+m6wWtolNJcCuXUw==
X-Received: by 2002:a17:90b:2d82:b0:393:194d:5366 with SMTP id 98e67ed59e1d1-396d0f6f8bfmr1853252a91.10.1787853593456;
        Thu, 27 Aug 2026 10:59:53 -0700 (PDT)
X-Received: by 2002:a17:90b:2d82:b0:393:194d:5366 with SMTP id 98e67ed59e1d1-396d0f6f8bfmr1853160a91.10.1787853592820;
        Thu, 27 Aug 2026 10:59:52 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a905cf38sm27437523c88.12.2026.08.27.10.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 10:59:52 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 23:29:20 +0530
Subject: [PATCH v2 3/9] soc: qcom: geni-se: Add helper to set SE clock rate
 via OPP
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-3-091697dbeb02@oss.qualcomm.com>
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
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787853566; l=2911;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=zHylj+HT+odz16Na0xE7+fHmSFeJfsDp+dwqk6ejkcI=;
 b=w7NHm9ePtmCqH/3jPw8yr1znOlCotzsen4mcclKd4jYwSgqnAUCwLzywWanOrvCDjLjvkCNPx
 uioUNiPLBtcBegA9YNEWcnR0C9gm3bYAbB7KKI7C4dmnOjgoYDu3r1+
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-GUID: B1aBEE8Zs4quSTLWKePnvR25mroiMjbc
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE1MSBTYWx0ZWRfX1VW1YPq+igYB
 fjwJp3rWgffxvARz543GvGrbau7w2qV0pM+Gmu3NGcML6IE+5KZJG3Y705rdVyRRSPAIOaPYy+p
 yzymUaxU52xRt/wkg5zQqn+8ytn+SV8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE1MSBTYWx0ZWRfX3Dl5/+12DoPP
 4e5GphUUi3TLe36whJ/8r7C6lSWWF4/2ApcJhZHGGAtTOFJJOKLkAkgbuFWzgRH1eDD41yz1dWH
 TJ9dQzHeUcT2LhRxY8sbxKnQg95oSCP7AdIp/xSVyuDA9eHJOX/ocpStDIlN+yK8/b9I45cNtPD
 DwpdVmq7xW1E5L+c5MLOxKAZi6qGUlPM4gg93/fScO1YMEkfKnGdDqCdhHU4SwTRhE8Kxm0wKNK
 cMIj29flmbi5QXzbiLP/CUUe+mTpxijK2rINpYyNblYCjcp08pFhMvy9tSrXQx/DOFQn7DBR88F
 tj8xYh0r2+7JE/N8Rfys5BCPmyNt/G+JTsvGbjjW+OFVzscigELqw3Fwh6txPT+PDadJ8o/qms7
 aZriFMdlFGM/0zXcHxAIIXHNenE0XZQuhbY2SP1cHA8k1E4dIyQqrtsOCsbgBfxvFWmnv6BjXwH
 fSXhIASUD7VloQiy/4A==
X-Proofpoint-ORIG-GUID: B1aBEE8Zs4quSTLWKePnvR25mroiMjbc
X-Authority-Analysis: v=2.4 cv=E8b9Y6dl c=1 sm=1 tr=0 ts=6a907b1a cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=590DCAjQX6RtSPayVpcA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_07,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270151

GENI protocol drivers need a common way to scale the SE source clock
through the OPP framework. However, the device that owns the OPP table
differs depending on how the SE resources are managed. For Linux clock
managed platforms, the OPP table is associated with the SE device,
whereas on firmware-managed platforms it is associated with the
performance power-domain device. This requires protocol drivers to be
aware of the underlying resource management model when requesting
frequency changes.

Introduce geni_se_set_rate(), a common helper that abstracts this
difference and applies the requested frequency through the appropriate
device. The helper automatically selects the performance-domain device
when power domains are attached and falls back to the SE device
otherwise.

Acked-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/soc/qcom/qcom-geni-se.c  | 22 ++++++++++++++++++++++
 include/linux/soc/qcom/geni-se.h |  2 ++
 2 files changed, 24 insertions(+)

diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
index 447b9cc6babf..04f58a6f26ff 100644
--- a/drivers/soc/qcom/qcom-geni-se.c
+++ b/drivers/soc/qcom/qcom-geni-se.c
@@ -1149,6 +1149,28 @@ int geni_se_set_perf_opp(struct geni_se *se, unsigned long clk_freq)
 }
 EXPORT_SYMBOL_GPL(geni_se_set_perf_opp);
 
+/**
+ * geni_se_set_rate() - Set the SE source clock rate via the OPP framework.
+ * @se: Pointer to the struct geni_se instance.
+ * @freq: The source clock frequency to set.
+ *
+ * Applies the given frequency through dev_pm_opp_set_rate(), targeting the
+ * perf domain device when the SE has power domains attached (firmware
+ * managed path), or se->dev otherwise (Linux clock managed path).
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int geni_se_set_rate(struct geni_se *se, unsigned long freq)
+{
+	struct device *perf_dev = se->dev;
+
+	if (se->pd_list && se->pd_list->pd_devs[DOMAIN_IDX_PERF])
+		perf_dev = se->pd_list->pd_devs[DOMAIN_IDX_PERF];
+
+	return se->has_opp ? dev_pm_opp_set_rate(perf_dev, freq) : 0;
+}
+EXPORT_SYMBOL_GPL(geni_se_set_rate);
+
 /**
  * geni_se_domain_attach() - Attach power domains to a GENI SE device.
  * @se: Pointer to the geni_se structure representing the GENI SE device.
diff --git a/include/linux/soc/qcom/geni-se.h b/include/linux/soc/qcom/geni-se.h
index 29a53bbc0dd4..3b411cba9339 100644
--- a/include/linux/soc/qcom/geni-se.h
+++ b/include/linux/soc/qcom/geni-se.h
@@ -596,5 +596,7 @@ int geni_se_domain_attach(struct geni_se *se);
 int geni_se_set_perf_level(struct geni_se *se, unsigned long level);
 
 int geni_se_set_perf_opp(struct geni_se *se, unsigned long clk_freq);
+
+int geni_se_set_rate(struct geni_se *se, unsigned long freq);
 #endif
 #endif

-- 
2.34.1

