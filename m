Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E94623F374;
	Fri, 28 Feb 2025 20:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740773878; cv=none; b=ON+5WHBaMiEY3pHwT3nK5H8uiVblwcnUe4TDpjAk5fXicO6jfiMPnXwKtMJXfi4OPp4IlINiigz0VMCAEiENgJAt8KPlyyH4iju0oDsAkfjL96DRi9iPhtZsDU4y1mtVJNMJ0sX/FlPF5vDbsKs2GUm+knh1LeBBkrk0h0pA9f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740773878; c=relaxed/simple;
	bh=gAs0/3F2geXV4YNTqhdtOdKytR/TAZyfSsX8wnGYoSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m5ZGaBT1v1hs0CfqXFvmy6prN0QM8y1Bj8k8csi/7eSvysuQNVEuPSG5Oes5Fx1oGNUKGTt/yh81ghSR85ezUn3Nvpra+j+Yw2cXrST8oYf1yr65kR504dDyTQFmMCoDAgr8SGHwv7sXGcmfUNYgiRefQgoqDvQh2CoXkYhE1ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YbN7TGkO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YbN7TGkO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70BB6C4CED6;
	Fri, 28 Feb 2025 20:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740773877;
	bh=gAs0/3F2geXV4YNTqhdtOdKytR/TAZyfSsX8wnGYoSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YbN7TGkOGRl6dt6bcyOVqjt/hdC+EO3hzNKaj9yB06GRKqtAo0lwhxxDC4U65SATz
	 Dk1sBmojt5+Wjmh82NE4rf6wQABwwqYDZXcp8kbBVXzZlreRDWWXnXakEcL7cDjBAA
	 EoU2eKiGkyai+l6RQScwyCjRxSJudBsCptCZ04vE3/7hU/nG4w2eFHCaj9j99vIhLJ
	 FRsiRQ1RLJE1OF7dB3OW/kfMA94l0MdxstVMiCFvYCV7NkxPBrIy74Dl9vluHLv+0g
	 pv5UMqbSticRLuVyXroK824tKnjcX3na3XSRjOM1CobP+l5iwwhuGsV0FdYqMlauXs
	 4DszI7cHkJl+w==
Date: Fri, 28 Feb 2025 14:17:55 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: linux-serial@vger.kernel.org, heiko@sntech.de,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-rockchip@lists.infradead.org,
	Jiri Slaby <jirislaby@kernel.org>, devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v3 08/15] dt-bindings: serial: snps-dw-apb-uart: Add
 support for rk3562
Message-ID: <174077386802.3599396.5797329350683510790.robh@kernel.org>
References: <20250227111913.2344207-1-kever.yang@rock-chips.com>
 <20250227111913.2344207-9-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227111913.2344207-9-kever.yang@rock-chips.com>


On Thu, 27 Feb 2025 19:19:06 +0800, Kever Yang wrote:
> The UART core on Rockchip's RK3562 is the same as the one already
> included in generic dw-apb-uart. Extend the binding accordingly to allow
> 
> 	compatible = "rockchip,rk3562-uart", "snps,dw-apb-uart";
> 
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> ---
> 
> Changes in v3:
> - Update the commit message
> 
> Changes in v2: None
> 
>  Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

