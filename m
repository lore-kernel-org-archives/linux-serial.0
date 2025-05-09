Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8205622A1C5;
	Fri,  9 May 2025 15:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746804732; cv=none; b=ZvZQhSg4EytP7VI7Aib8DaismJIFsBgafgoSuP9cCzJw9E+qmKoPbAWNLxE8cO/nkFrBN2vB0blRZMjD1qwu+pHRfUFK8I+8fnwgq3016IabD2nW2e02p+HdHDQ1A1YgaKqWQP6kbu8WhV2anylPU0Zbct6YIbDZZ37oe9GwTAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746804732; c=relaxed/simple;
	bh=qcrU3PLuyJ39f7Grm0C17ELUE5ZOgr1KxGpTaj1TKpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XybCuxPdJgkljzkia72ko6aKXh7PkcHniRC5SxzpeOHkK25SgN4CozUbHXE6FxO4G0mdAa0Frg7jKcKwbwTv4XsnGf2kLEC/XqIiPLuPf++222glVRlpRsQBGVg0f6m9YlOZlGmRWcKWnVtdhrh5E9Wl90f92GOTter1GW0gzsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ISAhfEKp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ISAhfEKp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD6FC4CEE4;
	Fri,  9 May 2025 15:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746804729;
	bh=qcrU3PLuyJ39f7Grm0C17ELUE5ZOgr1KxGpTaj1TKpE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ISAhfEKpgjA+Gl/PiXUPhkGgj8Oxjru+p7WwtbAHP5Xrd/7kGAl4Ai7/Ri3hbvTCK
	 evaainhsJHxSGH8KRrUcHMowIQRZZASKx19Nv3RZ49rf8GY+OaARY83wJ+4KUndiRC
	 1iIIBBm83Nn3EeLGG8CBImaZ/A9orzgOJjebgPLo=
Date: Fri, 9 May 2025 17:30:24 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rob Herring <robh@kernel.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Taichi Sugaya <sugaya.taichi@socionext.com>,
	Takao Orito <orito.takao@socionext.com>,
	Thierry Reding <treding@nvidia.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] dt-bindings: serial: Convert
 socionext,milbeaut-usio-uart to DT schema
Message-ID: <2025050912-snide-spoiling-0f7c@gregkh>
References: <20250507154924.1602842-1-robh@kernel.org>
 <2025050935-suffocate-snazzy-c5f3@gregkh>
 <CAL_JsqKjssqGOO6H9RCneo86fKop4bQtiKNcCq_95fOk2CP+eA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqKjssqGOO6H9RCneo86fKop4bQtiKNcCq_95fOk2CP+eA@mail.gmail.com>

On Fri, May 09, 2025 at 10:29:07AM -0500, Rob Herring wrote:
> On Fri, May 9, 2025 at 9:51 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, May 07, 2025 at 10:49:22AM -0500, Rob Herring (Arm) wrote:
> > > Convert the Socionext Milbeaut UART binding to DT schema. It is a
> > > straight-forward conversion.
> > >
> > > Reviewed-by: Thierry Reding <treding@nvidia.com>
> > > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > > ---
> > > v2:
> > >  - Fix $id path
> > > ---
> > >  .../bindings/serial/milbeaut-uart.txt         | 21 -------
> > >  .../serial/socionext,milbeaut-usio-uart.yaml  | 56 +++++++++++++++++++
> > >  2 files changed, 56 insertions(+), 21 deletions(-)
> > >  delete mode 100644 Documentation/devicetree/bindings/serial/milbeaut-uart.txt
> > >  create mode 100644 Documentation/devicetree/bindings/serial/socionext,milbeaut-usio-uart.yaml
> >
> > Are you wanting all of these serial "convert to dt schema" patches to go
> > through the tty/serial tree, or will you be taking them?  Either is fine
> > with me, your choice.
> 
> You can take them. With all of them, we're done converting serial drivers!

Ok, I'll queue them up in a day or so, thanks!

greg k-h
