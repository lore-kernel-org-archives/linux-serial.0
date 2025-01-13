Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C4B4174A;
	Mon, 13 Jan 2025 03:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736738513; cv=none; b=a8Eh1PboYn/lNXziKfkmbzM4W/LjOcAHtuWDlgABkALlBIvfny+mesIz7mZwDEoHfq+3za9w9w0Ff0oSExEjgypY481tKJEEGOHS+8W5/8vpfcVeIKr9RZ8QmBk+GdUJ+w4sbxk50OVrg+bQTmyrY2oS0QLz2lYm2cxMxPIzcNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736738513; c=relaxed/simple;
	bh=JXmigsw5VdGaOjR9q5ZqKgCdE6l5XdMEjE18F8MpZIY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eqjmng9rySMSGRzOO628yOsLPWal2tgjZStHSXwqo1y+PgNWGoC2XZH900hjoEKTGre9eJ5/nHviwNiKZCACuyiYVpyl6YMPgGarokOY0Tw4Qi7vLRFfbwyPl3OrSVgW2nNVnEatI+FNdxMvdSGzvCobL/C/ACYK63E1QWJToWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 50D3JPTp015679;
	Mon, 13 Jan 2025 11:19:25 +0800 (+08)
	(envelope-from Wenhua.Lin@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx06.spreadtrum.com [10.0.1.11])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4YWcq52MYGz2PgVth;
	Mon, 13 Jan 2025 11:16:17 +0800 (CST)
Received: from zeshkernups01.spreadtrum.com (10.29.55.99) by
 shmbx06.spreadtrum.com (10.0.1.11) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 13 Jan 2025 11:19:22 +0800
From: Wenhua Lin <Wenhua.Lin@unisoc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby
	<jirislaby@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang
	<baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>, Cixi
 Geng <cixi.geng@linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <devicetree@vger.kernel.org>, wenhua lin
	<wenhua.lin1994@gmail.com>,
        Wenhua Lin <Wenhua.Lin@unisoc.com>,
        Xiongpeng Wu
	<xiongpeng.wu@unisoc.com>,
        Zhaochen Su <Zhaochen.Su@unisoc.com>,
        Zhirong Qiu
	<Zhirong.Qiu@unisoc.com>
Subject: [PATCH V2 0/2] serial: sprd: Modification of UNISOC Platform UART Driver
Date: Mon, 13 Jan 2025 11:19:15 +0800
Message-ID: <20250113031917.3354988-1-Wenhua.Lin@unisoc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 shmbx06.spreadtrum.com (10.0.1.11)
X-MAIL:SHSQR01.spreadtrum.com 50D3JPTp015679

In order to be compatible with UNISOC's new UART IP, the UART driver uses
private data for adaptation. Patch1 adds UART timeout interrupt BIT17, and
the old project uses BIT13. In order to be compatible with all projects,
private data is used for adaptation. Patch2 adds a new compatible string.

Change in V2:
-Change commit message in PATCH 2/2.
-Add a new items supports sc9832 compatible string in PATCH 2/2.

Wenhua Lin (2):
  dt-bindings: serial: Add a new compatible string for UMS9632
  serial: sprd: Add support for sc9632

 .../devicetree/bindings/serial/sprd-uart.yaml |  5 +++
 drivers/tty/serial/sprd_serial.c              | 41 ++++++++++++++++---
 2 files changed, 41 insertions(+), 5 deletions(-)

-- 
2.34.1
