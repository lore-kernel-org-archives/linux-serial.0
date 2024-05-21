Received: from dianne.skoll.ca (dianne.skoll.ca [144.217.161.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03EA1E4A2;
	Tue, 21 May 2024 14:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.217.161.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716300938; cv=none; b=MSibRVvcezaFDoYSn3zu/+zbThKcQCLHElsQxY8WS8bIaXaBid9mI+lXHuhr9L2VFwx3FaijBLnMo0PF3+R2/63lg9OVY6U6Xiqif7gRccO+Z7aAa28lgLAkjpBNF1tyvwiQk2ivuXP5NiFwv90xIiQPDMSIawz8F3Tdc6WoV5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716300938; c=relaxed/simple;
	bh=CQY/u8kxhmHJD+6fMC5R8Nze8D98YruqQ6VlBkAoDwE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tjSZdP4VXHcHULn4IHNnmI5VdCu/NNGT+iIs36J9cxmBVS1ZsX5R57vQSXpb7q4XVvVYEDqOBaAvRx7F7dFnwzDcnT2NZ+0yq4YvY0URfrxWep5uTZ2p6C43VSCvELMc4lXYCBc4RIEHbQbSd177jrOnG/3ddbzk0fFgjeyw5bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=skoll.ca; spf=pass smtp.mailfrom=skoll.ca; dkim=pass (2048-bit key) header.d=skoll.ca header.i=@skoll.ca header.b=Ts6GvWNw; arc=none smtp.client-ip=144.217.161.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=skoll.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skoll.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=skoll.ca header.i=@skoll.ca header.b="Ts6GvWNw"
Received: from pi4.skoll.ca ([192.168.84.18])
	by dianne.skoll.ca (8.17.1.9/8.17.1.9/Debian-2) with ESMTPS id 44LEFG18319952
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 21 May 2024 10:15:17 -0400
Received: from gato.skoll.ca (gato.skoll.ca [192.168.83.21])
	by pi4.skoll.ca (Postfix) with ESMTPS id 4VkGfr1Q0mzgd52Y;
	Tue, 21 May 2024 10:15:16 -0400 (EDT)
Date: Tue, 21 May 2024 10:15:14 -0400
From: Dianne Skoll <dianne@skoll.ca>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: N_HDLC line discipline: Race condition
Message-ID: <20240521101435.0b6b3420@gato.skoll.ca>
In-Reply-To: <63a5a3c5-8362-4b93-a50e-10c9cdcffdd2@kernel.org>
References: <20240424173114.035ddd7b@gato.skoll.ca>
	<20240425140127.6504ade1@gato.skoll.ca>
	<63a5a3c5-8362-4b93-a50e-10c9cdcffdd2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=skoll.ca; h=date
	:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=canit2;
	 bh=s2YFZC7GmOEsW+N8EbYEKSMbTn8bmL6bKKFlud97oVQ=; b=Ts6GvWNwzAiq
	DIuDmgOV2oME9wuzHhxo9iWwVqa8zXPl0g7RTZ64gzt6zYCazsA68oIDgGJcgmWS
	VI8yEyijE4zM8A34rHCXNlUrAulJfL+ceIz4pknLua+j37mvii7vIWBp51h9yAT7
	3TYZR4whLHlFzbyz0P9bHItOda0BkJ2Uyiq33apzr0viAzbqJWEFIwvUJ0QqgBtj
	+NGGEEAFw6Dnel99ZFp2etgKGPezpnDrfFnfD/Opjb0Vus3la79CleieHNZPkQZD
	cKXt4rtBemn6P5bQz2gDhfL++Q9B36y4wUzPTNiReuWT/NwWKcuHPKTG7PBkNirR
	zxuIzqnpAA==
X-Scanned-By: CanIt (www . roaringpenguin . com)
X-Scanned-By: mailmunge 3.16 on 192.168.83.18
X-Spam-Score: undef - relay 192.168.84.18 marked with skip_spam_scan
X-CanIt-Geo: No geolocation information available for 192.168.84.18
X-CanItPRO-Stream: outbound (inherits from default)
X-Canit-Stats-ID: Bayes signature not available
X-CanIt-Archive-Cluster: tWKWaF/NcZkqjWIj0BEJTBHJhwY
X-CanIt-Archived-As: base/20240521 / 01cpOfh1S

On Tue, 21 May 2024 12:47:00 +0200
Jiri Slaby <jirislaby@kernel.org> wrote:

> I believe it is a correct behavior after all. As you use pty for 
> testing, the "framing" is lost during the pty-to-pty pass on the
> flush to ldisc path (receive_buf()).

That might be what's happening, but I don't think it matches the documentation
in n_hdlc.c.  If you read the comment block near the top of the file,
it says this:

 * All HDLC data is frame oriented which means:
 *
 * 1. tty write calls represent one complete transmit frame of data
 *    The device driver should accept the complete frame or none of
 *    the frame (busy) in the write method. Each write call should have
 *    a byte count in the range of 2-65535 bytes (2 is min HDLC frame
 *    with 1 addr byte and 1 ctrl byte). The max byte count of 65535
 *    should include any crc bytes required. For example, when using
 *    CCITT CRC32, 4 crc bytes are required, so the maximum size frame
 *    the application may transmit is limited to 65531 bytes. For CCITT
 *    CRC16, the maximum application frame size would be 65533.
 *
 *
 * 2. receive callbacks from the device driver represents
 *    one received frame. The device driver should bypass
 *    the tty flip buffer and call the line discipline receive
 *    callback directly to avoid fragmenting or concatenating
 *    multiple frames into a single receive callback.
 *
 *    The HDLC line discipline queues the receive frames in separate
 *    buffers so complete receive frames can be returned by the
 *    tty read calls.
 *
 * 3. tty read calls returns an entire frame of data or nothing.
[...] */

Point 2 says that the driver should avoid fragmenting frames, or concatenating
frames into a single receive callback.  Doesn't this imply that frame
boundaries should be preserved when you read() data, which happens reliably
when you add a small delay between write()'s?

Regards,

Dianne.
