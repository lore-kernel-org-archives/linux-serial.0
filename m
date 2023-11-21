Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NuRnY3qE"
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90FA512C;
	Tue, 21 Nov 2023 04:13:40 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-507e85ebf50so7145080e87.1;
        Tue, 21 Nov 2023 04:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700568819; x=1701173619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FT8P0ptxDfFA1jaqoqoVmTf0vYme8WIJol1hbSEtpiE=;
        b=NuRnY3qExKGoYLEXU3eCO9AmnYTKtI8AdW2SmNkq1I3FMBLboDdTivqFCzBcrG0Iml
         fyDnqZp1mh2KuEHWTqe9h4q0MndLBeOsMkRwnvyBMh7a2V1HWjd+dnkLTUkPQkHw+q3i
         qcb1qs4+DbB8bDu6m3RGE28GzXPaXgA4ynYuygv09mqnZl/EwgdwYTRTaDOidcq1MNDA
         Daxkhb1TgaiYUgCIQRT0Ym4ePYEQGv1/YZm6BznaoBbG/gYHZNlyGrZyZfCikpHXD8Hl
         I9F644UR+jpi3xa/re+wTvHwY8youVQ6/5500uQ8RYzmhllsLq5cyGANmB/gCEKdBFCd
         YudA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700568819; x=1701173619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FT8P0ptxDfFA1jaqoqoVmTf0vYme8WIJol1hbSEtpiE=;
        b=eciPyrr+2rICO8dCs2R0vjq8FHBEaOtDJMwC8QwqpYK/Ys0027OHT8ld818tWYM0ie
         fzuccnWdC76aRLbPIdDi6MBAdrqwy0q/4NJJFWlkz9iZaloFOGihcHS4rMaRS3Nqr8gu
         dDeQnEzCUBGmpnRP7gvrSdRXnMeeVB1ayJiGGoX89aP/KwuQG9kd964dZk9UxGTAz1D1
         sL7txMsmMf6ca4JKocqq/BhWunRgi1ZfRGZIBqmhmYdgTw9B/VS77Z6CjgrMXyOAKPcl
         qoKHdj0DUHvA8qLn7LUO5kboiUoJ0II10JVHpBInOnWkOkKyICzHHRwEwmFIpa92mgAW
         JkCQ==
X-Gm-Message-State: AOJu0YyoRfMqW976HNEI0eW4csDSY7LXidxSh2/ZZAY4UKlhgi9Ky6EN
	dTDSxB0H1/XVw22jzfP84sA=
X-Google-Smtp-Source: AGHT+IGRDGRpooWpfMTQfoTFHeYEvbQA1dlXkU0dBS0AycHYD6Z7QkCqkv/RETvybZmXh2sZ46ttAA==
X-Received: by 2002:ac2:5316:0:b0:50a:6fbe:fec4 with SMTP id c22-20020ac25316000000b0050a6fbefec4mr7464318lfh.33.1700568818526;
        Tue, 21 Nov 2023 04:13:38 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id z15-20020ac2418f000000b005079ff02b36sm1491509lfh.131.2023.11.21.04.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 04:13:38 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	William Zhang <william.zhang@broadcom.com>,
	Anand Gore <anand.gore@broadcom.com>,
	Kursad Oney <kursad.oney@broadcom.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andre Przywara <andre.przywara@arm.com>,
	Alexandre TORGUE <alexandre.torgue@st.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	bcm-kernel-feedback-list@broadcom.com,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 2/2] ARM: dts: broadcom: Add BCM63138's high speed UART
Date: Tue, 21 Nov 2023 13:13:24 +0100
Message-Id: <20231121121324.23268-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231121121324.23268-1-zajec5@gmail.com>
References: <20231121121324.23268-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

It's designed for hardwiring Bluetooth devices to it.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 arch/arm/boot/dts/broadcom/bcm63138.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/broadcom/bcm63138.dtsi b/arch/arm/boot/dts/broadcom/bcm63138.dtsi
index 93281c47c9ba..bf0538896f0e 100644
--- a/arch/arm/boot/dts/broadcom/bcm63138.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm63138.dtsi
@@ -232,6 +232,12 @@ nand_controller: nand-controller@2000 {
 			interrupt-names = "nand";
 		};
 
+		serial@4400 {
+			compatible = "brcm,bcm63138-hs-uart";
+			reg = <0x4400 0x1e0>;
+			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		bootlut: bootlut@8000 {
 			compatible = "brcm,bcm63138-bootlut";
 			reg = <0x8000 0x50>;
-- 
2.35.3

