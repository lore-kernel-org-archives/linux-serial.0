Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795339863;
	b=cOaJwMm2MZ+eOVQsDuhNv3DvlzYjvBUGTWD2psGFjHVETk3t+/yXRVwzQoSKLgcOtZQf
	 OlZ1eIRJzjnbXpky7PIIqmw1b5EUQzjz/EAXoo/s1Pn7dHvcERNdSe+cBqzY6rX+pdy04
	 Fe3Sf1qCp8LdaohjjcRRiYNA8RiufDgieO5H2paafO1mBuPBuSY31E6A2FjSBAIiRquLs
	 BA8Gg4sMBZBHw3WudGgD9SYqkqrnaYea60DK2dN4194UtLToQWrGnqSeLNooGLBd6X0jS
	 71/oZzC7mU0bCRQvuRsXhvvkofjqkTkRCMDX+auA9yFrUXKjQAeQFJk1jmRJkz26zEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795339863;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ENep0JgHU2vzKr3RdB2IMHrrvr0fW00updK/iBfBHwA=;
	b=F9isinm1jfqODNsll52Yg4/JTv8GTxMDiRygiwje+g1XGDiFQLAksOMRc4LGGUyRNtfP
	 0KuGNxbntDb+QToElvwp234H1f0ppf6jSt72oE0Pxo6VEqetJlWN5VVdnxgNbPQOsTuF5
	 EDZUS/anyXxZuui1hyCNfEVDVCZwEM4auJ3JL28Q77lvNhztJr6maqw1OUe1hYssdCXn8
	 sRu+DvBjgMtUYczzR9fe6elAQXIqa9gRDIwMifm1fVl2O46d9pnkQK2RbbuW6gO63m3h5
	 Xn3Ge9zpSDCPMrf2OwCHfA6YZigYN3OJoybkrnsZTvgCajsJFdHGpfjkXQVy2DvaCFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=b+nK6kz7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5E4606A320;
	Sun, 22 Nov 2026 09:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=b+nK6kz7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A95A1F000C6;
	Sun, 22 Nov 2026 09:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795339862;
	bh=ENep0JgHU2vzKr3RdB2IMHrrvr0fW00updK/iBfBHwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=b+nK6kz7OmdvT9hq2XJItJaek8evi7a9VJ67GqjoWeAMrX4OaGEpBGTjA0wir/TuQ
	 +R3ew66FoS9S2KWbGLDhkqfJTZNfMa68wHg4bcW5CforTtHI842N0lJjfIWSfuJF3C
	 IA0S1xOOGWPZYrf+xHlLli5YgaHmXc892wAA+FcQ=
Date: Sun, 22 Nov 2026 10:30:58 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: emcp@enser.io
Cc: Laxman Dewangan <ldewangan@nvidia.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Krishna Yarlagadda <kyarlagadda@nvidia.com>,
	linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: tegra: do the baud tolerance math in 64 bits
Message-ID: <2026112253-salute-epilogue-67b4@gregkh>
References: <20261122-b4-serial-tegra-baud-tolerance-v1-1-39907382281f@enser.io>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261122-b4-serial-tegra-baud-tolerance-v1-1-39907382281f@enser.io>

On Sun, Nov 22, 2026 at 05:11:23AM +0000, EMCP333 via B4 Relay wrote:
> From: EMCP333 <emcp@enser.io>

Real name please.
