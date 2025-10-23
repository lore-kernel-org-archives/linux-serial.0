Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C96912CDA5
	for <linux-serial@vger.kernel.org>; Thu, 23 Oct 2025 10:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761214672; cv=none; b=R4rS1C5NUccrcLHqBBRFMo1bUAGZM+8ybrCbg0A5YQ7oPqnkY/rQz2XVtqoGVIn9JHsBAO7+EDNNDFuOgcJQ8ZXnHBkF+WhiGmqfc1ARDVg12SrH1MjT0qGRxvll+G4oZh06P+LKu0ubhI2/8F1rD4TWN76yknwIvqph3c5VIYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761214672; c=relaxed/simple;
	bh=c8nVBPl7fxvEs5MUxlQpJE342FLQX1qmiE+Cghmt5co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O6efUSbTfVL8/plSAdtCI1OX92XcBnwPiRKevKUnQfGCmeDpP4mvfyCGTfEGfFbkiog5qiN4md8rIeaMpzyt87yvLFQ3JFm+E3Q+C5U0NjhPpnXWATuCs4POOLRq6umMsoGUMAEmMEusFoFcp0w8qTvRN+2RIAS6iT8Cw0pQuq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 3E7112009D20;
	Thu, 23 Oct 2025 12:17:42 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 385154A12; Thu, 23 Oct 2025 12:17:42 +0200 (CEST)
Date: Thu, 23 Oct 2025 12:17:42 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, Gerhard Engleder <eg@keba.com>
Subject: Re: [PATCH v3 1/2] serial: Keep rs485 settings for devices without
 firmware node
Message-ID: <aPoAxvRijfsG4hIR@wunner.de>
References: <20251020190658.30655-1-gerhard@engleder-embedded.com>
 <20251020190658.30655-2-gerhard@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020190658.30655-2-gerhard@engleder-embedded.com>

On Mon, Oct 20, 2025 at 09:06:57PM +0200, Gerhard Engleder wrote:
> +++ b/drivers/tty/serial/serial_core.c
> @@ -3536,6 +3536,14 @@ int uart_get_rs485_mode(struct uart_port *port)
>  	if (!(port->rs485_supported.flags & SER_RS485_ENABLED))
>  		return 0;
>  
> +	/*
> +	 * Retrieve properties only if a firmware node exist. If no firmware
> +	 * node exist, then don't touch rs485 config and keep initial rs485

s/exist/exists/

Thanks,

Lukas
