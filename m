Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2CE525A90
	for <linux-serial@vger.kernel.org>; Thu, 15 Oct 2026 12:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792069120; cv=none; b=tKvqHmLnUcC+ndSocjE9QxNhAYJnlFGemhDgqVlO5Sw6pBMwfUxeMEmw93WUKZfmrs55SQVe8a021BUU4kDpgCtRghS3bVKH4yLMshuL3Uh2rjiMUN5+y3mSbrMIeVx092f8IMtbpayI3tphOEWPN0l3N1nfT+SkW8dMenOFp/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792069120; c=relaxed/simple;
	bh=v70FRW5iiRhX/4+aCXUZxMXenF3esiNtKu86as7Ptlk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bAjdBdrhfNSdSiYeKWYrwShEp2tP4wbvhc7i+QMEkPXMLeJd3ZqAm3q8F8ErZ7wm0xKE7IvOY8FbxDdxm26JHvo/KRgOC0Tb57A1LN5GWxUbbwQDKHR/MLPszAdzvpP6p7QTyk7I2uM0U0MCfv8CGe3sPhy+jioH81EcPjrypnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pKljQCPe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cmtBppPq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pKljQCPe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cmtBppPq"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69FAPud01596368
	for <linux-serial@vger.kernel.org>; Thu, 15 Oct 2026 12:58:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=fn80m7lvIkTjz807COGpVE
	82JK0kaqF+rlFlpuCly0s=; b=pKljQCPe4m8ZDljQiurPI5am68GgBOMrgcdWYY
	7qp0lbfjVuJmJiR1wFrlmBprCAZ1IYBJZajlZcYLnoWXBc/QxDMGKGMYBXRbScml
	YyQrb7HyJgAxVpdBxrnVOa9ps7CAU48f+gkbPIqjUcrPblsoo0GlS/ZrHdK21Etq
	mg92OeS3LSxAP1kFuVgTkzIDFPcEA9YJ1JEKMQfduWfeQT4teghicjS47L60aesO
	c5NluH+rj8SiUjVw8Db7ENRUcm0D00dLSqoP07fmmyajp6vAlvOUVNp6/OloNHBf
	TkO36L8XLx6dT85GTYQCOJMplll2/gTDwrARXjqOX/JFY9RQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haw2v8hmd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Thu, 15 Oct 2026 12:58:37 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cfa4e4684bso29933415ad.2
        for <linux-serial@vger.kernel.org>; Thu, 15 Oct 2026 05:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792069117; x=1792673917; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fn80m7lvIkTjz807COGpVE82JK0kaqF+rlFlpuCly0s=;
        b=cmtBppPqRAB52leel1r9iP3XXEKgq4xWTXXmdcT2U467+Ajj+ttoXt8qnwiwSWSJNZ
         77r7knKywr0dgP8V4NKnhXQ31C8gKm1NDFFZV2V+BXcEtRwXuJxR+oXFklFra/Z98scZ
         9KyXR0H/nkI75dVDFIgKLI5D1EwQKlARiS4l9GEDHc7N748n77o91bX+JmU4W6I3c8vX
         sc2v4+pOXQ+nW2r7A2cCJWUXsd1IR9teofboC+k++vrlFjOCSx6siceiurteoRt2yM0q
         eeDKtCWfv2Eu3w8HwOayGx7l2Jvsf/x2QCk69yM/VS6lp5wNUGTptS4+Lg4SQE8n3Kz2
         CZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792069117; x=1792673917;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fn80m7lvIkTjz807COGpVE82JK0kaqF+rlFlpuCly0s=;
        b=WPU7/sXXxbHJjJK0K47AFidVzCStnsBeASeo0dv+z/M/nW33bOSn8jfOtTMGYDzxBF
         h0F86BtK5JZa3NmDAKiT9lA1u28PWWxnVy9G6cyQrjzB43X3HhPMihkE0Fsm8jtnJ6N3
         vIZOlXBO54ZiCz8cEnGin1hI/8yby4p+ERV/EPa86nwKH5BKc5SDoNi0pVL3s/tJa0Hf
         khLKticZJM04hVokbV1FWOOdr8gMZ9Udzp2zlGn51BwyWXgv2o86lYpqUHxL6lRyQANw
         Cx6dcZwVIgysDP5i7MMkMECclEB7TvoRcJoJddmZ1grPxhRhtyEdsoSAS9mDsyQsZItK
         9NsQ==
X-Forwarded-Encrypted: i=1; AKwUvBx24XlJq2cNLc9zdVaob8tBQ/21eL9mWLmScjRyDeum6JT2uMr31xjvoUJuXi/9EfhsqVWDbhooLuDeQJE=@vger.kernel.org
X-Gm-Message-State: AFq9FYI5eq1v6OGP4Ac7yJ5t5SyTz6ypB+MsU75/g7MzzIS22PpeS3zK
	01C0bsV/CxmXrZP6uhoh9aUcW2PAsmtxTxvgMwUiIFrMChyPsc7DlwRv8kNc+J2wMpcLedx3Dlh
	ZK4wP92mQyCU1mCQgdcouBk86nIIJ1Kfa1ZeLWMozwpCM475w7w+LhXqy5RYOHBcq5jw=
X-Gm-Gg: AYBFou0iTwvNWXvEGpTozwUqbBBWXPmmkXaz9HFpnQzB3zgLQftTIo8NwI69BIld3Ps
	ewP3Qo5UET/+G25A6Lh+bHm6cbpvJHN8SC11FDzoJVhLspd/5phjvAXx22BtS/3LdoJl7W4FGS6
	ryCp1NcRAfSMVVXXxNqzB1ZvtUFZ69Ib4tl1JmEjA6FsuOCyFKhXwkmDASGtIyMHKMnz4wS6wH2
	nZDG6sN3POTikrGX6IfrZP/tcqEoATQPVerABQp2EO8AGLdGvuqkzoE3bq8yToyf4NJGu0p3bib
	mNE6hbaNHdv2sS/pq1D8eCD2Wu3oqY1TBfLleAGBGzWf//Fkk9a9Caaaom92MbToNsj4Kglunph
	1ywy80FdQSEfV13NvokV1Fe8W+VcN9ozsOw==
X-Received: by 2002:a17:902:d50a:b0:2e3:1bb4:610d with SMTP id d9443c01a7336-2e842f31562mr166589225ad.50.1792069117088;
        Thu, 15 Oct 2026 05:58:37 -0700 (PDT)
X-Received: by 2002:a17:902:d50a:b0:2e3:1bb4:610d with SMTP id d9443c01a7336-2e842f31562mr166588895ad.50.1792069116492;
        Thu, 15 Oct 2026 05:58:36 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b8d8dsm79691705ad.52.2026.10.15.05.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 05:58:35 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Subject: [PATCH v3 0/8] soc: qcom: geni: Derive SE clock configuration from
 OPP table on SA8255P
Date: Thu, 15 Oct 2026 18:28:20 +0530
Message-Id: <20261015-derive_clk_perf_tbl_from_perf_domain_opp_table-v3-0-5da1096243c9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOzN0GoC/52OzQ6CMBAGX4X0bE27RBBPvocxTX8WqQLFFhqN4
 d0tevHgRS+bTDLZ+R4koLcYyC57EI/RBuv6BPkqI7qR/QmpNYkJMCjYlm2oSX5EoduLGNDXYlS
 tqL3r3mRcJ20v3DCIUaoWKdRQSZMDQCFJejp4rO3tFTwc3xwmdUY9LpXFaGwYnb+/FkW+eH/HI
 6eMFpyXXCqujca9C2F9nWSrXdet0yHLhggfFSh/rkCqsIoXVWkUKgZfKvM8PwHOdkKGawEAAA=
 =
X-Change-ID: 20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-2f29ad32226a
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792069108; l=4235;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=v70FRW5iiRhX/4+aCXUZxMXenF3esiNtKu86as7Ptlk=;
 b=u1m3iW5BCkVT1gNC6NXOBIobcvi6p6ZecmCB7PJ6QxVqlmRw8ffyqb9rCaDH04jFYYTlQZXWh
 YSWnLJ0Bgu1BjkBTlL/XVn6X+JoGHcmU9dOvlGgu3Qc/pr8Uza3vAAY
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA1MSBTYWx0ZWRfXwB2E66PmLarH
 mVxx0+ZeoiNMpMy0CeucJT2U6UK6nGnsJxeE6dMY1EN5VCYtgQ0oK2nyQoXy+SQamsc9vbXAVPi
 CTSsdlSq4PoPwxS4E2q9oGWvmcu/quclvt4n77uQbI3JTDky8cbNOdhsfJvLcGCOjuhFOYeF+KK
 if9MkheAcsBgssD2NP5/96cm+BrLqJUzvpcpmfMnvsyBGoJ7DkkxVpZnGTexgRXWXIYg/E7Qk7f
 aUsb5U40OeHqrOCrPWY7Z18qZXbmXBbwDJdqUCLnUnQlJlHmEA3wrEX+OhmbQ9NpwLi6Lsm5iBc
 5Kp/kHJQK4v1oLa593Wq22c1nM1lVVIvdHfRD/6nX37su/MSGyE9uyYeFdTbjqM5R0sj5PZqNqS
 NaXpa7ccuCoEU4GvM4pHq3JQENSj2plzs0xwVcbDKHcuS+vIwZ8ZRvSzowx0kgcqwVt4++QuYT7
 4Mhs+DnZIaO05HGfUpg==
X-Proofpoint-ORIG-GUID: RlgfvC7QhS1tr43-SD8zojZL_-FTj4zY
X-Proofpoint-GUID: RlgfvC7QhS1tr43-SD8zojZL_-FTj4zY
X-Authority-Analysis: v=2.4 cv=G/CJgNk5 c=1 sm=1 tr=0 ts=6ad0cdfd cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=2LTROXezBIF7KgQVBLEA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA1MSBTYWx0ZWRfXwxQPK0PPRrEE
 wxiAKlAfpbR1vSI2+4EZvCWPAF2h7qoHmVIVoBkTyQIOmEZPr5psN4ScBocKLhVooCrkx7nimKR
 JpXRwKBwnuf3hxcp2nZ4lUk87KAg4ok=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 suspectscore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150051

On firmware-managed platforms such as SA8255P, there is no Linux clock
handler available to determine the appropriate SE source clock, source
clock index, and divider values for a requested protocol frequency.
However, these parameters are required when programming GSI TREs, where
the hardware expects an explicit clock source selection and divider
configuration for the serial engine.

In contrast, platforms using Linux-managed clocks derive these
parameters through geni_se_clk_freq_match() using the source clock
information stored in clk_perf_tbl. Since the firmware-managed path
lacks equivalent clock information, protocol drivers cannot reuse the
existing frequency matching logic and instead rely on a direct mapping
between protocol-requested frequencies and performance levels. This
creates a separate clock configuration flow and prevents
firmware-managed platforms from deriving the actual SE clock parameters
required for GSI TRE programming.

To address this limitation, the performance-domain OPP table is treated
as the representation of SE-supported source clock frequencies. During
geni_se_domain_attach(), the OPP entries are used to populate
clk_perf_tbl and related clock performance data, allowing
firmware-managed platforms to leverage the same clock frequency matching
infrastructure used by Linux-managed platforms.

With this change, protocol drivers can use geni_se_clk_freq_match() to
select the closest supported source clock frequency for a requested
protocol rate, derive the corresponding source clock index and divider
values required for GSI TRE programming, and apply the matched clock
through the OPP framework. This removes the dependency on direct
protocol-frequency-to-performance-level mappings and provides a common
clock selection and configuration mechanism across both firmware-managed
and Linux-managed GENI deployments.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
Changes in v3:
- Added a return check for set_rate.
- Remove redundant source-frequency fields from clock tables.
- Store the validated frequency in gi2c->src_freq.
- Use it for OPP configuration and runtime resume.
- Preserve exact source-frequency validation.
- Simplify OPP level iteration in geni_se_domain_attach().
- Keep level initialisation outside the loop.
- Increment level explicitly after processing each OPP.
- Link to v2: https://patch.msgid.link/20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com

Changes in v2:
- Add new patch to remove OPP rate reset from resource deactivation
- Add new patch to vote source frequency via OPP for I2C
- Compress the SPI, I2C and serial commit messages per review feedback
- Drop a stray blank line before trace_geni_i2c_bus_setup() in the
  I2C resource-initialization helper commit.
- Link to v1: https://patch.msgid.link/20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-0-61171ab1cdce@oss.qualcomm.com

---
Praveen Talari (8):
      soc: qcom: geni-se: Populate clk_perf_tbl with SE source clock frequencies from perf OPP table
      soc: qcom: geni-se: Add helper to set SE clock rate via OPP
      soc: qcom: geni-se: Remove OPP rate reset from resource deactivation
      serial: qcom-geni: Use geni_se_set_rate() for source clock configuration
      spi: qcom-geni: Use geni_se_set_rate() for setting source clock frequency
      i2c: qcom-geni: Vote for SE clock rate using OPP
      i2c: qcom-geni: Use common GENI resource initialization helper
      i2c: qcom-geni: Use geni_se_set_rate() for setting source clock frequency

 drivers/i2c/busses/i2c-qcom-geni.c    | 58 ++++++++++++++++----------------
 drivers/soc/qcom/qcom-geni-se.c       | 63 +++++++++++++++++++++++++++++++----
 drivers/spi/spi-geni-qcom.c           | 24 ++++++-------
 drivers/tty/serial/qcom_geni_serial.c | 26 ++++++++-------
 include/linux/soc/qcom/geni-se.h      |  2 ++
 5 files changed, 113 insertions(+), 60 deletions(-)
---
base-commit: 1fffefb00cc0b0da1f2ae24e3d33364530ea6515
change-id: 20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-2f29ad32226a

Best regards,
--  
Praveen Talari <praveen.talari@oss.qualcomm.com>

