Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4BB4519A2;
	Tue, 18 Aug 2026 10:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787049133; cv=none; b=A92BlnSpMS995ejndMSSkB3Ew8U6W/b8xUCt7W4P+B2P5fIjUsosLmbiTMhTOyMvvTDH1sVjmccmyB0n7PbDYFoO63SxnvBZOZ5WXDJBbALzBq4yEEz4Brdm5EXWDPth0SvHhSZs+KVPolafAlykpHQqI+p78r/vVqOXBFk7cjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787049133; c=relaxed/simple;
	bh=QVo13gwqTD4KZzt9imrEAhoQPNNjElG0xmVDlRWUyNI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qWYqclODrINSgLGR8ANc1KG0gUSYO8KIGYdq3jEGYkgyJv1dnvHCCB/tX8dM5MqgxLMN4F6QTFUh+sEI5EvWVfVqA7lO5TcXLIpKCfS2RZYGh9kH1cC3oTaA3sFZng0lFPJh+9rqp8houIX+j5EBeuxyhHrYmTfaiL6oUCBzjJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lnN+DjGH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lnN+DjGH"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9277EC2BCFA;
	Tue, 18 Aug 2026 10:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787049133;
	bh=QVo13gwqTD4KZzt9imrEAhoQPNNjElG0xmVDlRWUyNI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=lnN+DjGHeo2tlc9vycESrAeCBLVQTWq34Njnvezg9CzWCbnonP3YdFTEXOlZTeByR
	 zzadrpuPzV7YWHtK4mhkBh3gfV9rd+XJkJHGeXrAmEaJ5Mpxr0D/tIe39cSZ2Vkq+h
	 f7GqjXbhgVb3KuivP/easo1L2Nr6F8LZzafUCA/WolDufpmfwjj9o1wODX6j7Lkh5Y
	 A2XbrsiyGx3Ze60XRvr7xG15qTKlwc3faQq+Kjh0RiT2DvqZkPbks0uwsZACybJfxi
	 t5LDBsW/8CBsVTdfjnR4XMY65yP2xMLvmqR7N4z6gNJg+3/CvK1ZPfyTyWK5bj68fq
	 CyCi4w/kyjKMQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7156DC5DF80;
	Tue, 18 Aug 2026 10:32:13 +0000 (UTC)
From: Long Zhao via B4 Relay <devnull+longzhao.ambarella.com@kernel.org>
Date: Tue, 18 Aug 2026 18:31:16 +0800
Subject: [PATCH v5 02/12] dt-bindings: mfd: syscon: add Ambarella CV75
 secure scratchpad
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-cv75-v5-v5-2-7bbb12f0360f@ambarella.com>
References: <20260818-cv75-v5-v5-0-7bbb12f0360f@ambarella.com>
In-Reply-To: <20260818-cv75-v5-v5-0-7bbb12f0360f@ambarella.com>
To: Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, soc@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Brian Masney <bmasney@redhat.com>, 
 Lee Jones <lee@kernel.org>, mfd@lists.linux.dev, 
 Long Zhao <zl020895@163.com>, Long Zhao <longzhao@ambarella.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787049131; l=864;
 i=longzhao@ambarella.com; s=20260730; h=from:subject:message-id;
 bh=UZUyXXBBt/U6PUqQu+CGVwiN2KK9z5EYeOVD1g3SxZg=;
 b=T8yD7k5AUqFRlxCE8adl8w66UEPKZlmwNFkLbqgX9QAVa/6oT3PaPWQtmP1u4FbMy7fjOmrHQ
 gK9z87jqEUICI07g5YRbWrqdiPaZHBed4IEaJhQQnJwBc2vYstg5t3W
X-Developer-Key: i=longzhao@ambarella.com; a=ed25519;
 pk=/xGhPTOX0/eYsyTWzyjjgAIW1Z/YD+IlnOnvcdRozow=
X-Endpoint-Received: by B4 Relay for longzhao@ambarella.com/20260730 with
 auth_id=903
X-Original-From: Long Zhao <longzhao@ambarella.com>
Reply-To: longzhao@ambarella.com

From: Long Zhao <longzhao@ambarella.com>

Allow ambarella,cv75-sec-scratchpad as a syscon for the shared secure
scratchpad registers on CV75.

Signed-off-by: Long Zhao <longzhao@ambarella.com>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index fe882d3f828b..9ebf702c06f1 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -32,6 +32,7 @@ properties:
               - allwinner,sun50i-a64-system-controller
               - altr,l3regs
               - altr,sdr-ctl
+              - ambarella,cv75-sec-scratchpad
               - amd,pensando-elba-syscon
               - amlogic,meson-mx-assist
               - amlogic,meson-mx-bootrom

-- 
2.34.1


