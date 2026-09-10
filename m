Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EE048A2C5;
	Thu, 10 Sep 2026 13:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789045710; cv=none; b=FH+dLtg8AoWhN0Ny/W4T23oqTbhC8zi83C29pGRiQ1WGE7fogEU66yw1fxhnfNBanSJpjZBoK3mziego6UwmbPL17qEtFQ41eN9Qgvjo1DZk6HKqXPlqaEthqR/L5CU74Xukg8Yuqz0mq5p/QrrEARO+0HGpypSK2bOIkCE8lNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789045710; c=relaxed/simple;
	bh=q09Ub2Zlzm1v1szk5ufKOiqJFMiI8h9bh5iJTP2FwgI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bMYGYvllgrcYv3UY9i9CpuKhXqxCVcOuOo0lyWfi48cYwuj2/siWQS7J39ynxHSQ2ELXU0va8A6ofWvyaerFNgcVTtaoITP+bdxFnsvKgOd7ckcQHsHJAHyBenQB1CdYnQ8Yvb1pOO9Hu9Q0CXcYfclob2qNC3ZpcYcuQPhL48Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CxJzPrac; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CxJzPrac"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 576D61F00899;
	Thu, 10 Sep 2026 13:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789045708;
	bh=yTvniIUKsG5BaCYYnc7GSa7/WMYbVKGTDhdmgtUzrn8=;
	h=From:To:Cc:Subject:Date;
	b=CxJzPracYPM80VlhKiteNwY3ikARnorW10qh1ynIZAaloLZ7wHVUx/jRjHPqEcBlZ
	 xtQeOMldUwypG3dZoEmErHI1ysew1y/ZMzY2XlZigIkog/ZrB1Y5AIY4HmfYtJEktK
	 +Ph3d3xrFr1ZeIyM5r0/eFvfskLQfzshUG6/n7qGeCdXF2OXR5oZ++7eOw1eXRba9/
	 9rAkND8sw2v0Wr3HkGegy4u1jQOz7cs9SL+QHAIvnOmqXzFQDHnzSCrQtuzAdRdmf6
	 mbdKO28CTojBdOOY0uO2iDIqHYF4V2N5mA7KF3E4xTUOOCrmUB3rv1fMYmoerzAELp
	 /INQqOXnirCJQ==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1x4eVt-00000002hCb-43t8;
	Thu, 10 Sep 2026 15:08:25 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH v4 0/4] serial: fix ioctl hangup race
Date: Thu, 10 Sep 2026 15:08:12 +0200
Message-ID: <20260910130816.642699-1-johan@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tty ioctls can race with hangup and end up calling into a tty
driver for a device that is already gone or powered down.

Included since v3 are also two related fixes for issues highlighted by
Sashiko.

Johan


Changes in v4
 - include TIOCSETD which also access hardware

Changes in v3
 - revert guards in uart_wait_modem_status()
 - fix race in TIOCMIWAIT (new)
 - abort TIOCMIWAIT on hangup (new)

Changes in v2
 - include TIOCMIWAIT which also access hardware
 - replace broken scoped_guard() construct in wait loop


Johan Hovold (4):
  serial: revert guards in uart_wait_modem_status()
  serial: fix ioctl hangup race
  serial: fix TIOCMIWAIT race
  serial: abort TIOCMIWAIT on hangup

 drivers/tty/serial/serial_core.c | 59 ++++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 18 deletions(-)

-- 
2.55.0

