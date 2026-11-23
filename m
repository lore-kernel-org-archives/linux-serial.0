Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795421007;
	b=nuNvS4RZrIzKDw5Pq8KTw1uQslydsTldMSR3FWFkBgYk8ukjBd++y07htsMfrOEXXGp+
	 ydjIl5mZGvFlgm4GqjweeCBhBAMKbOt4/V1iILE3ZQQ6rB4cpj22RPhSuD0bF0rvbtkZX
	 krWvCYapk9RaL6kayN6JXJz+3ZwyKHxzjtPXxRtPnLfhY/JMbllKfQzYqGawALq0AeG6n
	 4RH25042BkQEAE7D7W8dWu6NAz+7q99MjyMickR0QIYRsMprqFUs9bnqg+cZb5Je0RT9w
	 Q6pG5ElACzlS/UndCRG3DwRLgy8d62Oq3umivN+zB6+KhruTLtFUdODkdFbODrx+FkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795421007;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=56qIsCsRYahPEGbFo42LTUf6UE/vtnz8sOVyn3tuhYw=;
	b=43NiTfsROE013abvsStYdo/e/XTSk07eg7jy8COL2rq8eZqvJsmZ56bTvZGFY0HpoZ9N
	 CLPESi2QEDb7fg58tWqPppjq8eDdR2khuV60viMzwH8/FbgM7DG796kcsZKWSikgj7J92
	 uG49hYFY8mfpe6l+rXwikNifcyax9ZdloWugJk2O153TvkCq1Qzg3Fno9/+5LHyAlvF4N
	 U0+ABv6F2IlHyqKyOsbeCI4aPLN3bzDNEAkSJ/yfGPGw3KSyYwYmDNt3c/OuCjKlDRRy/
	 xsS87eho0PeEVekIoaQzeocWhSMxp6iHDdIm/+G2Q9uyol7Ax5e02Wa21rwl135s3cQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WXDWdY2C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D28B606A692;
	Mon, 23 Nov 2026 08:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WXDWdY2C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A661F000D0;
	Mon, 23 Nov 2026 08:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795421006;
	bh=56qIsCsRYahPEGbFo42LTUf6UE/vtnz8sOVyn3tuhYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WXDWdY2CoEV4UWyZSScfG4er2dUyJViQN7Dm2bh3eR3n1mm1tpCKmjOlwb8hxLgLL
	 y0N2cfQMeg+R7d+StHduLrTGUtxkYsJKNrTI33vpxy/8bN8WUWW3ioKHnMQ0JU7Flq
	 vonuoACr2bT/s0vYmHuFhC2QXubxYSx32PP6yGwE/G2Rmqk23ZGJLR3rvrkYkSZeay
	 LtF7HcgO04iPTtgk60TsfMPYoRWUWoDX0ylNypywXnNkB4HfziwURbm4w/8euODn/J
	 TB/+9MpvI6cAtYAguCcNT+0zJag06mSTXgDh782vxnvBQ3Jr7bivTPPfGB7bKNNv2J
	 XSRVEpjleKAGA==
Date: Mon, 23 Nov 2026 09:03:22 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Tapio Reijonen <tapio.reijonen@vaisala.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Markus Probst <markus.probst@posteo.de>, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
	Christoph Niedermaier <cniedermaier@dh-electronics.com>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Lino Sanfilippo <l.sanfilippo@kunbus.com>, Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH 2/7] dt-bindings: serial: Add the line transceiver enable
 GPIO
Message-ID: <20261123-transparent-coucal-of-persistence-8cfbdd@quoll>
References: <20261111-serial-transceiver-supply-v1-0-40bad0f912f2@vaisala.com>
 <20261111-serial-transceiver-supply-v1-2-40bad0f912f2@vaisala.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261111-serial-transceiver-supply-v1-2-40bad0f912f2@vaisala.com>

On Wed, Nov 11, 2026 at 12:28:01PM +0000, Tapio Reijonen wrote:
> A UART's line transceiver (RS-232, RS-485, an isolated or a
> multiprotocol part) is a dumb device with no node of its own, yet on
> many boards it is the largest consumer behind the port and can be
> switched off, through a shutdown input of the part or a switch in its
> supply. Device trees have no way to say so, and the transceiver stays
> powered for as long as the system is up, whether or not the port is
> open.

To me transceiver is part of the UART device node, so this should be
handled by device schema. Commit msg lacks actual hardware names
justifying the change.

Best regards,
Krzysztof

