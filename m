Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F1D36B908;
	Mon, 24 Aug 2026 15:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787584337; cv=none; b=a8rck6G2akyI85LfPrXooRXekOwTZZ2hjhZoI0Fhj5iddFF/QAY4piTvyyAnk2ULRBMZGcezDCRBtBMmA9foR+6MLQRDfmL7N9FlLEiYqQMgPUBKEEr97XKRn7KJuUpVqJNGUuTwL1Sn3y1KwexUDp6nTBkqas7RyU2Jxx7Z5wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787584337; c=relaxed/simple;
	bh=L57nxidJre8T25oraV0zASniEZYhjlya6GrOeut5Q6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xg+2+AKXaYof2ydTMEEuKzfMGqgRVMi3NrirFTmLh7cZ9ZjqM3wFA8Ye+q1a62tlS3DyvqPL+0LZy7fRWCAYUwilw1jMNkMdh3cZf33Ovb9ErN0012KR8gACpT2NH8Zd7GTKIpSWgMT9qfS7YCzDP/j0T5MI+HsWkz9FlCiVJzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mWijSNRy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mWijSNRy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBD731F000E9;
	Mon, 24 Aug 2026 15:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787584335;
	bh=aL4PSpbTxLcGq/m29znu3D64PKn4hwpK4ee8tv+x3xw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mWijSNRy7jh0h+E6xmLCVXcbgJFiYOQyZO3goolyAEPfHcUzMcNU25/kYjGAH1NFP
	 AFg9e1AaHDnOUrqH3zEmjJarEWGzV+FsHpHcIQUJe9NXg6KkKpwl7SQjlPMrRHDMmh
	 eemQFYU458x3PYEJUqWkNg0X9JUY7rGSjkWewa5M=
Date: Mon, 24 Aug 2026 17:12:11 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jaeyoung Chung <jjy600901@snu.ac.kr>
Cc: jirislaby@kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, eulgyukim@snu.ac.kr
Subject: Re: [BUG] KASAN: slab-use-after-free Read in __timer_delete
Message-ID: <2026082445-peddling-brigade-34ab@gregkh>
References: <20260824145314.2148275-1-jjy600901@snu.ac.kr>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824145314.2148275-1-jjy600901@snu.ac.kr>

On Mon, Aug 24, 2026 at 11:53:13PM +0900, Jaeyoung Chung wrote:
> Hello,
> 
> We found a "KASAN: slab-use-after-free Read in __timer_delete" on Linux v7.2.
> The issue was found by our own race fuzzer. We have not analyzed the root cause,
> so we do not have a proposed fix to offer.
> 
> To reproduce the race reliably, we applied the delay patch below to the
> kernel and ran the C reproducer as root inside an x86_64 QEMU guest. The
> crash log we observed, the delay patch and the reproducer are all included
> below.
> 
> The following kernel config options are required to reproduce the issue:
>     CONFIG_N_GSM=y
>     CONFIG_TTY=y
>     CONFIG_KASAN=y
> 
> We hope this report is useful. Please let us know if any further
> information would help.

Please see the email archives for why attempting to fuzz this file is
not going to go well, and why you should just ignore it UNLESS you have
this hardware.

thanks,

greg k-h
