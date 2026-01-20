Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B4F35B12B
	for <linux-serial@vger.kernel.org>; Tue, 20 Jan 2026 12:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768913561; cv=none; b=Nzc7GX4O6Cy1Tbd7+JwJ2NAKrac0BWBLz4pDkbgIktX7eIo4w2R13LFeEjLMWxRoVZCaNCpmYi5+IPLdI8a5zzo4PB8wTxKpzZ90n0Ka3WisU5+Rwa9J8dcM3/sC1jmGq95MmJHsUBJlbRtA9D4+jmh+HsZC7Nqu6QyWOZsHWog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768913561; c=relaxed/simple;
	bh=tKERO6SBJJqx3TRK7XGrvuoyFR1bVVvpi8MF7J8Ro6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bg+K3tJvbNQroHsuqKlEAaRZX4Mol351LV3NnF2CsHiWHVH8TD69Eg+PyPAaDV2lsv5GXVCT5cEeePh/UKgC8Z0FUuLeO88r6WSu1CmD++bs86lINMherKwkZaC+b8jFaHMbFt7oYgv7OGJpTBcjd8c+ppRGzml0waqH4mY5nJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SUuHvB//; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUuHvB//"
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-b7cf4a975d2so932429366b.2
        for <linux-serial@vger.kernel.org>; Tue, 20 Jan 2026 04:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768913556; x=1769518356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JSRKj6wmV+AKwbO+bGsCVB/saW4/0FVnBMzHhAa7IM4=;
        b=SUuHvB//U5azkJAptRBi2hNg6e0eHeJyvP3UiQRQCdhVfaKsGgVus6BVPV1UgwM7Mw
         PE9w4sCsRSZZoukS9P9xB3Fc7gXFOYgOESmanrCAGAH5RCp2Sa+EK28UGlnSvUWQR+Vk
         fRrqyj8eSdDK3lzOAZNgScmR8zftY4JRVp0QFrxJiy9k8PNMOXv8enCjtkOdtbvoGjNl
         5/R80L0WxxqpG3eKt8eAB0Sh8vyRX0236p7mDjsPmdlQ2tS2HSEWxn/FbXmU7sJHlNKi
         60IIEqvHh5V6vgZd3N5R2hXv4fZegWN8XU4uKoEgmDqgM9ktR6ipUSwgmCvY0wulK8eB
         KFpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768913556; x=1769518356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JSRKj6wmV+AKwbO+bGsCVB/saW4/0FVnBMzHhAa7IM4=;
        b=nqe6MFmtH7V7DmcAFUZ1tkAkZd9EeJAWQZA0z0tWHeT8caSOQ/CiFKa4TSTSA0wvrV
         QhtIR64RcAPo8NxH76VaNeYK35DQyR5iq3TBNrX1ADnroYONaz5jYn1dY2Z3CgOB/g2a
         zf/54d7sWOtypiHDcyVBiEXl28tZ3e6MV2XgFxBUNAil46qkzU2wBQaFM4Cvpv+zH6te
         5vs+iBC/F+wEtpZ1CBMW6O9uuwh2zWcSS23sxWhulQjfFkKrHKkv4+mwr8UdChd5lcih
         D6D5ueoTL9hf5ycjjRdrV2oAJiCOvVZt+MdYIM2dS0EeQkOU7KJTk1p50o8KIL2pIozh
         Y9nA==
X-Forwarded-Encrypted: i=1; AJvYcCWqs0VlDgqdgGvQKD9aPu0eaHiXEoBXKM3/Vn0n4m1myxVTJZDPSzFqikc1hjul0vsQFyo6KhKFUteTi/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXpoSy9A2BYS8g3vHDR+wE1aCtbUKfsqZHyENd+9Wn5m1Wx7O+
	gpFFG8yGwBa29EOe0nUT4+8qCFNjrAVbckIQaBWvFXJ/AuIFRMzCQQka
X-Gm-Gg: AZuq6aL2WCwGcek96Vzbr661CfqKLCQ6k1o1348ytPQA+qxMu5m/4vcfrq4vcx0BIO2
	TJGcHXAqBaO345f5ZNNjeWavkB0pXvs4k/iAmQ64BAACr5aWjlv+NYpG4/Uh5AfNFbMVOdswgQh
	P4xgWAWli3CPzCqu2lcbcAYaJVxuh9XuJyMmAvIdSty+xzzfHWVIIuEKCu0o9VtmgQsl6rso9+q
	vEzoRKRd9hq0qx0nikWDsJ11oFeed2wwDxtm1SRYz4yfhuPaJwx0TmOKP2e7sTDQMhtpIQdaeV8
	xEdXpBorQx5yL7BgXmOglRXByThRwcik3nMk8SnW53V78pAkknswIKozzekhe8QUVCmTYh5pNY1
	HXo7hpQ02nGDtagSI10FVvIeREuyweUyrg+mFYwrZbXsUVCaye7PlxDEtyFk0SFbVFJyF/90HGj
	kw5z8iEIMDtnwxL7V727uAtXYMGVCZU5v/pi0=
X-Received: by 2002:a17:907:a089:b0:b87:fad:442f with SMTP id a640c23a62f3a-b8800348bdamr159690166b.42.1768913555975;
        Tue, 20 Jan 2026 04:52:35 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:c8c7:2ef6:8ac5:5556])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b87959ca32esm1420626066b.41.2026.01.20.04.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 04:52:35 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH 01/12] dt-bindings: serial: renesas,scif: Document RZ/G3L SoC
Date: Tue, 20 Jan 2026 12:52:12 +0000
Message-ID: <20260120125232.349708-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260120125232.349708-1-biju.das.jz@bp.renesas.com>
References: <20260120125232.349708-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Add SCIF binding documentation for Renesas RZ/G3L SoC. SCIF block on the
RZ/G3L is identical to one found on the RZ/G3S SoC.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 Documentation/devicetree/bindings/serial/renesas,scif.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/renesas,scif.yaml b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
index a6ef02327be8..82f54446835e 100644
--- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
@@ -82,6 +82,7 @@ properties:
               - renesas,scif-r9a07g043      # RZ/G2UL and RZ/Five
               - renesas,scif-r9a07g054      # RZ/V2L
               - renesas,scif-r9a08g045      # RZ/G3S
+              - renesas,scif-r9a08g046      # RZ/G3L
           - const: renesas,scif-r9a07g044   # RZ/G2{L,LC} fallback
 
       - items:
-- 
2.43.0

