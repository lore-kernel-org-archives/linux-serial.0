Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2902035962;
	Thu, 17 Apr 2025 08:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744877626; cv=none; b=OPwPROR70/Qf7pJtK9NcNYMl0w59+qbv8OjYDmOWYjEnCtOw4kw2kT5VY30pgeWfq1cLdtKh2TftPmj6aGn0ii+MHl5l0dusHBATx4YOlbDvX3oOusv5sSeON5dUD3evwl8t9+DBm49PAtOo839McNN28iii0cUo3peakHHt8KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744877626; c=relaxed/simple;
	bh=zyU+Avmsupi03n5Di+kk3CCOVSwpjgJNzIO0CDPpUu4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H5ROccLrspj8F9O0/zWDtqf5lT3aeYPxETXVtQ31bS4EGa7Gu3vyHrpdt5Rr+FBP509h25eUyqesCChZWnY5bcG6S4Tz76C6wI1qhmyHp6iceBEZaj8GMx9C96CqrOKHQBuIpi4Y7vKhzYVJrHmmnZpafBYLTtMWzq8+rw+JXyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMUsly6C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMUsly6C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56139C4CEEC;
	Thu, 17 Apr 2025 08:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744877625;
	bh=zyU+Avmsupi03n5Di+kk3CCOVSwpjgJNzIO0CDPpUu4=;
	h=From:To:Cc:Subject:Date:From;
	b=JMUsly6CkJBosudFvHyYQiPEAS77Sz/TzCUbyo3NPgAPy444unATlz2zFtmuFjd0E
	 GIJFNBF4NPTOeACGcAQINWkdlACY1DDuvm2J/OzclZ6D9Ii7NNTfEoee+Tn42CKUm4
	 rtRH8tQPuPpAKKwK14Er0QO0iCBCDotee6A8SdYN+z/t1iTZfPaTUZftaCTUk4S/Iv
	 93LWgZCuGzM07dviRIyK86w1ED9b7+qRmFG5vpV42WRw2u8jTsO5fPZZOkVtaThLaQ
	 k5fVV+Up9ZKHe9nbaysX8EOFL8IjJz54oNxG7GH0x0Lg1dqjgvh7Ebd3UQ1JQD9GlZ
	 cBFEhsfzpL0NQ==
From: Philipp Stanner <phasta@kernel.org>
To: Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Philipp Stanner <phasta@kernel.org>
Subject: [PATCH] mxser: Use non-hybrid PCI devres API
Date: Thu, 17 Apr 2025 10:13:34 +0200
Message-ID: <20250417081333.20917-2-phasta@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mxser enables its PCI device with pcim_enable_device(). This,
implicitly, switches the function pci_request_region() into managed
mode, where it becomes a devres function.

The PCI subsystem wants to remove this hybrid nature from its
interfaces. To do so, users of the aforementioned combination of
functions must be ported to non-hybrid functions.

Replace the call to sometimes-managed pci_request_region() with one to
the always-managed pcim_request_region().

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/tty/mxser.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 4d45eca4929a..2fc13cc02cc5 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -1812,7 +1812,7 @@ static int mxser_probe(struct pci_dev *pdev,
 
 	/* io address */
 	ioaddress = pci_resource_start(pdev, 2);
-	retval = pci_request_region(pdev, 2, "mxser(IO)");
+	retval = pcim_request_region(pdev, 2, "mxser(IO)");
 	if (retval)
 		goto err_zero;
 
@@ -1822,7 +1822,7 @@ static int mxser_probe(struct pci_dev *pdev,
 
 	/* vector */
 	ioaddress = pci_resource_start(pdev, 3);
-	retval = pci_request_region(pdev, 3, "mxser(vector)");
+	retval = pcim_request_region(pdev, 3, "mxser(vector)");
 	if (retval)
 		goto err_zero;
 	brd->vector = ioaddress;
-- 
2.48.1

