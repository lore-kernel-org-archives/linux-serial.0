Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A3647780
	for <linux-serial@vger.kernel.org>; Tue, 21 Nov 2023 10:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YgqIBL2U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40FEDC433C8;
	Tue, 21 Nov 2023 10:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700563000;
	bh=PIjehP0eqEivg3HZumQKAr0EcmBF9R7CYwR5clAojnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YgqIBL2Ufsxh1KeTUFZMlePF4h591OjLcG2XY/DJ1xIXlWyOiwEvneE3uNzrZC6cR
	 3WyAveg2Cn+MOEgafZlZgiDAlKgHb2x2fTM7DHIQjpbraXHYqnI7bZgOK0rpmWEzOT
	 BcS1GX1Bljd0VjLf59ycXDu7ZkYc72GpxpiIAIX8M148G2RZ2jpZXfJqRYmfreITX/
	 s2uhxrP86wsH98A0bI78KoBQwbzjJ/uJj8Oma2WEmlpu2rMQxJnp/MJLlWW1S75Nv0
	 zZfYRxIe0VHTv+VyGCI7dhy2IkcJXNfVNhbeRosFyNbNuCYBM1Lu9dRlbWRCGaH3f1
	 bOlcxpKm3tjFg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH 5/6] tty: rp2: remove unused rp2_uart_port::ignore_rx
Date: Tue, 21 Nov 2023 11:36:25 +0100
Message-ID: <20231121103626.17772-6-jirislaby@kernel.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231121103626.17772-1-jirislaby@kernel.org>
References: <20231121103626.17772-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

clang-struct [1] found rp2_uart_port::ignore_rx unused.

It was actually never used. Not even in introductory commit 7d9f49afa451
("serial: rp2: New driver for Comtrol RocketPort 2 cards").

[1] https://github.com/jirislaby/clang-struct

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/tty/serial/rp2.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/rp2.c b/drivers/tty/serial/rp2.c
index d46a81cddfcd..4132fcff7d4e 100644
--- a/drivers/tty/serial/rp2.c
+++ b/drivers/tty/serial/rp2.c
@@ -178,7 +178,6 @@ struct rp2_card;
 struct rp2_uart_port {
 	struct uart_port		port;
 	int				idx;
-	int				ignore_rx;
 	struct rp2_card			*card;
 	void __iomem			*asic_base;
 	void __iomem			*base;
-- 
2.42.1

