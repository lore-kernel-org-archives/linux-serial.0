Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793648711;
	b=zhvLsuxM6tZZW0AgeBDFWt5imQfNkPg9Egr04opQQmXq8TsFLbtTjz2GxWMyJr8OkJh1
	 UxO2yXUbfVG6R4wjm2BCMAmZIHfQaJLrccr7ZEPek3trBad0SUQuU9vu2V2JvohvtneJz
	 4G4KVQm7d2cqEQMBr/p4bfvDoGXqIESuvZ+iIOlVQ6ShQebK3SpduJzDNpJYG8UY1hj9b
	 HHKS/7e3QVCz/rcSk5mYWpuEQfC5Q0uQYVyNVIH8zxvbfHU4flR/iavd4K+MaTqQwc/WF
	 XjEZLA8x4A6sF5OAYWaaqpxlHlGms7ba7HOgj+sb7ZYOLoiqN97lLWB3+Qd/8IuSoRg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793648711;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=UsM44Bz2hR0jwZlDUjpk1mrvCsTX73s8ccqm/Jjs4CI=;
	b=I0KQvpo1yIg8eOLzMCWmBlmFZJLzyPTEJT+W5QTtFKQUwQC4tcp8yrTg1zZxWk3l+SMo
	 hL1TF2JaqSDEM/2bb0weAdB/TdfQHZwqf4elebMa01UKKMfL93l4UNxURhqJpovMOhEh1
	 Pcr9ITlYjSsrmWVMABCaC9D7O6FeA7AoYAr01UKjh6dHRWv631jsSKqR57q3PR7lW8mva
	 nAJtipgtC7jdtqamax20kjObEVWMm+Mr7N96LLcabUEKCTSbr3vdyh/zCieQ2Tehk5b3U
	 oYjeRZwLySd+ifhGz8NcBEt6mTEXeRzc4zp74HmcOZVfLfYgtuw+snijOHoD5J+0c/g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DfR132yd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4719606A32E;
	Mon,  2 Nov 2026 19:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DfR132yd
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793648710;
	b=iSy78I70IOJYScaOUENQkyhXTm6jG5lPLbf1YCxnafzfUjkRKFbLfO/wWkHx25o8nMIC
	 memyx3LQD1VYL2gOGxE5exW7A/KuJBQAZ12XBEoXdm62nMxBCGQUqpSUDfTYf0DWdNZeS
	 5L0S1FcSOXXwMrXErzovOICcuQ3udivo9DiS9Kh7P5SDG5HrWWp5cFdBJSnv9egLF0p3Q
	 aJbP/fcEUc1/Eh/5t+P2+src/1H9MRzv4coQzJ6JVV55C9vmLUQghZexJuesL8MkdSQBf
	 HOrN8gJUp7lSVBP7u99pOzX5q68fHpx7VtF9zKNhPyLnsLDrXF4vP+sJd94QvqThmuw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793648710;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=UsM44Bz2hR0jwZlDUjpk1mrvCsTX73s8ccqm/Jjs4CI=;
	b=wbPelbF7H0+N+IF6hoV6PhI9pB3x4m3ArJvnapdPVukEzB/1cSVN4iPkyWlnfSMIXgcH
	 sf9U7aN/IfvO9GhNZa/+POkC5pd5gR2TNVknyfs1k4NurwF6g3L1Jwqz4TBJywpQGYAmk
	 oFc1zA6p0BdZbirVsr0zPGozqcR/HD9PZSNW2WAw2RV9TjtZzfL9ZyWTuCxFPhF42iTZB
	 bjQtzjXJuiMpTL2PPQXdUh6yt7YMDaD7XNTeVx4k9HHs0ibZ7TEuk8jgWzYNr6X24veQK
	 u5abZUukJ/se6SnDQZYvQ+O/O9xtHNziW6FW+jzd2nOzGnuHtX8GWGTePVcsnt612eg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 54B3A1F00A1F;
	Mon,  2 Nov 2026 19:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793648710;
	bh=UsM44Bz2hR0jwZlDUjpk1mrvCsTX73s8ccqm/Jjs4CI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=DfR132ydmb5vPE4KOoRCNZFkjm6C2zbFRvJ9NkcC1qAb81zc0SBf8H1+2JPMdtziy
	 pkTqsRWqVK/l7uvyjyEQudasTqgKjaXfdtOq/ljhyJHjw7dip49d0OYEK7C5fcPLp4
	 jJjxOz3pF1w0TlPKftjX9TrOChJ3gePdcvoRrno3YvIMEYDdcQcdHtaI4V1y5y6RdE
	 aR4Bk3hIB8KiYjYKwqBfbk8IJ+rYLEWmIihB1A4RXdiWFaDJNSUPCRAobvpNGi0jxl
	 gbubKPo3KZXR2CTJVRDAQl9JHBf3lNDXpigRh03O7OClIwroFxQaYi1+Ts0rHBRmMB
	 5glZVYrF4yiUg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B2A3B465D3;
	Mon,  2 Nov 2026 19:45:08 +0000 (UTC)
From: Han Gao via B4 Relay <devnull+gaohan.iscas.ac.cn@kernel.org>
Date: Tue, 03 Nov 2026 03:45:04 +0800
Subject: [PATCH RFC v3 01/17] firmware: arm_scmi: Drop the ARM architecture
 dependency
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
Message-Id: <20261103-a210-scmi-v3-1-ee6b31580808@iscas.ac.cn>
References: <20261103-a210-scmi-v3-0-ee6b31580808@iscas.ac.cn>
In-Reply-To: <20261103-a210-scmi-v3-0-ee6b31580808@iscas.ac.cn>
To: Sudeep Holla <sudeep.holla@kernel.org>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Michal Simek <michal.simek@amd.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Linus Walleij <linusw@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 Bartosz Golaszewski <brgl@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Thomas Gleixner <tglx@kernel.org>, 
 Radu Rendec <radu@rendec.net>, Samuel Holland <samuel.holland@sifive.com>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Anup Patel <anup@brainfault.org>, Stephen Boyd <sboyd@kernel.org>, 
 Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Drew Fustini <fustini@kernel.org>, 
 Icenowy Zheng <uwu@icenowy.me>, Inochi Amaoto <inochiama@gmail.com>, 
 Vivian Wang <wangruikang@iscas.ac.cn>, Yao Zi <me@ziyao.cc>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-gpio@vger.kernel.org, 
 Paul Walmsley <paul.walmsley@sifive.com>, linux-clk@vger.kernel.org, 
 linux-serial@vger.kernel.org, Han Gao <rabenda.cn@gmail.com>, 
 Han Gao <gaohan@iscas.ac.cn>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793648705; l=1053;
 i=gaohan@iscas.ac.cn; s=20261021; h=from:subject:message-id;
 bh=/i2Hrato1ZaddmWBACOcAsu4rA2pM7/klcdfY2u7RqE=;
 b=twSKt1n9O18ON1twtQeq9bHAwBn2LoDRA9GzybRh7RNj6v2Uld03XL7r+2OKTy+S8evBTnbrt
 dLLzVzpNnkEAQRSfFZMsoejt9+FVb1uF2RGgxFrig8PAyxgPBzVtZUJ
X-Developer-Key: i=gaohan@iscas.ac.cn; a=ed25519;
 pk=J8WHEK3filS86QaCaIHDGafqhxKyQ4K7+vFgRirTIiY=
X-Endpoint-Received: by B4 Relay for gaohan@iscas.ac.cn/20261021 with
 auth_id=1262
X-Original-From: Han Gao <gaohan@iscas.ac.cn>
Reply-To: gaohan@iscas.ac.cn
Content-Transfer-Encoding: 7bit

From: Han Gao <gaohan@iscas.ac.cn>

The SCMI core and the mailbox and shared memory transports only use
generic kernel interfaces. Transports that need architecture support,
such as SMC, already carry their own dependencies.

Drop the ARM and ARM64 dependency so that other architectures can use
SCMI.

Suggested-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
---
 drivers/firmware/arm_scmi/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
index 783c24a20e29..b56aed46a387 100644
--- a/drivers/firmware/arm_scmi/Kconfig
+++ b/drivers/firmware/arm_scmi/Kconfig
@@ -3,7 +3,6 @@ menu "ARM System Control and Management Interface Protocol"
 
 config ARM_SCMI_PROTOCOL
 	tristate "ARM System Control and Management Interface (SCMI) Message Protocol"
-	depends on ARM || ARM64 || COMPILE_TEST
 	help
 	  ARM System Control and Management Interface (SCMI) protocol is a
 	  set of operating system-independent software interfaces that are

-- 
2.55.0


