Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525C5145355;
	Wed, 19 Mar 2025 06:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742364940; cv=none; b=CZMtvSrhZ9q5iwdXAEQK8OD07cuLHTQH4bu0E4Tz/dYzIZxKWm07Kp6kyhOej5e+P1ogzmrNALl7xHUElAb/26kzH+K9DzNxk4GrxaBe/1nDA4m4k0Zt2+lE7Kb5b+nU6NAMDcBva2BzY8zWS7jHm9rrdfAXdHDmQ7gEWtU3L1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742364940; c=relaxed/simple;
	bh=S/1/UGlmmaTdAGPWoTWM3/bUWdW9C4RiqjqivYc8bEQ=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=sbdhiPd5FfC0bOgJvjG+u8e9Vl6JRlOVTST0qDg/UVHSAY3QDPBMe0r+hJG052ZJz9GqpvYV2hMoOCHXiehXg0x9foyJ8RUpDPkALvW/QKOm3Vejs/xzOwTrZcpY3Pum9A4njNvnQ9Gvyv5+F6E6ShqirOLxjmzcw5HCBWnT/b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=aikeUlBi; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="aikeUlBi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1742364887;
	bh=S/1/UGlmmaTdAGPWoTWM3/bUWdW9C4RiqjqivYc8bEQ=;
	h=From:To:Subject:Mime-Version:Date:Message-ID;
	b=aikeUlBih0gyWcWNGFx8q8ZA6l0nRGLzy2i/4tWbJh4NIQ4LNxbGJ8l/QE7D8nhxW
	 ElHou3llyVKVYO//jSNR+x/9y3OzuNJEjVh6EMbBEwt5xu8zj/W+pP58HuV/0LsEnW
	 hZ5qdzWmsDvN07dpIPRJRz0YrCQuMcrO+IGnpj/Y=
X-QQ-GoodBg: 1
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: D4aqtcRDiqTaNE5G7a0fa7M/rEhb0o4JjCHUE1mhqHo=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: m+PvlHCfA/TK6CIELqV9wfQuHCBMRG9S2SrAvrffTl8=
X-QQ-STYLE: 
X-QQ-mid: v3sz3a-6t1742364880t4311287
From: "=?utf-8?B?V2VudGFvIEd1YW4=?=" <guanwentao@uniontech.com>
To: "=?utf-8?B?Sm9obiBLZWVwaW5n?=" <jkeeping@inmusicbrands.com>, "=?utf-8?B?R3JlZyBLSA==?=" <gregkh@linuxfoundation.org>
Cc: "=?utf-8?B?Sm9obiBLZWVwaW5n?=" <jkeeping@inmusicbrands.com>, "=?utf-8?B?SmlyaSBTbGFieQ==?=" <jirislaby@kernel.org>, "=?utf-8?B?RmVycnkgVG90aA==?=" <ftoth@exalondelft.nl>, "=?utf-8?B?SWxwbyBKw6RydmluZW4=?=" <ilpo.jarvinen@linux.intel.com>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?bGludXgtc2VyaWFs?=" <linux-serial@vger.kernel.org>
Subject: Re:[PATCH] serial: 8250_dma: terminate correct DMA in tx_dma_flush()
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Wed, 19 Mar 2025 14:14:40 +0800
X-Priority: 3
Message-ID: <tencent_7FB378712CE341FE55666DAD@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20250224121831.1429323-1-jkeeping@inmusicbrands.com>
In-Reply-To: <20250224121831.1429323-1-jkeeping@inmusicbrands.com>
X-QQ-ReplyHash: 1598585841
X-BIZMAIL-ID: 6037498720850255605
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Wed, 19 Mar 2025 14:14:42 +0800 (CST)
Feedback-ID: v:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Od6CeO/j0sUeWb+7nQRz99GpBVplmlcGpmC01T+OS/dSfZHOG3AKQ1hb
	tsAiQ3wzcmPmNIRnO/1hTjFudKzfC48JBdvVjqvbMHpIKnB6txvz7Ym8jzYdIysvuOrz2lH
	mQc8mv58FxlYSZ2ciPS/lD++b1YN1aOqAmzncpCajXf43QUruMUgYpSPBzzXulR9KyWivGH
	ACr7S13w5hOVmY+oIJq1FJRHU4+Z0tz/N/OECqI7CiN4yES8cHbd55MuDemiHCMJlIdt37T
	KjcoO8B7n25uYgkwFJW0qEeUUriL836CN46ePraqJu5QyLdLBkDavIqNloleq17OPkpMPYx
	jXnUBfLDVz2bY2wwlcnzwCmq3egnWlqeHYLQrwjsk7+FBj/ZZ6CkDHcrdbsrdaHWKRHp+m4
	HQiGMiSKw/JSscSnszcEuNhGGc+LJEtmIdNs9vY3Ejj431fGOO/6gZEx/Z/neqqv8bLItRA
	p9O1A8TKbyUmonmZRILQwUoGfKiZaYRI98qzvDMnSWNXvVyVPPOyn7lsXVwUo9s4xL3my9y
	QZWiSv12fPfByFur1qBpcdP3tFTYI229YwE+sXF5lXp5bFjIOGV9k/knBfODWm2Hg9h0V5N
	Pfdo8pGx5xIRdubTkHtp0TLHiqDUrReREU3RRrrnWNbKVBHcWo0YRzAKUpvNqctNR/hO1Rb
	C9xGX8h0eURwteeXjccdcas8DanZBk04DOYptANFeTxDA51GdAqtlGM9BIBxAUS8c1mO4RC
	IrHwRLDXzMhy81Snw46C/t0LlfHLbKpaR+lpqUeNyuL3QiahYx2Z5c6mA4PpBoSBJfvROtY
	oBpo6bBwKAavneyVuhlamXq+KxfakdMELuWhpR1cnqt+K9kRXd+HHNzqJv/Fdd6Mp5gAbbp
	yMUNj7fMwtgCH8TURYma6C5tBGCk2kewKO3eyTSEz2yyXBQhmxAH0Gtreq9Q7nfh9+C2qnQ
	NEo984wJIc0Z/sW+svShxew7krkBjI9J25puaBb51Sxr/m8DBXSJ2oyjAGfs8pjhQfoQ=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

UGluZz8=

