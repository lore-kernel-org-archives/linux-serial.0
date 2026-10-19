Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D460499F3A
	for <linux-serial@vger.kernel.org>; Mon, 19 Oct 2026 09:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792401003; cv=none; b=O+KMqOERhS0lnogM+uMCq5EafDaUdMNvW56dnkDYZjFPVg4ijlvZ7z5mzrhXgEsV1d+JZ6h+kILEBy5iuF8xUo3gsVNRsLTQ7Cn/i2yNcz6vIBSG4wukjP8O9UeOF0hoHMa+NbbvJQY663zHkm7LwUKuVaWRbeZURmDXe1ElxvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792401003; c=relaxed/simple;
	bh=kj8LYuKMfDF1niDZrCZLI/kPUrlYb1+h/IT5kGPJW8A=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ePaCovvqOH3RKsiK8HLV12VEYXEh7CSpoWC6oyS87eLNTD46wBK6MhPNvSDJNcP3YcbQxrne01k80PJOi5t36xHD7dvGtaFDurcv3nfWv0Ndvs8sHoYLZ74TDFWlh/h0jQd29vcYgXRN6tHQa+5aWcbYoGQEdtSH+K8yl7WcWf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=L3f9jObg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o0si0j4d; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="L3f9jObg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o0si0j4d"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.stl.internal (Postfix) with ESMTP id 4AE031D00093
	for <linux-serial@vger.kernel.org>; Mon, 19 Oct 2026 05:10:01 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Mon, 19 Oct 2026 05:10:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1792400994;
	 x=1792487394; bh=VRrkh9ufsavwUzGW+kYYPeIwYlUPaQhcxxu+q1D/UVU=; b=
	L3f9jObgZ3Y2ryEcxFVe4eWz9ruWVwAZQKXuzDfBLLT3BVXPvhosOkgbOhc/xE6Q
	QSpqvBn/ezYeqXvlEqKHan+S6ZE4Hfg/xIF7HrO6VdJMjzxR/G5PhRSIXncyeYhP
	od6NaTE+aV39GtkEMxS2RS5dO9vDOF0obvGpB4N+FzGXWwTHsYVaFjJ73/13w0eL
	aTSb3UlflJOwfZaxIy5j00kuNQTFesCg3me+7/Hl61Ymj0uHUgxV34D3OzOGmYO5
	CPGMKB13D0gFqJ/3id7L3pNMvhRQ/UyF7JTKZwFkCi5XXJYK+5K362BiwQOnpYTM
	jN1pCdZK0W7qYDu96Ef3sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792400994; x=
	1792487394; bh=VRrkh9ufsavwUzGW+kYYPeIwYlUPaQhcxxu+q1D/UVU=; b=o
	0si0j4d5WZXMd2S/CGg+i7LWgV8QTkJKVbzYEQ3SSu/0odececm5N8pXpU4nd9WL
	O5L0+xpLqEsDXIHfZy3zfuwVCfxsk0FUHoQcG/cxcWS8MpQj89X8gzG4DbDwjDYc
	S/QjI/JexPmTIHyEztVQe58MfdG1gFg1w0uvJwkiKHxXbRcIc+fFPtJSJ9++Etvt
	T0eCsRxmcb+SfU9fyf7xCurbcmi/3innids7AfkEIQUx1jqfa2WqHd7LQwGiTh/U
	/2usFcToWLtiprR7vdKEcSKWnt7FU73gao0WOljJ+Fnk0O+yT7LZblFW4TcfAuZm
	fWmIVcw1PfSxIr/LQDrMg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792400994; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PGxpbnV4LXNlcmlhbEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:L0hs+B6vkpkQFT92RDZllOuEzjKL/Y0NRBPzQqG6RTZQqE1
	xnfyMR+uvGhAVFebPTOYWGaoJP0H3RA079NgDyje7yOFFjz/q1yOAJ6V4h4qCI3v
	7wqqcl9cm9LMb3S28rL6JosUK4ZG5PDJr+r9vEjW3f6hab++sdNvhOUsKKwgmhul
	8p0kxjHfuuSeA1dIcRPempXx1gupPs4RXL0yqzsOTwl65DIiL25WmVtpiBefgVQP
	3ZWJFV9B1ybix9KQeLCR8l6hoQS4bdHfp6RnZjxaWyvfdQuFEF4JaDXOWmClV08T
	Dsy0g6Iq2mZK1yySzRQEmOusE9IannLb0nlb25g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:GpfjWsuTedn1PGgZB4VWlRUwOsUX/+Z2h6AxJHYaHpQ=:kj8LYuKMfDF1niDZrCZLI/kPUrlYb1+h/IT5kGPJW8A=;
X-ME-Sender: <xms:Xt7Vas3ysSKFfiNJy1wYno_yUkPuQEdXrabYyR9YAJwy9aBhPT286g>
    <xme:Xt7Vah5jcxzIqhvq8DIghfSEWPrG_QFj9PbXEcdjJAwLddOrgJHrWslYGgsluZvgt
    y8-H8jefJtcTu6FD2CPWr9GdVPVfgkeg2M7yXGVo3I69Hixu2YBJPE>
X-ME-Proxy-Cause: dmFkZTFYRXPUPX60vo5NxXURpLeDTBW2NZI8Nhg9EestjprxOOBQDyI1yFGxcHxaZcxo8F
    MJn2vy/9vxZ8o20eiDpdEw5ftI0w1ITcqw5ykPXIOBdMPtdJLJW47TMfiRwM4lk7ZcV9qh
    zvGtQO9noFJm3b0FJHHoOxqcLFtawzHomex3BgSOg/9OTwGheY5wzKL7BQg4GJFnyCtzxT
    1CajZ9QN8sQMu9tRvX9eDNhZoRqevBaBn1ivC6bmI3MFnz25M93FUeFiKJlKyzPL2iIAmx
    k/iYk8h9BVtnzHNACvekCVXHWy3RbL66CyT24pBVKaCNMWkEIM4sTJxkpZ8kg1Awh7b1rw
    hebVjsrHJEUhKZwpf9TM+E9/iKnmqSq8vzm69uam1kByTTT/HHAZrLcvcCsjddTZtgtLTi
    V+PYDQETbpZXbil9OwqhkH+gxPBxJRmSUaFsawAHxjC1Iodch2aAzI8yMUX/rbOe4w1+yy
    dNdJTGcLn5lyBrHS5U+yQx9ICcHlRrm1LHS05NVipPJOKBEfDorfmv7YUBl7sIUD8VzoyX
    CBBuIJhtchKVXExiDR2tStF3lZwpaB4U3igqg51y37CaXAYppxaGikser/Fy2l7apZ60Np
    lQpUtKnFODoPj3jKtYmBLZe2+Kvx5wU855/3gXNrTlsXdlmJ+nRr7yaRiIZQ
X-ME-Proxy: <xmx:YN7VakYRfolVWoq2U4Kc3lbavYH85MB3dAyNB7UvaZUhBGIhJqp41Q>
    <xmx:YN7VarQRn2XCVfUnO_i8Vs0O-uaURChmxxCsF7vt5XyyBNKOfKJxmg>
    <xmx:YN7Var9cXWiXeIPHCcUxPBdgYXGeGmE2bHWi-zq2U4RYlY5qdbfpfg>
    <xmx:YN7VajiCWTDaHDx0Q0CqXJRwJGMthixVQRM4fNhG9TqfDqF_K09CBQ>
    <xmx:Yt7VatpnyFMnmfC90QxOuCEVgX2unZyDCh70RbGe5e0ToZeFdFPMMhtu>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 4BEE432A008E; Mon, 19 Oct 2026 05:09:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A4WN0AQLOakc
Date: Mon, 19 Oct 2026 11:09:29 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jiri Slaby" <jirislaby@kernel.org>, "Arnd Bergmann" <arnd@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 "Hugo Villeneuve" <hvilleneuve@dimonoff.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev
Message-Id: <2ef6314b-989e-4982-8964-1d6fdd123f4e@app.fastmail.com>
In-Reply-To: <0ec5fddf-f8de-4c82-a42d-6abca1e06091@kernel.org>
References: <20261016130328.1037616-1-arnd@kernel.org>
 <0ec5fddf-f8de-4c82-a42d-6abca1e06091@kernel.org>
Subject: Re: [PATCH 1/2] tty: serial: remove hub6 multiport support
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Oct 19, 2026, at 10:15, Jiri Slaby wrote:

>
> Great, you would have saved me a headache if you had sent these long 
> time ago ;).
>
> So I will Ack both, once you repost with the reported issues fixed.

Ok, sent the updated patches as v3 now. I accidentally ended up
sending them separately instead of a series, I hope that's still ok.

I have a few more patches to remove serial port drivers (lpc18xx, mps2,
21285, acorn, sa1100), but those all depend on Arm platform removal
patches that I had planned for 7.4 and deferred to 7.5. I'll probably
send the driver removals for 7.6 then unless you prefer them in 7.5.

I also have an older series to rework 8250 so the ISA, PnP and
platform portions can be left out from the core support, this one
needs to be properly rebased and tested. If anyone else wants to
give this a shot, I'd be happy to send what I have as a suggestion.

       Arnd
