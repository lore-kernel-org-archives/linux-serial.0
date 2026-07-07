Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFE93FFAA1;
	Tue,  7 Jul 2026 12:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783427173; cv=none; b=tTRJYH5t/C5QgZ2LMx04kDPDtFoGPjh8mxCdiRa3CjRZyD+9ijc+DKV4x5QI/ArUysHTzN3/uqEBXJmuMUktw4HYj3hw2HaYXjbYWc3KElGjyY+yaXp+dLDrdvlkf/OAgVxl1Owb1/sClMizS95rydr580CNbvYDevlxF50WZnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783427173; c=relaxed/simple;
	bh=GJceRcDlPwTETTm767llqBBpwi0rAWg+eOyey4Otj2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XYyibB9/RXFSkpYPTr7HjLQvh5S64wJpwQQTst2IT6DrG3He6+QGhjCzouecvCIhdPc/NuEzuPIkTcfRjllcA6qWOaq/cswwFBINfTU98umXoaI1UwBrTaJexXRprK6ojr6DIUsTMf2t5EJ7jYJrAhANX/znqlqCk3+FGVfor80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k8umR9+4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k8umR9+4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 301371F00A3A;
	Tue,  7 Jul 2026 12:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783427171;
	bh=+Wj3Nw1VhJyMA9iPCMYht9Qn6LH4oN1iizYxbse9Mbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=k8umR9+4VQ3ROx910sUkR2G5/nP3v1hwj0/kVjO48ljTwIjts5Hsq2G8q5TghnPRf
	 3dqXArgnpW63GW8TOwwHBoRmQdjvE2RYLUyUHvpEhtYGM5pPInxyo+qBoydbWi2/YF
	 vSL5TeZGrlip27i5oNcGfH0gaCJciETpj2fnJvDs=
Date: Tue, 7 Jul 2026 14:26:09 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Kevin Cernekee <cernekee@gmail.com>, Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] tty: serial: rp2: Use named initializer for
 pci_device_id::driver_data
Message-ID: <2026070746-voltage-division-abd6@gregkh>
References: <20260524131905.871222-2-u.kleine-koenig@baylibre.com>
 <akzB9zul5o1OMnsm@monoceros>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <akzB9zul5o1OMnsm@monoceros>

On Tue, Jul 07, 2026 at 11:09:30AM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> Hello,
> 
> On Sun, May 24, 2026 at 03:19:05PM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> > The .driver_data member of the struct pci_device_id array were
> > initialized by list expressions relying on hidden assignment of .class
> > and .class_mask in PCI_VDEVICE().
> > 
> > Make the initialization more robust by using a named initializer. This
> > robustness is relevant for a planned change to struct pci_device_id that
> > replaces .driver_data by an anonymous union.
> > 
> > This change doesn't introduce changes to the compiled pci_device_id
> > array. Tested on x86 and arm64.
> > 
> > Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
> 
> This patch was sent before the merge window leading to v7.2-rc1 and got
> no feedback and isn't in next. So I wonder if it's still on someone's
> radar?!

It is, give me a chance to catch up, just made it through 300+
drivers/staging/ patches that had been sent recently....

thanks,

greg k-h
