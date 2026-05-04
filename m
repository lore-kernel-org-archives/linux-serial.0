Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71E11D63F3;
	Mon,  4 May 2026 07:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777880045; cv=none; b=eNo2XUTPZndS6FHAIsUruOPQd4I9WW4h/vb5yfDzTTb80sDsgJwLO8lk2jjkrMA3ES5jk8h2rJNgSTRFgIMqtURVULNdFNjM1jKkqK8oiLTuvgu9bep/3VqZjYusIzuCFUs07tDFxUgWKVKordUn68wLrkX1WN2rIPMqCk02clI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777880045; c=relaxed/simple;
	bh=scmgntQCYHa6EVIjS+lp7kYdyYV2XIhqqHIU12zjkF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3wDs1nsBsuWfh06gU9EpO+Q7vsAqEo+skz0TwkR54YrDEbJhv8LdRlMGU4+8YKbJuvOdQQW8oLqD8+TvLgSxhk8j9ZyX40wXCVSMPoWdjAKx1Xk8Q1bnsGhzLM4L4fKbAnY/uffKR27zVm5WLFm/J4kO5jO8GrjC4518a9TgBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ks9eBAfc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ks9eBAfc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05BB9C2BCB8;
	Mon,  4 May 2026 07:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777880045;
	bh=scmgntQCYHa6EVIjS+lp7kYdyYV2XIhqqHIU12zjkF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ks9eBAfc7/pV4dQYXl5Tkmnn9gJOTgwljWhqPwRKCyDQJgs4Cj7+cJXFOFC3Z/dI2
	 rbLglSbwNsUXpkEDY6dsDTdf4RUNivppfpRpcRPZigVQyYj9809C7ckguz+Ie3h+Kr
	 r7ysK7i1bc2KJJDfbnA3XmJOfLUMHyBc9hJNsiHo=
Date: Mon, 4 May 2026 09:34:02 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: jirislaby@kernel.org, peter@hurleysoftware.com,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	baijiaju1990@gmail.com
Subject: Re: [PATCH] tty: n_tty: order lockless input availability checks
Message-ID: <2026050451-tree-trustful-a841@gregkh>
References: <20260504072321.928921-1-zzzccc427@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504072321.928921-1-zzzccc427@gmail.com>

On Mon, May 04, 2026 at 03:23:21PM +0800, Cen Zhang wrote:
> The N_TTY read buffer uses release/acquire ordering for its
> lockless ring indices. Input producers release-publish canon_head and
> commit_head after updating the buffer and delimiter flags, and readers
> acquire those heads before copying data. Readers also release-publish
> read_tail before producers use it to calculate room.
> 
> chars_in_buffer() and input_available_p() sample the same indices
> for availability and flow-control decisions, but use plain loads. That
> can miss the ordering used by the data-copy paths and can also let
> poll() observe termios-synthesized availability with weaker ordering
> than normal receive-side publication.
> 
> Use acquire loads for the lockless head/tail samples in those
> helpers. When n_tty_set_termios() updates canonical/noncanonical
> availability, publish the updated heads with release stores as well.
> Keep the cached icanon bit as an intentionally lockless mode snapshot
> and annotate that access.
> 
> Fixes: 70aca71f92ca ("n_tty: Fix unordered accesses to lockless read buffer")
> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>

What tests show that this is needed?  That commit was a long time ago,
and surely we would have had some bug reports since then, right?

thanks,

greg k-h
