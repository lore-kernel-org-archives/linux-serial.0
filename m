Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549E43B7617
	for <linux-serial@vger.kernel.org>; Tue, 16 Dec 2025 13:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765891986; cv=none; b=CkH9+gd/z6FfLc7S67YNHaDHw2efVYv5GcfbNyUMx1MrAJGEQWRboa3jtvo6hWnDBXqV1LFFQJ5Ze0VBxr6twPEMeOdzD3l+79ewWbAF/wyqk3Y/DE8gawMXgYEFUmNXiSmdVo0wLnuRr8hXUAfllHNsDs8VsodTGNJsTeZZbfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765891986; c=relaxed/simple;
	bh=hMk7e9sDIbndU8jtxho9DAKUxyuGQV2QeCg6OF24fgw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e/XhvvmII0nZS91BC0cmJRGBH5J+KUozlgTL4zCmYWrfGSIneSEsTRqG/zj5YHVdEPZHH2+gw3G/ja/mIMcFC1lgrBzT0S262rWvOjG2If5ey0Y64WEPVFDfUkvdPPBkLZkoqG885SmzAgeVvFF3jEFKjrP4JnXwjXirJjrVNG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=NSr80pkA; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="NSr80pkA"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2a0833b5aeeso48809755ad.1
        for <linux-serial@vger.kernel.org>; Tue, 16 Dec 2025 05:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1765891984; x=1766496784; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vwieFoqD7GSHNJIXxDJ7bzO+eNbv0m3QCXE/uSRPY3I=;
        b=NSr80pkAcHh7TAS5rc2DOjOaZ69BMfXSgRw42fReKUwuJ8J9t61HmrPEtd8ADtJY37
         4h9mloUqscTsZvIzk3lK7JB/U1VK8V9mMI696M2XGt0xdrYUDg1rfrVcq06TjrMbtJq1
         Kr1QyaNnX5TBK0B7pqlKeW1JBmBGnEK7zgXNaKFEjWHbQzKw05wnstb0aTcGmRTt5rqg
         4foTz46NBT6wvB08V3H8SHIegFgh/bOZs2DX1I7uWJAPmIqM0cKDrm3GHb9foNIpslh4
         OHURkslMTTYxEYq2/DX4Yqb09nRy3gQY6KapRjb9p5GLHCLoFGalv+On5mnBxgISlidA
         6YoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765891984; x=1766496784;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vwieFoqD7GSHNJIXxDJ7bzO+eNbv0m3QCXE/uSRPY3I=;
        b=Xvejeoo90k5pVa0gyA9baOLbZpforIsZfzLjI7I6KqYVILadu75hctE2ZpBkk8MwqK
         BgEnHVFUWc0W4JwU3nUSNHhUKY0v3hjstmORzcZYa4BTIkjVkfx3lNi6mhRqT8zpVJ7O
         /kOLPMhlUGC+IxG0Yt5fw6LFV0VykEQ+VF5VVldj2a/lCJLSj4CqQetTKczqQTyNe3l4
         TXC8zJPnk5OAf2NtCo0fHBSWYvSJfD+6jUIZyPDidXvkk4IYKqhGN4BtksNTBcx09nDU
         3VuBaXIMPB72hZK/VFi2hqJ5Q8WZg4eHjvmOjQ2c2dYituJtUdbNHyW30ujSXRbEyVCz
         25kg==
X-Forwarded-Encrypted: i=1; AJvYcCXcz+Gh2zz0zXFXMisuCqSQqX9ENOOybH67GQJQ6c/QfcorT75n7o4ktzQgyxqRC5D0EYTDPyLpSr/swp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAiFxRt1F2G4NXC+b1WxBBPp8rRKslzjyoBT/JhfV781R106Hq
	byBBXX3SaGh9JDHMRUeUi5utzC7iatw9guq0ZGwErvNxpQsTsJCAzVIy5CMysEeUrxA=
X-Gm-Gg: AY/fxX4VHFkk9sykTETXu64fKpi5rY3TvxlQiiSyn4wtWt4RI8TP2sCI0G0z5Q4AlCa
	ch3LCbSnMor5II/De8NIh+AtcvKH/im2y+eVok45THmptNBLwmyEyKWn65IcUVN3/c4s1J+MV7H
	fIXGe4IQt/x3ivCK2dLFvSWjsriCq9JP3nVTph4VhD5FNbXvgCEu0I66M3/2HDwlVeBeH/h0urU
	umk3zzPWbksgIg3MEIifs4AmGQp8otyTQ+dmokXwBChdjLRga1kGshV0K9RYNCjHMcq0ATr0YwP
	WFlUXlGbDY/gnmVdRM8udDxih2vbt/o10GM3hN8OEqoZQ1UbkbKVEBkii1ICB2lxA8IwP3AfHXI
	r9w0yJID9rKYLc4i6nhLivERHwEtfIb0F4ZkPP4UdcHAiVTdh/IBcUUPF23BVlgRCpUt1WAOYgg
	O50XrligoHw2U9zIsEt5OvMwd1WFOShmo=
X-Google-Smtp-Source: AGHT+IGHe5/9SaW81jyDKkQ0OPmaYehcP7QMhJzz2ZDa3a+RaUWBBtXL3A4tMbxbrOk89EkkF+fCWQ==
X-Received: by 2002:a17:903:1a2b:b0:297:e3c4:b2b0 with SMTP id d9443c01a7336-29f244aa9e9mr153671045ad.54.1765891983667;
        Tue, 16 Dec 2025 05:33:03 -0800 (PST)
Received: from [127.0.1.1] ([2a12:a305:4::4029])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a14625add8sm15829525ad.61.2025.12.16.05.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 05:33:03 -0800 (PST)
From: Guodong Xu <guodong@riscstar.com>
Date: Tue, 16 Dec 2025 21:32:25 +0800
Subject: [PATCH 1/8] dt-bindings: riscv: add SpacemiT X100 CPU compatible
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251216-k3-basic-dt-v1-1-a0d256c9dc92@riscstar.com>
References: <20251216-k3-basic-dt-v1-0-a0d256c9dc92@riscstar.com>
In-Reply-To: <20251216-k3-basic-dt-v1-0-a0d256c9dc92@riscstar.com>
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
 Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Kevin Meng Zhang <zhangmeng.kevin@linux.spacemit.com>, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, spacemit@lists.linux.dev, 
 linux-serial@vger.kernel.org, Guodong Xu <guodong@riscstar.com>
X-Mailer: b4 0.14.2

Add compatible string for the SpacemiT X100 (RVA23 compliant) core.

Link: https://www.spacemit.com/en/spacemit-x100-core/

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index d733c0bd534fb63ed7c0eada97c42832431f1fc1..cce87092dc7749f49066154d9a256af6c7b6c19f 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -62,6 +62,7 @@ properties:
               - sifive,u74
               - sifive,u74-mc
               - spacemit,x60
+              - spacemit,x100
               - thead,c906
               - thead,c908
               - thead,c910

-- 
2.43.0

