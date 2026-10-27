Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793115423;
	b=zwm4uNacRSURgzL9h23CncN+LZmfol6Gmf8X7Kwh3WC50MIbDWj/AKOqhNw7cRRN2p8E
	 o2wsRJTWcyyP7FQETDGs/2oxb5gmK2GXYpZj9CQEIP3d6q8Fj2ZwIMuaTx7ZcE18tAwAi
	 qKktHXGbJ039uuFhyUm6mcuLCxFJ/jpXYTXdDQESr8EydBMI75Ul1zSuN/SnVNPc3N0vY
	 tTFVOx3XSM/6fZjSvouPaKXIUTehdwYrk8AZ08HllUDRskKLSIuNR0h7xCGctSLDeEZYA
	 pixp3Ewotl36aG5nBeDNlgFShxd8/OF9cmPmNqTqfB6UCaaj7DHDERF82/Mg+MQv8wQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793115423;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=RsU/Miju2jeqymvYcNJXTnmmqKzjTj43vuEKKcaUunA=;
	b=1/R3os10tPpSshuzliDXBvT7WiSfCQFwKXw3O7mjLxCndIaLgGcWd9IgX0BB8b2fnWeF
	 lBdg/0ouuIi/qBGC/u95XsjMSK9FYqKezqwe0mmgexvM6n0UXwLdKy+KqjNnXAmwkHyKf
	 A0aVtJQFMd8NL/Dg1W6YQ3NoK4j9h3/jpv3E6WXRTA8AWaV6rTUeMwMZ+97+eQZY+PMA9
	 wgGWu0VWdea7MZv8MQ/m0cvH6+1kFBLYFoLUmQZq0py46nAob5QWOjLQtvPrUUYKBKag/
	 KyqBUewgEeD3i0xb/ZXViRpuTk2o1MnRo4ZaUo9lC+OYSc3oNRfGC2T35L8tbeFLs3Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rx+apCM6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF53606A31A;
	Tue, 27 Oct 2026 15:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rx+apCM6
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793115422;
	b=I58PmCtMOsJSyv7CfUgoJnDx9r7C1YjBQXD4CryF2Jr7SAgsMSvejo7cqiV5cDQxIv9u
	 hSpUHHj+bNXqXtD3j6WEReMrrIHYaJ/S02Go4KngscpHHl1uee4JUZAMDBfvuDKs+QjvP
	 9+qSft/lJ+UN5G4U87yXp4XlHi2B/BxiEzxyJ10k+yLTT8cuvTczkum2gCGk/62k5LJm0
	 w5+8GXD+oAe5GjtuOnAyQD6yKln3bfntUJSzQBHX5V3zKQwhIteOLj0MM1LTRSCkrg9SF
	 B3p4cm8Huyc2TXUbmHrGWJcvcawCcV/CVs1JChhLRNHw3ha/bIBn0MWVMajhoIsosWA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793115422;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=RsU/Miju2jeqymvYcNJXTnmmqKzjTj43vuEKKcaUunA=;
	b=B3ELMtPMzhBI6yFmB0tt5UqJdykqeSycVTzrDEyamoGX3wmFWsF+v5jvs5kLtKBQBf6n
	 Joow1II8vLA7sAOgBYKBflh46xjASbfA9yCEAFXj1jCeBakRxhSD62MFnPWT6dJAIWaDM
	 floZSnftuzBeUi3Yn/Ux1xO1wQbS2kZicAqTgywC/AK7mlJZIMJV5OG0iS0QN7odSCYL7
	 0HabDrEgned981lX1EFKyeHGnSjVh28zL0xqKuz5LVIaAuX6WX+m6J84omY2hZp9UPKYJ
	 9KtwmNHLeocbeXp/JLm+eeT0e1KlqgA4qzixn0Wg7+pYAoDjPTzlH/aIy+i7J48Vvpw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B4BA91F031E8;
	Tue, 27 Oct 2026 15:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793115422;
	bh=RsU/Miju2jeqymvYcNJXTnmmqKzjTj43vuEKKcaUunA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Rx+apCM6EluEKSCZHQo3m3NYIdPozD/nSGfKZYRDvgzctsvybIhlceKPKQToC/Is3
	 oMeFqxtKbu4VVFQs5ztaZPY1cOVHEhbC2dB0HEqyL2ZUTZbON4oGZIJkfiAPski2oJ
	 TZoA0yExKlRpeUYIpaDOaRkuAUqgw5uu7dAQuzcvQXJOH8IHfA3DqvSjnXaP2KZuRJ
	 UcoBoIjgt0u07m0Em7NPyBQsWeN1woMnwI2wzVxUdcpMlLih2zQwTSBHAt+7se5Q85
	 YU2ELf3VqHg4vfgFb9u7BiMkXrCqVBS2qnclhf102ifK3/AbU5wm55HD37c4SS/Ju5
	 b3hVKEIuSh9qw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 307A64513F;
	Tue, 27 Oct 2026 15:37:01 +0000 (UTC)
From: Han Gao via B4 Relay <devnull+gaohan.iscas.ac.cn@kernel.org>
Date: Tue, 27 Oct 2026 23:36:53 +0800
Subject: [PATCH RFC 02/18] dt-bindings: vendor-prefixes: add Zhihe
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
Message-Id: <20261027-a210-scmi-v1-2-74d58ce85bd8@iscas.ac.cn>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793115418; l=842;
 i=gaohan@iscas.ac.cn; s=20261021; h=from:subject:message-id;
 bh=78H4CNA6muw7rwfV33m2sQ0QfyIqTcYL4B8JahPXMn4=;
 b=ZlIYxo13cmOAFrP5dhVx8YBV6beEABXC/eF22oDJ1AKXa+I4RIFByDZzWBlPUSIX3TUDFFQ9X
 hNEt/8H6owrBYrIHLOg2GkAvpO6b8uJOp8WCZ+bCF9Bmd7iZjztiPwo
X-Developer-Key: i=gaohan@iscas.ac.cn; a=ed25519;
 pk=J8WHEK3filS86QaCaIHDGafqhxKyQ4K7+vFgRirTIiY=
X-Endpoint-Received: by B4 Relay for gaohan@iscas.ac.cn/20261021 with
 auth_id=1262
X-Original-From: Han Gao <gaohan@iscas.ac.cn>
Reply-To: gaohan@iscas.ac.cn

From: Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>

Add the vendor prefix for Zhihe Computing.

Signed-off-by: Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>
Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index ba2002969373..21142578837b 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1973,6 +1973,8 @@ patternProperties:
     description: Zealz
   "^zeitec,.*":
     description: ZEITEC Semiconductor Co., LTD.
+  "^zhihe,.*":
+    description: Zhihe Computing Limited
   "^zidoo,.*":
     description: Shenzhen Zidoo Technology Co., Ltd.
   "^zii,.*":

-- 
2.55.0


