Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70D13C1D47
	for <linux-serial@vger.kernel.org>; Tue, 13 Oct 2026 09:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791882330; cv=none; b=bZOJwZf2CvwX//syVi/7fmehOq1kyeqdyUhrJVc8v9Jxv+rFvDmrDdyYGohJq/23p/bKpY/m4OCku2ouVTHc3MLegBw7Y9mHtniErg/hY2jQPXR6mPxtDs0cf4EzjyGPLTyvWB0L/xpCGWX7gqDgTVZ7Z7HuDnWs6YYhU/Y2rXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791882330; c=relaxed/simple;
	bh=ZFmLcCeL3cuHdz8AwMbttcGTR73WQSlfkvmtDN5wQf8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=h1XQ9PjSZUYEVa7F9ZzNfVGRUns1WGLMFBpI69D8Faexu2U/q3+hld7LeHnzi4aC/xS7lotPUzqG40ONfHWWQQBEH/Tra6Abzdonjv9kp6mfJpNIVGYW8Tzj4ESLzvcTJm9KCX0cGTnR6JO0jjkC65abtzKZh/NYFc/MMweyC+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=idd7msZS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rayI3YWz; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="idd7msZS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rayI3YWz"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.stl.internal (Postfix) with ESMTP id 0CEC61D0014F
	for <linux-serial@vger.kernel.org>; Tue, 13 Oct 2026 05:05:27 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Tue, 13 Oct 2026 05:05:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1791882316;
	 x=1791968716; bh=5Vu+OzUk0MIMBYSS2c/IxqZ4LiwoE9Nz2IqLhJSI37c=; b=
	idd7msZSsfRL3u79KkWVHMhvQE2Iq5DPnSingn8n5pygs5gk1oXJoa0gUNnua8Hq
	Dwy54W32VjKEA9er6JthFzKN2QcJHy9huiaG/Nq5Lu9eQQtytY4zXDb1d94GNUuI
	inIrY3qWfHcUao2bDYhY72QHLTHCj/1UEY+fd4l3lxug7yQpG9nWdyoY0atlyzq6
	WTX8f8X9USO3Hk+w/u+XG9l8KSJA6oni56Fsgkcepcs6P4sz8Py0tA+d9HqSe6N2
	SweMD5e0016IudfYfbt53fkaUGMiA00mr0IrZjH2Ig5F2TIGKq1nRBuTmhP0PuWW
	Co2Torw8uBXcBnPdvvU6iQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791882316; x=
	1791968716; bh=5Vu+OzUk0MIMBYSS2c/IxqZ4LiwoE9Nz2IqLhJSI37c=; b=r
	ayI3YWzKU5LUBrAzpF0W+HMthGVmZhb+z8sSbJN6Bzr3im8LedSX22LqhBIZ9TNn
	tHB+d8dcFyH/YO8YUcW/NJOVvBnrIxzCLIX3IRHQH+rXGSUq7DeGoUkzb4Y6GCJJ
	I12bNBQpgiR49p6GvdAkJuxIG9/dnkhRuuVaUbK95mErniixIgjUcQwV/EpAizbm
	TdIa/WzNoo/gaUBVCpTXIeCIvKIi2HzamF6IqrsLjjlB67HnSwFtWVZV3xbQFM06
	JL4V5axHJMMNwlEall2p5LCid7cQwO3lnTeoFaJwSdwzxKPoJCAgecI803/W18qA
	GeSbnXs+3LYFFm6pYJtew==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791882316; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PGxpbnV4LXNlcmlhbEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:bFe2L3l8RMorhsUggmnwrTzkkxkz3Q2mOF+4WCEDnsmnszM
	SXA/9K7LP+XrKNoduGjYGOv00xjcTTiTzU2vRHi0nZhgQdt1GKMhHsMnUCD9IGB/
	VBTw9zN2jVmBJ1PTeYGGtPPxfw50M3fDJyZR6hAQz1nNV3GPRDYW4wuFfqW+RqE0
	So7F0f6Iba6atOi7WAV5pwDOoPUGZUNau+KCN6U724q55hM+vIN2jNQDxazOy9si
	daIKtcp2LeIJUKq6latjkv0UQglyIZXWF8YfGeHaiujXfaopl6OhT6HmEMzg7KgG
	C6pjumdZL0cYJJPLqkUAumkNoGJYDLIHMevn6cw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:YlRJbN86xwXuiKasg+HYpYUGf7FUWur5wgJz9NO67zo=:ZFmLcCeL3cuHdz8AwMbttcGTR73WQSlfkvmtDN5wQf8=;
X-ME-Sender: <xms:RvTNauy3DPzUGJinL1qQ5nkQ05tHOrXW9qg6p8T3rTOl4OSnDSp_kw>
    <xme:RvTNalErx89Iu7OGUtpLMtQG56nFAozNamFYO48-5ya37o5aYFpvnYfm__R2AzQ0d
    CyRCgdJmCZ8SjdBfRjZy57_MDmmjI3RMEUrLqkZiC63BXOKsSRRqb8>
X-ME-Proxy-Cause: dmFkZTEaKGcxRZWYC2ZzlxnfGYHVFhHnMmkDqoeW31U+gEtaJKhI6TlLUmnksXJOUEBrd8
    yBlHpJ2LC6dZ7XmxwbOaq1yRrnpd7SiaJ8Ggp8hbsA0vpEDveQTHee9kHbDkEYeDcNjOdv
    c8HHJ3t5VPwERagUysZAWfIV309Y3knQIFpnR1bJg5dL8c3RMwoJBFGFYOBxLcSsx6jCdi
    9bIYNQIB6RrnhaNg9/TRKM11VmCsaXs2HypU3I1uYaieqsG4ypc9LDuS9YAdzrEOdZqV1z
    bsoRPAvE2UAp2JvGmXQSLGlE92Z8vTGU7D1lzOPHEFReiYt6XM8zHN4tyC5Fi5hBPZFvfQ
    6NSj1S8McnVav/vuOhoHLYKRwxVO0jI7qJGxEcuCCL+XekWVn/arUhpLZn8kQqHiiCokqR
    KDFd61k7au6y8GK4/tKl9o7gwgUBm3z4a6yNnIGYFVPPiGJg8ndjVsQOntLn4KtX72lFwD
    0/g243eETcuARDPnkk5+ZOKc+FJcACtmYaIG28X/1Jgp2VS6fyYxCo+w3LxFB4/9bULbtj
    79IJxW3OIaHqkoPVpcDbVNzBW9Q/Qznqm6kTiVrKiznLIEX9uVKZmqf5QP9rO9WwEUrnbB
    GMIXPbPSW/zIFCpPIfX96ztVpdQ395de/GweoDXxgi54srp709yqGrIHxiKA
X-ME-Proxy: <xmx:SfTNajarx3o0JmpfaqmZ224StPTnpAxy7rWKLZ3KrGpPJrufNHzA8A>
    <xmx:SfTNaqUglVjJXHJ7xKHOjJCTZEBXNdVjEQFXcN7W4D9pzlcaoR_hpw>
    <xmx:SfTNatItlfZ4pjEJ0leoFl-hpcYJVsdOQFywJ6oo21IHfsVdu9D0-g>
    <xmx:SfTNagGMKnMqbFToTrE2FAcbBwgN8Vc7dQSe2xXwQh4_MYKpJSqxuw>
    <xmx:TPTNakG6G3To8SYyvfPexCKyGeW0-zHAIo9l4HWowG0eZv9kDsz2OWo6>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 91C8432A008E; Tue, 13 Oct 2026 05:05:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aj8tA9m21Bng
Date: Tue, 13 Oct 2026 11:04:50 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Fil Dunsky" <filipp.dunsky@gmail.com>,
 "Krzysztof Kozlowski" <krzk@kernel.org>
Cc: "Linus Walleij" <linusw@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Jiri Slaby" <jirislaby@kernel.org>, "Russell King" <linux@armlinux.org.uk>,
 "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
 "Drew Fustini" <fustini@kernel.org>,
 "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 "Jason Li" <jason.li@cortina-access.com>,
 "Conor.Dooley" <conor.dooley@microchip.com>
Message-Id: <192a1f7f-79e6-403f-9910-d46b871cae2b@app.fastmail.com>
In-Reply-To: <179187343453.3124451.12229499654368455627@gmail.com>
References: <20261013-b4-cs75xx-v6-0-37e8f3969b7c@gmail.com>
 <971b67a9-7e3a-4fde-a8a1-e5a78f8d6436@kernel.org>
 <179187343453.3124451.12229499654368455627@gmail.com>
Subject: Re: [PATCH v6 00/10] ARM: Add support for Cortina Systems CS75xx and Securifi
 Almond+
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Oct 13, 2026, at 08:37, Fil Dunsky wrote:
> On 13/10/2026 08:18, Krzysztof Kozlowski wrote:
>> Way too many versions of huge patchsets. I already counted 4 today.
>
> Sorry about that, my mistake. I will leave this series alone for at
> least 48 hours now and collect all comments before the next version.

Please just wait until all soc patches for the 7.4 merge window are
upstream, I don't think anyone is going to look at this before
then anyway.

    Arnd
