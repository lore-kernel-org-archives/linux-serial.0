Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1461C8FC6;
	Wed, 18 Sep 2024 15:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726671995; cv=none; b=c/PBgBqTPgbm+8dgoKGfGn9ae8jKUKR/qCYdXw4PmyYIZUmYZCtSp4LAdZCfTrfAyCEKP8V4pEcIuDST46u2V4iTYej9VfMeiThG7K4HShPe+8gqugc1pt70ITdBP9m16DMZVytBer3jmpOclyVbYUFRLt1nSUXm1m6jtL9Cv7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726671995; c=relaxed/simple;
	bh=k8V4oAtC1xUvvwaC908kOzAoB/9R1YpBSEPPpXNjw/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IYdZvCtoERVTdATA/oi62ctY7zcnl6XWKtCHH0IpVIkqpry6kqdlAF+qAeApsG3O3EMlsrpBxzQgk3d913Bpn0CV7enOYkGGjDtYjpet5mzzqSV74i8tLAh/6Dg+PY6GHFPQoAiWkxbmDASdWPh9PFfx+jrxLDmOoHVlViyJKvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=exg0yWCc; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="exg0yWCc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1726671990;
	bh=k8V4oAtC1xUvvwaC908kOzAoB/9R1YpBSEPPpXNjw/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=exg0yWCcqsKUJT/XrM3PAcsocKR8l1WPqsjJV27k4wvuzSZO6HzX0jYTqZw9DX3E4
	 qlPVvwmDTa9jO6/Yz1gdl7F1VZX3R8/KUEBDvWG1QdWD/w5oLPiZBtw5ILn7sReTZI
	 n0I6031+kBX/gG7uJhEJramN6iBSXxA1+3Qa1hJXVDRLKqJTk5+kVhXoYSlIM5z7Ig
	 HtbEgFtsOtvT0p+9JWpe+a9QTErs5+Kif4bE5pc9Y8e7/SWqMkiWAn2U/JQ7+84jTN
	 esIdyHuELsRdID55S4/FHQUwiKoHhQ2P2zZ+iuKlx9QLgYAHQgrj2HB3jZ3/xjt/D2
	 0uE4JHVNUE07Q==
Received: from trenzalore.hitronhub.home (unknown [23.233.251.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id F11FB17E35DD;
	Wed, 18 Sep 2024 17:06:28 +0200 (CEST)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	kernel@collabora.com,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v5 1/1] dt-bindings: serial: snps-dw-apb-uart: Add Rockchip RK3576
Date: Wed, 18 Sep 2024 11:05:07 -0400
Message-ID: <20240918150704.1163581-2-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240918150704.1163581-1-detlev.casanova@collabora.com>
References: <20240918150704.1163581-1-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a Rockchip RK3576 compatible.

Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Heiko Stuebner <heiko@sntech.de>
---
 Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
index 4cdb0dcaccf38..cfcfd7a6b78f2 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
@@ -49,6 +49,7 @@ properties:
               - rockchip,rk3368-uart
               - rockchip,rk3399-uart
               - rockchip,rk3568-uart
+              - rockchip,rk3576-uart
               - rockchip,rk3588-uart
               - rockchip,rv1108-uart
               - rockchip,rv1126-uart
-- 
2.46.1

