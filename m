Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535742B9B7;
	Sat, 14 Mar 2026 00:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773447763; cv=none; b=plQTAF75D2yT6H65UwSo56Rq6NVKuAePXOFNGUqU4yMxq6jflxAnj5ZddQ3MR9R+4MAPtpp4+VcAX9tIWbm3y8LxNDGWsxa4OoTEvxOhR6VUp2J9vLyomtOMsNAHCTypjl42buJlrdPnwmVLxa+zLaQjccOw4TxfqxXYfisumR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773447763; c=relaxed/simple;
	bh=0+ND1aRfu6WzcrXhB1aDgdM8Yq2QvZyjUnfx/NhOjKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SjEY4DuAwfB1wyCYbjmWJeUX341wNVmFqVfReomd7ZK+er9Z83+HaHWCxAn2sxywT1oApZbx+9zPniXHMnPA4HtpGcIyLuvq4qEvL0IG0XnRbIqKjfBRAfbQ0KbSi2Rc4BAgET3cJEmWEiduSpzDPDAtEk0ndQc0Qq4yf4NQRyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LzEI3zWu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LzEI3zWu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0709C19421;
	Sat, 14 Mar 2026 00:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773447763;
	bh=0+ND1aRfu6WzcrXhB1aDgdM8Yq2QvZyjUnfx/NhOjKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LzEI3zWuh5hwPxsXbtN5wQQhswZ1wBZRStI3/HlA6g2q1OHdOCHe4Au40dVHOTHOE
	 ACYbfxArYDHimS9JyVYQo95QR55ZCGRwrO711y4hZ7tabkwtAaHUOimWUPe0LXdP7T
	 83aVUvTXGq2e0WSxlbZNSLOiR4y5G+l0YOZq5Iy8mboulZyvD3dEFc569Ysy+h69P4
	 tn41DDvbKdoKHwQrM9wVJrCEHG3py1G+rTq71f3JHhtN91Sg8qQ0fysztWcgCtwbJW
	 1C4cS/ZprDkH0GSo8KnMiYNELYEfnWuE/mMRhjERVLHwPmtGtbtLPKmZcHT+H2461e
	 kK/ek8C+kR37Q==
Date: Fri, 13 Mar 2026 19:22:40 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Biju <biju.das.au@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-serial@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, devicetree@vger.kernel.org,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 1/2] dt-bindings: serial: renesas,rsci: Document RZ/G3L
 SoC
Message-ID: <177344776029.3722290.9591899535804850157.robh@kernel.org>
References: <20260312082708.98835-1-biju.das.jz@bp.renesas.com>
 <20260312082708.98835-2-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312082708.98835-2-biju.das.jz@bp.renesas.com>


On Thu, 12 Mar 2026 08:26:58 +0000, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
> 
> Document the serial communication interface (RSCI) used on the Renesas
> RZ/G3L (R9A08G046) SoC. This SoC integrates the same RSCI IP block as
> the RZ/G3E (R9A09G047), but it has 3 clocks compared to 6 clocks on
> the RZ/G3E SoC. The RZ/G3L has a single TCLK with internal dividers,
> whereas the RZ/G3E has explicit clocks for TCLK and its dividers.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  .../bindings/serial/renesas,rsci.yaml         | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

