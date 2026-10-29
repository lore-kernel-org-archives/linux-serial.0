Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793255013;
	b=iQ1KCdKrGIJFFjl7Ww48Co3r8uLNXKojDFMBCu0PssC5Zuxlmct+obOguYuir4fMmEjc
	 1GmTKuEhPMX+qGd1ZExYw9E1ZXTRpIguX0909VEgujNOFYnmmW7Ua0dZK3iCnzgWFqZ6n
	 f0VDgyX6hAMdPsKnDs2T+i2ZNYnEk24ZrnoS4ShYIlliGXS0Rw6pioTn5L7o8b943lVsS
	 FSFFQMjXQYyCovQ5nhhgItnKAD+TJpEVmGrv3GM6xEktlY5x7lxYpU7dyYRVN93ZzB4Mf
	 GGegf9faUQxaI6HXqrkF0yu95867asSUocKETDZPtU0bByXXMl8crO75Ctt1412EyJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793255013;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ekm5UlrcMERWb+Z9yJF3NqZM3X+Bb1WsVBzJNPZWKXY=;
	b=QVRUs1QkU+t50c3zLckeaU5/ZnQGtIyaTUiCoDK37DanuDRwFjrmzYYq4bNAEMKvqtPo
	 G+an6SBj6IqV+gfKWRtjwXjBEY6VxTrQJrhU40ik+/ZTMGb1NgPZhffV1Uq41V98uPtMJ
	 ZpabUoD3mfPlOx3vEAAdUTBcgx/BpJzelwiK0JCKl8gMprn8oz+3gmZ7OnOyQSAAyJpz+
	 clZqmZkSfw5sd/wBPW1FWpR/9WE1yeNdh/sjWQC5NFZzwZGKC2Xvn5PGnon/s8pPAjxMY
	 6IH8hFOGXB4HMkgJhgVf31mtlZxPXF8nPELYLvWhgHQbukGQ2KH8aKNwcPbObx152RQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=LOYyDSsR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC9C606A320;
	Thu, 29 Oct 2026 06:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=LOYyDSsR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 745F31F01825;
	Thu, 29 Oct 2026 06:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793255013;
	bh=ekm5UlrcMERWb+Z9yJF3NqZM3X+Bb1WsVBzJNPZWKXY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LOYyDSsRpnvlmtDx9v6fRsl3VelANDTFL1Vn4jrZ8qQWOT0ay476Ud2sS2/k2w6tI
	 733BBQII9qdc7+38bp97SE0qsTcJamO7TVtBXOp5YbsqmjrU/NB1wQBAXeQlRhlxPv
	 OkAC6LCpc9/kyt7Y6TH0OWRKtlFmpdkZoeEjAhC8=
Date: Thu, 29 Oct 2026 07:23:29 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: jirislaby@kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: n_tty: convert the full VTIME interval to jiffies
Message-ID: <2026102957-suitable-gesture-be83@gregkh>
References: <20261029002052.54117-1-dennylin0707@gmail.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029002052.54117-1-dennylin0707@gmail.com>

On Thu, Oct 29, 2026 at 12:20:52AM +0000, Hungyu Lin wrote:
> VTIME specifies a timeout in tenths of a second, but n_tty_read() divides
> HZ by 10 before multiplying by VTIME. For supported HZ values that are
> not divisible by 10, this truncates each decisecond and shortens the
> requested interval. For example, HZ=128 and VTIME=40 produce 480 ticks
> instead of 512 ticks for four seconds.

What real system uses HZ=128 ?

In other words, is this a real issue at all?

thanks,

greg k-h
