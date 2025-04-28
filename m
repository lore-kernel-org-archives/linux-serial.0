Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9467A266EE8;
	Mon, 28 Apr 2025 17:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745860245; cv=none; b=TxjHB9yXKM2sSYqrLlA0tBF+6TQD9qdbGSyISD4zUk1ktlvMSkChXPpKZ7SAE6mTYTII1JpFXY7xFlZD1FWrv5H+6hX7s+VfjozUH4hwbSLRF6zaUERHOnKrhaUYLIVOwAYMPUUeopQvgZfctvl9Zk0B7gOaeqeYmVh+h/Oi40A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745860245; c=relaxed/simple;
	bh=5AgkR+22VDjIBm+J00qc5j3ln4mZEAFE46+wzRtBSgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lBw3cVXcBl9wVeIU68cY5W9E+gKJOd0ZZKFMr1RJrThLZjxfYLrWTIJBtrcYuJyP2JJTZm92rjzsNw4SJs8ErJ5G+73gC23Eo8WsIAX/ShBK7Stsz7gqUNl8ajYDs9IgfPI5mkqDRombvARVS1+/KQvuelYdX0ZtZ57+1itoL/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tY3G8aUU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tY3G8aUU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EF00C4CEE4;
	Mon, 28 Apr 2025 17:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745860245;
	bh=5AgkR+22VDjIBm+J00qc5j3ln4mZEAFE46+wzRtBSgA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tY3G8aUU7JZKmsYWpxRE1JAAsUEtYAgG3SSxEKSFzK4Q5ZNILSy/8AXziYAqsmV6T
	 CAWnasTLDNL5BDx37i72roQIJoULZbs27Kw1vmZXX1gAvGbsgIQN6bSmNM2/Q/bdQ3
	 OuwV2QlZ2uc01mW3mdUvK5A7+khDu+oI7lCc6zO8=
Date: Mon, 28 Apr 2025 19:10:42 +0200
From: 'Greg KH' <gregkh@linuxfoundation.org>
To: Faraz Ata <faraz.ata@samsung.com>
Cc: 'Krzysztof Kozlowski' <krzk@kernel.org>, alim.akhtar@samsung.com,
	jirislaby@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, dev.tailor@samsung.com,
	rosa.pila@samsung.com
Subject: Re: [PATCH v3] tty: serial: samsung_tty: support 18 uart ports
Message-ID: <2025042829-heroics-deskwork-e74d@gregkh>
References: <CGME20250417042427epcas5p2df3d35803adcb24da7d83e5df586380d@epcas5p2.samsung.com>
 <20250417043427.1205626-1-faraz.ata@samsung.com>
 <d350841c-3560-4511-a866-9490737e48f7@kernel.org>
 <06cb01dbaf5a$1ea1a8b0$5be4fa10$@samsung.com>
 <2025042508-statute-pleading-df6f@gregkh>
 <0ce801dbb837$19706530$4c512f90$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ce801dbb837$19706530$4c512f90$@samsung.com>

On Mon, Apr 28, 2025 at 05:44:21PM +0530, Faraz Ata wrote:
> HI Greg
> 
> > Subject: Re: [PATCH v3] tty: serial: samsung_tty: support 18 uart ports
> > 
> > On Thu, Apr 17, 2025 at 11:02:24AM +0530, Faraz Ata wrote:
> > > Hello Krzysztof
> > >
> > > > -----Original Message-----
> > > > From: Krzysztof Kozlowski <krzk@kernel.org>
> > > > Sent: Thursday, April 17, 2025 10:50 AM
> > > > To: Faraz Ata <faraz.ata@samsung.com>; alim.akhtar@samsung.com;
> > > > gregkh@linuxfoundation.org; jirislaby@kernel.org
> > > > Cc: linux-arm-kernel@lists.infradead.org; linux-samsung-
> > > > soc@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> > > > serial@vger.kernel.org; dev.tailor@samsung.com;
> > > > rosa.pila@samsung.com
> > > > Subject: Re: [PATCH v3] tty: serial: samsung_tty: support 18 uart
> > > > ports
> > > >
> > > > On 17/04/2025 06:34, Faraz Ata wrote:
> > > > > ExynosAutov920 SoC supports 18 UART ports, update the value of
> > > > UART_NR
> > > > > to accommodate the same.
> > > > >
> > > > > Signed-off-by: Faraz Ata <faraz.ata@samsung.com>
> > > > > ---
> > > > > Changes in v3:
> > > > > - Fixed review comments from Krzysztof
> > > >
> > > > Which ones? What changed?
> > > >
> > > While sending v2  change log was missed unintentionally.
> > > Added missed change log in v3.
> > 
> > Can you add this properly and send a v4?
> > 
> This was a clarification given to Krzysztof.
> The complete change-log was missed in v2, This was pointed out by Krzysztof.
> Added those missed changes in v3.
> Do you want me to add this clarification as well and send v4 ?

Yes please.
