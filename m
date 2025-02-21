Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8B1209F2E;
	Fri, 21 Feb 2025 12:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740140745; cv=none; b=IWfA3ZsML7GBmhLYVN2VSBpytax36dNNGBG55mhUWBggfKMsNb7IuGNyNiEd6MsCZk/EqoU1C+JU11M6l1KeydJVKzQRqqw9u8ifL9L1Ic3vvZ+V8P3NGP3hfaU7Vx/tAq5mSrrtF11vudlPBthImc4RqM5C/JzmIg5776A8YRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740140745; c=relaxed/simple;
	bh=OFSEtxcK3zYlx7wBQWYTU3fDwOhj2h7jl/iYHctMRmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Noav7MZLWWf5HD6TULEVYxxg08n3D1+yInj7qk/dety7wi0AVbfYr9aHp1w1FxxzJAeeBERPhUxY5cSn4AtMEx20QtQa6Mn6CiXf4xeohNiRYwnWUulaOZiZX+Mb6tT0kjhZaxS+ve7p09tFIGtE4ZfnKCMgWjwem0keFXPwx/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ke4222DD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ke4222DD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC81C4CEE7;
	Fri, 21 Feb 2025 12:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740140744;
	bh=OFSEtxcK3zYlx7wBQWYTU3fDwOhj2h7jl/iYHctMRmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ke4222DDHXnV0BAbawEdjTedKJ53iUBQi58weupuZmzWnCssmhDzQgg9Q0enJakXY
	 HgD4I+pW236g5wFFCtm1hSAHBp9jRkAsbJxATshxB47DfW+nr3lkX2vP6oJ9ROT3yh
	 +1YsaS7vHjHwvlGdqbzJ2nRWHTM7nm8rL9mqK2ZwZOwG3vQuAqVWCTlnuTRPEF9ZPi
	 Db7/ybs1r4+JQZxQ22oYXEnkrTcJeIqo9EE6M7bCqFMqxMjgzQRXXZSoiWX/Qr/0KS
	 9B11aksKwgNWpyz72jowA9XhJIgeGpUkghRHoQtfszbG8NfLynGOwPsjqgSVvBEl0K
	 8faQp5KXhN0xQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tlS6M-000000007ms-3Dz0;
	Fri, 21 Feb 2025 13:25:55 +0100
Date: Fri, 21 Feb 2025 13:25:54 +0100
From: Johan Hovold <johan@kernel.org>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Lin <dtwlin@gmail.com>,
	Alex Elder <elder@kernel.org>, greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH 21/29] tty: staging/greybus: pass tty_driver flags to
 tty_alloc_driver()
Message-ID: <Z7hw0lO1bGEesy_d@hovoldconsulting.com>
References: <20250220111606.138045-1-jirislaby@kernel.org>
 <20250220111606.138045-22-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220111606.138045-22-jirislaby@kernel.org>

On Thu, Feb 20, 2025 at 12:15:58PM +0100, Jiri Slaby wrote:
> tty_alloc_driver() is supposed to receive tty driver flags.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>

Acked-by: Johan Hovold <johan@kernel.org>
