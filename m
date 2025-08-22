Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6636D2FF
	for <linux-serial@vger.kernel.org>; Fri, 22 Aug 2025 04:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755838016; cv=none; b=JDrSfvYWyCCyApB8y3nPUGa/Vy9lEieFqi4EuGb0IGYWQvS9tDFmrd3zcHg7JTOtgfpahThe5uezqGndosTAySqFMmmLDJjrzjBfe3Oe7buR2/u9c2kp1PxdWaYyR7R84AfJY8UPmHVxT9Xsx7UUCrfZXAxEZ8NlKUNcJaqVwaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755838016; c=relaxed/simple;
	bh=KA4uJV82fZcgkl9TFVFTf4Yr3jts0XEea2cNJy8Eams=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fn7D0PQu+UtrBGv/WjkfE8rYv3NymPdT0krNgUpFfplO4hq5x4ZqoaGhqzz03njzOQWn5dsOpfNhDHJRqw+ONjHMeVml0hF4RWEIDJzaGK/jIOGUPRyT8QNo7WYBJEfcsScrEO5DXNVTnhra0zL+eCeK0hdr1bPiOAK1XAitUsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hn3vqvOE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hn3vqvOE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD9AFC113CF;
	Fri, 22 Aug 2025 04:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755838016;
	bh=KA4uJV82fZcgkl9TFVFTf4Yr3jts0XEea2cNJy8Eams=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hn3vqvOE0qgkPS0lQhF03P4oT0qkyR3gBLt5mdn8OVFZAzSiD3wFu2euoU0UV6ypa
	 d7jYCIo2Waq6GAOenhuGc1sX/pi6M3gVyBoYhbFzO6m2wi93wtJkuuz3XoM1BA2WWI
	 s0U7y4h/Ju2jU7mBgXanat+LDSKJQ/X/5Yt+lkEs=
Date: Fri, 22 Aug 2025 06:46:52 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Zong Jiang <quic_zongjian@quicinc.com>
Cc: linux-serial@vger.kernel.org, dan.carpenter@linaro.org,
	quic_ztu@quicinc.com, quic_msavaliy@quicinc.com,
	quic_vdadhani@quicinc.com, quic_anupkulk@quicinc.com,
	quic_haixcui@quicinc.com
Subject: Re: [PATCH] serial: qcom-geni: Fix off-by-one error in
 ida_alloc_range()
Message-ID: <2025082206-fragile-trading-ccda@gregkh>
References: <20250822033532.4074827-1-quic_zongjian@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822033532.4074827-1-quic_zongjian@quicinc.com>

On Fri, Aug 22, 2025 at 11:35:32AM +0800, Zong Jiang wrote:
> The ida_alloc_range() function expects an inclusive range, meaning both
> the start and end values are valid allocation targets. Passing nr_ports
> as the upper bound allows allocation of an ID equal to nr_ports, which
> is out of bounds when used as an index into the port array.
> 
> Fix this by subtracting 1 from nr_ports in both calls to ida_alloc_range(),
> ensuring the allocated ID stays within the valid range
> [start, nr_ports - 1].
> 
> This prevents potential out-of-bounds access when the allocated ID is used
> as an index.
> 
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202508180815.R2nDyajs-lkp@intel.com/

Why do you have "| " here?  Have you ever seen that in other kernel
commits?


> Signed-off-by: Zong Jiang <quic_zongjian@quicinc.com>

What commit id does this fix?

thanks,

greg k-h
