Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7BD134AB
	for <linux-serial@vger.kernel.org>; Sun, 19 Oct 2025 17:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760894441; cv=none; b=mN8jEx9Wcxe1J7y9e01Lax/lp12bc+6xocx6mN2hg1Y4lcqNf6vYDlueI7nMLxval7n7kpw+LfL1iI1egr1X+nGhE/RAgmEOD+QlyhAVnRSo3bN63r+JW/MYPZk4mv4kkGyPGBbu/b6M8Y718XjAGRGsUwuUDBWFgHlJwA71HIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760894441; c=relaxed/simple;
	bh=AQXxdPFZHgzLc/szEu1lzfwrVWnpPLnH2uokQGudSQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QlucwPC8hwbGl/mvNpuZ8Nmt5/gLI0mK/BavChrS/FhyHsGWC9v1RvyDkVpacQ3ZT08U+iaqogemxSt6e4mXNVQWriBA6kriTasN+aw20HAvwd8lRu+yTmkbd5UPbditnEbZ5MPfh72w8PDE3qXZml1VU+tIK4xqmjLsiFWbJWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 9B255200802B;
	Sun, 19 Oct 2025 19:20:36 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 86A354A12; Sun, 19 Oct 2025 19:20:36 +0200 (CEST)
Date: Sun, 19 Oct 2025 19:20:36 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, Gerhard Engleder <eg@keba.com>
Subject: Re: [PATCH v2 1/2] serial: Keep rs485 settings for devices without
 firmware node
Message-ID: <aPUd5NXmmow77WF7@wunner.de>
References: <20251017144209.2662-1-gerhard@engleder-embedded.com>
 <20251017144209.2662-2-gerhard@engleder-embedded.com>
 <aPSmOcbprjf0EoAq@wunner.de>
 <81b924dc-4e95-40af-a52a-48a75e01d7f5@engleder-embedded.com>
 <aPT42ykVKxouqUHK@wunner.de>
 <4e3da3b9-693e-4d21-901e-14ac4663d340@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e3da3b9-693e-4d21-901e-14ac4663d340@engleder-embedded.com>

On Sun, Oct 19, 2025 at 05:21:30PM +0200, Gerhard Engleder wrote:
> On 19.10.25 16:42, Lukas Wunner wrote:
> > BTW is there a good reason that you don't have a fwnode for your UART?
> > It seems odd to have a UART but not describe it in the devicetree.
> > Maybe that's the real problem and fixing it obviates the need for this
> > patch?
> 
> This auxiliary device is part of a FPGA based PCIe device. It is mostly
> used on x86 but arm64 is also possible in the future. There is no device
> tree or ACPI information available for this device. Think about an x86
> CPU module where you cannot influence the BIOS implementation and device
> tree is not available. IMO having a self describing PCIe device which
> works out of the box is best in this case.

In case you're not aware of it, it's possible to assign a software
fwnode to devices through device_add_software_node().  There is
precedent for its usage among 8250 drivers, see 8250_bcm2835aux.c
and 8250_exar.c.

So that would be an alternative to this patch.  Conceivably, your
FPGA might support different UART types and each might default to
different rs485 settings.  A software node as used by 8250_bcm2835aux.c
would allow you to define those settings through the driver_data.

Thanks,

Lukas
