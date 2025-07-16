Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DBC17B50A;
	Wed, 16 Jul 2025 06:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752649093; cv=none; b=r5tWjHaCA08P3TSnir6X38UZjiMWnIJ1QS65dYLr6AwCmRacDY+raXdBjOk+AiN7wZkiDkcPwFOTEdYxK8oh6JVvUHJANQbxsPSCZU40eEOaaAVq8A6C4bx688TzgKo+JOd+VBtCsalce+wJW6Aient4PhDCIv8mPosU5pWMBtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752649093; c=relaxed/simple;
	bh=dprRUhqdgfAk9X4hFRnI4ZYwibR+dNU2S1xSkcPS0SY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dnYqAwIL/VlFFkqKzPpyJLKS7fw47n3OHPKMjl/L/DqcXLUB/48fLXQI1y8EQ8+LSJYoLffmwtaakMuJn1sxLKK05XzJmMNCeTCw5F8EJCN9rPkXA4BxVFTGpztTdYZHfZ2T2oatfo7TpPdqNXxAFLmyg3Y5eNRgSjZL8YX+gBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lhsbAi6r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lhsbAi6r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF68C4CEF0;
	Wed, 16 Jul 2025 06:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752649093;
	bh=dprRUhqdgfAk9X4hFRnI4ZYwibR+dNU2S1xSkcPS0SY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lhsbAi6rdu9+wyhHrTOmLTo3NA+aBHDo9JhVPhBiNLItVg/MY9fxrRrkmqJWrCEIw
	 15Xfl77zoD/JyAow3UlLS7a9tzZcRB6RwVT1NxESF6Hfqp2q8Sgz1qQJn6YLTcshv8
	 ug2eURrKZ8U73b7I9gyok0AmUldZDgzBv6ZQroU4=
Date: Wed, 16 Jul 2025 08:58:10 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Oliver Neukum <oneukum@suse.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org
Subject: Re: USB cdc-acm driver: break and command
Message-ID: <2025071652-afar-cornhusk-0830@gregkh>
References: <ce54ae11-72bb-4ac7-980b-c1cbc798a209@zytor.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce54ae11-72bb-4ac7-980b-c1cbc798a209@zytor.com>

On Tue, Jul 15, 2025 at 02:00:10PM -0700, H. Peter Anvin wrote:
> Hi,
> 
> I noticed looking at the CDC-ACM driver that it uses the assert/local
> delay/deassert method of sending BREAK.  Given that the CDC model has a
> delay specifier in the command packet, is there any reason not to set
> TTY_DRIVER_HARDWARE_BREAK and sending only one packet?
> 
> I'm also wondering if it would make sense to support the
> SEND_ENCAPSULATED_COMMAND and GET_ENCAPSULATED_RESPONSE commands, presumably
> via an ioctl().  I'm not 100% sure because I'm not sure there aren't
> potential security issues.
> 
> I'm guessing both of these could be of some use to embedded devices that
> emulate a ttyACM serial port.

No idea why this is that way, sorry.  Try making the change and see if
it actually works?

thanks,

greg k-h
