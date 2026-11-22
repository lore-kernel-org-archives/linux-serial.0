Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795361688;
	b=tSlGPI7ca3q84AD1HschN73qon2j8e17ULj0A6Pw/9ItBRAgJ3kuaMSydyinxCLkDcq4
	 vLJatuxQesI1I5AuDlstPBISljiha4Poh8lP+zt2tq5dL3y3RjUncnN/nFS7aefqo9bvK
	 nb7MjkRrteYN6qJ10NnzVYI/iix2v78wb3eAKeK0uErmA+Nrvz57+TYgWZ+l641Dyh06S
	 R9EVj7YHOTrpwk8I/IC0JIf3mctlZhtmy3G7Ti10tnut4ku5zLA8ZcudgsLG1R08ksSVl
	 YD4jEOTFidf4PO0G5kr7/yntLtWPnynfy/hF8izkUJspao1JwDNOkhf9VE2B6xRHq1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795361688;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=L43f1kBqOYb+3obxiloeu9TGeNNR8aeSo1E51+NquNQ=;
	b=SvVGzRQyQAWJ1e4Lgt0fuwOmpSLqBHYgP42pugbebCSS/l0yJEaVkqDdF1rXjCpSOwvO
	 SaGJeaJVQjjSsVrRRpe++lkBnS5kHJ/d9KqWTx0AUU4qPxTwLXyPrb/jHjyCzBfzlTfCl
	 m+UB6X5Y+IhQAibiBxSq28qPM9txnde7mu0uHF6wKGrbHJ3VvN0gZjdwSqKVFgLdh4BQ/
	 Lr0lq70Ha14l9GT66cc08L/SdtwZLPsDLYMZU93XxNYvP+cDEwClCWBJETNMV5A0bvXp5
	 l43DXLWVGjNmTj0xJMeLU/nNFRgievYwwjqPQ1EE1djE48G5PLopp7FqZDCweld9EkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=hQ2bx52H;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F62606A32A;
	Sun, 22 Nov 2026 15:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=hQ2bx52H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F6A81F000D1;
	Sun, 22 Nov 2026 15:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795361687;
	bh=L43f1kBqOYb+3obxiloeu9TGeNNR8aeSo1E51+NquNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hQ2bx52HR2OhOL0XHQLuCkn1fsTOISQ1wU5RgGZprSRVAL59Y7e/mvD0Fc4+o6nzH
	 vLIHtFoGUadgT8gFeHnpsELbqx2h9FKUK+9J1BpcJizhDyYOfFnJPuigVmbiCfcyfT
	 O8MPJ3SWx7B03hopO0qr9ewbRJarJKzdAaekmWoY=
Date: Sun, 22 Nov 2026 16:34:43 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: EMCP333 <emcp@enser.io>
Cc: Laxman Dewangan <ldewangan@nvidia.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Krishna Yarlagadda <kyarlagadda@nvidia.com>,
	linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: tegra: do the baud tolerance math in 64 bits
Message-ID: <2026112258-hesitancy-passable-902c@gregkh>
References: <20261122-b4-serial-tegra-baud-tolerance-v1-1-39907382281f@enser.io>
 <2026112253-salute-epilogue-67b4@gregkh>
 <CAOY-3nCEb=fMMwHyecpvs5jVTod90tG7L8HvbDWZ+OgBfSJY0A@mail.gmail.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOY-3nCEb=fMMwHyecpvs5jVTod90tG7L8HvbDWZ+OgBfSJY0A@mail.gmail.com>


A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Sun, Nov 22, 2026 at 07:07:00AM -0800, EMCP333 wrote:
> Hi Greg
> 
> It's Erik Peterson
> 
> Been my first attempt to work on the kernel with NURA (formerly
> postmarketOS, which doesn't take AI submissions directly) and I think it
> clearly stated when to indicate AI use which I believe I did.

The issue is you need to sign off and put From: using your real name,
there was not any issue with using a LLM here at all.

Please fix up and resend.

thanks,

greg k-h
