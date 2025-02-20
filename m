Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AAF1FFC4F;
	Thu, 20 Feb 2025 11:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740050200; cv=none; b=p+btkPJw/uW7kdNZWVWedJMMeaa2vGBw0sPWJZkWhPys5nmGYcrYhgcurAayzUNgkR17X9OfFVgLRlA/lPion4LD8OcrkoAVAhesNjYdGB/C/VmqxBdO5+4vxAIgNQwoSuX8tYlXyxGkPS828XApPmx1nNARIll5iqZ/4pfHWn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740050200; c=relaxed/simple;
	bh=NWefyehqTC8N6b5xJiLn3iRSos/mZcw/xFIo2yDlpOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QyPqVo+fPnIZB4jv+ETcktUAo2NhEeS1/fMqodc31j2J/9+ue6PNpYyTMSTKIPTKe2wjezMeO4eT2hmqNZ+D3ePelPli4RWmUHfng6vTu88MVf67Jp3hW5TlMFvZ/RNDWxjQM4bdw7AEd9F2pOWU+SJvq5tJBR1rXZbUEDsqzwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+AuI4q8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+AuI4q8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A3AC4CEDD;
	Thu, 20 Feb 2025 11:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740050200;
	bh=NWefyehqTC8N6b5xJiLn3iRSos/mZcw/xFIo2yDlpOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d+AuI4q89zRzHYvZKnA0A1KQUxLMHXe/CtY/lXvz7YbAfeL0TYbb25yrtC3DV07My
	 MNW0ThwxC/pLdSl1Qdvv7XiXzRfpFDNK8tnh+ymnGizdJrRtSjClaae7RJaAYYbaXx
	 wXMJkgn3btlNqiqCbgbcx3TS2Pf8cKomHeBKD3lckwEqyZ9OmAz9zZJUDPbkBjtDbM
	 xVRkRj1idQ1fBGP4db56ITWK1YrU/qXVgldfXeatPMgaHC0C5qHpD1uc4uekBPRhcu
	 Gw9qYQv02ZWcqiqxOjgYZ6q0s8lioubiF4cdijnGyHqO1T6xSHFai8d3GwCadIuc3A
	 PPJTu/Eg/1EGg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 17/29] tty: moxa: drop version dump to logs
Date: Thu, 20 Feb 2025 12:15:54 +0100
Message-ID: <20250220111606.138045-18-jirislaby@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250220111606.138045-1-jirislaby@kernel.org>
References: <20250220111606.138045-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The arbitrary MOXA_VERSION is dumped to the logs when the driver is
loaded. Avoid this as a driver should be silent unless something breaks.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/moxa.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/tty/moxa.c b/drivers/tty/moxa.c
index ebaada8db929..2b75ca12cbc9 100644
--- a/drivers/tty/moxa.c
+++ b/drivers/tty/moxa.c
@@ -347,8 +347,6 @@
 #define	MX_PARMARK	0xA0
 #define	MX_PARSPACE	0x20
 
-#define MOXA_VERSION		"6.0k"
-
 #define MOXA_FW_HDRLEN		32
 
 #define MOXAMAJOR		172
@@ -1327,9 +1325,6 @@ static int __init moxa_init(void)
 	struct moxa_board_conf *brd = moxa_boards;
 	unsigned int i;
 
-	printk(KERN_INFO "MOXA Intellio family driver version %s\n",
-			MOXA_VERSION);
-
 	tty_port_init(&moxa_service_port);
 
 	moxaDriver = tty_alloc_driver(MAX_PORTS + 1,
-- 
2.48.1

