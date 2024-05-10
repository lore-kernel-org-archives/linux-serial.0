Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D6780BF8;
	Fri, 10 May 2024 10:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715337653; cv=none; b=noBlxirLYWH2XQOQSR7zvTbGN8ap5A6cTz3WYkwvjYmSiuFvZ4v7hsBGWq312f8qESfC//GH3i+HapJNsNEZIhuAzR8vf6T8cI1wfZ/MOXFcNaa3/JPYRlt6JeH8CCaYN+CWErGL6BFOd4L5INQA3Yese+4oPwMzWcoB2ARacxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715337653; c=relaxed/simple;
	bh=wMZuHNxRQ1suG3JAK+RcMQPpAT4dzMSqsh91R2I2sUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=stliVhRhI8jjItFRY7qdyq1wVE0hb9484BymUaNnOL68vOnghYdG5Epe7dCvdAVm2zOJxcEQe4xh+wrjHiC06IvS7i7H8YjJOUPi+xX+ZdAV4W2YE7X4l3WjMAd43qrw2fQpSCs/Hy1OX8EIunoTD/iAS+JCeekb6/uVg8s+GDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qrtjd92q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qrtjd92q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70C12C113CC;
	Fri, 10 May 2024 10:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715337653;
	bh=wMZuHNxRQ1suG3JAK+RcMQPpAT4dzMSqsh91R2I2sUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qrtjd92q4b82+6m7iyitDshVzxSqnRhOlZXdBaAE1CMjHKxvbzYsGdtSkZKahjC8n
	 oZ+KWftBz98c9FAXo4qvnJoKJYKqRcO5ZYP2hB6b9WqZx90BD8GzjbncCKgRyC0smR
	 DfRGewBFt+iAWWMrRAscTASQZtLqQ/GWVuYetdlk=
Date: Fri, 10 May 2024 11:40:33 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] tty: vt: saturate scrollback_delta to avoid overflow
Message-ID: <2024051039-bankable-liking-e836@gregkh>
References: <20240506-b4-sio-scrollback-delta-v1-1-4164d162a2b8@google.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506-b4-sio-scrollback-delta-v1-1-4164d162a2b8@google.com>

On Mon, May 06, 2024 at 06:55:19PM +0000, Justin Stitt wrote:
> Using the signed overflow sanitizer with syzkaller produces this UBSAN
> report:

<snip>

I think you might want to hold off on these until the discussion on the
hardening list about overflows all settles down to a solid resolution.
Right now these all seem to be a mess and perhaps you will have a better
set of primitives to work with once that thread is finished.

thanks,

greg k-h
