Received: from va-2-30.ptr.blmpb.com (va-2-30.ptr.blmpb.com [209.127.231.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE05B34EEE8
	for <linux-serial@vger.kernel.org>; Sat, 14 Mar 2026 23:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773531829; cv=none; b=YAF68KFtPs0wkmGL3OoWCSt71wmNQh9RyChW9pNGXqOBZ239wzh9HCVniPpjxwhJcbuenR2zoBvNyA7oOiBUbpcBdRm2xgzFx7xehn0DMbrBMvQOi95H4WZHSqKvXmBE68jjDWerVyR78Vpi0bNrErSOZyWxQ58Ub4bqjZNlq2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773531829; c=relaxed/simple;
	bh=jbTjQzTzKLODEEV96JhJ4cxD23a4Xp2o5KR4Cttb9Y0=;
	h=To:References:From:Subject:Mime-Version:In-Reply-To:Cc:Message-Id:
	 Content-Type:Date; b=HmwZ4YLD/zD7FnXF+3Z8xFrr6HAAie4KVWzqKEiIHIkEjJpsjCoJQHZuAjsMA/kAkfy2jee/nA/kMsc/zESUECdt81IFjeuaOo4BzwENOknHIvhrURVGyN6M0qbq3yR3c9rIjbPWaAaporBd4QvEc9dt7ENcOjU/L4KhjHm1v1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cipunited.com; spf=pass smtp.mailfrom=oss.cipunited.com; dkim=pass (2048-bit key) header.d=oss.cipunited.com header.i=@oss.cipunited.com header.b=JjsZ2sox; arc=none smtp.client-ip=209.127.231.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cipunited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cipunited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cipunited.com header.i=@oss.cipunited.com header.b="JjsZ2sox"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2303200042; d=oss.cipunited.com; t=1773531710;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=qjwiWQK9ND0M8GvhVewD7xqCAHpseSipYcAsLmniDM0=;
 b=JjsZ2soxrm2uT3cQ0RfZzTqf9Z5jZJpknXpTVicIXVB95m9P2ZCTsiXkbtrfpV2rlNZHAU
 3e5S939OxYIZf3HGci9Oeo9l1mcaqP8u5ncOwn/wMQuVs11YrvbZJUm8iOAHUUPipN9XMq
 ig6z+HwiV5mTDv2Wm5DEME31Pya+d++VBaUBbOFfHGC2NrlEhPd2rIjyN9MQ4Edar+edLA
 OsA936Vub6dEenhy3M97Cv/s7ixOEg3XJouYXH72phJt/RUTMfFpW/vX4Jd8JwJxYs8J+2
 E3LUm+suixc1OGrC4n1Wpi10Yae8ZXaRZVE2SZN0LvfsZinLPH5anCHx1uvnng==
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, 
	"Jiri Slaby" <jirislaby@kernel.org>, "Rob Herring" <robh@kernel.org>, 
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, 
	"Conor Dooley" <conor+dt@kernel.org>, 
	"Thomas Bogendoerfer" <tsbogend@alpha.franken.de>, 
	"Huacai Chen" <chenhuacai@loongson.cn>, 
	"Jiaxun Yang" <jiaxun.yang@flygoat.com>
Received: from tb ([223.88.91.90]) by smtp.feishu.cn with ESMTPS; Sun, 15 Mar 2026 07:41:48 +0800
X-Mailer: git-send-email 2.53.0
X-Lms-Return-Path: <lba+269b5f23c+edc5c7+vger.kernel.org+rongrong@oss.cipunited.com>
References: <20260314234143.651298-1-rongrong@oss.cipunited.com>
From: "Rong Zhang" <rongrong@oss.cipunited.com>
Subject: [PATCH 2/3] serial: 8250: loongson: Enable building on MIPS Loongson64
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <20260314234143.651298-1-rongrong@oss.cipunited.com>
Cc: "Rong Zhang" <rongrong@oss.cipunited.com>, 
	<linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>, 
	<linux-mips@vger.kernel.org>, <devicetree@vger.kernel.org>, 
	"Yao Zi" <me@ziyao.cc>, "Icenowy Zheng" <uwu@icenowy.me>, 
	"Rong Zhang" <i@rong.moe>
Message-Id: <20260314234143.651298-3-rongrong@oss.cipunited.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
Date: Sun, 15 Mar 2026 07:41:42 +0800
X-Original-From: Rong Zhang <rongrong@oss.cipunited.com>

Loongson 3A4000 is a MIPS-based Loongson64 CPU which also supports
8250_loongson (loongson-uart).

Enable building on MIPS Loongson64 so that Loongson 3A4000 can benefit
from it.

Signed-off-by: Rong Zhang <rongrong@oss.cipunited.com>
---
 drivers/tty/serial/8250/Kconfig | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index fd4e8b6ab60d..fc3e58d62233 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -465,11 +465,12 @@ config SERIAL_8250_OMAP_TTYO_FIXUP
 config SERIAL_8250_LOONGSON
 	tristate "Loongson 8250 based serial port"
 	depends on SERIAL_8250
-	depends on LOONGARCH || COMPILE_TEST
+	depends on LOONGARCH || MACH_LOONGSON64 || COMPILE_TEST
 	help
-	  If you have a machine based on LoongArch CPU you can enable
-	  its onboard serial ports by enabling this option. The option
-	  is applicable to both devicetree and ACPI, say Y to this option.
+	  If you have a machine based on LoongArch CPU or MIPS-based Loongson
+	  3A4000 CPU you can enable its onboard serial ports by enabling this
+	  option. The option is applicable to both devicetree and ACPI, say Y
+	  to enable this option.
 	  If unsure, say N.
 
 config SERIAL_8250_LPC18XX
-- 
2.53.0
