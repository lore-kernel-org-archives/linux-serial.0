Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDC64EB22
	for <linux-serial@vger.kernel.org>; Tue, 28 Nov 2023 10:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yIiTDtjv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC50CC433C8;
	Tue, 28 Nov 2023 10:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701167389;
	bh=KvnGnhC36n+XAsjH7DxvdmdS970RfUH+HPWC+xqH9RU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yIiTDtjvvUBicMwJQgKqugrxLiN1NrAckFvd+ovmfp25PpGLp56rj8B5rixIEv5WV
	 XZL3AQwadhYv0ivkqnsAl8qeruwz4X1LwGQW7VAXcfN3srB7yFccUnSLG5SP5dRwTa
	 nNxpwqEfB3dnIRfmpBr0far2cqDMKdN2wK2i5vQc=
Date: Tue, 28 Nov 2023 10:29:46 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Christina Quast <contact@christina-quast.de>
Cc: linux-serial@vger.kernel.org,
	Daniel Beer <daniel.beer@igorinstitute.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v3 RESEND] hid-ft260: Add serial driver
Message-ID: <2023112831-pacifist-lure-428a@gregkh>
References: <20231122094004.95399-1-contact@christina-quast.de>
 <2023112205-explore-frequency-40a6@gregkh>
 <0fb134f7-f72e-4742-9c2d-c68f83b67975@christina-quast.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fb134f7-f72e-4742-9c2d-c68f83b67975@christina-quast.de>

On Sun, Nov 26, 2023 at 10:53:18AM +0100, Christina Quast wrote:
> Hi Greg!
> 
> Thanks for the comments!
> 
> On 11/22/23 11:15, Greg KH wrote:
> > On Wed, Nov 22, 2023 at 10:40:03AM +0100, Christina Quast wrote:
> > > This commit adds a serial interface /dev/FTx which implements the tty
> > > serial driver ops, so that it is possible to set the baudrate, send
> > > and receive data, etc.
> > Why is this a serial device?  What type of device is it?
> > 
> > And why "FTx"?  Where did that name come from?  That's not a "normal"
> > tty name.
> I meant /dev/ttyFTx. Since it's a hid device providing a serial interface,
> in theory you could also call it /dev/ttySx or /dev/ttyUSBx, but both feel
> wrong. It's an FTDI device, that functions as a USB to UART / I2C Master. Do
> you have a better name in mind?

I thought we had a HID tty device name already, perhaps dig around for
that and tie into that interface?  If not, sure, youcan use ttyFTx, but
it needs to be documented somewhere (and the correct wording here in the
changelog as well.)

thanks,

greg k-h
