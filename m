Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7C92D7DC6
	for <linux-serial@vger.kernel.org>; Mon, 22 Dec 2025 13:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766408797; cv=none; b=snwiIIB7u4t9nm7dofGDGp1J3jp7ztdMRq0NdfDPHELsAXctpLaxv0fshnyCaMePPCW8nNaH3rX1xsBUGyLkVG+jdt9rDc7h4V17MmcdZhH4teIzlDETKmJzD35nnlul5UYnJqNjTdA83lpUdwWsLEr36WwBbeZDqdNyLE1oGSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766408797; c=relaxed/simple;
	bh=v1t1naZGSzedzZUjuL1zdtf39V2v8+wzQD5LmHlpe4k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u/hqsjENm1JCs/tEUzpMRQQl44k5onFypAqLyH6ltHRXYRgaOpIb07DeSdmxl9iponuyLFCG5hmw6VitXm0gAgDExPoCDBGzOVvCfzoIiuOKciamZwU+q8ZOS4QDy78Kip8fsBHxQNiVMeSOaztLEFjXWvEktm86vpJ20Tercik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=qxsjRPdT; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="qxsjRPdT"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-34ccbf37205so2942210a91.2
        for <linux-serial@vger.kernel.org>; Mon, 22 Dec 2025 05:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1766408794; x=1767013594; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XgdTFHMTCMlAmy2Oru9A0Zg9E+ZEm3hyo7Svl62/2oA=;
        b=qxsjRPdTdA62kgMzfK2a3wdsGyf30OkjVj5yCxxU7Rb9H+nmksSKARShpf0TJPa5Yn
         0qsmTVBW/HWLYlmba/nyuyjyDvR3fvd7XLLkn2ob5z+teiCbiIFdGQIliUtj9Ak+z88J
         8JLjNwe1qCIrmB2t89pUKtjbDR6cEtKEolnWpxAwVBinvsgH1iZUKu7T5KKtkd0d8PL9
         wOkJjWSzV8eqIYxh+7ymgp3Uk6KHuFMggelvFq/eC9ITrQl/l0B5i5EERf5TcuRlGp4X
         rMhJ5FUAC17Cn5LEt38jNU66YXSJWtZUeg2s8XgxnaZBiPm7oFjv5br3uOuK2ET/m8r9
         4Xkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766408794; x=1767013594;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XgdTFHMTCMlAmy2Oru9A0Zg9E+ZEm3hyo7Svl62/2oA=;
        b=d80pm6cNB9x/3R3vB1UWle9+uWypKeTakWgvDMsMyGIq3ZpcyolHeFYnrmD0Evcc2b
         YBt9ei5Ctav7ITb64YLvRSzf+GMcqRKlKWG9EalGkqN6nFwsf/STNBMi0iZIRboRnKuc
         5Icr/dNTTaLUw3YzbfzJKXqsDKdZPpoIK9GQnjhTLZ2hIsTc7bnGzkwq9TfG0lcoN+x/
         U0W2sRd3DR00EQRx96EZFW1sEcfGFLuRgu1xhtOvy4B+DYMyVVnUtaHxL+8BzsZL9deq
         1Jukq19IFYu3H/HOYzQnwYh+J4wiGesviNZFhWzesWuR1Av3e4y1ls+M3PJDRQJ0nGhE
         srrw==
X-Forwarded-Encrypted: i=1; AJvYcCVQaiJ35xvpCaA77+EmJ0kv6iTckgGcY3NbjssF7bkh2lAJwlz2Y0ryvGjqX0/ivIdGstRb4hi5J7T5LbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCXcGhbgxXXWIk9xhwe0r25c63kOJj0X9DbKlpRAQf57AZD5fz
	+PaP5UeNqkh95yhIL8hFyKM9m1xjLtFa4lR22YiH/xEckRxtoJ8bzfF+qZA8tkpWLI0=
X-Gm-Gg: AY/fxX4kJzyzSRejKkk5Noyo2nhKK2nnwIougBjMj+O9c4lyzt4IrSJn2rUCOAE/EsS
	VD+uAyVKD+SekqGJ4J5OOv7VzYN6f6wN3lBYF/3Zl8YbA8AJ6eWiePoxKPTYI622IqGF+6F5VJJ
	of6vF92VFT5SmB3GkkYw0ft1l0iQH2z31A5qq8NKDECA3p0D+kQpuyZcuDa6xT418iP4UDzQ0HV
	eGWg/HfLVCJfAmXvvlLWuYFMAATXufnVg9X4PGR6wknZPLoLkzvDX55Wk1Da+LYjklR1e1+6/Ks
	5w7c+Bv0CxT/mMHSTk/eYzpFsgK3YtLynPgg1hqb0d9IUzCzkinOBgNIynDWiESM5Nodt4Gh7Bw
	NAXdvyqbG1g8qaLhTlH53S5tRpESJi67KjaAodyh0QJUrWfZ5zcQ2V95R0iuLW3PdKtoYjVVinE
	m/Jq0ojFsFtMhG0Bhb/nXPSZ3k5FdQqwiAaM4Nbq0qqw==
X-Google-Smtp-Source: AGHT+IHxNgi+B0C4X0RL24+gScZYcxvnEH5vGDKHG//0EVTSEFa006bU6P/YkBj5P6dINmSvw+3QjA==
X-Received: by 2002:a17:90b:1dc6:b0:33b:b020:5968 with SMTP id 98e67ed59e1d1-34e921be2a1mr9160833a91.21.1766408794105;
        Mon, 22 Dec 2025 05:06:34 -0800 (PST)
Received: from [127.0.1.1] ([2a12:a305:4::402f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70c932casm12970405a91.0.2025.12.22.05.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 05:06:33 -0800 (PST)
From: Guodong Xu <guodong@riscstar.com>
Date: Mon, 22 Dec 2025 21:04:12 +0800
Subject: [PATCH v2 02/13] dt-bindings: timer: add SpacemiT K3 CLINT
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-k3-basic-dt-v2-2-3af3f3cd0f8a@riscstar.com>
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

Add compatible string for SpacemiT K3 CLINT.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
v2: Add Conor's Acked-by.
---
 Documentation/devicetree/bindings/timer/sifive,clint.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
index 0d3b8dc362ba7e8d0ca6d0cea692ceddc5e1f89e..3bab40500df9bc2ba4f7d6f1bf340c8cbc06f9de 100644
--- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
+++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
@@ -33,6 +33,7 @@ properties:
               - eswin,eic7700-clint     # ESWIN EIC7700
               - sifive,fu540-c000-clint # SiFive FU540
               - spacemit,k1-clint       # SpacemiT K1
+              - spacemit,k3-clint       # SpacemiT K3
               - starfive,jh7100-clint   # StarFive JH7100
               - starfive,jh7110-clint   # StarFive JH7110
               - starfive,jh8100-clint   # StarFive JH8100

-- 
2.43.0

