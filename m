Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCFA28935B;
	Wed,  7 May 2025 14:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746627345; cv=none; b=Wmq4dYKbkTxXOs8S63oiMrm8ZrNOoM6ZnFoCkMbCzULgf+d0rr7pUeCe2VpcRZUeWv97CUBg4mipoODwqjT2SikQIheJkrLsDiNEq5ZvQVYmR/69wrYRKyJV37R0X+lE06p730xLsldajoBWdceP36eOdnDrIv/U+Ns7q5t/mA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746627345; c=relaxed/simple;
	bh=gr62Oofmaro8Dj1blKC5oimjg1Ma95qx74mbe6VAJWo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gVm6zbSyXQjAdxfRgd2z4r9FvY0V24AIRpciyN1li2r7/PZk+VUwTErJGDv3+fQ8kbDUzawaRPtvfOmjF9UjBR+XngL1DqeZPPb8omNk6lSzybVbG4WTyGTyQFSlatCVnNuw9Q9T9CfGj2VjIRHSu5fkjJItUT3lAQHm9SXS+XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=CeRKQ8ws; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mkmuYxIp; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="CeRKQ8ws";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mkmuYxIp"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8D58A1140106;
	Wed,  7 May 2025 10:15:42 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 07 May 2025 10:15:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1746627342; x=1746713742; bh=Fjn2f21sUjQTKQQyo9yeV
	4PkAjK/HDeNAWxPJ/taQ3Q=; b=CeRKQ8wsVGBdJhYrTCiFGFUBFXpssarQQkQCh
	rk+wL6DIkzmQkY7yFvHO1oWp+0Ne+aEwY/QbZ1b8pOCmNHOHiPph/xZdfEZqnNcZ
	l151C7j4nIb5rVm5VQ76dxGpbQTwBpCtx0UZKgeHvC9Au3Ag1Z0Gus1GnWmxCVCR
	Jczeexl5AlPjhQhBRxaArjA9ZIA44s5x87LegQ+fE4Ti+bguEVkEuPpE8mv41qjm
	HOhGoOU7Gxi5qsGvzgkZfrHSAmuLCL6O/K29EQsgxLcG215w2KMyYkQBQ51td+1p
	W/CXHyWCCB+Kj3SqDKrv2ccmTzIRsF8zk2Eqal+Qoz1Tkymug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746627342; x=1746713742; bh=Fjn2f21sUjQTKQQyo9yeV4PkAjK/HDeNAWx
	PJ/taQ3Q=; b=mkmuYxIpQAU8tbY3W0e548hGoAsmv6FG5BTy/v4+3uXDXfy3nua
	RwLZcIiT86C3wCxYlngfbWE3WWOEnXGV84wi+nL0gCXUDrBthaCOYfs9XTc3fr5+
	8gW9LOoiaoWLGUy3Pqx6ilKVURKU9HQ0xGD5zDh0Zq9KKMhF+EBau4FIbpEFesVz
	mOF8koIb2j68vdAQhDRjwRa52yMHwrqlWL95jGEFyjHl0ae6hzhs+7OIvfaa06tM
	7yo3A9DrpHT3nAzq3tMXXJ7twgb/Ey33CTiMKVFRzgXci8nC63XQ7PAKW50R28+Z
	pZh4C8JWr4WKL9yl8Hn6Ms9xZEWiIQ5vxdA==
X-ME-Sender: <xms:DmsbaOMCLtpPCWxReI8SIAedB-T3AzbIaIuM8zsJwLRJAfDzWJEpJA>
    <xme:DmsbaM9IaQfRpS2WB2u7nWD1fiA99nSLqsPYOZG76ahqQ9QazXu_seBjETg8Z21ak
    ROprRKaCANNYhJgSPg>
X-ME-Received: <xmr:DmsbaFRSclcBAwV43nUIWjeJBoEzJtzn1mVwzOxuOLODFbiRCUcasYQFTEc2Gn4KfcyUQIMAtVjDKjILbghCF3ANkRDGTHhdSM9Hb-o6oJu3DGX_IA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeejtdejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:DmsbaOvx9_N0DuOlHaSQ9SVSY_-EnuH2oWwz1NE8OW1-tof5opZvaA>
    <xmx:DmsbaGfn0q6zJQ-9KXAl0efPGbOALfCbqR8aN8qofkFpONlntVl-ug>
    <xmx:DmsbaC2tjRFuBhsfe5cPnRCZ_YzR9LyhgtWlpD42ZxfrFNDBXS0qmw>
    <xmx:DmsbaK-7AuGp8bXt8pVOziJEb_x2tYSumDsyBxiMg1cnlt0ohzVQSg>
    <xmx:DmsbaPczdn3RF_8Z00sPV_24dk3_OFhnEPi4KfmpTJEHNSPEHN2RTnV1>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 May 2025 10:15:42 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 9B54C1189E9F;
	Wed, 07 May 2025 10:15:41 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/8] vt: more Unicode handling changes
Date: Wed,  7 May 2025 10:13:15 -0400
Message-ID: <20250507141535.40655-1-nico@fluxnic.net>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Linux VT console has many problems with regards to proper Unicode
handling. A first set of patches was submitted here:

https://lore.kernel.org/all/20250417184849.475581-1-nico@fluxnic.net/

Those patches are currently in Greg's tty-next branch.

The first 2 patches in the following series contain fixes for those
already-applied patches.

Remaining patches introduce tables that map complex Unicode characters
to simpler fallback characters for terminal display when corresponding
glyphs are unavailable. Only the subset of Unicode that can reasonably
be substituted by ASCII/Latin-1 characters is covered. Substitution may
not be as good as the actual glyphs but still way more helpful than squared
question marks.

This applies on top of tty-next currently at commit 5ee558c5d9e9.

Changes from v1 (https://lore.kernel.org/all/20250505170021.29944-1-nico@fluxnic.net/):

- Reworked the gen_ucs_fallback_table.py script to be based on unidecode.
  This creates a much more comprehensive fallback table with a much smaller
  script.

- Changed the fallback table encoding to be more space efficient.

- Addressed style comments from Jiri.

diffstat:
 drivers/tty/vt/.gitignore                   |    1 +
 drivers/tty/vt/Makefile                     |    8 +-
 drivers/tty/vt/gen_ucs_fallback_table.py    |  360 +++
 drivers/tty/vt/ucs.c                        |  102 +-
 drivers/tty/vt/ucs_fallback_table.h_shipped | 3346 +++++++++++++++++++++
 drivers/tty/vt/vt.c                         |   93 +-
 include/linux/consolemap.h                  |    6 +
 7 files changed, 3875 insertions(+), 41 deletions(-)
