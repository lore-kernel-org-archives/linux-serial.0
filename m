Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A948D33F9
	for <linux-serial@vger.kernel.org>; Sun, 26 Oct 2025 09:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761471039; cv=none; b=Rwhw3ESzZDUXj3zsZ6qAocYZTkNPFKHxRenA0sFPwV11lhtHo2qDkC0qWT1ggkPhFs42hc0aN/8nuHQf/HH8sKw23EM8ba+3b7e8t7fVV4F9BaRW18r0eTG1nWZPd9GuguHjFRImAJFsypbfDUAvO52IyZ4Sz9Wkd5ir+PFf6iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761471039; c=relaxed/simple;
	bh=C4EB1KK67bmcOsaxymIluDeLn4phribqLiwOqunO1EA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cY9LadPhcoPNBAyialhshVxM6FmYmTVCEkXmqPm8z8LP65pfjqcUxp6hVSldODj9dngB6Wf/D+xFJYhlo6tpDV6p+sDZmkj344898xszqXxF4TYx9rM3+3ngf3Vy8LyJy/3H2gyyyhI0d5k/zO6rPDl6y9kpSLSaaSBrvWSAJOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 2BA5220083DF;
	Sun, 26 Oct 2025 10:30:30 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 251214A12; Sun, 26 Oct 2025 10:30:30 +0100 (CET)
Date: Sun, 26 Oct 2025 10:30:30 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, Gerhard Engleder <eg@keba.com>,
	Daniel Gierlinger <gida@keba.com>
Subject: Re: [PATCH v4 2/2] serial: 8250: add driver for KEBA UART
Message-ID: <aP3qNsNDz7p2WSPm@wunner.de>
References: <20251023151229.11774-1-gerhard@engleder-embedded.com>
 <20251023151229.11774-3-gerhard@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023151229.11774-3-gerhard@engleder-embedded.com>

On Thu, Oct 23, 2025 at 05:12:29PM +0200, Gerhard Engleder wrote:
> The KEBA UART is found in the system FPGA of KEBA PLC devices. It is
> mostly 8250 compatible with extension for some UART modes.
> 
> 3 different variants exist. The simpliest variant supports only RS-232
> and is used for debug interfaces. The next variant supports only RS-485
> and is used mostly for communication with KEBA panel devices. The third
> variant is able to support RS-232, RS-485 and RS-422. For this variant
> not only the mode of the UART is configured, also the physics and
> transceivers are switched according to the mode.
> 
> Signed-off-by: Gerhard Engleder <eg@keba.com>
> Tested-by: Daniel Gierlinger <gida@keba.com>

Reviewed-by: Lukas Wunner <lukas@wunner.de>
