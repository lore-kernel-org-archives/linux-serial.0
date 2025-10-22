Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B6C272E51;
	Wed, 22 Oct 2025 16:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761151059; cv=none; b=Q+XB300AbNTmvFX8/mUVS/9QcFS8q4ybb6DsNG59bXcRazJHcgLej8z1QKhbBayynP0NjB6ibWCeX/0bBptrX2QwAns5E8R9HD0K1C8NTh6RZA8y+5tYGTl/L2wUdzGcFI4DKAha3fp+rH7o56q0Mt43MZPMTYzhxLTAe9iZTGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761151059; c=relaxed/simple;
	bh=qAJ3x6BqFYdL50HRKnzjCUxzzqmPI1QpprcHgQR24y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HSHuWHuBqk01x5DOYVTXgFdP8c1pzg5jiOCZ9DsUByC8PIFlvJyRYtgWlVKbsRTGQjZgBxFVxxC9+myHMNCHg2T4GVPvyuYOkGRyVdbsi9RF7oDsNtj8hjakhTG6uala2oM2pOkMzSamKCWj53QaE1cj+NlbarRjxK0DSJjohA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2/VuunN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2/VuunN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABD95C4CEE7;
	Wed, 22 Oct 2025 16:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761151058;
	bh=qAJ3x6BqFYdL50HRKnzjCUxzzqmPI1QpprcHgQR24y4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n2/VuunNk6TXE2a3YSL4vf3xbt9rRhsLI23qHz7U9XYD5EM9EVkd30kKST1ylVZfi
	 JH1ti86LdlRjgIDSxB5JuajKRhkUqkVnEASDlYe63dg3oZaz22wt4vVFK/xWtXMRBp
	 XPo7t+jxDLCO5DxfG8LjO8KsxwRhHJSBYGB3cMZFWtKz/6oJvWgBz5pQ3AKkalE43U
	 pW45KnPnamqeAyM5/rFrtq8GlQkTVf8oeX1t88UjDOhZzV/MkYzxfMmJWRSvwCNwx5
	 5tRsfHD6/AYHwk1ui1/6j6JG0eBBMDjstH0iJqdQBekQQWY43iZ4sTNGuqf05rrq2+
	 IIAu7cOqKPqpw==
Date: Wed, 22 Oct 2025 06:37:37 -1000
From: Tejun Heo <tj@kernel.org>
To: Xin Zhao <jackzxcui1989@163.com>
Cc: gregkh@linuxfoundation.org, hch@infradead.org, jirislaby@kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v1 2/2] serial: 8250_dma: add parameter to queue work on
 specific cpu
Message-ID: <aPkIUa73Xfr8NA-q@slm.duckdns.org>
References: <2025102107-player-baggie-37fc@gregkh>
 <20251022144707.160181-1-jackzxcui1989@163.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022144707.160181-1-jackzxcui1989@163.com>

On Wed, Oct 22, 2025 at 10:47:07PM +0800, Xin Zhao wrote:
> Considering the current situation is still limited to the RT-Linux scenario, if
> possible, I will add the logic to create this workqueue only when CONFIG_PREEMPT_RT
> is enabled in the next patch. By setting WQ_SYS, it will allow user space to dynamically
> modify it. Additionally, in tty_flip_buffer_push, I will check if a private workqueue
> has been created; if so, I will use the private workqueue to queue the work task.

Creating a workqueue isn't that expensive. Might as well just always create
a dedicated workqueue.

Thanks.

-- 
tejun
