Received: from mail-m3273.qiye.163.com (mail-m3273.qiye.163.com [220.197.32.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208B622CBDC;
	Thu, 27 Feb 2025 11:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740655178; cv=none; b=iH7newMd/3zPDaVntQ2osu+ZUuYPFmzIrEYuX2HsoxS5+SFgWrYxpe2cIWewVRGtQV7lVYeiluoaDXSlMJfCDs6heK2Z8wY6BmvGppBhps0XY/6n/34VJSZ6bk2inNV2GDOYYywE6B44YkBc5aJnDD/g++2EltMH20l8Q68y6dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740655178; c=relaxed/simple;
	bh=d/WDbLLQaQ+fswImLXyZpHPlFeCfYZDhOHYM3Ifa5+A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CCimRUb6rllBijtdtEnTE9VouVS3MLfjj0WMYZFApQG2uLnWdFHK9QY6lDmQ/wGJb7O6d1fwOgAiacC7UVMYNoEcISV826LnBFGOgFXl4NT2WJKPRPbUBfOn+lgTZKEjXRRKn0/Yiq8lB5rvoUyXD31h+28Og0SRFKRq1VU8h+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=jwLz3DjP; arc=none smtp.client-ip=220.197.32.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="jwLz3DjP"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id c65f97e3;
	Thu, 27 Feb 2025 19:19:32 +0800 (GMT+08:00)
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
Subject: [PATCH v3 08/15] dt-bindings: serial: snps-dw-apb-uart: Add support for rk3562
Date: Thu, 27 Feb 2025 19:19:06 +0800
Message-Id: <20250227111913.2344207-9-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250227111913.2344207-1-kever.yang@rock-chips.com>
References: <20250227111913.2344207-1-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR0eTVZPQx8fGUtPSx1NGUlWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9547221bef03afkunmc65f97e3
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PT46Ayo4EzIJNw0TKENRHkJI
	VhgKCh9VSlVKTE9LTU5OSkxIQkpDVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKS0NPNwY+
DKIM-Signature:a=rsa-sha256;
	b=jwLz3DjPvTEj5JXyro5xpmO0HlmZp6R6gdo3em7Sg39uALNEAx1FvscoIiIsvzY/W/KCVVbXis7q66EMFpRskMmLJFRn9UrGUkrEqUTez5xpScpU4d5LYR7i/vqiL3v2dKnQSp+ejL5dvgxnfuRrluGtecCLa1+FURpJ4oShZik=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=jmSlRRHgiKaCPjF9zIpxCVTtDRNDshAA457xOf536FU=;
	h=date:mime-version:subject:message-id:from;

The UART core on Rockchip's RK3562 is the same as the one already
included in generic dw-apb-uart. Extend the binding accordingly to allow

	compatible = "rockchip,rk3562-uart", "snps,dw-apb-uart";

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

Changes in v3:
- Update the commit message

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

