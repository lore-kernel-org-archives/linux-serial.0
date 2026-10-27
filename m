Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793115425;
	b=HZ5lrwWilfkWG9sH6RyExnowRCMumWPIYknmJ9QWrD8KrBMCcPkLIGs1C9AVgA1h6VoZ
	 Ry4OgyOcUdx9U6yPLp4jCheADplEZbU1e9obMUJNkwmau2bV9pQrkIt1qMQ+Dv58CpFwl
	 P16tR5T9V7q8ZZFWgmiKLTlZJM5Dg5YXod6YknmZ60K4LEpWFQ66DaTs2ko+bYiDH+ozt
	 ebLQ5OttHqGCfSS6PJBUCJTCE1ifBXvkhbU9vDrn07AUckvlrTQ0p66RTqdI0CpM8a0MD
	 25lGBrXc+oa5AWUDuRiQerY+bOYMyPL+6exlwlYKgkrb5a1XU15ZiMepsVgulQOSVFg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793115425;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=Wg/4rCc9Y69RwQr7t1OslmfPJs2UBZmRz8gauVCMqkE=;
	b=S7Bx3gzuuzU7z7DbIabp8XZ06EPiwB2FPU+ldFjyFz1xuNj06EzCC6mxXQSOGfQlH8AD
	 /LgrU+t+gl6GqE8ziyCUr2JTOyolZjQ0s/oHfG2DiF2Wstxu32CJcKgkfAgqQACth+cEq
	 TPz12kKGsurYp8neRlLQx/Fu5KgDZNbY7SKwFcW7Thag6Et/UE9r9+YY6PJWzoQkq0C/x
	 qBh/GE4c4eu/WaJgHLJgOuOdBtb4VI8H2Woczcp180oX26cNabdWV73iZ5u23AdLOwiuC
	 sX88qEAKUhGOmRTxOlpY5ZsAkGF700EmW9SDuXoJ3oWq2cFfuXyN1PaMuALF7Rrm8zQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k1TtMq6c;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512FA60A2619;
	Tue, 27 Oct 2026 15:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k1TtMq6c
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793115425;
	b=Ywa8MSiejR/f1YYcj/kiGYnf8OoFAOwaugBiii4/UJ9OfL/t74fa3rQgsPtOcdIC3BFz
	 f1Q9ufGaq1jZlhEwaHCYllIKk0HXiY9UEa7WKfglEzTUlbHH7YoXhCxMw3xiG7cI4L8N2
	 iDvaJXt5XC9l8trhUGVNY/vbiT+e0yQXZ0D1ilWSOwBN18bktDLiAOj2pr3BkMbTFEP3R
	 oAOE7D0oletW5OHlvY94F/GPgEtYHzE3s7+8l579yoTvW32a10H4iKlHkzbrnoIOJTnrz
	 vNXihvhsc8hOvKGtB3s5gzVn2c7OXTcWq8OYgbaV+spihG33TR3inB6LzIw6DFIl5zg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793115425;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=Wg/4rCc9Y69RwQr7t1OslmfPJs2UBZmRz8gauVCMqkE=;
	b=U6HPvvbCj+wLEPhNIqlywgF7J7cKl4LmjF+NuhyVa0VqQREnFnYX/Vcw80XrsHhnKj4V
	 LPO+tVI3Vt3Nk0CoiZgH6uFU0/lMtjazQs3BtpdIAkTOaizjjLGKnK2jTsYgxwxLJjC4h
	 XV+sxC2m3bJJCDnGzh30/INaWib59CHZ4+ve5TV+QUSDgvatQx5honHY//Ow7ZUWeoYPB
	 y0UQkgaLALlKbkfuhGY2Gsd4R1wJ6ZTfNusGPVscelhHdC2hmxQFaVmj6NmAxFU2jOEcF
	 e9i9jThPMt6BPkWETHKn1qsAq3qcgG0bKdZwKQpeAYAmWmp7RwdcUQFC6FAShUbzdUA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id BE2A51F031F1;
	Tue, 27 Oct 2026 15:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793115425;
	bh=Wg/4rCc9Y69RwQr7t1OslmfPJs2UBZmRz8gauVCMqkE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=k1TtMq6c/WTv48i4q3qBxo5ssYXw2BOWw1W18j15xuLHNw4DwX2jGcb51WY+M6Cei
	 5Xetw0blVNtzG1xYHxoJBM6srZDGtw5e9zY1z1CCikpjEThb91yw6yLTsBVRCsYYqo
	 DW68+lxNR/WAYqioYEIw+8zjFTM93ioRLFEkW+Taus2iPJZVXklGA5ypRH+BGjngKQ
	 shPrZI16eq+pg3YnmwpuOwSVbDEFqs0dfzj7ZW6OSMKC3QwxGgJVof1B66FOOi0dz5
	 p/M9L/pmRzACbByKLDDKEyfDXAdJ3nV+u4dFvJBOvu54OZmo+qq+krAuKdtXpjrVHT
	 zHVg+46ytmT7g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7344545157;
	Tue, 27 Oct 2026 15:37:01 +0000 (UTC)
From: Han Gao via B4 Relay <devnull+gaohan.iscas.ac.cn@kernel.org>
Date: Tue, 27 Oct 2026 23:36:59 +0800
Subject: [PATCH RFC 08/18] dt-bindings: interrupt-controller: add Zhihe
 A210 PLIC
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
Message-Id: <20261027-a210-scmi-v1-8-74d58ce85bd8@iscas.ac.cn>
References: <20261027-a210-scmi-v1-0-74d58ce85bd8@iscas.ac.cn>
In-Reply-To: <20261027-a210-scmi-v1-0-74d58ce85bd8@iscas.ac.cn>
To: Sudeep Holla <sudeep.holla@kernel.org>, 
 Cristian Marussi <cristian.marussi@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Linus Walleij <linusw@kernel.org>, 
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
 linux-serial@vger.kernel.org, Han Gao <gaohan@iscas.ac.cn>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793115418; l=961;
 i=gaohan@iscas.ac.cn; s=20261021; h=from:subject:message-id;
 bh=MYmNcIdDPzIqU+lFcft+1pLSNPlzC5ZsJ4TFo0L1GrE=;
 b=Vhx+1FMKGBmb9XNkIq6p+G9/3cD2jq2U9rQkE36iw94gvXsWmdIZaqbb+gQDI3rmihzrmhBNC
 uFqJfWO5xdtCbVnBFGZ7UJCwkdi2VTYeHduCK06ARF1vJDnM8k3m/a5
X-Developer-Key: i=gaohan@iscas.ac.cn; a=ed25519;
 pk=J8WHEK3filS86QaCaIHDGafqhxKyQ4K7+vFgRirTIiY=
X-Endpoint-Received: by B4 Relay for gaohan@iscas.ac.cn/20261021 with
 auth_id=1262
X-Original-From: Han Gao <gaohan@iscas.ac.cn>
Reply-To: gaohan@iscas.ac.cn

From: Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>

Add the A210 PLIC compatible with the thead,c900-plic fallback.

Signed-off-by: Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>
Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
---
 .../devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml      | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
index cde4bb691897..fd5b61db3f5f 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
@@ -80,6 +80,7 @@ properties:
               - sophgo,sg2042-plic
               - sophgo,sg2044-plic
               - thead,th1520-plic
+              - zhihe,a210-plic
           - const: thead,c900-plic
       - items:
           - const: ultrarisc,dp1000-plic

-- 
2.55.0


