Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA5D2D94BA;
	Thu, 12 Mar 2026 13:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773323072; cv=none; b=FrQ2CEboGkv2zzbT8eEA9Jg1b+jgUr/e8DKJxeTGAuADHw+OYG4k2ksan6iSkoNobfMehZvg8sx+6RxuLG57cSIYyF5KQm8eLQ7daKeU8ACNRKYsFomxGrz/4k2amWZbEXPXKNK4uTte6hd2fuaQSWggSRqzOcDThh/Cjmk5dMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773323072; c=relaxed/simple;
	bh=ZdJlCfHSVxnH0b72Vq14nnKRhdcGvsb4M6dqsBV9nhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dY7pbTfFzZm6gWLHlkJOlB9uEutRB9keAqKkUzI5IzaeWd69X0AOX5o9J8A1THWn3RCJNMAYnGpHGKQkbU78MLTAOV9CBZ8wxA5EpDb0P4VYhq4WVjsP+LjQrLZ/evIjqYjVExz4hTaY+NbtOw+b2zQNextJ0N8jyRo+Ssz+bKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QD+oruav; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QD+oruav"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE92C4CEF7;
	Thu, 12 Mar 2026 13:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773323072;
	bh=ZdJlCfHSVxnH0b72Vq14nnKRhdcGvsb4M6dqsBV9nhQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QD+oruav8Ciyp3CBqJDD09LHx71SNIbfWqy0uz2GZniNcrgR32kEpMW07ojPjIBc1
	 uEuDLvmnsJET2DmcGESkKJHY5goAIhzuUBTFXaqAGfd6CqHBv1KqKBe1xwXlGhlyuY
	 cldOZJVhSDjK3boQr4h4l2/YdZY7KAa9Q+ST+VqM=
Date: Thu, 12 Mar 2026 14:44:26 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Pete Connor <pete.connor@pythcoiner.dev>
Cc: Chaitanya Vadrevu <chaitanya.vadrevu@emerson.com>,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_ni: use kzalloc_obj() for allocation
Message-ID: <2026031215-dance-astute-5c5f@gregkh>
References: <20260217031913.1166949-1-pete.connor@pythcoiner.dev>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217031913.1166949-1-pete.connor@pythcoiner.dev>

On Mon, Feb 16, 2026 at 10:19:13PM -0500, Pete Connor wrote:
>   Replace kzalloc() with the preferred kzalloc_obj() helper
>   to address a checkpatch warning.
> 
>   Signed-off-by: Pete Connor <pete.connor@pythcoiner.dev>

Something went wrong with your indentation here :(

