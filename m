Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E6617BA5;
	Mon, 10 Mar 2025 06:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741589909; cv=none; b=O0WceYUF9T741NJEE11inGD5r3UP/4J92XFWf4NKu7Zn9K2ZmdgdyX2nwU5jNQFsv1cfmZs8mHaXl2MWT8zx0HiPj8WxeBHgssGAfhb87K8aUEdtuX8mZOs5m9x3AN7j8DC7po+sgyxfofk09shZErf+STmBadiJXSGci4K5Xqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741589909; c=relaxed/simple;
	bh=MI/HwqEL2OPCjvc2aGnpiGs/AcvZ6r10iVYJLYV/Og8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKxCmMGK7x+yddsX6FyEANc6CPRkMmV5TIiZ2vv0j/oMHrBTNs6MLHJQ6gU50XRYPJTEYVMFaBEx95D1IUaI7i8Dg0vrEPGlHqUK3VPkpPTR1AtmRRW7ArdYkH6J9QDsakC9ybsVrFXXDzfcmiRAuBNromClPw1S38FxIv7znHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xUiS5MiU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xUiS5MiU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A406C4CEE5;
	Mon, 10 Mar 2025 06:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741589908;
	bh=MI/HwqEL2OPCjvc2aGnpiGs/AcvZ6r10iVYJLYV/Og8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xUiS5MiUa+D6x0z1UldzohtW1PhLDWG5az/jPLAl7x2xx5HSB4EcvDBqX4oMteBrU
	 mOSpieFnabDRFCtj5T5ZnYlZzjbfAW4kKQxF/oRUIcX7CTg6xvfa4UmylL7jSKBoPP
	 y1hJsiP7To4HTVLo2yf51biuTeO/GAIYrO+GTBMs=
Date: Mon, 10 Mar 2025 07:58:25 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Toshiyuki Sato (Fujitsu)" <fj6611ie@fujitsu.com>
Cc: Russell King <linux@armlinux.org.uk>, Jiri Slaby <jirislaby@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3] serial: amba-pl011: Implement nbcon console
Message-ID: <2025031001-outwit-outsider-b34e@gregkh>
References: <20250204044428.2191983-1-fj6611ie@aa.jp.fujitsu.com>
 <TY4PR01MB13777DB55F2231F7399E42609D7D62@TY4PR01MB13777.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY4PR01MB13777DB55F2231F7399E42609D7D62@TY4PR01MB13777.jpnprd01.prod.outlook.com>

On Mon, Mar 10, 2025 at 02:23:35AM +0000, Toshiyuki Sato (Fujitsu) wrote:
> Dear Reviewers,
> 
> It has been about a month since this patch was merged into tty-next -> linux-next.
> I would appreciate any comments or feedback on this patch.

What needs to be commented on?  It is accepted and will be merged in the
next -rc merge cycle.

confused,

greg k-h
