Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9344A2356DB;
	Mon, 17 Mar 2025 07:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742194901; cv=none; b=S34O5RwZa0ZkmtD9SQCKqklq2WX1J1BbVvKekxgHApp5YIFnyOMJU9Av/1t2p1d0eLFHGRIALoJVQYH/5H6CGEnNetf0NGzvQ9mgEEwfSdoFN4cJfcI/BVQ6UL6jdQFY5eI7ZqXL3e/g7wLKpcdZx5os4pP1xBRJSkJ/scjfpNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742194901; c=relaxed/simple;
	bh=DNNEffSPT7NpR4ueszPoeFAk+N1pzzZMTLBTDGxrgBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cpoOgA8n4lOmMU3P8ysHrZLqQ3cI38vw23g2pViC9FpOIdULky5xIdjdve8u00NBIpR+flzSWQA9tPhF5RegKOofkg2CzZ1l/7WdsNRfOT2+OX+i8hO7q9SjUGyH7h5gbxGwdwO7FY7Lv76yifwCT0l6LNuJ3XXWhjzx/yJSPh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JnreIRbv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JnreIRbv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF5AAC4CEEC;
	Mon, 17 Mar 2025 07:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742194901;
	bh=DNNEffSPT7NpR4ueszPoeFAk+N1pzzZMTLBTDGxrgBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JnreIRbvZoMKSKrwHK8GiBm2XFbkvc3FER7xeY8AguLwfkF4KkXTwlUU7nl3xUuBD
	 AIujIK1Mabgdp5lzg9OsvVj11w79+/msVNYw905cYKms9duLMuTDpjRgdTi2yJA7Om
	 FCcWjT/3T2szQQzv8mFTD6H1/A1pNYAxX4fq5oHhHunU6uKxr7F1qoALuF3L7MfIpT
	 kR3+ts0nWKtSGBzgpbLIg/0KYX90jnSXLWJTm/x3GMFJOf6diKsBoooT/YviBc1L/a
	 CSF03w4F4c4+pzIksmUc0IQO8qRiQ2EDg2efnXWcdvN7tZM+DKPQdJoeiS+ZorgKds
	 x8E5y9TxcNJCg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH v2 31/31] serial: switch change_irq and change_port to bool in uart_set_info()
Date: Mon, 17 Mar 2025 08:00:46 +0100
Message-ID: <20250317070046.24386-32-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250317070046.24386-1-jirislaby@kernel.org>
References: <20250317070046.24386-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

change_irq and change_port are boolean variables. Mark them as such
(instead of uint).

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>

---
[v2] this is a new patch
---
 drivers/tty/serial/serial_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 0dbf75b25ff6..88669972d9a0 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -895,8 +895,8 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
 {
 	struct uart_port *uport = uart_port_check(state);
 	unsigned long new_port;
-	unsigned int change_irq, change_port, closing_wait;
-	unsigned int old_custom_divisor, close_delay;
+	unsigned int old_custom_divisor, close_delay, closing_wait;
+	bool change_irq, change_port;
 	upf_t old_flags, new_flags;
 	int retval;
 
-- 
2.49.0

