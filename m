Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D0214A0BC;
	Fri, 27 Dec 2024 07:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735285422; cv=none; b=hcDCVezIPGSVUjPh8Shj7cmE3QX/F4IBs9zt9jUsDq0RQnFUYAwIVCTq6bMR5jGUMeSV3wSSHinV/p6o4s8haCeB7vDLysK/V8VapOCaVQScKfLOlU0ep5ARfz98XkiMrkCf59Lc4wNx4nq/PBdSbI75CWhDD9kEW52KnSvvZ0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735285422; c=relaxed/simple;
	bh=zZhOuRm+PASsS+k7ZVAuUfCNT4LIZdHw6OjN5ARVmYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RlM22XnNXR6E/z0wBZfCH9PVu1wb6dVJcuRiVUGn24eqe6tPShlEb5csXiNqdTXBVQ+YptZhBJPnknwWFUWDn7iD8gu18RdQZ5L9PKjeJAlHVEKUsYX5oif31Dkc5HEmRI4FpmN9Z0gy4HUJkgAiPnpSntfQRPe6WCG+BqjG0sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ddaAuQgS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ddaAuQgS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05BF0C4CED0;
	Fri, 27 Dec 2024 07:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735285421;
	bh=zZhOuRm+PASsS+k7ZVAuUfCNT4LIZdHw6OjN5ARVmYY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ddaAuQgSf19y8QIcXS+2Ll0bc63nSIiRT8kMrzva8xDQsFvZbGV9SEcEIw1GqrrRH
	 OaQKN8ksOpMvxiYdim4SAHFzA1YENP8igJvyAW7zUNVowAgReoZ+iaykOvrmNrpFFB
	 NuDjGEejKAv3J9DVwlHhkQg8nBjTdCuc/lba+sLOdqxUb8mTQY97MEY2NQwcfkKUCQ
	 1bYTBm182WBLA035A00yQdP30CSotsLf556gfpyVBzYDsJJyNU2fW1qJ12/OIwMsDT
	 vR6+uo2xESGxTlS8NEjJ0nzzNdKHsCYjF/TVBioiZLy9aqxigL3DvbmyLr6YZuZ2gr
	 R9HhrrfjoH5Ew==
Date: Fri, 27 Dec 2024 08:43:38 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: heiko@sntech.de, linux-rockchip@lists.infradead.org, 
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-serial@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v2 09/17] dt-bindings: serial: snps-dw-apb-uart: Add
 support for rk3562
Message-ID: <etw5iuii7i7mmedlvqkuufis5pl7zlyiipnu4zeqmfjrvsc2vb@ptgw76zcpsm7>
References: <20241224094920.3821861-1-kever.yang@rock-chips.com>
 <20241224094920.3821861-10-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241224094920.3821861-10-kever.yang@rock-chips.com>

On Tue, Dec 24, 2024 at 05:49:12PM +0800, Kever Yang wrote:
> Add rockchip,rk3562-uart compitable for rk3562.

Typos.

This we see from the diff. Say something not obvious. Where is the driver change? Why aren't the devices compatible?

Best regards,
Krzysztof

