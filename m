Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6FF3E49C4
	for <linux-serial@vger.kernel.org>; Fri,  9 Oct 2026 05:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791524778; cv=none; b=NVo1ZmagK52pm297qz7mmhgvFSEgA0hLKcNgXJDiQmCZjYUy5egBsY6OAKvuedx5tXNB/lwrvY7XQNKHOhtlE+l81D1WKmJ9EwBofYQOa3L7dmp55Roakr8B3s9Wh1dpxUnqxprkV6oOeZVOUdf/kizdxY2c9yb7xF9EbYGmmww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791524778; c=relaxed/simple;
	bh=plNdXfUivZftRjTvutKcZoqUEVQia1kq0gOec23gqMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RZ7p2aMv6HkwADqhihF+IKTFTylFdPJcKLRZm0yVSxN4Odpgr7hzrpoXjb2L2BtoIbCD4amqGJH7G/nFmOlv3tNPaY/rnGC4Ac6uFfnnUG3aTjNjWApLvSIecRBdRzzGbmYZycCYV3H8RdS6Bcl3XHP0WfvIOJXyo78mMI+AYkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvPTAs3U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvPTAs3U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D8B1F000FF;
	Fri,  9 Oct 2026 05:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791524777;
	bh=mXBVNax2U8pQDhHNZbriNpKOab5rluKme2MlUzw0i0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GvPTAs3U+Yf7KfFnVrjLt1tKAlQ44mzPr1M+BcglTG1vbfU4oWN2i209lLkwRcO/4
	 4kU2EnI8aQiJuVLosTTwvHQ77tH7uDRSW6PDhvRl9DFBsVw60OEBs8oHE8KnTIhF1I
	 M/fxoktGWK5Jf7lsk/k1whhfYDfKkFj58UHOhdyq+MNJEmkkJ239Lg+nBKWZI+LfHt
	 vuvaUymgrZJnT8MhbY61kfAVR8sWUx49/i7bhf7acM/4kRDUVhUBbtIhsKsjcUDapz
	 zE4ofBZ+PQWhzSISBtSt2CU4FvDc7NcFch/jgEbuzKWzug+f4SC2JHBnllZJXkC/0n
	 Yi95TMTD4q1FQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-serial@vger.kernel.org
Subject: [PATCH 1/3] serial: 8250_lpss: do not touch uninitialized line in ehl_serial_exit()
Date: Fri,  9 Oct 2026 07:46:10 +0200
Message-ID: <ef47d676a44346e058f29a00c8701484db722831.1791524724.git.jirislaby@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1791524724.git.jirislaby@kernel.org>
References: <cover.1791524724.git.jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

lpss8250_probe() calls lpss->board->exit() on its error path. For the
EHL board, that is ehl_serial_exit() and it does:
serial8250_get_port(lpss->data.line)->dma = NULL;

But when lpss8250_dma_setup() or serial8250_register_8250_port() fails,
lpss->data.line was never assigned. As lpss is kzalloc()ed, line is 0
and ehl_serial_exit() clears the dma pointer of an unrelated port --
serial8250_ports[0], i.e. ttyS0, which is often the console.

Initialize lpss->data.line to -1 in probe and skip the clearing in
ehl_serial_exit() if no port was registered.

Fixes: 5318f70da7e8 ("serial: 8250_lpss: Balance reference count for PCI DMA device")
Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Assisted-by: LLM
--
Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-serial@vger.kernel.org
---
 drivers/tty/serial/8250/8250_lpss.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
index 776ec1ef29d6..c5257847a94c 100644
--- a/drivers/tty/serial/8250/8250_lpss.c
+++ b/drivers/tty/serial/8250/8250_lpss.c
@@ -183,6 +183,9 @@ static int ehl_serial_setup(struct lpss8250 *lpss, struct uart_port *port)
 
 static void ehl_serial_exit(struct lpss8250 *lpss)
 {
+	if (lpss->data.line < 0)
+		return;
+
 	struct uart_8250_port *up = serial8250_get_port(lpss->data.line);
 
 	up->dma = NULL;
@@ -329,6 +332,8 @@ static int lpss8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return ret;
 
 	lpss->board = (struct lpss8250_board *)id->driver_data;
+	/* for tests in lpss->board->exit() */
+	lpss->data.line = -1;
 
 	memset(&uart, 0, sizeof(struct uart_8250_port));
 
-- 
2.56.0

