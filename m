Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2F02C2592
	for <linux-serial@vger.kernel.org>; Tue, 29 Apr 2025 12:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745928403; cv=none; b=mXjU89plM5uhC1TOdkxPG68kpU8sIH8s1rPtr211Kae/GqHoqJtSg19UeLLAYKscWuNT452Vb0U4s1l2C92dM/swkO2ZuHu6J/mMWMARgOzFZsKFyqwPLZ2UF0UZtp668PpQQjiLPKPcIAeNTQFWLOpe2CcoCf7/73Bs3nbz6ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745928403; c=relaxed/simple;
	bh=u6IGIBto1xpKcUHgEQL32+myYLIW4UGqnHyagSe7Bwk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=UZKUl4fYPpAh6VG0OJRD39RGnj13nrvP5eeozBFhCwJZaHrUvG1fN0CgYNHGCHI4Zpwhi7huwJ6Ba0N9WLH9t/Wj9A+woNcnmNQsEcchFgcLCrj9YoVlS8is3U6UjIMZrPj2c3q9n16hQy7cuH8L9cuiQS5+zvkmTv78GfJBKzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=F6A3lSBe; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="F6A3lSBe"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250429120639epoutp03aa682691006c2344865d9514104f211e~6yKD4vVAl0986209862epoutp03G
	for <linux-serial@vger.kernel.org>; Tue, 29 Apr 2025 12:06:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250429120639epoutp03aa682691006c2344865d9514104f211e~6yKD4vVAl0986209862epoutp03G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1745928399;
	bh=RSyKLRIDfZUqc02NXZVKLH+houRYwWh9aD2SxU7TZ8U=;
	h=From:To:Cc:Subject:Date:References:From;
	b=F6A3lSBe+gvEoieXDYc6jNW2TaNH7akSKj28hu5OkpvieEDc6N1UkDuQyQWBoGKCJ
	 JxFaa6gqRAJhUTeFtyp1lWuuB2fzcSGfXefjxjY3nyKzHeRSYeao2LpqD/IpCm9z+6
	 Qd1zsV+ejKla4KuHgtVTSpZt7kG1LZs4ZVk+4FIg=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250429120638epcas5p4b8f04554cb03b9b4817cea66fb3076ee~6yKDF0dl22706927069epcas5p4M;
	Tue, 29 Apr 2025 12:06:38 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.174]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4ZmzZ42tHlz6B9m9; Tue, 29 Apr
	2025 12:06:36 +0000 (GMT)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250429101953epcas5p4604a6bd79548ebc29e1c72bdc64965a4~6ws2Qmttv0416804168epcas5p4f;
	Tue, 29 Apr 2025 10:19:53 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250429101953epsmtrp219cade6a3671e0473c443dd011e5dbab~6ws2PtFAG0222002220epsmtrp2q;
	Tue, 29 Apr 2025 10:19:53 +0000 (GMT)
X-AuditID: b6c32a28-460ee70000001e8a-d6-6810a7c9d902
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	0D.23.07818.9C7A0186; Tue, 29 Apr 2025 19:19:53 +0900 (KST)
Received: from bose.samsungds.net (unknown [107.108.83.9]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250429101951epsmtip16df3344d040194e5d7b75e331b376fdf~6ws0p8Gx50829508295epsmtip1s;
	Tue, 29 Apr 2025 10:19:51 +0000 (GMT)
From: Faraz Ata <faraz.ata@samsung.com>
To: alim.akhtar@samsung.com, krzk@kernel.org, gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	dev.tailor@samsung.com, rosa.pila@samsung.com, faraz.ata@samsung.com
Subject: [PATCH v4] tty: serial: samsung_tty: support 18 uart ports
Date: Tue, 29 Apr 2025 15:59:41 +0530
Message-Id: <20250429102941.4138463-1-faraz.ata@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrILMWRmVeSWpSXmKPExsWy7bCSnO7J5QIZBjueq1g8mLeNzeLejmXs
	FtduLGS3aF68ns3i3VwZi/PnN7BbbHp8jdXi8q45bBYzzu9jsjizuJfd4svPB8wO3B6bVnWy
	eeyfu4bdY/OSeo++LasYPT5vkgtgjeKySUnNySxLLdK3S+DK+D6nk61gNXfFt8MPWRsYv3N2
	MXJySAiYSDzp+c7SxcjFISSwm1Hi3r817BAJSYnDT++yQtjCEiv/PWeHKHrLKPFz8zKwIjYB
	dYmZN44AdXNwiAikSOy/ywRSwyxwk1Fia+tSsBphAWeJVQ8/MoLYLAKqEr+62phBbF4BG4md
	U6YwQyyQl9h/8CxUXFDi5MwnLCA2M1C8eets5gmMfLOQpGYhSS1gZFrFKJlaUJybnptsWGCY
	l1quV5yYW1yal66XnJ+7iREcyloaOxjffWvSP8TIxMF4iFGCg1lJhLfKgD9DiDclsbIqtSg/
	vqg0J7X4EKM0B4uSOO9Kw4h0IYH0xJLU7NTUgtQimCwTB6dUA5PR+oOX0lM+375caTVp0Rz3
	e59+fXd/kTXx27ziXXHZ0SuPdf27n3UhcfPXl6z7Z36L+z3765+WBHF/64bEm/f87vQ9Mniq
	sWK/4Y1lGXpdj+VDXizNafzHanvRf+HBWfk3nnzmulf4Op3r0D873xWHPJo3u+Z8aPy1gvep
	YSvvlE0LMg3/VldMs2RzD5DUzSpUE5HKZvntLmDlx7NYJW2Rqs6TG9EN/I2rzhk6ex350pyR
	WPsjbL7joe3qjVwWXlPvW5534vOYZjfnh3ut1Fmr0mcbux/9Eop5o7hh6q2Xi33ddl5cFzhp
	bXT7nvj5ch6cybOnH7iZf0vh+selEb0rub7e5F3/YFG197PASfv+KrEUZyQaajEXFScCACeH
	nVHUAgAA
X-CMS-MailID: 20250429101953epcas5p4604a6bd79548ebc29e1c72bdc64965a4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250429101953epcas5p4604a6bd79548ebc29e1c72bdc64965a4
References: <CGME20250429101953epcas5p4604a6bd79548ebc29e1c72bdc64965a4@epcas5p4.samsung.com>

ExynosAutov920 SoC supports 18 UART ports, update
the value of UART_NR to accommodate the same.

Signed-off-by: Faraz Ata <faraz.ata@samsung.com>
---
Changes in v4:
- Updated v3 change-log as discussed with Greg[2]
- The patch itself remains unchanged, only the change logs have been updated.
- Link to v3: https://patchwork.kernel.org/project/linux-arm-kernel/patch/20250417043427.1205626-1-faraz.ata@samsung.com/
- Reference: [2] https://lore.kernel.org/linux-samsung-soc/2025042829-heroics-deskwork-e74d@gregkh/

Changes in v3:
- Added changes-log (as pointed by Krzysztof[1]
- Link to v2: https://patchwork.kernel.org/project/linux-samsung-soc/patch/20250404135006.1263827-1-faraz.ata@samsung.com/
- Reference: [1] https://lore.kernel.org/linux-samsung-soc/03cc01dbaaaa$4dea13f0$e9be3bd0$@samsung.com/

Changes in v2:
- Rebased on the latest linux-next and added reviewers as per get_maintainer.
- Link to v1: https://patchwork.kernel.org/project/linux-samsung-soc/patch/20250312061932.1797993-1-faraz.ata@samsung.com/

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 210fff7164c1..9a5211b730fb 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -52,7 +52,7 @@
 #define S3C24XX_SERIAL_MINOR	64
 
 #ifdef CONFIG_ARM64
-#define UART_NR			12
+#define UART_NR			18
 #else
 #define UART_NR			CONFIG_SERIAL_SAMSUNG_UARTS
 #endif
-- 
2.34.1

