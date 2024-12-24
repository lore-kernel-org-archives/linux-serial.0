Received: from mail-m32122.qiye.163.com (mail-m32122.qiye.163.com [220.197.32.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37511B0F15;
	Tue, 24 Dec 2024 10:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735034699; cv=none; b=p7GsaPlrwJp8yce0iPsuhTxmEE+1KmU+3KfKx9jLCfw2wbX3zkfxwb+Wg00tKAXWM8eerqpzLd5MimQf9i1ONLfmuDPYFuvYD8COs4zQepnVdDO01jLmik1GxVBVoedu+JzxAlxwkAJvsj1yMSiOkFUxCM8Wjqkz19h8TU+bKB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735034699; c=relaxed/simple;
	bh=w1sYguIT9Fej9Y7r2rAQOrte9SJwK4CiC+goidounq4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nIP+3MvAK7bmUEBbaw03ZJ4/idiYNyfso7lZeLTDmMFA/RKvgmpTu7RPF08L7XB8hg8+lyB3iJrJIZ32+q//gE9WGEtpaD58wo9iZuHdsj5fWTQFSqnk4j5vBh/IKErAy/Nr/Izssf4YubdyhTM8iurjnNc/+Pgs+byrpAENR+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=PaW1ZunR; arc=none smtp.client-ip=220.197.32.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="PaW1ZunR"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 6aad4f50;
	Tue, 24 Dec 2024 17:49:36 +0800 (GMT+08:00)
From: Kever Yang <kever.yang@rock-chips.com>
To: heiko@sntech.de
Cc: linux-rockchip@lists.infradead.org,
	Kever Yang <kever.yang@rock-chips.com>,
	devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-serial@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v2 09/17] dt-bindings: serial: snps-dw-apb-uart: Add support for rk3562
Date: Tue, 24 Dec 2024 17:49:12 +0800
Message-Id: <20241224094920.3821861-10-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241224094920.3821861-1-kever.yang@rock-chips.com>
References: <20241224094920.3821861-1-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGktJS1ZCSkhCHk4ZTR5DT05WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a93f81269ea03afkunm6aad4f50
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nyo6ORw6DTIQPkoXS0s3LChM
	HxQKCihVSlVKTEhOS0hITExMTEJLVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFDQ083Bg++
DKIM-Signature:a=rsa-sha256;
	b=PaW1ZunRuKqrq2MEcyGvF1ID608tmpEBs1Ro/ydVWnjvr7HLMMz1O26g0VS1hqqnDc5P4TWf9gDt2Imm5nODPfT5p9LW1pKRKpA++M8yZHQFJBP84ZqWggVGGDH36hTeQ4RextZmgpNyVvv9ues5FURWMFR2LqgxBr9dBwve9+E=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=LL/r0W7SCVHJRGGyzbWqtnf2sNnv53u7nqfOYyaOwaI=;
	h=date:mime-version:subject:message-id:from;

Add rockchip,rk3562-uart compitable for rk3562.

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

Changes in v2: None

 Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
index 1c163cb5dff1..1c16ca3b4e29 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
@@ -51,6 +51,7 @@ properties:
               - rockchip,rk3368-uart
               - rockchip,rk3399-uart
               - rockchip,rk3528-uart
+              - rockchip,rk3562-uart
               - rockchip,rk3568-uart
               - rockchip,rk3576-uart
               - rockchip,rk3588-uart
-- 
2.25.1

