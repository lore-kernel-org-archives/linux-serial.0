Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EEAA35;
	Tue,  6 Aug 2024 04:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722919887; cv=none; b=Z91jM1UC4Gfn/Rt57iJ09CwggOhml63yw9MJ4DyPhT4iEqEzCzl2UMNp5NA3ISZ3/N8r41LY9mbqR7K9mVpuI3I6fWxrRHI01pC0sLUiKxee445Ox2aNyu38nlezoG2WUVZkQw4snfPWSfQg9Zhz4xnAAjgmZprtNBB0xbm4KP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722919887; c=relaxed/simple;
	bh=TbiCSzBYmLGldS+dmeAtupFPU6qc4zR+8Bsz3z9h/+k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d7F+dr2N3j+XV+kf67Zpazw8KKDDLOI9VYiyWQ5g69bF5VoWgN5VQYEeFRw3wBFw/p435KqMiwUfwNb/RV5zA6cBPdy4y6LJOU1U1J6pnypRYwclmtcpo8FXsuDt+jrq0kTAVhBFihF6F1q5okN6IWg9VOfVeXBom1xwoEYe/Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=bJV6MkHZ; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="bJV6MkHZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1722919876;
	bh=TbiCSzBYmLGldS+dmeAtupFPU6qc4zR+8Bsz3z9h/+k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bJV6MkHZ6WYaBPBYchyIajSGJZNJrWj7uGfIJamq2Kb+WpWNDKf7Z4ujV2zchFnof
	 Q9TU31oTSLGjlsyyI9DC53OApA5lz57r+tFi+O454oWqMdD67dLKg2f3QWE9Dli6yG
	 x8Sref3r/Z+Mwsxirc8ILUzrDYHZ8MVZfURYgENeOvniUkn1o7ptaPXg/LKTXcs9zc
	 qzKP4kRK9NEU4iitAj0zGsRzfU95cNjNtvgSj9AYwrq1yXn605YnEax0tosh4/pHyP
	 8lz3x7pSS5UsAhNNqtx0tx97DN1YSnRB6ortzVmeqqyn/kBSl3PFWj98mc2sNI53Kj
	 JceIFBQL+u0kQ==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id BD3EA65665;
	Tue,  6 Aug 2024 12:51:15 +0800 (AWST)
Message-ID: <532223445d395ac6ac5da0e34d00c0edb9ffd998.camel@codeconstruct.com.au>
Subject: Re: [PATCH 08/13] mctp: serial: propagage new tty types
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Matt
 Johnston <matt@codeconstruct.com.au>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,  netdev@vger.kernel.org
Date: Tue, 06 Aug 2024 12:51:15 +0800
In-Reply-To: <20240805102046.307511-9-jirislaby@kernel.org>
References: <20240805102046.307511-1-jirislaby@kernel.org>
	 <20240805102046.307511-9-jirislaby@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Jiri,

> In tty, u8 is now used for data, ssize_t for sizes (with possible
> negative error codes). Propagate these types (and use unsigned in
> next_chunk_len()) to mctp.

All good on my side, thanks!

Reviewed-by: Jeremy Kerr <jk@codeconstruct.com.au>

I assume you're looking to merge as a series through tty, is that
right?

Cheers,


Jeremy
