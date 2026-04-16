Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E401E38C425
	for <linux-serial@vger.kernel.org>; Thu, 16 Apr 2026 20:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776370806; cv=none; b=cs0MioOO0VaE8yYBbfEui2owLxAvWRJYy6vQZmLizndJxxs0pL8gj4qK1hjHfzle+FBW8oE4XK9O42goGGzezxekB91D85eRd677piJzq6lEgLlnpmnS8s8s7uoY4UgPhuq6vO7vGMeDZigvWCgtgYWsc6HBVV6hT9u0aKxiZO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776370806; c=relaxed/simple;
	bh=zqX6tFIGEUCVaeZF4QkxvcJ5oMEM87X0rHqUfEPpl/g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YaQxHEQNWXrT23ADeqrZegznI5gTS0C/1bDUIKx+IN5NZ62nXblVO0kKUjdGOsMwv+DPfprLco6/YvfzXl2HFgHFkrZtiHTah0tyNs/Rh6Ooq/mZdfCMzWPxbVWXyduLuvjusdkiYDGViW8XXBLTXGJeIx/+oZzrm7ia0LIOZ4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P0a2Szwp; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0a2Szwp"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43d7213b6ebso3236032f8f.3
        for <linux-serial@vger.kernel.org>; Thu, 16 Apr 2026 13:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776370797; x=1776975597; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0T03nzSg8o1Xiwn3g5TYhAqMiuGuUlEI3maXBZPCdug=;
        b=P0a2Szwpe0CY2ZBY/PbJg9rlM3HNnwwWXuEDn707qh1gjAEjqS4OmbcIKNIUZo0A0S
         0SWQmqpn0puXhUuqm3IDXlCDSzSOIxitF4CPIE3Ai9eYeQMCDB6bey3+u9sh+0BiaxWl
         TCLitHHx2HcDZb5juR7rOkXe0n95nbVfzkfu8uVX80lQp6cBIQ0U9GEoU33HID36J/HB
         yB4DTe2RYfgTdYAgkhmfgX/WkPfraCL+EVkII0Q8KuvbnOC+yPab4MppZUhScBSIiBz9
         vllyYoLlnP/uDsz/RB3sO0gPNw38Kfk22eHv+Zq9x7zVvUacMIRKgdXmzcutxkv+bMBd
         C4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776370797; x=1776975597;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0T03nzSg8o1Xiwn3g5TYhAqMiuGuUlEI3maXBZPCdug=;
        b=p67ubxChN8JzOtZZ2uB3EEms2O9Ryo1I77K8oEdG1DYbNV8cjUn0g6DsSaOK2JJz8P
         c1tta2R1rBkwtKi59Gm5ZV1HKPo4BkLVj2/RHTMVIkfgYAeHxJ6CLw+vXA0BCaMIzbvN
         lPIhYlexaYS+VGvl7u0RAN2xfRGZQvEJmCWB/47iWU4Dj9TjyXOfZG4P6Yg3D6WScdr1
         kLFaiLW7QuWozB/jxIBNqrl4PmgqZvnf7NmBIpOtzgeQJO0FK5xZmba+yGNsEmYptCp5
         ZWrndRMRpTqgNaOt2UnrCk3j/Qo8zJIwzRk1dKSan6Sau4Fd0vtHCOfNxUNWKpRYua7J
         5gEA==
X-Forwarded-Encrypted: i=1; AFNElJ8e2D4nDIp6wFijdSVqkZX/WbwoHMV9Jtj1rtfm/72VvFEg8obQUz6t1JRtCEhC0apc3E9rfsT9ZZoCYM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbnULJKFhmjr/0aftE+FXH27yav0JrX4946M9gS7oc9v6ohfr0
	ePWFXDrQ73uqdkIua9pYYZ8GA4EvpjkbPjWd2Z5zzHr5xd4HOMJMMbfE
X-Gm-Gg: AeBDiesxv0VMxbyd5v+PUOLl0/0kN2TE5NCKCA1NlXI9FB/g9amFKWr+qbcFjG3Bihw
	rAaiUVuWrcC4SYNxRxIuggl/muEiNsgczVx6y7ypdkMqLTUpXrv8MtxVKiIhngZqPNjZwgPA6lN
	5iAl/nVaskIlzfTLedAeiENk1tAahO7JNhFrkmdEbxKhgQImNonIlCz41dVl/xDDMNZE6dfGsU8
	upjq6Yah77lMNii3jePaGCnLui/R+iJupBgNhjQ/2h+3FP2Vb4fXz26uvPFfGQWVqwQwkeHduYd
	lxrLSfmvxSbJNJGALZ7gaqdHpl2MRv+AW1BExPl55wYNPpcjN8/K9/OrmGr7QWDF14sleDjpgtG
	Xhm+0XetopWdejeg6iRBYVKQlduVDFe3UoOpiDhw4wAOfwiObtwHGGVm7L8W+H6xe6uzbskBjms
	NIP0r4JLKK1n3C3TsZR/FCnNqqYNOKwsrW9AnXkS0n/DBUwA==
X-Received: by 2002:a05:6000:18a5:b0:43e:a69b:d810 with SMTP id ffacd0b85a97d-43fe169d563mr1185520f8f.38.1776370796893;
        Thu, 16 Apr 2026 13:19:56 -0700 (PDT)
Received: from [192.168.0.2] ([197.250.227.196])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead35c026sm16180624f8f.15.2026.04.16.13.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 13:19:56 -0700 (PDT)
From: =?utf-8?q?Stefan_D=C3=B6singer?= <stefandoesinger@gmail.com>
Date: Thu, 16 Apr 2026 23:19:14 +0300
Subject: [PATCH v4 6/8] ARM: zte: Bring back zx29 UART support
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260416-send-v4-6-e19d02b944ec@gmail.com>
References: <20260416-send-v4-0-e19d02b944ec@gmail.com>
In-Reply-To: <20260416-send-v4-0-e19d02b944ec@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Linus Walleij <linusw@kernel.org>, Drew Fustini <fustini@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 soc@lists.linux.dev, linux-serial@vger.kernel.org, 
 =?utf-8?q?Stefan_D=C3=B6singer?= <stefandoesinger@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2641;
 i=stefandoesinger@gmail.com; h=from:subject:message-id;
 bh=zqX6tFIGEUCVaeZF4QkxvcJ5oMEM87X0rHqUfEPpl/g=;
 b=owEBiQJ2/ZANAwAIAT0TvMhUTxoiAcsmYgBp4URLOAzH1tDsqAQM6YsZ7GEyIYJznmL2L8uIk
 nhr3jf9n4yJAk8EAAEIADkWIQRDFvS2qgVbJ5UyXWw9E7zIVE8aIgUCaeFESxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQPRO8yFRPGiKx/w/8DjeLetUi3csxyMsp3tA2IS2LYDPYepk
 nusCL8dln6bs70+ADwKi4Y4a31RnjheChLnfNcfosGcDQiO00EXr5uP5c/PRGfl/oOLslI3uOkZ
 5VY/xxMT5nuqII8In4qpDumJhiEStbYx3EUYZ7+Zwh+4UUtnxVKpqcPnhoHKucrfETgSCykXo2Q
 fUsaAnCy4JQ+S1pkPa2kE52QzqYRhV9wEFf2vsQcpfdlObUuxtjl/xhYeKy8SRNhx57Odec5vuj
 9sqRIke/0799ZtihtMrHMDSvmpZiR6Ea4u9Hl1/5LOt903k8E1iUF9a2NYnSPmnMmYJLPdQ4UPj
 n6vlHIJpXlkxFYN23/W3YU5+gEGY+hvL1dALjmwmvQclDe5HCyDmkU/ZrSi3rtVbvAr+wQ8Dxgf
 Jkh6iEbGRGRZG549PgjH+uCDgF7+hWCNTE9uJt49lFe0lXkrmgmrZMNmlq06L8vcluLTaAbnK6D
 +5xHw2T2tcuviAmrV6ovuLi4/UaECUyZbSKiMTH/0sqTUFMHATLO9iLwWt3zR5u6Pf75BYOGnjb
 dV1GlpeL86CeIaFTQ93V1GoEQIlS8tM0E9PHNxgC/O3ZarpJIRT5Mf1XyFWVRlWb5DSC51YcHw7
 Xu+XbvZWPNUuqTHq1jDa3p2c2w+UZqjTtBqmK2pyHU42ZwVkbn0c=
X-Developer-Key: i=stefandoesinger@gmail.com; a=openpgp;
 fpr=4F9C2C8728019633893EBBB98CB81F9A72BBA155

This is based on code removed in commit 89d4f98ae90d ("ARM: remove zte
zx platform"). I did not bring back the zx29-uart .compatible as the
arm,primecell-periphid does the job.

Signed-off-by: Stefan Dösinger <stefandoesinger@gmail.com>
---
 drivers/tty/serial/amba-pl011.c | 37 +++++++++++++++++++++++++++++++++++++
 include/linux/amba/bus.h        |  6 ++++++
 2 files changed, 43 insertions(+)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 7f17d288c807..858a0edd3e3b 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -216,6 +216,38 @@ static struct vendor_data vendor_st = {
 	.get_fifosize		= get_fifosize_st,
 };
 
+static const u16 pl011_zte_offsets[REG_ARRAY_SIZE] = {
+	[REG_DR] = ZX_UART011_DR,
+	[REG_FR] = ZX_UART011_FR,
+	[REG_LCRH_RX] = ZX_UART011_LCRH,
+	[REG_LCRH_TX] = ZX_UART011_LCRH,
+	[REG_IBRD] = ZX_UART011_IBRD,
+	[REG_FBRD] = ZX_UART011_FBRD,
+	[REG_CR] = ZX_UART011_CR,
+	[REG_IFLS] = ZX_UART011_IFLS,
+	[REG_IMSC] = ZX_UART011_IMSC,
+	[REG_RIS] = ZX_UART011_RIS,
+	[REG_MIS] = ZX_UART011_MIS,
+	[REG_ICR] = ZX_UART011_ICR,
+	[REG_DMACR] = ZX_UART011_DMACR,
+};
+
+static unsigned int get_fifosize_zte(struct amba_device *dev)
+{
+	return 16;
+}
+
+static struct vendor_data vendor_zte = {
+	.reg_offset		= pl011_zte_offsets,
+	.access_32b		= true,
+	.ifls			= UART011_IFLS_RX4_8 | UART011_IFLS_TX4_8,
+	.fr_busy		= ZX_UART01x_FR_BUSY,
+	.fr_dsr			= ZX_UART01x_FR_DSR,
+	.fr_cts			= ZX_UART01x_FR_CTS,
+	.fr_ri			= ZX_UART011_FR_RI,
+	.get_fifosize		= get_fifosize_zte,
+};
+
 /* Deals with DMA transactions */
 
 struct pl011_dmabuf {
@@ -3081,6 +3113,11 @@ static const struct amba_id pl011_ids[] = {
 		.mask	= 0x00ffffff,
 		.data	= &vendor_st,
 	},
+	{
+		.id	= AMBA_LINUX_ID(0x00, 0x1, 0xffe),
+		.mask	= 0x00ffffff,
+		.data	= &vendor_zte,
+	},
 	{ 0, 0 },
 };
 
diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
index 9946276aff73..854c962d70f5 100644
--- a/include/linux/amba/bus.h
+++ b/include/linux/amba/bus.h
@@ -103,8 +103,14 @@ enum amba_vendor {
 	AMBA_VENDOR_ST = 0x80,
 	AMBA_VENDOR_QCOM = 0x51,
 	AMBA_VENDOR_LSI = 0xb6,
+	AMBA_VENDOR_LINUX = 0xfe,	/* This value is not official */
 };
 
+/* This is used to generate pseudo-ID for AMBA device */
+#define AMBA_LINUX_ID(conf, rev, part) \
+	(((conf) & 0xff) << 24 | ((rev) & 0xf) << 20 | \
+	AMBA_VENDOR_LINUX << 12 | ((part) & 0xfff))
+
 extern const struct bus_type amba_bustype;
 
 #define to_amba_device(d)	container_of_const(d, struct amba_device, dev)

-- 
2.52.0

