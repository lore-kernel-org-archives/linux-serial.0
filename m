Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791501E5B7A;
	Sat, 12 Jul 2025 06:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752302954; cv=none; b=HeSGJbwDDik9N9Fv7yzOVosoDX2oPTsanoExsEJtEwow67/DiAdbxafNehGGeFJ7+6v7BKtyq0I3Blu0YkFas1tC1vATT3yAacTIxTrDlb4+NbFugqf093iHJxenTC6c0PGba1H6isDxh/Sky7x/QB36MMbqqThewep0CilzCqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752302954; c=relaxed/simple;
	bh=TWJ5z+kmsDANWjylFrIx+jWhuBbFpmRSioccZfJgFMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nX5qczIyFDDMeN0J8r8ru003uf0X9HNn9MXmIw9RDvT9AqKwYPie0gCP/hZkX0ndxK8prOSJEb5hxluP4Bt/ore47I5//3rHnZdbKXf+JlWVu/Lq9vZ9jR/xiE0XOT/8uaH3lDqKm87Ka9scCnWNH9bWeXDQxrmMVaz/6lvfd+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UJ7tXB2t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UJ7tXB2t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89836C4CEEF;
	Sat, 12 Jul 2025 06:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752302953;
	bh=TWJ5z+kmsDANWjylFrIx+jWhuBbFpmRSioccZfJgFMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UJ7tXB2tSpvQ14ljduQK+3K3uwzeazoTQecSScvTFbUgdxGHquGcWP/3EZzDdi4uT
	 Kv8aJzj4n4v/5O+NFErfh1K4be3q/7679IlMre9tYsA/uk8AMsJk95nH1mFndx3dOU
	 IwJ/kS8JR5w+dH4zzN/9CGNwIR3afdkTysT+40RI=
Date: Sat, 12 Jul 2025 08:49:10 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Chaitanya Vadrevu <chaitanya.vadrevu@emerson.com>
Cc: jirislaby@kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
	Jason Smith <jason.smith@emerson.com>,
	Gratian Crisan <gratian.crisan@emerson.com>
Subject: Re: [PATCH] serial: 8250_ni: Fix build warning
Message-ID: <2025071249-curdle-predator-05ed@gregkh>
References: <20250710223838.2657261-1-chaitanya.vadrevu@emerson.com>
 <2025071102-zombie-disbelief-4c38@gregkh>
 <991f5fe9-b810-4aef-825c-d0b532584730@emerson.com>
 <2025071206-grip-overblown-bf53@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025071206-grip-overblown-bf53@gregkh>

On Sat, Jul 12, 2025 at 08:47:42AM +0200, Greg KH wrote:
> Ah, you are right, sorry, I always get that one wrong.  I'll just take
> this as-is, no need to redo it.

You already sent v2, thanks, I'll take that.

greg k-h
