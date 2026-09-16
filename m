Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC58446BF5;
	Wed, 16 Sep 2026 07:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789543305; cv=none; b=t8qjFyOA/cJO3wTWDOraGpiZx4kWt6FwN7qGTPDueNzKUcze62BEEb1KTZmVNoGPemFEb9TzM+YgBlsbB1cS5WGz7xERFzOEKaW/cPmUvcZ6m8XWTPnUL4JaJyLeBaqvxzU8P57Vy2k5i4VvODy7aZP58+JZN5kxmNjIndJr2nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789543305; c=relaxed/simple;
	bh=GzZj/+oH8IHT90WvIfWvTaXqoPfeM4j7vmP6q2d6akA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F1yhqomoDcqn+OL9qNccODXr07EiStqirlmuXPttZEzhV3V51ZT/UydrcCZOq1Rp1BTgwoAzsIu3zqwEbi7wLCROV4eHHAkDfoEknDqlXMGqNh2JZH0ozaOx4/Z93CKGsX631ugOFugk7nxb/nkhzd38kM4pBFkWjZ2pn8UzlGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pUSTFgQW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pUSTFgQW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE8D1F000FF;
	Wed, 16 Sep 2026 07:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789543277;
	bh=dno5QmvU349FdSNFql+uLmXSa9x4YqTAeiIABciESCw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=pUSTFgQWAlbtm7ykxOsXvHEuQAUnMJ7ldxMZw67Ei/+FblaA+vz6Pfc9uLYy1a1Tv
	 yTpateMUdsrnWo+dNOisiF9+LiLdXVtL0jvu5X6r8dGqSPjdoHJlFIPuwZaF1qlNN3
	 qV5/YRaFLn7JiR8704wGJXBSM/rd42cyX7gpKpXQ=
Date: Wed, 16 Sep 2026 09:19:23 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Martin Roukala =?iso-8859-1?Q?=28n=E9_Peres=29?= <martin.roukala@mupuf.org>,
	Lukas Wunner <lukas@wunner.de>,
	Magne Bruno <magne.bruno@addi-data.com>,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_pci: Catch up on new pci_device_id entry
 without named initializer
Message-ID: <2026091608-twistable-jaundice-6138@gregkh>
References: <20260814095931.1871387-2-u.kleine-koenig@baylibre.com>
 <aqovRVuGLvfSLLPr@monoceros>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aqovRVuGLvfSLLPr@monoceros>

On Wed, Sep 16, 2026 at 07:56:08AM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> Helo Greg,
> 
> On Fri, Aug 14, 2026 at 11:59:31AM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> > When the patch that became 0481a041e956 ("serial: 8250: split Moxa PCIe
> > serial board support out of 8250_pci") was created, commit 44e55f1f3088
> > ("serial: 8250_pci: Consistently define pci_device_ids using named
> > initializers") wasn't applied yet and thus added an assignment to
> > .driver_data without using a named initializer. Adapt the assignment to
> > make the array consistent again and re-prepare the driver for the planned
> > change to struct pci_device_id.
> > 
> > Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
> > ---
> > Hello,
> > 
> > if you prefer it, feel free to squash this change into 0481a041e956.
> > Otherwise I don't think this change justifies a Fixes: trailer, but
> > still it would be nice to get this in during the upcoming merge window.
> 
> Is this patch still on your radar?

Yes, along with a few thousand more, sorry, way behind in reviews...
