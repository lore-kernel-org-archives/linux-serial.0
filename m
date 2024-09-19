Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F79160B8A;
	Thu, 19 Sep 2024 11:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726744580; cv=none; b=koAp70O2H5DvnKNPmaaW2uubNwpMNlGwqiXalh0g4TMAgqXEkkmcxj3pmQ2gGJ1cA76lznw4HneTIVIFtWdLG+4cvnDIVNLxgb1eQb09Z/bF+xtKOWVDCZYgBKiH73AyEG3gKejIiCcHNSmxBvIqqgM2kt9brABjSz0kigtO0eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726744580; c=relaxed/simple;
	bh=UmoDr/xmw7bQwLekV6ZmfkNAHoR/KISj6JJS3ym8Fyc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O88GQ0VlQzmwVdBcHEcjGzsep+c0QicKR/NtPuMNsFL0izvEQ6cBAZQFnpjj0/O5qOd45rNY62g/MwN9ZS+pgBFvlsHGs+8nyc5CaWZu6RWijdbnFu3XRM4UrHsZmqiRlNrHZdpvZ+UtYDfKALZZmsVcCZCNV+t266zfP36a/10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=GdCdQAQO; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="GdCdQAQO"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 512FE23D96;
	Thu, 19 Sep 2024 13:16:15 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kBAsstS7blCN; Thu, 19 Sep 2024 13:16:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1726744574; bh=UmoDr/xmw7bQwLekV6ZmfkNAHoR/KISj6JJS3ym8Fyc=;
	h=From:To:Cc:Subject:Date;
	b=GdCdQAQOv3kePcFUZ7Lg5cS8YSTtrKasA4Ws2zmaw8RijVGQ82qND1wspjQw+KLts
	 btNnqz8+PPXq6Lev2X+oEj81iVbPKm+hxC8cz3CuYpFtgUEJLitEB4kuerv+LU5je9
	 vU4AeTdFeJe3ppff8WG0FhI9V6BUYI8N/obYhn5I8pBwdTrkigtUr+8nxA4OXhKrqA
	 jwJ/51Dx82dysGAIzcCBCFqFDGw+T3kO10uZ+6UakJRBC/+F+d0S+AqD745qG0DY5U
	 lMz4i/lgUnCRlZF+TLHtcW5eOX85l3Q6g2TuT+uTQ+Z4kUy/5zsetEx/AqzLGn6VhG
	 78rg9pEq20ruA==
From: Yao Zi <ziyao@disroot.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	Yao Zi <ziyao@disroot.org>
Subject: [RESEND PATCH v4 0/1] dt-bindings: serial: snps-dw-apb-uart: Document Rockchip RK3528
Date: Thu, 19 Sep 2024 11:14:14 +0000
Message-ID: <20240919111413.45413-3-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rockchip RK3528 comes with snps,dw-apb-uart compatible UARTs, document
it in dt-bindings.

This is actually part of series
https://lore.kernel.org/all/20240829092705.6241-1-ziyao@disroot.org/
Thanks for your time and review.

Yao Zi (1):
  dt-bindings: serial: snps-dw-apb-uart: Document Rockchip RK3528

 Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 1 +
 1 file changed, 1 insertion(+)

-- 
2.46.0

