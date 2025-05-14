Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1F827933F
	for <linux-serial@vger.kernel.org>; Wed, 14 May 2025 12:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747227110; cv=none; b=GkrxYbTu7CXYk0zd9X/GnvL+RzTSIHMhBTKhG1LZ+is+f0Rpg0KH25VXOmaatW018vZoc6cPeOm6lcwOJhcOlO3QMdMI7rwQg7tfT6gvZZJMTuSbjuyooBpklW/UoLsxO8k+jbdkt6/lTFWIJl4byg8ziWVvXI5SwjJGgJa8540=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747227110; c=relaxed/simple;
	bh=qFzqK2fj1HCSeZvxxjuZEOJdMePJq2O0RxP7hWzNXos=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u+ndsSZzU6OBE/mHIEo+6JSxXIu6h7HEHDO9TUIUuggr2e0MTHMWYFmQIsSG8W/JLb+s1XJiN9lOL2SKcRICioUB/h5CxsrkbOf7pYcZy2OK6GLLPmvuuQlVMC3Ev7KR6QseQ7kl6u8YZucPLQNw2Xc2+4IsaIjp6dPTlWr6hKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bdc6/miz; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bdc6/miz"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-442f4d40152so529755e9.2
        for <linux-serial@vger.kernel.org>; Wed, 14 May 2025 05:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747227106; x=1747831906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G96WwZNOynjvqyGyKipx2eszkDBgYS84tw9/9TdkKxc=;
        b=bdc6/miz6LnbAOtDGMp+rti5xxxoYPUuocP4rtE7bDSXtGhFLC/DUGI23z6lPi+W7s
         IsElHn9MwESvX902ThEHbm6ClzVuvzA8RwhYYmVW9qG5I5uKmThRSLmHx3HeKwhLBhSS
         gjodoRR+31kPoTzK8CLASlHwBqf2MTrecPUeEq4ppHKQwXZDOjbOF2A+vbL8yqhHVp+x
         3OQlquL6JuEvlMpw0Ruo4Y+OY0BSM7oeIdvJ+4AQu1i/u2qU/AAczMvLnNUy0UW017F7
         7sCFleQR67cSXRX+0WIXvWJe6JXwMTqNKfrF1+62Gjjfv91+YP5qFo9SG0yC+k/NMGcn
         Ij3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747227106; x=1747831906;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G96WwZNOynjvqyGyKipx2eszkDBgYS84tw9/9TdkKxc=;
        b=SI74NeE6/jTBjUf5FWFybpVVF80Zw5l1Uq9vrDHUDYoAQecTz4q6GOtXBe8/7XHIJg
         CIebeo8A+zpFFEtPtz9jexd75V/hrFXZ0ar/84wQiO5VzaxgRzQbkdfHXk0seV1hiae3
         HWEXEtLt2ouEZEJFy2uP+LY3M7C1cZAr75OSxjmI+K/aslAFU+wshPjk3DRtHiSsKXVa
         5l9sZTO/p2L3XOkJEhH9waApH2puOr/GPU9FyvucRiSUx77V6IMjtya0jqv/JwN7DVFw
         oKCgyUoSdsAikzqU7nvQMj+HNHrbnlw4YWt1qZ3lGnqtK5Jio6ujFteDfHqlC6xR+N15
         xjUA==
X-Forwarded-Encrypted: i=1; AJvYcCUV7g8LK8tOOWLeB03qeDqyKwffICpOEzEkyQXSiu7NNdMACI/nLFDpJybVY9moBak7Az4bEIpuqdN+ogo=@vger.kernel.org
X-Gm-Message-State: AOJu0YycWcAx9OBVuftuvoje3jeXbvXH46G0S9SvhF3m5MUA9/XRjN0C
	8Ka2qP5fEET1cKEAbyOS8IUJOW2GO1/9ilGc1ju/h4umKw4KPs+9DoQSKoT+eVM=
X-Gm-Gg: ASbGncup6CV9ca+0fN/dN2ZVGFMP/mF13fVsVOfWq/rYthMqdV0/aHJ9kgr7QH5f1qA
	ARW+VZ4U2i9lxMmQ/qLeK7vWK98CFKcs0MpkIDyLlmozMuxfFguE+MvjEwxjwwUqKmMRmVH3ZLb
	eh4YC8GUt+zxKek8ywolNopckK9RYVogW/P8u4aZp9YxlziY5sFs1DRIT+ugbM7zDaQczmEU51m
	oVjTbA0YATUlJXh4qIS+qeGiRlavZn3csMXpUSZBEt49zub+lytMVMUqfTBvW4a9oz1Xou/Yg2y
	TL0iACuOzl7jrIltdEsaXVdRYl7dHJrPve8fb9GATX+HmjWXQ4fZtsW+HDZeHKBNwSrJydtevdL
	7lW4lmYadJtkAx5y5JTv4xakPSzwBaBFznxmKgKw=
X-Google-Smtp-Source: AGHT+IFZIaPFeS+MCIGc/n0k7HQIiRGAtaHoEjEST/i2knk0UNX+vPMn1mIz7kEQxw5X9yopq23eiQ==
X-Received: by 2002:a05:6000:40ce:b0:3a0:6c12:237e with SMTP id ffacd0b85a97d-3a349966539mr949736f8f.16.1747227105716;
        Wed, 14 May 2025 05:51:45 -0700 (PDT)
Received: from kuoka.c.hoisthospitality.com (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a22ea7a53asm7745942f8f.23.2025.05.14.05.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 05:51:45 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: serial: 8250_omap: Drop redundant properties
Date: Wed, 14 May 2025 14:51:28 +0200
Message-ID: <20250514125127.56149-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1088; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=qFzqK2fj1HCSeZvxxjuZEOJdMePJq2O0RxP7hWzNXos=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoJJHPtqHSU1Qk8BxXvilLaKyVFgAjZk+a0lzio
 oXCt1bupleJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaCSRzwAKCRDBN2bmhouD
 14RpD/9BzBk88TJILONuQMPpVKrbk05NXBDJsbdZ0Q1iJwNlspfgM7/gV2ey6liewYj6+SzZ6Jq
 4xRE3jSOzfCWksHPpevKlQF5LBTCORR9nl+NER6hX4Rc/7u+7nSO43SSNp7O0hoAP1De6n0I9LY
 Zw81y/qGJ1dpGf42tTnx/GyyE1F1j2g4hxlGLI3+1UvJr093vBMLqX6Bw2KaCyTzlJQkuOngtjr
 3JsASV2TEnkDOCq/PkiYqDJi64KukEhbTW0rP0oLKLBUQNM2OuAL92gJ86E4XubIi3/iMKbwt7H
 v4lk4TBgbqs4JtY9luz6A/qwPHkmus+XgZXiqxC6kasPea3zp+FHrsousGJyVIcvZHd7eS37GEs
 HWfI7PlDvef6/RKUtuQfKCWupFkU1KZRsFoYqJTRYfniKwRCL4JJ0L1jHwsdsoIdPHoDhctieNq
 KqBffAUvwZlKSBJ8WCo2PHNwIGGzZxllwKvLpXLTzTsY/5Ayx31E52AW33whTFdXbdV+YU8XFZq
 G10Y0InpyOMrs0F3kERufANk6nvXozHSfCcAg8rbMmNMkjVgnovc3hUATZiOlkjaYivuaW+/iPV
 84vqTRU3nSqyDuAt3dHJ1pHMG5AoZxhFymXWYo5m2iXob4xB21Ra18+VRnfQmg6uTA6F9QZmQ+R t3E5quDi45zWwZA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

The binding references in-kernel serial.yaml, so there is no need to
explicitly list its properties.  Note that rts-gpio is also redundant
because DTS should be simply converted to -gpios variants.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

There are two cases of 'rts-gpio' which I will fix in separate patchset.
---
 Documentation/devicetree/bindings/serial/8250_omap.yaml | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/8250_omap.yaml b/Documentation/devicetree/bindings/serial/8250_omap.yaml
index 4b78de6b46a2..1859f71297ff 100644
--- a/Documentation/devicetree/bindings/serial/8250_omap.yaml
+++ b/Documentation/devicetree/bindings/serial/8250_omap.yaml
@@ -64,14 +64,7 @@ properties:
   clock-names:
     const: fclk
 
-  rts-gpios: true
-  cts-gpios: true
-  dtr-gpios: true
-  dsr-gpios: true
-  rng-gpios: true
-  dcd-gpios: true
   rs485-rts-active-high: true
-  rts-gpio: true
   power-domains: true
   clock-frequency: true
   current-speed: true
-- 
2.45.2

