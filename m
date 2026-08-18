Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6284570FD
	for <linux-serial@vger.kernel.org>; Tue, 18 Aug 2026 10:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787049114; cv=none; b=K+nZIP9wB9Ve04Hm/3Ncx+eLfCkBOpsorwN3ypJTvhqosTcJk+mkdkIWoVs9ev3L8+FiXyejxRk5bgUBAoY4dLnsGl9AqK0afSo1zVXkXc36jzM5APQCyjFS5I1/PN1XC/IIJ9U3YNeS75sojs6WARTBzx7PdPma7kXXAnXrqYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787049114; c=relaxed/simple;
	bh=vfIcMF/D8wcsUdtVGgWk0Xhn25+5CnrW+64Wkzh62KE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OepXOcN55LBwNJ0DdgDPmAobLcV+FD+wLhnQaQVLGhARTblTuX3XNXY76lIvuCy7vinowS/G0gkuCNu4onlK9oYoAnBhDjNuuqSQDRJT3H3b+yY4JOC5SM9vFY+IJ80NExLPsc7BE7YXZ8uf47fDwjEt3CFCeRgqXcuYE+Tag0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=EtUXPzjt; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="EtUXPzjt"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49556f97a9dso31358755e9.1
        for <linux-serial@vger.kernel.org>; Tue, 18 Aug 2026 03:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1787049111; x=1787653911; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0US0ozN7L3SAjOKyepRf84tawF861oB4+zMdDmmleEw=;
        b=EtUXPzjtwE1VDazadATcDYmnLRL4zgYOA6wqGR5ckhuJCyJXTnK2/vQvImgK80j5OQ
         ZGUfohTyrfFGeApzUYgc1npPihJzjBdq9jKQgkgG1Kqofw7aqnjhOO+iu+19vbegIhSN
         I+ujT0lOKH0uU2A/BscDieZrKB4FLeruhWUbjLrh4K24jJ5BbMnAtRZeDyYaNQ1WClWU
         g4IFyF+wF5it/RgcPc0HmNV1ELRclikKOIcgV4TODpAL0Drt7HneeThA79qLDdRQiCcd
         p/Eno0UEblQsw9VQ1iCswDs7qKIAcZWNu/TRw1R1GZKcoLtSihZ4lrTzwNhfrc2AmcsL
         Z3Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787049111; x=1787653911;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0US0ozN7L3SAjOKyepRf84tawF861oB4+zMdDmmleEw=;
        b=PYPRzbwtaLIUXU9ybGBEKKilUFxwroGTnxYR2f2bS1+v5KWjZWLzpICiH5pSwxTnsI
         xuTvqZY0TEC5RGSBV2fJGXYBbxNHVjCLThx6/UsGRPPtcoWA6UO8YSZsaIufLvlehPlX
         GJu2nSf24hp/5KgEi3Gf3hT+AsrwM0zo6jCPCzuDaJ73VfkJ2G/o/Ko+Icx6EOXvcHnh
         BqKRa3cFIGJ0AYsef5Exw+U42r+qhGhd8V7Tiwe8lMpfCijoqoQ4aiWIeUmU+h3qNMzC
         r8NmpsxNNs8NPGK0P58O00cU5QofzhJrXUcGHOp+9kDGCtA+KyQW2nUf6YW4LE+tZLVH
         JQ6g==
X-Forwarded-Encrypted: i=1; AHgh+Rq06kOsmJz2m/5mT8Qln4ZaicYaKpmnptQ5IW9RO5LxUMO4OyBh1Fe0FNmHrPtPVm6XoMBI9dMHgxqSAPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU9+RnvAuY5gCODPVd+5eaElRFJ3MoFl+HuUfVdA2RXYWU79Kd
	D78n7SlhRZ90K040oT0SggZCE7GdmYEP4Q7jlh68r+32+W7IGW6iN1cjzv7i806SDwo=
X-Gm-Gg: AR+sD11F/jfRaTZTcRx/V8rGsVPkRK/ggfDaCN9040mpMd3z2HxMzskSETkQOYi+1rb
	Ji+rUehZxhh4Zidgcoe8JSn/ygbkuO+ts/gtnup3edhyAWkxscyqLo2V6lAeaoqzRoqG6zGuSB9
	gdJKs9pYEYUBy2JBXotaWg94uL5ZLICwY+hVlwG7COjGEgRVhrj9kN16flY63QMGrveYHfDvTX6
	D6clJXko9UP09KeRU+xNzMdv2GjUXJEOd0THRdf8k3eD0KeOpKI8zPLIL9rOZXonPl/YcgQRXTo
	vq2TkVPoAlEbgIo9Sbr47Skyb5peazeteGdpEmIfiYffWiwy36li+kClgBdjJ/tNRaJtfN0cQ2Y
	5DucuGzbNBDWofxVcK4bokI+wS2e5O1qSv4kMON5n/aIiI/xpEe9xJOniXFKEai91JAKJmpmNXb
	VmwGr0cS4anXOoTukyhZohKIdPoO6Jq4LEmm0gfQT90cJLfzJpVQD69RiyDBgl2VuqVP2PK7iLu
	hOVFCdmAGTLLm0oCMzREmrxNfKTS+/2iSSzckiNsRWwJRxbEN/Z+FeS1hHN
X-Received: by 2002:a05:600c:1d27:b0:493:e451:a9e1 with SMTP id 5b1f17b1804b1-4999fae4e89mr107830385e9.2.1787049110979;
        Tue, 18 Aug 2026 03:31:50 -0700 (PDT)
Received: from [127.0.0.2] ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499960988c6sm246025575e9.0.2026.08.18.03.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 03:31:50 -0700 (PDT)
From: =?utf-8?q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>
Date: Tue, 18 Aug 2026 10:29:18 +0000
Subject: [PATCH v6 5/6] ARM: dts: aspeed: g6: Change vuart compatible
 string for ast2600
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260818-aspeed-driver-v6-v6-5-fd7cc0b338ea@9elements.com>
References: <20260818-aspeed-driver-v6-v6-0-fd7cc0b338ea@9elements.com>
In-Reply-To: <20260818-aspeed-driver-v6-v6-0-fd7cc0b338ea@9elements.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>, 
 devicetree@vger.kernel.org, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Lee Jones <lee@kernel.org>, 
 =?utf-8?q?Gr=C3=A9goire_Layet?= <git@gregoirelayet.com>, 
 Tan Siewert <tan.siewert@9elements.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 mfd@lists.linux.dev, andrew@lunn.ch, jacky_chou@aspeedtech.com, 
 yh_chung@aspeedtech.com, ninad@linux.ibm.com, anirudhsriniv@gmail.com, 
 =?utf-8?q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>
X-Mailer: b4 0.15.2

Use the ast2600 compatible string.
Make it more precise and enable specific ast2600 properties.
Still use the ast2500 compatible string as a fallback.

Reviewed-by: Tan Siewert <tan.siewert@9elements.com>
Signed-off-by: Grégoire Layet <gregoire.layet@9elements.com>
---
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index edf4b74f5aba..c952e2075b4c 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -707,7 +707,7 @@ emmc: sdhci@1e750100 {
 			};
 
 			vuart1: serial@1e787000 {
-				compatible = "aspeed,ast2500-vuart";
+				compatible = "aspeed,ast2600-vuart", "aspeed,ast2500-vuart";
 				reg = <0x1e787000 0x40>;
 				reg-shift = <2>;
 				interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
@@ -717,7 +717,7 @@ vuart1: serial@1e787000 {
 			};
 
 			vuart3: serial@1e787800 {
-				compatible = "aspeed,ast2500-vuart";
+				compatible = "aspeed,ast2600-vuart", "aspeed,ast2500-vuart";
 				reg = <0x1e787800 0x40>;
 				reg-shift = <2>;
 				interrupts = <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>;
@@ -727,7 +727,7 @@ vuart3: serial@1e787800 {
 			};
 
 			vuart2: serial@1e788000 {
-				compatible = "aspeed,ast2500-vuart";
+				compatible = "aspeed,ast2600-vuart", "aspeed,ast2500-vuart";
 				reg = <0x1e788000 0x40>;
 				reg-shift = <2>;
 				interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
@@ -737,7 +737,7 @@ vuart2: serial@1e788000 {
 			};
 
 			vuart4: serial@1e788800 {
-				compatible = "aspeed,ast2500-vuart";
+				compatible = "aspeed,ast2600-vuart", "aspeed,ast2500-vuart";
 				reg = <0x1e788800 0x40>;
 				reg-shift = <2>;
 				interrupts = <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>;

-- 
2.54.0

