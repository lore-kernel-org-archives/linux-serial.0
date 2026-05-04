Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D803DEFFF;
	Mon,  4 May 2026 15:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777908017; cv=none; b=DoxjIqGkcIOrNgZbYYSC2owYudveGI6wMr1zM58H9pQmvKKSR7CGB0kLJx/UpJUBUGzb7mHNQ1afuQ2LWkS3RCDuiqIjemZBFWralwTTeaRbcKD67SimbgP/9V8cpfB4UoeDzsRTcfUrxxFRhttoPBg1C64H1et7rcpDB8loDWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777908017; c=relaxed/simple;
	bh=bqf3BKDNKyi6ALzn8Z/koxymBdn27aanOYFoKyfwgkc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=aogTqkli4ymMy+htr2CPac2jusoJ5bztH+zfXYYCoE/aTKDdoPIYeb1uEyyRuAeNW8l7RoHW99bSOaro08vNqwSgGJVsCyex1oRAAEslAGfMWqLJ1P0oPYCjkfj7AkKO028YyL94YwoF8DkvLbZzxUCYdhb11/UuvCnajKtdPb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id EFA0C92009C; Mon,  4 May 2026 17:20:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id E909592009B;
	Mon,  4 May 2026 16:20:13 +0100 (BST)
Date: Mon, 4 May 2026 16:20:13 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
cc: Hugo Villeneuve <hugo@hugovil.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, 
    =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
    Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH v2 02/15] serial: core: add uart_iotype_mmio/legacy_io
 helper functions
In-Reply-To: <afitf0I1izLup5TR@ashevche-desk.local>
Message-ID: <alpine.DEB.2.21.2605041617190.23161@angie.orcam.me.uk>
References: <20260428-tty-upio-v2-0-01c1857cf761@dimonoff.com> <20260428-tty-upio-v2-2-01c1857cf761@dimonoff.com> <afNwaUf8esqaqxUe@black.igk.intel.com> <alpine.DEB.2.21.2605030016120.23161@angie.orcam.me.uk> <afhdTI_jAQrIsPSZ@ashevche-desk.local>
 <alpine.DEB.2.21.2605041220540.23161@angie.orcam.me.uk> <afitf0I1izLup5TR@ashevche-desk.local>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 4 May 2026, Andy Shevchenko wrote:

> I see no value in this discussion. And I see no point to add a word where it's
> not needed at all.

 Agreed.  I just pointed out that the use of "legacy" in this context is 
not incorrect.  And "regular users" won't see any of this stuff anyway.

  Maciej
