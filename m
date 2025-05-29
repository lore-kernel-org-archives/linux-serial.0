Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41FE26C385;
	Thu, 29 May 2025 09:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748511683; cv=none; b=o/Ssg2JA8cgnANR7SjJkPHZGseZVhKur9RWjagnzXBfOwB48QjNgYKi3eZLFtm/MuVtb/XZB83Aj/KzkDsnFqDJviXoPy998/aaeJKUb+ChJQzdHJ3fGNkuNMol8mOEKDjdPT7OuYvncRfHU3+rNaGzy+0Rp+l85OLUljHBK7EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748511683; c=relaxed/simple;
	bh=vqz1KKkvB6H1LZFKlZUMTSWgxZ8RSU8LtK7z1Z9LEmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RVsendOMYTbBTdACLKywIvu94Qms4yYNgimCw1fdw8nNkSjJ5EpMoTRfWve/rXUqi0rjQBWmBUKrFjSxHnlM90HAy/hx9N1pRhkwm3GpwS46241Too7ba9qv2EJ5gPbftO/lVpo4PCDwMmRhbDgnKIVhy0dezAX0cT4JgxlpC1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vu9samcg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vu9samcg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0047C4CEE7;
	Thu, 29 May 2025 09:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748511681;
	bh=vqz1KKkvB6H1LZFKlZUMTSWgxZ8RSU8LtK7z1Z9LEmQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vu9samcgBLiopDcLf8NGMLCaUB7wHCjKn23ucLXw+yMIbLWsYQSdt/9HYUrrrUY2d
	 zjnlc0Te0cRHN1Aiq162BcfXXQ9CJbZ4Diym22QA9KXBrO+su2BO55UYaY4TWuId90
	 4U4r1LaTRDLzFSIdThtuolyZT4m8G/cS/1LH9QA8=
Date: Thu, 29 May 2025 11:41:18 +0200
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
Message-ID: <2025052957-jawless-superhero-09be@gregkh>
References: <20250430111617.1151390-1-quic_cxin@quicinc.com>
 <2025043022-rumbling-guy-26fb@gregkh>
 <d388b471-482b-48ba-a504-694529535362@quicinc.com>
 <2025050851-splatter-thesaurus-f54e@gregkh>
 <38bf94e1-ebed-4d03-8ea0-4040009e8d31@quicinc.com>
 <8e171057-b3c3-4808-b49e-f04ffd310b31@quicinc.com>
 <2025052926-net-economist-a016@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025052926-net-economist-a016@gregkh>

On Thu, May 29, 2025 at 11:07:25AM +0200, Greg Kroah-Hartman wrote:
> On Fri, May 23, 2025 at 10:52:27AM +0800, Xin Chen wrote:
> > 
> > 
> > On 5/14/2025 5:14 PM, Xin Chen wrote:
> > > 
> > > 
> > > On 5/8/2025 5:41 PM, Greg Kroah-Hartman wrote:
> > >> On Thu, May 08, 2025 at 05:29:18PM +0800, Xin Chen wrote:
> > >>>
> > >>> On 4/30/2025 7:40 PM, Greg Kroah-Hartman wrote:
> > >>>> On Wed, Apr 30, 2025 at 07:16:17PM +0800, Xin Chen wrote:
> > >>>>> When ttyport_open() fails to initialize a tty device, serport->tty is not
> > >>>>> --- a/drivers/tty/serdev/serdev-ttyport.c
> > >>>>> +++ b/drivers/tty/serdev/serdev-ttyport.c
> > >>>>> @@ -88,6 +88,10 @@ static void ttyport_write_flush(struct serdev_controller *ctrl)
> > >>>>>  {
> > >>>>>  	struct serport *serport = serdev_controller_get_drvdata(ctrl);
> > >>>>>  	struct tty_struct *tty = serport->tty;
> > >>>>> +	if (!tty) {
> > >>>>> +		dev_err(&ctrl->dev, "tty is null\n");
> > >>>>> +		return;
> > >>>>> +	}
> > >>>>
> > >>>> What prevents tty from going NULL right after you just checked this?
> > >>>
> > >>> First sorry for reply so late for I have a long statutory holidays.
> > >>> Maybe I don't get your point. From my side, there is nothing to prevent it.
> > >>> Check here is to avoid code go on if tty is NULL.
> > >>
> > >> Yes, but the problem is, serport->tty could change to be NULL right
> > >> after you check it, so you have not removed the real race that can
> > >> happen here.  There is no lock, so by adding this check you are only
> > >> reducing the risk of the problem happening, not actually fixing the
> > >> issue so that it will never happen.
> > >>
> > >> Please fix it so that this can never happen.
> > >>
> > > 
> > > Actually I have never thought the race condition issue since the crash I met is
> > > not caused by race condition. It's caused due to Bluetooth driver call
> > > ttyport_close() after ttyport_open() failed. This two action happen one after
> > > another in one thread and it seems impossible to have race condition. And with
> > > my fix the crash doesn't happen again in several test of same case.
> > > 
> > > Let me introduce the complete process for you:
> > >   1) hci_dev_open_sync()->
> > > hci_dev_init_sync()->hci_dev_setup_sync()->hdev->setup()(hci_uart_setup)->qca_setup(),
> > > here in qca_setup(), qca_read_soc_version() fails and goto out, then calls
> > > serdev_device_close() to close tty normally. And then call serdev_device_open()
> > > to retry.

Wait, what?  Why is qca_read_soc_version() failing?  Why are you
retrying multiple times until either you run out of attempts?  Why are
you closing the port and then opening it again right away?  What
close/open pair seems totally unnecessary, why do that at all?

If I read that function qca_setup(), it can NEVER detect if a failure
really happened (i.e. if it does run out of retries, you just plow on
and keep going and keep on registering things and THEN return an error
for some reason.

In other words, the error handling in qca_setup() is very suspect, why
not fix all of that up first?

thanks,

greg k-h
