Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A1236A03F;
	Thu,  1 Oct 2026 19:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790881448; cv=none; b=kKMJVqK9dWEMxRsG79X3vCHqQZA8DZ4pt5xB37wSJOyFQbBw2ZrHAyhnD3RPwFnbKRpZq2yR6yzxW3QwNcPG156GmxzhXatLqvlUHyngtlqzZoDuFzP8EENZkIaQ/hHDmFJgAEcWVKf8lG6G4nFAP78ZIvaR7dPxlhUeaN1AoCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790881448; c=relaxed/simple;
	bh=9XtP5s+6px+vcmdX3grt0ZWYypbBIl6mH/XKasH8JVE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CvHCYBFFN9CTlfDymMp96um6NgXFkEg35A9NoaeRUfYC+cACAKI68W/7K6KjXCHctGzrrju9bYcxA/c5Cc0dWTAvwx2fT3v4UGPLvD3FrSJK/1uRp4K5AW9n+XmEYAVU9Lkv0AqEF3mg2FbihAG7wg4RGUuhNt5oNKo1i8UFm0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r2smebim; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r2smebim"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 532DBC4AF14;
	Thu,  1 Oct 2026 19:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790881448;
	bh=9XtP5s+6px+vcmdX3grt0ZWYypbBIl6mH/XKasH8JVE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=r2smebimXz2B3NdHCsQwEPzFeHou2tnFD92FbmbClD83qVLc+q9X6jzV9HTL9a+8Q
	 //JaCFuqQmWveBZw2sCjXRyDswU1swG4SAVZYLTL4Xi3+RC2EKr0YDifWv8i21Vtr2
	 zjRcvSfIpRVLcFarQv7TFPVxvlvuBRgcvv/7qJrCJaH2GYTPY16N/uucR+o4YxVFN5
	 il8HQkn4WeWvuh4Sf1BWIo0Pt9qxp1Z5kd3mQ3AEFn1GhAQD8bcBEV0pPhgdcytVxz
	 jcX5pNejcg69aPkCF2EEi9fP2vtasJT41M9rxV61w7kMPwNiI9cIoXnOGEGh7PSnWO
	 Fpfb7oemNlAmA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4AACA5FCE;
	Thu,  1 Oct 2026 19:04:08 +0000 (UTC)
From: Austin via B4 Relay <devnull+austin.schlegel.arthrex.com@kernel.org>
Date: Thu, 01 Oct 2026 15:04:02 -0400
Subject: [PATCH 2/2] serial: tegra: fix TX DMA descriptor use-after-free
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-tty-linus-v1-2-ecb8576c802d@arthrex.com>
References: <20261001-tty-linus-v1-0-ecb8576c802d@arthrex.com>
In-Reply-To: <20261001-tty-linus-v1-0-ecb8576c802d@arthrex.com>
To: Laxman Dewangan <ldewangan@nvidia.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-tegra@vger.kernel.org, Austin <austin.schlegel@arthrex.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790881447; l=1877;
 i=austin.schlegel@arthrex.com; s=20261001; h=from:subject:message-id;
 bh=EMsy9Br5xSelbXG4rnyA2/UBqNiR5fGd7V9vJ3r0J7g=;
 b=aBZdd0zi3InfuISzL706K+GAJ8ezKP7VhIrjg+LdtoLIQS24CuYoV+SzXwa0ITCY/2k9glNSj
 3XLzMXG8yO9Alh156F4Cz8d3d4kki7vrdQIYTlhE2YYs6m5yn11klgE
X-Developer-Key: i=austin.schlegel@arthrex.com; a=ed25519;
 pk=IGtNH5dFuS24wm8/+OsmhjREhHB9V7zR8eOgh3sZo3s=
X-Endpoint-Received: by B4 Relay for austin.schlegel@arthrex.com/20261001
 with auth_id=1096
X-Original-From: Austin <austin.schlegel@arthrex.com>
Reply-To: austin.schlegel@arthrex.com

From: Austin <austin.schlegel@arthrex.com>

tegra_uart_stop_tx() calls dmaengine_terminate_all() and then
async_tx_ack(tup->tx_dma_desc) on the descriptor that was just
terminated. With the GPC DMA driver, dmaengine_terminate_all() frees
the active descriptor immediately, so the ack call that follows
touches freed memory, the same use-after-free pattern fixed for the
RX path in tegra_uart_terminate_rx_dma() ("serial: tegra: fix RX DMA
descriptor use-after-free"). dmaengine clients must not touch a
descriptor once dmaengine_terminate_all() has returned.

Move the ack before dmaengine_terminate_all(), while the descriptor
is still owned by the driver. tegra_uart_tx_dma_complete() already
acks inside the completion callback, where the descriptor is valid,
and is unaffected.

Found by code inspection while fixing the analogous RX bug; not
reproduced on hardware, since triggering it requires stopping an
in-flight TX DMA transfer (e.g. via a modem control line or flush)
at the right moment. The RX and TX paths share the same
dmaengine_terminate_all()-then-ack structure and the same root cause.

Signed-off-by: Austin <austin.schlegel@arthrex.com>
---
 drivers/tty/serial/serial-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index c9ec633e7164..0d1a2ebe2a59 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -625,9 +625,9 @@ static void tegra_uart_stop_tx(struct uart_port *u)
 
 	dmaengine_pause(tup->tx_dma_chan);
 	dmaengine_tx_status(tup->tx_dma_chan, tup->tx_cookie, &state);
+	async_tx_ack(tup->tx_dma_desc);
 	dmaengine_terminate_all(tup->tx_dma_chan);
 	count = tup->tx_bytes_requested - state.residue;
-	async_tx_ack(tup->tx_dma_desc);
 	uart_xmit_advance(&tup->uport, count);
 	tup->tx_in_progress = 0;
 }

-- 
2.53.0


