Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439D33D3AA
	for <linux-serial@vger.kernel.org>; Tue, 21 Nov 2023 10:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jL1qGK4L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3C6AC433C7;
	Tue, 21 Nov 2023 10:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700562998;
	bh=gYNUG4npFwZVxiI0KAeDKVJO+CZmchirHrnJPjLRzrg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jL1qGK4L9thFFk/ZGqToKc4xbLb3qHBFTkNCUOSyhwIqdJgLb5SvApx1McOqjqYvY
	 g0ZOaFMWTTczCN+tmQKQP6IV/yhzYFz7NhCl1MbgpUhDrKn3TY0akHXirl261UHQIS
	 Jo1A87sobcOZLNI3+BXQkdco2DpqP31YCUreoRWsOcVsqHw0ESIX7HbIctVAYNwBAL
	 cqC9qAGO2GjfmZdy8EylmCQ7jVzUidC/ygAmDA7xTbOf8nClHVOkf91lFrdcSE5pWh
	 FJBPqDCfyJ/TmHmuV7nxlmZv7XLmfa3Mz2Oykwnaaae49HyDcpein9lPvv4tETyomr
	 R8JsHFKpaAQHg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 4/6] tty: jsm: remove unused struct jsm_board members
Date: Tue, 21 Nov 2023 11:36:24 +0100
Message-ID: <20231121103626.17772-5-jirislaby@kernel.org>
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

clang-struct [1] found jsm_board::type and ::jsm_board_entry unused.

::jsm_board_entry is unused since 614a7d6a76b7 ("fix up newly added jsm driver")
::type was never used as far as I can tell. Even when the driver was
introduced in the pre-git era.

Remove them both.

[1] https://github.com/jirislaby/clang-struct

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/jsm/jsm.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/tty/serial/jsm/jsm.h b/drivers/tty/serial/jsm/jsm.h
index 08a42f045ec8..df55e5dc5afc 100644
--- a/drivers/tty/serial/jsm/jsm.h
+++ b/drivers/tty/serial/jsm/jsm.h
@@ -125,7 +125,6 @@ struct jsm_board
 {
 	int		boardnum;	/* Board number: 0-32 */
 
-	int		type;		/* Type of board */
 	u8		rev;		/* PCI revision ID */
 	struct pci_dev	*pci_dev;
 	u32		maxports;	/* MAX ports this board can handle */
@@ -153,8 +152,6 @@ struct jsm_board
 	u32		bd_dividend;	/* Board/UARTs specific dividend */
 
 	struct board_ops *bd_ops;
-
-	struct list_head jsm_board_entry;
 };
 
 /************************************************************************
-- 
2.42.1

