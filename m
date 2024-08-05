Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589A0558BC;
	Mon,  5 Aug 2024 10:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722853262; cv=none; b=tOB30/eZmhsHxF8Kar4Kku+aT9jxaqa8UbTHxkzGuSDmOhEfM0D/SstuKD7uFDF50Rqt4k2E8x0DarGs1SC9MJk6DOvavP0sXeRvghc55Y6iiU2e2qwRF5T96o6sTOLZcrvu3QsJ+Qiwvf2Fu9qDVXt5Lq+qQJ4Kp00y8uj2y+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722853262; c=relaxed/simple;
	bh=gJTxTjqmJCVhdU9++PAKLolxpY0IlAQM2n9t5U9kci0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dj0K0ASHfEUpHBkcgUFtui9h1r6cQ58u+lOuKU8g+iDKhshTAJ5S1q8zM6S7rRUYZr6yyWYcsvs5Jv0APZMc5w3WJT1kW/JzHXud93MVcAUJ+ojrFfV2Z+hevOpZKDdjJ1bF3+NbC7bHzkBiYqAIq95r51QFlPGw9OebYEunKjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qieHvDXn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qieHvDXn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E51DC4AF0E;
	Mon,  5 Aug 2024 10:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722853262;
	bh=gJTxTjqmJCVhdU9++PAKLolxpY0IlAQM2n9t5U9kci0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qieHvDXntXOUIdPEFDPYTMdoX6TV+wURbFswO9KsIFH4v+qhpHnV15RBARS54g935
	 kdItlOlQlqbsg1Z0CWlK1oyLlWfrDqIXJQDmOiCEUgOfZ4qbQAe4gUx1g3ew1ck10c
	 2MjiQ+FlzYZNHekuScDkXtQlQf6YKkzEIvztMbV8kFlFkIoPRFy01CpO33Jty9P15p
	 9VThE7EZXWLKhYzQYYTWFrYAZBiPSjIixKhVEAWkMaBfp1d+7xVtMGms+ysCYLrLdi
	 tW18Ocby3DI69wdjevel7k97hhbuiVzLb8XQFmGtFacnCcYwseYNd2A47ArigeOWze
	 jMyJriybhHWXw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 06/13] mxser: remove stale comment
Date: Mon,  5 Aug 2024 12:20:39 +0200
Message-ID: <20240805102046.307511-7-jirislaby@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240805102046.307511-1-jirislaby@kernel.org>
References: <20240805102046.307511-1-jirislaby@kernel.org>
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

