Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0152E2F0D;
	Tue,  8 Jul 2025 17:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751994190; cv=none; b=ttyZNEDphssnyNMtjZ6z3YqRzVCRpHJ2oKf+AGg2d+J86VIcWG8/hIHlIrdtXZCdYBKMOs1bpB+FcwmWRasDtXdzoRBKNI++af17TqEoYxKl0dCKt90tnZbCI2hZKvymXR1JKTKSHE+VD8KV36g6EehyvA8MI2minLlH9sh+3IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751994190; c=relaxed/simple;
	bh=XKYlXVbQYV2iMMorUJfhOli2L25rSRot9E9TXpcj7rE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R65+JcpVE7gN4n1rBkFxt1+29PPG6a3bC1LNOqRSNGhl1RJu4kS2y+MtZD1EjMxweCbK2FX1UrfVxKwoWX7jYha8BPIUJCE3ZnmDgbXY6LA853sFdxeH4OGGQzzHF6j9DgZhqQ/fJDLNdaMWsfzJkMmhRXO/jip9hfwUPwYbFxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TbMPeAHH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TbMPeAHH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A9BC4CEED;
	Tue,  8 Jul 2025 17:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751994190;
	bh=XKYlXVbQYV2iMMorUJfhOli2L25rSRot9E9TXpcj7rE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TbMPeAHHyXupSUq7veM3WmjyvDpgmewaXHTP9Jz26AlaId9Gi6H4aJv6u0v0m1Y4u
	 6DyWIPTcGpCrS0/yNIpTpV0yHF9EyJJ0JVlsGuQAm7YYhZDiwoKCDYEgtUKLstyl/p
	 MjnQp29JLDT9GVwMr7D8UeIi9CIyyjMx9P0JT2d6mB5fC++h+CDsx7OwaKhgYO44Bc
	 0EIdjaW6ytdTXpRjchHVlX5OMKQfSQuWMJ/1nOGm3cHhP29DSNM81xAy3AvKTb02P3
	 YBRQV3l6+kdZf7d/iXmEENuZuMYcztgpWiDQXb3x2U8+wS2msuAm6UN265pucXKrC3
	 ez7QflFr3/Dbg==
Date: Tue, 8 Jul 2025 12:03:08 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Thierry Bultel <thierry.bultel.yh@bp.renesas.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Nghia Nguyen <nghia.nguyen.jg@renesas.com>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: serial: sh-sci: Document r8a78000
 bindings
Message-ID: <175199418824.629588.10971950243048104169.robh@kernel.org>
References: <87frfddghg.wl-kuninori.morimoto.gx@renesas.com>
 <87ecuxdggq.wl-kuninori.morimoto.gx@renesas.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ecuxdggq.wl-kuninori.morimoto.gx@renesas.com>


On Thu, 03 Jul 2025 04:51:50 +0000, Kuninori Morimoto wrote:
> From: Nghia Nguyen <nghia.nguyen.jg@renesas.com>
> 
> R-Car X5H (R8A78000) SoC has the R-Car Gen5 compatible SCIF and
> HSCIF ports, so document the SoC specific bindings.
> 
> [Kuninori: tidyup for upstreaming]
> 
> Signed-off-by: Nghia Nguyen <nghia.nguyen.jg@renesas.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  .../devicetree/bindings/serial/renesas,hscif.yaml          | 7 +++++++
>  Documentation/devicetree/bindings/serial/renesas,scif.yaml | 7 +++++++
>  2 files changed, 14 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

