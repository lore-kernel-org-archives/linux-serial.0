Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2508232785;
	Tue,  3 Feb 2026 04:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770094575; cv=none; b=acY0mhlU+98gwDBGo4NgA1qNvycvLIdh+f8N0dGBvWresTyuVmUFaR58C4yOSP3rWhpIp/EkXIT94txbahk8gWJ6EQkEKHevP+cpxVdc7rkYNRlAmRe9xMGXptIF++UdD+ob8EgjLZ0SsDmFWV5h0+gre+weiAA3hDkWFiRj3rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770094575; c=relaxed/simple;
	bh=Pa6mTWuR8/L8alpDmOcCIYGoR7xx96QO2rvwMir0720=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=delbrUuV81hkfK6i3ht1DPeg31eYgkkfPnDHCJptXjjSe9H/VFur47pq9pviGMxaa7W6seVmf4JOPS4z0NVji+eTXH0gaJYgRHWunwNNQBZW0fVt5nZqmuQDTiWPdhezOa3MaAFaFoe5VSuM8zc9ZoAQ3Vfkm1qh38rHd8eHWCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=NbCh4si8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=py6aqea6; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="NbCh4si8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="py6aqea6"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id C26E0EC007B;
	Mon,  2 Feb 2026 23:56:12 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 02 Feb 2026 23:56:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1770094572; x=1770180972; bh=fk9jMpvZKGavoO0DHACG9
	aXvt5eAzq+G5AYMEhrpmRE=; b=NbCh4si8GG+LCGRazB0tq7P2cuIPq9qQgRikc
	uyTgOA88H3UB4YxZlGRUjcyqyXoPUBLg9NFUla8600tVJ1jLek2lp0YZ9IPkQjFM
	pVZB26G/0MdJtmdnwxGutWqExzsd3i+vJ0JLTN6fEUqzjibwIAGsLLWOGMDQYmPy
	/hBGC7/PPbjwlHdNzqdPNdXGKip6QVDPvyJa9KezyLwIUoiLEM9gBSjFrXCZAMkP
	aPpPcOQwJ7OLrs8u1l9oOKME8z/Ci5v4IQXhek+p8mFXgxcVRhZ2+al+u772Mg39
	K4hMLtKTcXaERA7BQPyZ2RiiuncYeqtWOWrVr5U3nxf0v+OPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770094572; x=1770180972; bh=fk9jMpvZKGavoO0DHACG9aXvt5eAzq+G5AY
	MEhrpmRE=; b=py6aqea6I1G15fc8YmwAcENbHOlWTbnBS0rCgo3DJRwn888uMKG
	xLWFoGUZ6/7+xn1YDVCWgnZsW6sNGc3C8w4yZugUCEqKybMkkf9JBrXN2x+DfVQq
	uHfKwLszcmbyZpQNvprRhS/uSWRxxKBhWmOXJ3S/HRbAiM1r5hEJtiFy5yqHbfkz
	jjzf1EXTXH58LVJYw24oyrCsF2tkuLhnzjoV2kCLoOQdzqSsL8DO6qfG977KHEhO
	Qu9M0M4NheMq868KFUPwieGpQJuJmcDuBl8Mct87a144plgDPzcxqPGyTragG0ZF
	s57tH7ROzDo1srKwXgsT8C4vfhdIxlg3vXw==
X-ME-Sender: <xms:7H-BaaSBd2G-mwgatk1wDepNZre4Ouuy38oQBG-jbZ2zNJstmwFYyQ>
    <xme:7H-BaZH6eH37PskIuIRuQnOp6WZKELCMk1huydIk9liy2mCnLGuaQ646su5uPOcQC
    8Z4WfwqKbMF_7q4_iNc8YR7UvuJEnWdoIshtDIGdPal6HSaMU-h0qM>
X-ME-Received: <xmr:7H-BafHEwj8vmJC8SXJXW4HM1r97Os4rEuvvHpywq3S657DEF4p6E_rT5xZ5FqjaYhvp8sUZsq6ivP8OYyd9zU8xWjxP-3D-MP0MKdXu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeelheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheppfhitgholhgrshcu
    rfhithhrvgcuoehnihgtohesfhhluhignhhitgdrnhgvtheqnecuggftrfgrthhtvghrnh
    ephefhfeetueeiteeigfffieelveethfduleegheelteehudetuedvjeffffdvhfevnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhhitghose
    hflhhugihnihgtrdhnvghtpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehnphhithhrvgessggrhihlihgsrhgvrdgtohhmpdhrtghpthhtoh
    epjhhirhhishhlrggshieskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhgvghhiohhn
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunh
    gurghtihhonhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhsvghrihgrlhesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:7H-BaXR_Oj6GT-UUHOqKfubghcOQrLj7OhxjIlN0ydJmib2HI2K2Pw>
    <xmx:7H-BaQLzYjIK5fKP9YKzLZ2oC0lg1izfOKAJJ6etjoqwgx_6Tij33Q>
    <xmx:7H-BaSZIGxsgdqwlo1X6cHnabxCzj2l_8tgckw0QqGNrTt8XM5OiZA>
    <xmx:7H-BaS-4u28YR-PEU4l5yKlZCKgdMzvLi9gwbjlybooqmtGU-mTF4g>
    <xmx:7H-BaWFJqqtlp0FfLUj3P8CBduU3NduKYLMmIvjLcQ63Q7gSUd_i96EY>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Feb 2026 23:56:12 -0500 (EST)
Received: from xanadu.lan (_gateway [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 8EFA8151AE38;
	Mon, 02 Feb 2026 23:56:11 -0500 (EST)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Alexey Gladkov <legion@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] vt: add modifier support to cursor and navigation keys
Date: Mon,  2 Feb 2026 23:52:45 -0500
Message-ID: <20260203045457.1049793-1-nico@fluxnic.net>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds xterm-style modifier encoding to cursor keys and navigation
keys on the Linux console.

Modern terminal applications (shells, editors, TUI programs) rely on
modifier+key combinations like Ctrl+Left, Shift+Home, or Alt+Delete for
navigation and selection. The xterm protocol encodes these as CSI sequences
with a modifier parameter (e.g., ESC [ 1 ; 5 D for Ctrl+Left).

While the existing func string table mechanism could technically support
these sequences, each modifier combination would require a separate entry,
quickly exhausting the limited string table space. This series instead
generates the sequences programmatically, providing full modifier support
without consuming string table entries.

This series addresses that in three patches:

1. Add modifier encoding to cursor keys (Up/Down/Left/Right). When
Shift, Alt, or Ctrl are held, the arrow keys now emit sequences like
ESC [ 1 ; 2 A instead of plain ESC [ A.

2. Add a new KT_CSI keysym type for navigation keys (Home, End, Insert,
Delete, PgUp, PgDn) and function keys. These generate CSI tilde
sequences (ESC [ n ~) with automatic modifier encoding.

3. Add automatic fallback to the plain keymap for modifier-aware key
types. This eliminates the need for explicit bindings for each
modifier combination - a single plain keymap entry handles all
modifier variants.

The modifier encoding follows the standard xterm convention:
  mod = 1 + (shift ? 1 : 0) + (alt ? 2 : 0) + (ctrl ? 4 : 0)

Explicit keymap bindings take precedence, preserving backward
compatibility with existing configurations.

Corresponding patches for the kbd package (loadkeys/dumpkeys) are ready
and will be submitted once this kernel support is available.

diffstat:
 drivers/tty/vt/keyboard.c     | 80 ++++++++++++++++++++++++++++++++--
 include/uapi/linux/keyboard.h | 29 +++++++++++++
 2 files changed, 103 insertions(+), 6 deletions(-)

