Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87FD146D49
	for <linux-serial@vger.kernel.org>; Tue,  4 Jun 2024 16:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717516907; cv=none; b=HLhCyaj364ov/oSWnOXD66R0xkm2DnHEfcI63l8d49XQe6HgBjvyeP5yVIgBibCKyzPRAFMQpv9b4TaMefJL9IlNSrLIdabLwmy0yViWVNKYb57FZAs3WLjY4sKMwgbWO6iZBU72HCXP5gx2cNtk2j4/Y6NawqRYF6oig9h/atA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717516907; c=relaxed/simple;
	bh=eNI9NbGlMBE/dfZEleY3KsoUvrO1tZDSmMJ0X+X0MGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aMez8jjQWkXm6drbGObug1GtZPhj/fCffUXV+REGZhpo7x/06oVfhIumMoHFUEdgIgs624G1B+FvCAV426/0+jcK9Vn4epzi5u+tYSI5sEIitNrnccgrMuOUavByWK06VBhyjPC15KnWkLmUlCXw1FQvCTab70kUmoE7G9eqecI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dWWmY77M; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dWWmY77M"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f6559668e1so23916295ad.3
        for <linux-serial@vger.kernel.org>; Tue, 04 Jun 2024 09:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717516904; x=1718121704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dk/4AF49oXXnNFUX5+Su2//neZ/RJyiCOhQzShR517w=;
        b=dWWmY77MmJz1wcpYB9iFB3yKS0xNqv84Xw/fhPN9m/htFT7/fTyURD+8xkwz/rQQAl
         jf+w68fA16Cn1lH8CI7ceB4ubbZGqDxOyrD+HU7jLkziZF8Bh6e4i+zn3QZ3HHPB/02A
         fkoEhnjRzoA/6Jibkyl21DYxNfRgpJa2JVKOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717516904; x=1718121704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dk/4AF49oXXnNFUX5+Su2//neZ/RJyiCOhQzShR517w=;
        b=VsNNgE13148A+cT6H1RAoWXaRIsJfu/0FZ3HKsOnWnKCPoS2NsfOZe8UxG/m4Sa5DT
         o2Vq6T8fJgTU46OJInmCqE4aNpZcf2CXn5ER0rXLMWgTspIaD+QSLNEz2MSn2RJ31I5D
         YyhuatI3S7YcPgHNKDGsWyEkRGf5rpqBCMqzCPue4NtcRIQb4aC0w+fe5O38lmutgUSi
         lIN6U/8hrR18cZPlVKSwqFqk7b4iiDLHdzW93qdY+oyi4i7Q435DaKG3ngNxUlpuoN10
         zqOHZCl5f9AA9/YC9WETwR2a/z8UowfwooSNmgz3nn2Q0QJ2h0e2D7K6aiKIShCK8Q/P
         xLBg==
X-Forwarded-Encrypted: i=1; AJvYcCUvcmmbczeV6XMLdA84opRHltGj6AaFLXVSO9iIJZnmDse/1mOBv4iyt4njyOKY0RK8KxgoHN92yvHTlvWmH478SChI62UOLFCZEC4i
X-Gm-Message-State: AOJu0YxTiYLu228Xt1uWI8L+46eBVztP8LQDcJrFYDOW1YrFNAXxE4TG
	C27tD1aAT+kwkJOxcMVeuBqRGbQcaAPJ8hy1JX3fQd1IQPA7/Q+6E7ACMl1WEw==
X-Google-Smtp-Source: AGHT+IH3gIE1OtM086DyyhTOWjAt4JmRQYlQLYPgpkVt7dUI95yVU9Qm9mU9ANKuP1Vy3e7A+IdyKg==
X-Received: by 2002:a17:902:ce82:b0:1e4:c8b3:dbaf with SMTP id d9443c01a7336-1f6370296c6mr142181615ad.33.1717516904142;
        Tue, 04 Jun 2024 09:01:44 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:3609:ff79:4625:8a71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f632358519sm86118385ad.82.2024.06.04.09.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 09:01:43 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-arm-msm@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	John Ogness <john.ogness@linutronix.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Tony Lindgren <tony@atomide.com>,
	Stephen Boyd <swboyd@chromium.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v3 1/7] soc: qcom: geni-se: Add GP_LENGTH/IRQ_EN_SET/IRQ_EN_CLEAR registers
Date: Tue,  4 Jun 2024 09:00:27 -0700
Message-ID: <20240604090028.v3.1.Ife7ced506aef1be3158712aa3ff34a006b973559@changeid>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
In-Reply-To: <20240604160123.2029413-1-dianders@chromium.org>
References: <20240604160123.2029413-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For UART devices the M_GP_LENGTH is the TX word count. For other
devices this is the transaction word count.

For UART devices the S_GP_LENGTH is the RX word count.

The IRQ_EN set/clear registers allow you to set or clear bits in the
IRQ_EN register without needing a read-modify-write.

Acked-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
Since these new definitions are used in the future UART patches and
Bjorn has Acked them, I'd expect them to go through the same tree as
the UART patches that need them.

(no changes since v2)

Changes in v2:
- New

 include/linux/soc/qcom/geni-se.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/soc/qcom/geni-se.h b/include/linux/soc/qcom/geni-se.h
index 0f038a1a0330..8d07c442029b 100644
--- a/include/linux/soc/qcom/geni-se.h
+++ b/include/linux/soc/qcom/geni-se.h
@@ -88,11 +88,15 @@ struct geni_se {
 #define SE_GENI_M_IRQ_STATUS		0x610
 #define SE_GENI_M_IRQ_EN		0x614
 #define SE_GENI_M_IRQ_CLEAR		0x618
+#define SE_GENI_M_IRQ_EN_SET		0x61c
+#define SE_GENI_M_IRQ_EN_CLEAR		0x620
 #define SE_GENI_S_CMD0			0x630
 #define SE_GENI_S_CMD_CTRL_REG		0x634
 #define SE_GENI_S_IRQ_STATUS		0x640
 #define SE_GENI_S_IRQ_EN		0x644
 #define SE_GENI_S_IRQ_CLEAR		0x648
+#define SE_GENI_S_IRQ_EN_SET		0x64c
+#define SE_GENI_S_IRQ_EN_CLEAR		0x650
 #define SE_GENI_TX_FIFOn		0x700
 #define SE_GENI_RX_FIFOn		0x780
 #define SE_GENI_TX_FIFO_STATUS		0x800
@@ -101,6 +105,8 @@ struct geni_se {
 #define SE_GENI_RX_WATERMARK_REG	0x810
 #define SE_GENI_RX_RFR_WATERMARK_REG	0x814
 #define SE_GENI_IOS			0x908
+#define SE_GENI_M_GP_LENGTH		0x910
+#define SE_GENI_S_GP_LENGTH		0x914
 #define SE_DMA_TX_IRQ_STAT		0xc40
 #define SE_DMA_TX_IRQ_CLR		0xc44
 #define SE_DMA_TX_FSM_RST		0xc58
-- 
2.45.1.288.g0e0cd299f1-goog

