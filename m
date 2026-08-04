Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0B64BC019
	for <linux-serial@vger.kernel.org>; Tue,  4 Aug 2026 19:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785873524; cv=none; b=QyzDm+lhEKMivxHcbMElHfEki4hGYERp/ovHpkaAIUn8pUKLcjNSuZlTIwNUSa09lGsxiuche3UczyzYi3okAg3riuZ2WJH9XvmcRrfFpBJuqpCP/XejH23x75VZM64AHnnmpK9N9R2g4c74t/Mmxq2IGqQsxmE37T1mpeD6Bjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785873524; c=relaxed/simple;
	bh=aMvXNSriPF/1rdXD7CryP6EsFDq+VBK2UfJSFjESgos=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ET1QqmwLEqSzXDV5K9G9/h5E3E+u+KX70F/4DPwxQ0Ai9cX62+FdAwz2pmgGMcx5NPb5GOJERDGTS2KfY8/hoJMorGykoTd3X315lIH+k70RCESqQFElYoINM2RtX70EGS+7YhPxl764NHfw5wh7zfRcw09ty+JXJrdANfeekLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SBu/S5ef; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fNEkrDe2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SBu/S5ef";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fNEkrDe2"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674JlMtN940010
	for <linux-serial@vger.kernel.org>; Tue, 4 Aug 2026 19:58:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9sG2kUOoNXTpFGVqjSx81RXjkZACMv2nCZdw/ToWaVY=; b=SBu/S5efX3MKEky9
	WUCMyIcbLHQ1Wxi4IPa9C5jVpH/2lN6Iscbef8UD0c+Ia6yT59SdXrh7vbPkmP9T
	3fI2wQOb7uL2WJKCfw+drjNd5kGSb9M9r7HMcHd1QvW3HLGy10nrD6TPsH7leCe0
	SDYt+HaUhMGUoBHzhUaVFJTaAfNq4ughIIDYw5Yd46iadEsGUqOHu1a80S0SrUUg
	dufvZedyUmj3NPBtBzbSBACwZIYP9ZtrozNMZraYSdmHXHwxzTmgFMEXV5Glz72h
	6X9EwVh6SHi787IYKSH+1YfqLM/tKH1C//O1CabqFKF6auI4BDvR14NxfKDxfaMr
	Alc1zw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fug65a3pu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Tue, 04 Aug 2026 19:58:37 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ccb6823efcso2131965ad.0
        for <linux-serial@vger.kernel.org>; Tue, 04 Aug 2026 12:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785873517; x=1786478317; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9sG2kUOoNXTpFGVqjSx81RXjkZACMv2nCZdw/ToWaVY=;
        b=fNEkrDe2PTtA9O9WnsfBFPO2xwQjcPRgZ0MhmMg3I/U0P6OBP4Ex1bl/HySMsUa2OT
         5KvPX8dH+kxMWIS42gJpu0KhdfKq7ZkV+5du5hts5UrBjG8FdiWYsZqfwGoVVPls+kmM
         m+0/X0GrHlluoE4+T8VxQStBJRY4iS7xem3JKoRdLClmORw8vVdWAuGRhiV4X1Vy1bzH
         3POFWrTDVfkKeU4L8tERt3MsEMmGl20nWB6luSw320mRmi9AJazkesyssjrNp3AQUyGM
         J2GGmiUlh4sA4fPfSiDXhRCrU1AaWKm5SJFEbfnyheTiZEbS9+Ih0u9HIQ2YIP9wT2lU
         M4hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785873517; x=1786478317;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9sG2kUOoNXTpFGVqjSx81RXjkZACMv2nCZdw/ToWaVY=;
        b=DQ0BTToPTbps7HDq1F7WMweTn9vqVbSmPW85cOjYI/MOyQxH9MPD4TWMUQtGPGnlzO
         Hj6LPhRtPGD0yDoAghO3bc19FqO5oGmLUQUSIZdXwQYWn6B8rkYtvFfsjg7r2TpocUXW
         vfbzTyDIMuv7ixDyUyIPLh+XZAKveEEOqOwtVHdXaCXV5xWPUwhWA0W6eEjGhMc5GEt/
         paI/aygSvGM/qv18BTKMMpC6Da/isB4Jbxp3tPbte6DavAkvR2c1fEbCU147Kc2zT5GJ
         4FyoALHhzfJ38MUuG2q8ZNAWU3Gv+GuIgYTXlvzyVhvZBSEOdxiKZY2UMonxURZMTylu
         DuLQ==
X-Forwarded-Encrypted: i=1; AHgh+RrMFip5MwO2uEZJbjz4hMYTLWZvm0LOENaxv4Ob/T9T0mJGwiyMX6mMzibkuflab9+iStOPMtM4YScUKUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqGkjwk3AwJX1XVQpQkJ4KTvH4VzuR3B9jg3DxDJHJw4srMayF
	OwHq/ggCwagqmgXl38y8WANYcPOhgBTmek5FTGluvAqxEBqUVyBtViBTC9vJZtg4CvgkT70FNTR
	ZHEwmS6ZR1WyvHDTm45nhbot5YzIXjiojze+s2O6FloDf/j487BoW/TllPGBGKIYrASE=
X-Gm-Gg: AR+sD1220PHlSRJt2OqqjbAjf38dpxa+W4+spJrBkhe173jy5ZfXTvRa8RldH+sAG4N
	0CplyMjrff9SblE7JjQ60uWmNfUt0yho6Z270CgreVkZINA0vuV9X+V+1n6TixxbsYqMaPBN2Xe
	rm+VUVbYouMrdIuXXEg0dz8W85Maxr5C7TQn0lR9u0dTo8bdpIm2btRKZlvBZiQ+SMkCZI5thk4
	DR3MF1G2IapxHMp9StolwGxI2+wek9u1aq3KI2Fr8RjrMXm1lXYQUEWVMTeiQQq9TjUDxYUalG/
	o001jDHffVNSM+ysz3cQtTttbykoHZ7JYBW9+bjXB6ZIjiPXPxa3hGVi5ybBJ6XKfPCxFK2ZPbJ
	+qANLuJPhXf8iTKAIIyDArcr26p8HG5ZRBQ==
X-Received: by 2002:a17:903:2392:b0:2d0:cc92:f7af with SMTP id d9443c01a7336-2d0cc930358mr8353785ad.9.1785873516948;
        Tue, 04 Aug 2026 12:58:36 -0700 (PDT)
X-Received: by 2002:a17:903:2392:b0:2d0:cc92:f7af with SMTP id d9443c01a7336-2d0cc930358mr8353295ad.9.1785873516378;
        Tue, 04 Aug 2026 12:58:36 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315867a68fdsm12316636eec.25.2026.08.04.12.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 12:58:36 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Wed, 05 Aug 2026 01:27:43 +0530
Subject: [PATCH 5/7] spi: qcom-geni: Use geni_se_set_rate() for setting
 source clock frequency
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-5-61171ab1cdce@oss.qualcomm.com>
References: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-0-61171ab1cdce@oss.qualcomm.com>
In-Reply-To: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-0-61171ab1cdce@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785873474; l=3943;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=aMvXNSriPF/1rdXD7CryP6EsFDq+VBK2UfJSFjESgos=;
 b=Z7l3NK4ZAErxpmh0xCxi1JAF+UNI5t63aPkBcxlmu10SL/ThlehBSe3n4zPL7NVW7nvmOlOSn
 6kRFgbHJBz6BLCo2NZ91JGbM8nXdnAJbYVOBu3A1vilb2cZqtF1ArL1
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-ORIG-GUID: _a4HjHjWKL9z9QM7XVznjgKvaazVJP-3
X-Authority-Analysis: v=2.4 cv=fcydDUQF c=1 sm=1 tr=0 ts=6a72446d cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=V8jFpX-JU2fdHFI84kkA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE2MSBTYWx0ZWRfX5gmeY/aw8cpe
 NMhKH+5kcQt+D2buONoRstxhROcxDP3NjfAZgNr+YH/FCxxS4X8yDmNREOQWJCmovRUzUP8OPpE
 LJUkhTmgXbWX1PjvEhu/1iypS1/eyKQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE2MSBTYWx0ZWRfX2Pa4vcxkrxwM
 P82i4JwQ6E0/qmVT3FxhQVeu/wv5fgNdGCcfMjp/Qnx1EJuBHRpXWAPTMriK8UuBTCorb65gS7n
 bFtAk19e7z/Vh75detnsOuk/5sJ3Ti0Suw2msign3lylVeI4jaBA8h5qq+259foNq0R+R5Q/xdZ
 xWVrMbsp5fJf0poVkmx8Ke4b2h4qvWlUaIDFuXhsRhAR2QZLTlS7WWTkT2Z4oiYEsNBLfMJL2UX
 rykcA+dyWWMkhpow23fkcusDU9i7jQY/N8F9lpF39dn6m4p2e8jTaMLPtYRk1ztiRbry1K7qBqO
 RLaRF5ZqhqTNzHCqu3HjoLxc5Kj7KOyJSWu82e0J8aZSmT/MMW9+7DyYrTWplp0YI4s2txOXE2/
 2LeT8rcXNDovwoyzQvjVTptWkTIjsMEj4zZKREot0JWnG/fKpardfX/W7e0mEJom6qZ4WVl+Sjs
 ioYDx70YnOt0RXJfUeQ==
X-Proofpoint-GUID: _a4HjHjWKL9z9QM7XVznjgKvaazVJP-3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_05,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0 adultscore=0
 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040161

On the SA8255P platform there is no Linux clock handler for the SE
source clock, so the driver has no way to look up the source clock
index and divider needed to fill the GSI CONFIG0 TRE for a requested
transfer frequency. To work around this, firmware instead exposes the
SE HW supported source clock frequencies as OPPs on the perf domain
device.

geni_se_domain_attach() now populates se->clk_perf_tbl from this OPP
table at attach time, mirroring clk_perf_tbl on the Linux-clock-managed
path. This lets get_spi_clk_cfg() call geni_se_clk_freq_match() to pick
the closest supported source clock frequency and divider on SA8255P
exactly as it already does when a Linux clock is present, and fill in
the GSI CONFIG0 TRE accordingly.

Switch get_spi_clk_cfg() and spi_geni_runtime_resume() from calling
dev_pm_opp_set_rate() directly to the new geni_se_set_rate() helper, so
the matched frequency is applied to the correct device (the perf
domain device on the firmware managed path, or se->dev otherwise)
without the SPI driver needing to know which resources_init variant is
in use.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/spi/spi-geni-qcom.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 6566975eb24f..09e796d22ab1 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -15,7 +15,6 @@
 #include <linux/log2.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
-#include <linux/pm_opp.h>
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
 #include <linux/soc/qcom/geni-se.h>
@@ -82,7 +81,6 @@
 
 struct geni_spi_desc {
 	int (*resources_init)(struct geni_se *se);
-	int (*set_rate)(struct geni_se *se, unsigned long clk_freq);
 	int (*power_on)(struct geni_se *se);
 	int (*power_off)(struct geni_se *se);
 };
@@ -150,9 +148,9 @@ static int get_spi_clk_cfg(unsigned int speed_hz,
 
 	dev_dbg(mas->dev, "req %u=>%u sclk %lu, idx %d, div %d\n", speed_hz,
 				actual_hz, sclk_freq, *clk_idx, *clk_div);
-	ret = dev_pm_opp_set_rate(mas->dev, sclk_freq);
+	ret = geni_se_set_rate(&mas->se, sclk_freq);
 	if (ret)
-		dev_err(mas->dev, "dev_pm_opp_set_rate failed %d\n", ret);
+		dev_err(mas->dev, "geni_se_set_rate failed %d\n", ret);
 	else
 		mas->cur_sclk_hz = sclk_freq;
 
@@ -847,7 +845,7 @@ static int setup_se_xfer(struct spi_transfer *xfer,
 	}
 
 	/* Speed and bits per word can be overridden per transfer */
-	ret = mas->dev_data->set_rate(&mas->se, xfer->speed_hz);
+	ret = geni_spi_set_clock_and_bw(&mas->se, xfer->speed_hz);
 	if (ret)
 		return ret;
 
@@ -1162,6 +1160,8 @@ static int __maybe_unused spi_geni_runtime_suspend(struct device *dev)
 	struct spi_controller *spi = dev_get_drvdata(dev);
 	struct spi_geni_master *mas = spi_controller_get_devdata(spi);
 
+	geni_se_set_rate(&mas->se, 0);
+
 	return mas->dev_data->power_off ?
 	       mas->dev_data->power_off(&mas->se) : 0;
 }
@@ -1178,10 +1178,7 @@ static int __maybe_unused spi_geni_runtime_resume(struct device *dev)
 			return ret;
 	}
 
-	if (mas->se.has_opp)
-		return dev_pm_opp_set_rate(mas->dev, mas->cur_sclk_hz);
-
-	return 0;
+	return geni_se_set_rate(&mas->se, mas->cur_sclk_hz);
 }
 
 static int __maybe_unused spi_geni_suspend(struct device *dev)
@@ -1224,14 +1221,12 @@ static const struct dev_pm_ops spi_geni_pm_ops = {
 
 static const struct geni_spi_desc geni_spi = {
 	.resources_init = geni_se_resources_init,
-	.set_rate = geni_spi_set_clock_and_bw,
 	.power_on = geni_se_resources_activate,
 	.power_off = geni_se_resources_deactivate,
 };
 
 static const struct geni_spi_desc sa8255p_geni_spi = {
 	.resources_init = geni_se_domain_attach,
-	.set_rate = geni_se_set_perf_opp,
 };
 
 static const struct of_device_id spi_geni_dt_match[] = {

-- 
2.34.1

