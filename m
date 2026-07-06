Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF7842E000
	for <linux-serial@vger.kernel.org>; Mon,  6 Jul 2026 18:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783361035; cv=none; b=QhI/QZUjas8TSeVQxc17SelHu89Eq1a6DfUhrc3YxExXWJDcy2TzjN0NMPVzr16cVRYoyEogal3ELtyl1v18Ug0ANJ1cO5rD16hjbuwdmblxEfR4YN9rgX6PQoJAesSawdPYrkBGo6am3uOZfSAJcTqLrzR1a6A77Z+W3JOOOVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783361035; c=relaxed/simple;
	bh=VZDaZKMK4kEJKXIJDaekq8HWph4OgLHsGNpx0bYPXmU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=MCHdPFpTXHgjqJirFgER29ugPsOc0oUVtGbJnUYwEUxsODDUhBCWlkntBklDggfESDxlKSVjw4vM/Z/kgqRfxbG9UgXnSuzGTLJcddcwBcTz7MVsEjeJ04StXB8Lk7MNLvghJZS+K4InedEFHC+pvE25Hm9K1d+/2Xx4u8tVl3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wTRWQ2Np; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wTRWQ2Np"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493c733f15aso33513645e9.0
        for <linux-serial@vger.kernel.org>; Mon, 06 Jul 2026 11:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1783361030; x=1783965830; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5luYFUMmAggGGBEA0YYlTH7BdRmbZuziZyzSdwJJOPQ=;
        b=wTRWQ2Np6WaCMlt7TjVkhSrofasG20GHt9KIcPDUjU8l9rH7IFK0Ss8VETK/02GhmE
         XMOr8xgopWXFd3nIBaaMg6Qd5nKz4cVUdvjUvXi+4T2S9NaOOhv2pm4KuLQFPjGKPWRZ
         ftbY/OUw2tRpxelwiGc2yF0X6fKyHKBYknhTr3HO8+bSgmf0GF7ZQNSVIXu2DASnR0F4
         gwhwLzIE4C/TfL22YM1oCdDWeOOa9eWMfOwbk+kWt/mKJ2CgMdYQpx/+dELj7s3N7/CR
         e4m/95MmUJtXZtu3hWjkQMa4A/m0DoKDzwVDiMPuDJ69TGIUFVZD42t+hE37tzaFPLC/
         6NSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783361030; x=1783965830;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5luYFUMmAggGGBEA0YYlTH7BdRmbZuziZyzSdwJJOPQ=;
        b=guVbkXRQmuHc/uF7f5JwdFTzMZWq5rd0Wi3/UBwoDmtXGEeNec/1r5mt6k3GJi9mUm
         jsCBngRRs66COGuQxxZZAqsqEbxfQRddznlaO5m0KgdAUgR47G9dDz27X+X+8qSsL6W2
         00/1xFezCe7H9fh43Md9VkpGeEFewaxFW1H0uDpDxeV0MXBCuXYI211fgtUIGzEgtVZK
         WBTp56vrpTLbnhkyDK3hWx+KpyDipCkvCzuFKDT8wtZHQWajaek9Tox6Pv5lKIrccE2w
         a86XPEMS3pgdOL4Giwj+dvaw/uUn1uVWF0TntFVEfkQ7ZF749CBV9rWSAz7KHvbFkybG
         eCJA==
X-Forwarded-Encrypted: i=1; AHgh+RqV2AlpW/Gfbj+FcsUBkaLw9ptNWkoD95BdBYtfvp8FD/FeMOZFCu0myC2Bdxtg6vNfsuhX1E1Uou8z2to=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPFb+kOJPu73HsSEjseaD6lgfYcLQp/Ez0VWISpF5s7aCvWB1S
	FaO0vYrK4t2BviMyD/O4MXpPxQrhWDPj1JmtR4sclWuvhWS9VhEpTduM5Kkyv84Vvp02OgcYIB4
	qoJT5SBg=
X-Gm-Gg: AfdE7ckt99Zybr5OYIM6neUFouMwCCQZGARo4Mr93mU9U4i1jBIds+Levj90+qYZ7ie
	fzYDWo7WSfs4ibuad98QPTOngd4ZFGlu0fCDTRw8BYCRUgusrBdoz1LjVbULlbrGg5zHYD6Zy35
	uWomwavb0f/M6zvprnQm35WUL/ZNt2FHD3J0GkC/Gls/fqAGyvZRjz+DmHLawhm87eEjJj4M3zZ
	dSONpw60Mjb2WBS9+xDG7L0DeYP5+6vtFg2Ve23yOCcqay8KxA93vgwkuUmXbr5+e5jcrJ6cUxg
	ZQbxnWXPbeWx/NxHzsDYqymFzumXmpmV0VSeSSIlb9F2vZFW9vPaDnjOUrT8k6rVqfQOfJliVYn
	PCMwaUqsRmr/kqJoiR+Jq5QSKfWZlY4Ara/u/+E5deThrAogy604qv37NtDFhzgrUB57zJyGGKR
	JAqKu6CC5EvrazaeOqks0S6iQShw==
X-Received: by 2002:a05:600c:3f14:b0:493:ad1b:b38d with SMTP id 5b1f17b1804b1-493df0a0891mr17558835e9.37.1783361030506;
        Mon, 06 Jul 2026 11:03:50 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff24:7210:1bb5:914d:5d25:d048])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e00bd6a0sm1109505e9.15.2026.07.06.11.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 11:03:50 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Mon, 06 Jul 2026 20:03:32 +0200
Subject: [PATCH] serial: msm: Disable DMA for kernel console UART
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-serial-msm-console-dma-collision-v1-1-3179b8cb1d89@linaro.org>
X-B4-Tracking: v=1; b=H4sIAPPtS2oC/yWN2wqDMBBEf0X2uQuptkb6K6UPSVx1Sy4lW0UQ/
 73Rvs2BmTMbCGUmgUe1QaaFhVMscL1U4CYTR0LuC0Ot6lZp1eLRNx6DBHQpSvKEfTAle3+OkWy
 nO9sMN6vvUDSfTAOv58Xz9WeZ7Zvc9/DCvv8AtxRLQYQAAAA=
X-Change-ID: 20260706-serial-msm-console-dma-collision-eb878b3f4b75
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, Sam Day <me@samcday.com>
X-Mailer: b4 0.15.2

At the moment, concurrent writes from userspace and the kernel to the
console can trigger a race condition that results in an infinite loop of
the same messages printed over and over again. This is most likely to
happen during system startup or shutdown when the init system starts/stops
a large number of system services that interact with various kernel code.

When userspace writes to the TTY device, the driver initiates an
asynchronous DMA transfer and releases the port lock. At the same moment,
the kernel printk path might grab the port lock and re-configure the UART
controller for PIO, without waiting for the DMA operation to complete. It
seems like this collision results in zero progress being reported for the
DMA engine, so the same text is printed to the console over and over again.

For the kernel console, we want a reliable output path that will be
functional even during crashes etc. So rather than implementing complex
code to synchronize the kernel console write routines with the userspace
DMA write routines, simply disable DMA for the console UART instance.

Similar checks exist in many other serial drivers, e.g. 8250_port.c,
imx.c, sh-sci.c etc.

Cc: stable@vger.kernel.org
Fixes: 3a878c430fd6 ("tty: serial: msm: Add TX DMA support")
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 drivers/tty/serial/msm_serial.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index 2e999cb9c974..bfa44b01c3e9 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -1228,7 +1228,8 @@ static int msm_startup(struct uart_port *port)
 	data |= MSM_UART_MR1_AUTO_RFR_LEVEL0 & rfr_level;
 	msm_write(port, data, MSM_UART_MR1);
 
-	if (msm_port->is_uartdm) {
+	/* Disable DMA for console to prevent PIO/DMA collisions */
+	if (msm_port->is_uartdm && !uart_console(port)) {
 		msm_request_tx_dma(msm_port, msm_port->uart.mapbase);
 		msm_request_rx_dma(msm_port, msm_port->uart.mapbase);
 	}

---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260706-serial-msm-console-dma-collision-eb878b3f4b75

Best regards,
--  
Stephan Gerhold <stephan.gerhold@linaro.org>

