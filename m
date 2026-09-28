Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112A53955CB;
	Mon, 28 Sep 2026 06:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790577069; cv=none; b=DxYIqyt0d8xfJPQAkjHG0vxNhX/qAzzbSq/umeNi9jCMlprFsTinVB14MbgDZ0TGrsKlJDhWP/fJCxhp1N+dJ4Cyb2cg3Jn1tQUckE18eKNfzU8x7HG9L3fEOU9xbZmrJTOfPT7I9Yjncfyl7TYEKJliiuq0TqR49lRUhqa6UBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790577069; c=relaxed/simple;
	bh=AijAebPUqGTDc/nsF9I/dNDY/1gMf9hw9fNAUOxlI1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZDfSotBeadn/T4O2iFvib5lbzf7X1zq2pHnfRelvY38/kOLdRI5GtI8sz6Q6hYk39UOt8KnzX4+eMorgys4aHgJ+HRr+6xzRVR8Q6OyT2zzVrZU1EljB1DH+1obCKtU4Ep3zXxX2y78gH845++KHjNR2/udhqN+O61C6ZkfSbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DbAFnN00; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DbAFnN00"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDE111F000FF;
	Mon, 28 Sep 2026 06:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790577067;
	bh=vXn0ZnrKN3/lM1uocAL33Pk1LeiRIvLjENWtzWxECIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DbAFnN00m/j/d1EhTq6rnjfFhb5F9Y3juy4A5W8wa1aiQ38FmLmkZv6qh2i1uenpE
	 1M4watCNPxqzS09046Qy8/hpyzKmA+Q/S6dOXuWjDufsXxaEm0+xQFjQGo5Fxu8Dnj
	 5ieC84Z0tsn2R/1ssdUPUQPKZ2RJtw9qZMMLIsgl0fwx7Kfcq6Lnwfc0Gp8Tttxc9Q
	 WGi3fat/VWC8ZSCTjumKGI9MebOtLCnGXqA/BO5kjcbHXdYpmtf043c7E+/g32tXoc
	 DKyfLDS3pSTuLgZME3aZc/4rjP+RfvuPt7cuDZcLog+FH3YA3bTyBT0TSQnPydEXpD
	 7JBzKIYopd7uQ==
Date: Mon, 28 Sep 2026 08:31:03 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: serial: renesas,hscif: Increase number
 of DMA channels to 6
Message-ID: <20260928-industrious-gorilla-of-democracy-2eefa8@quoll>
References: <0fac2fa211f591d91c6e59fa16bc98791afc6559.1790071098.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0fac2fa211f591d91c6e59fa16bc98791afc6559.1790071098.git.geert+renesas@glider.be>

On Tue, Sep 22, 2026 at 11:59:42AM +0200, Geert Uytterhoeven wrote:
> On R-Car X5H, HSCIF serial interfaces are wired to three DMACs, hence
> referring to up to six DMA channels.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> v2:
>   - Correct authorship,
>   - Add Reviewed-by.
> ---
>  Documentation/devicetree/bindings/serial/renesas,hscif.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

