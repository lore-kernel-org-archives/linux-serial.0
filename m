Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E862632;
	Mon, 13 Jan 2025 03:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736738518; cv=none; b=G9zRNU/H7QCn3FiOle1x4Zy3vMg+gPK640HUN+SSV2hu+NBt43idr3qONYUwW87PNDb/7D42Oy/7J57nRYiOyDUmw7IblDL2Ohien2wtIMwDbCJBWTfDcO29wXsLXgnwbsOan9/EWkeb8AUDOoQFzKnnKLyaSDvmLKmLfIt2bEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736738518; c=relaxed/simple;
	bh=Y3nE2lzDIpMp5PBFKP/A9qmSHTy0qU3sj01um7Vbing=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FAqZYHFv+vyLr0rR5oURj8ckohm8gKE5SwGISSOc6BJoJrFaNNptAP8DXzl9+PjhctJO3dSjJtByCdDRrpac+4UFgzAvYwrxE+9ga9Mnt2fAtp7bCLo4Ug0lYpyqR+Pg/pjJLFV3GzfK2yhGs12mrJopWX6jotv0m6eZO1xT9Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 50D3JPbH015683;
	Mon, 13 Jan 2025 11:19:25 +0800 (+08)
	(envelope-from Wenhua.Lin@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx06.spreadtrum.com [10.0.1.11])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4YWcq56gzgz2PgVtk;
	Mon, 13 Jan 2025 11:16:17 +0800 (CST)
Received: from zeshkernups01.spreadtrum.com (10.29.55.99) by
 shmbx06.spreadtrum.com (10.0.1.11) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 13 Jan 2025 11:19:23 +0800
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
Subject: [PATCH V2 1/2] dt-bindings: serial: Add a new compatible string for UMS9632
Date: Mon, 13 Jan 2025 11:19:16 +0800
Message-ID: <20250113031917.3354988-2-Wenhua.Lin@unisoc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250113031917.3354988-1-Wenhua.Lin@unisoc.com>
References: <20250113031917.3354988-1-Wenhua.Lin@unisoc.com>
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
X-MAIL:SHSQR01.spreadtrum.com 50D3JPbH015683

The UMS9632 uses the SC9632 serial device.

Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
---
 Documentation/devicetree/bindings/serial/sprd-uart.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/sprd-uart.yaml b/Documentation/devicetree/bindings/serial/sprd-uart.yaml
index f4dbb6dc2b6e..83582aa6c750 100644
--- a/Documentation/devicetree/bindings/serial/sprd-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/sprd-uart.yaml
@@ -23,6 +23,11 @@ properties:
               - sprd,ums9620-uart
           - const: sprd,sc9836-uart
       - const: sprd,sc9836-uart
+      - items:
+          - enum:
+              - sprd,ums9632-uart
+          - const: sprd,sc9632-uart
+      - const: sprd,sc9632-uart
 
   reg:
     maxItems: 1
-- 
2.34.1

