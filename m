Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB77384CC4;
	Fri, 31 Jul 2026 08:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785485699; cv=none; b=BNd+46Fv4KtTUMtnOTSqoC69UyRz0LrDLaB1meWI923lAJq1nunsUeYyDhdyMYP5BFB2BZTOU0zl4PAJwum4w3ZZnWe28gq2QBU+fe63is1UYdQXfHgCbPsgQ0Q72Z73g1gInnxqgNBHKeQPSgJjSHYmFKqp/LWB1o43vr3NpoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785485699; c=relaxed/simple;
	bh=dYDlBtrojsxvLvjMm8g/AIeM0TT7VLNFGIhf2m3UKu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p2kmLXXH66GoLgYgr1N4ucOp7pAkjBDgpDhUubsobCAQaKyzh0IzDpRKbY/lS9EXCd6+essJFQy+SIaIso1RH2x+oNhw3yxtNzPcx3gXfmYVY62Mb2hRgH/qy073GXvqn9R66SS/0srjVYImIZQQKUsg1sdqQpZUro9o0RelzHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SfBurZxv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SfBurZxv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC1571F000E9;
	Fri, 31 Jul 2026 08:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785485697;
	bh=dYDlBtrojsxvLvjMm8g/AIeM0TT7VLNFGIhf2m3UKu4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SfBurZxvi4dEHoOrW5iah8461tnTE/Gxwyihl/CtFdRuzXkcU+/ZPFYCzRmC6j94W
	 5DE12nF3o7uRUC06yCUNoko6eTFuOILgCNFUnfqlJ0C/LrmjV2yrfq+7s11Sfv9V8K
	 5Pt2F9jYf9dQaGzOG3adItRz3Rx1/LM7HrfF4T1c=
Date: Fri, 31 Jul 2026 10:14:42 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Markus Probst <markus.probst@posteo.de>, linux-serial@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org, Joshua Rogers <linux@joshua.hu>,
	stable <stable@kernel.org>
Subject: Re: [PATCH 0/2] serdev: Some small serdev bugfixes found by code
 scans
Message-ID: <2026073133-eligibly-operation-dbd8@gregkh>
References: <20260731-aisle-tty-serdev-v1-0-2401a3189327@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731-aisle-tty-serdev-v1-0-2401a3189327@linuxfoundation.org>

On Fri, Jul 31, 2026 at 10:06:08AM +0200, Greg Kroah-Hartman wrote:
> Joshua at AISLE has been kind enough to run a bunch of scans on the
> tty/serial code and here are two minor fixes for the vt code that the

s/vt/serdev/

{sigh}
