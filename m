Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365262652AF;
	Sun, 21 Dec 2025 09:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766308866; cv=none; b=PrOmQ4+n6oKEWida8DPxFN/G8ZlwfqvAyhZPnyUD1aqiffxAyDl4s9CW6VQMCoLAyrWa2Y2a21gja2luSuh66v79WjYJceyaXcNDbQEH+Iwq69J+B1CtcxBPdlTYiM1knmYwvm/A7kpHY7KN22Llwh87JlewmObF1C+x6fPDSD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766308866; c=relaxed/simple;
	bh=U5D9HwTGKr8BqC8XIc0U5AwJkVqDatO7r35UyhsYNpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fz5R5wcz5vkSJX9ZuObVa7DdmTLTW/gLL5msg7SVDlYgvIdoRgcxogrIqvADGy4G5D9ibEdplRSfxIoIbgV47h3h4zZeZVG1AterxKaUZqLA3Cnu0HdnnG89FbW5iJYGZ210CRycckbAc5tTeEuAHOYqlTy7KkhNDgmXnHaNZGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vdZmQIol; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vdZmQIol"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A8BC4CEFB;
	Sun, 21 Dec 2025 09:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1766308864;
	bh=U5D9HwTGKr8BqC8XIc0U5AwJkVqDatO7r35UyhsYNpk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vdZmQIolXx7CObgpMIwCjlzn467eGlMeiq2Ygiy2B1JP9R1fs3WjQ10oeD3Guioa/
	 AymhtYPZN4jDQg52AV+S6yrVtguy3aPTQQZgMet/xdPpPRTEjA6FmD6qLZdzQi4Pc+
	 JlulhJxcRpnfX77Y1MnvbNT38I32wJ5v450CI77k=
Date: Sun, 21 Dec 2025 10:21:01 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Cosmin Tanislav <demonsingur@gmail.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 1/1] serial: core: Fix serial device initialization
Message-ID: <2025122145-reward-stroller-4fdd@gregkh>
References: <20251219152813.1893982-1-alexander.stein@ew.tq-group.com>
 <2025122151-petition-joylessly-bdc5@gregkh>
 <1ab9287b-bab4-48de-a6fc-88b5f0797e6c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ab9287b-bab4-48de-a6fc-88b5f0797e6c@gmail.com>

On Sun, Dec 21, 2025 at 10:59:52AM +0200, Cosmin Tanislav wrote:
> 
> 
> On 12/21/25 10:40 AM, Greg Kroah-Hartman wrote:
> > On Fri, Dec 19, 2025 at 04:28:12PM +0100, Alexander Stein wrote:
> > > During restoring sysfs fwnode information the information of_node_reused
> > > was dropped. This was previously set by device_set_of_node_from_dev().
> > > Add it back manually
> > > 
> > > Fixes: 24ec03cc5512 ("serial: core: Restore sysfs fwnode information")
> > > Suggested-by: Cosmin Tanislav <demonsingur@gmail.com>
> > > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > > ---
> > >   drivers/tty/serial/serial_base_bus.c | 1 +
> > >   1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/tty/serial/serial_base_bus.c b/drivers/tty/serial/serial_base_bus.c
> > > index 8e891984cdc0d..1e1ad28d83fcf 100644
> > > --- a/drivers/tty/serial/serial_base_bus.c
> > > +++ b/drivers/tty/serial/serial_base_bus.c
> > > @@ -74,6 +74,7 @@ static int serial_base_device_init(struct uart_port *port,
> > >   	dev->parent = parent_dev;
> > >   	dev->bus = &serial_base_bus_type;
> > >   	dev->release = release;
> > > +	dev->of_node_reused = true;
> > >   	device_set_node(dev, fwnode_handle_get(dev_fwnode(parent_dev)));
> > > -- 
> > > 2.43.0
> > > 
> > > 
> > 
> > Can I get some confirmation from people that this resolves the issue, or
> > should I just revert the original problem commit instead and wait for a
> > tested new version?
> > 
> 
> Hi Greg. I confirmed that this fixes the issue before I suggested the
> fix. :D

Great, can you respond with a tested-by?
