Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8F51A238C;
	Fri,  7 Feb 2025 09:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738921107; cv=none; b=tXNC+LW0Xjmy83GtBv1vHX3BeWK/cCUhL0uRImM4To7xIQ135LJl5WsL5yTn7k4nWNdOoZIYW+a2krXNz59ONCuDv2R8DA/aIhrb7WKXqbLMhkYAENKASxjQ6l6caEoA2cmGavDIrEDE8Ffv2b/z4eIWOuS1GL2HO1abk3VJ2HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738921107; c=relaxed/simple;
	bh=6jVYmhAyOBjqF1aFaP4dvqisYm5HXGfQ90JyPpbYXww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mmoRuQ4Kjvep5+PdttK03uWAarr/7rc709gb48dnWyPwYKsstB2bioTFjeURDz82w1k9NcBF1ZB6CfkTKAjv6AastJFE8yoI1dWEx7Ly/rQaQPmEghCjbZiXDrZ2aincJHp6by5t2DrjBRe9YtaIFsWS1DvYsOYofLhD0HHLpMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QLsaIqnH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QLsaIqnH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29055C4CED1;
	Fri,  7 Feb 2025 09:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738921106;
	bh=6jVYmhAyOBjqF1aFaP4dvqisYm5HXGfQ90JyPpbYXww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QLsaIqnHDUaHBMyiWbM86mZcUZygIyMGauFG8+PPywd9V1QX/3D/UqN/QGcYPynkC
	 VKLe8J1Vvw0muoKP3ZUq+7hPfKnRiff/11tmY1Q55Xdg8laSYvYfe2MDTsc1JqlrCO
	 7V6kI9BqVKXtcxEXI0YmfZTxWgqGFrmhKx7IrNnw=
Date: Fri, 7 Feb 2025 10:38:23 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3][next] tty: tty_buffer: Avoid hundreds of
 -Wflex-array-member-not-at-end warnings
Message-ID: <2025020741-shame-landline-c597@gregkh>
References: <Z6QvAZxiQusdaDkH@kspp>
 <2025020633-irritate-boogieman-4c35@gregkh>
 <7c396d56-a2ea-4cb5-8a10-a2b78cebfaeb@embeddedor.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c396d56-a2ea-4cb5-8a10-a2b78cebfaeb@embeddedor.com>

On Fri, Feb 07, 2025 at 09:53:30AM +1030, Gustavo A. R. Silva wrote:
> 
> > >   	unsigned int used;
> > >   	unsigned int size;
> > >   	unsigned int commit;
> > > -	unsigned int lookahead;		/* Lazy update on recv, can become less than "read" */
> > > +	unsigned int lookahead; /* Lazy update on recv, can become less than "read" */
> > 
> > Coding style change?
> 
> (Whaa? for some reason your response didn't reach my inbox until today)

Sorry, my email was stuck on my system for a day, my fault.

> It seems I got a bit too proactive.
> 
> What do you think about the rest of the patch?

I agree with Jiri's comments, and overall I like it as a way forward.

thanks,

greg k-h
