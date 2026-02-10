Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D0C3EBF24;
	Tue, 10 Feb 2026 13:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770729784; cv=none; b=D6+SJmgFfEEySeiSl8zzUJp3gDGD/VsdtQUfu018hSD3Inz/AVc9XJ2NB5GTAoAB6rt4Ly2wN+ApN+8DUXUUF5cbKJ2WWmeiDGSi3fuJZDNUglcCPGIuvFOC8/1lnWYoJ/9LCJG7qF228BODfmQt6ZIvC0WFrOU5SV99h/YQnaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770729784; c=relaxed/simple;
	bh=ShD3K3XhO3Hj6qyliohPc4bKyQvTx6Qls4y7E19TtQQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=TUu+mp1PoU15Hx2GMFpVHZu3gB0fF4QsCf0fQVaIdAddNJ8v000Ne+EHnEAvI9WalbibTmxld9dhr5wK/F12/CKpP4bGRWhBCxYGfDvNIiDifG/7LxXtsHcKhcM23ec6chlELhcNsD5TcEx6yRBuszXNLQxFvxGQjg0QXBw6eiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=gB82yu8E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mHSQ/4BY; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="gB82yu8E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mHSQ/4BY"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 37A8B1D000C4;
	Tue, 10 Feb 2026 08:23:01 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Tue, 10 Feb 2026 08:23:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1770729780;
	 x=1770816180; bh=AjHopETUasa62EeX1yUkRWKvnW6OkCghUQ7w5u0du7U=; b=
	gB82yu8E9rthn+iET2Gh63MHX2VyJCmBTuaYRXVAVh2NjzOjf0pHLAo75YSqmWCO
	DKX9Wky5rNB71sihGOCZN+5aAlO5hky0G+kbYsXftkS3ENKfO+yIxkSBXrzbOeNY
	hdEzTkcAuX8wX6RIWYtOwoiL/SUeXAyNExR/Fzs8DT1/fcG1Gb1YtgB5+nSeZOjG
	Yh1oe4iM8U3y29Suh1I7aXng4jTTtqptHZCHKLpT+jTeQI0j0GsY4ikCjvfrvzP7
	Ld4qpePtpRUfYe8wGT4q7mXJOEl44kdpA4ib8/7haDxd4qqOgLRtHgPPGnpiUg7h
	XstT6YGiPGhbO8mh188LnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770729780; x=
	1770816180; bh=AjHopETUasa62EeX1yUkRWKvnW6OkCghUQ7w5u0du7U=; b=m
	HSQ/4BYIO+lyLZK9+M1H1j1xpqdEke8POWvumlbo8zguhDrcJ/OewvJFMi/Xqlgi
	d4Hrcff5TWL7qV+KratutCv16LzTdu1uC55HCfE7u/731tb37AIeHtZwm3Ws/qsp
	0EM0FDTniQVOd8vsezqzCdTsyiwCqyn4oMyRro2QX53LooNosPXXoObLVJCJHHK9
	2/ezzQPvZ3VBh5cgiTQv/POHcPjUVOZhpIWyYzdwH5fPRceb4GiFtnIKfZHvftnL
	TT/8U0rmrAdQPrV6k7DWQ4c07NS44esFV/XwrmO8olETIy8hweSoblBGq1nZQa8h
	/ovU+XKDeeqNqn6/PwFcA==
X-ME-Sender: <xms:NDGLaay6Rq4IS1t9cp-l6byI7ic7aXnXgCOh6pPLkQTZqco5h4N5-A>
    <xme:NDGLaRHX8tm-gY2etX0ErGvQO8Ff5ZOQUD6PoyqTmF57kR6VHneoi3xPDLHlTp9Kl
    q03hsaR429UZNMiMY5W4aqb2GX0pbJb_GFFTASNSCnX_BIC2KmlICA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleeljeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtth
    hopehlihhnmhhqtddtieesghhmrghilhdrtghomhdprhgtphhtthhopehjihhrihhslhgr
    sgihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtghhlgieskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepphgvthgvrhdrmhgrhiguvghllheslhhinhgrrhhordhorhhgpdhr
    tghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtg
    hpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheplhhinhhugidqshgvrhhirghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:NDGLadhlJ69R7oqZnvtzXtb4Tb1nXp5FwCkHhQAX5jZHQnpRZ64twg>
    <xmx:NDGLaUlNGl_B8qwnA_yaKDiI6HWlF_NGXY7qWntSMLOjTsKl9_f8dQ>
    <xmx:NDGLaQtTDDQigGSrmHA-fgVbg8hYRz3BRSnkx-YugOrYw_TfMVGhJg>
    <xmx:NDGLaSbzi2HgfVT7nJ4Z9NrOcQw3_IdIrvKS6H70WDPo5yt25vf9YA>
    <xmx:NDGLaQaCZOVSBpCmpFnZf_PDFYGzTM8FotWVIVvKBdpUACc_vup8P4as>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 67BB7700069; Tue, 10 Feb 2026 08:23:00 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A7aFLWfceQ13
Date: Tue, 10 Feb 2026 14:22:40 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Peter Maydell" <peter.maydell@linaro.org>, linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Jiri Slaby" <jirislaby@kernel.org>, "Thomas Gleixner" <tglx@kernel.org>,
 "Russell King" <linux@armlinux.org.uk>, "Miaoqian Lin" <linmq006@gmail.com>
Message-Id: <316ebe17-5938-4e8b-9269-934c7c773c01@app.fastmail.com>
In-Reply-To: <20260210125100.223138-1-peter.maydell@linaro.org>
References: <20260210125100.223138-1-peter.maydell@linaro.org>
Subject: Re: [PATCH] serial: amba-pl011: Enable UART in earlycon setup
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Feb 10, 2026, at 13:50, Peter Maydell wrote:
> Currently the PL011 driver only enables the UART (by setting UARTEN
> in REG_CR) in pl011_startup(), so if it is used for earlycon it is
> relying on the bootrom/firmware having left the UART enabled.
>
> There's no particular reason not to actively enable the UART before
> using it for earlycon, and the earlycon handling for e.g. the 8250
> UART sets up the UART in its setup function, so follow that in the
> PL011.
>
> This allows use of earlycon with a UART that the firmware hasn't
> already been using for its own output, but the main motivation is
> that QEMU will otherwise log a message complaining that the guest is
> trying to write to a UART it never enabled.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> NB: I have tested this under QEMU, but I do not have any real
> PL011-using hardware to hand to test with.

Looks good to me,

Acked-by: Arnd Bergmann <arnd@arndb.de>

One more question: what is the symptom without this patch with
qemu? You mentioned on IRC that qemu may warn about attempting
to write to the uart when it is disabled. Would we still get
the correct early console output before the uart is enabled?

      Arnd
