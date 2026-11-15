Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794755286;
	b=myAn+y6aARat6KvD3Uvft2ZtkgxzgCKxd8afcrFC5ZaG0ILmsobhG4eat6QfZ9Ad5Oi4
	 Es93bDWiSIF6i5r/bzvBdIauND6ggtwK4FNFkrZc6UIDGKEllRCvVu21cLyKzj7kFBu9X
	 P04Q2xjOuhX5Ip6qCXK6EazmONGGz/dNeryo7jPxPzPhGqi1p4yZPrI7URuW6/JH/VEmF
	 hcq+kZfT9I30UHg/YMVEsIp7zOThCLW/ujz4kZ+onRYyf4+nYCzmInv3B7IoRkLXBA/JS
	 IcaoV+oW3TdIdSes3GExvPFIBg2i+o+7N+/8YiXloD9aIk9IYc3cSaV5tRL1VDj/kzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794755286;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=2rnyfsy2EldrWz467K7SxAMK6OUc0htpUc0SitHaE/A=;
	b=xSZjNP0gNWJVLjia9+2GD0Wu6G5M5qexU294/DuqqCPc7QSVlsF/T9ojvQIVk3CWZrsm
	 lWtgLcy0Vh5oSryED+yHOF3byk7jQpsexk+dc9RMpPvzVsg7y5gP+raInghrSKj3eIrAk
	 QUAP+Oi3J1TDgS/IF5s+S13mHJgTCb3q8weTGojjt+OC2AVdsKZndusuxQo1uJujkXpy2
	 n8PyphJ/2ErwwxDr6K0/WhVUyGb+8ViluBM8RBu8NOnlVSjR4kHZ1b8pv5XTptfg4EJya
	 3iJ8lgFRRHAuqLCnRizSTnVqvywShPka2qUGUWOreM2N1d+X//gZ8VvKpvvGDs20mnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QFNcllD9;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04A7606A31D
	for <linux-serial@vger.kernel.org>; Sun, 15 Nov 2026 15:08:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E04A7606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QFNcllD9
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-492690dd5daso2587934f8f.1
        for <linux-serial@vger.kernel.org>; Sun, 15 Nov 2026 07:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794755284; x=1795360084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2rnyfsy2EldrWz467K7SxAMK6OUc0htpUc0SitHaE/A=;
        b=QFNcllD9vJ9RNYjanp/aZaO5cSt+y8OFpkd0tT7WqUbmE4G8viItw1o+rGNNrn4bAf
         mBF9HV6cmgq80xojU1re335TX3kmQPovNQOb898f/aPnjGVcWLpWko77f9ZD1XVD/D1V
         3Q29PvwYoyWTxMDyc5GZagtfn+ZEebJdzhG4KJAw96ywma5q4vBIBc1qs+GOANjZbtNh
         arHrZ4ZIav7EOHxGBLeCZE0qHy7WUluTtK5W1aLo9L/0aBgF7VoJAVDPfEqBJIi3ELoG
         OGYRhy4W/3KAw8e5mjsbkQVV6aYXT+6UZ62kVUWQh7HPKUsPr60i41tEsPt7lzjNV3FN
         z/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794755284; x=1795360084;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2rnyfsy2EldrWz467K7SxAMK6OUc0htpUc0SitHaE/A=;
        b=TpaAMP3R8sswOY9QwQZ1SYofL3npBLBdE97eWUHnFs+9WdpfM9c8vwxAN2Oq6rpDDu
         eSYUC4X3MwNZgB6CUmfqBTePK/U3mbZanZ78vx6vLdDFImgqSW3cxOhvaUcP4mesVV8+
         xGn/SY0N28KcX0RNNNSieUYa2Emdbj2LsZu5Xw3+joStDRdLuBMpKoCcfZJhPgVjTCeX
         0iZqwpkSqNYL9CX+jDYl1ElyT3tavgtlUMmoU7cAvm3EmBUDAaSoPt18jBHihgljjVwm
         gAgU9Bq1Ze/Aof5Nktz84s7YnVWedT0Jr/ZycUfml4a4R/iZ+ondLI/LLSodvqoKxEpR
         6C6w==
X-Gm-Message-State: APuU4Z9NILfeFmtUVqqS+IM8mZVe6GVvFwAU57d4RsbInJ53bhK5zskI
	7mK1UiXYpoAWXgu/54MSyBMkhW/VA/MWq5YDj6vyC25cIH9bUeL+0ocQ
X-Gm-Gg: AYBFou2rBLeqeBp89H3dlq0nYzCqZk192mz14mRklSkZDvkAUgD3816n893aVqvpyRW
	x1he9R6Y0bz4VFmbYOTDrhp+affVJq97DbONS9kWvXzKHcy/jA6KfDddcRe7U+Cy3YKckvUSwOv
	UPrtNQRDx0uru+m0yKAgb7Qq4aHvgOvlWbxq/IHaiBXCQy7cfbxoPw3xAm+k7yAcS21e3pdovuo
	LUoEzsblzAvrDue8RUbZhRHXHLXP2xcmDCMIV+NM04ReoY36/mS1TaRxLDsYk1iXgUDOa4BmZ9E
	kJ+ZPSK0xdxmMX+Nhy/3AvAN0vUGEvZBBTd1HdQ+vfw5rukS6CoN4/kleUOipcSP8SU6yD8JS4Q
	SZXT7At6vCq1ruQw8dPEkUEq1OYUyEijvLxtLQXK1j1rVKaZgigkdmh3E47zoiIBe0ZsUSrdMxF
	0NBXIB7lB/lUaOxSHKjNAOcbZfBLrmf7N1JzJzoqJ2cpTwgNyBa/Th5u8+U7t3hsJDt9UOLdiLr
	My7LrUXJXkCvyWc9VQ8jOXoEwCMhnJ2zDo+Gu6LCdZWB2WlQ2x+Jk1h+QBS5N9OHOCjgnxbwj5o
	DesbWM7WF+7rkKwPGA8VX7MlFyCliD3QzNKSjpVreOU=
X-Received: by 2002:a05:6000:290b:b0:499:9ffc:59bd with SMTP id ffacd0b85a97d-49c70a0ee43mr17121286f8f.30.1794755284178;
        Sun, 15 Nov 2026 07:08:04 -0800 (PST)
Received: from fedora.jkuat.ac.ke ([41.204.187.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c60d9fff8sm17642477f8f.52.2026.11.15.07.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 07:08:03 -0800 (PST)
From: Bramuel Barack <bramwelbarack89@gmail.com>
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bramuel Barack <bramwelbarack89@gmail.com>
Subject: [PATCH] serial: mvebu-uart: drop of_match_ptr for ID table
Date: Sun, 15 Nov 2026 18:07:42 +0300
Message-ID: <20261115150742.24126-1-bramwelbarack89@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mvebu_uart_of_match[] is always compiled in and already referenced
directly in mvebu_uart_probe(). Wrapping it in of_match_ptr() in
mvebu_uart_platform_driver is redundant and prevents ACPI PRP0001
matching when CONFIG_OF is disabled.

Drop of_match_ptr() to reference the table directly.

Signed-off-by: Bramuel Barack <bramwelbarack89@gmail.com>
---
 drivers/tty/serial/mvebu-uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index 33ea496c93b2..8311e4c244f3 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -1016,7 +1016,7 @@ static struct platform_driver mvebu_uart_platform_driver = {
 	.probe	= mvebu_uart_probe,
 	.driver	= {
 		.name  = "mvebu-uart",
-		.of_match_table = of_match_ptr(mvebu_uart_of_match),
+		.of_match_table = mvebu_uart_of_match,
 		.suppress_bind_attrs = true,
 #if defined(CONFIG_PM)
 		.pm	= &mvebu_uart_pm_ops,
-- 
2.56.1

