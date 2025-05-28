Received: from mail.enpas.org (zhong.enpas.org [46.38.239.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB87D7FBA2;
	Wed, 28 May 2025 13:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.239.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748439085; cv=none; b=uA5vN5OIJB/E223RXfZRU6ZCPypsmmqwxUIwtoST1J9gQb/6GDxTiRKCWMR06lVMN6uEOBbBk5sgZUGL3bk/I/gsD+dJioBOLhCIcgGRjs3ZguUnBSpQprQOIM8IxB2COt8K8R7HjavhPMfRWCejUID1y91+exW4Zm08Wk/Ohug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748439085; c=relaxed/simple;
	bh=9GKAxXzOyI6ofZz7YPv5ib0aESLjWf40bDf8lwn3igg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NNgKrB3bcRojufPxhwJgMeu56JZs2xTbZWRR8/rmfR/EXvE+rPxdKKHsjPpN/1ZLZk+FD4gSRse3v0PKQgbnPZspKGPoBaun4s5s4HKCf8PrgITVsEQ8wqpicjIQAEhwMlFzReVljNjIC2DcVe7aFsfosEwkwKSIaMEOb/nzyug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org; spf=pass smtp.mailfrom=enpas.org; arc=none smtp.client-ip=46.38.239.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enpas.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mail.enpas.org (Postfix) with ESMTPSA id CA49310392E;
	Wed, 28 May 2025 13:31:20 +0000 (UTC)
Message-ID: <bcbc2f6f-9935-415c-ac79-f839afe6204d@enpas.org>
Date: Wed, 28 May 2025 22:31:15 +0900
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] tty: Register device *after* creating the cdev for a
 tty
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250526112523.23122-1-max@enpas.org>
 <2025052801-human-aversion-3518@gregkh>
Content-Language: en-US
From: Max <max@enpas.org>
Autocrypt: addr=max@enpas.org; keydata=
 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
 1Nk4wgjdif6n69chAwuDQyOfWdz/dQ==
In-Reply-To: <2025052801-human-aversion-3518@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/28/25 17:23, Greg Kroah-Hartman wrote:
> As 0-day points out, I think this adds a new locking issue :(
> 
> But it's really hard to detect this, as you are doing both a revert and
> a change in the same commit.  Can you make this as 2 patches, one that
> does the revert which would be "easy" to review, and the second one that
> does the new fix?  That way we can detect what is going on easier.

Done!

Thanks for reviewing this, I've scratched my head about this locking for 
a while, and just when I thought I had used a suitable lock... Well, 
that's where maintainers (and now automation) come in :)


>> Fixes: 6a7e6f78c235 ("tty: close race between device register and open")
>> Signed-off-by: Max Staudt <max@enpas.org>
> 
> You also forgot to add cc: stable on this :(

Done. I wasn't sure whether this needs to go to -stable, but since 
you're the maintainer for both tty and stable, I figured you'd make a 
choice anyway.


Thanks,
Max

