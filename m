Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795202195;
	b=exwr7ChfLGgFe1fnKIDa6yla0ACNESzL4Upxr4/Q2LEAaSHGAhVr3oksPnHtbuzL3tQx
	 gpAif7hhcMZDRzxn1QO4IHHHYEd9EpUydVDFdpY2DL7xREo/dKdwKuinS+HDExMzTQkxJ
	 rWHlAmvuFgh3GmioMnT9VMcZ1DYXCD9+4pupVf/ZDwy24pFP29fhG/hbpwxL5oikFdYZ+
	 xGi+LmzRuZwfYPnzO1L9B9Aar6CtZHwRhPfd+ZpadLTzfC9KSFUDWdygZHhmP/WE4Z2XB
	 vREnUNV2yw/PtGwkKLKqWqoYMU9h08oSmP6wLzeuZWt8fNPaUDrFzb7snXbzyl3OGlA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795202195;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=X1gs5KeCo1v5nVzDOONX/rjGPthdxfNaqSCGYiFENeg=;
	b=sDLp+PhS8CSHERqoK+Xr04HhNYcSAttNHBGGAwvpercxL+h9CQ+kR3+RmT0sF8Qatt1+
	 Af3Hc29DMXkCcIazU7B9PZqdo+JaoJX8vATbjXEzp7W2e8/KDYWaFDl+L0f2ZJ7lFAcEJ
	 3nwyoyoi6eAC73Pc6WiGCrGFX5qfShUQpqkA2hwQQ4PUE+n0drKgJMKQlEoFnZfDpf6GV
	 sn7CUwj7Dve0qDC+wJHlAVLlNuLn+FbAqNR/3Ua3H5RM5u5JKeNlFUtVlk3eHkOB1pdD/
	 2GfpLMS2SSIKdBGxcPdU3WAlDsV6J2zVxM4hhoviW1lxB+ahGGKi423ZXyiI6j3t+VA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lXT1FYTq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1B560A381A;
	Fri, 20 Nov 2026 19:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lXT1FYTq
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795202195;
	b=U8wEpGxwpssbJz4blbonnIO5Y8HSPCIip6qzwmqAU46JuxKQkxffly+0w4lpXXk7sdam
	 Al18Q6/Zya7h5JMcw1L3me06cga2c7QAfsIm1OxUv78wDEHIsq1BJGGsfGIrQtupHuqIu
	 xIbAURdhrS27ohJUbj1VoAG8pLtU0zR4oO4Y/ahEUqeUM9H+boEHiNPSN1S7P7GBU5xzm
	 6oxdkN48Zm85qOtV+XNEXCIz/+TLXu9OinEUYySi42IMtZD7zDvi6d6+xgHJ+yMFf42U5
	 7Yvz+qEcxbfZ9e7slwGkWHbhYIxwoY6JjFeR1iBP+ohmFPZOvgMzCYQCoUIgEFs+kuQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795202195;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=X1gs5KeCo1v5nVzDOONX/rjGPthdxfNaqSCGYiFENeg=;
	b=kyX+XhqYthejGGXi5X1BB5iCKnjg+fQTsfmN6T1R4xUZjCs/aWRJUoCl2+1H5UqjEuEi
	 lXR83MHUbGIZKLmjyHVCfQQDpnKeNFelP2zE4MlV2ahbnmwZVLZSyX5rSg4VIVkQZvAhL
	 UU9dKXZ7NcwUpW9UEOU6PtPYC4TvZk64gWR31FYys6AHAP27oIwEI33qLo9M9ZoDzbCS7
	 B/p9FoYifyMytQgVkwfFKmHHNcSQTcJjsN1owOPRvcg6SH59wcMz+qgpITAUWCklVrZcK
	 OWUFzroOmnwQzyQFJNZ53BVWjiIpx6M/o/KUBwxStu618sOh9XLnSHdwwDyuhA+fMfg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 833E21F000CA;
	Fri, 20 Nov 2026 19:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795202195;
	bh=X1gs5KeCo1v5nVzDOONX/rjGPthdxfNaqSCGYiFENeg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=lXT1FYTq57B6uAhfydx+OTNAutLUUGfWWbzKAylE/NUA/Np6/idde19UDURpRKJyv
	 3+jMLYjIEfADsRGHUwLpYjeRsd5N575Z8WfXbqUm/o0yBmR1okACxDrcoj5AviJDhs
	 JGErSe9YJSdfQKRPxFPu3doeD1s/JGlp/DJ4ZjJHp73m1241zqJgXvodtJmq4is5Bh
	 zfVx3YK+5oSALSZ8J96FXtdO4fFHlwpUtokuZ2hpX2Ksy9Rd0MxY5D9z8os8gmfTZ2
	 WH2r/JEaal8wb/Bf0HrJyCqW3CgANB2q2Pzhnpc/1VYaGtfk9b8d1ES6FqhUb4//Dh
	 LvRzm6wbk7bTw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 131934B994;
	Fri, 20 Nov 2026 19:16:24 +0000 (UTC)
From: Han Gao via B4 Relay <devnull+gaohan.iscas.ac.cn@kernel.org>
Date: Sat, 21 Nov 2026 03:15:47 +0800
Subject: [PATCH v4 01/13] riscv: add Zhihe A210 support
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261121-a210-scmi-v4-1-4a795a0a9fc9@iscas.ac.cn>
References: <20261121-a210-scmi-v4-0-4a795a0a9fc9@iscas.ac.cn>
In-Reply-To: <20261121-a210-scmi-v4-0-4a795a0a9fc9@iscas.ac.cn>
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Radu Rendec <radu@rendec.net>, Samuel Holland <samuel.holland@sifive.com>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Anup Patel <anup@brainfault.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Michal Simek <michal.simek@amd.com>, 
 Drew Fustini <fustini@kernel.org>, Icenowy Zheng <uwu@icenowy.me>, 
 Inochi Amaoto <inochiama@gmail.com>, Vivian Wang <wangruikang@iscas.ac.cn>, 
 Yao Zi <me@ziyao.cc>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, 
 linux-serial@vger.kernel.org, Han Gao <rabenda.cn@gmail.com>, 
 Han Gao <gaohan@iscas.ac.cn>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795202181; l=1016;
 i=gaohan@iscas.ac.cn; s=20261021; h=from:subject:message-id;
 bh=Xvkj+SoMFEM0aCTapUCLJM3XOLxV9bGDyfr9qshYbdY=;
 b=T7MP/76xYCAKU5w8NqTFMcRtQAIkbRLfydOKpgQvY1FLftb4nEm3Yhd0DRAIEPZw/RkonH/fK
 SRMZXG585TuC2Ofkq9niiUkQJFFfpd+z1/La8+sRICabQ6bh74hY0YN
X-Developer-Key: i=gaohan@iscas.ac.cn; a=ed25519;
 pk=J8WHEK3filS86QaCaIHDGafqhxKyQ4K7+vFgRirTIiY=
X-Endpoint-Received: by B4 Relay for gaohan@iscas.ac.cn/20261021 with
 auth_id=1262
X-Original-From: Han Gao <gaohan@iscas.ac.cn>
Reply-To: gaohan@iscas.ac.cn

From: Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>

Add the ARCH_ZHIHE option for the Zhihe A210 SoC.

Signed-off-by: Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>
Co-developed-by: Han Gao <gaohan@iscas.ac.cn>
Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
---
 arch/riscv/Kconfig.socs | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index cecbce0c4983..9e096feb79b9 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -91,6 +91,16 @@ config ARCH_ULTRARISC
 	  This enables support for UltraRISC SoC platform hardware,
 	  including boards based on the UR-DP1000.
 
+config ARCH_ZHIHE
+	bool "Zhihe SoCs"
+	depends on 64BIT && MMU
+	select ARCH_HAS_RESET_CONTROLLER
+	help
+	  Enable support for the Zhihe A210 SoC.
+	  A210 has four C908V and four C920V2 RISC-V CPU cores.
+	  Supported boards include the Melon Pi V1 and V2.
+	  Say Y here to build a kernel for these boards.
+
 config ARCH_VIRT
 	bool "QEMU Virt Machine"
 	select POWER_RESET

-- 
2.55.0


