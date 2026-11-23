Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795420823;
	b=PO6xgUWcy9x6EXm3+eslm/zrYTwNuAHNRZlwMuHSr2l0flYdRS++LUpRDnKwn2kAD8f4
	 Oak2y+gBtIYxQ+TCtv786j4Ix0j5ce2fl1GqTRAEwo/Rl1KhcVezHNe+E5S5L+LuF6iNC
	 12SpnF6tBDAC+lD9nOg5uO/Znjxna+wFqHyXY5l/PMn0yEELoocUNRXWi5ugUWLjTju2v
	 j+bLiMIrHf1XtCLF6ltFaBMsfYwfvhBC6eZdkyaTZiPKyoabjEpQeKCK3mkbJRVghux2q
	 riXNvXrHdBGekEp+5e3+S0LlZDoiCNslB6Qi0Gs753Uc5ciq0cmxjQGz4fToShmN+IA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795420823;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=2OnPm5ivslBz4KVWlKoUxVBmTVqZjfY7/E8iMQZaZfw=;
	b=yYz7tRUd1Nr+O5oXQR1Sjo7yRC6wKrPTgkFqOwCIEsCBPTYWb6orbNFlBSuTHKxfc2pd
	 nIllhXR/gVBXq62Jja37GVkac2hwd+lXWyK9rmRPrubBcQDx3UdrlaOdUAO8klogfjXDc
	 RvN75ST+ZgA3htKgFyAtTsMEwDgDtqdRizFQE2FquLV/pPdGXFX9KFJpOG/2mYkjVRzKe
	 99YO5oVQPcoA3ReMZKFdBA9eVC0sVlh5nAgYfAWmrT234VqTaOHyK8HvqlxQsxSdjwo4Z
	 M/2oxgkh1dMeoZ2JEHxb+jlf0pGqK6cMN9K8odXp280rRoXJ/HXzsJR2/K4hivXBgCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mGtRMt8A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9B760A5BC3;
	Mon, 23 Nov 2026 08:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mGtRMt8A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D97681F01569;
	Mon, 23 Nov 2026 08:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795420822;
	bh=2OnPm5ivslBz4KVWlKoUxVBmTVqZjfY7/E8iMQZaZfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mGtRMt8AUlkPvUgp4yNw5Vn3jhhla0B/bnOICYzS/FkE7Od4PQLm+D1YLDHchIk1V
	 E6KqM0wJlJhobzbOICK362X3py9zo0A7mQ8/R7fj+9Vl9R9Y9HN4Tz8swdLaTV8omT
	 OKvUrT7LuQftaZfiqTYEm78V21pWUbuIgk2cxuc7uJPNkQNpaH3WzUxUMZo3TNPgbk
	 HQEF4V3R0VSm0e6Z3wxr/nLsE1FAHJ9OaTt4jOAbm8xB+QCSfozTF5t1WyGIDw1Owp
	 eHLrRbj45wSuA5Jv7AfYFG/oF6maRyrnvK6ljNVxMzj9Xu49BtPTHbfBig0L/1nIUL
	 nRJrjveLBXrHw==
Date: Mon, 23 Nov 2026 09:00:19 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Tapio Reijonen <tapio.reijonen@vaisala.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Markus Probst <markus.probst@posteo.de>, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
	Christoph Niedermaier <cniedermaier@dh-electronics.com>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Lino Sanfilippo <l.sanfilippo@kunbus.com>, Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH 3/7] dt-bindings: serial: sc16is7xx: Disallow transceiver
 GPIO on dual parts
Message-ID: <20261123-outrageous-narwhal-of-refinement-b1bf8d@quoll>
References: <20261111-serial-transceiver-supply-v1-0-40bad0f912f2@vaisala.com>
 <20261111-serial-transceiver-supply-v1-3-40bad0f912f2@vaisala.com>
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
In-Reply-To: <20261111-serial-transceiver-supply-v1-3-40bad0f912f2@vaisala.com>

On Wed, Nov 11, 2026 at 12:28:02PM +0000, Tapio Reijonen wrote:
> The SC16IS752 and SC16IS762 describe both of their channels in the one
> node that references serial.yaml, so transceiver-enable-gpios validates
> on it, while the GPIO belongs to one port: the driver gives both ports
> the same device, serial core requests the line once per port, and the
> second request fails with -EBUSY, which fails the probe of the whole

Which line? If you mean GPIO, then use consistent naming to make it easy
to understand and then that's Linux GPIO limitation which is being
fixed, thus no need for bindings change.

> chip. Reject the transceiver properties on these parts until their
> channels have nodes of their own.
> 

Best regards,
Krzysztof

