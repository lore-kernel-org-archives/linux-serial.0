Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E97018B47E;
	Thu,  8 Aug 2024 10:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723113358; cv=none; b=HYcWpxuSJtMJ09ewhpGjhFWC6GRR82vNU/4exwjk7qtmMQxWcTUb9wdz7vTgRwOItylxpzwfryOjsZVp59ewYff0BBbn8hHPwO34WfjheQPeou1ljxqP0spR2l4UUI8WBkcoUWaxSFFZ/aE4wNCjrLkAmDt2V66kyViapilB8bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723113358; c=relaxed/simple;
	bh=gJTxTjqmJCVhdU9++PAKLolxpY0IlAQM2n9t5U9kci0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s5tb4E0r3S0wZMxTbfcdPinft1SSe49rxFGZNl2EnDAMHGWyL0R6hQL/Wmp/1gC5F7qbqPJwYpclj7h5VXf0Ah0qpOZBU8h+/HZ8gM+9/KjtM5y9KPRqgkjKZUmV7apQ39EXV9UQc9OVaK4LeaKQZiKAO5ZUm/EQf/UAp8KO3cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U8us/cGW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U8us/cGW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5634C32782;
	Thu,  8 Aug 2024 10:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723113357;
	bh=gJTxTjqmJCVhdU9++PAKLolxpY0IlAQM2n9t5U9kci0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U8us/cGWgdDVgFmiMzR8gXC4HkXz6ECM6C7sY/ja0yKNPqft2tCyubr9veZGuUSQ8
	 QVoUKkU39bhttzcXjFzJGwC5jbgIICj3OIdFOJnnxEkaY9KnRi/fTGY0mOpcuAqUW+
	 Oe6Q79Nh8mMzfZmTgPWqYwW4m6HMK3/NvXcJaK/wzWbdyim6wX/G70ubTFJ0FYHWFb
	 7voGsoJtACM5gRsEFDBPgq0dAIELu80Z6tD6gh/qnV4ZblOdxE3mwoDw0rNOhyDbSY
	 yb7xJlID4kMojTCmm+YzUw2/xqp0QWgIV0eJHS415DvUYZAV/91zCNYS73BagDX77n
	 1+YJ1+T4TCLQg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH v2 02/11] mxser: remove stale comment
Date: Thu,  8 Aug 2024 12:35:38 +0200
Message-ID: <20240808103549.429349-3-jirislaby@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240808103549.429349-1-jirislaby@kernel.org>
References: <20240808103549.429349-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comment mentions ISA removed long time ago. It also comments on
.driver_data pointing to above structures. That is not true either.
Remove that.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/mxser.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 5b97e420a95f..9a9a67b5afa0 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -208,9 +208,6 @@ static const struct {
 };
 #define UART_INFO_NUM	ARRAY_SIZE(Gpci_uart_info)
 
-
-/* driver_data correspond to the lines in the structure above
-   see also ISA probe function before you change something */
 static const struct pci_device_id mxser_pcibrds[] = {
 	{ PCI_DEVICE_DATA(MOXA, C168,		8) },
 	{ PCI_DEVICE_DATA(MOXA, C104,		4) },
-- 
2.46.0

