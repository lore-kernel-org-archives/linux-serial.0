Received: from mx0b-00622301.pphosted.com (mx0b-00622301.pphosted.com [205.220.175.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F94640B107;
	Thu, 30 Jul 2026 11:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.175.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785409595; cv=none; b=P+mki8tIH4/TOzUJM/ZzkIjPdfo1jyO5bA9zOs3NEi3rn8g0vb39HeEiqdqtykzZ7zkqqTwlj8rx8IPDv6c53m1t7cgLvvQLqA/jMjUZDe+SZwuQpIj5SPC2SbR5l8YFnY7bAsoWvxdssrsprCufcZYa6btGJ8pnAndvZAXQSeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785409595; c=relaxed/simple;
	bh=pW1wsTHfzaJ3ZuKTMi2aAPgF75ZYqVrMek85YTomY2A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WXSC5KxL48TM0jhIDRu4F7Tk39LS7151H7mgQzA0pKByoJlkxb40DNY5bqhLyBTy+xseFNsTqbHx9dLCX3HUkrA1XUgTOanV0qeoFO+B37jA2krIISt9B4H2+tWuQa2Ze/Ab1CXWmqQbO6pE39urbMIAT3Fk5y7WmmugoShlM/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ambarella.com; spf=pass smtp.mailfrom=ambarella.com; dkim=pass (2048-bit key) header.d=ambarella.com header.i=@ambarella.com header.b=t4pLsid7; arc=none smtp.client-ip=205.220.175.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ambarella.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ambarella.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ambarella.com header.i=@ambarella.com header.b="t4pLsid7"
Received: from pps.filterd (m0241925.ppops.net [127.0.0.1])
	by mx0a-00622301.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UA4EdH3329173;
	Thu, 30 Jul 2026 10:43:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	com20210415pp; bh=u6nUw4Rgp4SzWkDJhOSewVZkF8EbLS8yovpiTKWdT0A=; b=
	t4pLsid7Fv2ujKLokdOgAmKrhDs/kvjN8X+MvyQUW3pRpgpm6OgWL3I0Pos0CnhS
	Mj51p6bwtH8KgoZAJ+pQv9iU/0Nxmdbhb4xcUXrk6t8c1d0hfMPTFjJ8HlicYuJp
	rFYG99kiHdDswQaf0IWPCNobjly51qhA+xowYboTbkbrc3835n2GisIUScnWTDeE
	s6PldToMK8B43rfkOEmxNMxatVHe+fbv9VrqP/J4dQ8G1HPTGTCgGzjJ/yMwuj9+
	qfAv8F1zFXEh3+x4H4tB1Iva8965JGE+3DqRXi0rvbifUpsNLpKIM8KRPqXH9nIH
	pG2IjJD0/v1d7Sx7Dpbz6g==
Received: from webmail.ambarella.com ([12.30.244.130])
	by mx0a-00622301.pphosted.com (PPS) with ESMTPS id 4fq8twhnbg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 10:43:55 +0000 (GMT)
Received: from ambtw-ex-se1.ambarella.net (10.2.5.164) by
 ambus-ex-se1.ambarella.net (10.1.4.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 03:43:54 -0700
Received: from ambtw-cas3.ambarella.net (10.2.4.228) by
 ambtw-ex-se1.ambarella.net (10.2.5.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 03:43:52 -0700
Received: from shbuild7.ambarella.net (10.4.8.70) by ambtw-cas3.ambarella.net
 (10.2.4.228) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Thu, 30 Jul 2026 18:43:51 +0800
From: Long Zhao <longzhao@ambarella.com>
To: Arnd Bergmann <arnd@arndb.de>,
        Alexandre Belloni
	<alexandre.belloni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>, <soc@lists.linux.dev>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        "Michael
 Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, <linux-clk@vger.kernel.org>,
        Linus Walleij <linusw@kernel.org>, <linux-gpio@vger.kernel.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, <linux-serial@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, <linux-kernel@vger.kernel.org>,
        Long Zhao
	<longzhao@ambarella.com>
Subject: [PATCH 10/10] MAINTAINERS: add ARM/AMBARELLA SoC support
Date: Thu, 30 Jul 2026 18:43:30 +0800
Message-ID: <20260730104330.81367-11-longzhao@ambarella.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260730104330.81367-1-longzhao@ambarella.com>
References: <20260730104330.81367-1-longzhao@ambarella.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Proofpoint-GUID: 2E2TaZ-ORL0hTrjqU4cm_1acAjU-gkov
X-Proofpoint-ORIG-GUID: 2E2TaZ-ORL0hTrjqU4cm_1acAjU-gkov
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA4MCBTYWx0ZWRfX3sXvoiWGXpDQ
 r9So4QzNBDic2o8KmHfTFnZ4XrkWUKt1vJrU3YqdSKt1ZH4eHELSztT3WANBwDaeOaWMJ2XScSR
 DpzzohoOg9TBCxftkhCTFqB74hU/vm/oZ7sgheCYPG7OdooP8gx+kfpgMK37KHUUoeZGKJsONVd
 h/ABMMvin06Cw/4Z6h4Ee5PKykZmFrq+SYKAYsQXeMG78SE/4BB0B1hDprZpHYyAYY1n216mxqy
 YmzbeKSNFCGBiBj3oqsXZsV4PL5w4rruL2dE8f5178i4/0uJ6nFKxmQ/9I/w70qzgGh7SPCCqfF
 HCH0tT3sJGuq5Dyxa9rDz7yYmRXlbCuovCC9uFtHIwUP3Iy0+XtbEv/Mm5aniATl3ZN1qIBhRRg
 Rk67dLSKV5q56nfMWsHMoykGbM1IBw3PlaKZzm0IOPKuIDIbarfMtUfRM/5j+ST65X5rB4BON5u
 CBkmnjq/SZckrYQhdGQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA4MCBTYWx0ZWRfX2Pf9ohZk9wey
 FxdnnqGB+var+2/5c72ouY2wudMRn9l4VQbXmPp+J0+LVLYIgRvrZxHTnJ9ESEaGBh94gHw6sDK
 ozcqWfWXksCT9o+EtmBQUI+sJkQP1y89RAhyudbu8GFYJdWMZiRH
X-Authority-Analysis: v=2.4 cv=PNE/P/qC c=1 sm=1 tr=0 ts=6a6b2aeb cx=c_pps
 a=DgnZYc2JwZ3KnY28M5UqXQ==:117 a=DgnZYc2JwZ3KnY28M5UqXQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yXVIz-0bn9infC194UBj:22
 a=KblO7da7ppA7TBl3N-nE:22 a=ppJngBeKAAAA:8 a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8
 a=zd2uoN0lAAAA:8 a=6h8Q0ANTdPAEg-4E5kYA:9 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_03,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 malwarescore=0 clxscore=1015
 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300080

Add a maintainer entry covering Ambarella CV75 bindings, drivers
and device trees.

Signed-off-by: Long Zhao <longzhao@ambarella.com>
---
 MAINTAINERS | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 803b60ad628f..34c0ac2e00b9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2502,6 +2502,24 @@ F:       drivers/clocksource/asm9260_timer.c
 F:     drivers/rtc/rtc-asm9260.c
 F:     drivers/watchdog/asm9260_wdt.c

+ARM/AMBARELLA SOC SUPPORT
+M:     Long Zhao <longzhao@ambarella.com>
+L:     linux-arm-kernel@lists.infradead.org (moderated for non-subscribers=
)
+L:     devicetree@vger.kernel.org
+S:     Maintained
+F:     Documentation/devicetree/bindings/arm/ambarella.yaml
+F:     Documentation/devicetree/bindings/clock/ambarella,cv75-rct.yaml
+F:     Documentation/devicetree/bindings/pinctrl/ambarella,cv75-pinctrl.ya=
ml
+F:     Documentation/devicetree/bindings/serial/ambarella,uart.yaml
+F:     Documentation/devicetree/bindings/soc/ambarella/
+F:     arch/arm64/boot/dts/ambarella/
+F:     drivers/clk/ambarella/
+F:     drivers/pinctrl/pinctrl-ambarella.c
+F:     drivers/tty/serial/ambarella_uart.c
+F:     include/dt-bindings/clock/ambarella,cv75-clock.h
+F:     include/dt-bindings/pinctrl/ambarella,pinctrl.h
+N:     ambarella
+
 ARM/AMD PENSANDO ARM64 ARCHITECTURE
 M:     Brad Larson <blarson@amd.com>
 L:     linux-arm-kernel@lists.infradead.org (moderated for non-subscribers=
)
--
2.34.1

NOTE: This email (including attachments) contain Ambarella Proprietary and/=
or Confidential Information and is intended solely for the use of the indiv=
idual(s) to whom it is addressed. Any unauthorized review, use, disclosure,=
 distribute, copy, or print is prohibited. If you are not an intended recip=
ient, please contact the sender by reply email and destroy all copies of th=
e original message. Thank you.
