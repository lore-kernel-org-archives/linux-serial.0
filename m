Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207494854F8
	for <linux-serial@vger.kernel.org>; Tue,  4 Aug 2026 19:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785873485; cv=none; b=Y/XVExnrptmJ/7pq0086ECxt045SC9fVKOlBqrNMh9nIG8IdviAWVFIX6Gp8OoSth/jFroMmA+DeVfZuKYbRFBy27pYZvpGP6vlMj5hHPyB53EnFeXP9SxiccagWx2ATEU7sqtVUgmKcS5HvHB8yomQtTa9MlUALrvvhdsEi6Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785873485; c=relaxed/simple;
	bh=30qgLQKKCow2Vd7Rsipof0YfdQ8riHpCd1YMdGG0SCQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=founTERLaNqRwkDKPUGd7CgOd9/Lom0f2qvvkrKBjJ9ox47/1O8aqP+3cO3TcN/hHsY5RxNJEmuWsPvfdU01heSSJRXTjJ0SpqgZJg4/PgWiJ/QXx837cVrlhSP8qccRHhyKbl6AitAj0VVV7/XC3M2s8kl1Tu9g2+BUw7G5/Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bLQTv8LK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MmqKdUOc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bLQTv8LK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MmqKdUOc"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674Jlc4Q701384
	for <linux-serial@vger.kernel.org>; Tue, 4 Aug 2026 19:58:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=96UrCWv7PjJtStf5Ags8L3
	GA6XNzs2BmN7ZndIZVjpE=; b=bLQTv8LK0U3o0+vtg49Yy43Aaitj8WpZXbpKUL
	dsEbRKqPO4kSvyTxeuIB8UJWqgSJlS9/R04s/Kxz3TtEUUYFasJShBiOCNyjhbiB
	BdUEmMkX122DE4y3/lFhEGDKNuEIgSAhZ/V74/0ZyU6mZQH9c5vp5b1ANEYdYvhS
	8lVv4JtClf+wpObhijZon2Qh6wvCGTHA6QMZGyV6wx3KW6YChBrNIHsaf5/JLZeS
	5+zmxWJ3URA5P3+BxdhFltUpAa2BjVJF5405+HXLLNUOQxi7iG6doTf+APwwarPs
	24Gi15VdYf/D0faOy27/qx04NnNMZUigGmKK2IeYHbhs2gUQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fum3n8t2s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Tue, 04 Aug 2026 19:58:02 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c96b4f58ddcso122087a12.3
        for <linux-serial@vger.kernel.org>; Tue, 04 Aug 2026 12:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785873482; x=1786478282; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=96UrCWv7PjJtStf5Ags8L3GA6XNzs2BmN7ZndIZVjpE=;
        b=MmqKdUOcVJsayT/12SgQY1VooUpQ98k9VUgKp9segdDJQ56LFqMvfSnrzHAE8GsD/m
         r8GptY46p5F3Qu7QWhu1DYctwUdJRewixq12MJUYOhBeOZlkGFX6BXbjWY9RQPAVs4bO
         8u1D7MCq7yxZXhAaRDpm58Yc0hMnonjZHqRQ42P1Z7bvO2G6muUHjRZK1wmURgn4wVbN
         MBOdS5JYmbAVqqQDykse06r019aoS9WjIbiuPItJ0kMsH3bhldHgDyGRYmQkHasQfp7/
         EPAXILyewc2m5kYDjWWmwlmupFuSPdjtOqw2J92B8xMbM/jB5R+Wf8wftPX8YsbRLw8c
         hGsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785873482; x=1786478282;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=96UrCWv7PjJtStf5Ags8L3GA6XNzs2BmN7ZndIZVjpE=;
        b=sd46vJiY/Alc7C+8V5JpAKllFoAyRGy2OuAp0hOgkm25z7aU0U+znieMz1UIPW/cd0
         UpkQh4ptWhZkBcEsDcaHNMEnbs7GfJTnrx0juFKx46CJXQquYWJiNyjbXQgPWHJ3xY4G
         5+0Sn5tHn+ag+QVbr3J/BBiIBaWjsJIcM11BNygZgyw77QYs0mWahi4PHN0SYjCzQOAL
         E8RaPWha9eDvzwS2mXRa06MlvbZUUGF0v0eazbxHJWilW93Jtg5Y0GkdxiY4gaDf9VAk
         3KxMVyfpaKun1VmdoHR+Okwj/FdOrM0pvtqP4kmrgmK3ty/kQ5ldbopxiaN+zoW0PYoM
         JubA==
X-Forwarded-Encrypted: i=1; AHgh+Rr5bZ9/czSvfxcwPLJKTtrrO1rKeNBR3wZMGhCIbGY2M/pamwr/xgo6aEDNWjZPfdeUp+o5cG3UQqLtY44=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKzJCQkiySPmb70neV2H/alCNiQk4pDXPVy6Xt/2IECdzPW3HV
	leGBlA8SauwjE7Gfi70EHPEC5yhpM4bp+TZZP4bngBunIyBKr6RkXZZpNGe0uAKijW40ejLK14e
	wdEkeCJG2esef/m3u2JhTHMP0jYF89CV9lxsEKIqQY66zw7e5uog2FQuBkq5ERMim+LI=
X-Gm-Gg: AR+sD11bc64pAclVdmhLfeFN66rJ7+8WrhPqRgOjJWejFw5lsRxtaIkT0vBpjO5zwE6
	QqR2vBIATNKN8MBTY5KkDMQ7Haf0/8F2URMyAwkxPX7NehzseN02DeW6OkfBazdOxVmMKnuFrR/
	QAj+O4XMTDGr1cwfLMwIaN4ol5DvfeOFePxEJ7nbwF30AU+wsRYY4onie04GdVVRxJNUv8v0Jvy
	/Ivde0Nimj9nnQp0S2c55rKMLXfLj4ocSfxoZ26MzNZAJIGsi35Gd0Qs2q8aFvuyzhHkNsb6L62
	vwNEkLHhAH/pDHjHkUZJ/250//zgo+tmcCM3JbU2mR3L/rbWnred5e9muhNp00sCJu4CdmGn5xT
	q+skcIkvC9ddJ/1SkRRXV1L5wCTI8dIyk/g==
X-Received: by 2002:a05:6a21:998c:b0:3c3:a20f:f720 with SMTP id adf61e73a8af0-3cb85fac059mr1216114637.36.1785873481821;
        Tue, 04 Aug 2026 12:58:01 -0700 (PDT)
X-Received: by 2002:a05:6a21:998c:b0:3c3:a20f:f720 with SMTP id adf61e73a8af0-3cb85fac059mr1216051637.36.1785873481275;
        Tue, 04 Aug 2026 12:58:01 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315867a68fdsm12316636eec.25.2026.08.04.12.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 12:58:00 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Subject: [PATCH 0/7] soc: qcom: geni: Derive SE clock configuration from
 OPP table on SA8255P
Date: Wed, 05 Aug 2026 01:27:38 +0530
Message-Id: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-0-61171ab1cdce@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADNEcmoC/yXNWwrCMBCF4a2UeTYQRyzqVkSGXCYaTZOQxCKU7
 t1oHz84nH+BysVzhcuwQOHZV59ix343gHmoeGfhbTegxFGe5FHYvp+ZTHhR5uKo6UCupGmTTZP
 ykVLO1JQOLNDhWdkDIo4K+mku7PznH7zeNte3frJpvwqs6xemGz+TkgAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785873474; l=3194;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=30qgLQKKCow2Vd7Rsipof0YfdQ8riHpCd1YMdGG0SCQ=;
 b=VyYJLSlovV+NAczF/pwSRV3VrbTS83eTlSfC8k2adZOrG/17by3IfQqdTpqt/2kbe0n9Iwwe6
 mwvMtxG43tmAquy+6z8OK9XeeZ4Qotp28tq/sM6GnkRHGkvbBnk30Wp
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-ORIG-GUID: _LWxOG3dH5UzE9WO5LSDD3IsDbRki29p
X-Authority-Analysis: v=2.4 cv=EvjiaycA c=1 sm=1 tr=0 ts=6a72444a cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=sUha4Zbooll43uZDtmUA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: _LWxOG3dH5UzE9WO5LSDD3IsDbRki29p
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE2MSBTYWx0ZWRfXxFgw+qDhPcBm
 Ou56KWT8XnaSTh8xm3X3Z3QcjtkF9N0IPhHEVzlDPw7NGM7aipSwXpsXEMLXifQjd/XbyFu7xg8
 +gvi2Drv2cC9b5mt3H4O5gn3pIfOc48=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE2MSBTYWx0ZWRfXzO2c2gjNm64v
 JC22ScclLmUrz/5Borc8/QNOceRjp7aOl0s5LqzcY2Val+8MrU1FGYK2kn97Tm+alBVK4yrfwvv
 6fvswRDN5ybcmO2s2Sm5bGwveyasTQtKDhpaagx7WWAcd+nWth9GcuXUozvJL4Jao5nP345duHb
 E7XAmC89ZGp3L7hng7PiM7FIUpO+tbzp6ouLZxanbHnlCtW0b9BRPFX0Oeiq94LsuVowoRqf8fY
 L4JXoweY+WiRCqwJ+pH9z9yenpncn8Rdf4esNGTv15aGbTcOpYR7arNcX7jfERXSpmyiThrPbeM
 PCN/aL5OJAJkKG2550dFUtKA2fWQrpjVwhDRpL8e4CGTxBkT2IAbUbq5IxzCCtYgQFyU3LcKg2z
 cBY3m/LW8fRJcno6rEj9ZMMvzoWeJzwEOMG1BDNeKa67R0/Dq6kHU0T/8/Qarli1h5Somrqjv/v
 aUxPK5oEm/HqezVbbwQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_05,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040161

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
Praveen Talari (7):
      pmdomain: arm: Fix -EINVAL from scmi_pd_set_perf_state() on state 0
      soc: qcom: geni-se: Populate clk_perf_tbl with SE source clock frequencies from perf OPP table
      soc: qcom: geni-se: Add helper to set SE clock rate via OPP
      serial: qcom-geni: Use geni_se_set_rate() for source clock configuration
      spi: qcom-geni: Use geni_se_set_rate() for setting source clock frequency
      i2c: qcom-geni: Use common GENI resource initialization helper
      i2c: qcom-geni: Use geni_se_set_rate() for setting source clock frequency

 drivers/i2c/busses/i2c-qcom-geni.c      | 45 +++++++++++-----------------
 drivers/pmdomain/arm/scmi_perf_domain.c |  2 +-
 drivers/soc/qcom/qcom-geni-se.c         | 53 ++++++++++++++++++++++++++++++++-
 drivers/spi/spi-geni-qcom.c             | 17 ++++-------
 drivers/tty/serial/qcom_geni_serial.c   | 19 ++++++------
 include/linux/soc/qcom/geni-se.h        |  2 ++
 6 files changed, 88 insertions(+), 50 deletions(-)
---
base-commit: 0f6da28aab51b16762ed82e8fdeaa5042da45b08
change-id: 20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-2f29ad32226a

Best regards,
--  
Praveen Talari <praveen.talari@oss.qualcomm.com>

