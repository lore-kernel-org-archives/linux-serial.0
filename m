Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804C61DAC92;
	Wed, 14 May 2025 01:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747187778; cv=none; b=FwOiLoamH2ba6HQIsFdZZ5Bt9dw+sXbSfUFTwTuiKEsnQdrFmAnA4Ldm9MfCVUAVBNHXA160/moCGKnxLZfgyHcVHJV/xfyVSY5+CRGUhv3MSUgyFTaFHhp2zcpj4pOJQZZQHAYZRuryvI9+n3TVViRYMiOU64jfFiDqY193FLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747187778; c=relaxed/simple;
	bh=kprDUzz3HORek4jgXz1YTQRAJVW8oMV2aHsige+efKo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=csDKNfKknn556l0c48/2jO02NwMe6RF4n35pqVMhRvWUEhMiV2VYnQ5xu7PTjQDJSIp5Y1n2M/bCUqfBc+jIKMY+mUnKXut881dhX0L55mexfP3ip7TzhXO1z4kIjltUj78W67cqqW+SvdCZyqfb1a+EHDlxTfw0eLPY7SEidlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=VcUKUKuE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oaog5whK; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="VcUKUKuE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oaog5whK"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 514661140095;
	Tue, 13 May 2025 21:56:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 13 May 2025 21:56:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1747187773; x=1747274173; bh=vhpfVrpjQAxMVNP9kRsPQ
	04hdep/8LVopp9unopJ7zA=; b=VcUKUKuEQVusCUhfap+PNpTtEgjLc/Tmz2cKd
	sKWVXGQJ5DZShfBk3Rp5mWVjm4qZQ2M8bPe8355A4av3IPBAD2By4kW0gKDahbQW
	hk6UpVdOHlqDig8Ca8x7u+ZGyY0DpN4ISEEZHCrtT+6G224nkaRqjeIisrAGm/Gb
	Wt6qtwG4LzeGGRE1dNVJ88E7x0L2fJNC4M+PrA7tMTyuANdEyElrnzcvKOcif75I
	2pKsF+8kZqRgKtxXXKtu0TlCZcKHwWMudp3xXi9ZTuWnlv8UfDBi+LZFi1cxSVtz
	9bEr4v8nC0ABkEIky2gz4hwQ8i2MH9KN0AVxfBFKbjwmAA6Ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747187773; x=1747274173; bh=vhpfVrpjQAxMVNP9kRsPQ04hdep/8LVopp9
	unopJ7zA=; b=oaog5whKPAL1rE3RNNcoK25wafkrf4DEOXmYFYDgM1JOvAZsSyj
	iFHlVI9bhutFDCfPU/AgQ/ABLRpHE3OuXsyHtKeZJZtxjIVueFKVZXo62Nalrtka
	i/sJAWHNIXppXu7l/bt6nfPQmn/ws1FuDaysi+gvYBePdaTt9cQ2hV9CHm/mNJgB
	hod8Rg4KeNZIgn4yaA6lNTh/KdXalMdLpO3U5kvZcB3CU0db4iqCwSy+zA+POilu
	e/amhM9IKGNyttIR1bR2jpk/u15F7x+vUMegTJEDFtTtOXbEFoTsXmIxN03ZV3ZE
	Pbd7fnWxTCSLI8nvClyPB4M6AGxTPrMTriw==
X-ME-Sender: <xms:PPgjaIKhCp1oqs_qrEo5dD70_HPzP4M0WEFNTUMUgl4dGrbkkrIhkA>
    <xme:PPgjaIKsb1JjUj100s8cn0y6-t0-NGrnfnmD4DoMdnhttty1xqkD28JpWRFIr_lGt
    DLaT6RDXiLyCYEWn_U>
X-ME-Received: <xmr:PPgjaIuXwSkJ7SnwmjYsShouzYJZtHCUdGlLicJUOEfXSQ-Tsexvka2sV-zqOy2pbHKJfINjvxXFduLwBmmAMTNuutShPX-B1XJfgrXP6jF5quoS_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdehjedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttden
    ucfhrhhomheppfhitgholhgrshcurfhithhrvgcuoehnihgtohesfhhluhignhhitgdrnh
    gvtheqnecuggftrfgrthhtvghrnhephefhfeetueeiteeigfffieelveethfduleegheel
    teehudetuedvjeffffdvhfevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepnhhitghosehflhhugihnihgtrdhnvghtpdhnsggprhgtphhtthho
    peehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnphhithhrvgessggrhihlih
    gsrhgvrdgtohhmpdhrtghpthhtohepjhhirhhishhlrggshieskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpd
    hrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheplhhinhhugidqshgvrhhirghlsehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:PPgjaFbUmzgqPBlNvr3MN8QkeY3SSZ1gpwwYnmu8TquVla9zyS0vbA>
    <xmx:PPgjaPZwqqpyVwsa3dwkTPvwqD3sGF6PbvqF6KX2n_goI67TtlA1oA>
    <xmx:PPgjaBC5vcOjbqMnhyeAw7u10GKOvBLDXdw7Sht5g91RmECPHz6Icg>
    <xmx:PPgjaFa9ablJ_8YPhXR0KxGP-Gk3S3JUagoTk4k_OyCivCRGTnUMQg>
    <xmx:PfgjaFqIhDBKTBzVe_BY9x2gIoJeqSa1cjFdFJ8alCx7Vb-WG5Z29dTb>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 May 2025 21:56:12 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 119C011A0BC6;
	Tue, 13 May 2025 21:56:12 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] vt: bracketed paste and cursor position
Date: Tue, 13 May 2025 21:52:56 -0400
Message-ID: <20250514015554.19978-1-nico@fluxnic.net>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A different kind of VT console update this time. These patches:

- add bracketed paste support to the VT console

- overcome a /dev/vcsa limitation with cursor position retrieval

They are submitted together to avoid merge conflicts as they touch some
common code.

Tested on top of linux v6.15.0-rc4.

diffstat:
 drivers/tty/vt/selection.c     | 35 ++++++++++++++++++++++++++++++----
 drivers/tty/vt/vt.c            | 37 ++++++++++++++++++++++++++++++++++++
 include/linux/console_struct.h |  1 +
 include/uapi/linux/tiocl.h     |  5 +++++
 4 files changed, 74 insertions(+), 4 deletions(-)
