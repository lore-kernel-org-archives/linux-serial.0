Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794414657;
	b=2YkM0h7jjo48Kzl0GwGE94o9r0lsnAnc8z5Dfc2n8Zu5I7IRoY8BhxACrieOrTqS8F8K
	 cjiI2VrMUSnqRd2ok4k0lamFsFl6EUGW6k6eMD4Ue6AP1QiITGsG4mjmsm0TFUPCXquh1
	 KJ/OGXPuo+xiWyPVvNfxUv/ZKRuDvzeGEd3hI64I372M6jyDtANq25hcuzGbuxZ0bFQMQ
	 KAzgRVpgLoUVAF+m68D2+X7B6JhGNlnS9lcivaXSzHsekCSyN6bv670u2sIt1qY+XFIsz
	 slaMjiFYTwjj9ZQEuhcasBjtZRMJNf4eR5Jrh21CnXMFPDKGn4D+/uN+bBnA4wz+Qsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414657;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=cr2pCTFrOAbsGZegayn216J45MBNzuazgQE21QPz1MI=;
	b=nexz8qLx377OuNQpQmrrqZ9di8CCj4tG2NVJ1jWKyn6cNWfLn1hjlour3Q3Z57cHmXNK
	 RbvjO/5RZiL1xdDs9Q9P+BL6z6Ru8iq23vN8ZCWQRo3WS6/b2I2X2PLvG/RjGzpAd73SF
	 +BalHP6+XFdQLuYSQ/LI2v7Dsuy2ltUYYeKX0v2hxUbktMRgpFOMzIZkeT3BmsK6Gxqb1
	 d9MYUQxDGb35/msnDry+zAk9NVqllvnzYMLWLA5ByZuwlSYVtk2dg+0c2vMnKVPPGFzkn
	 tA9PZOo+MnbKjgTxUFJwZTevWfB84dqL+BDFON6RlVJypcQi3lVmqPWJbmBcEgZcGdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HYJXTLlB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8623B606A336;
	Wed, 11 Nov 2026 16:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HYJXTLlB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8335F1F00A07;
	Wed, 11 Nov 2026 16:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794414657;
	bh=cr2pCTFrOAbsGZegayn216J45MBNzuazgQE21QPz1MI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=HYJXTLlBkrjdCyCseNojn+GKtcau2ROmDR7O9+x7L30p+vfVl4Plq015VpJrchrOz
	 TaUDgnq1yVIkN0fenOZXBb0v2nbIAmNVcaM1+TPp5V2nruW3E0T05p6/jfAF8VdX75
	 uliVVhEvdmSO7Ct5e7QtzBG6cCxEg0z4hiyYhr9iGhZs3GyLzL4Fv/Y1oICE3+yhP1
	 KJTu7WcQTMSrW1AEmYqTOUnfZkCipZaOQTZ/Ro3IpmtuHLmUUwnBO9eZI2O5zLW1DC
	 cDHcLSgfzzZ2eLOd4aB8Sf+1asUGwFipYGTGv0fC5U4LVM5IZ0OUXNs7DEaYri/drU
	 Aoct9somAsisg==
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfauth.ams.internal (Postfix) with ESMTP id C7BEE198003A;
	Wed, 11 Nov 2026 11:30:54 -0500 (EST)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Wed, 11 Nov 2026 11:30:54 -0500
X-ME-Sender: <xms:PZj0auo1yxfbFfoGoe9LA3bze4AUiD2An_4zxSrIHkbIvVodyyrEuA>
    <xme:PZj0ancEPS_EwtAiNfbY-ne7ERjRduKZhGB68FbV7HlKRVDmEAac0oJRa1RvcxAGp
    5wc0pd3JW79Vrb51bSSXqHjl1F7foU2cqSayY2YsT5CiLZuze7OvcFv>
X-ME-Proxy-Cause: dmFkZTFpCDf50Xoa/3FMvMuf7A8f3PJYtfoT7NfTRf1FAj4xrp/TZ7mdtLRTn68GfPgMJ9
    gOWIXB3Uu3n7NPR8X6I74B7dRDod70iDH45teUN8bx1XM5VxMSJmLSZFQWwB/4h1rF+uu1
    OpPogxxBHhgok4UwYvI6hS7XJDuoJTbFv0VO+3J3AU8dBeuZwO3HlN6YPFJsPeRJKhG728
    ivaHzkQsgcddsn3/A8eK42elF6/pmoqtOGVf1HoN8Hly4puxJMgJcY/bP1SnPDjMX7jp4u
    pPMni1/OW+9kwi1KQ3lpPgrBtDgBieGAuD1a2nmSSD2Kafmp2l2/wXFIgC1x9RL9+hjeqP
    TqfbvuCgAg4rHpNJaykQ25kK/tzd5ex/11q10soXw5OdC4B0zDjtUlNrX9BcBP6IomNI8y
    79ZDEbjtauyG5/0C4z1Isq+H4pazjcbIgz/IW1j+gDA3QUrZyGkr1yDLFj1OgVDpNb6UlI
    oMLUkCKwYPSqI5PyKEEBEklcN4GxrZVtenfesf9/NSj/ShHx/YIaN66TtpdTfp09uWCDfP
    yy3EBqX1Zc843NxrJeIOZ2urAklqXZsaWUMcxAqTV9v2B7+Xc66apNy9/yCCME/HqyJ2JU
    vm8mEuMZIlZEXSnACDFBg9sFgnmdddVynNhRneKlJbbuO0/gim5NiOG6kzqw
X-ME-Proxy: <xmx:Ppj0asPEuxi4mqou_qL5wWf4yPAcIYj2qjboqd3Wl9TEwYB3VS88rA>
    <xmx:Ppj0arIJ8HqijEeffIGZBY9W5HQ6MaBpJBGBDu94XxIQEcHIF2c2sg>
    <xmx:Ppj0au3OfNb3QKHzLSaJBZZKJSWUScF5xo8I0ROQ17XMZESgNkrSWw>
    <xmx:Ppj0avWOASA0RTI7q1GoI3tKSkhtJ_bIqkeuk2QHDyHPUhFJX2hGMQ>
    <xmx:Ppj0agNARD5wNSMvLawZnFjIaO77c3egnfyKyLWF5-zbaXsbGy-TG9ZZ>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 10F4932A0099; Wed, 11 Nov 2026 11:30:53 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: AmbH9dKluAxR
Date: Wed, 11 Nov 2026 17:30:31 +0100
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Vladimir Murzin" <vladimir.murzin@arm.com>,
 "Changyul Lee" <lcy8047@gmail.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Jiri Slaby" <jirislaby@kernel.org>
Cc: "Liviu Dudau" <liviu.dudau@arm.com>,
 "Sudeep Holla" <sudeep.holla@kernel.org>,
 "Lorenzo Pieralisi" <lpieralisi@kernel.org>, linux-serial@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Message-Id: <8a20b9a9-b10c-4b7f-8d42-2e8c60edd943@app.fastmail.com>
In-Reply-To: <89544da0-7c18-4fe5-8005-131760a2b8b5@arm.com>
References: <20261106010611.1708587-1-lcy8047@gmail.com>
 <89544da0-7c18-4fe5-8005-131760a2b8b5@arm.com>
Subject: Re: [PATCH] serial: mps2-uart: Remove the ports_idr entry when probe fails
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Nov 11, 2026, at 15:17, Vladimir Murzin wrote:
> On 11/6/26 01:06, Changyul Lee wrote:
>
> Before getting into the review, I'd like to clarify a few things:
>
> - This driver is only used on a NOMMU platform, where any code
>   can write to any memory location, so the security impact of
>   this issue is likely minimal
>
> - The only platform that uses this driver is deprecated and
>   scheduled for removal [1], with the driver to be removed
>   afterwards
>
> @Arnd, could you please advise on how to proceed? Should we
> review the patch, leave things as they are, or take a different
> approach?
>
> [1] 
> https://lore.kernel.org/linux-arm-kernel/20260908152808.3928630-12-arnd@kernel.org/

I don't think it's super important, either applying as-is
or ignoring seems fine, just don't spend too much time
on a review.

For some of the platforms I'm planning to remove it would
be nice to backport fixesto the LTS kernels in case there
are some users after all.

Chanyul, it looks like you've done a thorough job testing this
patch, and you probably have similar work for other drivers
coming. I would suggest you try to prioritize the drivers that
are likely to be in use somewhere.

I have a branch for removing a lot of drivers including this
one, maybe check your other patches to see which ones are
obsolete.

      Arnd

[1] https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/log/?h=board-remove-7.4
