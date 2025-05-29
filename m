Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D3E19E968;
	Thu, 29 May 2025 09:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748509649; cv=none; b=sHkjgn4C5LpYhMyrnbaZuKo67a/UF/y/bZNyDH5XJ3SGKOn4Nid/1hyxg2QMoTjDC8Nkyfquev5KE0XX77h6n1QUnSf37AZ8cJeMO8ElnuBhCSfmCvhEZ/QynxhbZZdedbZqua8h/7khwwPG69aN7uFNlRYkNZ9lnoVDrFhrHzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748509649; c=relaxed/simple;
	bh=OA2B2lq2iE1SHMFUC3X0wRhqzvW5IdLq5T9FRXmrWl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KGMQoJ8mf9Nl6siTd8k0GjGF1ENkTEpNR8zxb8B+owdBcNLusc2gONlUuRwpwBF8RwD2Emwz6LC1TaNFz3t/LLRYAEJxMm9U0uX0YHs0n+PXhcxLUJ7it0nN7rr4brZqENJYeVI7r/oKgjSvxXg062gBHCsJKs4TaNzKNj28csE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C89UAGcE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C89UAGcE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25194C4CEE7;
	Thu, 29 May 2025 09:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748509648;
	bh=OA2B2lq2iE1SHMFUC3X0wRhqzvW5IdLq5T9FRXmrWl8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C89UAGcEN/1d17kRhhFTpVn3kLxukLiaXdKz33551BCdC8Wi3gZ+2iXzUlovBEFCq
	 6W3tfZFMpLjuARvtbvr8Ja+czc1XRa7AlF2Vij5FxRGF+sxO/YdMuaDLKiLDTw/b/3
	 8AgKlr+7v1zLxsEzZ+YMfA1BctH8aI/ONsGXYGEE=
Date: Thu, 29 May 2025 11:07:25 +0200
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
Message-ID: <2025052926-net-economist-a016@gregkh>
References: <20250430111617.1151390-1-quic_cxin@quicinc.com>
 <2025043022-rumbling-guy-26fb@gregkh>
 <d388b471-482b-48ba-a504-694529535362@quicinc.com>
 <2025050851-splatter-thesaurus-f54e@gregkh>
 <38bf94e1-ebed-4d03-8ea0-4040009e8d31@quicinc.com>
 <8e171057-b3c3-4808-b49e-f04ffd310b31@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e171057-b3c3-4808-b49e-f04ffd310b31@quicinc.com>

On Fri, May 23, 2025 at 10:52:27AM +0800, Xin Chen wrote:
> 
> 
> On 5/14/2025 5:14 PM, Xin Chen wrote:
> > 
> > 
> > On 5/8/2025 5:41 PM, Greg Kroah-Hartman wrote:
> >> On Thu, May 08, 2025 at 05:29:18PM +0800, Xin Chen wrote:
> >>>
> >>> On 4/30/2025 7:40 PM, Greg Kroah-Hartman wrote:
> >>>> On Wed, Apr 30, 2025 at 07:16:17PM +0800, Xin Chen wrote:
> >>>>> When ttyport_open() fails to initialize a tty device, serport->tty is not
> >>>>> --- a/drivers/tty/serdev/serdev-ttyport.c
> >>>>> +++ b/drivers/tty/serdev/serdev-ttyport.c
> >>>>> @@ -88,6 +88,10 @@ static void ttyport_write_flush(struct serdev_controller *ctrl)
> >>>>>  {
> >>>>>  	struct serport *serport = serdev_controller_get_drvdata(ctrl);
> >>>>>  	struct tty_struct *tty = serport->tty;
> >>>>> +	if (!tty) {
> >>>>> +		dev_err(&ctrl->dev, "tty is null\n");
> >>>>> +		return;
> >>>>> +	}
> >>>>
> >>>> What prevents tty from going NULL right after you just checked this?
> >>>
> >>> First sorry for reply so late for I have a long statutory holidays.
> >>> Maybe I don't get your point. From my side, there is nothing to prevent it.
> >>> Check here is to avoid code go on if tty is NULL.
> >>
> >> Yes, but the problem is, serport->tty could change to be NULL right
> >> after you check it, so you have not removed the real race that can
> >> happen here.  There is no lock, so by adding this check you are only
> >> reducing the risk of the problem happening, not actually fixing the
> >> issue so that it will never happen.
> >>
> >> Please fix it so that this can never happen.
> >>
> > 
> > Actually I have never thought the race condition issue since the crash I met is
> > not caused by race condition. It's caused due to Bluetooth driver call
> > ttyport_close() after ttyport_open() failed. This two action happen one after
> > another in one thread and it seems impossible to have race condition. And with
> > my fix the crash doesn't happen again in several test of same case.
> > 
> > Let me introduce the complete process for you:
> >   1) hci_dev_open_sync()->
> > hci_dev_init_sync()->hci_dev_setup_sync()->hdev->setup()(hci_uart_setup)->qca_setup(),
> > here in qca_setup(), qca_read_soc_version() fails and goto out, then calls
> > serdev_device_close() to close tty normally. And then call serdev_device_open()
> > to retry.
> >   2) serdev_device_open() fails due to tty_init_dev() fails, then tty gets
> > released, which means this time the tty has been freed succesfully.
> >   3) Return back to upper func  hci_dev_open_sync(),
> > hdev->close()(hci_uart_close) is called. And hci_uart_close calls
> > hci_uart_flush() and serdev_device_close(). serdev_device_close() tries to close
> > tty again, it's calltrace is serdev_device_close()->ttyport_close()->tty_lock(),
> > tty_unlock(), tty_release_struct(). The four funcs hci_uart_flush(), tty_lock(),
> > tty_unlock(), tty_release_struct() read tty pointer's value, which is invalid
> > and causes crash.
> > 
> 
> Hi Greg, could you please take some time to review my reply?

I am not disputing the fact that there is a bug here, I'm just saying
that you can't test for a value and then act on it without a lock
protecting that action because the value can be changed right after you
test for it.

You might not see this in your testing, as you have narrowed the window
that the value can change, but you have not solved the issue properly,
right?

thanks,

greg k-h
