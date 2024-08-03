Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD1014EC52;
	Sat,  3 Aug 2024 12:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722689796; cv=none; b=izp9Jp8b5rH2VeB7sy37gfPi8BkQaXRFQ7D3deG9KhS2vQlGuROVZPQe4Ety6KhhrUAK3AyRh4PeIvuIt77koZw5JoQp/od9ePpBgS3IZctBOUmewW7pxGcvaEwJRp4qbb/9wIyIPGkrOztiP3hMMw3UVgCEVTd6H+ucRwQqSrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722689796; c=relaxed/simple;
	bh=DQf1sqtkhnnoEtaNtUfawANX30n8YC0bJL8j07Mx9wA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SIehT0MIWQEJnpGuDRiAQCWLKPZyWDhWwIWn/G+r0BrKLEjC+fdtp6xj+4VUeCc3DBRO98G6To4oGONQ9Z0SM/qgOyw5MnudWqa751oXerVoENd1od8cOx85xgjCmbm+/KwFaDuvKhvbmOD3vo4OLQNPitkkblEOlKfhS3ZYVTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=b8eIk+gi; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="b8eIk+gi"
Received: from localhost (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 514F441A0D;
	Sat,  3 Aug 2024 14:56:33 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
	by localhost (disroot.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jzr0saSDU6r1; Sat,  3 Aug 2024 14:56:32 +0200 (CEST)
From: Yao Zi <ziyao@disroot.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1722689792; bh=DQf1sqtkhnnoEtaNtUfawANX30n8YC0bJL8j07Mx9wA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b8eIk+giDW7iuJoEBFdOPHS4cttQ2Sguj2rkjXFo4KxTRq9PqpkWUkfowqiz1mAAm
	 MsL2WMBemvXDOs3JfnsZXdIVIgo5dffGmASBwUEWAS5RceJJz2d6BeKuzpZCStJM7u
	 71TZaLbRlrKyD6aP07/ePnBH1Sdby62WlyqPE11K1D+SDLGkFd4lHUsMffP0F3RN3E
	 PWcrwaGDfmetonZJ9j7DVDbOwLaef1VrBugW+XprYZL3jkJbshTPzl0pvR5+Xm+H6O
	 wnKNamctm0gXRN7p9348DTc7vNtt1C+fyoncGemDbFSzUvUo0FfwfvLPlz6NBf2zna
	 2fz1uTrWlph7g==
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Tim Lunn <tim@feathertop.org>,
	Andy Yan <andyshrk@163.com>,
	Muhammed Efe Cetin <efectn@protonmail.com>,
	Jagan Teki <jagan@edgeble.ai>,
	Dragan Simic <dsimic@manjaro.org>,
	Ondrej Jirman <megi@xff.cz>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH 2/4] dt-bindings: arm: rockchip: Add Radxa E20C board
Date: Sat,  3 Aug 2024 12:55:09 +0000
Message-ID: <20240803125510.4699-4-ziyao@disroot.org>
In-Reply-To: <20240803125510.4699-2-ziyao@disroot.org>
References: <20240803125510.4699-2-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device tree documentation for Radxa E20C board.

Link: https://docs.radxa.com/en/e/e20c
Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 1ef09fbfdfaf..2b8bfc7892cb 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -753,6 +753,11 @@ properties:
           - const: radxa,cm3i
           - const: rockchip,rk3568
 
+      - description: Radxa E20C
+        items:
+          - const: radxa,e20c
+          - const: rockchip,rk3528
+
       - description: Radxa Rock
         items:
           - const: radxa,rock
-- 
2.45.2

