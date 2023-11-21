Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7BD16415
	for <linux-serial@vger.kernel.org>; Tue, 21 Nov 2023 10:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJS2/TLH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF5FEC433C7;
	Tue, 21 Nov 2023 10:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700563002;
	bh=ZUbsMm06fEd3nF1lhwAHhD7S+m2Uiy8kDq+uaKpBn3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DJS2/TLHg6Kc6CyARmWS+Z7QYMmd2Rx11qBg83meZSGR0y4cUwo3RvTZ0oX8WedYS
	 4zy5ksaJWE73HiL/d6Ig+JtZJ2t6G5tXuJcIoR5Re2O1NAqPe4XfP4h59EiU5I++Xj
	 4ImSAzcq2ucVD6OeHSAASpOVnsH0i+PP13ApE+691H+lgrUfZ/kxQWBepxWU+lRV9L
	 /bouSem61tHv6tiUZ7//5f7/2fExefTtU0s7cmbE7LTwI8s1OGSeEie0QR/wphEv2o
	 qaqPIk5exwAYZzuV9Q0Kyro0FbtTE2c/ZxMaX03CAAkvePf2t5QIyfn/Bn2iZHonMy
	 FaOscFZQbSyLA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 6/6] tty: serial_cs: remove unused struct serial_cfg_mem
Date: Tue, 21 Nov 2023 11:36:26 +0100
Message-ID: <20231121103626.17772-7-jirislaby@kernel.org>
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

clang-struct [1] found struct serial_cfg_mem's members unused.

In fact, the whole structure is unused since commit 6ae3b84d9793
("serial_cs: use pcmcia_loop_config() and pre-determined values"). Drop
it completely.

[1] https://github.com/jirislaby/clang-struct

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/8250/serial_cs.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/tty/serial/8250/serial_cs.c b/drivers/tty/serial/8250/serial_cs.c
index dc2ef05a10eb..2056aed46688 100644
--- a/drivers/tty/serial/8250/serial_cs.c
+++ b/drivers/tty/serial/8250/serial_cs.c
@@ -90,12 +90,6 @@ struct serial_info {
 	const struct serial_quirk *quirk;
 };
 
-struct serial_cfg_mem {
-	tuple_t tuple;
-	cisparse_t parse;
-	u_char buf[256];
-};
-
 /*
  * vers_1 5.0, "Brain Boxes", "2-Port RS232 card", "r6"
  * manfid 0x0160, 0x0104
-- 
2.42.1

