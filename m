Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BC83C461;
	Wed, 10 Jan 2024 08:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q87NB7Nr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B28E7C433F1;
	Wed, 10 Jan 2024 08:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704874882;
	bh=AoyiDQNyGKArSyTegD9rbvPIsc9ycTG3LPn2hasix6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q87NB7Nrwsd3zdRdDPzk2XuMg3YDfbviR8DKaYuxX/JB1gMJLkuMj+hve4nb6I6/R
	 4oRRv9q1A5hVO8UjjjoVJ0gJiYu/qeXvuiGbvMDWKBXL/o+tqTiPEOQN4JEMY5coNQ
	 Pe0fiOo9vZ+rDhxVY4BplEridHW82vyzE1eh8ZUM=
Date: Wed, 10 Jan 2024 09:21:18 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: chenguohua@jari.cn
Cc: jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] vt: Clean up errors in vt_kern.h
Message-ID: <2024011050-reviver-monologue-f7e1@gregkh>
References: <32f27893.e2a.18cf263f008.Coremail.chenguohua@jari.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32f27893.e2a.18cf263f008.Coremail.chenguohua@jari.cn>

On Wed, Jan 10, 2024 at 04:01:25PM +0800, chenguohua@jari.cn wrote:
> Fix the following errors reported by checkpatch:
> 
> ERROR: "foo * bar" should be "foo *bar"
> 
> Signed-off-by: GuoHua Chen <chenguohua@jari.cn>

The subject line should say "checkpatch" as this is not a "real" error,
but rather just a coding style issue.

thanks,

greg k-h
