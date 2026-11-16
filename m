Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794821930;
	b=WMiS6g4UnO3OxA9g5nydnQzuMgdwIvhfWpyVFQ9GYWvilwl8SSG0Ogw14G/rqEayOxYE
	 frfJ5Y1v4/PayO3r/wUp3lXlFYIfYXjJMgP3I/h0XTEylkXliWokShK1h0FqrW+u+JwSo
	 KL1CLs3vmU+8W2Vmx7faacD5f+G16ocf3Y/voOb888/rjlB1OyG0Zsantdi1+sKE/hPSJ
	 eOuXoSOmT6ZqJJT3IPH3ullWRLu4r6WrZwad1193P8faQTOCBBXP/cO2u1c1ooT9F+Er+
	 gwRwyw2KzethumbukY/x8TRW+TgpYCPJNMz5nDoiJsAEdUVGYUqLFcUplhsDVi+NukA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794821930;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=e+AwByM1Ua1XXBVOkdp9Ajnqky8I3HaY2gjpAtRHjB8=;
	b=QFyBX663SlZctB12Xi8xVzqFYVobrmlASpHCitk95waPeSikZaAy6wCgjIegDdhoAo0C
	 T+7l1xo3fnErc09mWW6kBnYNsyZcRTAnuYYrRkpnpN9OzZtUJpQbQpbv6oIQMD/WJ9eXu
	 F5S+2YdDu77wzZ9hGMPakrd+cHAfbBwFwVdyQJMdAuzdZPuGd67pLSKcyXE1IIRBkKxH0
	 cRsX4KPAEODSbZp8P3w3O/ziS1hDCDXry8B4P6OmwcSlR67NVc2gbq+It2boBZoH1ySeM
	 xTPvPihhnq2NFGNg1sGCiNvAIQJEZ4MbuliIBflV1XmLZ9CHFgx674/KQ1K4bUgSoQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=mIha81ks;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2163606A31C;
	Mon, 16 Nov 2026 09:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=mIha81ks
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CACA91F000C4;
	Mon, 16 Nov 2026 09:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1794821930;
	bh=e+AwByM1Ua1XXBVOkdp9Ajnqky8I3HaY2gjpAtRHjB8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mIha81ksj3Z9miugcyupGxfWvY9DWv+mLBRnX48rHNSIzLf1RAlGsI8Tcgp2vCSPG
	 I4PJByLXnhpMLmCV25E8j15/x6PoqIyALxaUEyJXxPF6u2ow3MMMGSGuLiaC7a64MD
	 GBXmyDISnGjci5aAOMvePqNcbtWg3TdqiV6mnS6s=
Date: Mon, 16 Nov 2026 10:38:47 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Cheng Yongkang <teel4res@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [BUG] tty: n_gsm: tx_work can be queued after gsm_cleanup_mux()
 flushed it
Message-ID: <2026111647-pettiness-detached-c1b1@gregkh>
References: <20261115163646.226207-1-teel4res@gmail.com>
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
In-Reply-To: <20261115163646.226207-1-teel4res@gmail.com>

On Sun, Nov 15, 2026 at 08:36:46AM -0800, Cheng Yongkang wrote:
> Hi Greg, Jiri,
> 
> Before anything else, a question. In September you said that n_gsm
> should only be touched by people who can test it and have a system
> that uses it. I do not have such hardware; I only tested with a pty.
> Does that still apply to bug reports like this one? If it does, please
> ignore this mail and I will not send more n_gsm reports.

What has changed from my original statement that would allow such
changes to be accepted?

And again, please do not send "here is a potential problem" reports
without a real patch.  Your llm can provide that just as easily.

thanks,

greg k-h
