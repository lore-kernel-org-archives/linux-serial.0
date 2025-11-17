Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD1727B32C;
	Mon, 17 Nov 2025 12:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763382939; cv=none; b=tpf3Clz2FVzlXs8kUB9aKP5OFtmX6ep3CowtntGWoGVVrTzf2eQMmDQcp4z6CnnDtgWCPliNyr6bqTutp5Q868NPyhNhpIZUdm0ceIWEFOZ05Nu+LcjLS6meqzbqwwVAO/8XVSAqv9yT5Rh/qEOExCWEwu1uU5EML0fIqoUdy20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763382939; c=relaxed/simple;
	bh=ZPov21ABVP5N3N86Oc3pqxVu+RXbOeoNDz8JY5NFybM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N81aEs5RYlxl04bCsqA6q/t1VXL9SVs7Vu8rY+u23hKVETIUVY4QNklVqCs8jI3QZvOsu6lWlHnpWhgix1POFub5oAEhPgegPguIDDx5LSflGxQMtDOMSiLDBbp9X+fgfjozp/yF4qoYblMaBhIArqf3jcbo/OWKEx14x58JGPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bvR03Vij; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bvR03Vij"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67FE6C113D0;
	Mon, 17 Nov 2025 12:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763382939;
	bh=ZPov21ABVP5N3N86Oc3pqxVu+RXbOeoNDz8JY5NFybM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bvR03VijCBZawd0yDLXhZiyTWyZ/cHmrzlnW0ekfnzG975OFWlzo4N8MFd8JODzez
	 1xr3mmJBQ1eEfjGOIbQNwLX3m2Abhs+CP/y5YOlF08jefGS79yua8DmzNgUolHIJqU
	 NP90hZBFD3wsvL6NIm34DECrD+zw4l/PNUgKxe7w=
Date: Mon, 17 Nov 2025 07:35:34 -0500
From: Greg KH <gregkh@linuxfoundation.org>
To: "jempty.liang" <imntjempty@163.com>
Cc: jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] ALSA: core: Fix style issues in sound/core/device.c
Message-ID: <2025111724-equinox-bondless-c407@gregkh>
References: <20251117033807.55512-1-imntjempty@163.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117033807.55512-1-imntjempty@163.com>

On Mon, Nov 17, 2025 at 03:38:07AM +0000, jempty.liang wrote:
> This patch fixes blank line and trailing whitespace issues in
> sound/core/device.c as reported by checkpatch.pl.
> 
> Signed-off-by: jempty.liang <imntjempty@163.com>
> ---
>  sound/core/device.c | 6 ++++--

I do not think you sent this to the correct people and lists :(

