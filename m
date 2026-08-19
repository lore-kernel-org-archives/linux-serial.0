Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B833D3D02;
	Wed, 19 Aug 2026 06:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787122248; cv=none; b=iyWek8Sf7d6JmagCrFWyUIyNQRSzdHj48cNEocadf5oS2baRqR/HGwJbYgG955drw0Z9nfx2LoqzkeIAzoTUIoD0YD4MfOdlzbs1XUPPXUqfN28Fj8ldP69t4xtq5ygh7kGi6qPM5MI5uBcLguGfsxKBGi+J6iHpjUSlyQ5IKCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787122248; c=relaxed/simple;
	bh=wCJr0QpB6IvF4GnKbuYMJe1osDds5VppBMtk0B/5+sI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sFAxhmoOV2JAf+zm0ITlYR/LFQOkmiJNPMHm8XKgV1beXp2dHci80oTAmZUDdx/DzyjzqlajRsqpdIaO1xCekBIsnyB/jN9mvoS3MVRFIGRfQlxjZ9tVk2DumDAjE5PGq89zAzQcDUAyV3/7dEmnNE60N3hAgidvphnb0D12GXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Sf2oXbId; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Sf2oXbId"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33BCF1F000E9;
	Wed, 19 Aug 2026 06:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787122246;
	bh=3bNWEYaNhv7V877Aj9eqEa3Y3/Pbuotgi/PXX0yFyRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Sf2oXbId2ybA56z39i1miswsYKcS8tLGhAvX0bjmq9cJaHVrOZCVFG6NNO1mhJYpa
	 5prgMDQAe0VlcJQwt/Y+GqRo9ujrwKpdqWf+sjYtdHJQVF/Z5PsBp+ej1YMoaA+Sbn
	 KGMrrQBIT0U6oeHLL0qJ5r5fv+f0Kjs+vVcxjVLQ=
Date: Wed, 19 Aug 2026 08:49:09 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Lucas Tanure <tanure@linux.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250: don't register ports that have no hardware
Message-ID: <2026081908-clamp-safely-de2f@gregkh>
References: <20260818185200.10243-1-tanure@linux.com>
 <2026081923-magical-enlisted-64ff@gregkh>
 <ecc5ada8-c878-4123-acd7-64af3219b181@linux.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecc5ada8-c878-4123-acd7-64af3219b181@linux.com>

On Wed, Aug 19, 2026 at 07:40:17AM +0100, Lucas Tanure wrote:
> On 19/08/2026 06:57, Greg Kroah-Hartman wrote:
> > On Tue, Aug 18, 2026 at 07:52:00PM +0100, Lucas Tanure wrote:
> > > The 8250 driver creates a fixed set of port slots at boot and
> > > registers a ttyS device for each one, even when the slot describes no
> > > hardware. On device tree platforms those slots are empty, but they
> > > still take the ttyS0..ttyS3 names.
> > > 
> > > New Amlogic SoCs (S4, T7) name their real UARTs ttyS as well. With
> > > both drivers built in, as in arm64 defconfig, the real port fails to bind:
> > 
> > Then fix that bug, don't break everyone else's systems because of it.
> > 
> Hi,
> 
> Understood. I thought preventing 8250 from probing on devices that don't use
> it would be a good idea, and fix my bug. Thanks for the feedback.
> 
> I will tak to Amlogic list the ttyS name collision introduced for the new
> Amlogic SoCs in e71aab9d6132.

That was an explicit decision by Amlogic to do that, so there should not
be any collisions as their systems should NOT be having the older 8250
device tree entries.

So perhaps just fix your device tree to not be broken?

thanks,

greg k-h
