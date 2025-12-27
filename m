Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC3E324B0A;
	Sat, 27 Dec 2025 20:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766867114; cv=none; b=h/m/fWfyuwi95wUSuWQFQPsHfrLx95dIJl0BloKmH8GbwfjFrQsFcDtIFsQkCJWud0ngeaGXFR3liWiHc+PP1AuJkdSG94gTlSdErOuoaf399AtsYV6b4R7tVHMBXan5vrHan0kTOEXgb6FjQE+LvCY3HUGenTv72BTYzKlxsf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766867114; c=relaxed/simple;
	bh=MtuoPiNNd1NBpciCTptMC9XmjSoJ2Ji/ukeHmashbRk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lPI35tt11urtQlwQKyvStS9oSoXtSBHeBbfcuzrV8Ho1zCHIvdpx7W2jS9TFHOUUlX5gpM4UZ0yK4EvruwVvc+7Hnymx9Zg+lbTEtfP9PAz0aWqkJY8qeXE8WUhsQ7iQ+GmD5lIL4xI8PHQr8WlfncYRMWviYwjGqIv64BUqur8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QuE3wTUR; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QuE3wTUR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=q9oTECntikVXRsi0e2KlMYL9I6ha4UmQVgmdaHFeuus=; b=QuE3wTURHlQtHGRvp8+yIfrgot
	ObwcNyJ+DQbb4Kj7vbL8MiF6toK6D8zdtgHKqDdgI2LdeWxrLfOKQRj4C9IdSXUPHPREe9Znu8IVu
	hEXvfVspxgM0NbrMQxOFcMg7FSEVUAC2tZaA45wHeYQNJSWbjCtmHNnYkDnBD0DpngipBbq+tIdMu
	nW5efOfh3yKueWKoUXFG6QPjhQmFguBGxi+GBW0vxoTcgQocEUpdaHYGipm8CXupc89ApTGOXkMAa
	O0c97jK456wK/bCUxyJp+DXy3X6p8qPed3QfcygSe745iu+Btg8FCY1ZB1U0//Jm1AsIaKXGHIpU4
	dKaZnY7g==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZaqc-00000002C4U-2oaW;
	Sat, 27 Dec 2025 20:25:10 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Fugang Duan <fugang.duan@nxp.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-serial@vger.kernel.org
Subject: [PATCH 0/4] serial: Kconfig cleanups
Date: Sat, 27 Dec 2025 12:25:05 -0800
Message-ID: <20251227202509.2084000-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clean up some Kconfig entries.

[PATCH 1/3] serial: imx: change SERIAL_IMX_CONSOLE to bool
[PATCH 2/3] serial: 8250: fix ordering of entries for menu display
[PATCH 3/3] serial: Kconfig: fix ordering of entries for menu display
[PATCH 4/4] serial: SH_SCI: improve "DMA support" prompt

 drivers/tty/serial/8250/Kconfig |   95 +++++++++++++++---------------
 drivers/tty/serial/Kconfig      |   34 +++++-----
 2 files changed, 65 insertions(+), 64 deletions(-)

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Fugang Duan <fugang.duan@nxp.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-serial@vger.kernel.org
