Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A303C3C06;
	Mon, 28 Sep 2026 06:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790576950; cv=none; b=ADro0itDqoUOlMYw9zHcIys5sXqqqcF/HQT9rwzJTDzX3r88FPfM6EMNKxj/a7CTbIf3c+9rV2A/4CvVegY9YuZA6t/TnmYcUvso4mwSceBoBVZ3ZtSJFH4aEPsDYoxUx8JAjW+adKKjsjUav/+3a3qBRmFcEIj5+Dms/bCG0mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790576950; c=relaxed/simple;
	bh=8+Izj7SCAiTrUYHonaYEAye3RQB0rg94ttxPossaDZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNTN/2mIzTH11EkhOMmmJzT16wg6nclWOYmrb5GSNdKvCxJHnUKEHaCP875L2ecWKWB1jpzQg5H8UqaKO6zlr5ghHdqarq7PdmkMV50tHcchB1/afntjAadyFyFvkOIrxJW9khWeoP6ZnZqWjnLwcGkHAYcSZL6CTXagrqsZEEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQthiFRq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQthiFRq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C03D71F000FF;
	Mon, 28 Sep 2026 06:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790576949;
	bh=yJuoliaxrCNnxQ6V+mMsGpPl4ZvLX4CSlPOKz5BS1h0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WQthiFRq/3fWvwfkB0/DL+PQYCtSS6h9cm4mqToqMwQHsgCf5C2jb0Z7gw+t74jGq
	 urZRxuvavFMQhNFTB3b8DzHjr/jEZxdQaRiOYENRp7NuQLiQfrIVxwRxQEF8iXHsYH
	 9DnXWln15PQeOqfjHcJZqfPm5wJochcnjUpDfYagRSPJCYUsNJ4mayK7/r/3BiBEmj
	 /MVc/8JoYjv7A3KGR3H6/PKGfNLP+AcAYggtOT+nJlX/QN5GwibkHv1qdFGoNMVfTd
	 BUrF/oDfSwaLUoXMQN8LCPIe5kYH+iuZ6fRtBugzx3L314CY1sT23BbBU7w+PpLNUf
	 YPwtqFfeoQMBg==
Date: Mon, 28 Sep 2026 08:29:06 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: serial: renesas,scif: Increase number of
 DMA channels to 6
Message-ID: <20260928-audacious-aromatic-dragon-de55ea@quoll>
References: <4dc02f4ff8a63c2bd41b15359828ce9befd2da2f.1790071199.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4dc02f4ff8a63c2bd41b15359828ce9befd2da2f.1790071199.git.geert+renesas@glider.be>

On Tue, Sep 22, 2026 at 12:00:09PM +0200, Geert Uytterhoeven wrote:
> On R-Car X5H, SCIF serial interfaces are wired to three DMACs, hence
> referring to up to six DMA channels.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

