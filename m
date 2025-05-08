Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0032641F9;
	Thu,  8 May 2025 09:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746697318; cv=none; b=iDNAKdbXmNw/hiVKxV1g27t8RFs9W9D3vd923G2LcPKkWgl/Wnb4wWYNWbLqLPc4vR+SqPvrVS6MavOXxPXuELVl8GkHcz+ximQQ/Sng/yCeZn6o6J9LYcrZuROpP1ECxS0XFSCdF5JvoMsh9SKIcMZ8Ig4eF+a64VVIiQUR0Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746697318; c=relaxed/simple;
	bh=ceuZ1VhWRsfxTXHgCCPmZYryf3+JoBPIDGf/qsxBzL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q/xXhEeuS77RX6vEbxnbeLLO/o7UFjrc5uaW0MiUMXz1AzgCinAUGbKPlEbngMnYqVDSl9qFUUfbO6aGdOGJbYWq45BKDM164QreYd4/+cta1GFrEGIOVgqOg4nxBl/WmAjexb4bsnpoeJAYi6gD/Ilp8K8kh1cq+KrUvKN/UgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qznzub3i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qznzub3i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A411C4CEE7;
	Thu,  8 May 2025 09:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746697315;
	bh=ceuZ1VhWRsfxTXHgCCPmZYryf3+JoBPIDGf/qsxBzL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qznzub3iG8U1VXlStuHd+0RktYB4oR/piecDIihiFl9ltB+wf1R9qw9QNtg7Wpby+
	 pKQJcNPL0smXpXZHcPDV5SuFr1Lw3CXNeRKSt5/QgtarsWLd42aT1fskd1h6rzX6gs
	 /UpotafiSEB6jMJJj5ec1QTH2iCOth0rV7SxyO+M=
Date: Thu, 8 May 2025 11:41:52 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Xin Chen <quic_cxin@quicinc.com>
Cc: Rob Herring <robh@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	liulzhao@qti.qualcomm.com, quic_chejiang@quicinc.com,
	zaiyongc@qti.qualcomm.com, quic_zijuhu@quicinc.com,
	quic_mohamull@quicinc.com,
	Panicker Harish <quic_pharish@quicinc.com>
Subject: Re: [PATCH v1] tty: serdev: serdev-ttyport: Fix use-after-free in
 ttyport_close() due to uninitialized serport->tty
Message-ID: <2025050851-splatter-thesaurus-f54e@gregkh>
References: <20250430111617.1151390-1-quic_cxin@quicinc.com>
 <2025043022-rumbling-guy-26fb@gregkh>
 <d388b471-482b-48ba-a504-694529535362@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d388b471-482b-48ba-a504-694529535362@quicinc.com>

On Thu, May 08, 2025 at 05:29:18PM +0800, Xin Chen wrote:
> 
> On 4/30/2025 7:40 PM, Greg Kroah-Hartman wrote:
> > On Wed, Apr 30, 2025 at 07:16:17PM +0800, Xin Chen wrote:
> >> When ttyport_open() fails to initialize a tty device, serport->tty is not
> >> --- a/drivers/tty/serdev/serdev-ttyport.c
> >> +++ b/drivers/tty/serdev/serdev-ttyport.c
> >> @@ -88,6 +88,10 @@ static void ttyport_write_flush(struct serdev_controller *ctrl)
> >>  {
> >>  	struct serport *serport = serdev_controller_get_drvdata(ctrl);
> >>  	struct tty_struct *tty = serport->tty;
> >> +	if (!tty) {
> >> +		dev_err(&ctrl->dev, "tty is null\n");
> >> +		return;
> >> +	}
> > 
> > What prevents tty from going NULL right after you just checked this?
> 
> First sorry for reply so late for I have a long statutory holidays.
> Maybe I don't get your point. From my side, there is nothing to prevent it.
> Check here is to avoid code go on if tty is NULL.

Yes, but the problem is, serport->tty could change to be NULL right
after you check it, so you have not removed the real race that can
happen here.  There is no lock, so by adding this check you are only
reducing the risk of the problem happening, not actually fixing the
issue so that it will never happen.

Please fix it so that this can never happen.

thanks,

greg k-h
