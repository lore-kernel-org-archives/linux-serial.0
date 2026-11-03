Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793666756;
	b=PDqQKgcNLkdlNL+JVx8q4ytfPGF7GzMU+FMdMx89z85xmtq/4z9NGH1vS/dVOtrJrSOG
	 b11G6X5cXzEq+OpGsSiWGLcUgNoEAtrqRVDXy3y9N3OfOsSw/iikhK3ID17SjL1XHptBQ
	 QRdfCyu+p+be3wPMzRjropX4P+XgUTdP5WfgThZvSiCyvEY+1hOU2e9L30AsRWDTZAyT4
	 LAn/YnS8IUEAZHMxuyqNY0XCVmE+QzZL16C1bR3tVC8FppJi9SSBcYXp6rzQcZPTxZd6G
	 TqO1ul18FBiEnmCv3F8v6B6Kzv2cKdtBJ7/pKPYGHzB/gX38a7iPymYmTocUnxlNA+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793666756;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:
	 X-HM-Spam-Status:DKIM-Signature;
	bh=tn2zR8vINusI2egn9LwHOlQ92sKaYJj4tVl36aYhKxo=;
	b=zQ9NjM5iYVp2Q5/cQQKkyL5TIWJ37WQ0rFq10ioZmAoPTGXlA3oCGj5YiTST022Y0d7g
	 A8xShQmkZ4vs1DBK3qMGm6r03mLc/0R5+lWyD3FfCom7IzwzaxAfAd6y1xziGyVO8eYc6
	 gTo9lHjNiIQfFEAfIe+4ECRGkxkXfD21QVQJ7yatkQFsO6DXryy1zNsqdh/j1LUps4f4N
	 +BPDQ1n9wwCBg4vOBH4xEiMLi72ZcudNkZkTtYxQXsXlPwx9CJ3a72ObyXSav3Hi9Q1/5
	 SyfQbDYf6x6nYfgCX+RkXrAFFgdipLIS1gpYY6MyHEU2prt48fMsco5ON9JaQCDhblw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=Uzfh8B9E;
	arc=none smtp.remote-ip=45.254.49.197
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEC3606A324;
	Tue,  3 Nov 2026 00:45:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BEC3606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=Uzfh8B9E
Received: from lgs.. (unknown [101.76.249.61])
	by smtp.qiye.163.com (Hmail) with ESMTP id 533e14b0e;
	Tue, 3 Nov 2026 08:45:48 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Tushar Behera <tushar.behera@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Subject: [PATCH 0/2] tty: serial: Keep UART driver state until ports are removed
Date: Tue,  3 Nov 2026 08:45:45 +0800
Message-ID: <20261103-cmc-tty-0-f5f5ec0841@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.43.0
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
X-HM-Tid: 0aa19ede90a303a1kunm33c27c8011821e
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaT0hNVktNTUxKTU5DTR1OSVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWUtVS1VLVUtZBg
	++
DKIM-Signature: a=rsa-sha256;
	b=Uzfh8B9EEJUGA7VG7PUsaEpxpJqTJmtXkckz0Zl5imQ1aUj6bTHgWvjv4wz/b+u8bt553UXwVIhAKWyzQotBkJ66bl3yo5PtYgSnCbERvRPG8tRq9rjYyECPslHg3yiiIwAkHIp0uII52saa0jqY13VDnvox1ftgzqVf8vTts/Q=; s=default; c=relaxed/relaxed; d=mail.sdu.edu.cn; v=1;
	bh=tn2zR8vINusI2egn9LwHOlQ92sKaYJj4tVl36aYhKxo=;
	h=date:mime-version:subject:message-id:from;

Keep shared UART state available until all ports have been removed.
The two independent fixes cover ip22zilog module exit and Samsung
per-port removal.

Prepared with AI assistance and reviewed by the submitter. The affected
objects were build-tested with W=1; configuration details are included
with each patch. No hardware or fault-injection tests were performed.

Guangshuo Li (2):
  tty: serial: ip22zilog: Fix potential NULL dereference on exit
  tty: serial: samsung: Fix potential NULL dereference on removal

 drivers/tty/serial/ip22zilog.c   | 2 +-
 drivers/tty/serial/samsung_tty.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0

