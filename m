Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926FB302740;
	Fri, 22 Aug 2025 13:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755870060; cv=none; b=WEYplaLOqnx5ecNBmXrlnOXBXd7hvKbSf4Iws8N/399OT/WaS67/FiGh7SgTVBRfkDCnJecfckjyErUtDh/OK6GL2JKTYfxAWTQC5xCB7G4F9u3YeUPHyrfOD+bUqcHzlIY6Bnoc4k93LBB6jlLuBPWuVBhWsJ6jri6MHbgv9So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755870060; c=relaxed/simple;
	bh=knZJdMiORCIjH9vmjRbIRCBgi6/8/09MXJyhowg5A2A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CAX6qFVwABzBnT7Squa+pn7eNEVHXK0k4hlXw4aQm3OJgMuZjh0cFpe78LDHmfQB1Jc12DlCIddfki0uhdWSa1i9M0IspfLQ20qZlHH7dL9GIhu3ejO3oR8vr02Jxk8kbyO08FtUU4JlUnX1DGJVmhaMg7jttWVAoIsVzLg1XT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=0FCSqdzE; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="0FCSqdzE"
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57MDPiDh019515;
	Fri, 22 Aug 2025 15:40:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=6vCtagcKIf7omy0DiO+Aki
	o9Ivyo52kmDNtQdAOWyUY=; b=0FCSqdzElRtGxvCy5qXTSkrsazIcNOJvFl7CXT
	jJeMTOSiAbalAGOwxbGNOQr75Ze+yF/5A+Rao0SIiF00ADL9AJXLqCQTMR23Wllv
	0xPceot/LLB1rfxtLz1YOlwufYzU5QeKHfjWGW0yDNlpMzm/iPsfhMKZUnla1b6W
	9vfsYBVu58KYFe0vyx3OlnfVoIWZsPBhRYlFZKWylfBQeMt9yYkfvylOIc/TZGLw
	GZrQe0KuZk+L1gUkSHdbdRtSp0yIUB3l3RIHGQ7ThouB4OWmWxeLwkfG2Jz+5tRi
	Nvvcg3uFf7RUuGcXmuqCx+r0G3wXUC5H+Rg1ec38AaVD+Z1Q==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48n754ka8s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 15:40:29 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 8A7E040046;
	Fri, 22 Aug 2025 15:38:56 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 20A0770F88C;
	Fri, 22 Aug 2025 15:37:56 +0200 (CEST)
Received: from localhost (10.130.74.180) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 15:37:55 +0200
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby
	<jirislaby@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Douglas Anderson <dianders@chromium.org>,
        Zong Jiang
	<quic_zongjian@quicinc.com>,
        Robert Marko <robert.marko@sartura.hr>,
        "Thierry
 Bultel" <thierry.bultel.yh@bp.renesas.com>,
        Raphael Gallais-Pou
	<raphael.gallais-pou@foss.st.com>,
        Kartik Rajput <kkartik@nvidia.com>,
        "Peter
 Hurley" <peter@hurleysoftware.com>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Vladimir Zapolskiy
	<vladimir_zapolskiy@mentor.com>,
        Antonio Borneo <antonio.borneo@foss.st.com>
CC: <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>
Subject: [PATCH] serial: stm32: allow selecting console when the driver is module
Date: Fri, 22 Aug 2025 15:37:53 +0200
Message-ID: <20250822133753.54300-1-raphael.gallais-pou@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01

Console can be enabled on the UART compile as module.
Change dependency to allow console mode when the driver is built as module.

Fixes: 48a6092fb41fa ("serial: stm32-usart: Add STM32 USART Driver")
Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
---
 drivers/tty/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index e661f5951f558..1e27a822c1cba 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1420,7 +1420,7 @@ config SERIAL_STM32
 
 config SERIAL_STM32_CONSOLE
 	bool "Support for console on STM32"
-	depends on SERIAL_STM32=y
+	depends on SERIAL_STM32
 	select SERIAL_CORE_CONSOLE
 	select SERIAL_EARLYCON
 
-- 
2.25.1

