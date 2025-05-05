Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998CD79CD;
	Mon,  5 May 2025 17:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746464471; cv=none; b=tKrCddEEo49ulGtWfRcEDZTaRoQznSavLcYEgNVn39kvF5sk/Og7r/bJQOrETwumrmfNrdECYHW9so4haC5Vk+cnIC/Y7Y3+FAmm4xeLp2xt7uDVYRzqA8dCCjosFlnKcS0sPG6OX6ETtOmE5T21rTMs3gDyGV2nf5QqI7nZYCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746464471; c=relaxed/simple;
	bh=/rb9sDoHFaPXkvVypXPPnNhJCmnEbt4hxIXviG6UFjU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vB6nW9numi1E7slBWeN3OWp3NIYbJq/N8rj0axay/xOE79VU1lh8KeOhYG27Pw85na0wkBrcjB9xAzKrAqTHxG21jCppyub/JXPacRWPp2pTWi9ttC9llYu9jYex1iOByHFF88RBf5NcF2L19DhasppmU0q1oyiaWoQK+03uaAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=EFi3lw7V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wHokB4Or; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="EFi3lw7V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wHokB4Or"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 87E301140251;
	Mon,  5 May 2025 13:01:08 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 05 May 2025 13:01:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1746464468; x=1746550868; bh=i+NjHOQvyPmCkguaVscPy
	Ug5INbsdBvyRRq7QrgMbGU=; b=EFi3lw7VcH19H6yZ+t2a1lGLB8NHmy7Qs3p5j
	beAzogmvvqxyQuWj8/uGQjSfYNZCbCsQrBRDqlucCOdbLaSk2wlueUzw3G5q87Iv
	Sg8jBBzAbdxzHTckuBKzqFwfhK8WWdja9GJPSRWF3J8gEl7CaN0GphiWuk0YxIf0
	iDPFBSkJhi5CokutZKAmle/TVzZMyokv/asBfTyhbbehUqgH2zyazoo8XLAFlF5L
	FZcDxL9guKiC//4YsMYKDsw9QxBRuF8o6HWzSsHWeXJ/t0FqTEEzWYzYPXtpCVm4
	7HxH/RsrjxzzkWIoIt+dXYPwfgOM5kfmWbet9wkFHoi7DQ1ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746464468; x=1746550868; bh=i+NjHOQvyPmCkguaVscPyUg5INbsdBvyRRq
	7QrgMbGU=; b=wHokB4OrijdGfEuX9MwkDVaRvcKkFXuiy3YuZqvKwxUJn11Y+0a
	JUwY2edDS3O2eheA1tBYhk1SF3PmP910B1C1Z1bhRgI0fCOssCzeeXTj59QfAk2Z
	Wdw2SHkAr9ERGTMAOfI6pScQLg53G3iUOtnaO6XhYTXVsllcF+CGMgiSAdb/h4PW
	2ylCxNwFjw2jDjMcE7U0TXmVulnBTFkQrJc55PBgTUBQJ478xzNfp628li9PhDH9
	x/EUzBfOMy1/R6fXMRGhcx7/6R333iE5g0jRADZePkNDPxi/myzTaOCnx9k3tihg
	2smhAMLLJSaM+ygPCQo5hJkIwPw6T2Z2K8A==
X-ME-Sender: <xms:1O4YaNsKL2qKby7egQylp4ETCMg_ti6oK7czLNi8-2-GCRNyX5n3KA>
    <xme:1O4YaGd9oq080pbZ0nNqzqzE1prQOT4GbT9p9Ot0AGwpp-QDlxAlpQ8PwE0RbAb-M
    GRbx8jSBuoxVLdSIts>
X-ME-Received: <xmr:1O4YaAxHLs8Pw0eqqWNIHL7BZAjYj5vkhaNUc3dZC0dav1abfh1nnXAxzj2S5N0zH57P64mebxjfaTajZmmaLjeCujnUdF15sYJL0LgFw4DYVrGr4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeduieegucetufdoteggodetrf
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
X-ME-Proxy: <xmx:1O4YaEN0fPaPsaNEpW07cmKF-z_Bnsi7VZFC-h6LXL--74XMdvYTRA>
    <xmx:1O4YaN92eUf6uQbvYIiyUdY3IBjrCSq5sCphuwQQaX-9uh2W2VovYw>
    <xmx:1O4YaEWT_gfICvnQXiFvzIIQbMrhIkSxXB2BGTSJ3G8yr1Rxejih4Q>
    <xmx:1O4YaOdD7itcIfgqboAUhdcn5CGT3md38aMqLG2FF6MVEl1xn7XFqQ>
    <xmx:1O4YaA_eh-3qd_jm-0PJvq6cD_PHclPzTdrwaOHH3vO094s_rthkL8wT>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 May 2025 13:01:08 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 2F6F01185457;
	Mon, 05 May 2025 13:01:07 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] vt: more Unicode handling changes
Date: Mon,  5 May 2025 12:55:23 -0400
Message-ID: <20250505170021.29944-1-nico@fluxnic.net>
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

diffstat:
 drivers/tty/vt/.gitignore                   |    1 +
 drivers/tty/vt/Makefile                     |    8 +-
 drivers/tty/vt/gen_ucs_fallback_table.py    |  881 ++++++++++++
 drivers/tty/vt/ucs.c                        |   89 +-
 drivers/tty/vt/ucs_fallback_table.h_shipped | 1498 +++++++++++++++++++++
 drivers/tty/vt/vt.c                         |   95 +-
 include/linux/consolemap.h                  |    6 +
 7 files changed, 2535 insertions(+), 43 deletions(-)
