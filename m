Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C730043DA53;
	Mon, 12 Oct 2026 06:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791788313; cv=none; b=ei6G7Lczj0FeODeeomO+SwJAOvSqAzTcspBGz0fmNK9X/9H4Nhtcob8ynK3IpwYOmARECboRa5Efnl+xFxSwVxbbazwpbQ3KuipqSXAHx+8kSJ13bT/U867SzNK3veuaSaYc9ry3dqgSfQCxAkbjuDtjrVVOjAyap6kKp/LAI9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791788313; c=relaxed/simple;
	bh=GCubckKkvtS/EOiOIxWc0YpDQoyEYzgiiDMrguNF01I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ietMMkDNN36nyU1IfHS2DksNKPE75wa/HFck4UkHHqerVJae0OoegRZ6achRDbIvrZbqxxCOWrStxQbtmqDSCuZdpu7475BO9SPiydxXWHoyfHsV3wupU7vrhSHmaWVK/R+0LVIMPmeXnMi9Av44lEeREIB9zDnzytgCwXYfRhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUVO0oyE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUVO0oyE"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 95948C2BCFF;
	Mon, 12 Oct 2026 06:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791788313;
	bh=GCubckKkvtS/EOiOIxWc0YpDQoyEYzgiiDMrguNF01I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=XUVO0oyEilI+px/lGGlyU7HWZ8WPKzqU77aZp3sUW/slKTd3j/nQVujXQHigx4Qgu
	 Z8NXebFUUOHaFaMekfj62IO+J1SBXnqzaHV9ru2iLfTqkYNyY8HB/SiqWVQ1fbJP2l
	 8+qQLrVp/BtCaJFzrWxlXMoaozKFnfZKLzHCTV17ZSnm7ueWGVerFPmGrkMe8pUSZN
	 QI3Lb0Wj2s8OJ60gcFWWvkt/pbsH3JtY50+dXOlrqDeXf/MDvx856eLCFaSIxGgmxO
	 6ZG+s1K0FB+wjqPNcFM1yKYviU5zz6KBlEZRJ+MR3faIp1e8kZg0CBhx3hPDsmVJEt
	 h3xmaWAJgP6vQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 823E7CA9EDB;
	Mon, 12 Oct 2026 06:58:33 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Mon, 12 Oct 2026 09:58:40 +0300
Subject: [PATCH RFC v3 10/10] MAINTAINERS: Add entry for Cortina Systems
 CS75xx
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-b4-cs75xx-v3-10-0e0d17a098cf@gmail.com>
References: <20261012-b4-cs75xx-v3-0-0e0d17a098cf@gmail.com>
In-Reply-To: <20261012-b4-cs75xx-v3-0-0e0d17a098cf@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linusw@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Drew Fustini <fustini@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Jason Li <jason.li@cortina-access.com>, 
 Fil Dunsky <filipp.dunsky@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791788310; l=1124;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=NwAetqwg8dZTsEYKE0lK90ntL9PQOHqCts3OMdvEgqE=;
 b=feiihIYCDZ8Q6pxsKFcTa8tIGfgQazR+NwMKWTyagaEXe2IiXLrKXSTMr2zNZK64ozgHhpk8i
 85YfWSgq78qCgxVc1nqDwmj2kPvm7LOxgKuiup4zfCRQYlZ9U8Z/XkA
X-Developer-Key: i=filipp.dunsky@gmail.com; a=ed25519;
 pk=JAYP8e2rJ54DHOmhNtXud8rl1igAaAXoOHxtJmVXI1g=
X-Endpoint-Received: by B4 Relay for filipp.dunsky@gmail.com/20260930 with
 auth_id=1085
X-Original-From: Fil Dunsky <filipp.dunsky@gmail.com>
Reply-To: filipp.dunsky@gmail.com

From: Fil Dunsky <filipp.dunsky@gmail.com>

Add an entry covering the Cortina Systems CS75xx platform code, device
trees, bindings and UART driver.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2d137a339..176046436 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2914,6 +2914,17 @@ F:	tools/perf/tests/shell/coresight/*
 F:	tools/perf/util/cs-etm-decoder/*
 F:	tools/perf/util/cs-etm.*
 
+ARM/CORTINA SYSTEMS CS75XX ARM ARCHITECTURE
+M:	Fil Dunsky <filipp.dunsky@gmail.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/arm/cortina.yaml
+F:	Documentation/devicetree/bindings/serial/cortina,cs7542-uart.yaml
+F:	arch/arm/boot/dts/cortina/
+F:	arch/arm/include/debug/cs75xx.S
+F:	arch/arm/mach-goldengate/
+F:	drivers/tty/serial/cortina-uart.c
+
 ARM/CORTINA SYSTEMS GEMINI ARM ARCHITECTURE
 M:	Hans Ulli Kroll <ulli.kroll@googlemail.com>
 M:	Linus Walleij <linusw@kernel.org>

-- 
2.53.0


