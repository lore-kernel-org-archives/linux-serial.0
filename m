Received: from sg-1-12.ptr.blmpb.com (sg-1-12.ptr.blmpb.com [118.26.132.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815366FC3
	for <linux-serial@vger.kernel.org>; Sat, 14 Mar 2026 23:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773532438; cv=none; b=TxBpH8I/8dbYnO2LSq82N5XsVLDOBkbA2HsMZTP9jLUWltsOY1PwuAoxMUSY0fCBtviz/eZwc1bMOkOlf9FYGlfbjBg5r/wnFS2wX/WL3n5v24W6+g8sqk8YJNJD9w+lkruWzLqJlvWSzjsozqH9xwb1N/nazutktfkrJwYN92c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773532438; c=relaxed/simple;
	bh=vrusqwkGGaiD1U40//aLfLHGRcn4Aexj8deKTDqIpgw=;
	h=To:Subject:Message-Id:Mime-Version:Content-Type:From:Date:Cc; b=BF8Z56l+MnikKfmeSzjiFkpfufUKql2NDVZMbtqYNdM9oXu3KdjfvzXK9vqL0wTpbb8XWsxX6v0syN5xIebwsJjOJnyefVinS56e8sj9EmtBBG9oIDgK3VybaEkjXIunS+POa7a03vTCAbmPkNqsKyZJa/SuUSJSMxwix49PK9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cipunited.com; spf=pass smtp.mailfrom=oss.cipunited.com; dkim=pass (2048-bit key) header.d=oss.cipunited.com header.i=@oss.cipunited.com header.b=2HP/y21E; arc=none smtp.client-ip=118.26.132.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cipunited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cipunited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cipunited.com header.i=@oss.cipunited.com header.b="2HP/y21E"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2303200042; d=oss.cipunited.com; t=1773531707;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=TzyF1v0NlxN5WwXjtflZOgV+Cup/KHavISWhIQddOMg=;
 b=2HP/y21Equv0ZkfR9uS0yQe0N622cps0q3Xrq0XuIBwjSra49NjQXoATBMjPYvPzyStzj0
 pXkAIb7AJQLH8I3283375g+5dUqKkM7hU0HzepKSgFBCKBYyWWHhF5xreHztM4ODRCTjH5
 CWjo1vZC7Ejj5AzIgRr6rjBTQ5LBs1gmpkdAJbFyxd1UaAEzuQKo5JBSlbAFHSCLxlgZVo
 lMp0pHrlQObsuT3KD55e+cKKQ7gFUxrHu3TLefYn4QILzRmznEpiv60/d4aj3vwqFqDsEE
 7wcOLpgEmktAq6TWB2dkRmtOBT0jcexUZ1tbWRPm0hnnxkVQQ6rrCkwZwvQz7g==
X-Original-From: Rong Zhang <rongrong@oss.cipunited.com>
X-Mailer: git-send-email 2.53.0
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, 
	"Jiri Slaby" <jirislaby@kernel.org>, "Rob Herring" <robh@kernel.org>, 
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, 
	"Conor Dooley" <conor+dt@kernel.org>, 
	"Thomas Bogendoerfer" <tsbogend@alpha.franken.de>, 
	"Huacai Chen" <chenhuacai@loongson.cn>, 
	"Jiaxun Yang" <jiaxun.yang@flygoat.com>
Subject: [PATCH 0/3] MIPS: dts: loongson64g-package: Switch to Loongson UART driver
Content-Transfer-Encoding: 7bit
Received: from tb ([223.88.91.90]) by smtp.feishu.cn with ESMTPS; Sun, 15 Mar 2026 07:41:45 +0800
Message-Id: <20260314234143.651298-1-rongrong@oss.cipunited.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+269b5f239+2ca8c4+vger.kernel.org+rongrong@oss.cipunited.com>
Content-Type: text/plain; charset=UTF-8
From: "Rong Zhang" <rongrong@oss.cipunited.com>
Date: Sun, 15 Mar 2026 07:41:40 +0800
Cc: "Rong Zhang" <rongrong@oss.cipunited.com>, 
	<linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>, 
	<linux-mips@vger.kernel.org>, <devicetree@vger.kernel.org>, 
	"Yao Zi" <me@ziyao.cc>, "Icenowy Zheng" <uwu@icenowy.me>, 
	"Rong Zhang" <i@rong.moe>

Loongson64g is Loongson 3A4000, whose UART controller is compatible with
Loongson 2K1500, which is NS16550A-compatible with an additional
fractional frequency divisor register.

Patch 1 adds loongson,ls3a4000-uart as compatible with
loongson,ls2k1500-uart.

Patch 2 enables building 8250_loongson (loongson-uart) on MIPS
Loongson64.

Patch 3 updates the compatible strings to reflect this, so that 3A4000
can benefit from the fractional frequency divisor provided by
loongson-uart. This is required on some devices, otherwise their UART
can't work at some high baud rates, e.g., 115200.

Tested on Loongson-LS3A4000-7A1000-NUC-SE with a 25MHz UART clock.
Without fractional frequency divisor, the actual baud rate was 111607
(25MHz / 16 / 14, measured value: 111545) and some USB-to-UART
converters couldn't work with it at all. With fractional frequency
divisor, the measured baud rate becomes 115207, which is quite accurate.

Rong Zhang (3):
  dt-bindings: serial: 8250: Add Loongson 3A4000 uart compatible
  serial: 8250: loongson: Enable building on MIPS Loongson64
  MIPS: dts: loongson64g-package: Switch to Loongson UART driver

 Documentation/devicetree/bindings/serial/8250.yaml   | 1 +
 arch/mips/boot/dts/loongson/loongson64g-package.dtsi | 4 ++--
 drivers/tty/serial/8250/Kconfig                      | 9 +++++----
 3 files changed, 8 insertions(+), 6 deletions(-)


base-commit: 69237f8c1f69112cca7388af7fab6d0ee45a2525
-- 
2.53.0
