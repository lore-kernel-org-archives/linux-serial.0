Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798574;
	b=iSpo1z+YQN9Eav5FjSo8/M7yD+Y+eAm/geL7F0j4Q+P1GEXNGgTaXf+nLtfUnfvCCErg
	 nP2nLvF80VMbUiaO3AT89gsDdff1PT4US5XymFWOiIiwZ82RGjB+kKNqOYPtTMDPv8ccD
	 2jXimAC/ACVuApRV4/oDPe2Tx07v9t51mRQINfPV8I4XIMOHyreMHDzasjo0YDRD6WFna
	 iG9s6cGUstAB3YiKeP0oqQXFZ986Lf1pr3wwb6UFixldkJ2IljMo2pGRMldf+JUiaeFBE
	 MVVf+BS4j/qjrbMKONnho2pH/4FW3jGR7QjrhFa+rB73IzhAoughf93OPhgIdEeXKSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798574;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=NDQdal3wNitMcunk+R+QXDq5g9roUTKZhJO2aGBztU8=;
	b=rpzj7fCvkF1s8M1arVLsdYpfFo4k3fM7QrIV6bUEnyKNfwFsj7dvjrJmKgz288HJDKfB
	 22QWFt/7p61PA4hnUUUysn5v3Lk6zN0MDNuRV/RyCYSPfMZw/8PPssGHc5fkDffST6Kzf
	 LorNKDi8/MvdTamBSP3vmvFO906pXPtoO8ZJw7Yi3CILCtoeTxj66VLguV5RZh0OHiUoT
	 s2h4X8piHLLeft/rJG23YoVZA0ZAJS1SxbsWWY1qSwB9hdJCOmr+luLx1GZ0SLnJGzrJe
	 nLUcYyPvxcP5ejvDPFm702Wfsg8c+TwjfL5h3bInMjbLo/pGuqUbAecCX40nGYFGNng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Cn2Z9l2C;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A3F606A31C
	for <linux-serial@vger.kernel.org>; Fri, 27 Nov 2026 16:56:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52A3F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Cn2Z9l2C
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so106533015e9.1
        for <linux-serial@vger.kernel.org>; Fri, 27 Nov 2026 08:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795798573; x=1796403373; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NDQdal3wNitMcunk+R+QXDq5g9roUTKZhJO2aGBztU8=;
        b=Cn2Z9l2C25/Dwx2GuGqZrIN4hGsPXcojHBdTo2t+bEnu1Uzh4KQjS2kq1Rqd17q7Ya
         B8noQGF7oDu2b6kjFTjfhXOfl7DtEtJQ01vqPNO7jBVyrKWuw9POWHXC6mmAZ+o5nTZD
         fqHX/Z8nYmHnq/1I0xQ35XnOnQpcxqrOxCyVqn+AzqBjP877HRunYwWm4dSaKDGj8SMP
         mcMAx/pNC3Pb7y/EGZOAVTKcgJ5QGt0Ck6yKB+DdQw9IpFT25h7pgZTEtdy2nbg0fRMD
         P5EbMSsaCV0Lx67mWF3iwujw7EvEk0YSVEEWm22sKhJQSVKas9dqRW8dfA/II8R2A0dY
         tCpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795798573; x=1796403373;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NDQdal3wNitMcunk+R+QXDq5g9roUTKZhJO2aGBztU8=;
        b=VGYwBRNartgZxyL8iyma4NPA6lWHpPHv/NpwRycoXqQocp2PZjdjL5yfIMU73Hmd7c
         1GHcPvMTDJJWVHmEwec+dk6XFZaSD8St4LC1Ke94BkGmXqtRa4EjTLQCC/08FvMzPe/r
         JAx6yJa49sDADbfpIqQBWo3EqBI0iQCyiPb7p4mnXJzgUl3gA+/xG1o41HhBMT9RE2eX
         XD9FFeXZQIcntiewfUNA7gZFDoHYofbpXYx65PcPGJkqLVwli25ywmhCmKqsSMQwok4T
         gbreCJUO1Egtbrprq158WVC1I7eMRUDNXt31ZORNKoKKh3/1oeFuTdUUIYbgM9MZffQM
         be0g==
X-Gm-Message-State: APuU4Z+k7gC/llNLqiTQqtRYZ43KjXBTSVnK3nJXcPhBb//l0Vhkm1Ns
	V722U7cENdIqpCOSu31Pa8AHKnGN7fLVBkBs9q4yY83Fs4dmohjCvPoPD+x8UEPjXmo=
X-Gm-Gg: AZFdTZfMoJWlrLw/I0TvBwKy0lQcwm1K+i3ItsEsoihXnvU3tU1o5RI8+pIuZv0BtFn
	REkVHpAUlkhoY9J3IxFxdawV79AMboLwbEdwbwkx1xGCbqYMJFxI8RdV6gWelV3T9/aLprWwY2P
	2dYT6c+0PMEiIxW/8m7KA7ETqmEkx+/sTFGjMUcCNx0YT78RvrE7zjtzyT96A9ueEwltmVzUlUM
	tZOcfsOk9ueVEdGHRIBOyG9PvaZEmPLFDDBRAB9Ir3eLyInftiqMXtkriKCm+VrAKwoAuQcr7f+
	S5TZRYYC+NMNzZJBeBQQKB7cpkGAoJELw1PhvwqRsf7LKnQ2QT/3COWB4z03q29B29ETCSCeG0K
	/3paXl9EiAg/0zygsFFj5fmTCASVY23ZK34QSW04bjs1gxLg+e+RmvQzD+1eTfJLhTQEmI+zqbq
	ZWbmonts1qpJJq0C9Ae/c4ORgDDD6abjmKIDe+WSXBrKzJhQuoPGMhDzJ0rOctIVaDMKM4pFgxl
	KigRar3rfa8G18TluKDeiUSYNt6dKNJx3bOxW6ZHLApxPSTSsvuShY+eQJImiyrKeb3K3sketDy
	FC+rvFVyrFZkHNOP1iGhcVDs8ivtPto1669Tum9SmJjgJpgZdPrv+CSCiH1clNvCA5JWxM1tgik
	RFX4kZfc=
X-Received: by 2002:a05:600c:1d09:b0:4bb:66fd:ad68 with SMTP id 5b1f17b1804b1-4bb888160cdmr539373665e9.14.1795798572537;
        Fri, 27 Nov 2026 08:56:12 -0800 (PST)
Received: from localhost (bl20-90-91.dsl.telepac.pt. [2.81.90.91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8849247asm721676685e9.7.2026.11.27.08.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 08:56:12 -0800 (PST)
From: =?UTF-8?q?V=C3=ADtor=20Hugo=20Silva?= <vitorhg20080@gmail.com>
To: linux-serial@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-riscv@lists.infradead.org,
	sashiko-reviews@lists.linux.dev,
	=?UTF-8?q?V=C3=ADtor=20Hugo=20Silva?= <vitorhg20080@gmail.com>
Subject: [PATCH RFC 4/4] serial: esp32: Enable the UART clock during port registration
Date: Fri, 27 Nov 2026 16:55:52 +0000
Message-ID: <20261127165552.133713-4-vitorhg20080@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261127165552.133713-1-vitorhg20080@gmail.com>
References: <20261125233020.1380594-11-vitorhg20080@gmail.com>
 <20261127165552.133713-1-vitorhg20080@gmail.com>
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

uart_add_one_port() can invoke the modem control callbacks before
the console setup or startup callback enables the UART clock. Keep
the clock enabled across registration so those callbacks can
access the registers. Release the probe's clock reference after
registration, including when it fails.

Serial console registration and operation were tested on the
Waveshare ESP32-P4-Module-DEV-KIT.

Signed-off-by: Vítor Hugo Silva <vitorhg20080@gmail.com>
---
 drivers/tty/serial/esp32_uart.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/tty/serial/esp32_uart.c b/drivers/tty/serial/esp32_uart.c
index 40acff7..cd68478 100644
--- a/drivers/tty/serial/esp32_uart.c
+++ b/drivers/tty/serial/esp32_uart.c
@@ -856,9 +856,15 @@ static int esp32_uart_probe(struct platform_device *pdev)
 	if (esp32_uart_ports[port->line])
 		return -EBUSY;
 
+	/* Serial core accesses modem control registers during registration. */
+	ret = clk_prepare_enable(sport->clk);
+	if (ret)
+		return ret;
+
 	/* Console setup can look up the port during registration. */
 	esp32_uart_ports[port->line] = sport;
 	ret = uart_add_one_port(&esp32_uart_reg, port);
+	clk_disable_unprepare(sport->clk);
 	if (ret) {
 		esp32_uart_ports[port->line] = NULL;
 		return ret;
