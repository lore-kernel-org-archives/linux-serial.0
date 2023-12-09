Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g8vTi6dh"
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647A710CF
	for <linux-serial@vger.kernel.org>; Sat,  9 Dec 2023 15:31:27 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40c41b43e1eso4849115e9.1
        for <linux-serial@vger.kernel.org>; Sat, 09 Dec 2023 15:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702164685; x=1702769485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tt3DlYOqBPGr+XD4+wWN4xoyocT73U+x7ydkizkAcB4=;
        b=g8vTi6dh5gQup9SfuVi1pPA4LtvkLjwyBFHy2WqkG/POQMUZBvsyuyemWy9PTa7d1F
         Mt5Nt0imVSxj1IHkC07X1a8LE7iSHM/jFyf1/tv1mjdTCidXM3LaPG+kPTz1VcA1Xm66
         z+5JBdrbYZZ9vIlr6peJpUtPaj6r72kN8pKGmkHepZTSwV9q/uaqrNDXwoMLt0zlBnjh
         SXVxtmIv88Xj6kl1LCTHg6lGHg58PY0q+xvqtoZma0xudo0TRRLmuBe2vbuJgaVAzwe/
         sIFEXTiWGfyEkpeFg6lks7yEH6pG5Le5ek3mv3+w9fP6TBOFpDhNQpX8UeRUWmi9LJkj
         BUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702164686; x=1702769486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tt3DlYOqBPGr+XD4+wWN4xoyocT73U+x7ydkizkAcB4=;
        b=JNGAn6PsJLqRhv4F4uaJJ2uO5MhAB/WCwzbLpV41ypgJo/ObrMPCP3YFDJCjxgsuzn
         sMFzis1VXDWwXqPCv55v6wowvEX3A4aXSTSDlUJEH+wnEERCs2/eAyjdRy6T2bifG3/n
         jCqPOJzP1JAestY63D2lAcE7bOXE8Q7H8XW9iw1A83zi52i5w2rTT08O3QKpeD4EmD2H
         LNUMNJeR1CSlrBJufCT6Y8NTaIs0ouXbaeJKMpbtS291Xwzuv0RlNP6QuJ5qvK4AzeqV
         QFVGltF4DzEwGS/n7mM7IfCa+XMC04Glnzzr/Vvimc1FDsBDhiX3aRFNaeMMMrmrmPLV
         PsWw==
X-Gm-Message-State: AOJu0YzZeyQYfNdlwLT2sFDn/Go2quXoKtXI8AiA0xGfyDD9eOJPFcF3
	w9pfLI6d+oDc8Wf2fEsh+th6mQ==
X-Google-Smtp-Source: AGHT+IGkgpwIOfGM4IWpdQ1In82Ab7ZPQ56XNX8tTri5eYcb+c64uzqd1e7frG0PG/Xau38IP7+5sA==
X-Received: by 2002:a7b:ce10:0:b0:40c:2c5a:da with SMTP id m16-20020a7bce10000000b0040c2c5a00damr962602wmc.191.1702164685792;
        Sat, 09 Dec 2023 15:31:25 -0800 (PST)
Received: from gpeter-l.lan (host-92-23-61-173.as13285.net. [92.23.61.173])
        by smtp.gmail.com with ESMTPSA id n9-20020a05600c4f8900b0040c41846923sm1875277wmq.26.2023.12.09.15.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 15:31:25 -0800 (PST)
From: Peter Griffin <peter.griffin@linaro.org>
To: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	mturquette@baylibre.com,
	conor+dt@kernel.org,
	sboyd@kernel.org,
	tomasz.figa@gmail.com,
	s.nawrocki@samsung.com,
	linus.walleij@linaro.org,
	wim@linux-watchdog.org,
	linux@roeck-us.net,
	catalin.marinas@arm.com,
	will@kernel.org,
	arnd@arndb.de,
	olof@lixom.net,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	cw00.choi@samsung.com,
	alim.akhtar@samsung.com
Cc: peter.griffin@linaro.org,
	tudor.ambarus@linaro.org,
	andre.draszik@linaro.org,
	semen.protsenko@linaro.org,
	saravanak@google.com,
	willmcvicker@google.com,
	soc@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	kernel-team@android.com,
	linux-serial@vger.kernel.org
Subject: [PATCH v6 08/20] dt-bindings: serial: samsung: Add google-gs101-uart compatible
Date: Sat,  9 Dec 2023 23:30:54 +0000
Message-ID: <20231209233106.147416-9-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231209233106.147416-1-peter.griffin@linaro.org>
References: <20231209233106.147416-1-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add dedicated google-gs101-uart compatible to the dt-schema for
representing uart of the Google Tensor gs101 SoC.

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 Documentation/devicetree/bindings/serial/samsung_uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
index e32c1b462836..ccc3626779d9 100644
--- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
+++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
@@ -21,6 +21,7 @@ properties:
       - enum:
           - apple,s5l-uart
           - axis,artpec8-uart
+          - google,gs101-uart
           - samsung,s3c6400-uart
           - samsung,s5pv210-uart
           - samsung,exynos4210-uart
-- 
2.43.0.472.g3155946c3a-goog

