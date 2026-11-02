Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793648718;
	b=0/QA7PN/F3dUQnJkcjOxch6X6Yb84uOel/WvIbHD3jcY0bG9RKXwuC7Ir5RJ8T6+z5r9
	 VjkGMryFUr8EhDuypaHgAPHnJjOw6Ac0rER3LUVSDY7cCWjGiHShQ1RCw6ghHm5oMNddu
	 2yj42WbeaDxHTMAv/wCY6oL42KwM7VB8PnH2DoG4T9DQkBhcdk7PKXkKjao5C+8ya5nNQ
	 rA4IGSvQWbJxnVjHS6ipN7wCJsmU3VquZVISK6l5sJqeFfqikPcuVuDbO5dDBOdcyna0I
	 uPdvWoANGbdDN0ARi/rQfDAhmwu+6dwHYSzMKpvVFxkg2ZsizXO5/TanBhWWWk8infg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793648718;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=VoO5psaD9DFnzn5bc1zZcOjZ9Zx/iOn4te5QyeYQEoQ=;
	b=vqt8CNhBLJgF8O9LrvR7Dgyj/04chg1kt8+Y7enDLEdmbivWlvRvIPrx5nyd5Og2TY4K
	 pQkhnXxkGQ1KBP85KG3Aj3lMPvF3plhckYSt53vyrl/xRfjLnAHDWpXqCC16bWoaft+bJ
	 4SFhq8NNbWqf/AQG5LruJrx1KZG4nkmGusm+UCHKUyAwlZPlM2QQnA+geepYmbCuML1Hs
	 SUjCUuXrXQlwojXXwCC3TCmHQlZgYTIkcHoG4oKpe5s92qV5Sz4kv//9rxSLvXYGHzS1T
	 g1p9aURGtxHve7oyr8OUkXNM13SA20mNaS2DObZNOvUu7XFPCkcVMAHjWvDM3yOdQuA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SekwYctf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7208F6082BF5;
	Mon,  2 Nov 2026 19:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SekwYctf
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793648718;
	b=mj234G8tfZCAg07vFT4myHJnpt/EL3yllG6y7KXQQFV3DgxxPL8Sj9Gk++NC2TxysHrj
	 EFJpDFRww6goBRUt+ne/iw+hPMj4mwKcT34uY5EaVilH+K5gIzTvOT3IrPd1bqXbW/8j1
	 USMIgIETl3pHhfHdRVIt7H6W0X+v5lqGxeMVmNVoFMfwnjFi3U1a/QUmxRq2M1D1ktqdK
	 1T98ihm0I0KVh2Df+bZbHrwZzIyknDAFYX3wNSXtZKXICxR3KUebSEswbsZeNgbXfeJN8
	 pKLcP1HKAYUIV2mdoHmhYjVQWwq/vHlUeMFew2hmkmqcMfvyHgEi+vlXD5oLyIsrDIA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793648718;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=VoO5psaD9DFnzn5bc1zZcOjZ9Zx/iOn4te5QyeYQEoQ=;
	b=MvW1a1JzvxsoQsoodmPwMi5NjKN6WZi8r/EqDVpcWMkjZVOAu94dNzPvvyPLIIf3GP46
	 zB4AvHqgBln9D9umV5WeV/X8kbv2mGhZTSQke9TgH7xhlDbZFYqZVorBcge+sq1LIOEBw
	 TDD/HCAfqqa9n7XPSByKuD0ujsW8mpK8EAVeK+1W1QLJ8NTB6oNjalrBMbEGxq0HQc8vY
	 Pv6n6ucwYueDjkAo59CVcaimumDcN4D6bByh8GYr8naxwumhnUU6nAvK+GVRCkPy9VtqK
	 q5b0bZvLQ7zJC/hsoiKHiZTUH3H4aja9x7mMEJcgIgV/ohKzbJ05C+MJcdOQCLtprwg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 721841F00A1A;
	Mon,  2 Nov 2026 19:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793648717;
	bh=VoO5psaD9DFnzn5bc1zZcOjZ9Zx/iOn4te5QyeYQEoQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=SekwYctfGqRKX5oFltaManGyX0fj/7CkBatkH4+jvnKgdMlrhmpMH3kPORVTppbvp
	 Y2GjN/IRqpw4pijL6CLSu1PtPehMGtXDi9VY2BQd21zUOxlH6f2ZBwblA6AIwUWrJB
	 gnX+71AeE8pxYFUFb7I1PLCKW6FwZAdrkjBq2ASGsM0fZJVdCdU+AqaSV0VkpsVb3h
	 DtRADZ+fMek+mi3OMjX5Ml7biAF57eVLIZML7Hr9Gxi8PUi0er3Ek9VWI8wf7qmYmj
	 t6hcUYWhq1vQaU4XbIXa8jJBdfYELVoWd6Jk1dUnXpGiKiCcSq86AYVPkESmvluDzI
	 OmFzD6luwNqNw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 472D646629;
	Mon,  2 Nov 2026 19:45:09 +0000 (UTC)
From: Han Gao via B4 Relay <devnull+gaohan.iscas.ac.cn@kernel.org>
Date: Tue, 03 Nov 2026 03:45:13 +0800
Subject: [PATCH RFC v3 10/17] dt-bindings: timer: add Zhihe A210 CLINT
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
Message-Id: <20261103-a210-scmi-v3-10-ee6b31580808@iscas.ac.cn>
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
 Han Gao <gaohan@iscas.ac.cn>, Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793648705; l=860;
 i=gaohan@iscas.ac.cn; s=20261021; h=from:subject:message-id;
 bh=xDW3mj4crTCYIjLMrm7hiotLvXuQDaJfNmGBDmcpw/Y=;
 b=jPnhhqjJYSQguFvLE9NtnRdhJ2pnOIJBkGdeFMOGQktm4CG6PWJlPA6aa0aC7ETMCM8DQqjwJ
 BARoYkifsKZBP3NCtPK4kUUcLiUf/xOXjljT0FkuSVWrt1HIZCy3wuW
X-Developer-Key: i=gaohan@iscas.ac.cn; a=ed25519;
 pk=J8WHEK3filS86QaCaIHDGafqhxKyQ4K7+vFgRirTIiY=
X-Endpoint-Received: by B4 Relay for gaohan@iscas.ac.cn/20261021 with
 auth_id=1262
X-Original-From: Han Gao <gaohan@iscas.ac.cn>
Reply-To: gaohan@iscas.ac.cn
Content-Transfer-Encoding: 7bit

From: Han Gao <gaohan@iscas.ac.cn>

Add the A210 CLINT compatible with the thead,c900-clint fallback.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
---
 Documentation/devicetree/bindings/timer/sifive,clint.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
index d53f52e80d88..6480c8dacf6b 100644
--- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
+++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
@@ -55,6 +55,7 @@ properties:
               - sophgo,sg2000-clint
               - sophgo,sg2002-clint
               - thead,th1520-clint
+              - zhihe,a210-clint
           - const: thead,c900-clint
       - items:
           - const: sifive,clint0

-- 
2.55.0


