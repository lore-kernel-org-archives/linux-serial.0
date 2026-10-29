Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793250453;
	b=JCI/yTPQj8fAANiZvJhr6MPMhYSpPeiYn1x7I7485NSFvt7YDKhfQPV3irpDVjLgvQLe
	 HFJUAHC4+kIlSxxxjdN4TBNT9d0vylMZYIC84hH0ctJ2U1rftAGwM008b+dfoxP26plFz
	 VUpQzbVZhHY4wQCzlo809SsdGI0O3CJ1AKKznarzvjf9yeAtBERTp/fnF9rYRJwxADOh1
	 2bE7Y1B36NncoDxwSOBNxsj1wBUjoZ7PIDfLjt8eap1uaeGu2Mn5FlqSduAWnvc312QEl
	 7uZhQqiqLlzCZRVLL68ymAiUugElLmdNLme11kcU4L//Dy1JRq0KDTzaknLjwn/UbFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793250453;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=zQNT7IgbxAV25cmcgrqKQ0fkAq6sElRF1wG29F8EmV0=;
	b=qqauQ8XiW6CSMRX9Lt4AkSAkr1wfv2IcataEl/6UKi4DPxCD0a4MzwpLhxaJk+rv7naK
	 VI8NhFEgbj2Wd9+zJc58iiOIaL5nqUgcBrutWTv0sbXzFTZAuVL1Z2wBhpGK3GYRzvJIV
	 Dg1cnSxthZgAf0Qh37jMeVN1cjWxRDlG4D8Sl9EVj01NOjCLE8FaEUd8lBSzq8x2XA6uz
	 68io95WY7YH2J0VFsQqPo7+mAXtwHa/oT6aNlQUHYSq+nKdKQHgNodapjW27di29Ut35J
	 JN5bbXKXfwAFbf34Vo/j38MBsowKTd+FTUq0/wAI2kp6cq46S/pXFkgQBGKhRm58xCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bzCXo7ur;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D33C606A31C
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 05:07:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D33C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bzCXo7ur
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e985106c0cso14958825ad.2
        for <linux-serial@vger.kernel.org>; Wed, 28 Oct 2026 22:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793250447; x=1793855247; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zQNT7IgbxAV25cmcgrqKQ0fkAq6sElRF1wG29F8EmV0=;
        b=bzCXo7urDa6UbYwZ1ZnzYmKQgEctapwj9XX3Bn8RdVeT7BZVAzczVg73uESuoQICT2
         AC1tRi1ifIsL/spuMAC9rXHH24zz9UzV0bhCXMj2znMtbses/nwzdcmtvOI5TAJHqUOy
         7+GNyz64WKsk8cLgTbITiFyuukodRlO0arxkZ+evUtBnU+2XGur4cTdovJh+wGvPDklX
         AhyBWENXiWs2bVx603vlVZKWr+Mxffheq7KzR76/2ypgD7WYRyvbta7WRUUbSSLsxg7o
         vvI7wl4OVrnLvJMoh9FEUupt8XF99EOQ4DASyrM0itQFZdOaOTZir1LGMOK4AAZiqgqc
         reSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793250447; x=1793855247;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zQNT7IgbxAV25cmcgrqKQ0fkAq6sElRF1wG29F8EmV0=;
        b=VGHgqHDxTVq4kRlJkCznqhUFbEd9r/dbOCAQmMD/gkuIvxRr1yxEA1ufM7Pf/eqR6n
         rsKh/CeWk6knzBTozzIWkfY8jsYN38m0X6kQXXMOrJPm9HROeOR8GsPa4el3RxlwWV8N
         0sgIAGAC2awIBY8WmC67lbdkkTFMf3Cy/Xru1eIVaZpcUT57n/b4OEFOc7fEqI2c8RNW
         0GhizkCwSZigTsX3A5KflCS+7TvlUeqvhbsdyKKS+BsU6O9++NF1EurrrzfbicSzy1cQ
         UrfpT9Bt8V/iblHl/ZbRmYy2Ch/8rCKlmBdjoan9QqBqs0oHLPm/A//3ilL41D0HIDKO
         XIGw==
X-Forwarded-Encrypted: i=1; AKwUvBxq+vS6oVxUUJF52ZdO9+nIH6ouPhFW1Ulkeobo3dXHmTaRLebjIWYBuuqvsurrU88qDuFBD/la3zJLg1c=@vger.kernel.org
X-Gm-Message-State: AFq9FYJg74EvX5ToA6QYgAgotqeXseHd4P5PXHO6Kp7/6Kx58xKPhBnb
	C/QvebSfYhb38uTTp99cB+2iP+kqVJM5zU+aVNBE8xQ/NFGDWUNGaLRc
X-Gm-Gg: AYBFou0XoK9ukuJO/h0n/uTMv+gV46rg4TAiB5/AEZi+l5uRGUF4J3jbnCjgzUUEILK
	ffFkyL5qnoCCy3MKg6hWyJJjZQG63oOLHFkYMFpxa6u1K94pysPyYOYmE8RdevcK3qGOSVljXYA
	6HXG9Jt2y47zoRbiDRufS+2g+TAFbUp9Op1HDt6hVHF0myNvvFJSrydo+jpzHDjKjGl3wbp1RYp
	cw92xx6Qu4yjjukdoR1MA4oehHxqwjOU4LjW5z3ObqdzSjaTycoWSJBem/gYFo99UA/ycU+oZQ2
	nbODInntZnyvs+OdQ5bfPg2eh0btrtlng1QsdJWPGfu6C2jPMMuwffiEEk2/v/WpPOaN9/xPQW+
	5YLYtlGSvUbbQdt1HYhviDlN9A9jHUFAHoMAYgb28IaQBRO5KijS8Hy77CewyG9yReZDe8od0ab
	s5eHaT5WFfqgqaNWgw8yYKONh4Dlzs3Y/wZjKop63XSwirzA4+v2zd0UGNuRrK41cdZrck9M+vR
	yr2dlX7jY3cGksA4Vxtw59clJUl7XB84CKlySUR88hmzUfxZb4hf9I5P2q7byNWmhRQu/wKW6si
	GbO6LFRihWnaj1ch0CZOkqmwXPc1
X-Received: by 2002:a17:902:d485:b0:2dd:ad73:c93a with SMTP id d9443c01a7336-2eb004fc927mr39045165ad.27.1793250447442;
        Wed, 28 Oct 2026 22:07:27 -0700 (PDT)
Received: from [127.0.1.1] ([169.211.140.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6c9d2cesm28159685ad.65.2026.10.28.22.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 22:07:27 -0700 (PDT)
From: Kwanghoon Son <asdfkwang@gmail.com>
Date: Thu, 29 Oct 2026 01:05:52 -0400
Subject: [PATCH RFC 11/12] riscv: defconfig: Enable Bouffalo Lab SoCs
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
Message-Id: <20261029-rust-bl808-console-v1-11-b736ee920078@gmail.com>
References: <20261029-rust-bl808-console-v1-0-b736ee920078@gmail.com>
In-Reply-To: <20261029-rust-bl808-console-v1-0-b736ee920078@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
 Paul Walmsley <pjw@kernel.org>, Samuel Holland <samuel.holland@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Anup Patel <anup@brainfault.org>, Kwanghoon Son <asdfkwang@gmail.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, 
 linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org
X-Mailer: b4 0.14.2

Enable support for Bouffalo Lab SoCs in the default configuration and
build the BL808 device trees. The Rust UART driver remains an explicit
configuration choice.

Signed-off-by: Kwanghoon Son <asdfkwang@gmail.com>
---
 arch/riscv/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 04ae305d5511bb0760247f50d4b69b1e3a00527b..78a5580021d8cd654c33df931149a2224465285a 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -24,6 +24,7 @@ CONFIG_BLK_DEV_INITRD=y
 CONFIG_PROFILING=y
 CONFIG_ARCH_ANDES=y
 CONFIG_ARCH_ANLOGIC=y
+CONFIG_ARCH_BOUFFALOLAB=y
 CONFIG_ARCH_ESWIN=y
 CONFIG_ARCH_MICROCHIP=y
 CONFIG_ARCH_SIFIVE=y

-- 
2.47.3

