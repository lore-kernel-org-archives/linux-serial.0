Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195BD1B041E;
	Mon, 24 Feb 2025 12:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740401316; cv=none; b=lDQ/DpF63L9CjQrNiU5tKygSI2YvtLvBjDONbL2QkO/ni6gr432yrxmXBBT9AegkiKu2EBLbSHC0ZAp4AQPBnN5LqNTfHaS6vfyBrCv1ZTJ8yTY2OV+GLaQt5ZPswwb1jo0BnM8Tv+O5XWOtAnMOyXtzkNTO0UtFGvr3KNBBFzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740401316; c=relaxed/simple;
	bh=sToislC1Vv7cuiOW5VzcASQTgxeUrbyvLfNb6ddVg3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fB48pxB2mTHO/JsI3TmQoa0FByUkSioRji6HMxBg5qGyBB6PMb2qhwHKrbnqic8sZgn6R3X0AH2hYJjtsWIjeDHal6E4XAstDy3QVajn5gbDFVp8/CeElkDh9roTpDTfewk/k1FgMxD51ppQe138sZrzgvI06wP3zZd0nhkZo/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MwnVDy6I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MwnVDy6I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12ABAC4CED6;
	Mon, 24 Feb 2025 12:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740401315;
	bh=sToislC1Vv7cuiOW5VzcASQTgxeUrbyvLfNb6ddVg3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MwnVDy6IeYwQvS7jYYmdhNRs59eSsfajixs+PrOiVg7SJrylqeJwpGhS2FnxySkI8
	 RAJvNcmDIGN4IuMrEBJDOGLVh7B6oRtk+tkNPXwuqSlDH/zZFDPEk4X+kX6rJd87+L
	 lvyYVq0h4i/7Qzl/2GDUhqKPSIwsSzkfkOqS4AWw=
Date: Mon, 24 Feb 2025 13:48:32 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Wentao Guan <guanwentao@uniontech.com>
Cc: John Keeping <jkeeping@inmusicbrands.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ferry Toth <ftoth@exalondelft.nl>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-serial <linux-serial@vger.kernel.org>,
	stable <stable@vger.kernel.org>
Subject: Re: [PATCH] serial: 8250_dma: terminate correct DMA in tx_dma_flush()
Message-ID: <2025022416-sanctuary-heftiness-7603@gregkh>
References: <20250224121831.1429323-1-jkeeping@inmusicbrands.com>
 <tencent_09E5A20410369ED253A21788@qq.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_09E5A20410369ED253A21788@qq.com>

On Mon, Feb 24, 2025 at 08:36:20PM +0800, Wentao Guan wrote:
> Hello,
> Thanks for reply.
> + Cc: stable@vger.kernel.org

I have no context at all here, sorry.  What am I supposed to do?

confused,

greg k-h
