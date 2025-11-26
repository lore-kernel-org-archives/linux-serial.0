Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E4324468C;
	Wed, 26 Nov 2025 16:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764175070; cv=none; b=YbYpZqzPypeLfdOjV/NptNjhv2goDd0lVDq2Up9dbl+FgX73NM3Q+kMh3X5fNTG7Ci5Zz+kMSdIwe2lti5XOJUFTBfNMzVXO7htPxw644u+jHv/S1uTp+zDnfC3R61skL+9g4W5olX+7JV3Z5eweLxtvt1xZEO7jTOQ9QMB1DbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764175070; c=relaxed/simple;
	bh=ablj5gm3uGPBB0bMYf5cOWpGH41jcCrr49MCznyzFAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aUrftTVwyJ241yTAJCS8g9Y69z4KbIfskwn3HX0HW9o3bd9VW5+vyyASlqLfFDTSxsrGYQVVxmXIa4LBPCXuncgrkPSfqLc2i7XIs9NlzC/cNl8bCVmzPeChCxgzzimnHKu5nOdGZKk3qnagBlIFVrcRJ/1+VkC/uEvDj2iQiLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YlQRa8U7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YlQRa8U7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADE04C4CEF7;
	Wed, 26 Nov 2025 16:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764175069;
	bh=ablj5gm3uGPBB0bMYf5cOWpGH41jcCrr49MCznyzFAQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YlQRa8U7qNxUu9+Epc6mEG6xll8PYG/Ge9by7UZbQjn6R5Z3qXsI/vZqnh1cRbh63
	 iSE7q/PAKmKFbOrOIpAFhrj4ppsbh8g0AN8veON/WkhTH2D62EJdPHcw4UUjd3UaYg
	 zCtbxjwkzNsgDcrcN5zq9ROFitIGdiQ/2B5qWQ9u8344JqNiap4c+vtEFY03HRwGPP
	 YXIexxJFLGA4fV0Ry77fFqxpvu0rkXFj/Pixxsqu8ndzd/GoyXEIE6rt3RDisVcRlu
	 EvvrpJg2TRHXWxDemOhLVgrn7RuPRGwc+22SwMg4HaHpZerHzqmXjruWwJkAEagrXs
	 ZfcTmTVGaIFbQ==
Date: Wed, 26 Nov 2025 06:37:48 -1000
From: Tejun Heo <tj@kernel.org>
To: Xin Zhao <jackzxcui1989@163.com>
Cc: gregkh@linuxfoundation.org, hch@infradead.org, jirislaby@kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v3] tty: tty_port: add workqueue to flip tty buffer
Message-ID: <aScs3LZ9nAIHCPzk@slm.duckdns.org>
References: <2025112654-shaping-undoing-afe4@gregkh>
 <20251126144650.2799567-1-jackzxcui1989@163.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126144650.2799567-1-jackzxcui1989@163.com>

On Wed, Nov 26, 2025 at 10:46:50PM +0800, Xin Zhao wrote:
> On Wed, 26 Nov 2025 13:10:49 +0100 Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > I don't know, what have you found in your testing?  Will multiple
> > workqueues cause too much overhead for large multi-port systems (i.e.
> > modem banks?)
> > 
> > Perhaps start with just a single workqueue and then increase it if there
> > is contention later if people notice?
> 
> OK. I will allocate single workqueue of one tty_driver in v4, simplifying
> the logic for creating and releasing the workqueue.

Note that having multiple workqueues doesn't necessarily mean there will be
more threads. If you have 10 workqueues with @max_active of 1, you'd get the
same concurrency as a single workqueue with @max_active of 10. Each
workqueue is more of a property domain than actual thread pool. I don't
think you'd gain anything by creating a separate workqueue per device.

Thanks.

-- 
tejun
