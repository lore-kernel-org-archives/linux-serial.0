Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD2F40960F;
	Tue, 26 May 2026 15:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779807812; cv=none; b=sYlBPzdyEk/UZUqXtyXm/GWjwpwZjn9u1/Ynh8+bzs2PuutGDV1qpkeVHUYPrrkdbPUvYRp+JURdlMV64a454dJwevoiXsJrwbSM6CHUBB6dg3PxX6QXGntWgPE+sPAYJ55+l2rJ5v8K7aopM/2PNbkrPKWKXomI3UFxPvZYJlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779807812; c=relaxed/simple;
	bh=PvyImwAcRHQOtM9DCXU/8PoTzZUztsuF6L6/cltELu0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=JkKtUtXEmcgnUd0Ox1kRh8g7xwjH+g2t6XAmB7Q5SLp+0mU1iSo0tdPL6HDv417vtbkiDAD/mgIJK+nzydIwZDx+473hSsYrdfCHpM2CbcUhVflag+FCF41YXB2BhdxV/m58mvoFfA6dK3tzbqg5vHTWI83UfJy/m1YSn2H4qCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 1BC2592009D; Tue, 26 May 2026 17:03:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 16D1492009B;
	Tue, 26 May 2026 16:03:29 +0100 (BST)
Date: Tue, 26 May 2026 16:03:29 +0100 (BST)
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
In-Reply-To: <20260526102915.c0dc51579182c0aeb1390bc4@hugovil.com>
Message-ID: <alpine.DEB.2.21.2605261602100.1450@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2605242242330.1450@angie.orcam.me.uk> <20260526102915.c0dc51579182c0aeb1390bc4@hugovil.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 26 May 2026, Hugo Villeneuve wrote:

> Please rebase your patch on greg's tty-next branch, because there have
> been some changes by me lately [1] to uart_get_baud_rate() and your
> patch will not apply.

 Sure, if this does get beyond RFC.  Thanks for the heads-up!

  Maciej
