Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882672D77FE
	for <linux-serial@vger.kernel.org>; Mon, 22 Dec 2025 13:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766408814; cv=none; b=Ka+rmvBLWw/EgOOSEyNjdQASk0vqOlJ9nW+ESqVkPkoR8Lm2UIrFk4DOnsgDad9WMEFitPUsv4gPvHfnxJxbbipPKZPYYzcEiEVD1esKv1Hcr3vOMZUfyAvKbH2vLvDYFCYwWZSFSJ7WWH1t7S+TsCM9sMS0i/8fCwr1HwB/oC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766408814; c=relaxed/simple;
	bh=zt6I6EAytFR8ggLCy61krEbf9jT4HMDJDCSOrojN5mE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JrrmEs31tFpMbUB4SukzR5Pw9gkaMrmj2fSkv3n8PUUZIcID2EKgBLZAYkw5QCcCx+iywA4INIDdn5u9Xj9kFoT9dc63PAqoL3w35ejFiPyyihO54nsC95GnLJ3Gz1h7rCLVe2RRGQXrMkh8Z6SxNf1Sl1hOZLM7tY6qPDL4T2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=Bqmohv0m; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="Bqmohv0m"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-bbf2c3eccc9so1822311a12.0
        for <linux-serial@vger.kernel.org>; Mon, 22 Dec 2025 05:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1766408812; x=1767013612; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dZd1WuVDHb3KQSVAGlgKp7AEdPQaqmn6KEKfxdPwWwg=;
        b=Bqmohv0mq4dTG94nJWjNeRRu7lTmb/NWFFyobGwoguDTVqyMHs+539fvhASS5Ua7xv
         YfUHvqZ4oF08SKGbyzp5RslCvKglR4XzqFxrpNNBT6PsUEHoMLQRgLDrvy1jc00NyJVs
         Gj0n23z2HmFYHNttwWZClmtzBunC8RQoceQibyTSppuhGc83EmIk9522RBl6US04JR7N
         DZ1rIvsovYKaCbtcvt1XIIi0aMtnZ894SJF8pMPKorAEk1USt5eC8t9nrnmWLrW4fndp
         OWmsxf0VVKsweiXqW4gatl2pKnSVRN2q6PKKPxLRgepbInmdLcBki5MCdh123NOfJ7sa
         bOZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766408812; x=1767013612;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dZd1WuVDHb3KQSVAGlgKp7AEdPQaqmn6KEKfxdPwWwg=;
        b=TqAyZjhpPsZoMiprbzms9eUbfngr/XZ9+0aceus4rCIkuIL7KJrjEoQKsNpOy0Bvin
         pLrheD9j+i8y6EYzTvtFqyPgVzgCQZYPUP1192be+jwfGuxbcOYvxMhH/x0sO6GZY2Oq
         DzGf21pzBhmup/H8upgayMjB6me+StwaZtdZncVSGucO7qJymy89G9PdIqPcy+uX+6Pp
         /3LJ4NQRToOJ4YBJnUc5+VFyX/tOGl+BUgHW7bJ2z47TcIksheXUb12PM7BMTj+qaQJS
         eHOniXxRQ+tQTKIlsiPFASXf7/xaT5uim5jgGGEXlcmfjX4GyQYpl+K4nCQ9Ysvq55hS
         ttLw==
X-Forwarded-Encrypted: i=1; AJvYcCUwj/wpvvKoxJOJENAe+ky90JycYtQockiW/1kYf/TXVvpObGzHVdwgzwFIU7uy5CkUCitJEgK+Hx/cD6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOt+haEhLoJIJIBwL3vWvErecb/WhQsAecsML83Z681eO6r+kh
	dob0m9N1JkWVwOpl3w/iYTsa8kMD+kBDjiRoanEnZs/ShthMOrLgPBi7UrYbsEXxVxc=
X-Gm-Gg: AY/fxX5ElQNoxkpAjDVw1lvCTpTlgPVSNRmiUi0/9WG07mPvWDYav3f+4jDWIxDtl1C
	p2XBF1PgXH4gkNsJHJZ369qyW61SAWNNH7u1ACpWgVFNlR/+GbqkBJh4dCeih2xkpwV3rjQKA2l
	tYK8qOWQA+bVaVfAqQUqi3VA2AkNzpUadvrPfnAmcIIMCQpEkwjJ5IdDfIF3VqjjI4o/pgfHcaD
	QBx0jcoESXIimjDyFBKBr+YNfdgue429hzeUThhsVpSp5uoxhjBt7Px+7B/vUxYy/O+1h1Jj5EX
	7Yq+0dN7sk+V52b1JyNlF8UtGHtuN9CdqrZwSgvEjPLtNPzZfDuwb0cjKWaMpgCOIEvjsdyfxaz
	nUu57qpN9dd0chQc6di/y+eQVaf9DedJDOUNEK3lbS0Ee7qfgYbwNevmScAV5VnQb0jjgHUvtfm
	kFMgMJQxeuqD+7ahWu2FuEFLZL5jSWGec=
X-Google-Smtp-Source: AGHT+IGPSlitj+KdxoHkSz2WMJ8tmr7DZSG1VelElp3zzCiMbTqUqeMIJpXpJbfUrLndiBON9Fx4BA==
X-Received: by 2002:a17:90b:4c4a:b0:343:3898:e7c9 with SMTP id 98e67ed59e1d1-34e71d6901cmr13057876a91.2.1766408811887;
        Mon, 22 Dec 2025 05:06:51 -0800 (PST)
Received: from [127.0.1.1] ([2a12:a305:4::402f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70c932casm12970405a91.0.2025.12.22.05.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 05:06:51 -0800 (PST)
From: Guodong Xu <guodong@riscstar.com>
Date: Mon, 22 Dec 2025 21:04:13 +0800
Subject: [PATCH v2 03/13] dt-bindings: interrupt-controller: add SpacemiT
 K3 APLIC
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-k3-basic-dt-v2-3-3af3f3cd0f8a@riscstar.com>
References: <20251222-k3-basic-dt-v2-0-3af3f3cd0f8a@riscstar.com>
In-Reply-To: <20251222-k3-basic-dt-v2-0-3af3f3cd0f8a@riscstar.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@gentoo.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Anup Patel <anup@brainfault.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>, 
 Yangyu Chen <cyy@cyyself.name>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
 Conor Dooley <conor@kernel.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Kevin Meng Zhang <zhangmeng.kevin@linux.spacemit.com>, 
 Anup Patel <anup@brainfault.org>, Andrew Jones <ajones@ventanamicro.com>, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, spacemit@lists.linux.dev, 
 linux-serial@vger.kernel.org, Guodong Xu <guodong@riscstar.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2

Add compatible string for SpacemiT K3 APLIC.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
v2: Add Conor's Acked-by.
---
 Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml b/Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml
index bef00521d5dacc002d24c50843ebe6380a7d5524..0718071444d29fbfa36283fc9666e8cecd6f77e7 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml
@@ -28,6 +28,7 @@ properties:
     items:
       - enum:
           - qemu,aplic
+          - spacemit,k3-aplic
       - const: riscv,aplic
 
   reg:

-- 
2.43.0

