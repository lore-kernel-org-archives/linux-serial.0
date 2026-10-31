Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793450360;
	b=ZMX39tdlyDi4XmdpqeE9stTJGNLMeuC//Ip8mAx2mb0wLR5EXRO8seljKNWi4U8T/+VR
	 Xptr/lHMoofTuwYV3vss9S5w1ItXp2ch81fsew/trKlIpVMZi30ZrjqbDDSnv9lIMAXlH
	 cTBiS2Pz5UDJ3TDyv7pFXfbifMY7llFm4azcTOeh8fI+pTJ3CA+lOzIlF11hWpVjYRKqh
	 iopKaf2cmlNdQ2JO5GA25HAFonl9DpUhMs+I42UwRqifg0q1ekdjn91d5CNMyt1UdlkHd
	 BCk4gUwGYTepuTOG08I3UKwEQ8OgBpaIMZJSclHWfb+nM/zGsEF5NG0Cmi8vXV1MaRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793450360;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=p+SP5aC6kFf2m6+Y0UAcy1XbuoZimqxQ+Qboov/RQdw=;
	b=R8dkhjBY0kZlUyd9NnbsXCNX9wY/4mTVMTiLrhtjtTf0fwdUv6P0DVh8iTe3l1/Hyyb8
	 yBz82gMKmtI7tPxKORuFGqTRcoRZQ30JOsxcVhzKBnWz3hKdh/O6gT8pMyfy+gdRP6FRE
	 rBe1AnvJf+ZKP7nprdeir70MDCND+1y2iFl87jQjruZLlRvmQINWylZLLc2kXwGy+2ORN
	 lrlwtzj/ArotIzUdl3i/zcLZrd3yl7k4+V/L8UMNylPZMP8y2i84QyIX8YxgSpMYPRr+9
	 4pgYfa6qtbm72knw7ulHTw5oVlKmvGFC+IZZcLo2XIunfBUCUFr4yTL9EapDwIaCDog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xKL4FZYZ;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCBD606A325
	for <linux-serial@vger.kernel.org>; Sat, 31 Oct 2026 12:39:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BCBD606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xKL4FZYZ
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-35829219da8so3139587eec.0
        for <linux-serial@vger.kernel.org>; Sat, 31 Oct 2026 05:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793450359; x=1794055159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p+SP5aC6kFf2m6+Y0UAcy1XbuoZimqxQ+Qboov/RQdw=;
        b=xKL4FZYZxZ2DMFO63mud1fJJvL8ljHKd1cSzKueTBjZ5KWdT9ssOnP0v+oXC+Q0hZo
         Qs+PHJ9Klrp7eA+ZXpy9jf3Dvec5+bt97LOlRXjZ2Q/ZQk3duWOE8JWGvfSgl57vgWch
         JCwhFXX9MgJGW590FuwNWfZumZRtLkpFT5T7+6Bz4lAo+aIOdOUI37/Kc3CAmRyY4HcK
         W41yN4QDz1O5X8AHfcEF+5+xoVAARl8Hp+FsH+KuRBB/WuH0FK/KGowokkDV3UY6/ekT
         v7y6LWO5F42Vjer5ob4L76hFwBAGTlmtyimH5jt8uYFW8EL+iFHLnr9Tu8b/QEml5OWf
         mHPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793450359; x=1794055159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=p+SP5aC6kFf2m6+Y0UAcy1XbuoZimqxQ+Qboov/RQdw=;
        b=Q8oskmaVeXZTDm2X/wMs+9QPC9otVBbbwG2vZ9O/128v3+MW/6WUbKnzTzBZYjJ8vG
         TjrXf5M++ZuMfIak9I4nPWbnVaTL6qXLPD2teW4nhavLPD3Ugk42ONqKWLdOhvfr36S6
         7YGSlbUhvhXb3+jgPhT4dHO3K44cspn6VElvWk32ZoM8CmTlvjfmwbbI2gjw54oKiepF
         nBZHYVxiHZPcw6h3qNJfqmZ0u8Es3sah5aJCGXyUWpndMHEgv7crKzvdVzvTEyhpjTOj
         vFTdu5V9ixQN7EdYCEatMhmh/ysIKK6XhArg0XsTGhmFGIlhN3e59nPU8LvXzj9+MQX/
         o/pw==
X-Forwarded-Encrypted: i=1; AKwUvBwZDa7ouApqPnOqwfpwiziqMPosrgJTHGL9YXn6z7RdzEdMnmue582xuOY5R0KJlAvbL6EqRoqN5AlKIj0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLU/8t4390QUsNaENGAWQv8+EmnJwW5bh1LNw766+So1O29I8ZD
	nhl2BqeoCiGyDgfkee818EQSS5EF9PNaTNH8v3hd1nqRvQbu2sKqNQt7
X-Gm-Gg: AYBFou3cblR6TwSYr1wi3pfWEARaghWjhHDYAC+426k1f7109C9qnzf6eEieTI6+8Qa
	vawqMxRgcjD1IafEPevfZ2lO1HRmLiB2UOvnfcQHFgeN9YxBp4S1tQFBvvn14ShS/1g93MZ/mVE
	EGea8buCBuWlAci+OS+YGHsgSSKcKvrW4nAzApv01rQSKXZYC1j/utZHLA8kWL3ky/QkWchxtea
	bcBsnfe/QSIVRivDrOXDMZYbCRPaXgUgyYO5YlHS/o9HQwwhPNuSZ9JKq942suY3rBh99lCJ1EP
	COsKiZDmTKf35SyPqY/7Nvu5pQr2FNM16rnfiwpv/1+2yZojlmEuSZar/kr+L46TZ+5N1NpLK4X
	yEVv1kUhUIk/p1bldsQvAx9NFB4uExs1UvQQCfVg6NuoWeTQgVOb+z/3HOwqC/ECH0LlQ+UrjWa
	ANma4rBHZcbcLC/I1kBA0fby8Ns1vFjmqA3MQc8yANfQZEFINFjhoGqhC16SFvu8ZQZ6zPS3r+Z
	n2NcSoQrOECjLInLqdS1rjpJV9BvKKDBhgfhqkX1+LutWNeLG+edqwDO5bvgFhA6ri0/cCj0R9/
	BBjjdQVUGc5XU9hnopg14a/OfVvtT75D6pqCrclkY2Q1aSqjeExDjjYi1BreQ8mg84TIKrQT54j
	FToxHOAW3+GrJkdp9+rTNERUpuItLZrgxs8ZO2lj1iAu/HMXPwNpS0IOysYX5/kmcQACWPf0GGn
	EXN9Y7Uunzd5/T7Q==
X-Received: by 2002:a05:7022:f507:b0:1ab:90a8:87a2 with SMTP id a92af1059eb24-1ad1077e9a6mr5123543c88.11.1793450359362;
        Sat, 31 Oct 2026 05:39:19 -0700 (PDT)
Received: from brev-9gdpyq8lp.ap-south-1.compute.internal (ec2-3-110-210-194.ap-south-1.compute.amazonaws.com. [3.110.210.194])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1854da78sm21566039c88.6.2026.10.31.05.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 05:39:18 -0700 (PDT)
From: Samarth Narang <samarth.colleges@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Samarth Narang <samarth.colleges@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	linux-serial@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] serial: fix TX kfifo underflow on flush in five drivers
Date: Sat, 31 Oct 2026 12:39:06 +0000
Message-Id: <20261031123911.3784690-1-samarth.colleges@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261031004733.3345841-1-samarth.colleges@gmail.com>
References: <20261031004733.3345841-1-samarth.colleges@gmail.com>
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

This series addresses the TX kfifo underflow reported in the parent
thread, where uart_flush_buffer() resets the transmit kfifo but a
completion callback from an earlier DMA transfer may still call
uart_xmit_advance() using the byte count from before the flush.

The fixes take two approaches depending on how each driver manages its
TX DMA mappings. In samsung and tegra, which map the TX buffer once,
samsung's new flush_buffer() terminates the outstanding transfer, as
tegra's already does, following the approach introduced in 8250 by
9e512eaaf8f4. A completion already in progress skips the kfifo update if
the transfer has since been retired by flush_buffer() or stop_tx().

In sprd, msm, and pch_uart, which map each transfer separately,
terminating DMA there would leave the flush hook to unmap a buffer the
controller may still be reading. These drivers therefore leave the
transfer running and mark it as flushed, allowing the completion
callback to unmap the buffer without advancing the kfifo. This means
that the data already queued for DMA before the flush may still be
transmitted.

All five patches have only been compile-tested with arm64 defconfig and
the relevant drivers enabled, including pch_uart through COMPILE_TEST,
using W=1 with no new warnings. I do not have access to the affected
hardware, so testing by someone with suitable devices would be
appreciated.

One race remains, which is also present in the 8250 fix: a completion
may already be running when the flush occurs but acquire the port lock
only after a new transfer has started, potentially mistaking the new
transfer's state for its own. Preventing this would require tracking
individual transfers, for example with a generation counter, which I
have left out of this series to keep the changes focused.

Samarth Narang (5):
  tty: serial: samsung: fix TX kfifo underflow on flush
  serial: tegra: don't advance the TX kfifo for a flushed transfer
  serial: sprd: fix TX kfifo underflow on flush
  tty: serial: msm: fix TX kfifo underflow on flush
  serial: pch_uart: fix TX kfifo underflow on flush

 drivers/tty/serial/msm_serial.c   | 19 ++++++++++++++++++-
 drivers/tty/serial/pch_uart.c     | 27 +++++++++++++++++++++++++--
 drivers/tty/serial/samsung_tty.c  | 22 ++++++++++++++++++++++
 drivers/tty/serial/serial-tegra.c |  8 ++++++++
 drivers/tty/serial/sprd_serial.c  | 24 ++++++++++++++++++++++--
 5 files changed, 95 insertions(+), 5 deletions(-)


base-commit: 36aad21d50d1af3f6954bb0c988257a908202477
-- 
2.34.1

