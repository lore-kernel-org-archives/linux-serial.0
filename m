Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416CA21B9C8;
	Mon, 23 Jun 2025 07:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750664776; cv=none; b=oUHnq7CB/ERMxMUH9nyNbCamVIQmftqUxN53jr2qYCQHtr0lSWxHGxSL+7zvoRa1dEv84S2DR0A1JuY8pNCohMG/WYGISY6xUzKPWsk6JF/ua3Crarta3Ujg0y3ISyU6OLXs/IuFusLwmUONGk6dsaGMUIKbtpNIhat99N6r5JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750664776; c=relaxed/simple;
	bh=smpKSO6O9D81D3q6N5YAOrgecS7Nl7xNAoJ7zHJtccI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UV9PsxIyzqUIKkAICbBb6XHoECY8iMZX/AKMIzyqnjD9eTL/EHxB1xW9N2wEFz58LH9MF2XsA3aiLIhGAUdCLjPDGUm9BztANOJzNp14NvyslxA/qZ3agS1SeMbdUt60RkQbJGeK46PBtsExxLHvxc3L+yFMOAsnB+WyExjRCcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wis3Uiic; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wis3Uiic"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A3AC4CEED;
	Mon, 23 Jun 2025 07:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750664775;
	bh=smpKSO6O9D81D3q6N5YAOrgecS7Nl7xNAoJ7zHJtccI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wis3UiiclxSQdffgfqsnVlk2ELRucQmBF4WJ/dezNyPE/Yt6ne0HSvYJcU1C97JDf
	 bVa/4Bh3eXgY4tEkK1vCBEbcH4PviDpofxFCwrWQjuai9i+dikL0cGjtE8pvMLJxB5
	 FaFF1A81FMcJfa3rdenQqXlStObwGMHLvYcXmEm9kiXsWU7dJ+WU/WbBAw4sjkFlVO
	 /w3QP7dyMPq5Wuyw1XCEDQNVTvW1YSCiufj6GI2OYgtESYNPwVElDKKtroi1ITiwca
	 ADRfTUtRCHjM+Bs/pE0CGqbi10XUv5WMe9LbzuVYSrwL2LGP9o7HBGJzpgrl3IUyMY
	 SJxofE9FSeVDw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	"Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH 4/5] serial: 8250: document doubled "type == PORT_8250_CIR" check
Date: Mon, 23 Jun 2025 09:46:05 +0200
Message-ID: <20250623074606.456532-5-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623074606.456532-1-jirislaby@kernel.org>
References: <20250623074606.456532-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The check for "port.type == PORT_8250_CIR" is present twice in
serial8250_register_8250_port(). The latter was already tried to be
dropped by 1104321a7b3b ("serial: Delete dead code for CIR serial
ports") and then reverted by 9527b82ae3af ("Revert "serial: Delete dead
code for CIR serial ports"").

Document this weirdness with a reason.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Link: https://lore.kernel.org/all/aFcDOx1bdB34I5hS@surfacebook.localdomain/
---
 drivers/tty/serial/8250/8250_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index a6ecb8575da4..feb920c5b2e8 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -717,6 +717,7 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
 		nr_uarts++;
 	}
 
+	/* Check if it is CIR already. We check this below again, see there why. */
 	if (uart->port.type == PORT_8250_CIR) {
 		ret = -ENODEV;
 		goto unlock;
@@ -815,6 +816,7 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
 	if (up->dl_write)
 		uart->dl_write = up->dl_write;
 
+	/* Check the type (again)! It might have changed by the port.type assignment above. */
 	if (uart->port.type != PORT_8250_CIR) {
 		if (uart_console_registered(&uart->port))
 			pm_runtime_get_sync(uart->port.dev);
-- 
2.49.0

