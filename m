Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B45202F60;
	Wed, 14 May 2025 19:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747252053; cv=none; b=iDYMuP0q4/QcynhLAy7LLN3zLDT6QhDfog2yx4xDFiWGEx/ck3UCwWpPaDC5RoFqc9cx2upBH/CMaktQyJX8YtIRFLuzXx2N8jM2JjIYRcHN4aIBdvY+NBoKPk8HwBt2SgU51dCQNsl8D+n3rs1dKjLcz6Af4CwenGnTQuE2iFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747252053; c=relaxed/simple;
	bh=/zk1FeMvFSV4k/jXzjgy7DC1CRsVbOeRY3S2C8NWsoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tw/xigpCqD4mn1PYGogwiN4chRsuwp1W4152VOUFkDS9fTo+ca0lXab50mOcbzKyYlNKjC5m6MPShqVU+caXek/zI9yZjRVVB6XLCf3cAR8wRANsilvai2u/coId7pvKv3OOtp1Wm+HHoyO/SYznEmkGgJ2WRuzYxpoGN6J2NFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=MCCL32dT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o0JCPSDA; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="MCCL32dT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o0JCPSDA"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C78DF25400F2;
	Wed, 14 May 2025 15:47:30 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 14 May 2025 15:47:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1747252050; x=1747338450; bh=pYtxPlCdRNg8MTJw74j75
	TGp0it8EA7GumTYURGPHHU=; b=MCCL32dTlIhxUCVxjYgEsJysuR70e+Wm8Jn+Z
	8OmUas+XYLRnZl0AQDnkqjOgYpOSFog+K8gbQU0MTBftCOUYUcA555xsZaPcskwI
	+g4HbSSHqO3Yo2yb0sSLuhHRQpg0iVenLsLO+UCwj4S9/zyXvG+XfXKjnSRwUH36
	avTyLRztNBRlh0sb9AFlG2aKayxFXexTMJ2h36tEyBO123Z9sXluSXETOZ2wt1jk
	YbtKOUUw+6LnufhCroA5eLC8ZGXOI7CIXWrg7HcYebgq98D3xJg1ptSqkML0Of3E
	mQy/MLaPfiqAcCinMEU32wpkq2DQVORW1MjCJ3CzXLJOBKgPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747252050; x=1747338450; bh=pYtxPlCdRNg8MTJw74j75TGp0it8EA7GumT
	YURGPHHU=; b=o0JCPSDAWHTD00PN62DyXuR/IHEC1rU2J5UK+jJnDRMfnaOOwq/
	BN3o4mWyLzNThep6wyDps2doFeuqDJPZKQNuiWUefsSA0P4TCUHO3tjlJqtHzPCg
	OeB+0Zr6PGN2zudP8k1U2uxCS27El5hELlyctPQrYjMNZMn/7mCVjJ0FDXjAPsVD
	xCXkdhWacGH9nRZhdlfAYDvhGZPo6chilF+MLyWVuv6CW0np0cV0eZIMWlq6DOzF
	UqbSDhpl5qWFmrObBFaOeE6QXbAb1r7gwj5sjToeknT9XvRLNH2hc+5hC/Gucj0K
	dJR21vUTDzWErEOGqqHTk+gl2/w0cPQvJVg==
X-ME-Sender: <xms:UvMkaFYMJKm-IZMrBhJ5_mxKqwmWsjVIqQhGPJq8-uHioVKq8Fa09Q>
    <xme:UvMkaMagrKK50vuktpZw96WO91fUCPO7mS9s6KnbS0KgI5bJMoAieEwboLHybNaSP
    wvyvICZoPZlghdfRZI>
X-ME-Received: <xmr:UvMkaH-w2j0_I3JuCQ0_swFfsup0HDNrkJUDcJVMF7sCsqYtEVcQgkU_xzydskiCTm2dxeykuLnKZqq0HL7jTDQPPNSSqfbFpKTCo8xQ6xff1mjQGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdejkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttden
    ucfhrhhomheppfhitgholhgrshcurfhithhrvgcuoehnihgtohesfhhluhignhhitgdrnh
    gvtheqnecuggftrfgrthhtvghrnhepudfhvdelgfeguefgjeeigfdtkeejheekveevgeei
    tdelvdeihfevfeetffeigeeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnihgtohesfhhl
    uhignhhitgdrnhgvthdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtohepnhhpihhtrhgvsegsrgihlhhisghrvgdrtghomhdprhgtphhtthhopehj
    ihhrihhslhgrsgihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehgrhgvghhkhheslh
    hinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghr
    nhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhsvg
    hrihgrlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:UvMkaDqspuyVgP1Ik_Ji3yPN5dwCNOJB7PqfNOMhckF8v2KibOE1IA>
    <xmx:UvMkaAo1b8_0ORkR4pw_mK7MDNP_XwMqrmA1lvzgWC_SlyuAX0n63A>
    <xmx:UvMkaJQtH06BcU5wiVNKeP3tcl-tEfniX8YbCTiNpKZ7rWsTeYKPEA>
    <xmx:UvMkaIrxRhUYAcG28OKoys8VJooqsSrPbVqT7g0lhiKvnGpUefk6tA>
    <xmx:UvMkaN6yknB0GCA4AfmObv6iaPVfia7uYus0Enyn5etD7byHxgllSwNP>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 May 2025 15:47:30 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 73E5111A26E6;
	Wed, 14 May 2025 15:47:29 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] vt: bracketed paste and cursor position
Date: Wed, 14 May 2025 15:42:38 -0400
Message-ID: <20250514194710.6709-1-nico@fluxnic.net>
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

In v1 those were submitted together to avoid merge conflicts. Those conflicts
no longer exist but here they are together again for coherence sake.

Changes from v1 (https://lore.kernel.org/all/20250514015554.19978-1-nico@fluxnic.net):

- Changed TIOCL_GETCURSORPOS to VT_GETCONSIZECSRPOS with proper structure.
  Moved to the VT_ space to benefit from unambigous pointer argument and
  vt_compat_ioctl() wrapper. Also motivated by the fact that usage require
  both display size and cursor position so those are joined in one syscall
  requiring a structure.

- Code simplifications suggested by Jiri.

diffstat:
 drivers/tty/vt/selection.c     | 31 +++++++++++++++++++++++++++----
 drivers/tty/vt/vt.c            | 15 +++++++++++++++
 drivers/tty/vt/vt_ioctl.c      | 16 ++++++++++++++++
 include/linux/console_struct.h |  1 +
 include/uapi/linux/tiocl.h     |  1 +
 include/uapi/linux/vt.h        |  9 +++++++++
 6 files changed, 69 insertions(+), 4 deletions(-)
