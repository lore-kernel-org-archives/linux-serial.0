Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9C313A258;
	Mon, 12 Oct 2026 01:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791769820; cv=none; b=DbaC5+KfE/m4mxtmdV4Zy2vml6Yy+TCXybFF3OE2hGUKFSAodRAh7KvKRXcACjLMyx6YiiXHGs/w/WabGOGJK4G7UItkhNvRl8KNCxEIfodTB28sj1kVHLnLro2M6impOoFA3yErKoAM9VHbQdTmLpzZqByJrvUvQAQdx2dGt9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791769820; c=relaxed/simple;
	bh=xSCbNFGAOGDMkbkNOkN74Oi39vk04K574tmwsN9O2eo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fxIJHDjUgPoDo+a9QyIDa3CQfTqF4qCn6BcVz6UoFl/orLS5te0pmetZj8WLSxms2gvmQTn8Oh4DKPxaEXW82VrD5/SQHQI8T99cS0T6k3szeHznihQTJ5eMlGjYY4gkwvVVZYGkbeEfmYcAsEVzDqcvRAXeLUVuh5L/U+guTjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 0246A9200B3; Mon, 12 Oct 2026 03:50:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id EFA6A92009E;
	Mon, 12 Oct 2026 02:50:14 +0100 (BST)
Date: Mon, 12 Oct 2026 02:50:14 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Hugo Villeneuve <hugo@hugovil.com>
cc: Theodore Tso <tytso@mit.edu>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
    "Dr. David Alan Gilbert" <linux@treblig.org>, 
    Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
    Gerhard Engleder <eg@keba.com>, Jiayuan Chen <jiayuan.chen@shopee.com>, 
    Joseph Tilahun <jtilahun@astranis.com>, linux-serial@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] serial: core: Don't clobber the baud rate on hangup
 via B0
In-Reply-To: <alpine.DEB.2.21.2605261602100.1450@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2608051937450.55540@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2605242242330.1450@angie.orcam.me.uk> <20260526102915.c0dc51579182c0aeb1390bc4@hugovil.com> <alpine.DEB.2.21.2605261602100.1450@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 26 May 2026, Maciej W. Rozycki wrote:

> > Please rebase your patch on greg's tty-next branch, because there have
> > been some changes by me lately [1] to uart_get_baud_rate() and your
> > patch will not apply.
> 
>  Sure, if this does get beyond RFC.  Thanks for the heads-up!

 Now posted as v2 non-RFC at 
<https://lore.kernel.org/r/alpine.DEB.2.21.2610120150230.55767@angie.orcam.me.uk/>.

  Maciej
