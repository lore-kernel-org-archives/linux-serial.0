Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118F11E9B17;
	Tue,  7 Jan 2025 10:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736246668; cv=none; b=mdmYhkBo7307lhSWnU6fkeDkRnudPu++C7K87OIPIrVOx12EL2Cdpn4gYel5fI/aAFc8c/N3llBLErZcJ+NYV2jvgedn//TvU59rUwEHMh4QZFi/L+TJOVu0TrsvN4V82rS+JnckNjcxoTFJ0oLw6/svANZ22mHG45MmaoSMWY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736246668; c=relaxed/simple;
	bh=Rjw9HCW5GFtbdTlbhkadOjLDG4FHXUEw26nbdkU71ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VgSe/17/EhU/EleHbEY8/FypQAY1QRQ0vuJV3SbwxGDFf9IHfxoKN/ZYlPxTDiBM6BMLMuzOG5aMhujM6XxL/Qlbt6+CVow4MriMlV1/eYrOxzjOAVRUothbu4HmGuqnBiY8w0WhP1dlg+CdLGFcjg7q6Q2vradV76HmIm184gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tWMTsHrF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tWMTsHrF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C708C4CEE2;
	Tue,  7 Jan 2025 10:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736246667;
	bh=Rjw9HCW5GFtbdTlbhkadOjLDG4FHXUEw26nbdkU71ew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tWMTsHrFmbBusG7bN1vepquHAZh0/EOlu7tngPiPUEvoD9tOHV7/SPDMSwFco66J6
	 jK0CSfKD6ZwSMVVbmNcSWi3sKC+5Opz3MP7v57dtV9qmbsFUtVkhHpZ4NkgFJKLNkH
	 Up2pPMEseQqBwunlgDQpVEwnQDEgdq5xBH3F6O9Y=
Date: Tue, 7 Jan 2025 11:44:24 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
	ansuelsmth@gmail.com, lorenzo@kernel.org
Subject: Re: [PATCH 2/2] serial: Airoha SoC UART and HSUART support
Message-ID: <2025010759-exodus-recast-70ea@gregkh>
References: <20250105131147.2290237-1-benjamin.larsson@genexis.eu>
 <20250105131147.2290237-3-benjamin.larsson@genexis.eu>
 <2025010500-subscript-expectant-144a@gregkh>
 <45f22ec5-76da-4a1d-bdf5-22246dc8f692@genexis.eu>
 <2025010646-nacho-grinning-cd35@gregkh>
 <49278805-b667-40cf-9217-1c51eb80882a@genexis.eu>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49278805-b667-40cf-9217-1c51eb80882a@genexis.eu>

On Mon, Jan 06, 2025 at 01:35:10PM +0100, Benjamin Larsson wrote:
> Hi.
> 
> > > > > diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
> > > > > index 9c007a106330..c71fb338accb 100644
> > > > > --- a/include/uapi/linux/serial_core.h
> > > > > +++ b/include/uapi/linux/serial_core.h
> > > > > @@ -231,6 +231,12 @@
> > > > >    /* Sunplus UART */
> > > > >    #define PORT_SUNPLUS 123
> > > > > 
> > > > > +/* Airoha UART */
> > > > > +#define PORT_AIROHA  124
> > > > > +
> > > > > +/* Airoha HSUART */
> > > > > +#define PORT_AIROHA_HS       125
> > > > 
> > > > Do you REALLY need these port definitions in userspace?  If so, what is
> > > > going to use them there?
> > > > 
> > > 
> > > Testing another PORT define gives this result:
> > > 
> > > grep -ri PORT_MTK_BTIF *
> > > 
> > > drivers/tty/serial/8250/8250_of.c:            .data = (void *)PORT_MTK_BTIF, },
> > > drivers/tty/serial/8250/8250_port.c:  [PORT_MTK_BTIF] = {
> > > include/uapi/linux/serial_core.h:#define PORT_MTK_BTIF        117
> > > 
> > > Per my understanding this is how the current code is designed to work.
> > 
> > That's a very old pattern, I'm asking you if you need this new number in
> > userspace, which is what you are doing here.  I'd prefer not to add new
> > values here as they are a pain to manage and we can never change them if
> > added.
> > 
> 
> I dont need it in userspace. I need it in serial8250_config uart_config[]
> that uses this header.

Then use something internal to the kernel please, and not exported to
userspace where it must never change for the next 50+ years :(

thanks,

greg k-h
