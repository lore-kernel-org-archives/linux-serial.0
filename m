Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E5433CEBB
	for <linux-serial@vger.kernel.org>; Thu,  9 Jul 2026 20:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783629221; cv=none; b=GXS63M/kFKcNXkPVgwPx03MfV7eCkkLlfSPBYSXSzJmEhAGReQOUhuKCEILf05EgTTKqs5hPxyldA9y0deV9lhFVdSA6WMR+qCHnvUfQk9XquJsOXKWbu14aQUTkayBGgAnbt53qbpHpfNJFNcfSrhPPYpRFw0IPSVhYKBL1s3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783629221; c=relaxed/simple;
	bh=8aGVDY1USFmbcVaVqGQG/25y+R/Jk/UAStmSphUxP0A=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=OO8XFa3Aa2raUbmqIdeltBL4in/05om+2oivyw6HkWMj9KsGUMJAt527Nh6fUVd/4fj1N/NExNLSjsskFPs6QUnGvSrScKnoSVczwB8snAcMj0NLY6dR+7jLMvtjSKQIZ7xLyavaYPqqTOlGbWi1Z6dGzp0TemjdHqdTOCl4390=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=cgnsP4rp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ATQp3/MF; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="cgnsP4rp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ATQp3/MF"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4AE457A00B6;
	Thu,  9 Jul 2026 16:33:38 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Thu, 09 Jul 2026 16:33:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1783629218;
	 x=1783715618; bh=m6dBFNXrhLV7+Crrk8Cv4j2NANNfCghYsdfOPMM7nnU=; b=
	cgnsP4rpqxRaeJ7UDQYq8zxK3S+Vhgyq4UwMidAMm6cqJcBB8V9J/WhaojJ9G2Jo
	6B1+Lo6QkcPqK+Oq1aDgbUQ0MYmSHMDkl3i/lBtxH+L6PXEF768NpMFAtzdj3vCH
	V+yHjKzxwwi/VprEAJWxBUtIzPSRl6MyZgZ7hF77ylTbaonurgkE0bIs08gUjNFc
	gjJ7vXbhzbog7WOinHbY8WsrOzKMsKRg0m2wUYVoMnvhlhP3VDcsnfnQ/vrdl8fN
	BwrGbO3juEn9ONSvzg+/4W0JSwgL+SPe3ijk1/3JC2YBoRSffBuu1AR+7Wj38Rb+
	3qkVo1ggfNIVkpIk3eDnlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783629218; x=
	1783715618; bh=m6dBFNXrhLV7+Crrk8Cv4j2NANNfCghYsdfOPMM7nnU=; b=A
	TQp3/MFPF0WzVkIb/FT0BnsAjQ047ggJUACjqfA/SRHDpXzkE/aNVjOCxTBoRUPH
	p2YCeI+sA+4jeUuqLbYnXN+BqbrNuYQzYOD1t4CAhtVYw5WfhkuobzzjxozjdFio
	k49T8OZViv6ax/viqO6VQj9KK4ECieMYfBnXcCJdJPzQuJqNATBnLj4GQtomjWgd
	2JNagAU7BI9dKrg1n77gaikluwIq5F/TV6U97jb9sLUPGmM2SmoKwoV4t76tYHcC
	2eGZc/dmN1cvgBTw9v8W1qk/moSp8RdAmVgycIEYn6AgI+oeX98nLkQfV80JJX+O
	Oy35uSUWBLDvSaokx5juA==
X-ME-Sender: <xms:oQVQajFmmSaDfdGbMRGCLA1WjqtpOV9npkNkbJgUFoDwnk8IiuiZzg>
    <xme:oQVQarJc28-xCoIEI_S6GaHwsZ7KoqvF2gVzc2evGHseq9D67CgWWkKeXUXbpZ_OF
    yq_0TjykzDH-DnplgwyfOJ28marvpRcCUVno61zLjGbOT0EaNRd-A>
X-ME-Proxy-Cause: dmFkZTFqZsnrpUfcmeLluid6zKkM3LYfZSbK7Rcefd88/QpWOnWmZPhGxMLqMl7kisRM7l
    Y3cHikS7pTifXPM6n2tqkDAYseW/YDkBa0j7B9FPZ3A4IMtezgurcws2NRUwHQm/HGNhgn
    cTLqrdEOoXfvmSNwMp+x9ssbLaGroXBvMzDhMppm+Cs/dRGzCX94Roi5NAh+OEJkd61Uwl
    SqyBnJfFh2t7e03RyY/Nmm6eO0H7dbGPH13YVYMSR+lvQN3oaLl+I89gWuhn80hCAMyufJ
    w7mmgfC4KLN9N0yGB0B0/uf52AmnCG8ZIjoVo1epEcMKwRFeaKc2NWheBQ9cumWuFkgIYn
    uRTPXZ2noF+TU5VWSLI3yBB5ApalM3ERJiSBG4igJ+Jo+hQvSubq/wTY6ncI9PAufV1gcD
    jzHARJ9SB3lRJEeb6kEaCszZX9mEDuJNIA00jW3KVh84CORYDf+XamGB+h6TL7tWmTuzQ+
    AKtiwyQwcQeYOeLXiJaGcl9DQIwt/EZ1cl2wCtcjLMoeUcgUngzjQ5bD9qr6IkHaAgNz3F
    n42dMHU3B8Kfogi/m3zRSZH3Lj9h1pIJYGXtGTjGqjV6ZTbDpOf1ZG7MCJaInx9bwpkJBg
    XlfrRDeGW+zJdktqQsFD29AcJa66Mj2RKk2GayjfCBXh5GUBhbhjKcdPNq/g
X-ME-Proxy: <xmx:oQVQakvP6iWrdvt4Uhz8QbLxa6YURnL1TRNsWddNYwZalT6Opol5Sg>
    <xmx:oQVQavSyexfbSNg9odDn5TAhNCpQ1wFTy_6uF8030UcVi85_vMPygw>
    <xmx:oQVQaqOfo2D7w9_vamLxlcSs3z69znePNqNOE_WT1v9axXzInW-_CQ>
    <xmx:oQVQaka48fm1r88kK-k_VALNFBr53bvUzP82yjSVReF5xq1J8LjbvQ>
    <xmx:ogVQalh4R8GztRHJor9fXfvh3xEKSBYwQCDJ_7FvysoGkBlQ5kwcO74->
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 90E4F182007E; Thu,  9 Jul 2026 16:33:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AOmfXBHEEPLc
Date: Thu, 09 Jul 2026 22:33:16 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Walleij" <linusw@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Jiri Slaby" <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org
Message-Id: <8e8795a0-704f-46d0-bb1d-5833f642df7b@app.fastmail.com>
In-Reply-To: <20260709-ixp4xx-serial-hackfix-v2-1-465fc8e4c54c@kernel.org>
References: <20260709-ixp4xx-serial-hackfix-v2-1-465fc8e4c54c@kernel.org>
Subject: Re: [PATCH v2] serial: 8250: handle ixp4xx register endianness correctly
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Jul 9, 2026, at 21:21, Linus Walleij wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> Unlike modern SoCs that just work in both big-endian and little-endian
> mode using the readl()/writel() or readb()/writeb() accessors, the
> internal registers on ixp4xx behave like native-endian 32-bit registers
> in both modes, which requires adjusting the register address
> when using 8-bit access.
>
> The existing dts files are written for big-endian kernels and 8-bit
> access, which does not work with little-endian kernels.
>
> Add a quirk that makes the 8250 OF driver:
>
> 1. Mask off any hardcoded offset.
> 2. Add the += 3 offset if and only if we are running on big endian.
>
> This should work in all combinations of big-endian and little-endian
> kernels with either variant of the DTS file.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> [linusw@kernel.org: Modified to just play with the offset]
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
> Changes in v2:
> - Use PTR_ALIGN_DOWN(*,4) instead of the custom &= 3, which also
>   works with a pointer which is an unsigned char *
> - Fix to the earlycon code to do the same thing as the main
>   serial port.
> - Link to v1: 
> https://patch.msgid.link/20260709-ixp4xx-serial-hackfix-v1-1-cd1c29d02183@kernel.org

Thanks a lot for the update, this looks good to me now.

It's barely worth keeping my authorship on it, as I'm sure
you have put more work into it than I did, but it's probably
not worth resending it just for that unless something else
comes up.

    Arnd
