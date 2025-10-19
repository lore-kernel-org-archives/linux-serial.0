Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34201D5CC9
	for <linux-serial@vger.kernel.org>; Sun, 19 Oct 2025 17:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760893337; cv=none; b=qGKKxdLToBgl9g+WZknHp3FnyhdjOYii8DAQKAhJPvaWJPUl/SVkD56J083mw7DNwVHPdUKXeJJ4+Ft0AZI+DqY87s+FyyyUCBK1ObpDUk80AbN48g9xdUTRLH0d/X0GGc8XNp6y7YPvXBvI5QvcL0U4iX73XP3hbLJQP7fCzc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760893337; c=relaxed/simple;
	bh=1jnwJ5fDN+i5KY8gpF/sM0gfXY3Ov2GneFcSHDCfGuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lFk4lzyyxtzF5nMqgfEMs9eVR/YrGKZaKV+0V9KnLhJzfiwXlYlhujV1Sik8PI6SV0OjPTJpEjrLA+X+72gX3VwCRLWk16ga7uRH/i0mUR/64QwL6lP6jKlMoseIJ4RDU81WM3ACcNda6wbBgNVAEP2zQ/OPH1/1voDPYYnqynM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id CD4CD2C06E33;
	Sun, 19 Oct 2025 19:02:12 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id C76754A12; Sun, 19 Oct 2025 19:02:12 +0200 (CEST)
Date: Sun, 19 Oct 2025 19:02:12 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, Gerhard Engleder <eg@keba.com>
Subject: Re: [PATCH v2 1/2] serial: Keep rs485 settings for devices without
 firmware node
Message-ID: <aPUZlCFq4c3oQC53@wunner.de>
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

It would be good to have that information included in the commit message
to avoid head-scratching by reviewers and leave breadcrumbs for people
who happen upon the commit through git blame etc.

Thanks,

Lukas
