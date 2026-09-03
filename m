Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841B84EBACA;
	Thu,  3 Sep 2026 17:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788455355; cv=none; b=r92emsKYIF6nWGj327fgGUYcMA5Y8YGmXDeSk7CspSpZxqMEbr5puvB6syoXGOqgmrCaZdh3WTJnAQ9PI0sDogkGBiVq2sOPfAWTLtIq9GYB9Bs4z9lsMY47dsFIroVYaYV5MpLB5DgIHI68zvkaoyGzQSyji9IJfUC/7D8Che4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788455355; c=relaxed/simple;
	bh=ONK4t6yEqD6YGL3MIWA8d6Cvws/k5qZpxMMASC7aHF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XUdvyLNip2P0G+sDRMWJZ6oFSci8ojVfLchdLsurwxWTKNn4JCiej7V3P7SWiWuEtXhCAY6qR/yKrjoWzLwLe5FKk8s2UyTWguy5f2WDQAh/aKURKmrOIdOH/KS4UaSble8grAOSsCN9u0RjjLiyN7E8Rt6jurIHv8+iO2wtJ4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fEpcpdJU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fEpcpdJU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A9971F000E9;
	Thu,  3 Sep 2026 17:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788455354;
	bh=ONK4t6yEqD6YGL3MIWA8d6Cvws/k5qZpxMMASC7aHF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fEpcpdJU97wZt1/bsOlBtnJA6eSQ0U9cjlVT14LAyV4K0AAUaFd8NGPZIvCUNN52r
	 9ERQH+ZXdDgsffghaih2z/gCiWKy9lCOorYNXOk1Jed1XLOgDVaBkIPy6AGBy4wX0C
	 mg+o93vGAlhbw5dlFC6jM02U5fjJ5tZ4lcdFLQiyKbCQYDlB4dFuMjt5aFvOlNExz+
	 Xy0tbD4pcYu2SOaDTnVDsMLbaPgMQQyGj9QTYSOdlVdhwpq6kJKoAiqbAPmmNRMVs6
	 yRhrOupO3uYEsPyrUZth3tnsZciJ/mZQZfECtHUQ4rUXY7LlF/TbWqwRLoMoYAnvSg
	 9lCaluFx3lU5Q==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1x2Aw3-00000006Ihm-3cQW;
	Thu, 03 Sep 2026 19:09:11 +0200
Date: Thu, 3 Sep 2026 19:09:11 +0200
From: Johan Hovold <johan@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-serial@vger.kernel.org
Subject: Re: [PATCH] tty: abort break signalling on hangup
Message-ID: <apmptysTEcbOEJLA@hovoldconsulting.com>
References: <20260903163736.1499280-1-johan@kernel.org>
 <20260903165004.B89561F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903165004.B89561F000E9@smtp.kernel.org>

On Thu, Sep 03, 2026 at 04:50:04PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Missing hangup check before initiating the break state leaves
> the tty in a permanent break state if the port is already hung up.

As the commit message explains, drivers should already be clearing any
break state on shutdown (cf. closing a port after enabling break).

Johan
