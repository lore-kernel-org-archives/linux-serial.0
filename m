Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793115426;
	b=Go9L2Qn/JcF8cjkIVXMTXQq+O2Tfmk8i+/rNjTZf9Fw/j9A3BGeL/lV7i02ImZ8wf1s7
	 0mrS3lWWWXCpoTwElK9hxHIT6kReDC3smz1WDj/+T3+Psr8ykCF/uhX/5qPjpHyefycU4
	 eooyzW4kSjzkdgDHtXQeRM6xmPHxIHttf7vX+UOk3IYyYrFvQUTDhOy1Eg+ADGb76Qoco
	 g/BkeSWYb0L/Hm09RsPXKQfcz9EqwoCZjpcSNw88eklr19HvpAj2vf9suL1BbxTP1IQtW
	 cL9q8qLtWsADAYsK+525pFIEbpPzN1Ommb3vuaJfH0mPy2PzxG28irt3ylwgHVHHHuw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793115426;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=D/80EfwAtXJCC0tZxo33X7RmKZW37FWB78bJeXvz28M=;
	b=nzxv5nPf10ac0SAkgAz/1ct8xTkqNA4tgACW4MXGnj3iylxw/sCcubEWaP5p46CEdMZG
	 ZpBq42jveGOXw/1PICqA0yu5hbbJtUo04M99zqhkHYxeh0Afu+2CEYd4K31tzrqL+wW2h
	 rib7YSrCQFCIwYpZrAiuwKAMQAd+lntP+cwLuB4WcykR4uaIoo/qhMPFIt7R+cQY+0oVa
	 o5yUeklLYJsZ25taFzfAQ0Jvf3bEtBK4HSZajHr9BGo8KDmyWztenPDrLptg6F8Bn9p5H
	 1UIIteB9E/Jr4sl9FhZw7/eGJmgAALKQ802OmTdmlSWysrXKMi7ZFgU/UFP+UU/XcfQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cnGXNasM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89F8606A33E;
	Tue, 27 Oct 2026 15:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cnGXNasM
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793115425;
	b=WKogAzpMuZyEIVz3zgmPN2Dkw0hWb6ZrT9eyC7dkEe/a6CdSkkDYLLc47/iHvHOMoj/L
	 oY1/E+qDGA7drlQmthV9mm3SP37au+eGbPf1WTmjXmoYIx17RYTGiIqBFW57z3jHdSrhF
	 4Gc9o0lajHgPsmkX4R9L3hTunZqD0Ax6rn6LlwWRa+s+WAtOACCS1vf8p6kOwgig5O9mc
	 ybNuhubKEIhdCAaKUFvwfnECSxf1ln+q5KUaFCDRUYZmVlbx29/e0V9rQrmfM17Qhe3JV
	 iMzlzdkglVhX4kClxYJh7odRknfGVfIjGICFSZ+yXKKRHZwb/3F6sekMO874bO3jAQg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793115425;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=D/80EfwAtXJCC0tZxo33X7RmKZW37FWB78bJeXvz28M=;
	b=dm5ZrH/rFgFLQUN4ckrpPzq1SwsNBi6R8V3llAgQpavNeaQd98FHs1905ma77IRP0I8m
	 0+aKtAyOKtQOvFwQIeby78rkkk335DbY8IbRFnm3w0jmQsW+GOPSKdVKX6EOvopDeNEy7
	 hXKvHFVKYLKKAPMqtS144UF46bWt4Mrj/oaS5vqIkW4U+JAW55sn3vLdYZwHSyCejwF+x
	 LtHmDkj8U0C/ZUNoy9/sYfpPF/DAPDgxn90kSlShRT5NRuEH76Xp6N13MrXJkAlCduCvV
	 FXpJB53I6ami0mTGMPiK0kreI9uRsWp0cdQSvQ+gKxDad2Yz8pglRhn/xuB4rnDG3ig==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C9B831F031F5;
	Tue, 27 Oct 2026 15:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793115425;
	bh=D/80EfwAtXJCC0tZxo33X7RmKZW37FWB78bJeXvz28M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=cnGXNasMvPhkUgVo+5pt8BHt5kuJCKFeYrIiu42mUM0QP11MS6LX0of0qAYnaPp4+
	 j9Y0tsYR/3VQeZfIuZVo694LxCh0kvBMjfKqq7hJ7yW4OqpaShMgqcPEoV4eA0b7O2
	 2iTN4ggOr2AJYQFchhc6Bif/H/5GtLANw3RjQe3+cq2QxOtOIVKTz6LB4FTDsG1Zgw
	 KlezO6mH+Ijj+els/+KsJLPROUO4/WHkBDvw1U0vD1JlgtShD1Tot6doKABlRrWVBs
	 Jouc0j/HKfZ7kzpqD950880hI5yTzJoJzeqLE0V0Vr7sxzgrtVTH7i3ehVbkLIcG51
	 vn4lv9UVylwtw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 895A64515F;
	Tue, 27 Oct 2026 15:37:01 +0000 (UTC)
From: Han Gao via B4 Relay <devnull+gaohan.iscas.ac.cn@kernel.org>
Date: Tue, 27 Oct 2026 23:37:01 +0800
Subject: [PATCH RFC 10/18] dt-bindings: timer: add Zhihe A210 CLINT
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
Message-Id: <20261027-a210-scmi-v1-10-74d58ce85bd8@iscas.ac.cn>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793115418; l=807;
 i=gaohan@iscas.ac.cn; s=20261021; h=from:subject:message-id;
 bh=mOLkOh4/jpI+bhz73rcyph1kni8iu4RhyVF0Wak3gq4=;
 b=KeI1lFZVfnK0DXd8ETZZgB+ksVJayuij7OJj1hfsbtb1XteWB98ctRke9ZnIc7FXDmCk4+PVq
 /wpwjTFIHK9AdFBNUk034oWabJBv0PFrOe5o8bM35iqFLP0putZ2BR0
X-Developer-Key: i=gaohan@iscas.ac.cn; a=ed25519;
 pk=J8WHEK3filS86QaCaIHDGafqhxKyQ4K7+vFgRirTIiY=
X-Endpoint-Received: by B4 Relay for gaohan@iscas.ac.cn/20261021 with
 auth_id=1262
X-Original-From: Han Gao <gaohan@iscas.ac.cn>
Reply-To: gaohan@iscas.ac.cn
Content-Transfer-Encoding: 7bit

From: Han Gao <gaohan@iscas.ac.cn>

Add the A210 CLINT compatible with the thead,c900-clint fallback.

Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
---
 Documentation/devicetree/bindings/timer/sifive,clint.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
index 3673836e14de..805262bb6cd3 100644
--- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
+++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
@@ -56,6 +56,7 @@ properties:
               - sophgo,sg2000-clint
               - sophgo,sg2002-clint
               - thead,th1520-clint
+              - zhihe,a210-clint
           - const: thead,c900-clint
       - items:
           - const: sifive,clint0

-- 
2.55.0


