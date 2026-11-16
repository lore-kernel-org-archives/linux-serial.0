Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794798648;
	b=ejZ6Wl21FGau8IMb3a00+q0464PgtrhGWGd01d+E4LAd0OtJ68PqFH9osxizlpacOl0L
	 ptN/5HBI4HE5KLCveb3auNygnJ7mUk7QoMiGZdEJhnUiKVEZjSKuOBf+V2D83akYnZ8iY
	 vJnV4PMOes9YYkHoYquC87G3gFoTqy3MaujGjQFn9CjrjXNb0SARKcS5v+ECV4kZrDfej
	 u8lFsle34//XorDoCWAT20O/IkIwLFWd76fUcF435gGlZBoUBlnrue+em1DTd0H7deoO9
	 CdxlVlwHfBRr5c0kG+Y5Tmpnz+aWGXkumt9OyvsGv8MisnSeQxIx3mSc/TP0EbT7vzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794798648;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=WqPb9CNtYM7Zy6zAHIxxb3xRBsVT79O0vGo8WudTrY0=;
	b=rct11ILqxscpsk7R2CrFaz3+Jo8GDH5HLGFAglBMnPABh2RwsPBwvWuAZKC3riqx3vUS
	 15XZUoEdTFxIULeXKXa4hrd6aFcIR4LIn1lGB7Sz/E94tTi+831XwLnRdwxx2YfixwJIW
	 rz+Z6F9qqxdXSqVbStA2Tqok6sQF1lslLtRDyyNxLZJSZEwWj+u3HjJBuWei1nGk+pCB+
	 U+0UB3RLm94PGHeXDCiSU5fR2n/D5I1/yF5pPE9MmkjS2H6wCHrcvepovCkdZEQGt4IC0
	 gj2ZzUG4GNOmLG+FVO+LzAIx/+IaDq3vVRemp9W3sAntQ3mH9vHYuUdMC/zg6HMLDOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=Rzq1MGQ5;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C38606A329;
	Mon, 16 Nov 2026 03:10:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2C38606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=Rzq1MGQ5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=Rzq1MGQ5D9adTYsOnLxe2gkT3IXyC8M/cyzcIA/0qtQTrWCceazcZ+kp0ykvoPlTEeTIqz1HcKKbd
	 0VMrmUhrsVLEacsUWekmF6BdwDvLqYHK5CCZdj+A4vOpZJTmN2LStj+XacY24Krpf5RmIh9UZsWyj5
	 /BctiYUoLm57q+vg=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee16afa7435486-d6c92;
	Mon, 16 Nov 2026 11:10:45 +0800 (CST)
X-RM-TRANSID:2ee16afa7435486-d6c92
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from DESKTOP-3K8GUTQ (unknown[223.108.79.97])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee96afa74331d5-7a4dd;
	Mon, 16 Nov 2026 11:10:45 +0800 (CST)
X-RM-TRANSID:2ee96afa74331d5-7a4dd
From: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
To: kernel test robot <lkp@intel.com>
Cc: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	hugo@hugovil.com,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	oe-kbuild-all@lists.linux.dev,
	llvm@lists.linux.dev
Subject: Re: [PATCH v2] serial: sc16is7xx: Fix clock leak on invalid clock frequency
Date: Mon, 16 Nov 2026 11:10:42 +0800
Message-ID: <20261116031043.503-1-laixiangwu@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <202611140631.LIs6CWKM-lkp@intel.com>
References: <202611140631.LIs6CWKM-lkp@intel.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

thanks for the reports.  The build error is an artifact of the test
setup, not a problem in the patch itself.

Both reports build v2 on top of the linux-review branch created
for the original 2026-10-30 posting, i.e. on top of the superseded
v1.  v1 redirected the invalid-frequency -EINVAL path to a "goto
out_clk", making use of the error label that exists in mainline.
v2 is a full rework that replaces v1: it switches to
devm_clk_get_optional_enabled(), so the -EINVAL path keeps its
original plain return, exactly like mainline, and the mainline
out_clk label is removed.  Since the -EINVAL path is identical in
mainline and in v2, v2's diff does not touch that line at all.
Stacking v2 on top of the v1 baseline therefore leaves v1's
"goto out_clk" in the invalid-frequency path while the label is
removed, which produces exactly the reported "use of undeclared
label 'out_clk'" at sc16is7xx.c:1622.

I verified this locally: v2 applies cleanly on top of current
mainline and the result contains no reference to out_clk at all,
while applying v2 on top of v1 reproduces the dangling goto
reported here.

So there is nothing to fix in v2.  It was posted as a standalone
replacement for v1 (as a new top-level thread), and the build
error only shows up when it is stacked on top of the v1 baseline.

Best regards,
Xiangwu Lai


