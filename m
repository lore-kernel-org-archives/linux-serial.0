Received: from mail.mleia.com (mleia.com [178.79.152.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4817E238178;
	Sat, 10 Jan 2026 02:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.79.152.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768013213; cv=none; b=oI821DH92SQ+iXeH82LHGfGIEUr+NKmLCnE/qPTcAfw+/Ja2bBYBUSIo0hvttLGzrk1hOTCP15khxnGj8Q1GoN/z1iBuUc5mGCNSz4iB1FjhQVw1U9ZnrYyMv9xFuU4wO92LKTqIFO0hzvnmenV9nl0WJRQik/QuJ6Dxw0WR6f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768013213; c=relaxed/simple;
	bh=24hz3Id0LIKMRhcbMNAjYabls+Gw5398qtBHFFTVgL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oSgkr5pNg3S5iybLZakUMHRiz0lSRjaXkjWxeX26xKEeXNOvHNXkKePrMQDKbpH+no337RHIyUnLEbYBfEict3Z6w7t3VmcJr+9qYTDJe7FoZh6tXDpUpx5gPfvlq1Y+Yoz6jA95VEBwdezWR+SD0i6xgwD0bmgqD4IAzSCFdrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com; spf=none smtp.mailfrom=mleia.com; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=LwMX2Li3; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=LwMX2Li3; arc=none smtp.client-ip=178.79.152.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mleia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="LwMX2Li3";
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="LwMX2Li3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1768013210; bh=24hz3Id0LIKMRhcbMNAjYabls+Gw5398qtBHFFTVgL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LwMX2Li3pFgrq27AM+F/VtVUQfjYfbj276bnh8YIK02/pmXSUezFVVPiE6fO7ozb0
	 2VH7MMBIG763lNDv82ooC2OGJLrIB4dY19sc3vQ8XwD+nQh21ntIEQGgSgbsMJbLou
	 Eiy6h88BbmgCJRIfgmYHcayXDnwTdbjzw+4Jbm4QSrhyrGbvHyniURaO1a012Wj4gS
	 VFycna6HQog7UmPQkj+hja56UCBn0AW0M7+pU/fnN2wdx12z9RU86IQRgsL7l/TWIJ
	 CKfW01MFCZrrAqb4wESKileHeIt5hWqc4qbOLs/Len2Zv1PkfznfZrNPR/UsEvFc7Y
	 7WvOv4iI8TnVA==
Received: from mail.mleia.com (localhost [127.0.0.1])
	by mail.mleia.com (Postfix) with ESMTP id B26DE3EB2D5;
	Sat, 10 Jan 2026 02:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1768013210; bh=24hz3Id0LIKMRhcbMNAjYabls+Gw5398qtBHFFTVgL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LwMX2Li3pFgrq27AM+F/VtVUQfjYfbj276bnh8YIK02/pmXSUezFVVPiE6fO7ozb0
	 2VH7MMBIG763lNDv82ooC2OGJLrIB4dY19sc3vQ8XwD+nQh21ntIEQGgSgbsMJbLou
	 Eiy6h88BbmgCJRIfgmYHcayXDnwTdbjzw+4Jbm4QSrhyrGbvHyniURaO1a012Wj4gS
	 VFycna6HQog7UmPQkj+hja56UCBn0AW0M7+pU/fnN2wdx12z9RU86IQRgsL7l/TWIJ
	 CKfW01MFCZrrAqb4wESKileHeIt5hWqc4qbOLs/Len2Zv1PkfznfZrNPR/UsEvFc7Y
	 7WvOv4iI8TnVA==
Received: from mail.mleia.com (91-159-24-186.elisa-laajakaista.fi [91.159.24.186])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mleia.com (Postfix) with ESMTPSA id 0FC6D3EB821;
	Sat, 10 Jan 2026 02:46:50 +0000 (UTC)
From: Vladimir Zapolskiy <vz@mleia.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Lubomir Rintel <lkundrak@v3.sk>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	devicetree@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] dt-bindings: serial: 8250: Explicitly make LPC32xx UARTs compatible with 16550A
Date: Sat, 10 Jan 2026 04:46:46 +0200
Message-ID: <20260110024647.3389345-2-vz@mleia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260110024647.3389345-1-vz@mleia.com>
References: <20260110024647.3389345-1-vz@mleia.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20260110_024650_745720_46ED961D 
X-CRM114-Status: GOOD (  10.40  )

NXP LPC32xx SoC has 4 16550A compatible UARTs with 64 byte TX and RX FIFO
sizes, and the platform UART hardware is well supported as a standard
16550A UART.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 Documentation/devicetree/bindings/serial/8250.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index 167ddcbd8800..1a5178320465 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -108,7 +108,6 @@ properties:
       - const: nuvoton,wpcm450-uart
       - const: nuvoton,npcm750-uart
       - const: nvidia,tegra20-uart
-      - const: nxp,lpc3220-uart
       - items:
           - enum:
               - exar,xr16l2552
@@ -123,6 +122,7 @@ properties:
               - fsl,16550-FIFO64
               - andestech,uart16550
               - nxp,lpc1850-uart
+              - nxp,lpc3220-uart
               - opencores,uart16550-rtlsvn105
               - ti,da830-uart
               - loongson,ls2k0500-uart
-- 
2.43.0

