Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F071E58122;
	Tue, 13 Feb 2024 19:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.228.1.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707853373; cv=none; b=Lq1vwSrfXcoq4EGznIKnfTvSUIz2xSQ+WRf31C0mctCny3/y4v867V5Uc9v7sfH5+gQuRQdZr+TWsSO6R82Y5UnvvDvIpQHuSPVqwpiuD842opbD4PoHoMh8NfFrQTgCLu2/ZPHDicKCnxCKkFuJBIQB74cMSD32GXsgygXOhRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707853373; c=relaxed/simple;
	bh=mvl3b+U7XdsMslEuAEGtOkRcbNX+zT482nAV1C+9Aho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bxYeDcZ5MaMyxUFucVf6p/zTW4vlbTmjc1qzpCfunt1hkfgQhdrOFdYXnJXjbW7UwkOGOZebQseTQmnwIAQ2UDl+SVP0PzsKS+feeOEAmm7ePhGIj/FvD4nLh3BIkLcGJLmxsmNeZ1aeCxaZmlMfZt7NE1nUrU6OwG+TSKmFORk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass smtp.mailfrom=kernel.crashing.org; arc=none smtp.client-ip=63.228.1.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.crashing.org
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 41DJCu2k018865;
	Tue, 13 Feb 2024 13:12:56 -0600
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 41DJCtmj018864;
	Tue, 13 Feb 2024 13:12:55 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Tue, 13 Feb 2024 13:12:54 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        llvm@lists.linux.dev, Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Bill Wendling <morbo@google.com>, linux-serial@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] tty: hvc-iucv: fix function pointer casts
Message-ID: <20240213191254.GA19790@gate.crashing.org>
References: <20240213101756.461701-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213101756.461701-1-arnd@kernel.org>
User-Agent: Mutt/1.4.2.3i

On Tue, Feb 13, 2024 at 11:17:49AM +0100, Arnd Bergmann wrote:
> clang warns about explicitly casting between incompatible function
> pointers:
> 
> drivers/tty/hvc/hvc_iucv.c:1100:23: error: cast from 'void (*)(const void *)' to 'void (*)(struct device *)' converts to incompatible function type [-Werror,-Wcast-function-type-strict]
>  1100 |         priv->dev->release = (void (*)(struct device *)) kfree;
>       |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Such a cast of course is explicitly allowed by 6.3.2.3/8, only calling a
function using a non-compatible type is UB.  This warning message is
quite misleading.  Doubly so because of the -Werror, as always.

Your proposed new code of course is nice and simple (albeit a bit bigger
than it was before, both source and binary).  Such is life ;-)


Segher
