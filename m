Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9265D3D9DB6;
	Tue, 29 Sep 2026 06:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790663698; cv=none; b=bFPBUuYUF9vzKwHGKNQhjdTcTFywSgIF1+bnl1CED5EXnVnepFHS/TXWDqH9s9hlrN/XKKAkdMW5BrBvnSGe4QhB2cjRvjSPE0YpIFsIhV41ZE9nZ3Dwm9fWYk493ec9fryjwncnqmelCaemWDGk1GINQIM5XfokLLZm9Z+ndfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790663698; c=relaxed/simple;
	bh=NucKFBd9r8hTUFyHEsbAB2CrbqXZ1Wa4xjN09/gmeb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YCj3NQYpbbtQqEQB4rcnQTP/aaklaArk9aY75rNTRduFUAZ8aQ/nqx3Fb4iY/AgRW+gxwrwNfDXiuQFPo2t6hwS6crJMWex6O8rKvOv+NoAsVVW0l8sFhM7yBhy6udToG7OJL4eqTPEIa1lEa1NOkkaZLoUAm/geZTElS+oJRdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WEf74tzi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEf74tzi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0F391F000FF;
	Tue, 29 Sep 2026 06:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790663697;
	bh=b5P9DPC5Eh+uVVTafzh7x7snkd1B5+EyEah33pHMIwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WEf74tzi760yMiXm/BbqSALK+Gvk/Z6yTHrwf5Dw7KuP6J0npGpLtEKSx3rrYjVSZ
	 LV13LVz/HA1cwIJI5VjiruARVhMwmUXEcETebHuyi4BafWynRucQiNNyIg9Be1r71x
	 RP41zHiK92rwsJBal0/5h3VbL3h+CJyCVnpdNiDrmQWxedSn01IGcJfVlYrpCxYIZt
	 nv2m3WdyO1gK8gH3Fbxtra56t3gtQCJQKcsefHB3bxhbF1SkX2voL6xayQPhYka7xX
	 uymMmTKD8+QrR8SjIJFY9EalKMg4VcfCzrPhVJh6cjQKhKWQTvrHqKDWIbG4hGO7au
	 0ze0YxOxMg/Lw==
From: Jisheng Zhang <jszhang@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Frank Li <Frank.Li@nxp.com>,
	Lee Jones <lee@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-i3c@lists.infradead.org,
	mfd@lists.linux.dev,
	linux-gpio@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 06/20] dt-bindings: i3c: Add Synaptics sl261x i3c
Date: Tue, 29 Sep 2026 14:14:03 +0800
Message-ID: <20260929061417.20733-7-jszhang@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260929061417.20733-1-jszhang@kernel.org>
References: <20260929061417.20733-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the compatible for the Synaptics SL261X SoC I3C controller, which
is compatible with the Synopsys DesignWare I3C.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml
index dcc21a7ab4c4..bd08d048d44b 100644
--- a/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml
+++ b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml
@@ -17,7 +17,9 @@ properties:
     oneOf:
       - const: snps,dw-i3c-master-1.00a
       - items:
-          - const: altr,agilex5-dw-i3c-master
+          - enum:
+              - altr,agilex5-dw-i3c-master
+              - syna,sl261x-i3c
           - const: snps,dw-i3c-master-1.00a
 
   reg:
-- 
2.53.0

