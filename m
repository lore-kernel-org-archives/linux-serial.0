Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=78.133.224.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792555643;
	b=UR2gBEQ0GtVZfMrYCp2WvLr1QB1XTQfI8ooK+F09zlLFw+krH4OrKsTsoECyBUe6N4xD
	 YaTugYMjvtdwTQ4mPIZLm3ZPYUbifVGW0qd1aX+n2/TQZ3+3lGShJr0gNAXeV9WRcMQam
	 j0aVSxdRtl/g8eFhnclBWV5U1rcP25e0xj+MVQPXsE6JxsWvE5o3vDmf+5F18YP66MPsR
	 c37mwMS4LSiERzPF+/nHRl/LveI4ZkM+9YbFq6ZKde2+grkIdKhFCCBZ5ClxUgCzCDjTt
	 CJ7rhHRmhRiQH4q4BkKKfz53f0IhKAyEP8w9ez0wcWepcQSbJ15vs7+hVJK6sS094Rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792555643;
	h=DMARC-Filter:Received:Received:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:User-Agent:MIME-Version:Content-Type;
	bh=zN73Itk1RMYrZjWk9siKnqLvoJw7bOpqdfeyu86euME=;
	b=LXKGfq+1MGuQnhNK/R7wJzeWna9X6bjbi/IiRC2VRoK7GwtVupi93VXg0B8qI31AgoYn
	 O0hFhVbuBzVxgo3sou6MbkP3kBinP//vFDVaE8VBGyPAIttVdPlfvEEFnYrSzoicR6px2
	 yc4nS9/+aU1pBFoNE6ohoix7DsLCjq4dwjos5YNQTdQvR9bJDJLfy3hHbaFym6qWrwOxO
	 WRfMVyI+KP0Ya2OSUlye18BYZUbkVNVHzZTkkJrVO18yMwOB5ejsiFddiT6RlJGpmwZZB
	 o60pvtreXDmX80xIJX3ccovQCC5usBmxH/k86a8VNOSgIswvCGHvirIZ5DLJp8RJdPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=orcam.me.uk;
	spf=none smtp.mailfrom=orcam.me.uk;
	arc=none smtp.remote-ip=78.133.224.34
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E679606A319;
	Wed, 21 Oct 2026 04:07:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E679606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id BCA0292009C; Wed, 21 Oct 2026 06:07:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id B76B892009B;
	Wed, 21 Oct 2026 05:07:20 +0100 (BST)
Date: Wed, 21 Oct 2026 05:07:20 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Arnd Bergmann <arnd@kernel.org>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
    =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>, 
    linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] [v3] serial: 8250: remove obsolete and broken PORT_RSA
 support
In-Reply-To: <alpine.DEB.2.21.2610210422160.22065@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2610210500560.22065@angie.orcam.me.uk>
References: <20261019090017.430425-1-arnd@kernel.org> <alpine.DEB.2.21.2610210422160.22065@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 21 Oct 2026, Maciej W. Rozycki wrote:

> so the only peculiarity is that the 8-byte region requested is actually 
> below `port->iobase', presumably relative to standard ISA serial port port 
> I/O locations of 0x3f8, 0x2f8, 0x3e8, 0x2e8, possibly not to clash with 
> conventional ISA serial port devices where also present in a system (for 

 Or, to self-correct after a few more mind cycles spent on this piece, the 
region below `port->iobase' is an expansion of one above, where standard 
8250 registers of the onboard serial port reside.  Which makes even more 
sense, to me anyway.

  Maciej
