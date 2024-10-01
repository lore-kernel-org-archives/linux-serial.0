Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7321A2BAF1
	for <linux-serial@vger.kernel.org>; Tue,  1 Oct 2024 07:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727768830; cv=none; b=dCFLzEHre9BFp5vk38GBei+wgyzZ6UOjyFaiImwnP9BGyn1rqSSvjmI0xwA2VHtm64Vaa622PJpOyRHZqXae7E89jB96zEDXUfN8JMxxO5e7jUKToj/+502vNeeQP9ckiWGxdgXFSaq25Uws7AE97pHEyR22xmy9f4v1Q/F0eaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727768830; c=relaxed/simple;
	bh=kqqvKQHwGcK5dvxhg4sDEbtgeaTSZPxRLhJEhl+Zghk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iGD5Q9FeQTVOFmX5AjVzqaL+ChFm7XWyIKTOhchBZS9XEqYRPAzUisOt3qWKY+U6Y6t3fN78w0VlDuClR8XfwBe3Du+abo1b9e/BBq9DV3RQcP99gFWiUp8v/o4I7T1N6LWIL2PEq5WQQOTRXzb6eW5mgcsCrMnbcMBe5lf4grc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1svXb6-00022d-R1; Tue, 01 Oct 2024 09:47:04 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mfe@pengutronix.de>)
	id 1svXb6-002pFI-Cu; Tue, 01 Oct 2024 09:47:04 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1svXb6-004u4N-0z;
	Tue, 01 Oct 2024 09:47:04 +0200
Date: Tue, 1 Oct 2024 09:47:04 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rob Herring <robh@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
	Johan Hovold <johan@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 0/3] USB-Serial serdev support
Message-ID: <20241001074704.kb4dus7rdrfc4v5c@pengutronix.de>
References: <20240807-v6-10-topic-usb-serial-serdev-v1-0-ed2cc5da591f@pengutronix.de>
 <20241001072453.3xv5sqxaj4zjprnz@pengutronix.de>
 <2024100109-maker-ravine-7c65@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024100109-maker-ravine-7c65@gregkh>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org

On 24-10-01, Greg Kroah-Hartman wrote:
> On Tue, Oct 01, 2024 at 09:24:53AM +0200, Marco Felsch wrote:
> > Hi,
> > 
> > gentle ping as this is series is two months old now.
> 
> And it was rejected as serdev does not support hotplug which of course,
> usb-serial does.

I just read concerns which I tried to explain/argue but didn't saw it as
rejected.

> So until serdev is fixed up to handle that correctly, this is not going
> anywhere, nor should you want it to as then you would be in charge of
> code that does not work properly :)

Sure as always :)

Regards,
  Marco
