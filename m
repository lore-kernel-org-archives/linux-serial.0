Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD9B16A956
	for <linux-serial@vger.kernel.org>; Sun, 19 Oct 2025 14:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760884966; cv=none; b=KMhhXBW+/TbZ64y3LuQQ+35Hl9pFFBa1MCU95sIhPjQBG/dWqHtW9SDneJLEVEitvmWTbVO9MKk12WaY7m2Ui8SJt+loasWB49CDma/EnhI8BZt3V5wCeuzILx/RDt7Rsx7pQtBNAhDObm/wIW+KFf1ndz5zrJ8RXbdvMkf7qhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760884966; c=relaxed/simple;
	bh=uMH8Vxo/A1cnJjSRjZZHhtHahhWzuqUzIj5T1Ui4KwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rMVRV1x63UA5UIm9dPCOWBSZwbFenMx+CjQbEDQo+vm3Bnx57ZSYsUuJnUwu7ctu3f6hZy+RT98sOmAX9304dmht1VYOFSfQla81getnGUpe3DfuKSR+94GtexSwoYiMVpno2Lhb5+PnQrKKchoSLPuQPzLWViakfHv0q7lBzqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 8241F2C0608A;
	Sun, 19 Oct 2025 16:42:35 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 7C52C4A12; Sun, 19 Oct 2025 16:42:35 +0200 (CEST)
Date: Sun, 19 Oct 2025 16:42:35 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, Gerhard Engleder <eg@keba.com>
Subject: Re: [PATCH v2 1/2] serial: Keep rs485 settings for devices without
 firmware node
Message-ID: <aPT42ykVKxouqUHK@wunner.de>
References: <20251017144209.2662-1-gerhard@engleder-embedded.com>
 <20251017144209.2662-2-gerhard@engleder-embedded.com>
 <aPSmOcbprjf0EoAq@wunner.de>
 <81b924dc-4e95-40af-a52a-48a75e01d7f5@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81b924dc-4e95-40af-a52a-48a75e01d7f5@engleder-embedded.com>

On Sun, Oct 19, 2025 at 04:10:26PM +0200, Gerhard Engleder wrote:
> On 19.10.25 10:50, Lukas Wunner wrote:
> > On Fri, Oct 17, 2025 at 04:42:08PM +0200, Gerhard Engleder wrote:
> > > +++ b/drivers/tty/serial/serial_core.c
> > > @@ -3533,7 +3533,13 @@ int uart_get_rs485_mode(struct uart_port *port)
> > >   	u32 rs485_delay[2];
> > >   	int ret;
> > > -	if (!(port->rs485_supported.flags & SER_RS485_ENABLED))
> > > +	/*
> > > +	 * Retrieve properties only if rs485 is supported and if a firmware node
> > > +	 * exist. If no firmware node exist, then don't touch rs485 config and
> > > +	 * keep initial rs485 properties set by driver.
> > > +	 */
> > > +	if (!(port->rs485_supported.flags & SER_RS485_ENABLED) ||
> > > +	    !dev_fwnode(dev))
> > >   		return 0;
> > >   	ret = device_property_read_u32_array(dev, "rs485-rts-delay",
> > 
> > Hm, this will also skip the call to uart_sanitize_serial_rs485_delays().
> > 
> > I'm wondering if a better approach might be to move the check for
> > !dev_fwnode(dev) further down, after the invocation of
> > uart_sanitize_serial_rs485_delays()?
> 
> Calling uart_sanitize_serial_rs485_delays() would make sense as it helps
> to prevent driver bugs. But on the other hand this check is done within
> a function, which implements a device tree binding. So it is confusing
> that device tree binding code issue warnings for none device tree
> configurations.

This isn't just for devicetree.  E.g. ACPI systems may have these
properties specified in a _DSD object.  It's meant to be a generic
function to retrieve and sanitize rs485 settings.

BTW is there a good reason that you don't have a fwnode for your UART?
It seems odd to have a UART but not describe it in the devicetree.
Maybe that's the real problem and fixing it obviates the need for this
patch?

> > It may be necessary then to change the else-branch for the delays to
> > "else if (ret != -EINVAL)" because -EINVAL is returned from
> > device_property_read_u32_array() if there's no fw_node.
> 
> Yes, that could be done. But is relying on return values future proof?

In general, yes.

> EINVAL for a missing fw_node is not a good fit in my opinion. So this
> may break in the future silently?

I agree it's a poor choice and something like -ENODEV may have been
more appropriate.

Thanks,

Lukas
