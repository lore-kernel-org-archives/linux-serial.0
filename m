Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795649478;
	b=3UTfUAFnC9t2YFSYXs7EJwRKewJIZVkA0wxXyO/6ebDO4DFFF4XnL3sSqHONN4xvEzqN
	 zJ3T7wOzrmkWByH8NgSVMot2WGRoAo5d+NYgS68ohb7EVXXkPODJsleyKnaccmXO0uvk4
	 cD4PIwfKMYiS+997pxXOfy8NJ/KXR91q0jyIDDrBHvlqOAAv6d6GSaG7P1yDQXYYL5QRh
	 5XQY/vJJwxP2ssrREx5Ru6iXNLAL7nN2hTB0Q8PlbH6rK3YchOG6rALG2mgOc2GEiNNcQ
	 myx2IGaVdDoEiiZ1vGDw3DfCEKRQAztOfhE/gvqdEKDeCP3914NydrRO9MyHlC8P/5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795649478;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=9We/x/kFtavsjCZuqwAHil7LDT45RYjQGWVveqfhXeM=;
	b=Z300agFsk0bM+FpX803qskjLzLHXZsccribo2jJoNG4aciQEATeUjnq7etI6tnUeI4JM
	 lm5l9RbKG4kHfG4xD/CUkYqnF89J7XZEAdF82d87ncUy4SfFhccHCyxXs0AOg44k0h3EA
	 jvGiYRoUX2mHzkbxNF5KnMUEeQ9r1+j8TjPk470uUsARgMeJq1i8+CGbfGq6fM7Vwo7We
	 6aFHDoXzRTTNTqjA+eTS2DzFHxW8YzmApf8IqL2KD8XB1OyYh0LulP61PMfnHWIPopPZB
	 Yh7aVo8lVOM19eaWRozGx9gSvgCMhewYAIKXFsHCEReDn1zA/QQwZQhga3DKKiu7kNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xKlyKc7+;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11DD606A32C
	for <linux-serial@vger.kernel.org>; Wed, 25 Nov 2026 23:31:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F11DD606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xKlyKc7+
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4bb70074ab2so68358455e9.0
        for <linux-serial@vger.kernel.org>; Wed, 25 Nov 2026 15:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795649476; x=1796254276; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9We/x/kFtavsjCZuqwAHil7LDT45RYjQGWVveqfhXeM=;
        b=xKlyKc7+DA/Gf8K7PbnxNgL9otqdu9NBuqKjIMuC+eKAToV5EA5k+wBTtFX27DSMGh
         x3xiT+NHDGEorXMZHmS7kH5z+vwQJEzOk58ANkMGoGZYX9R+RtqiqMJxytw5R0+/gCbr
         wu1VK5rC+mmr2acaBYictwCrCRK7TBZH38gEYfsnYCDEJuQFksepcc3xQNP4YNKAZASe
         CEoqeNyXrW/odj+KpBHG72dY4PE+DlCWzNadyx8EJ3pZisrxEtG09M0AKI+fG4JYA+yx
         FwcgdaPnC41cmaXhI9wB/GGqS0w9WtaJ3ZYY4BC2j/mtIadv0L8EFYhq/F3ALoAAXbxA
         P/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795649476; x=1796254276;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9We/x/kFtavsjCZuqwAHil7LDT45RYjQGWVveqfhXeM=;
        b=j9rpCIHAhWQ+bN7vbDBhAR6h/z40kWLgOeB0U41LxwR5MWSdwo8HBbDkd5wpSo3jV4
         fJ3LQfrBIfivi85K8zM7qvMEY3/hir5EgAILGHE7KB6L5dhfRM7P/Q9WsyVEUDRNpecA
         Rmh8CTS1MF7x0+7Pl1F7+D6HhyTv7YoaTZd0/Gs8hsvj3VpFAZ7g6ydzVR+UQN8UqiRH
         rvreChxFs1TlEgod/J5+iY4T0hB8eKB6aqN2efrjg5s4g+3n4r47K0na7jNnDIzAcF4/
         IiQ2vPRo5k5ri2TQSpZjUzDYOwjYNWMyP2MT9qbHrLL9LPAod98ey/NKKWT2IWlxHW1v
         +8Bg==
X-Forwarded-Encrypted: i=1; AL+hErGeNpZ2QPZ0GS50+g+nTrHwEZrbOqsGP+t/rgGH2UgYOkliveZD5cGXS673TcH9DBjcLWU/JIX8KXQp1a8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ESXsafllv2QND4Y19b7minr5Kt3+KWuuZB5YpnxmOPv3btfyY
	wDo4Pnx6J3eXvMbGT4agpmy5+YFCpQkBsU2j/Q4lZfaXLluHHsoVginW
X-Gm-Gg: AZFdTZeMr22F97wqVY5YCDMFsZDzGW/Je8OXcreNx1AzN3yPTXXJWrOEyEJAM2RbFu/
	AxSgFWeScPoDOruId+v84PCl7NXLUE1rSExVrhSJXvM9JhII2vvGNztif0EZHIR1ZOBkMa9gSXx
	8oDrjs0LDz90bVXRBlG2isg4+Y6+BgovRvQuzLVM1S6mMuFtMgvsXQqbAZtMVnsuf361O7d4JJ+
	oBG60EoeXCa8rAFObRp27h4VqPjFhGJ6+ljdLWjSRi2/uRHJ6xtlnyMb02Z4A04OP9EAp5rvBeq
	twMwN0Zirbd1525WLQC8TLQk87YFQ22eiJwCoiJ947f0T+MoCWPjscBX84ZCxK8JA0G99hXZvH4
	P2xISWbT7bm+xRFoE1W5Q8al5osljBrqL1MOSVNPQG2HLr9eYY1kZSmTaSpW5v171nYOcX2GDE/
	kEkKvHdqQizdeoMNWBbwiAzVF2aqyr+oaihbrALkCXtwoB+mVlIqyNlubfpZD6LKi7tv72L0mYZ
	TMvjSGXFjsFlwwR6IO4RFR8FuS70NAe+URyjfUUSyFKuHlxlrrrOGOijYZz1C2lTeFZzUlb0sS9
	3KSD7G9cF8/O7ISGO27ASSazAmlsBHZvWJmXeIvw1L7Oy3BGjj4RXIalV1bPsldgL57D6H7x5s7
	aSw6ki55qQA==
X-Received: by 2002:a05:600c:638e:b0:4bb:6c5e:b006 with SMTP id 5b1f17b1804b1-4bb887e265fmr363197555e9.3.1795649476302;
        Wed, 25 Nov 2026 15:31:16 -0800 (PST)
Received: from localhost (bl20-90-91.dsl.telepac.pt. [2.81.90.91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb90660cb4sm506528425e9.2.2026.11.25.15.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 15:31:16 -0800 (PST)
From: =?UTF-8?q?V=C3=ADtor=20Hugo=20Silva?= <vitorhg20080@gmail.com>
To: linux-riscv@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org
Subject: [PATCH RFC 09/19] dt-bindings: serial: Add Espressif ESP32-P4 UART
Date: Wed, 25 Nov 2026 23:30:10 +0000
Message-ID: <20261125233020.1380594-10-vitorhg20080@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261125233020.1380594-1-vitorhg20080@gmail.com>
References: <20261125233020.1380594-1-vitorhg20080@gmail.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Document the ESP32-P4 UART compatible using the existing binding
properties for the register range, interrupt and input clock.

AI assisted with drafting the binding.

Signed-off-by: Vítor Hugo Silva <vitorhg20080@gmail.com>
---
 Documentation/devicetree/bindings/serial/esp,esp32-uart.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/esp,esp32-uart.yaml b/Documentation/devicetree/bindings/serial/esp,esp32-uart.yaml
index 2a80ca997a0c..bf141db5e2e5 100644
--- a/Documentation/devicetree/bindings/serial/esp,esp32-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/esp,esp32-uart.yaml
@@ -13,7 +13,8 @@ maintainers:
 description:
   ESP32 UART controller is a part of the ESP32 SoC.
   ESP32S3 UART controller is a part of the ESP32S3 SoC.
-  Both SoCs are produced by Espressif Systems Co. Ltd.
+  ESP32-P4 UART controller is a part of the ESP32-P4 SoC.
+  These SoCs are produced by Espressif Systems Co. Ltd.
 
 allOf:
   - $ref: serial.yaml#
@@ -22,6 +23,7 @@ properties:
   compatible:
     enum:
       - esp,esp32-uart
+      - esp,esp32p4-uart
       - esp,esp32s3-uart
 
   reg:
-- 
2.56.1

