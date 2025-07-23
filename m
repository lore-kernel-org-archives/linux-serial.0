Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C4F285C8C
	for <linux-serial@vger.kernel.org>; Wed, 23 Jul 2025 08:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753261048; cv=none; b=fUfh/Eop8LsV5Kt4dvXNoAUltIJ3aVTqTZUZYgylGB36UKEjL2rq0CggHN3SSmTv/oTeIt7DMkOH4g1ZjwxOfWq/NW3+SAl1ozfFMQJopos4Sls9c22hKODrp04ZgTfdsMbSUI1YGFy/zfoRPPHDxYGN7fcXMXeDQoAbBJU5rhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753261048; c=relaxed/simple;
	bh=8SCowtYA+H6rspvke1KAUKfarPLg2f1jV6JRWecdiKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rlGaSAo3qss5Yrzr0hGZhB6CdniTAw69Lh0WeaRunKYhTfaU7S7VnL/3eI7zVEMQev8r1BvpQO7rCypwIykAQdjb4/tuXWkcNG5B9zIZZfI/y8jYAqXnIOVMIbbhtjJlIyCiFRBnLZi7EZwM1XTvyPhjah4NgLfszZi16ajb5Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=jMRiCdiC; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="jMRiCdiC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1753261046; bh=VYMDQe/mQ1kKIZU+OHkaA1YB3avFSOAww6d1p3lXtB4=;
 b=jMRiCdiCV2040MGnEoBMZ+2/8uUBggkdS0LgnbI1iErTS79v49qcaUMgl6yUkyztX3w3J6Nqs
 BnXBeE3oZi0QS1oZDmyNdB09wKOEyEsbm5/Nzjqty6sFgXGpdVYi22Vws3gIpVCDEGl0vcbQjzC
 6Obkihx7omZ5CK/1ARiDAHSASJ9WlrGiQ2TZ3mZ4kSvoyUGvJmsl3odtCV/Bl7tlnppYmCr9sPD
 7FC5noDB7sQ8e3bI9jXrMOBzz1lIef3lcjoL0bnGQQ0IJJv1Zq3TZ9jz0AyRlI0CNy5nxOs4F9m
 Cu2SxLrkXK+gE4xi86CoIKx2PHbWoEFm49avUI6SicWw==
X-Forward-Email-ID: 6880a3ed144dc4a5e5baee49
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.1.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Yao Zi <ziyao@disroot.org>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>,
	linux-serial@vger.kernel.org
Subject: [PATCH v2 4/5] dt-bindings: serial: snps-dw-apb-uart: Allow use of a power-domain
Date: Wed, 23 Jul 2025 08:56:46 +0000
Message-ID: <20250723085654.2273324-5-jonas@kwiboo.se>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250723085654.2273324-1-jonas@kwiboo.se>
References: <20250723085654.2273324-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The UART controllers in most Rockchip SoCs are part of power domains
that are always powered on. These always powered on power domains have
typically not been described in the device tree.

Because these power domains have been left out of the device tree there
has not been any real need to properly describe the UART controllers
power domain of Rockchip SoCs.

On Rockchip RK3528 the UART controllers are spread out among the
described PD_RKVENC, PD_VO and PD_VPU power domains. However, one UART
controller belong to an undescribed always powered on power domain.

Add support to describe an optional power-domains for the UART
controllers.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: New patch
---
 Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
index 8f1b7f704c5b..cb9da6c97afc 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
@@ -108,6 +108,9 @@ properties:
       parameter. Define this if your UART does not implement the busy functionality.
     type: boolean
 
+  power-domains:
+    maxItems: 1
+
   resets:
     minItems: 1
     maxItems: 2
-- 
2.50.1

