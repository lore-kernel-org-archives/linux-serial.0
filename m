Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAD3221DB1;
	Mon, 17 Mar 2025 07:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742194878; cv=none; b=DZNZaDS3Bnag1Odop96hWRQevvJvcZFmUq3IHg9rBN5tlYc8nXU0Legwf0cF6f/jf1kZKgaEFc55sI+O0J9TjXuRgdVwoVAZXOqnkmnrYC266T6hTNuiBZOcADgL6SXqJ/ZXXbnklGbOvjKtnxEBdphm+6A2xL4iDX8NVPcrnMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742194878; c=relaxed/simple;
	bh=mDzvyTMQJLkOu1LY+PUR5ramtgI2tETWjY3grzntzH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JLos4i4bBEHnzR+yIL38zfOkhD3yL2qQgSqxDmNojbL0zoXDDkyYJ020aHn+VRuco2xDAZnfXUhBnWKYyThWswG1wyCyIYlP9OeYVBDSB44XT+v0QaJz9OFQj663KrwKM9nV35wooIopM9R8O2U1hBOSorlyT5ssEpnRnmtjeAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gubqrvhu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gubqrvhu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A8C8C4CEE3;
	Mon, 17 Mar 2025 07:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742194878;
	bh=mDzvyTMQJLkOu1LY+PUR5ramtgI2tETWjY3grzntzH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gubqrvhuHzedp/HG6z//o6qcsxH8DYVSEFElNo2GwGS1k/PthCY+eQCYkOfwD7WS6
	 bB75WgN/5uipWlFp3d84H5eXK90WwusveHMeHweokF8vl8jg3n5vyXUFUhO4bn5Qhn
	 Qnk31KfS3tEhxytoFlNXXfGA4ywnaAGL92kPyZAcOcNxQRlNiXw0udT69VPZTdWLL4
	 GmxItSvjC0WAmereI15Q+aHgZGK9F3qDmfMBVDRArOKTwIDE9Agn309YfZ0tOjWk/w
	 x/uSC0vYRRL4VhsnLR8yK0P/hdFv7PodcRoA0jE6xsz48TxHdlMjGgux6HJ7R/kbOJ
	 yqawVcMAqX/Sg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH v2 18/31] tty: moxa: drop version dump to logs
Date: Mon, 17 Mar 2025 08:00:33 +0100
Message-ID: <20250317070046.24386-19-jirislaby@kernel.org>
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
2.49.0

