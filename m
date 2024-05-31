Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A56115098C;
	Fri, 31 May 2024 10:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717150817; cv=none; b=Q3LHuBCOGUtkkcgZPIh9JSJ3qwGPgMFmTcK28iYGdnoPPCMn4dFlnSLi0Jun+W05H9JaB0AaA2S7aHO+rgRiLS7azFMDRLS8js8B//pDCZewPUXxid3Hhey7uyhlDGGJICddPHfy+EU6K5c08FDUI+ywKvSh4EQH+l1lwNwPROk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717150817; c=relaxed/simple;
	bh=Afg/BlhPvdSwFvJIkGAy0jB6SLKbdIicJ+mDUKhcUZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N1uhegJMQac4PfJZ4mRTymPi8otifvoaDnihCFaVRSiQk3KXwTWDFUBKobLoYzZ7emzgtOyxOdpMCKswHztHtqFRcCpUHCx4ZwOZfugbIm9EzkaWEoT7mxRsntC8USDWr3eDv+mmKqRl3tIcoXA/er2MI7bB3/qphHpGX96sDks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Pbkpsz6+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Pbkpsz6+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A45FC116B1;
	Fri, 31 May 2024 10:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717150816;
	bh=Afg/BlhPvdSwFvJIkGAy0jB6SLKbdIicJ+mDUKhcUZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pbkpsz6+RCa6ou+xQVlEVSG9k91genUwaUZzEHbczs0OubFSPXsT+YPRRtOencDdw
	 SQCtkV6GIOTiabdn7N9aNU9dE0xHbzklbnPiNzkOaOblZWKVVXnaR7jGxwa7EKL7iR
	 Fc49cUza/3xp4R0bs+0AVxMFpB5IAm55b3Uk2Qk0=
Date: Fri, 31 May 2024 12:20:22 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] tty: serial: 8250: Passing attr_group to universal driver
Message-ID: <2024053105-stony-surreal-5e0a@gregkh>
References: <20240530094457.1974-1-crescentcy.hsieh@moxa.com>
 <2024053013-clapping-germless-d50d@gregkh>
 <ZlmRNVONKs3MWnM8@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlmRNVONKs3MWnM8@localhost.localdomain>

On Fri, May 31, 2024 at 04:58:29PM +0800, Crescent CY Hsieh wrote:
> On Thu, May 30, 2024 at 02:45:02PM +0200, Greg Kroah-Hartman wrote:
> > On Thu, May 30, 2024 at 05:44:57PM +0800, CrescentCY Hsieh wrote:
> > > Many low-level drivers in Linux kernel register their serial ports with
> > > the help of universal driver (8250_core, 8250_port).
> > > 
> > > There is an attribute group called `serial8250_dev_attr_group` within
> > > `8250_port.c` to handle the `rx_trig_bytes` attribute:
> > > https://lore.kernel.org/all/20140716011931.31474.68825.stgit@yuno-kbuild.novalocal/
> > > 
> > > However, if a low-level driver has some HW specifications that need to
> > > be set or retrieved using an attr_group, the universal driver
> > > (8250_port) would overwrite the low-level driver's attr_group.
> > > 
> > > This patch allows the low-level driver's attr_group to be passed to the
> > > universal driver (8250_port) and combines the two attr_groups. This
> > > ensures that the corresponding system file will only be created if the
> > > device is registered by such a low-level driver.
> > 
> > Great!  But is this needed now by any in-kernel drivers, or is this only
> > needed by things that are not in our tree?
> > 
> > If in our tree, what driver(s) does this fix up?  If none, then for
> > obvious reasons, we can't take this change.
> 
> Currently, no in-kernel drivers utilize this, but I can add a patch in
> v2 to demonstrate how this patch would work.

It would be a requirement if this is to even be considered, you know
that, why submit this without that?

But step back, why would we want a serial port driver to have the
ability to have different attributes than the normal ones?  What
attribute would it want to have at this layer that would be unique to
the driver that is controlling it?

That is almost never a good idea, it only can cause confusion and
complex userspace issues when a device type can have different types of
attributes just because of something "below" it controlling it.  So in
this case, why not create a proper child device of it's own specific
type  with those unique attributes instead?

> > > diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> > > index 893bc493f662..ddfa8b59e562 100644
> > > --- a/drivers/tty/serial/8250/8250_port.c
> > > +++ b/drivers/tty/serial/8250/8250_port.c
> > > @@ -3135,9 +3135,31 @@ static struct attribute_group serial8250_dev_attr_group = {
> > >  static void register_dev_spec_attr_grp(struct uart_8250_port *up)
> > >  {
> > >  	const struct serial8250_config *conf_type = &uart_config[up->port.type];
> > > +	struct attribute **upp_attrs = NULL;
> > > +	int upp_attrs_num = 0, i;
> > >  
> > > -	if (conf_type->rxtrig_bytes[0])
> > > -		up->port.attr_group = &serial8250_dev_attr_group;
> > > +	up->port.attr_group_allocated = false;
> > > +
> > > +	if (up->port.attr_group) {
> > > +		upp_attrs = up->port.attr_group->attrs;
> > > +
> > > +		while (upp_attrs[upp_attrs_num])
> > > +			upp_attrs_num++;
> > > +
> > > +		up->port.attr_group = kcalloc(1, sizeof(struct attribute_group), GFP_KERNEL);
> > > +		up->port.attr_group->attrs = kcalloc(upp_attrs_num + 2, sizeof(struct attribute *), GFP_KERNEL);
> > > +
> > > +		for (i = 0; i < upp_attrs_num; ++i)
> > > +			up->port.attr_group->attrs[i] = upp_attrs[i];
> > > +
> > > +		if (conf_type->rxtrig_bytes[0])
> > > +			up->port.attr_group->attrs[upp_attrs_num] = &dev_attr_rx_trig_bytes.attr;
> > > +
> > > +		up->port.attr_group_allocated = true;
> > 
> > This feels odd, why is this all dynamically allocated?  You want to add
> > another group to the existing group?
> 
> Yes, this approach aims to add the `attr_group` which declared in the
> low-level driver to the existing one in universal driver (8250_port.c),
> so that it will have the attributes from both low-level and universal
> drivers. This ensures that other device nodes utilizing the universal
> driver will not create the unsupported system file(s).

What files would be "unsupported" here?

I think we need a real example to understand what you are attempting to
do here.  serial ports should usually never have unique sysfs files as
the serial core code should all control them properly and provide the
needed interfaces to the device.  If not, then why not add it to the
generic serial port type so that all can use them?

thanks,

greg k-h
