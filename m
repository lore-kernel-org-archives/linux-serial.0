Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AA7271A7C
	for <linux-serial@vger.kernel.org>; Sun, 19 Oct 2025 08:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760863812; cv=none; b=lHyaybLeIe7R29/gGssw68jxuM9W52ttII+8PAqY98ko4RnjD/XRcWYt4TddEyIugW5prXilRg+g5OkZLz7f1VL8RJhwByVP3Fa98Gi7QxTUG1kr/rZ2vOnvWLEFZS9zH/dgIwys0ZJF4mWxpIK/0VxFjqakDGQudgOHESY+nYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760863812; c=relaxed/simple;
	bh=RNZaox5u4PRgHkG5zMT/DQgAH60j1yRFkmyQp/GI3gE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wl6FPuPuGc4E3W3Eq5TUOf+V+A3D66Ky1FVjG8Qtryca6f3xbT9jn06RuQowhN4a+5myJEjpkjCeGxYeBzv0C78umb+6bCR0f1bib7VsMacu3AOJWu1s6zw9Of30eMCGU3bWs3uZZVBuFuuVrobnNFVauvEKn2f6lCkWctMg6+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id DDD492C051D6;
	Sun, 19 Oct 2025 10:50:01 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id BAE074A12; Sun, 19 Oct 2025 10:50:01 +0200 (CEST)
Date: Sun, 19 Oct 2025 10:50:01 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, Gerhard Engleder <eg@keba.com>
Subject: Re: [PATCH v2 1/2] serial: Keep rs485 settings for devices without
 firmware node
Message-ID: <aPSmOcbprjf0EoAq@wunner.de>
References: <20251017144209.2662-1-gerhard@engleder-embedded.com>
 <20251017144209.2662-2-gerhard@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017144209.2662-2-gerhard@engleder-embedded.com>

On Fri, Oct 17, 2025 at 04:42:08PM +0200, Gerhard Engleder wrote:
> Commit fe7f0fa43cef ("serial: 8250: Support rs485 devicetree properties")
> retrieves rs485 properties for 8250 drivers. These properties are read
> from the firmware node of the device. If the firmware node does not
> exist, then the rs485 flags are still reset. Thus, 8250 driver cannot
> set rs485 flags to enable a defined rs485 mode during driver loading.
> This is no problem so far, as no 8250 driver sets the rs485 flags.
> 
> If no firmware node exist, then it should be possible for the driver to
> set a reasonable default rs485 mode. Therefore, reset rs485 flags only
> if a firmware node exists.
[...]
> +++ b/drivers/tty/serial/serial_core.c
> @@ -3533,7 +3533,13 @@ int uart_get_rs485_mode(struct uart_port *port)
>  	u32 rs485_delay[2];
>  	int ret;
>  
> -	if (!(port->rs485_supported.flags & SER_RS485_ENABLED))
> +	/*
> +	 * Retrieve properties only if rs485 is supported and if a firmware node
> +	 * exist. If no firmware node exist, then don't touch rs485 config and
> +	 * keep initial rs485 properties set by driver.
> +	 */
> +	if (!(port->rs485_supported.flags & SER_RS485_ENABLED) ||
> +	    !dev_fwnode(dev))
>  		return 0;
>  
>  	ret = device_property_read_u32_array(dev, "rs485-rts-delay",

Hm, this will also skip the call to uart_sanitize_serial_rs485_delays().

I'm wondering if a better approach might be to move the check for
!dev_fwnode(dev) further down, after the invocation of
uart_sanitize_serial_rs485_delays()?

It may be necessary then to change the else-branch for the delays to
"else if (ret != -EINVAL)" because -EINVAL is returned from
device_property_read_u32_array() if there's no fw_node.

If you decide to keep the check at the top of the function, then
style-wise it would seem cleaner to not insert it into the existing
if-condition, but add a separate if-condition.  It doesn't matter
IMO that they both return 0.  The way the patch is now, it creates
a little confusion to which of the two if-conditions the code
comment pertains.

Thanks,

Lukas
