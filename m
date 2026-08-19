Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2BC3DA5AE;
	Wed, 19 Aug 2026 07:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787125747; cv=none; b=L9CwTaoyGJq7cG92XeWmcWSTYS9ZCtZFrQbQEvdhJDaJgKrErX62L2RLqpAMkmx7oGk5EaRicOzgxvKuKomBdXV+LjCn/6/bEo1kk9PCT+3h5O6TuOIucvWJqAVS/xXgChcyBNbJyxV4Kfui09FR2LZ0HB1GopHV/bj4UBBRo0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787125747; c=relaxed/simple;
	bh=nxWHSP5PHQL7M+QBFxwaIaIWgbWABQeI02mXZubMEEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oEwR9tLWw8zk6j7S6/n8Y39ETILDBmlZpgV+g4wHf8+UHmXBsDjDJ7CX3CTRlRjcs6b2ZGE4iBEZUptK5DlEqgUXFt0DDpVRNfRg27D5915FOs8Sm/QDYLhr+Q0XE7YEQTwAmdfBqzmRxaaLwl8hGXLqeqTnzcmN4hBSrnqleeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lj8WeGmf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lj8WeGmf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 020941F000E9;
	Wed, 19 Aug 2026 07:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787125746;
	bh=kVD1wleIxlRps+GeowwWMVdoDZQFF7p0sf5QbTFaO2w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lj8WeGmfSwuuHU3wPg9bmGHbAK0rLhQ7ff7ZjiEx5ODU2zgfAmYmGMA29Tu84gj2u
	 8LCHMDFkGp15wV36KxxD+NXppouXpCToAMl4tIMYzTMGIsnOUOMVq/n+ohh30jQDCo
	 JsPAEY+z+1GC1OUT4wJN3Db+pUng1Sb5RlCRz/ko=
Date: Wed, 19 Aug 2026 09:46:48 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Lucas Tanure <tanure@linux.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250: don't register ports that have no hardware
Message-ID: <2026081906-curtsy-widow-028b@gregkh>
References: <20260818185200.10243-1-tanure@linux.com>
 <2026081923-magical-enlisted-64ff@gregkh>
 <ecc5ada8-c878-4123-acd7-64af3219b181@linux.com>
 <2026081908-clamp-safely-de2f@gregkh>
 <47719008-a26d-481c-8b0c-8acf669e987f@linux.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47719008-a26d-481c-8b0c-8acf669e987f@linux.com>

On Wed, Aug 19, 2026 at 08:31:10AM +0100, Lucas Tanure wrote:
> On 19/08/2026 07:49, Greg Kroah-Hartman wrote:
> > On Wed, Aug 19, 2026 at 07:40:17AM +0100, Lucas Tanure wrote:
> > > On 19/08/2026 06:57, Greg Kroah-Hartman wrote:
> > > > On Tue, Aug 18, 2026 at 07:52:00PM +0100, Lucas Tanure wrote:
> > > > > The 8250 driver creates a fixed set of port slots at boot and
> > > > > registers a ttyS device for each one, even when the slot describes no
> > > > > hardware. On device tree platforms those slots are empty, but they
> > > > > still take the ttyS0..ttyS3 names.
> > > > > 
> > > > > New Amlogic SoCs (S4, T7) name their real UARTs ttyS as well. With
> > > > > both drivers built in, as in arm64 defconfig, the real port fails to bind:
> > > > 
> > > > Then fix that bug, don't break everyone else's systems because of it.
> > > > 
> > > Hi,
> > > 
> > > Understood. I thought preventing 8250 from probing on devices that don't use
> > > it would be a good idea, and fix my bug. Thanks for the feedback.
> > > 
> > > I will tak to Amlogic list the ttyS name collision introduced for the new
> > > Amlogic SoCs in e71aab9d6132.
> > 
> > That was an explicit decision by Amlogic to do that, so there should not
> > be any collisions as their systems should NOT be having the older 8250
> > device tree entries.
> > 
> > So perhaps just fix your device tree to not be broken?
> > 
> > thanks,
> > 
> > greg k-h
> Hi,
> 
> There are no 8250 nodes in the Vim4 device tree.
> At __serial8250_isa_init_ports() in 8250_platform.c it creates nr_uarts
> ports unconditionally:
> 
>       for (i = 0; i < nr_uarts; i++)
>               serial8250_setup_port(i);

Then the amlogic driver should not be attempting to use the same device
nodes.  Something is broken somewhere, and I don't think it is in the
30+ year old isa code :)

thanks,

greg k-h
