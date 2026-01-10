Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9FF18DB37;
	Sat, 10 Jan 2026 23:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768087614; cv=none; b=pdkJrqKLNl6cXbeBHsZ+UBga7mzbowNNbqQQltvtDAJO+2Rhudzu6fz9JYdtESeCvLjmhW1h8ohpyaBYJi40zfTk9bZZHgHOtV0u6p8Oj/0EMclMjN3S4vt389//lcg4OJDGWjJd+E6mkH1/RxghhWLXqMQh7lBC9JS3cBTLZ28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768087614; c=relaxed/simple;
	bh=WCy1F6gUlUiHEaKv+j3z/c3UXIVutz3A4XmPLkOGAL0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d4K7prrnTMElGlNFTr/kcAUoD3/AAMMPd5dY2yuuyuyeoe5EPoLRU5x5uYzxmYP1JBjIqKFq3YChxr0HMrTc9GkBfGXTrVVYfP7gEWJlM9oqSiBKCTvRJgHEauYf1/r06L25fUgxHzq6X1ItsYGGJlE02cxojwxgtnpdt/1xftA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZB+qyuWF; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZB+qyuWF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=0wqz/acFyvI2Bv/YfOJ/LpoztRNFSxEYt7VGWEKKWOw=; b=ZB+qyuWFqRZDmr64Jlr1bGQdsx
	2cySAAXrAh2ukCXdQXPsc71nfAJkHu852m3+x1HLqg8IgkKoGPWZ87dldf6pKkUGMgJktKgx2HDC4
	HXEaqQTFMEkQY0pQf60DgxWZAdQXgSDdGtx9qnFrD3CGI4F3JZwQI5z0OhpJTNCdpaFeF1ZI8Ki15
	02zsXf2zHcQLO2L7ZZf01M8vwnC+rhPbe7782rRoqRywgEwAzu1WniNsIHrbRh+74EmvPvF0gCOi+
	aFa/hDrrDVBTw9KLljWdAh2YDKTIlLubGQCKguPeUnbiMS49aI1WB4XK3PlJ2B00j56ckMsig9bBd
	FbcMKsSg==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1veiM0-00000003lbk-3DU4;
	Sat, 10 Jan 2026 23:26:44 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-serial@vger.kernel.org
Subject: [PATCH 0/4 v2] serial: Kconfig cleanups
Date: Sat, 10 Jan 2026 15:26:39 -0800
Message-ID: <20260110232643.3533351-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clean up some Kconfig entries.

[PATCH 1/4 v2] serial: imx: change SERIAL_IMX_CONSOLE to bool
[PATCH 2/4 v2] serial: 8250: fix ordering of entries for menu display
[PATCH 3/4 v2] serial: Kconfig: fix ordering of entries for menu display
[PATCH 4/4 v2] serial: SH_SCI: improve "DMA support" prompt

Patches 1-3 are the same as v1 other than dropping
Fugang Duan <fugang.duan@nxp.com> from patch 1/4 (mail bounces).

Patch 4 was modified at Geert's request.

 drivers/tty/serial/8250/Kconfig |   95 +++++++++++++++---------------
 drivers/tty/serial/Kconfig      |   34 +++++-----
 2 files changed, 65 insertions(+), 64 deletions(-)

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-serial@vger.kernel.org
