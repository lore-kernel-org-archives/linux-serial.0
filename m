Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC0A3EC82E
	for <linux-serial@vger.kernel.org>; Fri, 11 Sep 2026 03:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789096512; cv=none; b=c6QigHokHXI6zLEaCD8LOgJ4LtME+rnzrzWuG/7fr8atZcprKIHjuutnjUPUWtYeOnM2eEHMAMIb/kF0vOGfKoUCccDZWnyuuSWYlQneRJpspKS/facG8DqgRrY1gQHN9dRJYkjDNuVUQeMdNg9AMFqDgXZAhUaZhFGM8I30eZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789096512; c=relaxed/simple;
	bh=T9/TW2cLGEYS4bEK3G5XpNy2ErIWmUDDxIv1/6DbR9A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A32bOsoiXwImHzZFy4vaG9jNwNC+k+UERWGj6HS9cxF9QK3PUvu2ay/GhLmlnOFSrkL3N9P9ZkwfCh/f84trhzOAa/3vvz43S47wKDzSNaqtg3fa9VjY/E0M2CGyD6eI9ZFeCOc8segbpUxGOu44a94lYf57GnlAvzQeclk2ijY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qmwIE537; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qmwIE537"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-910704e63a9so1621486d6.0
        for <linux-serial@vger.kernel.org>; Thu, 10 Sep 2026 20:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789096508; x=1789701308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=D/Er1eDnnKElUawcqZSFtd5s2k6qLXgoYfExyajlAOc=;
        b=qmwIE5377N6vztTbXsCbzno6gFwr/pgUa+LtkRKaDriUJQiRZrIOzkNNfvhvWwrJcW
         pv275SOycfa/HhoAcNWg0oYk/FH2nI+Rlp3NvIEinYBFXzTbglP3zJTtJFOYyRR4k3Wa
         uo5CuyuVoYQzidPCQpFnKdQFvMRHOkp6x3GG/2tVybjaKtYXClU4gPZU/6de5nJwQ97p
         j6F8JLwqbwczvtXg7WPdv9UoU1ePAkOZrfZh4A5WgLo7+G76RAfq7TiuhImxY7WeOduj
         0oYCdJjp4vhEwGJdyOgsZh+9RWcLK5N993dUqScddKgw4MCL15g/vSFFC6RskkS4O3TZ
         x4NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789096508; x=1789701308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D/Er1eDnnKElUawcqZSFtd5s2k6qLXgoYfExyajlAOc=;
        b=r//sZgGbSnDuu4KMhVOKtSnG/Y6rpu3Nv46m3QbI3e75kUI35A2lLZ+lN8FGbFLl6g
         i5GjwIzvQeoaSCQ+tBsnGGXgK7I2E5jhI68fDjDYIKDmkmNUuwhrRF4K2xBPSjBGctRe
         gCgUmyMazXIgOFui9KJ0XoVYPCQ/qBtZPNfJfJIYzbAqa/zjZ/qPAMwoBgod3ehBB7Sn
         Qwhldsel42ZsjPDLJ5FHgwOoyKXu/egggiWaOphtj8TEymf2lAZoU5BWnBprAYXNRvj6
         GSn/7ttybL9wMdgDiK7xW5XmS7z1zdOE9ELy2Tut102f1JS2fbspH72+ABxMwBogILOL
         6YcA==
X-Gm-Message-State: AFuF++myc7YUfUu57Ddkr7ln86sRk89LGN9sr4NCKto51OVUKJPDybj6
	gxwZifZpCDrm5XVrtQlzmHq3nL/ftoE2+KxTkSVjOv2aRPhtW9AYRc4=
X-Gm-Gg: AYBFou1E0LItlFOKwJvh/nIMSL2RA7ChnHML/jAAOiZbm5A58V2EwVC27S4biyq1LtG
	QBkPtf/jJJ8zERtmpkR959MeufUNNGXFyABgBSY1vVha5DyFTEvOilUwmB9PJ/m+zjn9W8hEEKT
	yL8t6cmDYCPbiSNvp69ELjGKfoi75SZ3eyzbiXTBwsALBLXVfdjFhEHj+cs5XyPkFYUE9bzRjc0
	/Y7vtL0X+sBwxSZn2B+1FeTcgmq/b3thRuX/aBZQ91omZsl3jf9kpLBA7MvgvNqVwV/BsrkcyVN
	lr9/9e7TQCxq/5GI0jOEyG7sSgNAk2IjuTeCkXmgoLdAA2duhYL8Fm6a/3iCo9L5TdrPrkor7U1
	dj23LOTT6c/sFbveqeKCEfHFyZDAlrS6yZND7/n/Vmlus2dB/Zj1q6XjdI1hu9tA2YeIl/w+NuC
	zcUNuDoBxezysjX0lfB2rwyEXN3WcvEQl/BVGbiVNA21DfgpsqGSZC+aEZvCCyrmxS2hxo7Ei29
	TjfSauuMgf97KmH9d4tijxG+jxFP5ISS5ra6rPtE7/gvDbxwIWqtoBhVYsO/uIi6SrUwiyULOjQ
	9QhPomi1zr6r+i/Li4twCC/xbH5FzJ6XVA==
X-Received: by 2002:a05:6214:2529:b0:912:5b3:c193 with SMTP id 6a1803df08f44-9120eaf2767mr32388056d6.2.1789096503067;
        Thu, 10 Sep 2026 20:15:03 -0700 (PDT)
Received: from localhost.localdomain ([104.39.73.78])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120ef650a6sm11625536d6.0.2026.09.10.20.15.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 10 Sep 2026 20:15:02 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] serial: sh-sci: Unregister UART on sysfs setup failure
Date: Thu, 10 Sep 2026 23:15:00 -0400
Message-ID: <20260911031500.5745-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sci_probe_single() registers the UART port before sci_probe() creates
the RX FIFO tuning attributes. If either device_create_file() call
fails, probe returns an error without removing the port from the serial
core. Device-managed resources are then released while the port remains
registered.

Unregister the UART port before returning either sysfs creation error.
If the second attribute fails, remove the first attribute before
unregistering the port. Keep the existing probe failure policy and leave
the successful initialization path unchanged.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: 5d23188a473d ("serial: sh-sci: make RX FIFO parameters tunable via sysfs")
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/tty/serial/sh-sci.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 92193eb26abf5e2de6386389708e635e42d33c8b..50ae9aae6b6146493a5c080a0f0cbb7351a89b3a 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3937,12 +3937,12 @@ static int sci_probe(struct platform_device *dev)
 	if (sp->port.fifosize > 1) {
 		ret = device_create_file(&dev->dev, &dev_attr_rx_fifo_trigger);
 		if (ret)
-			return ret;
+			goto err_remove_port;
 
 		ret = device_create_file(&dev->dev, &dev_attr_rx_fifo_timeout);
 		if (ret) {
 			device_remove_file(&dev->dev, &dev_attr_rx_fifo_trigger);
-			return ret;
+			goto err_remove_port;
 		}
 	}
 
@@ -3952,6 +3952,10 @@ static int sci_probe(struct platform_device *dev)
 
 	sci_ports_in_use |= BIT(dev_id);
 	return 0;
+
+err_remove_port:
+	uart_remove_one_port(&sci_uart_driver, &sp->port);
+	return ret;
 }
 
 static int sci_suspend(struct device *dev)
-- 
2.53.0
