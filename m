Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D5479F1
	for <linux-serial@vger.kernel.org>; Thu, 28 Dec 2023 12:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G0/1yfhW"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40d41555f9dso62028335e9.2
        for <linux-serial@vger.kernel.org>; Thu, 28 Dec 2023 04:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703768293; x=1704373093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qARtnmQgOAQf1WGszfbQmrcKdGUB3d5pXOUSqwXI61U=;
        b=G0/1yfhW9D3Z1ZtHw4UFkCpHq+Xf2Kapzg89rb5JH7GtJInJGDgvN0Kt3Q70j8Camy
         J63mDFCEOQYsolP+0ah4ureSW/mHmdLlnGoSaQYff8vIwj6QI65lKxxXBbNS2kJ9tPOb
         aFi9ZZzipXHgG/B8pyH1pzPMBBIjdRNzuGXM1ZquvkV5JWV1fPcBOjSPb0HCGoWkYNc1
         d+yzwByiqB9e1CixYjm4XOyQQ7rW4ol+Vsw/Y1yv1sWpJXSBmPpdwjVGinaQ5+jNXuDs
         P23t8qSOyZ16nw+FdH75DNOkPruM+70gQSMTWsvUo0aMyLgWVqhIMlerNsNUe5HTt+Zg
         vAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703768293; x=1704373093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qARtnmQgOAQf1WGszfbQmrcKdGUB3d5pXOUSqwXI61U=;
        b=UXPPF/4dWf+xImeaO3+q7xFPdwf4PoqbvVDvPVh0MxI8CRwtxo00k71q4GKNyAsNIf
         sjK9MPk0D8xGyATM7ITpLO82HrSGYsUXVDbCC/bL7vmemgYBY6Uv7tHODr+x7Uw4Azi4
         HFMEbS8tJRVkhZOHRnYCt6moZvzt+gYuRRX+3A39rn/NIsec53+qbg7tZZ1MPEge5Sy2
         RjaDyOApOYLVb/TkxoJ3vfsPwMfOy/gTMa1JhVHNNTcPaOQiM+Sk9gvR8D0dwpzEcMwA
         vsww+jEpHZZLGaGNatX0kPxZt0UXfTAiQmgA8MjOlmwPQNJm7bWEfwCyXAWyYVJw66sr
         KBrw==
X-Gm-Message-State: AOJu0YzJQvF7wzpvRBdSMP/V0g0K1aHCA5VmWTA+zpwRFpn7D4qPHiLw
	/EQ0kWu/I3JIGNjMbomebCm52VzNJDYClw==
X-Google-Smtp-Source: AGHT+IHT57QGYw7zLPX8R3bhMUgX3eDW1EDvo5Oc9TXgPSM2ZkHfeK0hm8E/vlZ6afNi/TT87YNVsA==
X-Received: by 2002:a05:600c:33aa:b0:40d:3a34:82ef with SMTP id o42-20020a05600c33aa00b0040d3a3482efmr5244462wmp.136.1703768293249;
        Thu, 28 Dec 2023 04:58:13 -0800 (PST)
Received: from ta2.c.googlers.com.com (216.131.76.34.bc.googleusercontent.com. [34.76.131.216])
        by smtp.gmail.com with ESMTPSA id h9-20020a05600c350900b0040d5aca25f1sm8615807wmq.17.2023.12.28.04.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 04:58:12 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: peter.griffin@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	conor+dt@kernel.org,
	andi.shyti@kernel.org,
	alim.akhtar@samsung.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	s.nawrocki@samsung.com,
	tomasz.figa@gmail.com,
	cw00.choi@samsung.com,
	arnd@arndb.de,
	semen.protsenko@linaro.org
Cc: andre.draszik@linaro.org,
	saravanak@google.com,
	willmcvicker@google.com,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-serial@vger.kernel.org,
	kernel-team@android.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 03/12] dt-bindings: serial: samsung: do not allow reg-io-width for gs101
Date: Thu, 28 Dec 2023 12:57:56 +0000
Message-ID: <20231228125805.661725-4-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231228125805.661725-1-tudor.ambarus@linaro.org>
References: <20231228125805.661725-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All gs101 serial ports are restricted to 32-bit register accesses.
This requirement will be inferred from the compatible. Do not allow
the reg-io-width property for the google,gs101-uart compatible.

Suggested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
v2: new patch

 Documentation/devicetree/bindings/serial/samsung_uart.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
index 133259ed3a34..0f0131026911 100644
--- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
+++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
@@ -143,6 +143,8 @@ allOf:
     then:
       required:
         - samsung,uart-fifosize
+      properties:
+        reg-io-width: false
 
 unevaluatedProperties: false
 
-- 
2.43.0.472.g3155946c3a-goog

